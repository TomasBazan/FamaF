#include <stdio.h>
#include <stdbool.h>

typedef struct _persona
{
    char *nombre;
    int edad;
    float altura;
    float peso;
} persona_t;

float peso_promedio(persona_t arr[], unsigned int longitud)
{
    float prom = 0;
    persona_t persona;
    unsigned int i = 0;
    while (i < longitud)
    {
        persona = arr[i];
        prom += persona.peso;
        i++;
    }
    prom = prom / longitud;
    return prom;
}
persona_t persona_de_mayor_edad(persona_t arr[], unsigned int longitud)
{
    persona_t vieje = arr[0];
    unsigned int i = 0;

    while (i < longitud)
    {
        if (vieje.edad <= arr[i].edad)
        {
            vieje = arr[i];
        }
        i++;
    }
    return vieje;
}
persona_t persona_de_menor_altura(persona_t arr[], unsigned int longitud) 
{
    persona_t enane = arr[0];
    unsigned int i = 0;

    while (i < longitud)
    {
        if (enane.altura >= arr[i].altura)
        {
            enane = arr[i];
        }
        i++;
    }
    return enane;
}

int main(void)
{
    persona_t p1 = {"Paola", 21, 1.85, 75};
    persona_t p2 = {"Luis", 54, 1.75, 69};
    persona_t p3 = {"Julio", 40, 1.70, 80};
    unsigned int longitud = 3;
    persona_t arr[] = {p1, p2, p3};
    printf("El peso promedio es %f\n", peso_promedio(arr, longitud));
    persona_t p = persona_de_mayor_edad(arr, longitud);
    printf("El nombre de la persona con mayor edad es %s\n", p.nombre);
    p = persona_de_menor_altura(arr, longitud);
    printf("El nombre de la persona con menor altura es %s\n", p.nombre);
    return 0;
}
