#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

typedef struct
{
    int horas;
    int minutos;
    int segundos;
} lapso_t;
lapso_t calcular_lapso(int segs)
{
    lapso_t lapso;
    lapso.horas = segs / 3600;
    lapso.minutos = (segs % 3600) / 60;
    lapso.segundos = (segs % 3600) % 60; 
    return lapso;
}
int main(void)
{
    int segs;
    lapso_t lapso;
    printf("Ingrese una cantidad de segundos: \n");
    scanf("%d", &segs);
    if (segs < 0)
    {
        printf("Error: los segundos no pueden ser negativos \n");
    }
    else if (segs >= 0)
    {
        lapso= calcular_lapso(segs);
        printf("La cantidad de segundos que ingreso equivale a %d horas, %d minutos y %d segundos\n", lapso.horas,lapso.minutos,lapso.segundos);
    }

    return 0;
}