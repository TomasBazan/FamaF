
# Instalación Spark

Laboratorio 4 Paradigmas
Grupo 20
Integrantes :
    
-   *Pereyra Carrillo Juan Cruz*


## Spark:

Para instalar Spark, investigamos en la página oficial de Spark en la sección de descargas. Esta elección se basó en los siguientes motivos:

    Confiabilidad.
    Información actualizada.
    Recomendaciones.
    Ejemplos de "Hello World".

Al examinar la sección "Descargas" en el sitio web https://sparkjava.com/download, se recomienda el uso de Maven como gestor de paquetes para Java. Esta opción resulta conveniente ya que en el Laboratorio 03 utilizamos Maven para administrar nuestro proyecto.

En la página web se proporciona un fragmento de código que indica lo siguiente:

    <dependency>
        <groupId>com.sparkjava</groupId>
        <artifactId>spark-core</artifactId>
        <version>2.9.4</version>
    </dependency>

Por lo tanto, solo debemos generar un proyecto Maven desde NetBeans (u otro IDE) y actualizar nuestro archivo pom.xml.

## Instalación en un proyecto Maven con NetBeans:

### Crear Proyecto

Una vez que abrimos NetBeans, seleccionamos:

    File -> New Project

Esto abrirá una ventana emergente en la que seleccionamos "Next", ya que por defecto aparece una aplicación Java con Maven.

Al hacer clic en "Next", se nos pedirá completar algunos datos. Ingresamos lo siguiente:

- Nombre del proyecto: nombreDelProyecto
- Ubicación del proyecto: Ruta/A/Nuestro/Proyecto
- Id. de grupo: grupo id
- Versión: xxx.xxx
- Paquete: grupo id.nombreDelProyecto

Luego, hacemos clic en "Finish" y nuestro proyecto se creará.

### Agregar Dependencias

La ventaja de Maven es que nos permite administrar las dependencias de forma eficiente y sencilla.

Dentro de nuestro archivo pom.xml, podemos observar diferentes secciones en formato XML. Estas secciones representan la configuración de nuestro proyecto. Para agregar dependencias, simplemente creamos una sección <dependencies> y agregamos las dependencias dentro de ella.

    <dependency> <!-- Spark dependency -->
      <groupId>org.apache.spark</groupId>
      <artifactId>spark-sql_2.12</artifactId>
      <version>3.4.0</version>
      <type>jar</type>
    </dependency>
    <dependency> <!-- Spark dependency -->
      <groupId>org.apache.spark</groupId>
      <artifactId>spark-core_2.12</artifactId>
      <version>3.4.0</version>
      <type>jar</type>
    </dependency>

Luego, hacemos "Build" y ¡listo! Es así de sencillo.

Podemos verificar que ahora se encuentra la dependencia de Spark en nuestra carpeta "dependencies".

### Hello World!
A modo de ejemplo podemos fijarnos en este url, algunos hello worlds para verificar si nuestra instalacion fue correcta.

https://spark.apache.org/docs/latest/quick-start.html

Code snippet:

    import org.apache.spark.sql.SparkSession;
    import org.apache.spark.sql.Dataset;

    public class Mavenproject1 {

        public static void main(String[] args) {
        SparkSession spark = SparkSession.builder().appName("Simple Application").config("spark.master", "local").getOrCreate();
        Dataset<String> logData = spark.read().textFile("example.md").cache();

        long numAs = logData.filter((org.apache.spark.api.java.function.FilterFunction<String>)s -> s.contains("a")).count();
        long numBs = logData.filter((org.apache.spark.api.java.function.FilterFunction<String>)s -> s.contains("b")).count();

        System.out.println("Lines with a: " + numAs + ", lines with b: " + numBs);

        spark.stop();
      }
    }


### Problemas Comunes:

#### A master URL must be set in your configuration:
https://stackoverflow.com/questions/38008330/spark-error-a-master-url-must-be-set-in-your-configuration-when-submitting-a


