# Informe del proyecto de laboratorio de análisis de datos con parsers en Java
## Laboratorio: 02
### Grupo: n°20 "kidvslab"
### Integrantes: 
- Bazán Tomas 
- Carabelos Milagros 
- Pereyra Carrillo Juan Cruz

### Disclaimer:
Nosotros utilizamos NetBeans para armar un proyecto Maven para manejar las dependencias, se agrego un .zip con el proyecto Maven ya configurado. No debería de haber problemas para correrlo directamente importando el proyecto.
Cualquier duda o problemas al correr el código consultarnos.
Gracias.
---

## Introducción

El objetivo de este proyecto de laboratorio fue crear un programa en Java que pudiera analizar diferentes tipos de datos almacenados en archivos JSON y XML. Para lograrlo, se utilizaron distintos parsers que permitieron extraer información relevante de los archivos.
## Desarrollo

### Subscription:
#### SingleSubscription:
Esta clase es una representación de una única suscripción a un feed RSS. Esta clase encapsula los detalles de la URL, los parámetros de la URL y el tipo de URL en una sola entidad.

##### Propiedades:
- url: una cadena que representa la URL del feed RSS.
- ulrParams: una lista de cadenas que representan los parámetros de la URL.
- urlType: una cadena que representa el tipo de URL.

##### Métodos:

- getUrl: devuelve la URL del feed RSS.
- setUrl: establece la URL del feed RSS.
- getUlrParams: devuelve la lista de parámetros de la URL.
- getUlrParams: devuelve el parámetro de la URL en el índice i.
- setUlrParams: agrega un nuevo parámetro a la lista de parámetros de la URL.
- getUlrParamsSize: devuelve el tamaño de la lista de parámetros de la URL.
- getUrlType: devuelve el tipo de URL.
- setUrlType: establece el tipo de URL.
- toString: devuelve una cadena que representa la instancia actual de la clase SingleSubscription.
- prettyPrint: imprime en consola la representación actual de la instancia de la clase SingleSubscription.
- getFeedToRequest: devuelve la URL del feed RSS con el parámetro de la URL en el índice i reemplazado.

##### Uso de la clase:

            SingleSubscription s = new SingleSubscription("https://rss.nytimes.com/services/xml/rss/nyt/%s.xml", null, "rss");
            s.setUlrParams("Business");
            s.setUlrParams("Technology");
            System.out.println(s.getFeedToRequest(0));
            s.prettyPrint();

En este ejemplo, creamos una instancia de la clase SingleSubscription y establecemos la URL y los parámetros de la URL. Luego, imprimimos en consola la URL del feed RSS con el primer parámetro reemplazado y también imprimimos la representación de la instancia actual de la clase SingleSubscription en consola.


#### Subscription:
Esta clase se utiliza para representar el contenido del archivo de suscripción en formato JSON. Esta clase es responsable de almacenar una lista de objetos de tipo SingleSubscription, que representan las suscripciones individuales.

##### Constructor

El constructor de la clase Subscription inicializa la lista de suscripciones individuales con un objeto ArrayList. Toma un argumento subscriptionFilePath que actualmente no se utiliza en la clase.

##### Métodos
- getSubscriptionsList: Este método devuelve la lista de suscripciones individuales almacenadas en la clase Subscription.
- addSingleSubscription: Este método se utiliza para agregar una nueva suscripción individual a la lista de suscripciones.
- getSingleSubscription: Este método devuelve la suscripción individual en el índice especificado de la lista de suscripciones.
- toString: Este método devuelve una cadena que representa el objeto Subscription. Esta cadena es una concatenación de las representaciones de cadena de cada uno de los objetos SingleSubscription almacenados en la lista de suscripciones.
- prettyPrint: Este método imprime en la consola la representación de cadena del objeto Subscription.

