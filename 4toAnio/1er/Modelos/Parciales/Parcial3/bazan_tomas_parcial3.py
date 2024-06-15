from random import random
import numpy as np
from scipy.stats import uniform, chi2, binom, expon

def ejercicio_4():
    def Monte_Carlo_0_1(fun, Nsim):
        Integral = 0
        for _ in range(Nsim):
            Integral += fun(random())
        return Integral/Nsim

    def integral_fun(U):
        return (((1/U)-1) / (1 + (1/U - 1)**4)) * (1/U**2)
        return (3/ (3 + (1/U -1)**4)) * (1/U**2)

    def Media_Muestral_X(z_alfa_2, fun, L): #z_alfa_2 = z_(alfa/2)
        'Confianza = (1 - alfa)%, amplitud del intervalo: L'
        d = L / (2 * z_alfa_2)
        Media = fun(random())
        Scuad, n = 0, 1
        while n < 100 or np.sqrt(Scuad / n) > d:
            n += 1
            X = fun(random())
            Media_Ant = Media
            Media = Media_Ant + (X - Media_Ant) / n
            Scuad = Scuad * (1 - 1 /(n-1)) + n*(Media - Media_Ant)**2
        cota_izq = Media - z_alfa_2 * np.sqrt(Scuad / n)
        cota_der = Media + z_alfa_2 * np.sqrt(Scuad)
        return Media, cota_izq, cota_der, n, np.sqrt(Scuad)

    def ejercicio_4(z_alfa_2, fun, N_sim): #z_alfa_2 = z_(alfa/2)
        'Confianza = (1 - alfa)%, amplitud del intervalo: L'
        Media = fun(random())
        Scuad, n = 0, 1
        while n < N_sim :
            n += 1
            X = fun(random())
            Media_Ant = Media
            Media = Media_Ant + (X - Media_Ant) / n
            Scuad = Scuad * (1 - 1 /(n-1)) + n*(Media - Media_Ant)**2
        cota_izq = Media - z_alfa_2 * np.sqrt(Scuad / n)
        cota_der = Media + z_alfa_2 * np.sqrt(Scuad / n)
        return Media, cota_izq, cota_der, n, np.sqrt(Scuad)
    print('===============================================')
    print('Ejercicio 4:')
    Media,cota_inferior, cota_superior, N_sim ,S = Media_Muestral_X(1.96,integral_fun, 0.001/2)
    print(f' Num de simulaciones {N_sim}\ncota inferior = {cota_inferior}\ncota superior = {cota_superior}\nMedia={Media}\nS {S}')
    respuestas_1000 = ejercicio_4(1.96,integral_fun, 1000)
    respuestas_5000 = ejercicio_4(1.96,integral_fun, 5000)
    respuestas_7000 = ejercicio_4(1.96,integral_fun, 7000)
    print(f'\nNum de simulaciones {respuestas_1000[3]}\n cota inferior = {respuestas_1000[1]}\ncota superior{respuestas_1000[2]}\nMedia={respuestas_1000[0]}\n S {respuestas_1000[4]}')
    print('----------------------------------------------------------------')
    print(f'\nNum de simulaciones {respuestas_5000[3]}\ncota inferior = {respuestas_5000[1]}\ncota superior{respuestas_5000[2]}\nMedia={respuestas_5000[0]}\nNum de simulaciones {respuestas_5000[3]}\n S {respuestas_5000[4]}')
    print('----------------------------------------------------------------')
    print(f'\nNum de simulaciones {respuestas_7000[3]}\ncota inferior = {respuestas_7000[1]}\ncota superior{respuestas_7000[2]}\nMedia={respuestas_7000[0]}\nNum de simulaciones {respuestas_7000[3]}\n S {respuestas_7000[4]}')
    print('===============================================')

def ejercicio_3():
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

    def Estadistico(N, p, k, n):
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

    # E[X] = n p
    # E[X] / n = p
    # (x_1 + x_2 + ... + x_n)/n^2 = p
    
    n_binomial= 3
    # N es el array de frecuencias N_i calculadas desde la muestra
    N = [490, 384, 111, 15]
    esp_muestra = 0
    for i in range(len(N)):
        esp_muestra += i * N[i]

    # Estimo p (parametro de binomial)
    cantidad_experimentos = sum(N)
    esp_muestra = esp_muestra / cantidad_experimentos
    p_estimado = esp_muestra / n_binomial

    lista_probabilidades = gen_pi(n_binomial, p_estimado) # lista de probabilidades de <indice> exitos
    valor_de_chi_pvalor = Pearson(N,lista_probabilidades,cantidad_experimentos, 1)
    print(f'Teorica: valor de chi cuadrado={valor_de_chi_pvalor}')

    valores_de_muestra = []
    k = 4
    for i in range(len(N)):
        for j in range(N[i]):
            valores_de_muestra.append(i)

    T = Estadistico(valores_de_muestra,lista_probabilidades,k,k)
    print(f'T = {T}')
    p_valor = calcular_pvalor(cantidad_experimentos, 4, lista_probabilidades, T, 10_000)
    print(f'p-valor = {p_valor}')


def ejeercicio_2():
    d_KS = 0.423 #estadı́stico
    pvalor = 0.
    n = 10
    Nsim = 10000
    for _ in range(Nsim):
        uniformes = uniform.rvs(0,1,n)
        uniformes.sort()
        d_j= 0
        for j in range(n):
            u_j = uniformes[j]
            d_j = max(d_j, (j + 1) / n-u_j, u_j - j / n)
        if d_j >= d_KS:
            pvalor += 1
    print(pvalor/Nsim)

def main():
    #ejercicio_4()
    #ejercicio_3()
    ejeercicio_2()

    

if __name__ == "__main__":
    main()
