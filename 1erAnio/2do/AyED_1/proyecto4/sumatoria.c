#include <stdio.h>
#include <stdbool.h>


int sumatoria(int a[], int tam)
{

    int i = 0;
    int sum = 0;
    while (i < tam)
    {
        sum += a[i];
        i++;
    }

    return sum;
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

int main(void)
{
    #define tam 5
    int a[tam];
    int sum = 0;
    pedirArreglo(a, tam);
    sum = sumatoria(a, tam);
    printf("La sumatoria de la lista es: %d\n", sum);
    return 0;
}
