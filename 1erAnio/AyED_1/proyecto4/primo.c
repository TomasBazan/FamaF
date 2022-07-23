#include <stdio.h>
#include <stdbool.h>
#define tam 5

int esPrimo(int a)
{
    int i = 2;
    while (a % i != 0 && a > 1)
    {
        i += 1;
    }
    return (i == a);
}

int nesimo_primo(int N)
{
    int i = 0;
    int x = 2;
    int nPrimo;
    while (i < N)
    {
        if (esPrimo(x) == false)
        {
            x++;
        }
        else
        {
            nPrimo = x;
            x++;
            i++;
        }
    }

    return nPrimo;
}
int main(void)
{
    int n = -1;
    int primo;
    while (n <= 0)
    {
        printf("Ingrese un numero para indice: \n");
        scanf("%d", &n);
        if (n <= 0)
        {
            printf("Error, no puede ingresar numeros negativos o ceros: \n");
        }
    }
    primo = nesimo_primo(n);
    printf("El primo numero %d es : %d\n", n, primo);
    //puedo hacer 
    //printf("El primo numero %d es : %d\n", n, nesimo_primo(n));
    //ahorro dos lineas
    return 0;
}
