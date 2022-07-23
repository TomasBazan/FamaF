#include <assert.h>
#include "pair.h"

pair_t pair_new(int x, int y)
{
    pair_t nuevoPar;
    nuevoPar.fst = x;
    nuevoPar.snd = y;

    return nuevoPar;
}

int pair_first(pair_t p)
{
    int primero;
    primero = p.fst;

    assert(primero = p.fst);
    return primero;
}

int pair_second(pair_t p)
{
    int segundo;
    segundo = p.snd;

    return segundo;
}

pair_t pair_swapped(pair_t p)
{
    pair_t invertido;
    invertido = pair_new(p.snd, p.fst);

    return invertido;
}

pair_t pair_destroy(pair_t p)
{
    return p;
}
