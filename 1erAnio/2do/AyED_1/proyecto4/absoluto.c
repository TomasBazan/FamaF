#include <stdio.h>

int main(void)
{
    int n;
    printf("Ingrese un valor para n:\n");
    scanf("%d", &n);
    if (n == 0)
    {
        printf("El valor absoluto de %d es 0\n", n);
    }
    else if (n > 0)
    {
        printf("El valor absoluto de %d es %d\n", n, n);
    }
    else if (n < 0)
    {
        printf("El valor absoluto de %d es %d\n", n, -n);
    }
    return 0;
}