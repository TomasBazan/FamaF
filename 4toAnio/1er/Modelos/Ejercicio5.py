from random import random
import numpy as np
# una sola integral
def Monte_Carlo_0_1(fun, cant_sim):
    integral = 0
    for _ in range(cant_sim):
        integral += fun(random())
    return integral/cant_sim;

def Monte_Carlo_a_b(fun,a,b,cant_sim):
    integral = 0
    for _ in range(cant_sim):
        integral += fun(a+(b-a)*random())
    return integral * (b-a)/cant_sim;

def Monte_Carlo_0_inf(fun,cant_sim):
    integral = 0
    for _ in range(cant_sim):
        y = random()
        integral += (1/y**2)*fun(1/y -1)
    return integral /cant_sim;

def funA(x):
    return (1-x**2)**(3/2)

def funB(x):
    return (x/(x**2-1))

def funC(x):
    return x*((1+x**2)**(-2))

def funD(x):
    return 2*np.exp(-x**2)

# dos integrales
def Monte_Carlo_0_1_doble(fun, cant_sim):
    integral = 0
    for _ in range(cant_sim):
        integral += fun(random(), random())
    return integral/cant_sim;

def Monte_Carlo_a_b_doble(fun,a,b,c,d,cant_sim):
    integral = 0
    for _ in range(cant_sim):
        integral += fun(a+(b-a)*random(), c+(d-c) * random())
    return integral * (b-a)/cant_sim;

def Monte_Carlo_0_inf_doble(fun,cant_sim):
    integral = 0
    for _ in range(cant_sim):
        y = random()
        y_2 = random()
        integral += (1/y**2*y_2**2)*fun(1/y -1, 1/y_2-1)
    return integral /cant_sim;

def main():
    # cant_simulaciones = int(input('Cantidad de simulaciones: '))
    # print(Monte_Carlo_0_1(funA, cant_simulaciones))
    # print(Monte_Carlo_a_b(funB, 2,3, cant_simulaciones))
    N = [100, 1000, 10000, 100000, 1000000]
    for i in N:
        # print(f'N = {i} = {Monte_Carlo_0_inf(funC , i)}')
        print(f'N = {i} = {Monte_Carlo_0_inf(funD , i)}')


if __name__ == "__main__":
    main()
