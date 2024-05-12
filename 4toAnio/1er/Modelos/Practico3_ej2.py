from random import randint
import numpy as np
from time import time

def ejercicio_a():
    N = 10000
    res = 0
    for k in range(N):
        res += np.exp(k/N)
    print('res ejercicio_a', res)

def ejercicio_b():
    N = 10000
    res = 0
    for _ in range(100):
        U = randint(1,N)
        res += np.exp(U/N)
    print('res ejercico_b: ', res / 100 * 10000)

def ejercicio_c():
    N = 100
    res = 0
    for k in range(N):
        res += np.exp(k/10000)
    print('res ejercico_c: ', res)

def main():
    start_time = time()
    ejercicio_a()
    time_a = time() - start_time
    ejercicio_b()
    time_b = time() - time_a
    ejercicio_c()
    time_c = time() - time_b
    print(f'time a -> {time_a}')
    print(f'time b -> {time_b}')
    print(f'time c -> {time_c}')

if __name__ == "__main__":
    main()
