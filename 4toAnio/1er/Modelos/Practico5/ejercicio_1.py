from random import random
import numpy as np

def Tinversa_gen(primer_cota, primer_F, segunda_F):
    U = random()
    if U <= primer_cota:
        return primer_F(U)
    elif primer_cota < U <= 1: 
        return segunda_F(U)
    else:
        return 1

def print_values(primer_cota, primer_acumulada, segunda_acumulada):
    a = []
    for _ in range(100):
        val = Tinversa_gen(primer_cota, primer_acumulada, segunda_acumulada)
        a.append(val)
    print(a)

def a_F_X_1(x):
    return 2 + 2 * np.sqrt(x)
def a_F_X_2(x):
    return 6 - 2 * np.sqrt(3) * np.sqrt(1*x)

print_values(0.25, a_F_X_1, a_F_X_2)
print('\n---------------------------------\n')

def b_F_X_1(x):
    return -3 + (np.sqrt(35*x + 27)) / (np.sqrt(3))
def b_F_X_2(x):
    return -3 + (np.sqrt(35*x + 27)) / (np.sqrt(3))

print_values(0.6, b_F_X_1,b_F_X_2)
print('\n---------------------------------\n')


def c_F_X_1(x):
    return np.log(16 * x) / 4
def c_F_X_2(x):
    return (16 * x -1) / 4

print_values(0.0625, c_F_X_1,c_F_X_2)
print('\n---------------------------------\n')
