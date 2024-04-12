import random

numeros_aleatorios_random = set()
for i in range(1):
    numero = random.random()
    if(numero in numeros_aleatorios_random):
        print(f'Numero repetido {numero}')
        break
    numeros_aleatorios_random.add(numero)

