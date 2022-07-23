#include <stdlib.h>
#include <stdbool.h>
#include "list.h"

struct node
{
    list_elem elem;
    struct node *next;
};

list list_empty(void)
{
    list l = NULL;
    return l;
}

list list_addl(list_elem e, list l)
{
    list p = NULL;
    p = malloc(sizeof(struct node));
    p->elem = e;
    p->next = l;
    l = p;
    p = NULL;
    return l;
}

void list_destroy(list l)
{
    list p = NULL;
    while (l != NULL)
    {
        p = l;
        l = l->next;
        free(p);
    }
}

bool list_is_empty(list l)
{
    bool b = l == NULL;
    return b;
}

list_elem list_head(list l)
{
    list_elem e = 0;
    e = l->elem;
    return e;
}

list list_tail(list l)
{
    list p = NULL;
    p = l;
    l = p->next;
    free(p);
    p = NULL;

    return l;
}

list list_addr(list l, int e)
{
    list q = NULL;
    q = malloc(sizeof(struct node));
    q->elem = e;
    q->next = NULL;
    if (!list_is_empty(l))
    {
        list p = NULL;
        p = l;
        while (p->next != NULL)
        {
            p = p->next;
        }
        p->next = q;
    }
    else
    {
        l = q;
    }
    return l;
}

unsigned int list_length(list l)
{
    list p = NULL;
    unsigned int n = 0;
    p = l;
    while (p != NULL)
    {
        n ++;
        p = p->next;
    }
    return n;
}

list list_concat(list l, list l0)
{
    list p = NULL;
    if (!list_is_empty(l))
    {
        p = l;
        while (p->next != NULL)
        {
            p = p->next;
        }
        p->next = l0;
    }
    else
    {
        l = l0;
    }
    return l;
}
list_elem list_index(list l, unsigned int n)
{
    list p = NULL;
    list_elem e = 0;
    unsigned int cont = 1;
    p = l;
    while (cont < n)
    {
        cont++;
        p = p->next;
    }
    e = p->elem;
    return e;
}

list list_take(list l, unsigned int n)
{
    list p = NULL, q = NULL;
    p = l;

    for (unsigned int i = 0; i < n - 1; i++)
    {
        if (p != NULL)
        {
            p = p->next;
        }
    }
    if (p != NULL)
    {
        q = p;
        p = p->next;
        q->next = NULL;
    }
    while (p != NULL)
    {
        q = p;
        p = p->next;
        free(q);
    }
    return l;
}
// funcion se rompe si trato de eliminar el primer elemento?

list list_drop(list l, unsigned int n)
{
    list p = NULL;
    unsigned int cont = 0;
    while (cont < n)
    {
        p = l;
        l = l->next;
        free(p);
        cont = -1;
    }
    return l;
}

list copy_list(list l)
{
    list l2 = NULL, p = NULL, q = NULL;
    l2 = malloc(sizeof(struct node));
    p = l;
    q = l2;
    while (p != NULL)
    {
        q->next = malloc(sizeof(struct node));
        q->elem = p->elem;
        q->next = p->next;
        p = p->next;
    }
    p = NULL;
    q = NULL;
    return l2;
}
