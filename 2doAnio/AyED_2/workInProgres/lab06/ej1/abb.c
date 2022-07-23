#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include "abb.h"

struct _s_abb
{
    abb_elem elem;
    struct _s_abb *left;
    struct _s_abb *right;
};

static bool elem_eq(abb_elem a, abb_elem b)
{
    return a == b;
}

static bool elem_less(abb_elem a, abb_elem b)
{
    return a < b;
}

static bool invrep(abb tree)
{
    return tree == NULL ||
           // El elemento a la izquierda es valido
           ((tree->left == NULL || tree->elem > tree->left->elem) &&
            // El elemento a la derecha es valido
            (tree->right == NULL || tree->elem < tree->right->elem) &&
            // El arbol de la izquierda es valido
            invrep(tree->left) &&
            // El arbol de la derecha es valido
            invrep(tree->right));
}

abb abb_empty(void)
{
    abb tree;
    tree = NULL;
    assert(invrep(tree) && abb_is_empty(tree));
    return tree;
}

abb abb_add(abb tree, abb_elem e)
{
    assert(invrep(tree));
    if (tree == NULL)
    {
        tree = malloc(sizeof(struct _s_abb));
        tree->elem = e;
        tree->left = NULL;
        tree->right = NULL;
    }
    else
    {
        if (!elem_eq(tree->elem, e))
        {
            if (elem_less(e, tree->elem))
            {
                tree->left = abb_add(tree->left, e);
            }
            else
            {
                tree->right = abb_add(tree->right, e);
            }
        }
    }
    assert(invrep(tree) && abb_exists(tree, e));
    return tree;
}

bool abb_is_empty(abb tree)
{
    bool is_empty = false;
    assert(invrep(tree));
    is_empty = tree == NULL;
    return is_empty;
}
bool abb_exists(abb tree, abb_elem e)
{
    bool exists = false;
    assert(invrep(tree));
    if (abb_is_empty(tree))
    {
        return exists;
    }
    else
    {
        if (tree->elem == e)
        {
            exists = true;
        }
        else
        {
            if (elem_less(e, tree->elem))
            {
                exists = abb_exists(tree->left, e);
            }
            else
            {
                exists = abb_exists(tree->right, e);
            }
        }
    }
    return exists;
}

unsigned int abb_length(abb tree)
{
    unsigned int length = 0;
    assert(invrep(tree));
    if (!abb_is_empty(tree))
    {

        length += abb_length(tree->left);
        length += abb_length(tree->right);
        length++;
    }
    assert(invrep(tree) && (abb_is_empty(tree) || length > 0));
    return length;
}

abb abb_remove(abb tree, abb_elem e)
{
    assert(invrep(tree));
    // caso base: si es hoja devuelvo null
    if (abb_exists(tree, e))
    {
        if (!elem_eq(tree->elem, e))
        {
            if (elem_less(e, tree->elem))
            {
                tree->left = abb_remove(tree->left, e);
            }
            else
            {
                tree->right = abb_remove(tree->right, e);
            }
        }
        else
        {
            if (abb_is_empty(tree->left) && abb_is_empty(tree->right))
            {
                free(tree);
                tree = NULL;
            }
            else
            {
                if (!abb_is_empty(tree->right))
                {
                    tree->elem = abb_min(tree->right);
                    tree->right = abb_remove(tree->right, tree->elem);
                }
                else
                {
                    tree->elem = abb_max(tree->left);
                    tree->left = abb_remove(tree->left, tree->elem);
                }
            }
        }
    }
    assert(invrep(tree) && !abb_exists(tree, e));
    return tree;
}

abb_elem abb_root(abb tree)
{
    abb_elem root;
    assert(invrep(tree) && !abb_is_empty(tree));
    root = tree->elem;
    assert(abb_exists(tree, root));
    return root;
}

abb_elem abb_max(abb tree)
{
    abb_elem max_e;
    assert(invrep(tree) && !abb_is_empty(tree));
    if (!abb_is_empty(tree->right))
    {
        max_e = abb_max(tree->right);
    }
    else
    {
        max_e = tree->elem;
    }
    assert(invrep(tree) && abb_exists(tree, max_e));
    return max_e;
}

abb_elem abb_min(abb tree)
{
    abb_elem min_e;
    assert(invrep(tree) && !abb_is_empty(tree));
    if (!abb_is_empty(tree->left))
    {
        min_e = abb_min(tree->left);
    }
    else
    {
        min_e = tree->elem;
    }
    assert(invrep(tree) && abb_exists(tree, min_e));
    return min_e;
}

void abb_dump(abb tree)
{
    assert(invrep(tree));
    if (tree!= NULL )
    {
        printf("%d ",tree->elem);
        abb_dump(tree->left);
        abb_dump(tree->right);
    }
}

abb abb_destroy(abb tree)
{
    assert(invrep(tree));
    if (tree->left != NULL)
    {
        abb_destroy(tree->left);
    }
    if (tree->right != NULL)
    {
        abb_destroy(tree->right);
    }
    free(tree);
    tree = NULL;
    assert(tree == NULL);
    return tree;
}
