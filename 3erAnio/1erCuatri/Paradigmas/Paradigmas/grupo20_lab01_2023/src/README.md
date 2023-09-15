# Paradigmas de la Programacion
## Laboratorio: 1
### Grupo: n°20 "kidvslab"
### Integrantes: 
- Bazan Tomas 
- Carabelos Milagros 
- Pereyra Carrillo Juan

---

Durante el desarrollo del proyecto tuvimos un primer acercamiento al código tratando de entender el flujo general y poder imprimir alguna figura. Una vez entendido esto pudimos empezar con la implementación de Dibujo.hs, llegando a una "wall" a la hora de la implementación de foldDib. Cuando logramos entender e implementar correctamente esta función el resto del proyecto fue mucho más ameno y rápido en general.

Material utilizado: Documentación de Gloss, Copilot, ChatGPT

---

**Preguntas:**

1. ¿Por qué están separadas las funcionalidades en los módulos indicados? Explicar detalladamente la responsabilidad de cada módulo.

En el módulo `Dibujo.hs`, definimos la sintaxis de nuestro DSL (Lenguaje Específico de Dominio), es decir, la gramática general de nuestro lenguaje, en la cual nos basamos para construir las distintas funcionalidades que otorgaremos al usuario. Luego, en `Interp.hs`, definimos nuestra semántica, es decir, la interpretación que le damos a nuestro lenguaje. En este módulo, nos encargamos de la aritmética de los vectores que definen las figuras base utilizadas en las funciones que exporta `Dibujo.hs`.

Estas funciones se exportan mediante `foldDib` de la siguiente manera: en un módulo nuevo, creamos las figuras básicas que deseemos y podemos componer una `Imagen` mediante cualquiera de las imágenes definidas en el mismo módulo, usando el lenguaje que nos proporciona `Dibujo.hs`. Por ejemplo, si definimos una figura básica como un triángulo y un rectángulo a partir de estas básicas, podremos apilar, juntar, rotar, etc., estas figuras, generando nuevas imágenes a partir de las ellas que a su vez pueden usarse como una figuras en otra imagen distinta.

Un claro ejemplo de esto en el proyecto se muestra en Escher, donde definimos una figura básica (un triángulo con otro triángulo negro adentro)

<img src="/home/mili/snap/typora/78/.config/Typora/typora-user-images/image-20230416113526317.png" alt="image-20230416113526317" style="zoom: 67%;" />



 Luego una composición de esa figura (`figuraU` y `figuraT`)

![image-20230416113856097](/home/mili/snap/typora/78/.config/Typora/typora-user-images/image-20230416113856097.png)



y finalmente, generamos un noneto que es una composición de estas composiciones (U y T).

![image-20230416113950520](/home/mili/snap/typora/78/.config/Typora/typora-user-images/image-20230416113950520.png)

 

Repitiendo y componiendo este noneto de cierta manera, n veces, logramos la imagen final esperada.

![image-20230416113150372](/home/mili/snap/typora/78/.config/Typora/typora-user-images/image-20230416113150372.png)

Notar que nuestra implementación de `figuraU` y `figuraT` no coincide con las del enunciado, pero sí con las del paper de Henderson, lo que nos permite generar el dibujo esperado. Las figuras del enunciado son fáciles de lograr solo espejando de cierta manera las nuestras, pero generan un comportamiento inadecuado en Escher.

Para comprender el significado de la semantica de nuestro lenguaje, debemos llamar a nuestro intérprete (`Interp.hs`), donde está definido qué hace cada "operador de nuestro lenguaje". Lo logramos llamando a la función `interp`, que, a su vez, llama a `foldDib` para identificar a qué "operadores" nos referimos en cada momento y qué interpretación local (en `Interp.hs`) tenemos para este.

El módulo `Main` se encarga de la creación de la pantalla donde se proyecta el dibujo y de qué dibujo se va a proyectar, eligiendo las configuraciones deseadas de la lista de configuraciones disponibles (accesible llamando a `Main` con el parámetro `--listar`).

En `FloatingPic` tenemos las definiciones de algunos tipos que utilizamos en todo el proyecto y la grilla que se imprime en la ventana a modo de referencia.

Por último, el módulo `Pred.hs` se encarga de revisar dibujos para verificar propiedades de las figuras basicas que conforman un Dibujo cualquiera. También se puede aplicar una función para modificar figuras con cierta propiedad `p` determinada por un predicado. 

2. ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez es un parámetro del tipo?

Esto se hace para permitir la flexibilidad del lenguaje. No importa qué figuras defina un programador como básicas, el lenguaje las va a soportar. De otra manera, el programador estaría limitado a utilizar solo las figuras básicas que el lenguaje provea, lo que limitaría mucho el poder de expresividad del lenguaje.

3. ¿Qué ventaja tiene utilizar una función de `fold` sobre hacer pattern-matching directo?

Al usar `fold`, tenemos más modularidad en el código, ya que solo nos debemos concentrar en la implementación de cada función y nos abstraemos del flujo del programa. Además, mejora la legibilidad del código.  De esta manera, los módulos como `Pred.hs` no acceden al tipo explícito de cada dibujo, en cambio le designan esta tarea a `foldib` y se concentran en lograr su funcionalidad. Asi se evita tener que hacer pattern-matching en varios archivos, generando cierta abstracción del tipo dibujo en los demas módulos que lo utilicen.

## Elementos extra del proyecto

Además de cumplir con los requisitos basicos del proyecto, implementamos la funcionalidad extra de         `--listar`. También agregamos un script llamado `delete.sh`, el cual facilito nuestro trabajo durante el desarrollo al permitirnos borrar los archivos compilados generados por `ghc`.

Es importante destacar que los compilados generados por `ghc` varían según la arquitectura particular en la que se ejecuta el programa. Por lo tanto, es recomendable chequear que los compilados se obtengan en la misma computadora donde se desea ejecutar el programa para evitar posibles errores de compatibilidad.
