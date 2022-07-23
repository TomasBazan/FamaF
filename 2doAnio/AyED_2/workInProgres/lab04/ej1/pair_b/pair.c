#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "pair.h"

pair_t pair_new(int x, int y)
{
    pair_t nuevoPar = 0;
    nuevoPar = malloc(sizeof(pair_t));
    nuevoPar->fst = x;
    nuevoPar->snd = y;
    return nuevoPar;
}

int pair_first(pair_t p)
{
    assert(p != NULL);
    int primero = 0;
    primero = p->fst;

    return primero;
}

int pair_second(pair_t p)
{
    assert(p != NULL);
    int segundo = 0;
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