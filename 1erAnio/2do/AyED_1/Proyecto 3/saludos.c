#include <stdio.h>
#include <stdbool.h>

int main(void)
{
    imprimeHola();
    imprimeHola();
    imprimeChau();
    imprimeChau();
    return 0;
}
void imprimeHola(void)
{
    printf("hola\n");
}
void imprimeChau(void)
{
    printf("chau\n");
}