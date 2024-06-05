from random import random
import numpy as np

def Monte_Carlo_0_1(fun, Nsim):
    Integral = 0
    for _ in range(Nsim):
        Integral += fun(random())
    return Integral/Nsim

def fun_i(U):
    pi = np.pi
    return np.sin(pi * (U + 1)) / (U + 1)

def fun_ii(U):
    return (3/ (3 + (1/U -1)**4)) * (1/U**2)

def Media_Muestral_X(z_alfa_2, fun, L): #z_alfa_2 = z_(alfa/2)
    'Confianza = (1 - alfa)%, amplitud del intervalo: L'
    d = L / (2 * z_alfa_2)
    Media = fun(random())
    Scuad, n = 0, 1
    while n < 1_000 or np.sqrt(Scuad / n) > d:
        n += 1
        X = fun(random())
        Media_Ant = Media
        Media = Media_Ant + (X - Media_Ant) / n
        Scuad = Scuad * (1 - 1 /(n-1)) + n*(Media - Media_Ant)**2
    cota_izq = Media - z_alfa_2 * np.sqrt(Scuad / n)
    cota_der = Media + z_alfa_2 * np.sqrt(Scuad)
    return Media, cota_izq, cota_der, n, np.sqrt(Scuad)

def ejercicio_b(z_alfa_2, fun, N_sim): #z_alfa_2 = z_(alfa/2)
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


def main():
    print(f'Funcion i: {Monte_Carlo_0_1(fun_i, 1000)}')
    print(f'Funcion ii: {Monte_Carlo_0_1(fun_ii, 1000)}')
    print('===============================================')
    print('Ejercicio a)')
    Media,cota_inferior, cota_superior, N_sim,S = Media_Muestral_X(1.96,fun_i, 0.001/2)
    print('Funcion i:')
    print(f'cota inferior = {cota_inferior}\ncota superior{cota_superior}\nMedia={Media}\nNum de simulaciones {N_sim}\n S {S}')
    Media,cota_inferior, cota_superior, N_sim ,S = Media_Muestral_X(1.96,fun_ii, 0.001/2)
    print('Funcion ii:')
    print(f'cota inferior = {cota_inferior}\ncota superior{cota_superior}\nMedia={Media}\nNum de simulaciones {N_sim}\n S {S}')
    print('===============================================')
    print('Ejercicio b)')
    print('Funcion i:')
    respuestas_1000 = ejercicio_b(1.96,fun_i, 1000)
    respuestas_5000 = ejercicio_b(1.96,fun_i, 5000)
    respuestas_7000 = ejercicio_b(1.96,fun_i, 7000)
    print(f'cota inferior = {respuestas_1000[1]}\ncota superior{respuestas_1000[2]}\nMedia={respuestas_1000[0]}\nNum de simulaciones {respuestas_1000[3]}\n S {respuestas_1000[4]}')
    print(f'cota inferior = {respuestas_5000[1]}\ncota superior{respuestas_5000[2]}\nMedia={respuestas_5000[0]}\nNum de simulaciones {respuestas_5000[3]}\n S {respuestas_5000[4]}')
    print(f'cota inferior = {respuestas_7000[1]}\ncota superior{respuestas_7000[2]}\nMedia={respuestas_7000[0]}\nNum de simulaciones {respuestas_7000[3]}\n S {respuestas_7000[4]}')
    print('\t-------------------------')
    print('Funcion ii:')
    respuestas_1000 = ejercicio_b(1.96,fun_ii, 1000)
    respuestas_5000 = ejercicio_b(1.96,fun_ii, 5000)
    respuestas_7000 = ejercicio_b(1.96,fun_ii, 7000)
    print(f'cota inferior = {respuestas_1000[1]}\ncota superior{respuestas_1000[2]}\nMedia={respuestas_1000[0]}\nNum de simulaciones {respuestas_1000[3]}\n S {respuestas_1000[4]}')
    print(f'cota inferior = {respuestas_5000[1]}\ncota superior{respuestas_5000[2]}\nMedia={respuestas_5000[0]}\nNum de simulaciones {respuestas_5000[3]}\n S {respuestas_5000[4]}')
    print(f'cota inferior = {respuestas_7000[1]}\ncota superior{respuestas_7000[2]}\nMedia={respuestas_7000[0]}\nNum de simulaciones {respuestas_7000[3]}\n S {respuestas_7000[4]}')

    

if __name__ == "__main__":
    main()
