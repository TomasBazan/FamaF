package feed;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import namedEntity.NamedEntity;
import namedEntity.heuristic.Heuristic;
import org.apache.spark.api.java.JavaSparkContext;
import java.util.Arrays;
import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.sql.SparkSession;

import com.google.crypto.tink.Key;

import scala.Tuple2;

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

	public String getPageName() {
		return this.getLink().split(".")[1];
	}

	public int getNamedEntitiesLength() {
		return this.namedEntityList.size();
	}

	@Override
	public String toString() {
		String st = "\nArticle [title=" + title + "\n text=" + text + "\n publicationDate=" + publicationDate
				+ "\n link=" + link
				+ "\nTotalNamedEntities:" + this.getNamedEntitiesLength();

		for (NamedEntity entity : this.namedEntityList) {
			st += "\n" + entity.toString();
		}
		return st + "]\n";
	}

	public NamedEntity getNamedEntity(String canonic_name) {
		for (NamedEntity n : namedEntityList) {
			if (n.equals(canonic_name)) {
				return n;
			}
		}
		return null;
	}

	public List<NamedEntity> getNamedEntities() {
		return namedEntityList;
	}

	public void computeNamedEntities(Heuristic h) {
		String textNotice = this.getTitle() + " " + this.getText();

		// Create a SparkContext
		SparkSession spark = SparkSession.builder().appName("ComputingEntities").config("spark.master", "local[4]")
				.getOrCreate();
		JavaSparkContext sc = new JavaSparkContext(spark.sparkContext());

		// SparkConf conf = new
		// SparkConf().setAppName("ComputingEntities").setMaster("local[4]");
		// JavaSparkContext sc = new JavaSparkContext(conf);

		// Convert the input string into an RDD
		JavaRDD<String> textRDD = sc.parallelize(Arrays.asList(textNotice));

		// Perform data transformations: split lines into words and remove characters
		JavaRDD<String> words = textRDD
				.flatMap(line -> Arrays.asList(line.split(" ")).iterator())
				.map(word -> removeCharacters(word));

		// Filter words that meet the predicate
		JavaRDD<String> filteredWords = words.filter(word -> h.isEntity(word));

		// Map and Reduce: count occurrences of each word
		JavaPairRDD<String, Integer> wordCounts = filteredWords
				.mapToPair(word -> new Tuple2<>(word, 1))
				.reduceByKey((a, b) -> a + b);

		// Convert the wordCounts RDD into a Map
		Map<String, Integer> wordCountsMap = wordCounts.collectAsMap();

		// Access and manipulate the word counts using the dictionary-like structure
		for (Map.Entry<String, Integer> entry : wordCountsMap.entrySet()) {
			NamedEntity ne = this.getNamedEntity(entry.getKey());
			if (null == ne) {
				this.namedEntityList.add(h.getCategory(entry.getKey()));
				this.namedEntityList.get(namedEntityList.size() - 1).setFrequency(entry.getValue());
				// System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
				// System.out.println(entry.getKey()+ " " + entry.getValue());

			} else {
				ne.setFrequency(entry.getValue());
				System.out.println(ne.getCanonicName() + "" + ne.getFrequency());

			}
			ne = this.getNamedEntity(entry.getKey());
		}

		// Stop the SparkContext
		// sc.stop();

	}

	public static String removeCharacters(String word) {
		String charsToRemove = ".,;:()'!?\\n";
		for (char c : charsToRemove.toCharArray()) {
			word = word.replace(String.valueOf(c), "");
		}
		return word;
	}

	public void prettyPrint() {
		System.out.println(
				"**********************************************************************************************");
		System.out.println("Title: " + this.getTitle());
		System.out.println("Publication Date: " + this.getPublicationDate());
		System.out.println("Link: " + this.getLink());
		System.out.println("Text: " + this.getText());
		System.out.println("TotalNamedEntities:" + this.getNamedEntitiesLength());
		for (NamedEntity entity : this.namedEntityList) {
			entity.prettyPrint();
		}
		System.out.println(
				"**********************************************************************************************");

	}

	public static void main(String[] args) {
		Article a = new Article("This Historically Black University Created Its Own Tech Intern Pipeline",
				"A new program at Bowie State connects computing students directly with companies, bypassing an often harsh Silicon Valley vetting process",
				new Date(),
				"https://www.nytimes.com/2023/04/05/technology/bowie-hbcu-tech-intern-pipeline.html");

		a.prettyPrint();
	}

}
