INFORME : laboratorio 1 Mybash

Grupo 23

Integrantes :

-   Bazan tomas
    
-   Carabelos Milagros
    
-   Pereyra Carrillo Juan Cruz
    
-   Scavuzzo Ignacio
    

  

ÍNDICE

1.  [Como usar mybash](#como-usar-mybash)
2.  [Implementación](#implementaci%C3%B3n) 

2.1 [Bloques](#bloques)

-   [Command](#command)
    

-   [Funciones Extras](#funciones-extras)
    
-   [Librerías](#librer%C3%ADas)
    

-   [Parsing](#parsing)
    
-   [Builtin](#builtin)
    
-   [Execute](#execute)
    

-    [Modularización](#modularizaci%C3%B3n)
    

-   [Mybash](#mybash)

2.2 [Funcionalidades extra](#funcionalidades-extra) 


3.  [Resultado de los tests](#resultado-de-los-tests)
    

-   [Tests de funcionamiento](#tests-de-funcionamiento)
    
-   [Memtest](#memtest)
    

4.  [Organización del trabajo grupal](#organizaci%C3%B3n-del-trabajo-grupal)
    

-  [Calidad del código](#calidad-del-c%C3%B3digo) 
    

  
  
  
  
  

# Como usar mybash

  

Para compilar y poder usar nuestra terminal a partir del código que se encuentra en el [repositorio de bitbucket](https://bitbucket.org/sistop-famaf/so22lab1g23/src/master/) hay que ejecutar dos comandos:

$make

$ ./mybash

make va a ser el encargado de generar todos los archivo objetos (.o) como también de linkear las librerías necesarias para poder correr el ejecutable, este proceso nos da como resultado el ejecutable mybash el cual podemos indicarle a nuestro sistema operativo que comience a correrlo usando ./mybash , notar que lo que estamos haciendo en realidad con ./ es dar la ubicación del archivo para que pueda ser ejecutado, en esta caso la ubicación es el directorio actual.

  

# Implementación

Nuestro código se divide en varios bloques que ayudan a que sea más legible, vamos a explicar el funcionamiento de cada uno de ellos

## Bloques

-   ### Command
    

En este módulo se encuentran las estructuras de datos básicas sobre las cuales vamos a montar todo el proyecto este bloque define dos estructuras muy importantes:

  

- scommand es la estructura que usamos para guardar la información de un comando simple con sus argumentos y archivos de entraba y/o salida, esta estructura está dada por:

-   una lista de string donde guardar el comando y sus argumentos.
    
-   dos punteros a string que guardan los nombres de los archivos de entrada y salida respectivamente.
    

  

- pipeline esta estructura se encarga de recopilar los comandos simples a ejecutar que se conectan mediante tuberías (pipe) como también si corren o no en background (&), esta estructura está formada por:

- una lista de comandos simples a ejecutar

- un booleano que nos informa si se encontró o no un &

#### Funciones extras

Además de las funciones que se especifican en el kickstart decidimos agregar 2 extra

  

scommand_get_argument: esta función nos permite acceder a cualquier elemento de la lista mediante un índice, fue diseñada para facilitar la implementación de la siguiente función.

  

scommand_to_array: esta función nos permite transformar la lista de un scommand en un array de strings, es especialmente útil cuando queremos utilizar la syscall execvp en el módulo execute que veremos más adelante.

  

#### Librerías

Para implementar estas estructuras nos valimos de las librerías

-   GLib para utilizar el tad GList que son básicamente listas doblemente enlazadas. Lo interesante de esta librería es que el tipo GList es polimórfico, por eso pudimos utilizarlo tanto para la lista de el comando y argumentos en scommand como para la lista de scommands en pipeline.
    
-   string que es la librería de string de C y nos ayudó para implementar las funciones scommand_to_string y pipeline_to_string, más específicamente otorgandonos una forma fácil de pedir memoria para los string necesarios a través de la función strdup.
    

  

-   ### Parsing
    

Este bloque se dedica al parseo de lo recibido mediante el módulo parser (implementado por la cátedra) su funcionamiento consta básicamente en utilizar las funciones de parser.h para interpretar el texto que se recibe desde la terminal y se guarda en una variable del tipo parser para poder reestructurar la información usando las estructuras previamente definidas en el bloque command.

No hay nada demasiado interesante que destacar de este módulo pero nuevamente utilizamos la librería de string para valernos de strdup para pedir memoria para los string necesarios

-   ### Builtin
    

Este módulo se encarga de ejecutar los comandos internos que no requieren de las syscalls a fork ni execvp, nuevamente no hay ninguna decisión muy importante de diseño o implementación extra en este módulo. Aqui se implemento cd, que cambia de directorio mediante una llamada a la syscall chdir la cual cambia de directorio, help, que muestra un texto de ayuda en pantalla, y exit, que permite la salida de mybash de manera limpia.

  

-   ### Execute
    

Este es el módulo más importante del proyecto es el encargado de tomar toda la información parseada y organizada por los módulos anteriores y efectivamente utilizar las llamadas fork y execvp para crear los procesos que harán funcionar a nuestra terminal.

  

#### Modularización

Para no sobrecargar la única función de execute y facilitar su lectura decidimos crear pequeñas funciones que ayudan a la ejecución final estas son:

  

execute_internal: si el comando es interno se encarga de ejecutarlo mediante el bloque builtin.

redir_in: setea el file descriptor que servirá como entrada al proceso, si el archivo no existe devuelve un error.

redir_out: setea el file descriptor que servirá como salida al proceso, si el archivo no existe lo crea y le otorga permisos de lectura y escritura para poder sobrescribir o bien imprimirlo en la terminal posteriormente mediante cat.

execute_scommand: si el comando recibido no se comunica con otros mediante un pipe lo ejecuta creando los procesos necesarios.

execute_multiple_command: si hay más de un comando simple a ejecutar y existe una comunicación entre ellos mediante una tubería esta función se encarga de su correcta ejecución creando los procesos necesarios.

  

De esta manera la función principal solo se encarga de elegir qué función de las anteriores debe usar y llamarlas con los argumentos necesarios .

  

-   ### Mybash
    

En este bloque se encuentra la función main que utiliza directamente el módulo execute, también chequeamos en este bloque si el parseo inicial del texto escrito por la terminal corresponde a un EOF (end of file), esta señal nos avisa que el usuario a utilizado la combinación de teclas control + D y por lo tanto nuestro programa debe terminar. Además, decidimos modificar el prompt para que muestre información relevante. En este caso, el directorio actual el cual lo obtenemos con la función getcwd y se lo asignamos a un arreglo de chars, primero por el tipo de parámetros que toma getcwd y segundo para que quede en stack y no se utilice memoria dinámica.

## Funcionalidades extra
Sobre los puntos estrella, pudimos modificar el prompt para que muestre el directorio actual e implementar el comando secuencial && para que se ejecute el siguiente comando solo si el primero resulta exitoso (para lo cual modificamos la estructura del pipeline para que tenga otro campo de tipo booleano que indique si hay un símbolo extra &, agregamos funciones que modifiquen el campo y se hicieron modificaciones en el parsing y execute agregando la función execute_secuential_commands).

# Resultado de los tests

## Tests de funcionamiento

Tanto al correr el test normal como los test-command y test-parsing obtenemos  
100%: Failures: 0, Errors: 0

## Memtest

En este test tenemos bastantes bloques que aparecen como still reachable pero podemos observar que este problema reside en la elección de la librería Glib.

  

# Organización del trabajo grupal

Para organizarnos en la primera parte del laboratorio cuando las tareas eran más simples dividimos el trabajo en grupos de a dos para que sea más fácil trabajar pero a la vez que nadie se encargará solo de un módulo y así tuviera con quien discutir los problemas y demás imprevistos, luego intentamos conectarnos a alguna llamada y ayudarnos entre todos con los errores y leaks que íbamos detectando mediante los test. En cuanto a la implementación de execute y arreglo de errores/leaks finales el trabajo fue totalmente conjunto tanto estando físicamente reunidos como mediante meets y llamadas en discord, si bien no podemos conectarnos a trabajar al mismo tiempo siempre realizamos reuniones para ponernos al día entre nosotros y ayudarnos con los problemas que nos surgían a cada uno.

  

## Calidad del código

Para mantener un código uniforme, prolijo y robusto, hacemos uso de la indentación y mantuvimos un estilo similar entre los integrantes. Para la parte de robustez, nos aseguramos de en los TADs chequear todas las pre y pos condiciones con asserts y en el resto del código, no solo con assert, sino que también verificando que las syscalls no devolvieran error (chdir devolviendo -1 por ejemplo). Por otro lado también tratamos de modularizar lo más posible y de comentar código no tan explícito para que sea legible como también dar nombres informativos a las variables y de usar variables globales para que no haya números sueltos.

  

Links a destacar

[División de tareas](https://miro.com/app/board/uXjVPcn1k18=/?share_link_id=635177705461)

[Updates por fecha](https://docs.google.com/document/d/1970EUh5jpExFCAM8peJnbo2FX8zSUvGWKQBoJ5QixJw/edit)

