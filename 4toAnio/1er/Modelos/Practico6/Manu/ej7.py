from scipy.stats import chi2, binom
import numpy as np

def pvalor_chi2(N, P, n, k):
    ''' N frecuencias, P probabilidades de F teorica, n tamaño muestra, k valores que toma la variable
    '''
    t = 0
    for i in range(k):
        t += ((N[i] - n * P[i]) ** 2) / (n * P[i])
    pvalor = 1 - chi2.cdf(t, k-1)
    return pvalor

def t_estadistico(N, P, n, k):
    ''' N frecuencias, P probabilidades de F teorica, n tamaño muestra, k valores que toma la variable
    '''
    t = 0
    for i in range(k):
        t += ((N[i] - n * P[i]) ** 2) / (n * P[i])
    return t

def pvalor_sim(Nsim, P, n, k, t_valor):
    ''' Nsim numeros de simulaciones, P probabilidades de F teorica, n tamaño muestra, 
        k valores que toma la variable, t_valor de la muestra original
    '''
    N = np.zeros(k, int)    # Frecuencias observadas
    pvalor = 0
    for _ in range(Nsim):
        # Calculo las frecuencias observadas
        n_rest = n
        p_acum = 0
        for j in range(k):
            p_rest = P[j] / (1 - p_acum)
            N[j] = binom.rvs(n_rest, p_rest)
            n_rest = n_rest - N[j] if N[j] < n_rest else 0
            p_acum += P[j]
        # Calculo el valor t_i
        t_i = 0
        for i in range(k):
            t_i += ((N[i] - n * P[i]) ** 2) / (n * P[i])
        # Verifico si es mayor al t_valor
        if (t_i >= t_valor):
            pvalor += 1
    return pvalor/Nsim

pvalor = pvalor_chi2([141, 291, 132], [1/4, 1/2, 1/4], 564, 3)
print(f"Usando la aproximacion de chi-cuadrada tenemos que el p-valor es {pvalor}")

t_valor = t_estadistico([141, 291, 132], [1/4, 1/2, 1/4], 564, 3)
pvalorsim = pvalor_sim(10000, [1/4, 1/2, 1/4], 564, 3, t_valor)
print(f"Usando simulaciones tenemos que el p-valor es {pvalorsim}")