#include <stdio.h>
#include <stdbool.h>
#define tam 5

typedef struct
{
    float maximo;
    float minimo;
    float promedio;
} datos_t;

datos_t stats(float a[], int tama)
{
    datos_t datos;
    int i = 0;
    datos.promedio=0;
    datos.minimo = a[0];
    datos.maximo = a[0];
    while (i < tama)
    {
        datos.promedio+=a[i];
        if (a[i] >= datos.maximo)
        {
            datos.maximo= a[i];
        }
        else if (a[i] < datos.maximo)
        {
            datos.minimo= a[i];
        }
        i++;
    }
    datos.promedio= datos.promedio/tama;
    return datos;
}

void pedirArreglo(float a[], int tama)
{
    int i = 0;
    while (i < tama)
    {
        printf("Ingrese el %d elemento de la lista: \n", i + 1);
        scanf("%f", &a[i]);
        i++;
    }
}

int main(void)
{
    float a[tam];
    datos_t tripla;
    pedirArreglo(a, tam);
    tripla = stats(a, tam);
    printf("El maximo de la lista es %f \n", tripla.maximo);
    printf("El minimo de la lista es %f \n", tripla.minimo);
    printf("El promedio de la lista es %f \n", tripla.promedio);
    return 0;
}
