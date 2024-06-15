from random import random
import numpy as np
from collections import Counter
from scipy.stats import mode
import pandas as pd
import matplotlib.pyplot as plt


Colors = [
    (0.537, 0.769, 0.933),  # Light Blue
    (0.247, 0.443, 0.698),  # Blue
    (0.694, 0.298, 0.694),  # Purple
    (0.933, 0.537, 0.933),  # Violet
    (0.941, 0.502, 0.502),  # Coral
    (0.957, 0.643, 0.376),  # Orange
    (0.933, 0.831, 0.306),  # Yellow
    (0.847, 0.576, 0.439)   # Tan
]

def exponencial(lamda):
    U = 1 - random()
    return -np.log(U) / lamda

def simular_Tbreak(TF):
    return exponencial(TF)

def simular_TFix(TR):
    return exponencial(TR)

def reparacion_1_operario(N, s, TF, TR):
    # Inicializacion
    lista_de_eventos = []
    t, r = 0, 0
    tiempo_reparacion = np.inf

    for _ in range(N):
        lista_de_eventos.append(simular_Tbreak(TF))
    lista_de_eventos.sort()

    while(True):

        if tiempo_reparacion <= lista_de_eventos[0]:
            # Caso se repara una maquina
            t = tiempo_reparacion
            r -= 1
            if r == 0:
                tiempo_reparacion = np.inf
            elif r > 0:
                tiempo_reparacion = t + simular_TFix(TR)

        elif lista_de_eventos[0] < tiempo_reparacion:
            # Caso de ruptura de una maquina
            t = lista_de_eventos[0]
            if r == s:
                return t
            else:
                lista_de_eventos[0] = t + simular_Tbreak(TF)
                lista_de_eventos.sort()
                if r == 0:
                    tiempo_reparacion = t + simular_TFix(TR)
                    r += 1
                else:
                    r += 1


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

def actualizar_estado_ruptura(tiempo_reparacion1, tiempo_reparacion2,lista_de_eventos, t, r, TR, TF):
    lista_de_eventos[0] = t + simular_Tbreak(TF)
    lista_de_eventos.sort()
    if r == 0 or r == 1:
        if tiempo_reparacion1 == np.inf:
            tiempo_reparacion1 = t + simular_TFix(TR)
        else:
            tiempo_reparacion2 = t + simular_TFix(TR)
        r += 1
    else:
        r += 1
    return tiempo_reparacion1, tiempo_reparacion2, t, r

def reparacion_2_operarios(N, s, TF, TR):
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

        elif tiempo_reparacion1 > lista_de_eventos[0] and tiempo_reparacion2 > lista_de_eventos[0]:
            # Caso de ruptura de alguna maquina
            t = lista_de_eventos[0]
            if r == s: # No tengo mas maquinas de repuesto
                return t
            else: # Tengo maquinas de repuesto, veo a que operario asignarle la reparacion
                tiempo_reparacion1, tiempo_reparacion2, t, r = actualizar_estado_ruptura(tiempo_reparacion1, tiempo_reparacion2, lista_de_eventos, t, r, TR, TF)


