from random import random
import numpy as np

def F_x(x):
    return (x**(3+1)) / (3+1)


def generar_F_M(parametros):
    variables_aleatorias = []
    for i in parametros:
        variables_aleatorias.append(F_x(i))
    return np.max(variables_aleatorias)

def generar_F_m(parametros):
    variables_aleatorias = []
    for i in parametros:
        variables_aleatorias.append(F_x(i))
    return np.min(variables_aleatorias)

def generar_metodo_1():
    while True:

        Y = generar_F_M([1, 2, 3]);
        U = random()
        if U < p(Y) / (c * q(Y)):
            return Y
