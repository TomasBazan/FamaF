# Laboratorio 3: Programación asistida para Frameworks sobre Cálculo Distribuido

## Introducción

En esta segunda parte del proyecto, la primera tarea a resolver consistía en elegir un código de alguno de los integrantes de la primera parte para construir, a partir de él, las funcionalidades de la parte dos, las decisiones tomadas y las razones para tomar esas decisiones están detalladas en el apartado [Código inicial](##Código-inicial).

## Código inicial 

La decisión fue bastante fácil, ya que todos habíamos resuelto la parte 1 de maneras diferentes. Si observamos los códigos de la primera parte, podemos ver que los de Tomás y Milagros son bastante parecidos, ya que ambos modificaron la función `computeNamedEntities` agregando algunos  `filter`,  `map` y `reduce` para sanitizar el string correspondiente al texto del artículo y mapeando a pares `(Palabra, Frequency)` los resultados.

Al reunirnos para decidir cuál código íbamos a utilizar, notamos que la única diferencia funcional entre estos dos códigos es que el de Milagros también modifica la función `h.getCategory` para agregar la frecuencia de la entidad nombrada correspondiente al añadirla a la lista de entidades nombradas, mientras que Tomás utiliza las siguientes líneas de código para realizar las tareas de agregar la entidad nombrada y establecer su frecuencia en pasos separados, sin modificar funciones de la clase `Heuristic`:

```java
this.namedEntityList.add(h.getCategory(entry.getKey()));
this.namedEntityList.get(namedEntityList.size() - 1).setFrequency(entry.getValue());
```
Entre estos dos códigos, creemos que el enfoque de Tomás es mejor, ya que no modifica las funciones fuera de `computeNamedEntities`. Sin embargo, si observamos el código de Milagros en el resto del proceso, está más modularizado (por ejemplo, `RemoveCharacters` es una función aparte). Por lo tanto, decidimos hacer una combinación entre ambos, utilizando el código de Milagros para `computeNamedEntities`, y la forma de establecer la frecuencia de las entidades de Tomás.

Creemos que las similitudes entre los códigos finales de ambos integrantes se deben principalmente a que ambos utilizaron Inteligencia Artificial para generar texto como guía al escribir sus programas. Tomás utilizó Bard, mientras que Milagros utilizó ChatGPT.

Ahora, al comparar este código con el de Juan, vemos grandes diferencias. En este tercer código, las funcionalidades están implementadas en el archivo `FeedReaderMain`, donde se utilizan métodos propios de Spark, como `map`, `collect`, `forEach`, `reduce`, entre otros, para llevar a cabo dos tareas principales:

* Obtener los feeds y los artículos de cada feed de manera distribuida.
* Imprimir los resultados.

La funcionalidad de imprimir los resultados no nos pareció demasiado útil y no la utilizamos en esta parte del proyecto. Sin embargo, la creación de los objetos de las clases `Feed` y `Article` de esta manera distribuida nos pareció interesante, por lo que decidimos incorporarla en el código base de nuestra parte dos. ¿De qué manera? Simplemente cambiando la implementación de Juan en la función `computeNamedEntities`, tal como mencionamos anteriormente. Sin embargo, tuvimos algunos problemas con las sesiones Spark creadas. Para solucionarlo, modificamos el código de `computeNamedEntities` para que, en lugar de crear sesiones Spark mediante la clase `SparkConf`, utilizara `SparkSession` agregando `.getOrCreate()` a todas nuestras sesiones. De esta manera, evitamos crear diferentes sesiones Spark de manera simultánea, permitiendo que Spark funcione correctamente.

La forma de resolver de Juan es bastante distinta, ya que al guiarse por internet y, principalmente, por la documentación de Spark, hasta que no comparamos los códigos, no conocía algunas funciones, como por ejemplo `reduceByKey`.



## Indice Invertido



Para la segunda parte del proyecto, teníamos la tarea de incorporar un índice invertido a nuestro código. Un índice invertido es una estructura de datos que nos permite relacionar entidades nombradas con los artículos en los que aparecen y la frecuencia de su aparición.

¿Qué es exactamente un índice invertido? Es una técnica utilizada en recuperación de información, donde se crea una lista que mapea cada término (en nuestro caso, entidad nombrada) con los documentos (artículos) en los que aparece. En lugar de buscar en los documentos para encontrar una coincidencia de términos, el índice invertido nos permite, de manera eficiente, encontrar los documentos relevantes para una entidad nombrada específica.

Al incorporar el índice invertido a nuestro código, pudimos agregar una funcionalidad muy útil para el usuario: la capacidad de realizar búsquedas basadas en una entidad nombrada ingresada como entrada. De esta manera, el usuario puede obtener información sobre en qué artículos se menciona dicha entidad y con qué frecuencia aparece.

### Modificaciones en el código