##### Uso de la clase:

		    Subscription a = new Subscription(null);
    
		    SingleSubscription s0 = new SingleSubscription("https://www.chicagotribune.com/arcio/rss/category/%s/?query=display_date:[now-2d+TO+now]&sort=display_date:desc", null, "rss");
		    s0.setUlrParams("business");		
    
		    SingleSubscription s1 = new SingleSubscription("https://rss.nytimes.com/services/xml/rss/nyt/%s.xml", null, "rss");
		    s1.setUlrParams("Business");
		    s1.setUlrParams("Technology");

		    a.addSingleSubscription(s0);		
		    a.addSingleSubscription(s1);
		    a.prettyPrint();

La clase Subscription proporciona una abstracción útil para el contenido del archivo de suscripción en formato JSON. Es capaz de almacenar múltiples suscripciones individuales y proporciona métodos para agregar, obtener y representar estas suscripciones.


### Parsers:
Para el desarrollo del programa, se implementaron diferentes clases para manejar los distintos tipos de parsers.


#### GeneralParser:
Clase "Madre/Padre" del resto de clases, aquí se definen las funciones utiles entre distintos parsers ademas de que se estructura el diseño de las clases hijas.
- formatDate: Esta función nos ayuda a mantener el mismo formato de fechas entre los distintos sitios.


#### SuscriptionParser:
Es el mas disitnto, entre los 2 otros parsers.
La clase SubscriptionParser es una clase que implementa el parser del archivo de suscripción (json) y se utiliza para convertir un archivo json en una instancia de la clase Subscription.

##### Métodos
- parseJson: Este método toma como entrada una cadena de texto que representa la ruta de un archivo json, lee el archivo y lo convierte en un objeto JSONArray. Devuelve el JSONArray resultante.
- makeResponse: Este método toma como entrada un JSONArray que representa la estructura del archivo json de suscripción, lo recorre y construye una instancia de la clase Subscription.
- parseFile: Este método toma como entrada una cadena de texto que representa la ruta de un archivo json de suscripción, llama al método parseJson para obtener el JSONArray resultante, y luego llama al método makeResponse para construir la instancia de la clase Subscription.
- handleParseSuscription: Este método toma como entrada una cadena de texto que representa la ruta de un archivo json de suscripción, llama al método parseFile y devuelve la instancia de la clase Subscription resultante.

##### Uso de la clase:
Para utilizar la clase SubscriptionParser, se debe instanciar un objeto SubscriptionParser y luego llamar al método handleParseSubscription, pasando como argumento la ruta del archivo json de suscripción. Esto devolverá la instancia de la clase Subscription que se puede utilizar en la lógica del programa.

El parser utiliza la biblioteca org.json para leer y analizar archivos JSON. En particular, utiliza el método parseJson para leer el archivo y convertir su contenido en un objeto JSONArray. Luego, utiliza el método makeResponse para extraer la información relevante de cada objeto JSONObject dentro del array y construir un objeto Subscription que contiene toda 

            SubscriptionParser subsParser = new SubscriptionParser();
            Subscription response = subsParser.handleParseSuscription(filepath);
            response.prettyPrint();
            
##### Referencias:

https://www.w3docs.com/snippets/java/how-to-parse-json-in-java.html


#### RssParser:

La clase RssParser implementa el parser de un feed de tipo RSS en formato XML. Esta clase es utilizada para leer y parsear información de un feed y convertirla en un objeto Feed que contiene información relevante como el título, texto, fecha de publicación y enlace de cada artículo del feed.
##### Metodos:
- parseXML(String xml): Este método toma una cadena de caracteres en formato XML y retorna un objeto Document que representa el contenido del archivo XML.

- getTagValue(Element element, String tagName): Este método toma un elemento Element y un nombre de etiqueta tagName. Retorna el valor del primer nodo hijo con el nombre tagName como una cadena de caracteres.

- readTagValues(Document doc): Este método toma un objeto Document que representa un archivo XML de un feed RSS y retorna un objeto Feed que contiene información de cada artículo del feed.

- handleParse(String s): Este método toma una cadena de caracteres que representa un archivo XML de un feed RSS y retorna un objeto Feed que contiene información de cada artículo del feed. Utiliza los métodos  parseXML y readTagValues para parsear la información del feed.

