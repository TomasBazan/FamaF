//1
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
int main(void)
{
    int x, y;
    printf("Ingrese un valor para x: \n");
    scanf("%d", &x);
    printf("Ingrese un valor para y: \n");
    scanf("%d", &y);

    if (x >= y)
    {
        x = 0;
    }
    else if (x <= y)
    {
        x = 2;
    }
    printf("El nuevo valor de x es: %d \n", x);

    return 0;
}
