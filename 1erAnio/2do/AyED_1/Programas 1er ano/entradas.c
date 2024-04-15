#include <stdio.h>
#include <stdbool.h>

int main(void)
{
    imprimeEntero(pedirEntero());
    return 0;
}
int pedirEntero(void)
{
    int x;
    printf("Ingrese un numero: \n");
    scanf("%d", &x);
    return x;
}
void imprimeEntero(int x)
{
    int entrada;
    entrada = x;
    printf("El numero que ingreso es: %d\n", entrada);
}