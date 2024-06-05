from random import random
# c = 0.35*5 = 1.75
probabilidades = [0.05,0.1,0.2,0.3,0.35]
def ejercicio1a():
    while True:
        Y = int(random()*5)
        U = random()
        if U < probabilidades[Y] / (1.75 * (1/5)):
            return Y

def ejericio1b(N):
    media = 0
    for _ in range(N):
        media += ejercicio1a()
    return media / N

def ejercicio2a():
    U = random()
    if U < 0.35:
        return 4
    elif U < 0.65:
        return 3
    elif U < 0.85:
        return 2
    elif U < 95:
        return 1
    else:
        return 0

def ejericio2b(N):
    media = 0
    for _ in range(N):
        media += ejercicio2a()
    return media / N

def ejercicio3():
    media = 0
    for i in range(len(probabilidades)):
        media += i * probabilidades[i]
    return media
        

print('Ejercicio 1 a ')
print(ejercicio1a())
print('Ejercicio 1 b ')
print(ejericio1b(10_000))
print('====================')

print('Ejercicio 2 a ')
print(ejercicio2a())
print('Ejercicio 2 b ')
print(ejericio2b(10_000))
print('====================')

print('Ejercicio 3')
print(ejercicio3())