##### Uso de la clase:
Para utilizar esta clase, se debe instanciar un objeto RssParser y llamar a la método handleParse con una cadena de caracteres que representa el archivo XML del feed RSS. Esto retornará un objeto Feed que contiene información relevante del feed.

            RssParser rssParser = new RssParser();
            for (int i = 0; i < xmlList.size(); i++) {
                Feed feed = rssParser.handleParse(xmlList.get(i));
            }

### HttpRequester
Es normal preguntarse, bueno pero...  ¿de donde sacamos estos datos?
Es necesario abstraer esta funcionalidad a otra clase separada, ya que trae beneficios a nuestro proyecto como escalavilidad, poder hacer UnitTesting y facilitar el debugging.

La clase que se encarga de hacer esto es la clase HttpRequester.
Esta clase realiza la petición del feed al servidor de noticias, utilizando el protocolo HTTP. Para ello, utiliza la API java.net, que proporciona clases para trabajar con URLs, conexiones HTTP y otros componentes de red.
#### Métodos:

- getFeedRss: se encarga de realizar la petición GET al servidor, con la URL del feed de noticias como parámetro de entrada. La respuesta del servidor se analiza para determinar si la petición fue exitosa (código de respuesta HTTP 2xx), y en ese caso, se obtiene el contenido del feed en formato XML a través de la clase InputStream. Este contenido se procesa y se devuelve como una cadena de caracteres, lista para ser procesada por el parser correspondiente.

- getFeedReedit: Esta función está destinada a obtener el feed de noticias desde una fuente distinta, en formato JSON. Sin embargo, esta funcionalidad aún no ha sido implementada.

#### Uso de la clase:
Para utilizar esta clase, es necesario crear una instancia de la misma y llamar al método correspondiente, pasándole la URL del feed que se desea obtener. Por ejemplo:


            httpRequester requester = new httpRequester();
            String feedRssXml = requester.getFeedRss("http://www.abc.es/rss/feeds/abc_ultima.xml");

#### Referencias:

Para obtener más información sobre cómo hacer una petición HTTP en Java, se pueden consultar los siguientes recursos:

- https://www.baeldung.com/java-http-request



### Feed:
#### Article:

La clase Article representa el contenido de un artículo, por ejemplo, en un feed RSS. Esta clase contiene los siguientes atributos:

- title: título del artículo.
- text: contenido del artículo.
- publicationDate: fecha de publicación del artículo.
- link: enlace del artículo.

##### Uso de la clase:
Se puede crear un nuevo objeto Article utilizando el siguiente constructor:

        Article a = new Article(String title, String text, Date publicationDate, String link);

Después de crear un objeto Article, se pueden acceder a sus atributos utilizando los siguientes métodos:

- getTitle(): devuelve el título del artículo.
- getText(): devuelve el contenido del artículo.
- getPublicationDate(): devuelve la fecha de publicación del artículo.
- getLink(): devuelve el enlace del artículo.
- getPageName(): devuelve el nombre de la página web del artículo
- getNamedEntitiesLength(): devuelve la cantidad de entidades nombradas

##### Metodos extra:

- computeNamedEntities: calcula las entidades nombradas en el artículo, utilizando un objeto  de la clase Heuristic el cual discrimina entre palabras que son entidades nombradas y las que no. Las entidades nombradas se almacenan en una lista de objetos NamedEntity.

- prettyPrint que imprime de manera legible los atributos del artículo, incluyendo la cantidad de entidades nombradas y una lista de ellas.
Se modificó el método prettyPrint para mejorar su legibilidad.

#### Feed:
La clase Feed modela la lista de artículos de un feed.

##### Atributos

- siteName: Nombre del sitio al que pertenece el feed.
- articleList: Lista de artículos del feed.

##### Métodos

 - Feed: Constructor que recibe como parámetro el nombre del sitio al que pertenece el feed.
 - setSiteName: Establece el nombre del sitio al que pertenece el feed.
 - getSiteName: Retorna el nombre del sitio al que pertenece el feed.
 - setArticleList: Establece la lista de artículos del feed.
 - getArticleList: Retorna la lista de artículos del feed.
 - addArticle: Agrega un artículo a la lista de artículos del feed.
 - getArticle: Retorna el artículo en la posición i de la lista de artículos del feed.
 - getNumberOfArticles: Retorna la cantidad de artículos en la lista de artículos.
 - toString(): Retorna una representación en forma de String del feed, incluyendo su nombre y la lista de artículos.
 - prettyPrint(): Imprime por consola la información de cada artículo del feed.

