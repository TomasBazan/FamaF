from random import random
import math 
# Estimar P(Y>2) con lamda = 10 y 1000 repeticiones para var Poisson con
# transformada inversa comun y mejorada

def Poisson(x):
    U = random()
    i = 0; p = math.exp(-x)
    F =p
    while U >= F:
        i += 1
        p *= x / i
        F += p
    return i
def Poisson_mejorado(x):
    p = math.exp(-x);
    F = p
    for j in range(1, int(x) + 1):
        p *= x / j
        F += p
    U = random()
    if U >= F:
        j = int(x) + 1
        while U >= F:
            p *= x / j; F += p
            j += 1
        return j - 1
    else:
        j = int(x)
        while U < F:
            F -= p;
            p *= j/x
            j -= 1
        return j+1

def ejercicio(fun,N_sim):
    count = 0
    for _ in range(N_sim):
        var_aleat = fun(10)
        if var_aleat > 2: count+=1
    print(f'P(Y>2) = {count/N_sim}')

N_sim = 1_000
print('Poisson')
ejercicio(Poisson,N_sim)
print('===================================')
print('Poisson mejorado')
ejercicio(Poisson_mejorado,N_sim)
