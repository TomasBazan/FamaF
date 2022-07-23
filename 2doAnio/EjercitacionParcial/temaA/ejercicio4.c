#include <stdio.h>
#include <stdbool.h>
#define tama 5

typedef struct
{
    int clave;
    int valor;
} asoc_t;

bool hay_asoc(int key, asoc_t a[], int tam)
{
    bool b;
    int i = 0;
    while (i < tam)
    {
        if (a[i].clave == key)
        {
            b = true;
        }

        i++;
    }

    return b;
}
void pedirArreglo(asoc_t a[], int tam)
{
    int i = 0;
    while (i < tam)
    {
        printf("Ingrese la clave del elemento %d de  la lista: \n",  i + 1);
        scanf("%d", &a[i].clave);
        printf("Ingrese el valor del elemento %d de  la lista: \n",  i + 1);
        scanf("%d", &a[i].valor);
        i++;
    }
}
int main(void)
{
    bool b;
    int key;
    asoc_t a[tama];
    pedirArreglo(a, tama);
    printf("Ingrese la clave que desea buscar: \n");
    scanf("%d", &key);
    b = hay_asoc(key, a, tama);
    if (b == 0)
    {
        printf("No existe la clave en la lista\n");
    }
    else if (b != 0)
    {
        printf("Si existe la clave en la lista\n");
    }

    return 0;
}
