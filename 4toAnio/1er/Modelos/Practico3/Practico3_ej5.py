from random import random
from time import time
import numpy as np

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

def binomial(n, p):
    exitos = 0
    for _ in range(n):
        if random() < p:
            exitos += 1
    return exitos

def generar_binomial(func, n, p, cantidad_ensayos):
    print('Metodo transformada inversa:')

    aleatory_vars = []
    for _ in range(cantidad_ensayos):
        aleatory_vars.append(func(n, p))

    most_repeated_value = np.bincount(aleatory_vars).argmax()
    print(f'El valor que mas veces se repitio fue {most_repeated_value} con proporcion {most_repeated_value/cantidad_ensayos}')
    print(f'Proporcion de 0 {aleatory_vars.count(0)/cantidad_ensayos}')
    print(f'Proporcion de 10 {aleatory_vars.count(10)/cantidad_ensayos}')

def main():
    n = 10
    p = 0.3
    cantidad_ensayos = 10_000

    print('A:')
    print('-------------------------------------------------')
    tiempo = time()
    for _ in range(cantidad_ensayos):
        binomial_transformada_inversa(n, p)
    tiempo = time() - tiempo
    print(f'metodo transformada inversa tardo {tiempo}')

    tiempo = time()
    for _ in range(cantidad_ensayos):
        binomial(n, p)
    tiempo = time() - tiempo
    print(f'metodo generando simulando los ensayos {tiempo}')

    print('B:')
    print('-------------------------------------------------')
    print('Metodo transformada inversa:')

    generar_binomial(binomial_transformada_inversa, n, p, cantidad_ensayos)
    print('\t--------------------')
    generar_binomial(binomial, n, p, cantidad_ensayos)

if __name__ == "__main__":
    main()
