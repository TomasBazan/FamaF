from random import random
import numpy as np
 
def llega_colectivo():
    U = int(random() * 20 + 20)
    return U


def eventosPoisson(lamda,T):
    t = 0
    NT = 0
    Eventos = []
    while t < T:
        U = 1 - random()
        t += - np.log(U) / lamda
        if t <= T:
            NT += 1
            Eventos.append(llega_colectivo())
    return NT, Eventos
eventos, aficionados = eventosPoisson(5,1)
print(f' En el tiempo 1 llegaron {np.sum(aficionados)} aficionados')

