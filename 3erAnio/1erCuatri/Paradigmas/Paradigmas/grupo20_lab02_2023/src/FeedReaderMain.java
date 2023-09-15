package kidsvslab.laboratorio_java;

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
            String filepath = "./src/main/java/kidsvslab/laboratorio_java/grupo20_lab02_2023/config/subscriptions.json";
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
            
                RssParser rssParser = new RssParser();
                for (int i = 0; i < xmlList.size(); i++) {
                    Feed feed = rssParser.handleParse(xmlList.get(i));
                    for (int j=0; j < feed.getNumberOfArticles(); j++){
                        Article article = feed.getArticle(j);
                        article.computeNamedEntities(heuristic);
                        article.prettyPrint();
                    }
                }
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
