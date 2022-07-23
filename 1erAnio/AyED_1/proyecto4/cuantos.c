#include <stdio.h>
#include <stdbool.h>
#define tam 5

void pedirArreglo(int a[], int tama)
{
    int i = 0;
    while (i < tama)
    {
        printf("Ingrese el %d elemento de la lista: \n", i + 1);
        scanf("%d", &a[i]);
        i++;
    }
}

typedef struct
{
    int menores;
    int iguales;
    int mayores;
} comp_t;

comp_t cuantos(int a[], int tama, int elem)
{
    int i = 0;
    comp_t contador;
    contador.menores = 0;
    contador.iguales = 0;
    contador.mayores = 0;
    while (i < tama)
    {
        if (elem < a[i])
        {
            contador.mayores++;
        }
        else if (elem == a[i])
        {
            contador.iguales++;
        }
        else if (elem > a[i])
        {
            contador.menores++;
        }
        i++;
    }
    return contador;
}

int main(void)
{
    int a[tam];
    int num;
    comp_t contador;
    pedirArreglo(a, tam);
    printf("Ingrese un numero para comparar: \n");
    scanf("%d", &num);
    contador = cuantos(a, tam, num);
    printf("Cantidad de numeros iguales: %d\n", contador.iguales);
    printf("Cantidad de numeros mayores: %d\n", contador.mayores);
    printf("Cantidad de numeros menores: %d\n", contador.menores);
    return 0;
}
