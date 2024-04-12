# a)
def vonNeumann(u):
    i = 0
    a = u
    while(i<11):
        a = ((a**2 // 100) % 10000)
        print(f'{a}, ')
        i += 1

# b)
def congruencial(u):
    i = 0
    a = u
    numeros = set()
    lenght_index = 0
    flag = False
    while(i<11):
        numeros.add(a)
        a = ((5 * a + 4) % (2**5))
        if((a in numeros) and (not flag)):
            lenght_index = i +1
            flag = True
        print(f'{a}, ')
        i += 1
    print(f'periodo de {lenght_index}')
# c)
def congruencialC(y):
    return (( 7*y ) % 71)

def chequeo_periodo_congruencial():
    max_periodo = 0
    for k in range(10**4):
        periodo = 0
        secuencia_sin_repeticiones = set()
        periodo = 0;
        a = k
        for i in range(2**9):
            if(a in secuencia_sin_repeticiones):
                periodo = len(secuencia_sin_repeticiones)
                break
            a = congruencialC(a)
        if(max_periodo < periodo):
            max_periodo = periodo
        # print(f'El periodo es de {periodo}')
        # print(f'============================')
        # print(f' Secuencia sin repeticiones {secuencia_sin_repeticiones}')
    print(f'periodo maximo {max_periodo}')

if __name__ == '__main__':
    chequeo_periodo_congruencial()
    # while(True):
    #     i = input('semilla \n')
    #     congruencial(int(i))
    # vonNeumann(int(i))
