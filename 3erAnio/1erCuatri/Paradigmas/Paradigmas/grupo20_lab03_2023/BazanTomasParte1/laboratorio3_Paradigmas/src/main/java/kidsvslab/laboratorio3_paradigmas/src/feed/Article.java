package feed;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import namedEntity.NamedEntity;
import namedEntity.heuristic.Heuristic;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import scala.Tuple2;
import java.util.Iterator;
import java.util.Map;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;


/*Esta clase modela el contenido de un articulo (ie, un item en el caso del rss feed) */

public class Article implements Serializable {
	private String title;
	private String text;
	private Date publicationDate;
	private String link;
	
	private List<NamedEntity> namedEntityList = new ArrayList<NamedEntity>();
	
	
	public Article(String title, String text, Date publicationDate, String link) {
		super();
		this.title = title;
		this.text = text;
		this.publicationDate = publicationDate;
		this.link = link;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Date getPublicationDate() {
		return publicationDate;
	}

	public void setPublicationDate(Date publicationDate) {
		this.publicationDate = publicationDate;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getPageName(){
		return this.getLink().split(".")[1];
	}

	public int getNamedEntitiesLength(){
                return this.namedEntityList.size();
        }

	@Override
	public String toString() {
		return "Article [title=" + title + ", text=" + text + ", publicationDate=" + publicationDate + ", link=" + link
				+ "]";
	}
	
	public NamedEntity getNamedEntity(String canonic_name){

            for (NamedEntity n: namedEntityList){
		if (n.equals(canonic_name)){				
                    return n;
                }
            }
            return null;
	}
        
	public void computeNamedEntities(Heuristic h) {
                // Creo la Configuracion que va a usar mi SparkContext
                SparkConf conf = new SparkConf().setAppName("CountNameEntityes").setMaster("local");
                // Creo el contexto
                JavaSparkContext sc = new JavaSparkContext(conf);
                
		// Create a JavaRDD of words from the title and text.
                JavaRDD<String> words = sc.parallelize(Arrays.asList((this.getTitle() + " " + this.getText()).split(" ")));

                // Remove punctuation characters from the words.
                JavaRDD<String> filteredWords = words.map(word -> {
                String charsToRemove = ".,;:()'!?\n";
                
                for (char c : charsToRemove.toCharArray()) {
                    word = word.replace(String.valueOf(c), "");
                }
                    return word;
                });
                
                // Filter the words that are entities according to the heuristic.
                JavaRDD<String> entities = filteredWords.filter(word -> h.isEntity(word));
                
                // Count the number of occurrences of each word
                JavaPairRDD<String, Integer> counts = entities.mapToPair(word -> new Tuple2<>(word, 1)).reduceByKey((x,y) -> x + y);
                
                // Convert to dictionary
                Map<String, Integer> countsMap = counts.collectAsMap();
                
                for (Map.Entry<String, Integer> entry : countsMap.entrySet()){
                    NamedEntity ne = this.getNamedEntity(entry.getKey());
                    if (null == ne){
                        this.namedEntityList.add(h.getCategory(entry.getKey()));
                        this.namedEntityList.get(namedEntityList.size()-1).setFrequency(entry.getValue());
                    } else {
                        ne.setFrequency(0);
                    }
                }
                sc.stop();
	}

	
	public void prettyPrint() {
		System.out.println("**********************************************************************************************");
		System.out.println("Title: " + this.getTitle());
		System.out.println("Publication Date: " + this.getPublicationDate());
		System.out.println("Link: " + this.getLink());
		System.out.println("Text: " + this.getText());
        System.out.println("TotalNamedEntities:" + this.getNamedEntitiesLength());
        for (NamedEntity entity : this.namedEntityList){entity.prettyPrint();}
		System.out.println("**********************************************************************************************");
		
	}
	
	public static void main(String[] args) {
		  Article a = new Article("This Historically Black University Created Its Own Tech Intern Pipeline",
			  "A new program at Bowie State connects computing students directly with companies, bypassing an often harsh Silicon Valley vetting process",
			  new Date(),
			  "https://www.nytimes.com/2023/04/05/technology/bowie-hbcu-tech-intern-pipeline.html"
			  );
		 
		  a.prettyPrint();
	}
	
	
}



