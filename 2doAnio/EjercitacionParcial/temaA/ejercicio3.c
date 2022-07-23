#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#define tama 5

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
typedef struct
{
    int inferior;
    int superior;
} sum_t;

sum_t suma_acotada(int cota, int array[], int tam)
{
    sum_t contador;
    int i = 0;
    contador.inferior = 0;
    contador.superior = 0;
    while (i < tam)
    {
        if (cota > array[i])
        {
            contador.inferior += array[i];
        }
        else if (cota < array[i])
        {
            contador.superior += array[i];
        }
        i++;
    }
    return contador;
}
int main(void)
{
    int cota;
    int a[tama];
    sum_t contador;
    printf("Ingrese una cota: \n");
    scanf("%d", &cota);
    pedirArreglo(a, tama);
    contador = suma_acotada(cota, a, tama);
    printf("La sumatoria de los elementos mayores a la cota es: %d\n", contador.superior);
    printf("La sumatoria de los elementos mayores a la cota es: %d\n", contador.inferior);
    return 0;
}