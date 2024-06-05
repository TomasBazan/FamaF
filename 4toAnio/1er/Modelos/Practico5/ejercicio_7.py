import math
from random import random
import numpy as np

def F_x_inversa(x):
    return np.exp(x)
def gen_Tinversa():
    U = random()
    return F_x_inversa(U)


def gen_T_rechazo():
    while True:
        Y = random() * (math.e - 1) + 1
        U = random()
        if U <  1 / Y:
            return Y

def ejercicio_c():
    count_exito = 0
    for _ in range(10_000):
        if gen_T_rechazo() <= 2:
            count_exito += 1
    count_exito /= 10_000
    print(f'P(X<= 2) = { count_exito }')
print('Inversa')
acum = 0
for _ in range(10_000):
    acum += gen_Tinversa()
print(f"T inversa {acum/10_000}")
print('Rechazo')
acum = 0
for _ in range(10_000):
    acum += gen_T_rechazo()
print(f"T rechazo {acum/10_000}")
print(f'===============================================')
ejercicio_c()
