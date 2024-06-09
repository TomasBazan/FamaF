from random import random
import numpy as np
from scipy.stats import chi2
from scipy.stats import binom

# Esta esta bien
def Estadistico(N,p,k,n):
    T = 0
    for i in range(k):
        T += ((N[i] - n*p[i])**2) / (n*p[i])
    return T

def Pearson(N,p,n):
    k = len(N)
    T = Estadistico(N,p,k,n)
    x, df = T, k-1
    return chi2.sf(x,df)
# Esta esta bien
def simular_muestra_tam_n_binomial(n,probabilidades):
    N = []
    prob_acum = 0
    for i in range(len(probabilidades)):
        val = binom.rvs(n - sum(N), probabilidades[i] / (1 - prob_acum))
        N.append(val)
        prob_acum += probabilidades[i]
    return N

def calcular_pvalor(n,cant_valores_a_tomar,probabilidades, t_0, N_sim):
    result = 0
    for _ in range(N_sim):
        N_i = []
        N_i =simular_muestra_tam_n_binomial(n,probabilidades)
        T = Estadistico(N_i, probabilidades, cant_valores_a_tomar, n)
        if T >= t_0:
            result += 1
    return result/N_sim

n_valores = 1000
probabilidades = [1/6] * 6
valores_obtenidos = [158,172,164,181,160,165]
array_T = []

valor_de_chi_pvalor = Pearson(valores_obtenidos,probabilidades,n_valores)
T = Estadistico(valores_obtenidos,probabilidades,len(probabilidades),n_valores)

print(f'Teorica: valor de chi cuadrado={valor_de_chi_pvalor}')

p_valor = calcular_pvalor(n_valores, 6 , probabilidades, T, 10_000)
print(f'p-valor = {p_valor}')

