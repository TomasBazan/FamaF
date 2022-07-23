//1
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
int main(void)
{
    int x, y;
    printf("Ingrese un valor para x: \n");
    scanf("%d", &x);
    assert(x == 1);
    printf("El valor que ingreso es %d\n", x);
    x = 5;
    printf("El nuevo valor de x es: %d\n", x);

    return 0;
}
