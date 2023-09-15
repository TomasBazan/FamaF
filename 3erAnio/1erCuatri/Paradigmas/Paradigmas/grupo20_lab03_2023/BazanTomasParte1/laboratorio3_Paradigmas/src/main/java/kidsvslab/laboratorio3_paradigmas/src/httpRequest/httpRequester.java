package httprequest;
import java.io.*;
import java.net.*;

/* Esta clase se encarga de realizar efectivamente el pedido de feed al servidor de noticias
 * Leer sobre como hacer una http request en java
 * https://www.baeldung.com/java-http-request
 * java.net package
 * */

public class httpRequester {

	public String getFeedRss(String urlFeed){
		String feedRssXml = null;
		int codeResponseRequest;
		//HttpsURLConnection para https

		//String erlFeed= "http://www.abc.es/rss/feeds/abc_ultima.xml";
		try{
			URL url = new URL(urlFeed);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			codeResponseRequest = con.getResponseCode();
			// de 200 a 299 son respuestas satisfactorias
			if ( codeResponseRequest >= 200 && codeResponseRequest < 300){
				/*
				*  obtengo el xml con getInputStream. StringBuilder crea una secuencia de caracteres
				* mutables, con este objeto agrego las lineas del xml.BufferedReader
				* se usa para leer caracteres de un stream
				* */
				InputStream in = con.getInputStream();
				StringBuilder responseFeed = new StringBuilder();
				BufferedReader reader = new BufferedReader(new InputStreamReader(in));
				String line;
				while((line= reader.readLine()) != null){
					responseFeed.append(line);
				}
				reader.close();
				feedRssXml = responseFeed.toString();
			}
			else {
				System.out.println("Error en la respuesta del servidor: " + codeResponseRequest);
			}
//			feedRssXml = con.getInputStream();
		}
		catch (MalformedURLException e){
			System.out.println("Error en URL: " + e.getMessage());
		}
		catch (IOException e){
			System.out.println("Error en IO: " + e.getMessage());
		}
		System.out.println(feedRssXml);
		return feedRssXml;
	}

	public String getFeedReedit(String urlFeed) {
		String feedReeditJson = null;
		return feedReeditJson;
	}

}
