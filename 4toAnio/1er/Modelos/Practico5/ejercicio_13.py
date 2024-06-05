from random import random
import numpy as np
 
def eventosPoisson(lamda,T):
    t = 0
    NT = 0
    Eventos = []
    while t < T:
        U = 1 - random()
        t += - np.log(U) / lamda
        if t <= T:
            NT += 1
            Eventos.append(t)
    return NT, Eventos
print(eventosPoisson(1,10))
