from random import random
import numpy as np
import math

def binomial_transformada_inversa(n, p):
    c = p / (1 - p)
    prob = (1 - p) ** n
    F = prob;
    i=0
    U = random()
    while U >= F:
        prob *= c * (n-i) / (i+1)
        F += prob
        i += 1
    return i

def generar_var_aleat_X_I():
    U = random()
    if U < 0.35:    return 3
    elif U < 0.55:  return 4
    elif U < 0.75:  return 1
    elif U < 0.90:  return 0
    else:           return 2

probabilidades = [0.15,0.2,0.1,0.35,0.2]
q = []
for i in range(len(probabilidades)):
    prob = (math.comb(4,i))*(probabilidades[i]**i)*(1-probabilidades[i])**(4-i)
    q.append(prob)
def generar_var_aleat_X_II():
    while True:
        y = binomial_transformada_inversa(4, 0.45)
        u = random()
        if u < probabilidades[y] / (4.88 * q[y]):
            return y

ceros = 0
unos = 0
dos = 0
tres = 0
cuatros = 0
for i in range(10_000):
    val = generar_var_aleat_X_I()
    if val==4:
        cuatros +=1
    elif val == 3:
        tres +=1
    elif val == 2:
        dos +=1
    elif val == 1:
        unos +=1
    elif val == 0:
        ceros +=1
    else:
        print(f'error en simulacion')
        break
print(f'ceros: {ceros/10_000}')
print(f'unos: {unos/10_000}')
print(f'dos: {dos/10_000}')
print(f'tres: {tres/10_000}')
print(f'cuatros: {cuatros/10_000}')
print(f'suma de prob {(ceros+unos+dos+tres+cuatros)/10_000}')
print('\n--------------------------------------------------\n')
ceros = 0
unos = 0
dos = 0
tres = 0
cuatros = 0
for i in range(10_000):
    val = generar_var_aleat_X_II()
    if val==4:
        cuatros +=1
    elif val == 3:
        tres +=1
    elif val == 2:
        dos +=1
    elif val == 1:
        unos +=1
    elif val == 0:
        ceros +=1
    else:
        print(f'error en simulacion')
        break
print(f'ceros: {ceros/10_000}')
print(f'unos: {unos/10_000}')
print(f'dos: {dos/10_000}')
print(f'tres: {tres/10_000}')
print(f'cuatros: {cuatros/10_000}')
print(f'suma de prob {(ceros+unos+dos+tres+cuatros)/10_000}')

