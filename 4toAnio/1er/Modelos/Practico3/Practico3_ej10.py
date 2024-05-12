from random import random 
import numpy as np
# La v.a X tiene distribucion de probabilidad dada por
# P(X = j) = (1/2)**j+1  +  ((1/2)
# *(2**(j-1)))  /  (3**j)

def g(j) :
  return ((1/2)**(j+1))+((1/2 * 2**j-1)/3**j)

def generar_v_a():
    U = random()
    i = 1
    F = g(i)
    while U >= F:
        i += 1
        F += g(i)
    return i

def esperanza():
    acumulador_esperanza = 0
    i = 0
    for _ in range(100):
        acumulador_esperanza += i * g(i)
        i += 1
    return acumulador_esperanza

acum = 0
N_sim = 1_000
for _ in range(N_sim):
    # print(generar_v_a())
    acum += generar_v_a()

print(f'Esperanza de v.a: E[x] = {acum / N_sim}')
print(f'Esperanza  E[x] = {esperanza()}')
