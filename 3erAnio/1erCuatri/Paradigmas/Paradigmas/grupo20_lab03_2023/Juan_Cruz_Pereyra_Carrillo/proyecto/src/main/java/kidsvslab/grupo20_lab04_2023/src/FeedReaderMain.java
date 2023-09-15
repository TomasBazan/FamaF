package kidsvslab.grupo20_lab04_2023.src;

import feed.Feed;
import feed.Article;
import httprequest.httpRequester;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import parser.RssParser;
import parser.SubscriptionParser;
import subscription.SingleSubscription;
import subscription.Subscription;
import namedEntity.heuristic.QuickHeuristic;
import namedEntity.heuristic.Heuristic;
import namedEntity.heuristic.RandomHeuristic;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.api.java.JavaSparkContext;

public class FeedReaderMain {
	private static void printHelp(){
		System.out.println("Please, call this program in correct way: FeedReader [-ne]");
	}
	

	private static void getFeeds(Heuristic heuristic){
        /*
            Leer el archivo de suscription por defecto;
            Llamar al httpRequester para obtenr el feed del servidor
            Llamar al Parser especifico para extrar los datos necesarios por la aplicacion
            Llamar al constructor de Feed
            Llamar a la heuristica para que compute las entidades nombradas de cada articulos del feed  
            LLamar al prettyPrint de la tabla de entidades nombradas del feed.
        */
            String filepath = "./src/main/java/kidsvslab/grupo20_lab04_2023/config/subscriptions.json";
            SubscriptionParser subsParser = new SubscriptionParser();
            try {
                Subscription response = subsParser.handleParseSuscription(filepath);
                response.prettyPrint();
                List<String> xmlList = new ArrayList<>();
                for (int i = 0; i < response.getSubscriptionsList().size()-1; i++) {
                    SingleSubscription sub = response.getSubscriptionsList().get(i);
                    String url = sub.getUrl();
                    for (int j = 0; j < sub.getUlrParamsSize(); j++) {
                        httpRequester requester = new httpRequester();
                        String xml = requester.getFeedRss(url.replace("%s", sub.getUlrParams(j)));
                        xmlList.add(xml);
                    }
                }


                SparkSession spark = SparkSession.builder().appName("RssParserApp").config("spark.master", "local[4]").getOrCreate();
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
                
                

                SparkSession sparkPrinter = SparkSession.builder().appName("PrettyPrinter").config("spark.master", "local[4]").getOrCreate();
                JavaSparkContext printerContext = new JavaSparkContext(sparkPrinter.sparkContext());
                String result = printerContext.parallelize(artList)
                    .map(Article::toString)
                    .reduce((a, b) -> a + b);
                
                System.out.println(result);
                spark.stop();
            } catch (IOException e) {
                System.out.println("Error: " + e.getMessage());
            }
        }


	public static void main(String[] args) {
            System.out.println("************* FeedReader version 1.0 *************");
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
