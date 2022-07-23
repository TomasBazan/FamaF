#include <stdlib.h>
#include <assert.h>
#include <stdbool.h>
#include "pqueue.h"

struct s_pqueue
{
    unsigned int size;
    struct s_node *first;
};

struct s_node
{

    pqueue_elem elem;
    unsigned int priority;
    struct s_node *next;
};

static struct s_node *create_node(pqueue_elem e, unsigned int priority)
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

static bool invrep(pqueue q)
{
    bool invariante = true;
    struct s_node *aux = q->first;
    while (invariante && aux != NULL && aux->next != NULL)
    {
        if (aux->priority > aux->next->priority)
        {
            invariante = false;
        }
        aux = aux->next;
    }
    aux = NULL;
    return invariante;
}

pqueue pqueue_empty(void)
{
    pqueue q = NULL;
    q = calloc(1, sizeof(struct s_pqueue));
    q->size = 0;
    q->first = NULL;
    return q;
}

pqueue pqueue_enqueue(pqueue q, pqueue_elem e, unsigned int priority)
{
    assert(invrep(q));
    struct s_node *new_node = create_node(e, priority);

    if (pqueue_is_empty(q))
    {
        q->first = new_node;
    }
    else
    {
        struct s_node *aux = q->first;
        if (aux->priority > new_node->priority)
        {
            q->first = new_node;
            new_node->next = aux;
            aux = NULL;
        }
        else
        {
            while (aux->next != NULL && new_node->priority >= aux->next->priority)
            {
                aux = aux->next;
            }
            new_node->next = aux->next;
            aux->next = new_node;
            aux = NULL;
        }
    }
    ++q->size;
    return q;
}

bool pqueue_is_empty(pqueue q)
{
    return q->first == NULL;
}

pqueue_elem pqueue_peek(pqueue q)
{
    assert(!pqueue_is_empty(q));
    pqueue_elem maxP = 0;
    maxP = q->first->elem;
    return maxP;
}

unsigned int pqueue_peek_priority(pqueue q)
{
    assert(!pqueue_is_empty(q));
    unsigned int mayP = 0;
    mayP = q->first->priority;
    return mayP;
}

unsigned int pqueue_size(pqueue q)
{
    assert(invrep(q));
    unsigned int size = 0;
    size = q->size;
    return size;
}

pqueue pqueue_dequeue(pqueue q)
{
    assert(!pqueue_is_empty(q));
    struct s_node *aux = q->first;
    q->first = aux->next;
    --q->size;
    free(aux);
    aux = NULL;
    return q;
}

pqueue pqueue_destroy(pqueue q)
{
    assert(invrep(q));
    struct s_node *p = q->first;
    while (p != NULL)
    {
        struct s_node *aux = p;
        p = p->next;
        aux = destroy_node(aux);
    }
    free(q);
    q = NULL;
    assert(q == NULL);
    return q;
}
