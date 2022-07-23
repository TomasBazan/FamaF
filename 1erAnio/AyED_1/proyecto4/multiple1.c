#include <stdio.h>

int main(void)
{
    int x, y;
    printf("Ingrese un valor para x:\n");
    scanf("%d", &x);
    printf("Ingrese un valor para y:\n");
    scanf("%d", &y);
    y = x + y;
    x = x + 1;
    printf("El valor x ahora es: %d\n", x);
    printf("El valor y ahora es: %d\n", y);
    return 0;
}