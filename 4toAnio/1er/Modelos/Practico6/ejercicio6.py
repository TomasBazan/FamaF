from random import random
import numpy as np

def fun_pi():
    en_circulo = 0
    u = 2 * random() -1
    v = 2 * random() - 1
    if u ** 2 + v ** 2 <= 1:
        en_circulo += 1
    return en_circulo

# Lo que estimo es p que es la proporcion de puntos que caen dentro del circulo
# Notar que esto no es pi, si no un valor entre 0 y 1 que da la proporcion de puntos que caen dentro del circulo
# es decir que el producto entre la proporcion y el area del cuadrado es pi
def estimador_p():
    p = 0; n = 0
    while n <= 100 or np.sqrt(p * (1 - p) / n) > 0.01:
        n += 1
        X = fun_pi()
        p = p + (X - p) / n
    return p

def estimador_p_intervalo_confianza(z_alfa_2,L):
    'Confianza: 100(1-alpha)%'
    'L: amplitud del intervalo'
    d = L / (2 * z_alfa_2)
    p = 0; n = 0
    while n <= 100 or np.sqrt(p * (1 - p) / n) > d:
        n += 1
        X = fun_pi()
        p = p + (X - p) / n
    cota_inferior = p - z_alfa_2 * np.sqrt(p * (1 - p) / n)
    cota_superior = p + z_alfa_2 * np.sqrt(p * (1 - p) / n)
    return p, n, cota_inferior, cota_superior

def main():
    # a) Utilice un algoritmo para estimar la proporción de puntos que caen dentro del círculo y deténgase
    # cuando la desviación estandar muestral del estimador sea menor que 0,01.
    Nsim = 1_0000
    print(estimador_p())
    # b) Obtenga un intervalo de ancho menor que 0,1, el cual contenga a π con el 95 % de confianza. ¿Cuántas
    # ejecuciones son necesarias?
    p , n, cota_inferior, cota_superior = estimador_p_intervalo_confianza(1.96,0.1)
    print(f'Estimado de proporcion: {p}\nNumero de ejecuciones necesarias {n}\n Intervalo [{cota_inferior},{cota_superior}]')

if __name__ == '__main__':
    main()
