#include <stdio.h>
#include <assert.h>

int main(void)
{
    int x, y;
    printf("Ingrese un numero: \n");
    scanf("%d", &x);
    printf("Ingrese otro numero: \n");
    scanf("%d", &y);
    assert(x != y);
    if (x < y)
    {
        printf("El minimo es %d y el maximo es %d\n", x, y);
    }
    else if (x > y)
    {
        printf("El minimo es %d y el maximo es %d\n", y, x);
    }
    return 0;
}