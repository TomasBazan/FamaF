package kidsvslab.grupo20_lab04_2023.src;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Scanner;
import java.util.Set;
import java.util.TreeMap;

import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.sql.SparkSession;

import kidsvslab.grupo20_lab04_2023.src.feed.Feed;
import kidsvslab.grupo20_lab04_2023.src.httpRequest.httpRequester;
import kidsvslab.grupo20_lab04_2023.src.namedEntity.entities.NamedEntity;
import kidsvslab.grupo20_lab04_2023.src.namedEntity.heuristic.Heuristic;
import kidsvslab.grupo20_lab04_2023.src.namedEntity.heuristic.QuickHeuristic;
import kidsvslab.grupo20_lab04_2023.src.namedEntity.heuristic.RandomHeuristic;
import kidsvslab.grupo20_lab04_2023.src.parser.RssParser;
import kidsvslab.grupo20_lab04_2023.src.parser.SubscriptionParser;
import kidsvslab.grupo20_lab04_2023.src.subscription.SingleSubscription;
import scala.Tuple2;

class ArticleTuple implements Serializable {
    private Article article;
    private Integer frequency;

    public ArticleTuple(Article article, Integer frequency) {
        this.article = article;
        this.frequency = frequency;
    }

    public Article getArticle() {
        return article;
    }

    public Integer getFrequency() {
        return frequency;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;
        ArticleTuple that = (ArticleTuple) o;
        return Objects.equals(article.getTitle(), that.article.getTitle());
    }

    @Override
    public int hashCode() {
        return Objects.hash(article.getTitle());
    }
}

public class FeedReaderMain {
    private static void printHelp() {
        System.out.println("Please, call this program in correct way: FeedReader [-ne]");
    }

