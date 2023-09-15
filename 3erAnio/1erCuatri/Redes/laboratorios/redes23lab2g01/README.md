# GRUPO 01 
### - Bazan Tomás
### - Carabelos Milagros
### - Pereyra Carrillo Juan Cruz



## Explicación del Código
Nuestro proyecto consta de distintos archivos. `client.py` y `server-tests.py` van a ser omitidos debido a que no hubo realmente modificaciones en ellos. (salvo la actualizacion del codigo a python moderno)

El archivo `server.py` contiene todo lo referido a nuestro servidor. Si desglosamos su código en distintas partes, tenemos lo siguiente:

- Función `main`: Encargada de iniciar la ejecución del servidor, setear variables importantes y checkear errores en el puerto default.
- Clase `Server`: La instancia de nuestro servidor. Al iniciar la instancia de la clase, se cargan algunas variables de clase importantes e iniciamos un socket para el servidor estará escuchando hasta 5 conexiones. También agregamos una pequeña función llamada `_check_for_available_ports` que chequea si el puerto está en uso, y si lo está, prueba con el siguiente hasta encontrar uno que pueda usar. Dentro de la clase, tendremos diferentes funciones claves como `serve` y `handle_client`.
  - Función `serve`: Acepta conexiones y las corre en hilos separados (llamando a `handle_client`). Para esto, utiliza la librería `threading`.
  - Función `handle_client`: Se utiliza como "puente" entre la clase `connection.Connection` y el servidor. En el método `serve`, se usa la librería `threading` para crear un subproceso que ejecuta la función `handle_client`. Cuando la conexión finaliza, la variable `close` se establece en `True`, lo que hace que el bucle `while` que mantiene activos cada uno de los hilos finalice y la función `handle_client` termine su ejecución. Como resultado, el hilo creado por `threading.Thread` finaliza y se elimina correctamente.

El archivo `connection.py` define una clase llamada `Connection`, que representa una conexión punto a punto entre el servidor y un cliente. Su objetivo es satisfacer los pedidos del cliente hasta que se termina la conexión. La clase `Connection` tiene tres métodos:

- Método `_get_buffer_data`: Obtiene los datos del buffer. Para esto, el método recibe como parámetro un socket, y se ejecuta en un ciclo mientras los bytes `\r\n` no estén en los datos. El método devuelve los datos obtenidos.
- Método `_get_command_data`: Chequea errores y obtiene la función a ejecutar. Para esto, el método recibe como parámetros el comando y la cantidad de argumentos. Primero, se obtiene la función correspondiente al comando y se chequea si el comando es válido. Si el comando no es válido, el método devuelve `INVALID_COMMAND`. Si la cantidad de argumentos es incorrecta, el método devuelve `INVALID_ARGUMENTS`. Si todo es correcto, el método devuelve la información del comando y el directorio que utiliza (si es necesario).
- Método `handle`: Atiende eventos de la conexión hasta que termina. Primero, el método obtiene los datos del buffer. Luego, se procesan los datos para obtener el comando y sus argumentos. Se utiliza el método `_get_command_data` para obtener la información del comando y el diretorio que utiliza . Si el comando es inválido, se envía un mensaje de error al cliente. Si los argumentos son inválidos, se envía otro mensaje de error al cliente. Si todo es correcto, se ejecuta la función correspondiente al comando y se envía el resultado al cliente. Si la función indica que se debe cerrar la conexión, se cierra la conexión. 



## Decisiones de Diseño

Hay tres decisiones importantes a destacar 

1. Utilización de threading:

   Decidimos utilizar la estrategia de Multi-threading para manejar múltiples conexiones simultáneas en nuestro servidor. Esta decisión nos permitió evitar problemas de bloqueo de conexión, en los cuales un cliente esperaba a que otro terminara su proceso para poder realizar su petición, lo que ralentizaba significativamente el rendimiento del servidor.

   Además, con Multi-threading, cada hilo se encarga de atender a un cliente específico, lo que nos permitió tener un mayor control sobre el flujo de datos y una mejor gestión de los recursos del servidor.

2. Máximo número de caracteres para nombre de archivo: 

   Decidimos utilizar un número máximo de caracteres para los nombres de los archivos en dos funciones: `get_metadata` y `get_slice`. Esto se debe a que estas funciones utilizan el nombre de un archivo como argumento, pero existe una limitación que debemos tener en cuenta para mantener la rigidez de nuestro sistema.

   La mayoría de los sistemas de archivos modernos tienen un límite de longitud de ruta máxima de 255 caracteres. Esto incluye el nombre del archivo, así como cualquier directorio o ruta de acceso que contenga el archivo. Por lo tanto, decidimos verificar esta condición en el argumento vinculado al nombre del archivo para evitar errores.

3. Modularización:

   Para mejorar el entendimiento del código, decidimos crear un diccionario que mapee los comandos válidos de la conexión y la información relevante de cada uno de ellos. Por ejemplo, la cantidad de argumentos, si cierra o no la conexión, etc. De esta forma, podemos obtener toda la información relevante de una sola vez a través del método `get_command_data` y verificar los errores pertinentes.



## Preguntas y Respuestas

1. ¿Qué estrategias existen para poder implementar este mismo servidor pero con capacidad de atender múltiples clientes simultáneamente? Investigue y responda brevemente qué cambios serían necesario en el diseño del código.

   **Respuesta:**
   
   Existen multiples opciones, entre ellas se destacan las siguientes:
   
    `Multi-threading`: Se pueden crear múltiples hilos en el servidor, cada uno de los cuales se encarga de atender a un cliente específico. De esta forma, se puede atender a múltiples clientes de manera simultánea (actualmente implementada en nuestro código).

   `Multiprocessing`: Es similar a la estrategia anterior, pero en lugar de hilos, se crean múltiples procesos que se encargan de atender a los clientes. Sin embargo, esta estrategia puede incurrir en un costo extra de memoria, ya que cada proceso tiene su propia sección de memoria.

     `Event-driven`: En lugar de utilizar hilos o procesos, se puede utilizar una arquitectura de eventos, en la que se utiliza un bucle de eventos que atiende a los clientes a medida que llegan las solicitudes.
2. Pruebe ejecutar el servidor en una máquina del laboratorio, mientras utiliza el cliente desde otra, hacia la ip de la máquina servidor. ¿Qué diferencia hay si se corre el servidor desde la IP “localhost”, “127.0.0.1” o la ip “0.0.0.0”?

   **Respuesta:**  La diferencia entre correr el servidor desde la IP "localhost", "127.0.0.1" o la IP "0.0.0.0" radica en cómo se accede al servidor desde otros dispositivos en la red.

    - Si se corre el servidor desde la IP "localhost", solo se puede acceder al servidor desde el mismo dispositivo en el que se está ejecutando el servidor.

    - Si se corre el servidor desde la IP "127.0.0.1", se puede acceder al servidor desde cualquier dispositivo en la misma red local, pero solo a través de la dirección IP específica.

    - Si se corre el servidor desde la IP "0.0.0.0", se puede acceder al servidor desde cualquier dispositivo en la red local, a través de la dirección IP del servidor o del nombre de dominio si está disponible.