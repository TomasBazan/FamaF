from scipy.stats import expon, uniform

def fda_exp_50(x):
    return expon.cdf(x, scale=50)

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


M = [8, 11, 22, 33, 41, 75, 78, 86, 99, 122, 133, 144, 146]
dvalor = d_estadistico(M, fda_exp_50, 13)
pvalor = KS(10000, 13, dvalor)
print(f"Usando KS tenemos que el p-valor es {pvalor}")
