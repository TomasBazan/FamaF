#include <stdio.h>

int main(void)
{
    int x, y, z, y1, z1;
    printf("Ingrese un valor para x:\n");
    scanf("%d", &x);
    printf("Ingrese un valor para y:\n");
    scanf("%d", &y);
    printf("Ingrese un valor para z:\n");
    scanf("%d", &z);
    z1 = z;
    y1 = y;
    z = y + x;
    y = y + x + z1;
    x = y1;
    printf("El valor x ahora es: %d\n", x);
    printf("El valor y ahora es: %d\n", y);
    printf("El valor z ahora es: %d\n", z);
    return 0;
}