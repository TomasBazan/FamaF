from random import random
from time import time
import numpy as np
# Simular variable aleatoria geometrica Geom(p) usando metodo de transformada
# inversa y aplicando la formula recursiva para P(X = i)

# no termino de entender cual es la formula recursiva, me suena a generar 
# todos los ensayos pero eso es el punto b

def generar_v_a_geometrica_transformada_inversa(p):
    U = random()
    return int(np.log(1-U)/np.log(1-p))+1

def generar_v_a_geometrica_con_ensayos(p):
    count_ensallos =0
    while True:
        U = random()
        if U <= p:
            return count_ensallos + 1
        else:
            count_ensallos  += 1

def ejercicioA(p,N_sim):
    values_obtained = []
    print(f'Transformada inversa')
    for _ in range(N_sim):
        values_obtained.append(generar_v_a_geometrica_transformada_inversa(p))
    print(f'Promedio de valores obtenidos {np.sum(values_obtained)/N_sim}')
    print(f'\t-------------------------')
    values_obtained = []
    print(f'Con ensayos')
    for _ in range(N_sim):
        values_obtained.append(generar_v_a_geometrica_con_ensayos(p))
    print(f'Promedio de valores obtenidos {np.sum(values_obtained)/N_sim}')

p = 0.8
N_sim = 10_000
print(f'con p = 0.8')
tiempo = time()
ejercicioA(p,N_sim)
tiempo = time() - tiempo
print(f'Tiempo de ejecucion {tiempo}')

print(f'==============================================================')
p = 0.2
print(f'con p = 0.2')
tiempo = time()
ejercicioA(p,N_sim)
tiempo = time() - tiempo
print(f'Tiempo de ejecucion {tiempo}')