def simulacion_ejercicio1(Nsim):
    x = []
    x_cuad = []
    resultados = []
    for _ in range(Nsim):
        sim = reparacion_1_operario(7, 4, 1, 8)  # Asegúrate de que reparacion esté definida y devuelva un valor numérico
        x.append(sim)
        x_cuad.append(sim**2)
        resultados.append(sim)

    df = pd.DataFrame(resultados, columns=['Tiempo de Fallo'])
    max_tiempo_fallo = max(resultados)
    min_tiempo_fallo = min(resultados)

    esperanza = sum(x) / Nsim
    esperanza_x_cuad = sum(x_cuad) / Nsim  # Esto es E[X^2]

    var = esperanza_x_cuad - esperanza**2
    desviacion_estandar = var**0.5

    print(f'Esperanza del tiempo de fallo del sistema: {esperanza}')
    print(f'Desviación Estándar del tiempo de fallo del sistema: {desviacion_estandar}')
    print(f'Maximo tiempo de fallo: {max_tiempo_fallo}')
    print(f'Minimo tiempo de fallo: {min_tiempo_fallo}')
    # Crear el histograma
    plt.figure(figsize=(10, 6))
    plt.style.use('seaborn-v0_8')
    plt.hist(df['Tiempo de Fallo'], bins=50, color=Colors[2], alpha=0.7)
    plt.plot(esperanza,desviacion_estandar, color=Colors[0],label="Esperanza", linewidth=0.8)

    # Ajustar los límites de los ejes
    plt.xlim(0, 40)  # Límite del eje x de 0 a 40
    plt.ylim(0, 2000)  # Límite del eje y de 0 a 2000

    texto = f'Esperanza: {esperanza:.2f}\nDesvio Estándar: {desviacion_estandar:.2f} \nMáximo tiempo de fallo: {max_tiempo_fallo:.2f}\nMínimo tiempo de fallo: {min_tiempo_fallo:.2f}'
    plt.text(0.95, 0.95, texto, transform=plt.gca().transAxes,
                fontsize=12, verticalalignment='top', horizontalalignment='right',
                bbox=dict(facecolor='white', alpha=0.5))
    plt.title('Histograma de Tiempos de Fallo del Sistema')
    plt.xlabel('Tiempo de Fallo en Meses')
    plt.ylabel('Frecuencia')
    plt.grid(True)
    plt.show()



def simulacion_ejercicio2(Nsim):
    x = []
    x_cuad = []
    resultados = []
    for _ in range(Nsim):
        sim = reparacion_2_operarios(7, 3, 1, 8)
        x.append(sim)
        x_cuad.append(sim**2)
        resultados.append(sim)

    df = pd.DataFrame(resultados, columns=['Tiempo de Fallo'])
    # Cálculo de estadísticas
    max_tiempo_fallo = max(resultados)
    min_tiempo_fallo = min(resultados)
    esperanza = sum(x) / Nsim
    esperanza_x_cuad = sum(x_cuad) / Nsim 
    var = esperanza_x_cuad - esperanza**2
    desviacion_estandar = var**0.5

    # Imprimir resultados
    print(f'Esperanza del tiempo de fallo del sistema: {esperanza}')
    print(f'Desviación Estándar del tiempo de fallo del sistema: {desviacion_estandar}')
    print(f'Maximo tiempo de fallo: {max_tiempo_fallo}')
    print(f'Minimo tiempo de fallo: {min_tiempo_fallo}')

    # Crear el histograma
    plt.figure(figsize=(10, 6))
    plt.style.use('seaborn-v0_8')
    plt.hist(df['Tiempo de Fallo'], bins=50, color=Colors[2], alpha=0.7)

    # Ajustar los límites de los ejes
    plt.xlim(0, 40)
    plt.ylim(0, 2000)

    texto = f'Esperanza: {esperanza:.2f}\nDesvio Estándar: {desviacion_estandar:.2f} \nMáximo tiempo de fallo: {max_tiempo_fallo:.2f}\nMínimo tiempo de fallo: {min_tiempo_fallo:.2f}'
    plt.text(0.95, 0.95, texto, transform=plt.gca().transAxes,
                fontsize=12, verticalalignment='top', horizontalalignment='right',
                bbox=dict(facecolor='white', alpha=0.5))

    plt.title('Histograma de Tiempos de Fallo del Sistema')
    plt.xlabel('Tiempo de Fallo')
    plt.ylabel('Frecuencia')
    plt.grid(True)
    plt.show()

def main():
    print('Ejercicio 1')
    simulacion_ejercicio1(10_000)
    print('------------------------------------')
    print('Ejercicio 2')
    simulacion_ejercicio2(10000)

if __name__ == '__main__':
    main()
