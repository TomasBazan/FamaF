from random import random
from scipy.stats import uniform, chi2, binom
import numpy as np


def estimacion_pvalor(n, Nsim, d_KS):
    # n tam de cada muestra, d_KS estadistico
    pvalor = 0.
    for _ in range(Nsim):
        uniformes = np.random.uniform(0,1,n)
        uniformes.sort()
        d_j= 0
        for j in range(n):
            u_j = uniformes[j]
            d_j = max(d_j, (j + 1) / n-u_j, u_j - j / n)
        if d_j >= d_KS:
            pvalor += 1
    print(pvalor/Nsim)

def acumulada_binomial(muestra, fun_acumulada):
    acumulada = []
    for i in muestra:
        acumulada.append(fun_acumulada(i)) 
    return acumulada


def Estadistico(muestra):
    acumulada_muestral = acumulada_binomial(muestra, uniform.cdf)
    n = len(acumulada_muestral)
    maximos = []
    for i in range(n):
        maximos.append(max (((i+1)/n) - acumulada_muestral[i] , acumulada_muestral[i] - (i/n)))
    return max(maximos)

muestra = [0.12, 0.18, 0.06, 0.33, 0.72, 0.83, 0.36, 0.27, 0.77, 0.74]
muestra.sort()
estadistico_muestral = Estadistico(muestra)
estimacion_pvalor(len(muestra), 10_000, estadistico_muestral)
