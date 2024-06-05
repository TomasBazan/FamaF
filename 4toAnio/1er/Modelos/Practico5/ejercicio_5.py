from random import random
import numpy as np

def exponencial(lamda):
    U = random()
    return -np.log(1-U) / lamda


def generar_F_M(parametros):
    variables_aleatorias = []
    for i in parametros:
        variables_aleatorias.append(exponencial(i))
    return np.max(variables_aleatorias)

def generar_F_m(parametros):
    variables_aleatorias = []
    for i in parametros:
        variables_aleatorias.append(exponencial(i))
    return np.min(variables_aleatorias)

F_M_list = []
print(f'F_M(x)')
for _ in range(10):
    F_M_list.append(generar_F_M([1, 2, 3]))
print(F_M_list)
print(f'===============================================')
F_m_list = []
for _ in range(10):
    F_m_list.append(generar_F_m([1, 2, 3]))
print(F_M_list)
