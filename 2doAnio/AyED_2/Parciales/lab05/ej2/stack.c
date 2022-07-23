#include <stdlib.h>
#include <assert.h>
#include "stack.h"

struct _s_stack
{
    stack_elem *elems;     // Arreglo de elementos
    unsigned int size;     // Cantidad de elementos en la pila
    unsigned int capacity; // Capacidad actual del arreglo elems
};

stack stack_empty()
{
    stack nuevoStack = calloc(1, sizeof(struct _s_stack));
    nuevoStack->elems = NULL;
    nuevoStack->size = 0;
    nuevoStack->capacity = 0;

    return nuevoStack;
}

stack stack_push(stack s, stack_elem e)
{
    assert(s != NULL);
    assert(s->capacity >= s->size);

    if (s->size == s->capacity)
    {
        unsigned int nuevaCapacidad = (s->size == 0) ? 1 : 2 * s->size;
        s->elems = realloc(s->elems, sizeof(s->elems) * 2);
        s->capacity = nuevaCapacidad;
    }
    s->elems[s->size] = e;
    s->size++;
    return s;
}

stack stack_pop(stack s)
{
    s->elems[s->size] = 0;
    s->size--;
    return s;
}

unsigned int stack_size(stack s)
{
    return s->size;
}

stack_elem stack_top(stack s)
{
    return s->elems[s->size -1];
}

bool stack_is_empty(stack s)
{
    return s == NULL;
}

stack_elem *stack_to_array(stack s)
{
    stack_elem *a = NULL;
    unsigned int i = 0;
    a = calloc (s->size, sizeof(stack_elem));
    while (i < s->size)
    {
        a[i] = s->elems[i];
        i++;
    }
    
    return a;
}

stack stack_destroy(stack s)
{
    assert(!stack_is_empty(s));
    free(s);
    s = NULL;
    return s;
}