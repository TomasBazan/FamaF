from random import random
import numpy as np

# N cajas en servicio, s cajas de repuesto, r cajas descompuestas

def exponencial(lamda):
    U = 1 - random()
    return -np.log(U) / lamda

def simular_Tbreak(TF):
    return exponencial(TF)

def simular_TFix(TR):
    return exponencial(TR)

def actualizar_estado_ruptura(tiempo_reparacion1, tiempo_reparacion2,lista_de_eventos, t, r, TR, TF):
    lista_de_eventos[0] = t + simular_Tbreak(TF)
    lista_de_eventos.sort()
    if r == 0 or r == 1:
        if tiempo_reparacion1 == np.inf:
            tiempo_reparacion1 = t + simular_TFix(TR)
        elif tiempo_reparacion2 == np.inf:
            tiempo_reparacion2 = t + simular_TFix(TR)
        elif tiempo_reparacion1 < tiempo_reparacion2:
            tiempo_reparacion1 = t + simular_TFix(TR)
        else:
            tiempo_reparacion2 = t + simular_TFix(TR)
        r += 1
    else:
        r += 1
    return tiempo_reparacion1, tiempo_reparacion2, t, r

def actualizar_estado_reparacion(tiempo_reparacion1, tiempo_reparacion2, lista_de_eventos, t, r, TR):
    # Reviso cual de los operarios reparo una maquina, disminuyo las maquinas descompuestas y
    # actualizo el tiempo al tiempo de reparacion.
    r -= 1
    t = min(tiempo_reparacion1, tiempo_reparacion2)
    if tiempo_reparacion1 <= lista_de_eventos[0]:
        if r == 0 or (r == 1 and tiempo_reparacion2 != np.inf): # Si no tengo maquinas para reparar o si el otro operario esta reparando una maquina
            tiempo_reparacion1 = np.inf
        elif r > 0:
            tiempo_reparacion1 = t + simular_TFix(TR)
    elif tiempo_reparacion2 <= lista_de_eventos[0]:
        if r == 0 or (r == 1 and tiempo_reparacion1 != np.inf):
            tiempo_reparacion2 = np.inf
        elif r > 0:
            tiempo_reparacion2 = t + simular_TFix(TR)
    return tiempo_reparacion1, tiempo_reparacion2, t, r

def reparacion2(N, s, TF, TR):
    # Inicializacion
    lista_de_eventos = []
    t, r = 0, 0
    tiempo_reparacion1 = np.inf # Tiempo de reparacion del operario 1
    tiempo_reparacion2 = np.inf # Tiempo de reparacion del operario 2
    for _ in range(N):
        lista_de_eventos.append(simular_Tbreak(TF))
    lista_de_eventos.sort()

    while True:
        if tiempo_reparacion1 <= lista_de_eventos[0] or tiempo_reparacion2 <= lista_de_eventos[0]: # Si algun operario esta reparando una maquina
            # Caso se repara alguna maquina
            tiempo_reparacion1, tiempo_reparacion2, t, r = actualizar_estado_reparacion(tiempo_reparacion1, tiempo_reparacion2, lista_de_eventos, t, r, TR)

        elif tiempo_reparacion1 > lista_de_eventos[0] or tiempo_reparacion2 > lista_de_eventos[0]:
            # Caso de ruptura de alguna maquina
            t = lista_de_eventos[0]
            if r == s: # No tengo mas maquinas de repuesto
                return t
            else: # Tengo maquinas de repuesto, veo a que operario asignarle la reparacion
                tiempo_reparacion1, tiempo_reparacion2, t, r = actualizar_estado_ruptura(tiempo_reparacion1, tiempo_reparacion2, lista_de_eventos, t, r, TR, TF)

def simulacion2(Nsim):
    x = []
    x_cuad = []
    for _ in range(Nsim):
        sim = reparacion2(7, 3, 1, 8)  # Asegúrate de que reparacion esté definida y devuelva un valor numérico
        x.append(sim)
        x_cuad.append(sim**2)

    esperanza = sum(x) / Nsim
    esperanza_x_cuad = sum(x_cuad) / Nsim  # Esto es E[X^2]

    var = esperanza_x_cuad - esperanza**2
    desviacion_estandar = var**0.5

    print(f'Esperanza del tiempo de fallo del sistema: {esperanza}')
    print(f'Desviación Estándar del tiempo de fallo del sistema: {desviacion_estandar}')

simulacion2(10000)
