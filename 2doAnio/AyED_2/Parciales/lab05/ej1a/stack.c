#include <stdlib.h>
#include <assert.h>
#include "stack.h"

struct _s_stack
{
    stack_elem elem;
    struct _s_stack *next;
};

stack stack_empty()
{
    stack nuevoStack = NULL;

    return nuevoStack;
}

stack stack_push(stack s, stack_elem e)
{
    stack nuevoNodo = NULL;
    nuevoNodo = calloc(1, sizeof(struct _s_stack));
    nuevoNodo->elem = e;
    nuevoNodo->next = s;
    s = nuevoNodo;
    nuevoNodo = NULL;
    return s;
}

stack stack_pop(stack s)
{
    assert(!stack_is_empty(s));
    stack removedor = NULL;
    removedor = s;
    s = s->next;
    free(removedor);
    removedor = NULL;

    return s;
}

unsigned int stack_size(stack s)
{
    stack indice = s;
    unsigned int contador = 0;
    while (indice != NULL)
    {
        contador++;
        indice = indice->next;
    }

    return contador;
}

stack_elem stack_top(stack s)
{
    assert(!stack_is_empty(s));
    stack_elem primerElemento = 0;
    primerElemento = s->elem;

    return primerElemento;
}

bool stack_is_empty(stack s)
{
    bool esVacio = s == NULL;

    return esVacio;
}

stack_elem *stack_to_array(stack s)
{
    stack indiceStack = s;
    unsigned int lenght = stack_size(s);
    stack_elem *stackEnArray = calloc(lenght, sizeof(stack_elem));
    for (int i = lenght - 1; i >= 0; i--)
    {
        stackEnArray[i] = indiceStack->elem;
        indiceStack = indiceStack->next;
    }
    indiceStack = NULL;
    return stackEnArray;
}

stack stack_destroy(stack s)
{
    stack indiceStack = s;
    while (indiceStack != NULL)
    {
        indiceStack = indiceStack->next;
        free(s);
        s = indiceStack;
    }
    return indiceStack;
}