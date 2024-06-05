from random import random
import numpy as np

def gI(U):
    pi = np.pi
    return np.sin(pi * (U + 1)) / (U + 1)

def gII(U):
    return 3 / ((U * 2) * (3 + ((1 / U - 1) * 4)))

def ejercicio3a(fun, d):
    Media = fun(random())   # Genero una g(U)
    Scuad = 0
    n = 1
    while (n < 100 or (Scuad/n) ** (1/2) >= d):
        n += 1
        X = fun(random())   # Genero una g(U)
        MediaAnt = Media
        Media = MediaAnt + (X - MediaAnt) / n
        Scuad = Scuad * (1 - 1 / (n - 1)) + n * (Media - MediaAnt) ** 2
    I95_izq = Media - 1.96 * (Scuad/n) ** (1/2)
    I95_der = Media + 1.96 * (Scuad/n) ** (1/2)
    return n, Media, Scuad ** (1/2), I95_izq, I95_der

respuestaI = ejercicio3a(gI, 1/1960)
print("\nEl numero de datos generados para la integral I es", respuestaI[0])
print("La aproximacion de la integral I es", respuestaI[1])
print("El valor exacto de la integral I es", -0.4337854758498377)   # Usando integracion numerica

respuestaII = ejercicio3a(gII, 1/1960)
print("\nEl numero de datos generados para la integral II es", respuestaII[0])
print("La aproximacion de la integral II es", respuestaII[1])
print("El valor exacto de la integral II es", (3 * (1/4)) * np.pi / (2 * (3/2)))

def ejercicio3b(fun, N):
    Media = fun(random())   # Genero una g(U)
    Scuad = 0
    n = 1
    while (n < N):
        n += 1
        X = fun(random())   # Genero una g(U)
        MediaAnt = Media
        Media = MediaAnt + (X - MediaAnt) / n
        Scuad = Scuad * (1 - 1 / (n - 1)) + n * (Media - MediaAnt) ** 2
    I95_izq = Media - 1.96 * (Scuad/n) ** (1/2)
    I95_der = Media + 1.96 * (Scuad/n) ** (1/2)
    return Media, Scuad ** (1/2), I95_izq, I95_der

print("\nIntregal I")

respuestaI_1000 = ejercicio3b(gI, 1000)
print("\nPara N = 1000, los valores de la integral I son: ")
print("Media muestral es", respuestaI_1000[0])
print("Desviacion estandar muestral es", respuestaI_1000[1])
print("Intervalo de Confianza 95 es (", respuestaI_1000[2], ",", respuestaI_1000[3], ")")

respuestaI_5000 = ejercicio3b(gI, 5000)
print("\nPara N = 5000, los valores de la integral I son: ")
print("Media muestral es", respuestaI_5000[0])
print("Desviacion estandar muestral es", respuestaI_5000[1])
print("Intervalo de Confianza 95 es (", respuestaI_5000[2], ",", respuestaI_5000[3], ")")

respuestaI_7000 = ejercicio3b(gI, 7000)
print("\nPara N = 7000, los valores de la integral I son: ")
print("Media muestral es", respuestaI_7000[0])
print("Desviacion estandar muestral es", respuestaI_7000[1])
print("Intervalo de Confianza 95 es (", respuestaI_7000[2], ",", respuestaI_7000[3], ")")

respuestaI_Ns = ejercicio3a(gI, 1/1960)
print("\nPara N =", respuestaI_Ns[0], ", los valores de la integral I son: ")
print("Media muestral es", respuestaI_Ns[1])
print("Desviacion estandar muestral es", respuestaI_Ns[2])
print("Intervalo de Confianza 95 es (", respuestaI_Ns[3], ",", respuestaI_Ns[4], ")")

print("\nIntegral II")

respuestaII_1000 = ejercicio3b(gII, 1000)
print("\nPara N = 1000, los valores de la integral II son: ")
print("Media muestral es", respuestaII_1000[0])
print("Desviacion estandar muestral es", respuestaII_1000[1])
print("Intervalo de Confianza 95 es (", respuestaII_1000[2], ",", respuestaII_1000[3], ")")

respuestaII_5000 = ejercicio3b(gII, 5000)
print("\nPara N = 5000, los valores de la integral II son: ")
print("Media muestral es", respuestaII_5000[0])
print("Desviacion estandar muestral es", respuestaII_5000[1])
print("Intervalo de Confianza 95 es (", respuestaII_5000[2], ",", respuestaII_5000[3], ")")

respuestaII_7000 = ejercicio3b(gII, 7000)
print("\nPara N = 7000, los valores de la integral II son: ")
print("Media muestral es", respuestaII_7000[0])
print("Desviacion estandar muestral es", respuestaII_7000[1])
print("Intervalo de Confianza 95 es (", respuestaII_7000[2], ",", respuestaII_7000[3], ")")

respuestaII_Ns = ejercicio3a(gII, 1/1960)
print("\nPara N =", respuestaII_Ns[0], ", los valores de la integral II son: ")
print("Media muestral es", respuestaII_Ns[1])
print("Desviacion estandar muestral es", respuestaII_Ns[2])
print("Intervalo de Confianza 95 es (", respuestaII_Ns[3], ",", respuestaII_Ns[4], ")\n")