#### Error reference to filter is ambiguous

https://stackoverflow.com/questions/59712047/java8-maven-raise-error-reference-to-filter-is-ambiguous


## Spark una pequeña descripción.
Spark es un motor ultrarrápido para el almacenamiento, procesamiento y análisis de grandes volúmenes de datos. Es de código abierto y se encuentra gestionado por la Apache Software Foundation. Por tanto, la herramienta se conoce como Apache Spark y es uno de sus proyectos más activos.

Apache Spark está especialmente diseñado para su implementación en big data y machine learning. Debido a que la potencia de procesamiento agiliza la detección de patrones en los datos, la clasificación organizada de la información, la ejecución de cómputo intensivo sobre los datos y el procesamiento paralelo en clústers.

- Permite su adaptación a distintas necesidades gracias a que es 100% open source.
- Simplifica el proceso de desarrollo de soluciones inteligentes.
- Mejora el desempeño de aplicaciones dependientes de datos.
- Unifica algoritmos para que trabajen conjuntamente en diversas tareas.
- Integra dentro de sí el modelado analítico de datos.
- Otorga escalabilidad en su potencia al introducir más procesadores en el sistema.
- Reduce los costes al poder utilizarse en hardware estándar de uso común.
- Promueve workflows basados en Grafos Acíclicos Dirigidos que aceleran el procesamiento.
- Dispone de una API para Java, Phyton y Scala; también APIs para transformar y manipular datos semiestructurados.
- Facilita la integración con sistemas de archivos como HDFS de Hadoop, Cassandra, HBase, MongoDB y el S3 de AWS.
- Ofrece bibliotecas de alto nivel para mejorar la productividad de los desarrolladores.
- Posee tolerancia a fallos implícita.
- Combina SQL, streaming y análisis de gran complejidad.

### Procesamiento por lotes ("batches")
El procesamiento por lotes se utiliza para manejar grandes cantidades de datos y realizar trabajos repetitivos de alto volumen, cada uno de los cuales realiza una operación específica sin necesidad de intervención del usuario. Cuando se disponen de suficientes recursos informáticos, el procesamiento por lotes permite procesar y gestionar datos con poca o ninguna interacción del usuario. Además, el procesamiento por lotes es fundamental en organizaciones y empresas para gestionar eficientemente grandes volúmenes de datos.

Esta técnica es especialmente útil para operaciones repetitivas y monótonas que respaldan varios flujos de trabajo de datos. Dado que el procesamiento por lotes automatiza los flujos de trabajo, minimiza en gran medida la posibilidad de errores o anomalías manuales. Gracias a las ganancias significativas en precisión y exactitud a través de la automatización, las organizaciones pueden lograr una calidad de datos superior al tiempo que disminuyen los cuellos de botella en las actividades de procesamiento de datos.

### Procesamiento Structured Streaming
Esta API permite realizar las mismas operaciones que se realizan en modo por "batches" utilizando las API estructuradas de Spark y ejecutarlas en un modo de streaming. Esto puede reducir la latencia y permitir el procesamiento incremental. Lo mejor de Structured Streaming es que te permite obtener rápidamente valor de los sistemas de transmisión con virtualmente ningún cambio de código. También facilita el razonamiento porque puedes escribir tu trabajo por "batches" como un prototipo y luego convertirlo en un trabajo de streaming. Todo esto se logra procesando los datos incrementalmente.

## Arquitectura de Spark
La arquitectura base de Apache Spark se muestra en la siguiente figura:

![Arquitectura](https://www.interviewbit.com/blog/wp-content/uploads/2022/06/Spark-Architecture-768x413.png)  

Cuando el programa controlador (Driver Program) en la arquitectura de Apache Spark se ejecuta, llama al programa real de una aplicación y crea un SparkContext. SparkContext contiene todas las funciones básicas. El controlador de Spark (Spark Driver) incluye varios componentes adicionales, como el Planificador DAG (DAG Scheduler), el Planificador de Tareas (Task Scheduler), el Planificador de Backend (Backend Scheduler) y el Administrador de Bloques (Block Manager), los cuales se encargan de traducir el código escrito por el usuario en trabajos que se ejecutan realmente en el clúster.

- El Gestor de Clúster (Cluster Manager):
Administra la ejecución de varios trabajos en el clúster. El controlador de Spark (Spark Driver) trabaja en conjunto con el Gestor de Clúster para controlar la ejecución de varios otros trabajos. El Gestor de Clúster se encarga de asignar recursos para el trabajo. Una vez que el trabajo se ha dividido en trabajos más pequeños, que luego se distribuyen a los nodos de trabajo, el controlador de Spark (Spark Driver) controlará la ejecución. Se pueden utilizar muchos nodos de trabajo para procesar un RDD creado en el SparkContext, y los resultados también se pueden almacenar en caché.

- El Spark Context:
recibe información de tareas del Gestor de Clúster y las encola en los nodos de trabajo.

- El ejecutor (executor):
Es el encargado de llevar a cabo estas tareas. La vida útil de los ejecutores es la misma que la de la aplicación de Spark. Podemos aumentar el número de trabajadores si queremos mejorar el rendimiento del sistema. De esta manera, podemos dividir los trabajos en partes más coherentes.

## Estructura tiene un programa de conteo de palabras en diferentes documentos en Spark

Si tomamos como ejemplo el Hello world que hicimos podemos ver que se utilizan varias funciones de la libreria de Spark.

- Crea una instancia de *SparkSession*, que es la interfaz principal para trabajar con Spark. Se configura con el nombre de la aplicación y se especifica "local" como el modo de ejecución. (aquí podemos agregar hosts y puerto que queramos)

- Se lee el archivo "example.md" como un conjunto de datos de tipo Dataset<String> llamado logData. textFile("example.md") carga el contenido del archivo en un RDD (Resilient Distributed Dataset) de Strings y cache() se utiliza para cachear los datos en memoria para un acceso rápido.

- Se realiza un filtrado en logData para contar el número de líneas que contienen la letra 'a'. Esto se hace utilizando el método filter y una función lambda que comprueba si la línea contiene la letra 'a'. El resultado se guarda en la variable numAs. 
De manera similar, se realiza un filtrado en logData para contar el número de líneas que contienen la letra 'b'. El resultado se guarda en la variable numBs.



## Integración de una estructura orientada a objetos con la estructura funcional de MapReduce
La integración de una estructura orientada a objetos con la estructura funcional de MapReduce se puede lograr mediante la implementación adecuada de las funciones map y reduce en el contexto de la programación orientada a objetos.

En MapReduce, la función map se encarga de transformar cada elemento de entrada en un conjunto de pares clave-valor intermedios, mientras que la función reduce combina los valores asociados con la misma clave para generar el resultado final.

Para integrar una estructura orientada a objetos, puedes seguir estos pasos:

- Definir una clase que represente los datos que deseas procesar. Esta clase debe contener los campos y métodos necesarios para trabajar con los datos.
- Implementar la función map en la clase. Esta función debe tomar un objeto de la clase como entrada y producir un conjunto de pares clave-valor intermedios.
- Implementar la función reduce en la clase. Esta función debe tomar una clave y una lista de valores y producir el resultado final deseado.
- Crear una instancia de la clase para cada elemento de entrada y aplicar la función map a cada instancia. Esto generará el conjunto de pares clave-valor intermedios.
- Agrupar los pares clave-valor intermedios por clave y aplicar la función reduce a cada grupo para obtener el resultado final.


La integración de estructuras orientadas a objetos y la estructura funcional de MapReduce puede variar según el lenguaje de programación y el entorno en el que estés trabajando.