#include <stdio.h>
#include <assert.h>

void imprimeHola()
{printf("Hola \n");
}
void holaHasta(int n)
{
    while (n > 0)
    {
        imprimeHola();
        n = n - 1;
    }
}
int main(void)
{
    int n;
    printf("Ingrese un numero: \n");
    scanf("%d", &n);
    assert(n>0);
    holaHasta(n);
    return 0;
}
//falta el b
