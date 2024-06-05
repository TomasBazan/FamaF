from random import random
import numpy as np

def Normal_rechazo(mu, sigma):
    while True:
        Y1 = -np.log(random())
        Y2 = -np.log(random())
        if Y2 >=(Y1-1) ** 2 / 2:
            if random() < 0.5:
                return Y1 * sigma + mu
            return -Y1 * sigma + mu

def Media_Muestral_X(d):
    media = Normal_rechazo(0,1) 
    Scuad, n = 0, 1 
    while n<=100 or np.sqrt(Scuad/n) > d:
        n += 1
        X = Normal_rechazo(0,1)
        media_anterior = media
        media = media_anterior + (X - media_anterior) / n
        Scuad = Scuad * (1 - 1 /(n-1)) + n * (media - media_anterior) ** 2
    return n, media, Scuad


N_sim,media,var = Media_Muestral_X(0.1)

print(f'numero de simulaciones {N_sim}, media {media}, varianza {var}')
