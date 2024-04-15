#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
int main(void)
{
    int x, y, z, b, w;
    printf("Ingrese un valor para x\n");
    scanf("%d", &x);
    printf("Ingrese un valor para y\n");
    scanf("%d", &y);
    printf("Ingrese un valor para z\n");
    scanf("%d", &z);
    printf("Ingrese 0 para False o 1 para True: \n");
    scanf("%d", &b);
    printf("Ingrese 0 para False o 1 para True: \n");
    scanf("%d", &w);

    printf("x+y+1= %d\n", x + y + 1);
    printf("z*z+y*45-15*x= %d\n", z * z + y * 45 - 15 * x);
    printf("y*2==(x*3+1) porciento 5= %d\n", y * 2 == (x * 3 + 1) % 5);
    printf("y < x*z =%d\n", y < x * z);
    printf("resto entre x y 4=0: %d\n", x % 4 == 0);
    printf("x + y == 0 ^ y - x == (-1) * z: %d\n", x + y == 0 && y - x == (-1) * z);
    printf("not b ^ w: %d\n", !b && w);

    //x->4 y-> (-4) z->8 b->1 w->1

    //Da como resultado 1 o 0
    /* 
    x+y+1= 11
    z*z+y*45-15*x= 55
    y*2==(x*3+1) porciento 5= 0
    y < x*z =1 

    x+y+1= 12
    z*z+y*45-15*x= 499
    y*2==(x*3+1) porciento 5= 0
    y < x*z =0
    */
    return 0;
}
