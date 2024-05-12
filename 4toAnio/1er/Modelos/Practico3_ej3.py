from random import randint as rnd
import numpy as np
def lanzamiento_dados():
    sum_of_dices = set()
    num_of_throws = 0
    while True:
        dice1 = rnd(1, 6)
        dice2 = rnd(1, 6)
        sum_of_dices.add(dice1 + dice2)
        num_of_throws += 1
        if len(sum_of_dices) == 11:
            break
    return num_of_throws

N = [ 100, 1000, 10000 , 100000]
for n in N:
    exitos_15 = 0
    exitos_9 = 0
    sum_number_of_throws = 0
    sum_number_of_throws_to_square = 0
    for i in range(n):
        X = lanzamiento_dados()
        sum_number_of_throws += X
        sum_number_of_throws_to_square += X**2
        if X >= 15: exitos_15 += 1
        if X <= 9: exitos_9 += 1
    varianza = (sum_number_of_throws_to_square/n)- (sum_number_of_throws**2/n**2)
    print(f'N = {n}')
    print(f'Probabilidad de que se necesiten al menos 15 tiradas: {exitos_15/n}')
    print(f'Probabilidad de que se necesiten al lo sumo 9 tiradas: {exitos_9/n}')
    print(f'valor esperado de tiradas: {sum_number_of_throws/n}')
    print(f'varianza de tiradas: {varianza}')
    print(f'desvio estandar de tiradas: {np.sqrt(varianza)}')
    print('-------------------------------------------')
