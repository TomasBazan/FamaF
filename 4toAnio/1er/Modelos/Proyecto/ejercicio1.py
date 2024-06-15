from random import random
import numpy as np
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

#N cajas en servicio, s cajas de repuesto, r cajas descompuestas
def exponencial(lamda):
  U = 1-random()
  return -np.log(U)/lamda

def simular_Tbreak(TF):
    return exponencial(TF)

def simular_TFix(TR):
    return exponencial(TR)

def reparacion_1_operario(N,s,TF,TR):

  #inicializacion
  lista_de_eventos = []
  t,r = 0,0
  tiempo_reparacion = np.inf

  for _ in range(N) :
    lista_de_eventos.append(simular_Tbreak(TF))
  lista_de_eventos.sort()

  while(True) :

    if(tiempo_reparacion <= lista_de_eventos[0]):
      # Caso se repara una maquina
      t = tiempo_reparacion
      r -= 1
      if(r == 0) :
        tiempo_reparacion = np.inf
      elif(r>0) :
        tiempo_reparacion = t + simular_TFix(TR)

    elif(lista_de_eventos[0]< tiempo_reparacion) :
      # Caso de ruptura de una maquina
      t = lista_de_eventos[0]
      if(r == s) :
        return t
      else :
        lista_de_eventos[0] = t + simular_Tbreak(TF)
        lista_de_eventos.sort()
        if(r == 0) :
          tiempo_reparacion =  t + simular_TFix(TR)
          r += 1
        else:
          r += 1
      t = lista_de_eventos[0]
      if(r == s) :
        return t
      else :
        lista_de_eventos[0] = t + simular_Tbreak(TF)
        lista_de_eventos.sort()
        if(r == 0) :
          tiempo_reparacion =  t + simular_TFix(TR)
          r += 1
        else:
          r += 1
def simulacion(Nsim):
  x = []
  x_cuad = []
  resultados = []
  for _ in range(Nsim):
    sim = reparacion(7, 4, 1, 8)  # Asegúrate de que reparacion esté definida y devuelva un valor numérico
    x.append(sim)
    x_cuad.append(sim**2)
    resultados.append(sim)

  df = pd.DataFrame(resultados, columns=['Tiempo de Fallo'])
  esperanza = df['Tiempo de Fallo'].mean()
  varianza = df['Tiempo de Fallo'].var()
  desviacion_estandar = df['Tiempo de Fallo'].std()

  mi_esperanza = sum(x) / Nsim
  mi_esperanza_x_cuad = sum(x_cuad) / Nsim  # Esto es E[X^2]

  mi_var = mi_esperanza_x_cuad - mi_esperanza**2
  mi_desviacion_estandar = mi_var**0.5

  print(f'Esperanza del tiempo de fallo del sistema: {mi_esperanza}')
  print(f'Desviación Estándar del tiempo de fallo del sistema: {mi_desviacion_estandar}')
  print(f'Esperanza del tiempo de fallo del sistema: {esperanza}')
  print(f'Desviación Estándar del tiempo de fallo del sistema: {desviacion_estandar}')
  # Crear el histograma
  plt.figure(figsize=(10, 6))
  plt.style.use('seaborn-v0_8')
  plt.hist(df['Tiempo de Fallo'], bins=50, color=Colors[2], alpha=0.7)
  plt.plot(mi_esperanza,mi_desviacion_estandar, color=Colors[0],label="Esperanza", linewidth=0.8)
  texto = f'Esperanza: {mi_esperanza:.2f}\nDesvio Estándar: {mi_desviacion_estandar:.2f}'
    
  # Ajustar los límites de los ejes
  plt.xlim(0, 40)  # Límite del eje x de 0 a 40
  plt.ylim(0, 2000)  # Límite del eje y de 0 a 2000
  plt.text(0.95, 0.95, texto, transform=plt.gca().transAxes,
             fontsize=12, verticalalignment='top', horizontalalignment='right',
             bbox=dict(facecolor='white', alpha=0.5))
  plt.title('Histograma de Tiempos de Fallo del Sistema')
  plt.xlabel('Tiempo de Fallo en Meses')
  plt.ylabel('Frecuencia')
  plt.grid(True)
  plt.show()

simulacion (10_000)