    private static void getFeeds(Heuristic heuristic) {
        /*
         * Leer el archivo de suscription por defecto;
         * Llamar al httpRequester para obtenr el feed del servidor
         * Llamar al Parser especifico para extrar los datos necesarios por la
         * aplicacion
         * Llamar al constructor de Feed
         * Llamar a la heuristica para que compute las entidades nombradas de cada
         * articulos del feed
         * LLamar al prettyPrint de la tabla de entidades nombradas del feed.
         */
        String filepath = "./src/main/java/kidsvslab/grupo20_lab04_2023/config/subscriptions.json";
        SubscriptionParser subsParser = new SubscriptionParser();
        try {
            Subscription response = subsParser.handleParseSuscription(filepath);
            response.prettyPrint();
            List<String> xmlList = new ArrayList<>();
            for (int i = 0; i < response.getSubscriptionsList().size() - 1; i++) {
                SingleSubscription sub = response.getSubscriptionsList().get(i);
                String url = sub.getUrl();
                for (int j = 0; j < sub.getUlrParamsSize(); j++) {
                    httpRequester requester = new httpRequester();
                    String xml = requester.getFeedRss(url.replace("%s", sub.getUlrParams(j)));
                    xmlList.add(xml);
                }
            }

            SparkSession spark = SparkSession.builder().appName("RssParserApp").config("spark.master", "local[4]")
                    .getOrCreate();
            JavaSparkContext jsc = new JavaSparkContext(spark.sparkContext());
            List<Article> artList = new ArrayList<>();
            jsc.parallelize(xmlList)
                    .map(xml -> {
                        RssParser rssParser = new RssParser();
                        Feed feed = rssParser.handleParse(xml);
                        return feed.getArticleList();
                    })
                    .collect().forEach(articleList -> {
                        for (Article article : articleList) {
                            article.computeNamedEntities(heuristic);
                            artList.add(article);
                        }
                    });

            // Iterate over the articles in artList

            for (Article article : artList) {
                List<NamedEntity> neList = article.getNamedEntities();
                System.out.println("article: " + article.getTitle());
                System.out.println("article: " + article.getLink());

                for (NamedEntity ne : neList) {
                    if (ne.getCanonicName() != "Unknown") {
                        System.out.println("Entity: " + ne.getCanonicName());
                        System.out.println(ne.getFrequency());
                    }
                }
            }

            Scanner scanner = new Scanner(System.in);
            while (true) {
                System.out.println("Ingrese la palabra que quiere buscar: ");
                String word = scanner.nextLine();
                // Create an RDD from the list of articles

                SparkSession sparkSearcher = SparkSession.builder().appName("Searcher")
                        .config("spark.master", "local").getOrCreate();
                JavaSparkContext articleRDD = new JavaSparkContext(sparkSearcher.sparkContext());

                // Create an inverted index

                JavaPairRDD<String, Iterable<Tuple2<Article, Integer>>> aList = articleRDD
                        .parallelize(artList)
                        .flatMapToPair(article -> {
                            // get all the named entities of each article.
                            Set<NamedEntity> uniqueTerms = new HashSet<>(article.getNamedEntities());
                            List<Tuple2<String, Tuple2<Article, Integer>>> tuples = new ArrayList<>();
                            // Create a tuple associating the values with their articles and frequency
                            for (NamedEntity term : uniqueTerms) {
                                int frequency = term.getFrequency();
                                Tuple2<Article, Integer> tuple = new Tuple2<>(article, frequency);
                                tuples.add(new Tuple2<>(term.getString(), tuple));
                            }
                            return tuples.iterator();
                        })
                        .groupByKey();

                Map<String, Set<ArticleTuple>> aMap = aList
                        .mapValues(iterable -> {
                            Set<ArticleTuple> uniqueTuples = new HashSet<>();
                            for (Tuple2<Article, Integer> tuple : iterable) {
                                ArticleTuple articleTuple = new ArticleTuple(tuple._1(), tuple._2());
                                uniqueTuples.add(articleTuple);
                            }
                            return uniqueTuples;
                        }).collectAsMap();

                // Sort the map by keys
                Map<String, Set<ArticleTuple>> sortedMap = new TreeMap<>(aMap);

                // Sort the ArticleTuple set within each key entry by frequency in descending
                // order
                // Después de ordenar la lista, se reemplaza el conjunto de ArticleTuple
                // asociado a la clave en el mapa sortedMap con un nuevo conjunto LinkedHashSet
                // que contiene los elementos de la lista sortedTuples. Utilizar LinkedHashSet
                // preserva el orden de inserción de los elementos y garantiza la eliminación de
                // duplicados, en caso de que existan.
                sortedMap.forEach((key, tuples) -> {
                    List<ArticleTuple> sortedTuples = new ArrayList<>(tuples);
                    sortedTuples.sort(Comparator.comparing(ArticleTuple::getFrequency).reversed());
                    sortedMap.put(key, new LinkedHashSet<>(sortedTuples));
                });
                boolean word_found = false;

                for (Map.Entry<String, Set<ArticleTuple>> entry : sortedMap.entrySet()) {
                    int counter_frecuencies = 0;
                    String key = entry.getKey();
                    Set<ArticleTuple> tuples = entry.getValue();
                    if (key.equals(word)) {
                        word_found = true;
                        System.out.println("\n---------------------\nKey: " + key);
                        for (ArticleTuple tuple : tuples) {
                            Article article = tuple.getArticle();
                            Integer frequency = tuple.getFrequency();
                            if (frequency != 0) {
                                counter_frecuencies += frequency;
                                System.out.println("En \"" + article.getTitle() + "\" Frecuencia: " + frequency);
                            } else {
                                System.out.println("\n\nERROR");
                            }
                        }
                        System.out.println("Frecuencia Total: " + counter_frecuencies);
                        System.out.println("----------------------------------");
                    }
                }
                if (!word_found) {
                    System.out.println("La palabra no ha sido encontrada... :(");
                }
                spark.stop();
            }
        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        System.out.println("************* FeedReader version 1.0 *************");
        // Get user input to check the wrod we want to search
        switch (args.length) {
            case 0: {
                QuickHeuristic h = new QuickHeuristic();
                getFeeds(h);
                break;
            }
            case 1: {
                RandomHeuristic h = new RandomHeuristic();
                getFeeds(h);
                break;
            }
            default:
                printHelp();
                break;
        }
    }
}
