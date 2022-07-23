#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

#define tam 5
void pedirArreglo(int a[], int tama)
{
    int i = 0;
    while (i < tam)
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
void intercambiar(int a[], int tama, int i, int j)
{
    int posicion1 = a[i];
    int posicion2 = a[j];
    a[j] = posicion1;
    a[i] = posicion2;
}
int main(void)
{
    int a[tam];
    int i = 0;
    int j = 0;
    pedirArreglo(a, tam);

    printf("Ingrese las posiciones del 0 al 4: \n");
    scanf("%d\n%d", &i, &j);
    assert(i >= 0 && i < tam && i != j);
    assert(j >= 0 && j < tam);

    intercambiar(a, tam, i, j);
    imprimeArreglo(a, tam);
    return 0;
}
