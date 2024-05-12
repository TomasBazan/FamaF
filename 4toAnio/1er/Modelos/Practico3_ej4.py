from random import random
import numpy as np
from time import time

probabilidades = [ 0.11,0.14,0.09, 0.08,0.12,0.10,0.09,0.07,0.11,0.09]
posibles_valores = np.arange(1,11)
q_y = 0.1 # es decir de los 10 valores posibles, 1/10 ya que es uniforme
c = 1.4

def aceptacion_y_rechazo():
    while True:
        Y = int(random()*10)+1
        if random() < (probabilidades[Y-1] / (0.14)): # 0.14 = c * q_y
            return Y

def transformada_inversa():
    U = random()
    i, F = 0, probabilidades[0]
    while U >= F:
        i += 1; F += probabilidades[i]
    return posibles_valores[i]
    
def urna():
    A = []
    # mejorar el doble for
    for i in probabilidades:
        for _ in range(int(i*100)):
            A.append(i)
    U = int(random()*100)
    return A[U]

        
# probabilidades_dict = { 1:0.11,2:0.14,3:0.09,4: 0.08,5: 0.12,6: 0.10,7: 0.09,8: 0.07,9: 0.11,10: 0.09}
# def transformada_inversa():
#     keys = list(probabilidades_dict.keys())
#     values = list( probabilidades_dict.values())
#     # sort the index of values in descending order, after create dictionary sorted
#     sorted_values_indexs = np.argsort(values)[::-1] 
#     sorted_prob = {keys[i]: values[i] for i in sorted_values_indexs}
#     print(probabilidades_dict)
#     print(sorted_prob)
#     print(len(sorted_prob))
#     print('----------------------------------')
#     U = random()
#     for i in sorted_prob.keys():
#         prob_of_i=sorted_prob.get(i)
#         # tengo un error de tipos pero no tengo tiempo de
#         # ver como especificar tipos, igual creo que esta mal encarado el problema
#         if prob_of_i is not None and U < prob_of_i:
#             return i
#     print('------------------------------------') 
#     return 'error'

def main():
    Nsim = 10_000
    print('------------------------------------') 
    print('Aceptacion y rechazo')
    tiempo = time()
    for _ in range(Nsim):
        # print(aceptacion_y_rechazo())
        aceptacion_y_rechazo()
    tiempo = time() - tiempo
    print(f'tardo {tiempo}')
    print('------------------------------------') 
    print('Transformada inversa')
    tiempo = time()
    for _ in range(Nsim):
        # print(transformada_inversa())
        transformada_inversa()
    tiempo = time() - tiempo
    print(f'tardo {tiempo}')
    print('------------------------------------') 
    print('Urna')
    tiempo = time()
    for _ in range(Nsim):
        # print(urna())
        urna()
    tiempo = time() - tiempo
    print(f'tardo {tiempo}')
    print('------------------------------------') 

if __name__ == '__main__':
    main()
