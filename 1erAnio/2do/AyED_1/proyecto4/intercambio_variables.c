#include <stdio.h>

int main(void)
{
    int x, y, z;
    printf("Ingrese un valor para x:\n");
    scanf("%d", &x);
    printf("Ingrese un valor para y:\n");
    scanf("%d", &y);
    z = x;
    x = y;
    y = z;
    printf("El valor x ahora es: %d\n", x);
    printf("El valor y ahora es: %d\n", y);
    return 0;
}