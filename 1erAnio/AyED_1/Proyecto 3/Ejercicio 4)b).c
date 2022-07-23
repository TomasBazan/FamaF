#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
int main(void)
{
    int x, y, z, m;
    printf("Ingrese un valor para x: \n");
    scanf("%d", &x);
    printf("Ingrese un valor para y: \n");
    scanf("%d", &y);
    printf("Ingrese un valor para z: \n");
    scanf("%d", &z);
    m = 0;

    if (x < y)
    {
        m = x;
    }
    else
    {
        m = y;
    }
    printf("El minimo entre x e y es: %d \n", m);

    if (m < z)
    {
    }
    else
    {
        m = z;
    }
    printf("El minimo entre x,z e y es: %d \n", m);

    //Muestra el minimo entre x,z  e y
    return 0;
}
