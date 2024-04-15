#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
int main(void)
{
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