Además, la clase cuenta con un método main que crea una instancia de la clase Feed, agrega tres instancias de Article a su lista de artículos y posteriormente utiliza el método prettyPrint para imprimir por consola la información de cada artículo en el feed.


##### Uso de la clase
            Article a1 = new Article("This Historically Black University Created Its Own Tech Intern Pipeline",
                "A new program at Bowie State connects computing students directly with companies, bypassing an often harsh Silicon Valley vetting process",
                new Date(),
                "https://www.nytimes.com/2023/04/05/technology/bowie-hbcu-tech-intern-pipeline.html"
            );

            Article a2 = new Article("This Historically Black University Created Its Own Tech Intern Pipeline",
                "A new program at Bowie State connects computing students directly with companies, bypassing an often harsh Silicon Valley vetting process",
                new Date(),
                "https://www.nytimes.com/2023/04/05/technology/bowie-hbcu-tech-intern-pipeline.html"
            );

            Article a3 = new Article("This Historically Black University Created Its Own Tech Intern Pipeline",
                "A new program at Bowie State connects computing students directly with companies, bypassing an often harsh Silicon Valley vetting process",
                new Date(),
                "https://www.nytimes.com/2023/04/05/technology/bowie-hbcu-tech-intern-pipeline.html"
            );

            Feed f = new Feed("nytimes");
            f.addArticle(a1);
            f.addArticle(a2);
            f.addArticle(a3);

            f.prettyPrint();

En este ejemplo, se crea un feed con diferentes artículos, además de imprimir por consola su información de manera ordenada y legible.

### NamedEntity y Heuristic:
#### NamedEntity:
Esta es  una clase que modela la noción de entidad nombrada. Esta clase contiene los siguientes atributos:
###### Atributos:
- name: una cadena de caracteres que representa el nombre de la entidad nombrada.
- category: una cadena de caracteres que representa la categoría de la entidad nombrada.
- frequency: un entero que representa la frecuencia de la entidad nombrada.

###### Métodos:
- getName: un método que devuelve el valor del atributo name.
- setName: un método que establece el valor del atributo name.
- getCategory: un método que devuelve el valor del atributo category.
- setCategory: un método que establece el valor del atributo category.
- getFrequency: un método que devuelve el valor del atributo frequency.
- setFrequency: un método que establece el valor del atributo frequency.
- incFrequency: un método que incrementa el valor del atributo frequency en 1.
- toString: un método que devuelve una cadena de caracteres que representa el objeto NamedEntity.
- prettyPrint: un método que imprime por consola el objeto NamedEntity con formato.

La clase NamedEntity es útil para representar entidades nombradas en diferentes contextos, por ejemplo, en procesamiento de lenguaje natural, minería de datos, entre otros. Además, la clase NamedEntity es fácilmente extensible para agregar más atributos y métodos según las necesidades del contexto en el que se utilice.
Ademas creamos distintas subclases con sus métodos propios.
Además se incorporó el uso de interfaces.

Las cuales nos ayudan a generar cierta "Herencia Multiple" implementando las interfaces dentro de nuestras subclases, generando así sub-subclases como por ejemplo

    Persona -> NombreBase -> NombreTech

La cual es una clase que hereda de NombreBase e implementa la interfaz de Tech, esto nos permite incorporar multiples interfaces en una misma clase.

Debido a que no tuvimos mucho timpo para refactorizar el kickstarter con esta implementacion sugerida por la catedra el pasado Viernes, no pudimos llegar a implementar cada una de las posibles subclases. Sin embargo, creamos las interfaces necesarias para generar las subclases importantes a las noticias de los portales.

