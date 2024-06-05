from random import random
import numpy as np

def Poisson_no_homogeneo_adelgazamiento(T, lamda_t, lamda):
    NT = 0
    Eventos = []
    U = 1 - random()
    t = -np.log(U) / lamda
    while t <= T:
        V = random()
        if V < lamda_t(t) / lamda:
            NT += 1
            Eventos.append(t)
        t += -np.log(1 - random()) / lamda
    return NT, Eventos


def lambda_t_i(t):
    if 0 <= t < 3:
        return 3 + (4/t+1)

def lambda_t_ii(t):
    if 0 <= t < 5:
        return (t-2)**2 - 5*t + 17

def lambda_t_iii(t):
    if 2 <= t <= 3:
        return t/2 -1
    if 3 <= t <= 6:
        return 1 - t/6
    else:
        return 0

print(f'Poisson de i {Poisson_no_homogeneo_adelgazamiento(2, lambda_t_i, 7)}')
print()
print(f'Poisson de ii {Poisson_no_homogeneo_adelgazamiento(2, lambda_t_ii, 17)}')
print()
print(f'Poisson de iii {Poisson_no_homogeneo_adelgazamiento(15, lambda_t_iii,0.5)}')

print('---------------------------')
print('Ejercico b')

def Poisson_adelgazamiento_mejorado(T, fun, interv, lamda):
    j = 0 #recorre subintervalos.
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
        else: #t > interv[j]
            t = interv[j] + (t - interv[j]) * lamda[j] / lamda[j + 1]
            j += 1
    return NT, Eventos

# Cuidado con el valor de T, si es muy grande puede haber un problema con el array
print(f'Poisson de i {Poisson_adelgazamiento_mejorado(3, lambda_t_i, [0.5,2,3] , [7,17/3,13/3])}')
print()
print(f'Poisson de ii {Poisson_adelgazamiento_mejorado(5,  lambda_t_ii,[1,3.5,5], [21,13,7/4])}')
print()
print(f'Poisson de iii {Poisson_adelgazamiento_mejorado(6, lambda_t_iii,[3,4.5,6], [0.5,0.5,0.25])}')
