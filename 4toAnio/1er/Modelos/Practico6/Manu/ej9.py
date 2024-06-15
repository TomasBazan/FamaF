from scipy.stats import uniform

def d_estadistico(Y, F, n): # Asumo que Y esta ordenado
    ''' Y muestra de n valores, F fda de la distribucion teorica
    '''
    d = 0
    for i in range(n):
        f_yi = F(Y[i])
        d = max(d, ((i + 1) / n) - f_yi, f_yi - (i/n))
    return d

def KS(Nsim, n, d_valor):
    ''' Nsim simulaciones, n tamaño de la muestra, d_valor obtenido de la muestra
    '''
    pvalor = 0
    for _ in range(Nsim):
        uniformes = uniform.rvs(size=n)    # Genero una muestra de n uniformes U(0,1)
        uniformes.sort()
        d_j = 0
        for j in range(n):
            u_j = uniformes[j]
            d_j = max(d_j, ((j + 1) / n) - u_j, u_j - (j / n))
        if d_j >= d_valor:
            pvalor += 1
    return pvalor/Nsim


M = [0.06, 0.12, 0.18, 0.27, 0.33, 0.36, 0.72, 0.74, 0.77, 0.83]
dvalor = d_estadistico(M, uniform.cdf, 10)
pvalor = KS(10000, 10, dvalor)
print(f"Usando KS tenemos que el p-valor es {pvalor}")