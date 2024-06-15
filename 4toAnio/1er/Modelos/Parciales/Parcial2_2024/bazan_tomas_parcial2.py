from random import random
import numpy as np

def algo_x(p):
    while True:
        Y = int(random() *4)
        U = random()
        if U < p[Y] / 0.35:
            return Y

def ejercicio2():
    def t_inversa():
        U = random()
        if U < (2/3):
            return (3*U/2) ** (2/3)
        else:
            return 3 * U -1
    exitos = 0
    N_sim = 10_000
    for _ in range(N_sim):
        val = t_inversa()
        if val > 1:
            exitos += 1
    print(f'Estimacion de P(X > 1) = {exitos/N_sim}')

def hot_dog(T):
    def metodo_adelgazamiento_mejorado(T, fun):
        interv = [1 ,2 ,6 ,8 ,9]
        lamda =  [10,15,20,18,14]
        j = 0 
        t = -np.log ( 1 - random() ) / lamda[j]
        NT = 0
        Eventos = []
        while t <= T:
            if t <= interv[j]:
                V = random()
                if V < fun(t) / lamda[j]:
                    NT += 1
                    Eventos.append(t)
                t += -np.log(1 - random()) / lamda[j]
            else:
                t = interv[j] + (t - interv[j]) * lamda[j] / lamda[j + 1]
                j += 1
        return NT, Eventos

    def lamda_t(t):
        if 0 <= t < 3:
            return 5+5*t
        if 3 <= t <= 5:
            return 20
        if 5 < t <= 9:
            return 30 - 2*t
    N_sim = 10_000
    acum = 0
    for _ in range(N_sim):
        nt, _= metodo_adelgazamiento_mejorado(T, lamda_t)
        acum += nt
    print(f' Estimacion del numero esperado de arribos en [0,9] {acum/N_sim}')

def area(N):
    def valorPi(Nsim):
        enArea = 0
        for _ in range(Nsim):
            u = random() * 3 -1.5
            v = random() * 3 -1.5
            if u**2 + (v - np.abs(u)**(3/2)**2) > 1:
                enArea += 1
        return enArea/Nsim
    print(valorPi(N))

