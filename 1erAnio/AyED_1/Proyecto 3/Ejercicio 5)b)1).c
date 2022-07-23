#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
int main(void)
{
    int x, y, i;
    printf("Ingrese un valor para x: ");
    scanf("%d", &x);
    printf("Ingrese un valor para y: ");
    scanf("%d", &y);
    i = 0;

    while (x >= y)
    {
        x = x - y;
        i = i + 1;
    }

    /* 
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
 */
    return 0;
}
