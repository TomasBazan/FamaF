from random import random
import numpy as np
from scipy.stats import chi2
from scipy.stats import binom

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

n_valores = 539
probabilidades =    [0.22,0.2,0.19,0.12,0.09,0.08,0.07,0.02,0.01]
valores_obtenidos = [120 ,114,92  ,85  ,34  ,33  ,45  ,11  ,   5]

valor_de_chi_pvalor = Pearson(valores_obtenidos,probabilidades,n_valores)
T = Estadistico(valores_obtenidos,probabilidades,len(probabilidades),n_valores)

print(f'Teorica: valor de chi cuadrado={valor_de_chi_pvalor}')

p_valor = calcular_pvalor(n_valores, len(probabilidades) , probabilidades, T, 10_000)
print(f'p-valor = {p_valor}')

print( '+++++++++++++++++++++++++++++++++++++++++++++++++++++++')




def calcula_proporcion(Nsim):
    enCirculo = 0.
    for _ in range(Nsim):
        u = 4 * random() - 2
        v = 2 * random() - 1
        if (u/2)**2 + v**2 <= 1:
            enCirculo += 1
    return  enCirculo/Nsim

def Bernoulli():
    u = 4 * random() - 2
    v = 2 * random() - 1
    if (u/2)**2 + v**2 <= 1:
        return 1
    else: 
        return 0

def Media_Muestral_X(z_alfa_2, L): #z_alfa_2 = z_(alfa/2)
    'Confianza = (1 - alfa)%, amplitud del intervalo: L'
    d = L / (2 * z_alfa_2)
    Media = Bernoulli()
    Scuad, n = 0, 1
    while n <= 100 or np.sqrt(Scuad / n) > d:
        n += 1
        X = 8 * Bernoulli()
        Media_Ant = Media
        Media = Media_Ant + (X - Media_Ant) / n
        Scuad = Scuad * (1 - 1 /(n-1)) + n*(Media - Media_Ant)**2
    cota_inferior_intervalo = Media - z_alfa_2 * np.sqrt(Scuad / n)
    cota_superior_intervalo = Media + z_alfa_2 * np.sqrt(Scuad / n)
    return Media, n, cota_inferior_intervalo, cota_superior_intervalo


Nsim = 10_000
proporcion = calcula_proporcion(Nsim)
print(f'Valor de la proporcion de puntos que caen dentro de la curva es: {proporcion}')
media_simulada, n_simulaciones, cota_inferior_intervalo, cota_superior_intervalo = Media_Muestral_X(1.96, 0.1)
longitud_intervalo = cota_superior_intervalo - cota_inferior_intervalo
print(f'Valor del area de la elipse es: {media_simulada} con n={n_simulaciones} y un intervalo de confianza de 95%: ({cota_inferior_intervalo}, {cota_superior_intervalo})')
print(f'Longitud del intervalo: {longitud_intervalo}')
