from scipy.stats import binom, chi2


def calcular_probabilidades(arrays):
    # Inicializar contadores para las ocurrencias de 0, 1 y 2
    total_0 = 0
    total_1 = 0
    total_2 = 0

    # Sumar las ocurrencias de cada número en todos los arreglos
    for array in arrays:
        total_0 += array[0]
        total_1 += array[1]
        total_2 += array[2]

    # Calcular el total de todas las ocurrencias
    total = total_0 + total_1 + total_2

    # Calcular la probabilidad de cada número
    prob_0 = total_0 / total
    prob_1 = total_1 / total
    prob_2 = total_2 / total

    return prob_0, prob_1, prob_2

def simular_muestra_tam_n_binomial(n,probabilidades):
    N = []
    prob_acum = 0
    for i in range(len(probabilidades)):
        val = binom.rvs(n - sum(N), probabilidades[i] / (1 - prob_acum))
        N.append(val)
        prob_acum += probabilidades[i]
    return N
arrays = []
for _ in range(10_000):
    arrays.append(simular_muestra_tam_n_binomial(564, [0.25, 0.5, 0.25]))

probabilidades = calcular_probabilidades(arrays)
print(f"Probabilidad de sacar 0: {probabilidades[0]:.2f}")
print(f"Probabilidad de sacar 1: {probabilidades[1]:.2f}")
print(f"Probabilidad de sacar 2: {probabilidades[2]:.2f}")

