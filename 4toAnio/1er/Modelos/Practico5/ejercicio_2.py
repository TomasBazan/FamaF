from random import random
import numpy as np

def pareto(constante):
    U = random()
    return (1-U)**(-1/constante)

def print_values(N_sim, fun, **params):
    acum = 0
    for _ in range(N_sim):
        acum += fun(**params)
    print(f'esperanza estimada {acum/N_sim}')

def exponencial(lamda):
    U = 1-random()
    return -np.log(U)/lamda

def erlang(mu, k):
    acum = 0
    for _ in range(k):
        acum += exponencial(1/mu)
    return acum

def weibull(lamda, beta):
    U = random()
    return lamda * ((-np.log(1-U))**(1/beta))

print('Pareto')
print_values(N_sim=10_000, fun = pareto, constante=2)
print(f'esperanza teorica {2/(2-1)}')
print('\n---------------------------------\n')
print('Erlang')
print_values(N_sim=10_000, fun = erlang, mu = 2 ,k=2)
print(f'esperanza teorica {2/(1/2)}')
print('\n---------------------------------\n')
print('Weibull')
print_values(N_sim=10_000, fun = weibull, lamda = 1 , beta=2)
print(f'esperanza teorica {np.pi**(1/2)/2}')
