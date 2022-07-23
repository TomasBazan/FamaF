#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "pair.h"

struct s_pair_t
{
    int fst;
    int snd;
};

pair_t pair_new(elem x, elem y)
{
    pair_t nuevoPar = 0;
    nuevoPar = malloc(sizeof(pair_t));
    nuevoPar->fst = x;
    nuevoPar->snd = y;
    return nuevoPar;
}

elem pair_first(pair_t p)
{
    assert(p != NULL);
    elem primero = 0;
    primero = p->fst;

    return primero;
}

elem pair_second(pair_t p)
{
    assert(p != NULL);
    elem segundo = 0;
    segundo = p->snd;

    return segundo;
}

pair_t pair_swapped(pair_t p)
{
    assert(p != NULL);
    pair_t parCambiado = NULL;
    parCambiado = malloc(sizeof(pair_t));
    parCambiado->fst = p->snd;
    parCambiado->snd = p->fst;

    return parCambiado;
}

pair_t pair_destroy(pair_t p)
{
    free (p);
    return 0;
}

/*
En esta especificacion de pari.h hay una capa más de 
abstracción, ya no me interesa que los datos de pair_t
sean int. Ahora son elem
*/