package feed;

import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.JavaPairRDD;

import java.util.Arrays;
import java.util.Map;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import namedEntity.NamedEntity;
import namedEntity.heuristic.Heuristic;
import org.apache.spark.SparkConf;
import scala.Tuple2;

/*Esta clase modela el contenido de un articulo (ie, un item en el caso del rss feed) */

public class Article {
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
		return "Article [title=" + title + ", text=" + text + ", publicationDate=" + publicationDate + ", link=" + link
				+ "]";
	}

	public NamedEntity getNamedEntity(String canonic_name) {
		for (NamedEntity n : namedEntityList) {
			if (n.equals(canonic_name)) {
				return n;
			}
		}
		return null;
	}

	public void computeNamedEntities(Heuristic h) {
		String textNotice = this.getTitle() + " " + this.getText();
                
                
                //este texto es el que mencione en el informe que utilize para testear lo dejo para mostrar el como lo testeaba :)
                //String textNotice = "Title: Elon Musk: Shaping the Future of Technology in the US Through Tesla's Innovation\n" +
                //"\n" +
                //"Introduction:\n" +
                //"In the realm of technology and innovation, few names carry as much weight as Elon Musk. With his visionary leadership and relentless pursuit of cutting-edge solutions, Musk has become an icon in the tech industry. As the CEO of Tesla, his influence extends not only across the United States but also globally. In this article, we delve into Musk's impact on the US technology landscape through the remarkable achievements of Tesla.\n" +
                //"\n" +
                //"Tesla's Electric Revolution:\n" +
                //"When discussing Elon Musk's contributions to the technology sector, Tesla inevitably takes center stage. Founded in 2003, Tesla has revolutionized the automotive industry by spearheading the development and mass adoption of electric vehicles (EVs). Musk's unwavering commitment to sustainable transportation has placed Tesla at the forefront of the EV revolution.\n" +
                //"\n" +
                //"Pioneering Autopilot Technology:\n" +
                //"Tesla's technological prowess goes beyond electric cars, with their advanced Autopilot feature making waves in the autonomous driving space. Through relentless research and development efforts, Musk and his team have harnessed artificial intelligence and machine learning to create a cutting-edge self-driving system. By leveraging real-time data and sensors, Tesla's Autopilot technology has laid the foundation for a future where human drivers become optional.\n" +
                //"\n" +
                //"Gigafactories and Battery Innovation:\n" +
                //"Musk's vision for Tesla extends beyond the vehicles themselves. He recognized the need for a robust infrastructure to support the mass production of EVs. Enter the Gigafactories—state-of-the-art manufacturing facilities designed to produce batteries, powertrains, and other key components at an unprecedented scale. Tesla's Gigafactories have not only propelled the company's growth but have also revitalized local economies across the United States.\n" +
                //"\n" +
                //"Pushing the Boundaries: SpaceX and Starlink:\n" +
                //"While Tesla remains the cornerstone of Elon Musk's technological empire, his influence extends to other ambitious ventures. SpaceX, Musk's aerospace company, has revolutionized space exploration by developing reusable rockets, drastically reducing the cost of reaching orbit. Additionally, through Starlink, Musk aims to provide global broadband internet coverage, connecting underserved communities and bridging the digital divide.\n" +
                //"\n" +
                //"Inspiring Innovation Ecosystems:\n" +
                //"Elon Musk's impact on the US technology landscape is not limited to Tesla and SpaceX. His bold and entrepreneurial spirit has inspired countless innovators and entrepreneurs to pursue groundbreaking ideas. Musk's unwavering belief in the power of technology to solve pressing global challenges has sparked a new wave of innovation, with startups and established companies alike striving to make a positive impact on the world.\n" +
                //"\n" +
                //"Conclusion:\n" +
                //"Elon Musk's influence on the US technology landscape is undeniable. Through his leadership at Tesla and other ventures, he has reshaped the automotive, aerospace, and energy sectors, leaving an indelible mark on the future of technology. From pioneering electric vehicles and advancing autonomous driving to revolutionizing space exploration and inspiring the next generation of innovators, Musk's vision continues to push boundaries and drive progress. As the US technology ecosystem evolves, Elon Musk's name will undoubtedly remain at the forefront, synonymous with innovation, disruption, and the limitless possibilities of human ingenuity.";
		
/////////////// sparkkk//////////////////////////
		// Create a SparkContext
		SparkConf conf = new SparkConf().setAppName("ComputingEntities").setMaster("local[4]");
		JavaSparkContext sc = new JavaSparkContext(conf);

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
			String word = entry.getKey();
			Integer count = entry.getValue();
                        
			NamedEntity ne = this.getNamedEntity(word);
                        
                        if (ne == null) {               
                                this.namedEntityList.add(h.getCategory(word, count));
			}
                        
		}

		// Stop the SparkContext
		sc.stop();

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
