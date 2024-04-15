#include <stdio.h>
#include <assert.h>

int potenciaConWhile(int numero, int potencia)
{
    int resultado = numero;
    while (potencia > 1)
    {
        resultado = resultado * numero;
        potencia--;
    }
    return resultado;
}

void pedirArreglo(int a[], int tam)
{
    int i = 0;
    while (i < tam)
    {
        printf("Ingrese el %d elemento de la lista: \n", i + 1);
        scanf("%d", &a[i]);
        i++;
    }
}
int binaDecimal(int a[], int tam)
{
    int acum = 0;
    int i = 0;
    while (i < tam)
    {
        int asd = 2^i;
        acum = acum + a[i]*potenciaConWhile(2, i);
        i++;
    }
    return acum;
}
int main(void)
{
    printf("2^0 = %d\n", 2^0);
    printf("2^1 = %d\n", 2^1);
    printf("2^2 = %d\n", 2^2);
    printf("2^3 = %d\n", 2^3);
    int tama, decimal;
    printf("ingrese tamaño del arreglo: \n");
    scanf("%d", &tama);
    int a[tama];
    pedirArreglo(a, tama);
    decimal=binaDecimal(a , tama);
    printf("El numero en decimal es: %d\n", decimal);
    return 0;
}