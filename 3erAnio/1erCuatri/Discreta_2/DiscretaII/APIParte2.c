#include "APIParte2.h"

#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct set_vetices {
    u32 *vertices;
    u32 len_vertices;
    u32 color;
    u32 fun_grado;
} set_vertices;

int cmp_fun_grado(const void *a, const void *b) {
    set_vertices *x = (const set_vertices *)a;
    set_vertices *y = (const set_vertices *)b;

    return y->fun_grado - x->fun_grado;
}

int cmp_ascendente(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int cmp_desc(const void *a, const void *b) {
    int num1 = *((int *)a);
    int num2 = *((int *)b);
    return num2 - num1;
}

// esta funcion devuelve el primer color disponible para un vertice de acuerdo a los colores de sus vecinos
static u32 primer_color_disponible(u32 i, Grafo G, u32 *Orden, u32 *Color) {
    u32 n = NumeroDeVertices(G);
    u32 min_col = 0;
    u32 vertice = Orden[i];
    u32 grado_vertice = Grado(vertice, G);
    u32 ultimo_color_chequeado = n + 2;  // inicializacion en un color que no se usa nunca en greedy
    u32 *vecinos_colores = calloc(grado_vertice, sizeof(u32));

    for (u32 i = 0; i < grado_vertice; i++) {
        vecinos_colores[i] = Color[IndiceVecino(i, vertice, G)];
    }

    qsort(vecinos_colores, grado_vertice, sizeof(u32), cmp_ascendente);

    // como el array esta ordenado de menor a mayor si mi color es menor que el minimo
    // puedo usarlo
    if (min_col < vecinos_colores[0]) {
        free(vecinos_colores);
        vecinos_colores = NULL;
        return min_col;
    }

    for (u32 i = 0; i < grado_vertice; i++) {
        // si llego a un vertice que aun no fue coloreado no lo miro ni a los siguientes
        if (vecinos_colores[i] == n + 2) {
            free(vecinos_colores);
            vecinos_colores = NULL;
            return min_col;
        }

        // si el color esta repetido no lo miro
        while (vecinos_colores[i] == ultimo_color_chequeado) {
            i++;
        }

        // si el color es igual al minimo que quiero usar aumento mi minimo pues no puedo usar
        // ese color ya que lo tiene un vecino de mi vertice
        if (min_col == vecinos_colores[i]) {
            ultimo_color_chequeado = vecinos_colores[i];
            min_col++;
        } else {  // si no es igual quiere decir que min_col es menor por el orden ascendente uso este min_col
            free(vecinos_colores);
            vecinos_colores = NULL;
            return min_col;
        }
    }

    free(vecinos_colores);
    vecinos_colores = NULL;

    return min_col;
}

// funcion encargada de asignar el minimo color posible a un vertice i y actualizar el maximo color usado
//  ya que max_color_used + 1 es la cant de colores que use para greedy en total
static u32 asignar_color(u32 i, Grafo G, u32 *Orden, u32 *Color, u32 max_color_used) {
    u32 color = primer_color_disponible(i, G, Orden, Color);

    if (max_color_used < color) {
        max_color_used = color;
    }

    Color[Orden[i]] = color;
    return max_color_used;
}

u32 Greedy(Grafo G, u32 *Orden, u32 *Color) {
    u32 n = NumeroDeVertices(G);
    u32 max_color_used = 0;

    // inicializo el color de todos los vertices en n+2 este color no se usaria nunca en un coloreo propio
    for (u32 i = 0; i < n; i++) {
        Color[i] = n + 2;
    }

    // asignar el primer color al primer vertice
    Color[Orden[0]] = 0;

    // asignar el minimo color posible a los demas vertices
    for (u32 i = 1; i < n; i++) {
        max_color_used = asignar_color(i, G, Orden, Color, max_color_used);
    }

    // el maximo color usado + 1 es la cantidad de colores usados
    return max_color_used + 1;
}

struct data_colores {
    u32 cantidad;
    u32 *indices;
};

// encuentra el maximo valor de un array
u32 max_elem_array(u32 arr[], u32 n) {
    unsigned int max_val = 0;

    for (u32 i = 0; i < n; i++) {
        if (arr[i] > max_val) {
            max_val = arr[i];
        }
    }
    return max_val;
}

char OrdenImparPar(u32 n, u32 *Orden, u32 *Color) {
    u32 cantcol = max_elem_array(Color, n) + 1;

    // pido memoria para el array por colores
    struct data_colores *colores = calloc(cantcol, sizeof(struct data_colores));
    if (colores == NULL) {
        return 1;
    }
    // pido memoria para cada array interno
    for (u32 i = 0; i < cantcol; i++) {
        colores[i].indices = calloc(n, sizeof(u32));
        // si hay error al pedir memoria
        if (colores[i].indices == NULL) {
            for (u32 j = 0; j < i; j++) {
                free(colores[j].indices);
                colores[j].indices = NULL;
            }

            free(colores);
            colores = NULL;

            return 1;
        }
        colores[i].cantidad = 0;
    }

    // pedi toda la memora ahora recorro

    for (u32 i = 0; i < n; i++) {
        u32 color_a_cargar = Color[i];
        u32 index = colores[color_a_cargar].cantidad;

        colores[color_a_cargar].indices[index] = i;
        colores[color_a_cargar].cantidad++;
    }

    // ahora recorro los colores y cargo Orden
    // cargar colores impares
    u32 iterar_color = 1;

    // mientras el color sea valido en mi coloreo
    u32 i = 0;
    while (iterar_color < cantcol && i < n) {
        u32 counter = 0;
        // cargo todos los vertices del color iterar_color
        while (counter < colores[iterar_color].cantidad) {
            Orden[i] = colores[iterar_color].indices[counter];
            counter++;
            i++;
        }
        // itero el siguiente color impar
        iterar_color += 2;
    }

    // cargar colores pares
    iterar_color = 0;

    // mientras el color sea valido en mi coloreo
    while (iterar_color < cantcol) {
        u32 counter = 0;
        // cargo todos los vertices del color iterar_color
        while (counter < colores[iterar_color].cantidad) {
            Orden[i] = colores[iterar_color].indices[counter];
            counter++;
            i++;
        }
        // itero el siguiente color impar
        iterar_color += 2;
    }

    assert(i == n);

    // libero la memoria pedida
    for (u32 i = 0; i < cantcol; i++) {
        free(colores[i].indices);
        colores[i].indices = NULL;
    }

    free(colores);
    colores = NULL;

    return 0;
}

static char cargar_vertices_mismo_color(Grafo G, set_vertices *aux_struct, u32 *Color, u32 n, u32 r) {
    u32 acum, indice_vertices;
    u32 x = 0;
    for (u32 i = 0; i < r; i++) {
        // me voy fijando en cada color y agrego espacio para los vertices, la cantidad inicial de vertices con ese color es 0
        indice_vertices = 0;
        acum = 0;
        aux_struct[i].color = i;
        aux_struct[i].vertices = calloc(n, sizeof(u32));

        if (aux_struct[i].vertices == NULL) {
            for (u32 k = 0; k < i; k++) {
                free(aux_struct[k].vertices);
                aux_struct[k].vertices = NULL;
            }
            free(aux_struct);
            aux_struct = NULL;
            return '1';
        }

        aux_struct[i].len_vertices = 0;
        // sumatoria de grado de los vertices de color i
        // Comparo el color de todos los vertices con el color i
        for (u32 j = 0; j < n; j++) {
            if (Color[j] == i) {
                // voy sumando el grado de los vertices de mismo color
                acum += Grado(j, G);
                aux_struct[i].vertices[x] = j;
                indice_vertices++;
                x++;
            }
        }
        acum = acum * i;
        aux_struct[i].fun_grado = acum;
        aux_struct[i].len_vertices = indice_vertices;
    }
    return '0';
}

static void destroy_same_color(set_vertices *aux_struct, u32 r) {
    for (u32 i = 0; i < r; i++) {
        free(aux_struct[i].vertices);
        aux_struct[i].vertices = NULL;
    }
    free(aux_struct);
    aux_struct = NULL;
}

char OrdenJedi(Grafo G, u32 *Orden, u32 *Color) {
    u32 n = NumeroDeVertices(G);
    set_vertices *vertice_mismo_color;
    u32 acum = 0;
    u32 r = 0;
    u32 incide_vertices = 0;
    char error;

    r = max_elem_array(Color, n) + 1;

    vertice_mismo_color = calloc(r, sizeof(set_vertices));
    if (vertice_mismo_color == NULL) {
        return "";
    }
    // itero en el struct de tamaño colores
    error = cargar_vertices_mismo_color(G, vertice_mismo_color, Color, n, r);
    if (error == '1') {
        return '1';
    }
    qsort(vertice_mismo_color, r, sizeof(set_vertices), cmp_fun_grado);
    // iterador de r ergo colores
    // for (u32 i = 0; (i < r); i++) {
    //    // j es el que recorre adentro de cada arreicito de vertices de mismo color
    //    for (u32 j = 0; j < vertice_mismo_color[i].len_vertices; j++) {
    //        Orden[incide_vertices] = vertice_mismo_color[i].vertices[j];
    //        incide_vertices++;
    //    }
    //}
    int ri = 0;
    int x;
    for (u32 i = 0; i < n; i++) {
        x = vertice_mismo_color[ri].len_vertices;
        // j es el que recorre adentro de cada arreicito de vertices de mismo color
        while (i < i + x) {
            Orden[i] = vertice_mismo_color[ri].vertices[i];
            i++;
            x--;
        }
        printf("c");
        ri++;
    }

    destroy_same_color(vertice_mismo_color, r);
    return '0';
}