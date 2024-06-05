from random import random
import numpy as np

def generar_N():
    i, acum = 0 ,0 
    while acum < 1:
        u = random()
        acum += u
        i +=1
    return i

def aproximar_e(cota_sup):
    Media = 0
    Scuad, n = 0 ,1
    while n <= cota_sup:
        n += 1
        X = generar_N()
        MediaAnt = Media
        Media = MediaAnt + (X - MediaAnt) / n
        Scuad = Scuad * (1 - 1 /(n-1)) + n*(Media - MediaAnt)**2
    return Media, Scuad

def ejercicio_c(d):
    Media = generar_N()
    Scuad, n = 0, 1 #Scuad = Sˆ2(1)
    while n <= 1_000 or np.sqrt(Scuad/n) > d:
        n += 1
        X = generar_N()
        MediaAnt = Media
        Media = MediaAnt + (X - MediaAnt) / n
        Scuad = Scuad * (1 - 1 /(n-1)) + n*(Media - MediaAnt)**2
    return Media, Scuad


def main():
    print('ejercicio a) y b)')

    media, varianza_estimada = aproximar_e(1000)
    print(f'Media {media}\nVarianza Estimada {varianza_estimada}')
    print('ejercicio c')
    media_c, varianza_estimada_c = ejercicio_c(0.025/3.96)
    print(f'Ejercicio c:\nMedia {media_c} | Varianza {varianza_estimada_c}')


if __name__ == '__main__':
    main()
