#include <stdio.h>
#include <stdbool.h>

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
bool existe_positivo(int a[], int tam)
{
    int i = 0;
    bool existe = 0;
    while (i < tam)
    {
        if (0 < a[i])
        {
            existe = true;
        }
        i++;
    }
    return existe;
}
bool todos_positivos(int a[], int tam)
{
    int i = 0;
    bool x = true;
    while (i < tam)
    {
        if (0 > a[i])
        {
            x = false;
        }
        i++;
    }
    return x;
}
int main(void)
{
#define tam 5
    int elegirfun;
    int a[tam];
    bool x;
    pedirArreglo(a, tam);
    printf("Inserte 1 si quiere verificar si existe un numero positivo en la lista, \no 2 si quiere verificar si todos los elementos de la lista son positivos\n");
    scanf("%d", &elegirfun);

    if (elegirfun == 1)
    {
        x = existe_positivo(a, tam);
        if (x == true)
        {
            printf("Existe al menos un numero positivo\n");
        }
        else
        {
            printf("No existe ningun numero positivo\n");
        }
    }
    else if (elegirfun == 2)
    {
        x = todos_positivos(a, tam);
        if (x == true)
        {
            printf("Todos los numeros son positivos\n");
        }
        else
        {
            printf("No todos los numeros son positivos\n");
        }
    }
    else
    {
        printf("Error: la opcion ingresada no es valida\n");
    }

    return 0;
}
