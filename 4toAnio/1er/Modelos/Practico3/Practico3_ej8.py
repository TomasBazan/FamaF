from random import random
import math

# metodo transformada inversa y el rechazo para v.a. X con distribucion de prob.
# por
# P(X=i) = ((lamda**i/i!)*e**-lamda) / (sum(j=0,k, ((lamda**j/j!) / e**-lamda)))     para i=0,...,k)

def Poisson_mejorado(x):
    p = math.exp(-x);
    F = p
    for j in range(1, int(x) + 1):
        p *= x / j
        F += p
    U = random()
    if U >= F:
        j = int(x) + 1
        while U >= F:
            p *= x / j; F += p
            j += 1
        return j - 1
    else:
        j = int(x)
        while U < F:
            F -= p;
            p *= j/x
            j -= 1
        return j+1

def generar_var_aleatoria_transformada_inversa(k, x):
    denominador = 0
    for j in range(k):
        denominador += (math.exp(-x)) * (x**j / math.factorial(j))
    U = random()
    i = 0; p = math.exp(-x)
    F = p
    while U >= F:
        i += 1
        p *= (x/i) / denominador
        F += p
    return i

N_sim = 1_000
probabilidades = []
q = []
k = 10
denominador = 0
for j in range(k):
    denominador += (math.exp(-0.7)) * (0.7**j / math.factorial(j))
c = 1/denominador
for i in range(k+1):
    probabilidades.append(( (math.exp(-0.7)) * (0.7**i / math.factorial(i)) ) / (denominador))
    q.append( math.exp(-0.7) * ( (0.7**i) / (math.factorial(i))))
    
def generar_var_aleatoria_rechazo(k, x):
    while True:
        y = Poisson_mejorado(x)
        u = random()
        if u < probabilidades[y] / (c * q[y]):
            return y

def ejercicio(fun,N_sim):
    count = 0
    for _ in range(N_sim):
        var_aleat = fun(10, 0.7)
        if var_aleat > 2: count+=1
    print(f'P(Y>2) = {count/N_sim}')


print('Transformada inversa')
ejercicio(generar_var_aleatoria_transformada_inversa,N_sim)
print('===================================')
print('Rechazo')
ejercicio(generar_var_aleatoria_rechazo,N_sim)
