from random import random
import numpy as np

#N cajas en servicio, s cajas de repuesto, r cajas descompuestas

def exponencial(lamda):
    U = 1-random()
    return -np.log(U)/lamda

def simular_Tbreak(TF):
    return exponencial(TF)

def simular_TFix(TR):
    return exponencial(TR)

def reparar_una(tiempo_reparacion,r,TR) :
  t = tiempo_reparacion
  r -= 1
  if(r == 0) :
    tiempo_reparacion = np.inf
  elif(r>0) :
    tiempo_reparacion = t + simular_TFix(TR)
  return tiempo_reparacion,r,t

def reparacion2(N,s,TF,TR):
  #inicializacion
  lista_de_eventos = []
  t,r = 0,0
  tiempo_reparacion1 = np.inf
  tiempo_reparacion2 = np.inf
  for _ in range(N) :
    lista_de_eventos.append(simular_Tbreak(TF))
  lista_de_eventos.sort()

  while True:
    if tiempo_reparacion1  <= lista_de_eventos[0] or tiempo_reparacion2 <= lista_de_eventos[0]:
      if tiempo_reparacion1 <= lista_de_eventos[0]:
        # se reparo una sola maquina de parte de alguno de los tecnicos
        if(tiempo_reparacion1 <= lista_de_eventos[0]):
          # termino de reparar tecnico 1
          tiempo_reparacion1,r,t =reparar_una(tiempo_reparacion1,r,TR)
      elif(tiempo_reparacion2 <= lista_de_eventos[0]) :
          # termino de reparar tecnico 2
        tiempo_reparacion2,r,t =reparar_una(tiempo_reparacion2,r,TR)

    elif(lista_de_eventos[0]< tiempo_reparacion1 and lista_de_eventos[0]< tiempo_reparacion2) :
      # Ruptura
      t = lista_de_eventos[0]
      if(r == s) :
        return t
      else :
        lista_de_eventos[0] = t + simular_Tbreak(TF)
        lista_de_eventos.sort()
        if(r == 0) :
          if(tiempo_reparacion1 < tiempo_reparacion2):
            tiempo_reparacion1 = t + simular_TFix(TR)
          else :
            tiempo_reparacion2 = t + simular_TFix(TR)
          r += 1
        else:
          r += 1

def simulacion2(Nsim):
  x = []
  x_cuad = []
  for _ in range(Nsim):
    sim = reparacion2(7, 4, 1, 8)  # Asegúrate de que reparacion esté definida y devuelva un valor numérico
    x.append(sim)
    x_cuad.append(sim**2)

  esperanza = sum(x) / Nsim
  esperanza_x_cuad = sum(x_cuad) / Nsim  # Esto es E[X^2]

  var = esperanza_x_cuad - esperanza**2
  desviacion_estandar = var**0.5

  print(f'Esperanza del tiempo de fallo del sistema: {esperanza}')
  print(f'Desviación Estándar del tiempo de fallo del sistema: {desviacion_estandar}')

simulacion2(10_000)
