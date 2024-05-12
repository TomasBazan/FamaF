from random import random
import numpy as np

def exponencial(lamda):
    U = 1-random()
    return -np.log(U)/lamda

def generar_v_a(probabilidad , fun, **params):
    U = random() 
    if U <= probabilidad:
        return fun(**params)
    return 0
def estimar_esperanza(probabilidad, N_sim, lamda):
    acum = 0
    for _ in range(N_sim):
        acum += generar_v_a(probabilidad, exponencial, lamda = lamda)
    return acum/N_sim

N_sim = 10_000
E_1 = estimar_esperanza(0.5, N_sim, lamda = 1/3)
E_2 = estimar_esperanza(0.3, N_sim, lamda = 1/5)
E_3 = estimar_esperanza(0.2, N_sim, lamda = 1/7)


print(f'Esperanza estimada {E_1 +E_2 +E_3}' )
print(f'Esperanza estimada {4.4}')

