---
---

## 2

### Simulación con un solo operario

#### Variables

**t** = tiempo actual de la simulación.
**r** = cantidad de maquinas rotas.
**s** = cantidad de maquinas de repuesto.
**TF** = parametro lambda para la simulación de una máquina reparada.
**TR** = parametro lambda para la simulación de una máquina rota.
**tiempo_reparacion** = tiempo que tarda en reparar la próxima maquina.
**lista_de_eventos** = lista de todas las rupturas de las maquinas.

#### Aclaraciones

Notar que la distribución del tiempo de ruptura y reparacion de cada máquina tiene una distribución exponencial, y también que llamamos a la funcion con **TR** = 1 y **TF** = 8 ya que nos dan como dato el tiempo medio.

#### Algoritmo

El algoritmo de la simulación primero inicializa **t** y **r** en cero, **tiempo_reparacion** en infinito y **lista_de_eventos** vacía. Luego, se genera un tiempo de ruptura para cada maquina y se los agrega a la **lista_de_eventos** para luego ordenar la **lista_de_eventos** de menor a mayor. (Los tiempos de ruptura son simulados con una exponencial de parametro **TR**).
Luego itero hasta que la misma cantidad de maquinas rotas que de repuesto.
En la iteración tengo dos casos:

- Si el tiempo de reparación es menor al tiempo de ruptura, entonces decrementro en 1 a **r** y seteo el **t** = **tiempo_reparacion**. Si no quedan maquinas rotas **tiempo_reparacion** = infinito, si quedan máquinas rotas **tiempo_reparacion** = **t** + exponencial(TR)
- Si el primer tiempo de ruptura es menor a **tiempo_reparación**, es decir que estoy en el caso en donde se rompió una maquina, seteo **t** = **lista_de_eventos**[0]. Ahora si la cantidad de maquinas rotas es el mismo que la cantidad de maquinas de repuesto, es decir que no puedo reemplazar la maquina que se rompió, devuelvo **t** (tiempo de fallo del sistema). En caso contrario, calculo el tiempo de ruptura para la nueva maquina que entra en servicio, esto es **t + exponencial(TF)** y reordeno nuevamente la lista de eventos (eliminando el primer evento de la lista). Por ultimo incremento **r** en 1, y si es única máquina en reparación calculo el **tiempo_reparacion = t + exponencial(TR)**

---

### Simulación con dos operarios

Para esta simulación, si bien la idea es la misma, tenemos algunas modificaciones.

#### Variables

Cambiamos **tiempo_reparacion** por dos variables **tiempo_reparacion1** y **tiempo_reparacion2** que simulan el tiempo de reparación que le va a llevar a cada operario reparar la próxima máquina que les corresponde a cada uno.

#### Aclaraciones

Modularizamos el código para que sea mas legible, por lo que agregamos dos funciones, ambas tomas los parametros **tiempo_reaparacion1**, **tiempo_reparacion2**, **lista_eventos**, **t**, **r**, **TR**, y la función **actualizar_estado_ruptura** además toma **TF**:

- **actualizar_estado_ruptura:**  Se encarga de manejar el caso donde se repara una maquina. Decrementa **r** en 1, toma como tiempo actual  el mínimo entre los tiempos de reparación de cada operario, y setea el tiempo de reparación del operario en infinito (si no hay maquinas para reparar ó hay una maquina descompuesta que esta siendo arreglada por el otro operario) o en **t + exponencial(TR)** (caso contrario ). Por ultimo devuelve **tiempo_reparacion1, tiempo_reparacion2, t** y **r** con los valores actualizados.
- **actualizar_estado_reparacion:** Se encarga de manejar el caso de que ocurra una ruptura de alguna máquina. Agrega un nuevo tiempo de ruptura a **lista_de_eventos** y lo ordena (eliminando el primer evento de la lista). Si hay más de 1 maquina rota sólo incrementa **r** en 1. Si hay una o dos maquinas rotas elije que operario esta libre y le asigna el tiempo de reparación a el.

#### Algoritmo
Este algoritmo funciona de manera similar al que simula un sólo operario. Con las siguientes diferencias:
La inicialización de los tiempo de reparación se dividen por cada operario.
En  la iteracion tengo dos casos:
- Alguno de los operarios reparo una maquina, en cuyo caso llamo a la funcion **actualizar_estado_reparacion** y actualizo el estado de **tiempo_reparacion1, tiempo_reparacion2, t** y **r** 
- El caso en donde ningún operario reparo una maquina es el caso en donde se rompió una. En este caso seteo el tiempo actual a **lista_de_eventos[0]** y checkeo si tengo la misma cantidad de maquinas descompuesta que maquinas de repuesto, en cuyo caso devuelvo el tiempo actual (Tiempo de fallo de sistema). De lo contrario llamo a la funcion **actualizar_estado_ruptura** y actualizo el estado de las variables **tiempo_reparacion2, tiempo_reparacion2, t ** y **r**.


---

---

