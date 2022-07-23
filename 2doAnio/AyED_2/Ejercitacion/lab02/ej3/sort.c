#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#include "array_helpers.h"
#include "sort_helpers.h"
#include "sort.h"

static unsigned int partition(int a[], unsigned int izq, unsigned int der)
{
    unsigned int pivot = izq,
                 i = izq + 1,
                 j = der;
    while (goes_before(i, j))
    {
        if (goes_before(a[i], a[pivot]))
        {
            i++;
        }
        else if (goes_before(a[pivot], a[j]))
        {
            j--;
        }
        else if (!goes_before(a[i], a[pivot]) &&
                 !goes_before(a[pivot], a[j]))
        {
            swap(a, i, j);
        }
    }
    swap(a, pivot, j);
    pivot = j;
    return pivot;
}

static void quick_sort_rec(int a[], unsigned int izq, unsigned int der)
{
    if (der > izq)
    {
        unsigned int pivot = partition(a, izq, der);

        if (pivot > izq)
        {
            quick_sort_rec(a, izq, pivot - 1);
            quick_sort_rec(a, pivot + 1, der);
        }
        else
        {
            quick_sort_rec(a, izq, pivot);
            quick_sort_rec(a, pivot + 1, der);
        }
    }
}

void quick_sort(int a[], unsigned int length)
{
    quick_sort_rec(a, 0, (length == 0) ? 0 : length - 1);
}
