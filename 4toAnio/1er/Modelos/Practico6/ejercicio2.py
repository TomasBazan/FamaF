# a) Indique cómo se obtiene mediante simulación el valor de la integral.
# Se estima el valor de la integral como un valor esperado de la funcion evaluada en 
# una variable aleatoria uniforme entre 0 y 1. Luego, por la ley fuerte de los 
# grandes numeros  puedo decir que la sumatoria de las funciones evaluadas en U(0,1) dividido
# por la cantidad de funciones es una estimacion del valor de la integral en 0 y 1.
# En el caso que los limites de integracion no sean 0 y 1 se busca realizar un cambio 
# de variable para que los limites sean 0 y 1.

from random import random
import numpy as np
from time import time

def f(u):
    return np.exp(u) / (np.sqrt(2 * u))

def MonteCarlo_0_1(fun, Nsim):
    Integral = 0
    for _ in range(Nsim):
        Integral += fun(random())
    return Integral/Nsim

# Como la funcion es par puedo trabajar sobre 2 * la integral desde 0 a inf
# y uso el metodo correspondiente
def g(u):
    return 2 * ((1/u -1)**2 * np.exp(-(1/u -1)**2))

def Media_Muestral_X(fun, d):
    'Estimación del valor esperado con ECM<d'
    Media = fun(random())# X(1)
    Scuad, n = 0, 1 #Scuad = Sˆ2(1)
    while n <= 10_000 or np.sqrt(Scuad/n) > d:
        n += 1
        X = fun(random())
        MediaAnt = Media
        Media = MediaAnt + (X - MediaAnt) / n
        Scuad = Scuad * (1 - 1 /(n-1)) + n*(Media - MediaAnt)**2
    return Media

def main():
    tiempo = time()
    print(f'funcion i): { MonteCarlo_0_1(f, 1000) }')
    tiempo =  time() - tiempo
    print(f'Tiempo {tiempo}')

    tiempo = time()
    print(Media_Muestral_X(f,0.01))
    tiempo =  time() - tiempo
    print(f'Tiempo {tiempo}')

    print('===============================================')

    tiempo = time()
    print(f'funcion ii): { MonteCarlo_0_1(g, 1000) }')
    tiempo =  time() - tiempo
    print(f'Tiempo {tiempo}')

    tiempo = time()
    print(Media_Muestral_X(g,0.01))
    tiempo =  time() - tiempo
    print(f'Tiempo {tiempo}')

if __name__ == "__main__":
    main()
