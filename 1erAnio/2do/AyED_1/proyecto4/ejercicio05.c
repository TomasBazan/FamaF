#include <stdio.h>
#include <stdbool.h>

void pedirArreglo(int a[], int n_max)
{
    int i = 0;
    while (i < n_max)
    {
        printf("Ingrese el %d elemento de la lista: \n", i + 1);
        scanf("%d", &a[i]);
        i++;
    }
}
void imprimeArreglo(int a[], int n_max)
{
    int i = 0;
    printf("La lista es: [");
    while (i < n_max)
    {
        if (i == n_max - 1)
        {
            printf("%d]\n", a[i]);
            i++;
        }
        else
        {
            printf("%d,", a[i]);
            i++;
        }
    }
}

int main(void)
{
    int n_max;
    int array[n_max];
    printf("Ingrese la cantidad de elementos que tendra su lista: \n");
    scanf("%d", &n_max);

    pedirArreglo(array, n_max);
    imprimeArreglo(array, n_max);
    return 0;
}
