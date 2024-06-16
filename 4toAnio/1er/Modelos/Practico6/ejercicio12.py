from scipy.stats import chi2, binom
# Ejercicio 12. Un escribano debe validar un juego en cierto programa de televisión. El mismo consiste
# en hacer girar una rueda y obtener un premio según el sector de la rueda que coincida con una aguja.
# Hay 10 premios posibles, y las áreas de la rueda para los distintos premios, numerados del 1 al 10, son
# respectivamente:
#           31 %, 22 %, 12 %, 10 %, 8 %, 6 %, 4 %, 4 %, 2 %, 1 %.
# Los premios con número alto (e.j. un auto 0Km) son mejores que los premios con número bajo (e.j. 2x1
# para entradas en el cine). El escribano hace girar la rueda hasta que se cansa, y anota cuántas veces sale
# cada sector. Los resultados, para los premios del 1 al 10, respectivamente, son:
#           188, 138, 87, 65, 48, 32, 30, 34, 13, 2.
# (a) Construya una tabla con los datos disponibles
# (b) Diseñe una prueba de hipótesis para determinar si la rueda es justa
# (c) Defina el p-valor a partir de la hipótesis nula
# (d) Calcule el p-valor bajo la hipótesis de que la rueda es justa, usando la aproximación chi cuadrado
# (e) Calcule el p-valor bajo la hipótesis de que la rueda es justa, usando una simulación.
#
# a) Solucion
# k = numero de agrupamientos de valores considerados = 10
# n = tamaño de la muestra = 637
k = 10
n = 637
N = [188, 138, 87, 65, 48, 32, 30, 34, 13, 2]
probabilidades = [0.31, 0.22, 0.12, 0.10, 0.08, 0.06, 0.04, 0.04, 0.02, 0.01]
lista_p_I = [0.31, 0.22, 0.12, 0.10, 0.08, 0.06, 0.04, 0.04, 0.02, 0.01]
for i in range(0, len(lista_p_I)):
    lista_p_I[i] = lista_p_I[i] * 637
print(lista_p_I)
# +----+---------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
# |    | Premio  | 1         | 2         | 3         | 4         | 5         | 6         | 7         | 8         | 9         | 10        |
# +----+---------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
# |    | Salidas | 188       | 138       | 87        | 65        | 48        | 32        | 30        | 34        | 13        | 2         |
# +----+---------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
# |    | Prob.   | 0.31      | 0.22      | 0.12      | 0.10      | 0.08      | 0.06      | 0.04      | 0.04      | 0.02      | 0.01      |
# |    | Teorica |           |           |           |           |           |           |           |           |           |           |
# |    | (p_i)   |           |           |           |           |           |           |           |           |           |           |
# +----+---------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
# |    | n * p_i |  197.47   | 140.14    | 76.44     | 63.7      | 50.96     | 38.22     | 25.48     | 25.48     | 12.74     | 6.37      |
# |    | frec.   |           |           |           |           |           |           |           |           |           |           |
# |    | esperada|           |           |           |           |           |           |           |           |           |           |
# +----+---------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
#

# b) Solucion
# La hipotesis nula es que la rueda es justa, es decir, que la probabilidad de que salga un determinado premio esta dada
# por el area de la rueda que corresponde a ese premio.
#
# d) Solucion
# Calculo el estadistico T = sumatoria_0_k(Ni - np_i)^2 / np_i
def Estadistico(N, p, k, n):
    # N es el array de frecuencias, p es el array de probabilidades, k es la cantidad de valores considerados, n es la cantidad de experimentos
    T = 0.0
    for i in range(k):
        T += ((N[i] - n * p[i]) ** 2) / (n * p[i])
    return float(T)

def Pearson(N,p,n, m):
    # N es el array de frecuencias, p es el array de probabilidades, n cant de experimentos, m es cantidad de parametros estimados
    k = len(N)
    T = Estadistico(N,p,k,n)
    x, df = T, k-1 -m
    return chi2.sf(x,df)

T = Estadistico(N, probabilidades, k, n)
print(T)
print(f' p-valor con metodo Pearson = {Pearson(N, probabilidades, n, 0)}')

# e) Solucion

def simular_muestra_tam_n_binomial(n,probabilidades):
    N = []
    prob_acum = 0
    for i in range(len(probabilidades)):
        val = binom.rvs(n - sum(N), probabilidades[i] / (1 - prob_acum))
        N.append(val)
        prob_acum += probabilidades[i]
    return N

def calcular_pvalor(n,cant_valores_a_tomar,probabilidades, t_0, N_sim):
    result = 0
    for _ in range(N_sim):
        N_i = []
        N_i =simular_muestra_tam_n_binomial(n,probabilidades)
        T = Estadistico(N_i, probabilidades, cant_valores_a_tomar, n)
        if T >= t_0:
            result += 1
    return result/N_sim


p_valor_sim = calcular_pvalor(n,k,probabilidades,T,10_000)
print(p_valor_sim)


