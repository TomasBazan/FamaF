#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>
#include "pstack.h"

struct s_pstack
{
    unsigned int size;
    struct s_node *first;
};

struct s_node
{
    pstack_elem elem;
    priority_t priority;
    struct s_node *next;
};

static struct s_node *create_node(pstack_elem e, priority_t priority)
{
    struct s_node *new_node = NULL;
    new_node = calloc(1, sizeof(struct s_node));
    assert(new_node != NULL);
    new_node->elem = e;
    new_node->priority = priority;
    new_node->next = NULL;
    return new_node;
}

static struct s_node *destroy_node(struct s_node *node)
{
    assert(node != NULL);
    free(node);
    node = NULL;
    assert(node == NULL);
    return node;
}

static bool invrep(pstack s)
{
    bool invariante = true;
    struct s_node *aux = s->first;
    while (invariante && aux != NULL && aux->next != NULL)
    {
        if (aux->priority < aux->next->priority)
        {
            invariante = false;
        }
        aux = aux->next;
    }
    
    return invariante;
}

pstack pstack_empty(void)
{
    pstack s = NULL;
    s = calloc(1, sizeof(struct s_pstack));
    s->size = 0;
    s->first = NULL;
    return s;
}

pstack pstack_push(pstack s, pstack_elem e, priority_t priority)
{
    assert(invrep(s));
    struct s_node *new_node = create_node(e, priority);
    if (pstack_is_empty(s))
    {
        s->first = new_node;
    }
    else
    {
        struct s_node *aux = s->first;
        if (new_node->priority >= aux->priority)
        {
            new_node->next = aux;
            s->first = new_node;
        }
        else
        {
            while (aux->next != NULL && new_node->priority < aux->next->priority)
            {
                aux = aux->next;
            }
            new_node->next = aux->next;
            aux->next = new_node;
        }
        aux = NULL;
    }
    ++s->size;

    return s;
}

bool pstack_is_empty(pstack s)
{
    return s->size == 0;
}

pstack_elem pstack_top(pstack s)
{
    assert(!pstack_is_empty(s));
    pstack_elem elem = s->first->elem;
    return elem;
}

priority_t pstack_top_priority(pstack s)
{
    priority_t topPriority = s->first->priority;
    return topPriority;
}

unsigned int pstack_size(pstack s)
{
    assert(invrep(s));
    unsigned int size = s->size;
    return size;
}

pstack pstack_pop(pstack s)
{
    assert(invrep(s) && !pstack_is_empty(s));
    struct s_node *aux = s->first;
    s->first = aux->next;
    aux = destroy_node(aux);
    s->size = s->size - 1;
    return s;
}

pstack pstack_destroy(pstack s)
{
    assert(invrep(s));
    struct s_node *aux = NULL;
    while (s->first != NULL)
    {
        aux = s->first;
        s->first = aux->next;
        free(aux);
    }
    free(s);
    s = NULL;
    assert(s == NULL);
    return s;
}
