//1
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
int main(void)
{
    /*     int x, y, z, b, w;
    printf("Ingrese un valor para x\n");
    scanf("%d",&x);
    printf("Ingrese un valor para y\n");
    scanf("%d",&y);
    printf("Ingrese un valor para z\n");
    scanf("%d",&z);
    printf("Ingrese 0 para False o 1 para True: \n");
    scanf("%d",&b);
    printf("Ingrese 0 para False o 1 para True: \n");
    scanf("%d",&w);

    printf("x+y+1= %d\n", x+y+1);
    printf("z*z+y*45-15*x= %d\n", z*z+y*45-15*x);
    printf("y*2==(x*3+1) porciento 5= %d\n", y*2==(x*3+1)%5);
    printf("y < x*z =%d\n", y < x*z);
    printf("resto entre x y 4=0: %d\n", x%4==0);
    printf("x + y == 0 ^ y - x == (-1) * z: %d\n", x+y==0 && y-x==(-1)*z);
    printf("not b ^ w: %d\n", !b && w);
 */
    //x->4 y-> (-4) z->8 b->1 w->1

    //Da como resultado 1 o 0
    /* x+y+1= 11
z*z+y*45-15*x= 55
y*2==(x*3+1) porciento 5= 0
y < x*z =1 

x+y+1= 12
z*z+y*45-15*x= 499
y*2==(x*3+1) porciento 5= 0
y < x*z =0
*/

    //a)
    /*
    int x, y;
  
    printf("Ingrese un valor para x: \n");
    scanf("%d", &x);
    assert (x == 1);
    printf("El valor que ingreso es %d\n", x);
    x = 5;
    printf("El nuevo valor de x es: %d\n", x);
 */
    //b)
    /* 
    printf("Ingrese un valor para x: \n");
    scanf("%d", &x);
    assert(x==2);
    printf ("Ingrese un valor para y: \n");
    scanf("%d", &y);
    assert(y==5);
    x= x + y;
    printf("x->%d y->%d \n", x ,y);
    y=y+y;
    printf("x->%d y->%d \n", x ,y);
 */
    //c)
    /*  
    printf("Ingrese un valor para x: \n");
    scanf("%d", &x);
    assert(x==2);
    printf ("Ingrese un valor para y: \n");
    scanf("%d", &y);
    assert(y==5);
    y=y+y;
    printf("y = %d\n", y); 
    x= x + y;
*/

    //////////////////////////////////////////////////////////////////////////////////////////////////4)
    //a)
    /*     int x, y;
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
 */
    //b)
    /*     
    int x, y, z, m;
    printf("Ingrese un valor para x: \n");
    scanf("%d", &x);
    printf("Ingrese un valor para y: \n");
    scanf("%d", &y);
    printf("Ingrese un valor para z: \n");
    scanf("%d", &z);
    m = 0;
*/
    /*    
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
 */
    /////////////////////////////////////////////////////////////////////////////////////////////////5)
    //a)
    /*
    int i;
    printf("Ingrese un valor para i: ");
    scanf("%d", &i);

    while (i != 0)
    {
        i= i-1;
    }
    printf("i = %d \n", i);
 */
    //b)
    //1)
    /*
    int x,y,i;
    printf("Ingrese un valor para x: ");
    scanf("%d", &x);
    printf("Ingrese un valor para y: ");
    scanf("%d", &y);
    i=0;

    while (x >= y)
    {
        x = x-y;
        i = i+1;
    }

antes de entrar al bucle
1: x = 13
2: y = 3
3: i = 0
primer ciclo completado
1: x = 10
2: y = 3
3: i = 1
segundo ciclo completado
1: x = 7
2: y = 3
3: i = 2
tercer ciclo completado
1: x = 4
2: y = 3
3: i = 3
cuarto ciclo completado
1: x = 1
2: y = 3
3: i = 4

    printf("El cociente de la division entre %d y %d es : %d\n",y*i+x ,y, i);
    printf("El resto de la division entre %d y %d es : %d\n",y*i+x ,y, x);
*/
    //2)

    int x, i, res;
    i = 2;
    res = 1;
    printf("Ingrese un valor para x: ");
    scanf("%d", &x);
    while (i < x && res)
    {
        res = res && ((x % i) != 0);
        i = i + 1;
    }
    if (res == 0)
    {
        printf("El numero %d no es primo \n", x);
    }
    else
    {
        printf("El numero %d es primo \n", x);
    }
    return 0;
}
