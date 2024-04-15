#include <stdio.h>

int suma_hasta(int N)
{
    int suma = 0;
    int i = 0;
    while (i < N)
    {
        suma += i;
        i++;
    }
    return suma;
}

int main(void)
{
    int N, suma;
    printf("Ingrese un numero\n");
    scanf("%d", &N);
    if (N < 0)
    {
        printf("Error: el numero tiene que ser positivo\n");
    }
    else if (N >= 0)
    {
        suma = suma_hasta(N);
        printf("El resultado de la sumatoria es: %d\n", suma);
    }

    return 0;
}