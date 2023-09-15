package namedEntity.heuristic;

import java.util.List;
import java.util.Map;
import static java.util.Map.entry;
import namedEntity.NamedEntity;
import namedEntity.Organizacion.OrganizacionBase;
import namedEntity.Organizacion.OrganizacionTech;
import namedEntity.Organizacion.OrganizacionPolitic;
import namedEntity.Lugar.Ciudad;
import namedEntity.Lugar.Pais;
import namedEntity.Lugar.LugarBase;
import namedEntity.Person;
import namedEntity.Apellido.ApellidoTech;
import namedEntity.Apellido.ApellidoBase;
import namedEntity.Apellido.ApellidoPolitico;
import namedEntity.Nombre.NombreBase;
import namedEntity.Nombre.NombreTech;
import namedEntity.Titulo.TituloBase;
import namedEntity.Titulo.TituloTech;
import namedEntity.Producto;
import scala.Serializable;

public abstract class Heuristic implements Serializable {
    private static Map<String, NamedEntity> categoryMap = Map.ofEntries(
        entry("Microsoft", new OrganizacionTech(1, "Microsoft", "microsoft", "microsoft", 250300, List.of("tecnologia", "Sistemas Operativos", "IA"), "Tecnologia", List.of("Windows", "Office", "Xbox", "Azure", "Visual Studio"))),
        entry("Apple", new OrganizacionTech(1, "Apple", "apple", "apple", 10000, List.of("tecnologia", "Celulares", "Sistemas Operativos"), "Tecnologia", List.of("Mac", "Iphone", "Ipad", "Ipod", "Apple Watch"))),
        entry("Apple's", new OrganizacionTech(1, "Apple's", "apple", "apple", 10000, List.of("tecnologia", "Celulares", "Sistemas Operativos"), "Tecnologia", List.of("Mac", "Iphone", "Ipad", "Ipod", "Apple Watch"))),
        entry("FBI", new OrganizacionPolitic(1, "FBI", "fbi", "fbi", 9920, List.of("Gobierno", "Investigacion", "Policia"), "Neutral?", "Organizacion", "USA")),
        entry("Google", new OrganizacionTech(1, "Google", "google", "google", 100000, List.of("tecnologia", "navegadores web", "IA"), "Tecnologia", List.of("Google Search", "Google Maps", "Google Drive", "Google Docs", "Google Sheets", "Google Slides", "Google Translate", "Google Photos", "Google Keep", "Google Calendar", "Google Earth", "Google News", "Google Books", "Google Scholar", "Google Finance", "Google Trends", "Google Flights", "Google Shopping", "Google Express", "Google Wallet", "Google Pay", "Google Pay Send", "Google Play", "Google Play Music", "Google Play Books", "Google Play Newsstand", "Google Play Movies & TV", "Google Play Games", "Google Play Console", "Google Play Services", "Google Play Protect", "Google Play Developer Console", "Google Play Movies & TV", "Google Play Books", "Google Play Newsstand", "Google Play Games", "Google Play Console", "Google Play Services", "Google Play Protect", "Google Play Developer Console"))),
        entry("Facebook", new OrganizacionTech(1, "Facebook", "facebook", "facebook", 500000, List.of("tecnologia", "red social", "IA", "marketplace"), "Redes Sociales", List.of("Facebook", "Facebook Messenger", "Instagram", "WhatsApp", "Oculus VR"))),
        entry("Instagram", new OrganizacionTech(1, "Instagram", "instagram", "instagram", 95922, List.of("tecnologia", "navegadores web", "IA"), "Redes Sociales", List.of("Instagram"))),
        entry("Twitter", new OrganizacionTech(1, "Twitter", "twitter", "twitter", 1000, List.of("tecnologia", "red social", "noticias"), "Redes Sociales", List.of("Twitter", "Twitter Mobile"))),
        entry("Department", new OrganizacionBase(1, "Department", "department", "department", 0, List.of("People"))),
        entry("Pixel", new Producto(1, "Pixel", "pixel", "pixel", "Google")),
        entry("Iphone", new Producto(1, "Iphone", "iphone", "iphone", "Apple")),
        entry("Phone", new Producto(1, "Phone", "phone", "phone", null)),
        entry("Galaxy", new Producto(1, "Galaxy", "galaxy", "galaxy", "Samsung")),
        entry("Taiwan", new Pais(1, "Taiwan", "taiwan", "taiwan", "Taiwanenses", "Mandarin Chinese", "Taipei")),
        entry("TSMC's", new OrganizacionBase(1, "TSMC's", "tsmc", "tsmc", 99, List.of("idk"))),
        entry("Chip", new Producto(1, "Chip", "chip", "chip", null)),
        entry("Washington", new Ciudad(1, "Washington", "washington", "washington", "Americans", "Washington", "USA", "Washington")),
        entry("Chinese", new Person(1, "Chinese", "chinese", "chinese")),
        entry("Beijing", new Ciudad(1, "Beijing", "beijing", "beijing", "Chinese", "Beijing", "China", "Beijing")),
        entry("Bikes", new Producto(1, "Bikes", "bikes", "bikes", null)),
        entry("Peloton", new TituloBase(1, "Peloton", "peloton", "peloton", "Peloton", "Peloton")),
        entry("Netflix", new OrganizacionTech(1, "Netflix", "netflix", "netflix", 500000, List.of("SAAS", "Series", "Peliculas"), "Entretenimiento", List.of("Netflix"))),
        entry("Musk", new ApellidoTech(1, "Musk", "musk", "musk", "Musk", "African", "tecnologia", List.of("Tesla", "SpaceX", "The Boring Company", "Neuralink"))),
        entry("Mr", new Person(1, "Mr", "mr", "mr")),
        entry("CEO", new TituloTech(1, "CEO", "ceo", "ceo", "CEO", "Usa", "Tecnologia", null)),
        entry("Linda", new NombreBase(1, "Linda", "linda", "linda", "Linda", "Caucasian", List.of("Linda", "Lindy"))),
        entry("Yaccarino", new ApellidoTech(1, "Yaccarino", "yaccarino", "yaccarino", "Yaccarino", "Asian(?)", "Redes Sociales", List.of("Twitter"))),
        entry("NBCUniversal", new OrganizacionBase(1, "NBCUniversal", "nbcuniversal", "nbcuniversal", 10000, List.of("Entretenimiento", "Series", "Peliculas"))),
        entry("Tesla", new OrganizacionTech(1, "Tesla", "tesla", "tesla", 100000, List.of("Automotriz", "Autos", "IA"), "Automotriz", List.of("Tesla"))),
        entry("Vehicles", new Producto(1, "Vehicles", "vehicles", "vehicles", null)),
        entry("Cruise", new Producto(1, "Cruise", "cruise", "cruise", "Chevrolet")),
        entry("Kyle", new NombreBase(1, "Kyle", "kyle", "kyle", "Kyle", "Caucasian", List.of("Kyle", "Ky"))),
        entry("Vogt", new ApellidoTech(1, "Vogt", "vogt", "vogt", "Vogt", "Franchise(?)", "tecnologia", List.of("Cruise"))),
        entry("Car", new Producto(1, "Car", "car", "car", null)),
        entry("AI", new Producto(1, "AI", "ai", "ai", null)),
        entry("3-D", new Producto(1, "3-D", "3-d", "3-d", null)),
        entry("Tech", new Producto(1, "Tech", "tech", "tech", null)),
        entry("Chiplets", new Producto(1, "Chiplets", "chiplets", "chiplets", null)),
        entry("ByteDance", new OrganizacionTech(1, "ByteDance", "bytedance", "bytedance", 100000, List.of("Entretenimiento", "Red Social", "IA"), "Datos", List.of("TikTok"))),
        entry("Company", new OrganizacionBase(1, "Company", "company", "company", 0, List.of("People"))),
        entry("Ex-ByteDance", new TituloBase(1, "Ex-ByteDance", "ex-bytedance", "ex-bytedance", "ByteDance Worker", "Ex-ByteDance")),
        entry("Ms", new Person(1, "Ms", "ms", "ms")),
        entry("Elon", new NombreTech(1, "Elon", "elon", "elon", "Elon", "African", List.of("Elon"), "tecnologia", List.of("Tesla", "SpaceX", "The Boring Company", "Neuralink"))),
        entry("Texas", new Ciudad(1, "Texas", "texas", "texas", "Americans", "Texas", "USA", "Texas")),
        entry("Hollywood", new Ciudad(1, "Hollywood", "hollywood", "hollywood", "Americans", "Los Angeles", "USA", "Hollywood")),
        entry("Writers", new TituloBase(1, "Writers", "writers", "writers", "Writer", "Writers")),
        entry("Workplace", new LugarBase(1, "Workplace", "workplace", "workplace")),
        entry("Women", new Person(1, "Women", "women", "women")),
        entry("Summer", new NombreBase(1, "Summer", "summer", "summer", "Summer", "American", List.of("Summer", "Sum", "Summy"))),
        entry("Sam", new NombreBase(1, "Sam", "sam", "sam", "Sam", "American", List.of("Sam", "Sammuel", "S", "Sammie"))),
        entry("Tucker", new ApellidoBase(1, "Tucker", "tucker", "tucker", "Tucker", "American")),
        entry("Carlson", new ApellidoBase(1, "Carlson", "carlson", "carlson", "Carlson", "American")),
        entry("American", new Person(1, "American", "american", "american")),
        entry("Companies", new OrganizacionBase(1, "Companies", "companies", "companies", 100000, List.of("Empresas"))),
        entry("TikTok", new OrganizacionTech(1, "TikTok", "tiktok", "tiktok", 100000, List.of("Entretenimiento", "Red Social", "IA"), "Entretenimiento", List.of("TikTok"))),
        entry("Times", new OrganizacionPolitic(1, "Times", "times", "times", 100000, List.of("Noticias", "Periodico"), "Democrata", null, "Usa")),
        entry("FTX", new OrganizacionPolitic(1, "FTX", "ftx", "ftx", 100000, List.of("Criptomonedas", "Finanzas", "IA"), "Comunistas", null, "China")),
        entry("China", new Pais(1, "China", "china", "china", "Chinese", "Mandarin Chinese", "China")),
        entry("Rusia", new Pais(1, "Rusia", "rusia", "rusia", "Rusos", "Ruso", "Rusia")),
        entry("Rusia's", new Pais(1, "Rusia's", "rusia", "rusia", "Rusos", "Ruso", "Rusia")),
        entry("US", new Pais(1, "US", "us", "us", "Americans", "English", "USA")),
        entry("Republican", new TituloBase(1, "Republican", "republican", "republican", "Republican", "Republican")),
        entry("Biden", new ApellidoPolitico(1, "Biden", "biden", "biden", "Biden", "American", "Democrata","President", "Usa")),
        entry("Government", new OrganizacionPolitic(1, "Government", "government", "government", 100000, List.of("Gobierno"), null, null, null)),
        entry("Food", new Producto(1, "Food", "food", "food", null)),
        entry("FDA", new OrganizacionPolitic(1, "FDA", "fda", "fda", 100000, List.of("Gobierno", "Salud"), null, null, "USA")),
        entry("Pill", new Producto(1, "Pill", "pill", "pill", null)),
        entry("Federal", new TituloBase(1, "Federal", "federal", "federal", "Federal", "Federal")),
        entry("Carl", new NombreBase(1, "Carl", "carl", "carl", "Carl", "American", List.of("Carl", "C"))),
        entry("Camera", new Producto(1, "Camera", "camera", "camera", null)),
        entry("Video", new Producto(1, "Video", "video", "video", null)),
        entry("Ship", new Producto(1, "Ship", "ship", "ship", null)),
        entry("Hulu", new OrganizacionTech(1, "Hulu", "hulu", "hulu", 100000, List.of("Entretenimiento", "Series", "Peliculas"), "Entretenimiento", List.of("Hulu"))),
        entry("Disney+", new Producto(1, "Disney+", "disney+", "disney+", "Disney")),
        entry("President", new TituloBase(1, "President", "president", "president", "Presidente", "Presidente")),
        entry("Russian", new Person(1, "Russian", "russian", "russian")),
        entry("Fox", new OrganizacionTech(1, "Fox", "fox", "fox", 100000, List.of("Entretenimiento", "Series", "Peliculas"), "Entretenimiento", List.of("Fox"))),
        entry("Strachwitz", new ApellidoPolitico(1, "Strachwitz", "strachwitz", "strachwitz", "Strachwitz", "German", null, "Oficial", "Alemania")),
        entry("Music", new Producto(1, "Music", "music", "music", null)),
        entry("Trump", new ApellidoPolitico(1, "Trump", "trump", "trump", "Trump", "American", "Republicano", "Ex-President", "Usa")),
        entry("Donald", new NombreBase(1, "Donald", "donald", "donald", "Donald", "American", List.of("Don, Donald, Donny, Donnie, Donal, Donnell, Donatus, Donat, Donatello, Donatien, Donatello, Donatian, Donatianus, Donatus, Do"))
        )
        );
	
	
    public NamedEntity getCategory(String entity){

	NamedEntity category = categoryMap.get(entity);
        if (category == null){
            category = new NamedEntity(entity, "Unknown", 1);
        }
          return category;
    };

    public abstract boolean isEntity(String word);
}