#### Heuristic:
La clase Heuristic es una clase abstracta que se encuentra dentro del paquete namedEntity.heuristic en un proyecto de Java. Esta clase se utiliza para determinar la categoría de entidades nombradas en un texto dado.

##### Metodos
- getCategory: La función getCategory es responsable de obtener la categoría de una entidad nombrada. Esta función toma una cadena como parámetro que representa la entidad nombrada y devuelve una cadena que representa la categoría de la entidad. Para determinar la categoría, la función busca la entrada correspondiente en un mapa de categorías predefinido. Si la entidad no se encuentra en el mapa, se establece la categoría como "Unknown".

- isEntity: isEntity es abstracta y se utiliza para determinar si una palabra dada es una entidad nombrada. Esta función se implementa en las subclases de Heuristic.
Mapa de categorías

##### Uso de la clase:
La clase Heuristic utiliza un mapa predefinido de categorías para determinar la categoría de una entidad nombrada. El mapa utiliza pares de entrada de la forma "entidad : NamedEntityClass". Las NamedEntityClass pueden ser "PersonaBase", "Pais", "Ciudad", "NombreTech", "NombreBase", etc.

##### Conclusiones

La clase Heuristic es una herramienta útil para determinar la categoría y temas de entidades nombradas en un texto. Utiliza un mapa de categorías predefinido para realizar esta tarea y es fácilmente extensible mediante la implementación de nuevas subclases.


#### QuickHeuristic:
La clase Java QuickHeuristic es una subclase de la clase abstracta Heuristic del paquete namedEntity.heuristic. Esta clase implementa el método isEntity para determinar si una palabra es una entidad nombrada o no.

##### Método isEntity

El método isEntity de la clase QuickHeuristic determina si una palabra es una entidad nombrada utilizando una estrategia heurística rápida. Este método devuelve true si la palabra:

- Tiene más de una letra
- La primera letra es una letra mayúscula
- La palabra no está en una lista predefinida de palabras clave comunes que no son entidades nombradas.

La lista de palabras clave se almacena en la variable estática keyWords y contiene palabras comunes como pronombres, preposiciones y conjunciones.

##### Uso de la clase:

            // Crear instancia de QuickHeuristic
            QuickHeuristic heuristic = new QuickHeuristic();

            // Llamar al método isEntity para determinar si una palabra es una entidad nombrada
            String word = "Apple";
            if (heuristic.isEntity(word)) {
                System.out.println(word + " es una entidad nombrada");
            } else {
                System.out.println(word + " no es una entidad nombrada");
            }


#### RandomHeuristic

La clase RandomHeuristic es una subclase de la clase abstracta Heuristic, que se utiliza para determinar si una palabra es una entidad nombrada o no. Esta clase utiliza un método de heurística aleatoria para tomar una decisión.
Atributos

##### Atributos:

- rnd: Un objeto de tipo Random que se utiliza para generar números aleatorios.
- positiveCases: Una lista que contiene las palabras que se han clasificado como entidades nombradas.
- negativeCases: Una lista que contiene las palabras que se han clasificado como no entidades nombradas.

##### Métodos:

- isPositiveCase: Un método que devuelve true si la palabra dada ya se ha clasificado como una entidad nombrada.
- isNegativeCase: Un método que devuelve true si la palabra dada ya se ha clasificado como no entidad nombrada.
- isEntity: Un método que utiliza la heurística aleatoria para decidir si la palabra dada es una entidad nombrada o no. Si la palabra ya se ha clasificado, devuelve el resultado anterior. De lo contrario, genera un número aleatorio y lo utiliza para tomar una decisión, agregando la palabra a la lista correspondiente.

##### Uso de la clase

Para utilizar esta clase, se puede crear un objeto de tipo RandomHeuristic y llamar al método isEntity pasando como argumento una palabra. El método devolverá true si la palabra es una entidad nombrada y false en caso contrario.

            RandomHeuristic heuristic = new RandomHeuristic();
            String word = "Apple";
            if (heuristic.isEntity(word)) {
                System.out.println(word + " es una entidad nombrada");
            } else {
                System.out.println(word + " no es una entidad nombrada");
            }
