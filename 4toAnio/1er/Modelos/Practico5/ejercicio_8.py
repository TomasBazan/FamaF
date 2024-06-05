from random import random
import numpy as np

def gen_X_sum_uniformes():
    return random() + random()

def gen_X_T_inversa():
    U = random()
    if U < 0.5:
        return np.sqrt(2*U)
    else:
        return - np.sqrt(-2 * U + 2) + 2

def Aceptacion_Rechazo_X():
    while 1:
        # Simular Y
        Y = random() * 2
        U = random()
        if Y <=1:
            if U < Y:
                return Y
        else: 
            if U < 2 - Y:
                return Y

def ejercicio_c(fun):    
    N_sim = 10_000
    val = 0
    media = 0
    exitos = 0
    candidatos = []
    for _ in range(N_sim):
        val = fun()
        media += val
        if val > 1.5:
            candidatos.append(val)
            exitos += 1

    print(f'X_0 es : {np.min(candidatos)}')
    return (media / N_sim, exitos / N_sim)

print('Suma de uniformes')
(val, prom) = ejercicio_c(gen_X_sum_uniformes)
print(f'Valor esperado: {val}; P(X>1.25) = {prom}')
print('=================')

print('Inversa')
(val, prom) = ejercicio_c(gen_X_T_inversa)
print(f'Valor esperado: {val}; P(X>1.25) = {prom}')
print('=================')

print('Aceptacion y rechazo')
(val, prom) = ejercicio_c(Aceptacion_Rechazo_X)
print(f'Valor esperado: {val}; P(X>1.25) = {prom}')
print('=================')

print(f'Esperanza TEORICA {1/2 + 1/2}')
print(f'P(X > 1.5) TEORICA = {0.125}')
