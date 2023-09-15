package parser;

import org.w3c.dom.*;
import javax.xml.parsers.*;
import java.io.*;
import feed.Feed;
import feed.Article;
import java.text.ParseException;
import java.util.Date;
import org.xml.sax.InputSource;

/* Esta clase implementa el parser de feed de tipo rss (xml)
 * https://www.tutorialspoint.com/java_xml/java_dom_parse_document.htm 
 * */

public class  RssParser extends GeneralParser {

    public static Document parseXML(String xml) throws Exception {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder db = dbf.newDocumentBuilder();
        return db.parse(new InputSource(new StringReader(xml)));
      }

      //the function takes in a tag name as a parameter, retrieves the first node with that tag name, gets the value of its first child node, and returns that value as a string.

    public static String getTagValue(Element element, String tagName) {
        NodeList nodeList = element.getElementsByTagName(tagName).item(0).getChildNodes();
        Node node = nodeList.item(0);
        return node.getNodeValue();
    }

    // This function takes in the tag name as a parameter and returns a list of string values corresponding to all child nodes with that tag name in the parsed XML document
    public static Feed readTagValues(Document doc) throws ParseException {
        NodeList nodeList = doc.getElementsByTagName("item");
        Feed f = new Feed(null);
        for (int temp = 0; temp < nodeList.getLength(); temp++) {
            Article article = new Article(null, null, null, null);
            Node node = nodeList.item(temp);
            try {
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) node;
                    article.setTitle(getTagValue(eElement, "title"));
                    article.setText(getTagValue(eElement, "description"));
                    article.setPublicationDate(formatDate(getTagValue(eElement, "pubDate")));
                    article.setLink(getTagValue(eElement, "link"));
                }
                f.addArticle(article);
            } catch(Exception e){
                System.out.println(e);
                continue;
            }
        }
        return f;

    }

    public Feed handleParse(String s) throws IOException{
        // Obtenemos el xml
        try {
            Document doc = parseXML(s);
            
            return readTagValues(doc);
        } catch (Exception e){
            System.out.println(e);
        }
        return null;
    }
}
