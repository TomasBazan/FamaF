#include <stdio.h>
#include <stdbool.h>

typedef struct 
{
    int cociente;
    int resto;
}div_t;

div_t division(int x, int y)
{
    div_t resultado;
    resultado.cociente = x / y;
    resultado.resto = x % y;
    return resultado;
}

int main(void)
{
    int dividendo, divisor;
    printf("Ingrese un numero que quiera dividir\n");
    scanf("%d", &dividendo);
    printf("Ingrese el divisor del numero anterior: \n");
    scanf("%d", &divisor);
    if (divisor != 0)
    {
        div_t resultado;
        resultado = division(dividendo, divisor);

        printf("el resultado de la division es: %d \n", resultado.cociente);
        printf("el resto es: %d \n", resultado.resto);
    }

    else
    {
        printf("Error: no se puede dividir por cero\n");
    }

    return 0;
}
