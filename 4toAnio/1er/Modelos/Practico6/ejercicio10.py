from random import random
from scipy.stats import uniform, chi2, binom, expon
import numpy as np

# Ejercicio 10. Calcular una aproximación del p−valor de la hipótesis: “Los siguientes 13 valores provienen
# de una distribución exponencial con media 50,0”:
# 86.0, 133.0, 75.0, 22.0, 11.0, 144.0, 78.0, 122.0, 8.0, 146.0, 33.0, 41.0, 99.0

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
        acumulada.append(fun_acumulada(i, scale = 50)) 
    return acumulada

def Estadistico(muestra):
    acumulada_muestral = acumulada_binomial(muestra, expon.cdf) # uso cdf porque es la acumulada
    n = len(acumulada_muestral)
    maximos = []
    for i in range(1,n+1):
        maximos.append(max (((i)/n) - acumulada_muestral[i-1] , acumulada_muestral[i-1] - ((i-1)/n)))
    return max(maximos)

def main():
    muestra = [86.0, 133.0, 75.0, 22.0, 11.0, 144.0, 78.0, 122.0, 8.0, 146.0, 33.0, 41.0, 99.0]
    muestra.sort()
    estadistico_muestral = Estadistico(muestra)
    estimacion_pvalor(len(muestra), 10_000, estadistico_muestral)

if __name__ == "__main__":
    main()
