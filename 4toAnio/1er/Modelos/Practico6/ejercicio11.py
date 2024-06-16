from random import random
from scipy.stats import uniform, chi2, binom, expon
import numpy as np


# def simular_muestra_tam_n_binomial(n,probabilidades):
#     N = []
#     prob_acum = 0
#     for i in range(len(probabilidades)):
#         val = binom.rvs(n - sum(N), probabilidades[i] / (1 - prob_acum))
#         N.append(val)
#         prob_acum += probabilidades[i]
#     return N
#
# def calcular_pvalor(n,cant_valores_a_tomar,probabilidades, t_0, N_sim):
#     result = 0
#     for _ in range(N_sim):
#         N_i = []
#         N_i =simular_muestra_tam_n_binomial(n,probabilidades)
#         T = Estadistico(N_i, probabilidades, cant_valores_a_tomar, n)
#         if T >= t_0:
#             result += 1
#     return result/N_sim

# Ejercicio 11. Calcular una aproximación del p−valor de la prueba de que los siguientes datos corresponden
# a una distribución binomial con parámetros (n = 8, p), donde p no se conoce:
# 6, 7, 3, 4, 7, 3, 7, 2, 6, 3, 7, 8, 2, 1, 3, 5, 8, 7.
# E[X] = n p
# E[X] / n = p
# (x_1 + x_2 + ... + x_n)/n^2 = p


def Estadistico(N, p, k, n):
    # N es el array de frecuencias, p es el array de probabilidades, k es la cantidad de valores considerados, n es la cantidad de experimentos
    T = 0.0
    for i in range(k):
        T += ((N[i] - n * p[i]) ** 2) / (n * p[i])
    return float(T)

def Pearson(N,p,n, m):
    # N es el array de frecuencias, p es el array de probabilidades, n cant de experimentos, m es cantidad de parametros estimados
    k = len(N)
    T = Estadistico(N,p,k,n)
    x, df = T, k-1 -m
    return chi2.sf(x,df)

def gen_pi(n, prob):
    p = []
    for i in range(n+1):
        p.append(binom.pmf(i, n, prob))   # i exitos en n ensayos independientes de probabilidad prob
    return p

n_valores = 8
valores_de_muestra = [6, 7, 3, 4, 7, 3, 7, 2, 6, 3, 7, 8, 2, 1, 3, 5, 8, 7]
esp_muestra = sum(valores_de_muestra) / len(valores_de_muestra)
p_estimado = esp_muestra / n_valores
# N es el array de frecuencias N_i calculadas desde la muestra
#    0  1  2  3   4  5  6  7  8
N = [0, 1, 2, 4 , 1, 1, 2, 5, 2]
cantidad_experimentos = sum(N)
lista_probabilidades = gen_pi(n_valores, p_estimado) # lista de probabilidades de <indice> exitos
valor_de_chi_pvalor = Pearson(N,lista_probabilidades,cantidad_experimentos, 1)
print(f'Teorica: valor de chi cuadrado={valor_de_chi_pvalor}')

k = len(lista_probabilidades)
# T = Estadistico(valores_de_muestra,lista_probabilidades,k,n_valores)
# print(T)
# p_valor = calcular_pvalor(cantidad_experimentos, k, lista_probabilidades, T, 10_000)
# print(f'p-valor = {p_valor}')
