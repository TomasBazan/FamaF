from random import random
import numpy as np
from scipy.stats import chi2
from scipy.stats import binom

def gen_binomial(n,p):
    return binom.rvs(n, p)

# def simular_muestra_tam_n_binomial(n,probabilidades):
#     count_blanca = gen_binomial(n,probabilidades[0])
#     count_rosas = gen_binomial(n - count_blanca,probabilidades[1] / (1-probabilidades[0]))
#     count_rojas = gen_binomial(n - count_blanca - count_rosas,probabilidades[2]/ (1 - probabilidades[0] - probabilidades[1]))
#     return [count_blanca, count_rosas, count_rojas]

def simular_muestra_tam_n_binomial(n,probabilidades):
    N = []
    prob_acum = 0
    for i in range(len(probabilidades)):
        val = binom.rvs(n - sum(N), probabilidades[i] / (1 - prob_acum))
        N.append(val)
        prob_acum += probabilidades[i]
    return N

def calcular_T(n,cant_valores_a_tomar,probabilidades, t_0, N_sim):
    result = 0
    for _ in range(N_sim):
        N_i = []
        N_i =simular_muestra_tam_n_binomial(n,probabilidades)
        T = 0
        for i in range(cant_valores_a_tomar):
            T += (N_i[i] - n * probabilidades[i])**2 / (n*probabilidades[i])
        result = result + 1 if T>= t_0 else result
    return result/N_sim

valores_a_tomar =   [1      ,2  ,  3 ] # 1-> blanco; 2->rosa ; 3 -> roja
probabilidades =    [0.25   ,0.5,0.25]
n = 564 # cant de guisantes de la muestra
t_0 = 0.8617

T = calcular_T(n, 3, probabilidades,t_0, 10_000)
valor_de_chi = 1 - chi2.cdf(0.8617,2) # o se puede usar chi2.sf(0.8617,2)
print(f'Teorica: valor de chi cuadrado={valor_de_chi}')
print(f'T {T}')
