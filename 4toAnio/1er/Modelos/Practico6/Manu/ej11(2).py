
import numpy as np
from scipy.stats import binom, chi2
from random import random


def gen_pi(n, prob):
    p = []
    for i in range(n+1):
        p.append(binom.pmf(i, n, prob))   # i exitos en n ensayos independientes de probabilidad prob
    return p

# Función para calcular el estadístico


def Estadistico(N, p, k, n):
    T = 0.0
    for i in range(k):
        T += ((N[i] - n * p[i]) ** 2) / (n * p[i])
    return float(T)

# Prueba de Pearson


def Pearson(N, p, n, m):
    k = len(N)
    T = Estadistico(N, p, k, n)
    x, df = T, k-1-m
    # probabilidad de que la chicuadrada de k-1 grados de libertad sea >= a T
    return chi2.sf(x, df)


def generar_N(p, k, n):
    Nsimulado = []
    acum = 0.0
    for i in range(k - 1):
        prob = p[i + 1] / (1 - acum)
        Nsimulado.append(binom.rvs(n - sum(Nsimulado), prob))
        acum += p[i]
    Nsimulado.append(n - sum(Nsimulado))
    return Nsimulado


def pvalor_sim(N, p, n, Nsim):
    k = len(N)

    # Estadístico observado
    t_0 = Estadistico(N, p, k, n)

    pval = 0
    for _ in range(Nsim):
        # Generar Nsimulado
        Nsimulado = generar_N(p, k, n)

        # Calcular el estadístico simulado
        t_simulado = Estadistico(Nsimulado, p, k, n)

        # Comparar con el estadístico observado
        if t_simulado >= t_0:
            pval += 1

    return pval / Nsim


muestra = [6, 7, 3, 4, 7, 3, 7, 2, 6, 3, 7, 8, 2, 1, 3, 5, 8, 7]
muestra.sort()
print(muestra)
# N es el array de frecuencias N_i calculadas desde la muestra
N = [0, 1, 2, 4, 1, 1, 2, 5, 2]

numero_de_experimentos = sum(N)
# parametro de la binomial
n = 8
# necesito encontrar una estimacion para el parametro prob_exito = ?
# para la muestra un buen estimador de la esperanza es el promedio por lo tanto
esp = sum(muestra) / len(muestra)
# sabemos que la esperanza de una binomial esp(x) = n * p luego p= esp(x)/n
prob = esp/n
print(prob)
p = gen_pi(n, prob) # los p_i
print(p)

Nsim = 10_000
print(f'pval con metodo pearson = {Pearson(N,p,numero_de_experimentos,1)}')
print(f'pval con simulaciones = {pvalor_sim(N, p, n, Nsim)}')
