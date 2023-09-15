#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

#include "APIG23.h"
#include "APIParte2.h"
#include "EstructuraGrafo23.h"
void OrdenNatural(u32 n, u32* Orden) {
    for (u32 i = 0; i < n; i++) {
        Orden[i] = i;
    }
}
void swap_arrays(u32** arr1, u32** arr2) {
    u32* temp = *arr1;
    *arr1 = *arr2;
    *arr2 = temp;
}

int main() {
    FILE* fp;
    // cambiar el primer parametro para probar otros casos, probar my_grafo_papi.txt no deberia andar
    fp = fopen("Grafos/test.txt", "r");
    if (fp == NULL) {
        printf("Error: could not open file.\n");
        return 1;
    }
    Grafo my_graph = ConstruirGrafo(fp);
    // Aca tengo que llamar a Construir Grafo mandandole el fp

    printf("Hola2");
    u32 n = NumeroDeVertices(my_graph);
    u32* Orden = calloc(n, sizeof(u32));
    u32* Color = calloc(n, sizeof(u32));
    u32* Color_2 = calloc(n, sizeof(u32));
    u32 elegir = 0;
    u32 min_num_crom = n + 2;

    printf("antes de greedy\n");
    OrdenNatural(n, Orden);
    u32 num_crom_4 = Greedy(my_graph, Orden, Color);

    printf("coloreo inicial con %d colores\n", min_num_crom);
    u32 color_greedy, color_greedy_2;

    printf("a");
    char char_2 = OrdenJedi(my_graph, Orden, Color);
    color_greedy_2 = Greedy(my_graph, Orden, Color);

    printf("minimo coloreo despues de Jedy y ImparPar: %d\n", min_num_crom);

    free(Orden);
    free(Color);
    free(Color_2);
    Orden = NULL;
    Color = NULL;

    DestruirGrafo(my_graph);
    fclose(fp);

    return 0;
}
