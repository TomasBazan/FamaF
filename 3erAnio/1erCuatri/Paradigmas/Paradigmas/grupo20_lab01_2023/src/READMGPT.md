# Paradigmas de la Programacion
## Laboratorio: 1
### Grupo: n°20 "kidvslab"
### Integrantes: 
- Bazan Tomas 
- Carabelos Milagros 
- Pereyra Carrillo Juan

---

####Experiencia General:

Durante el desarrollo del proyecto tuvimos un primer acercamiento al codigo tratando de entender el flujo general y poder imprimir alguna figura. Una vez entendido esto pudimos empezar con la implementación de Dibujo.hs, llegando a una "wall" a la hora de la implementación de foldDib. 

Cuando logramos entender e implementar correctamente esta función el resto del proyecto fue mucho más ameno y rápido en general.

Material utilizado: Documentación de Gloss, Copilot, ChatGPT

---

####Preguntas:

1. ¿Por qué están separadas las funcionalidades en los módulos indicados? Explicar detalladamente la responsabilidad de cada módulo.

En el módulo Dibujo.hs definimos la sintaxis de nuestro DSL, es decir la gramática general de nuestro lenguaje, para no entregar nuestros tipos de datos, lo que entregamos son funciones que traducen a nuestro lenguaje. Luego en Interp.hs vamos a definir nuestra Semántica, es decir la interpretación que le damos a nuestro lenguaje. En este módulo nos encargamos de la aritmética de nuestras imágenes cuando usamos las funciones que exporta Dibujo.hs. Esto se logra gracias a foldDib. Esto sería de la siguiente manera: en un módulo nuevo, creamos nuestras figuras y componemos una Imagen mediante las imágenes definidas en el mismo módulo, usando el lenguaje que nos proporciona Dibujo.hs. Para que el lenguaje tenga una semántica debemos llamar a nuestro intérprete (Interp.hs) donde esta definida que hace cada "operador de nuestro lenguaje", lo logramos llamando a la función interp, que llama a su vez a foldDib para identificar a qué "operadores" nos referimos en cada momento y que interpretación local (en Interp.hs) tenemos para este.

El módulo Main se encarga de la creación de la pantalla donde se proyecta el dibujo, y que dibujo voy a proyectar.

En FloatingPic tenemos las definiciones de algunos tipos que utilizamos en todo el proyecto y la grilla que se imprime en la ventana a modo de referencia.

Por último, el módulo Pred.hs se encarga de revisar dibujos ya hechos para verificar las figuras que conforman un Dibujo cualquiera, también tenemos una función para cambiar dichas figuras por otras.

2. ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez es un parámetro del tipo?

Esto es así para permitir flexibilidad del lenguaje, no importa qué figuras defina un programador como Básicas, el lenguaje las va a soportar. De otra manera, el programador estaría acotado a utilizar solo las figuras Básicas que el lenguaje provea, lo que limitaría mucho el poder de expresividad del lenguaje.

3. ¿Qué ventaja tiene utilizar una función de `fold` sobre hacer pattern-matching directo?
Al usar "fold", tenemos más modularidad en el código, solo nos tenemos que concentrar en la implementación de cada función y nos abstraemos del flujo del programa. Además, mejora la legibilidad del código.
