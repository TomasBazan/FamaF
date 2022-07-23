#include "array_helpers.h"
#include <assert.h>
#include "mybool.h"
#include <stdio.h>
#include <stdlib.h>

unsigned int array_from_file(int array[], unsigned int max_size, const char *filepath)
{

    unsigned int i = 0;
    int num = 0;
    unsigned int length = max_size;
    FILE *f;
    f = fopen(filepath, "r");
    fscanf(f, "%u \n", &length);
    while (i < length)
    {
        fscanf(f, "%d", &num);
        array[i] = num;
        i++;
    }
    fclose(f);
    return length;
}

void array_dump(int a[], unsigned int length)
{
    if (length == 0)
    {
        printf("[]\n");
    }
    else
    {
        printf("[ ");
        for (unsigned int i = 0; i < length; i++)
        {
            if (i == length - 1)
            {
                printf(" %d ] \n", a[i]);
            }
            else
            {
                printf(" %d,", a[i]);
            }
        }
    }
}

mybool array_is_sorted(int a[], unsigned int length)
{
    mybool sorted = true ;
    if (length == 0)
    {
        printf("El arreglo esta vacio\n");
    }
    
    for (unsigned int i = 0; i < length-1; i++)
    {
        if (a[i] <= a[i+1] && sorted)
        {
            sorted = true;
        }
        else
        {
            sorted = false;
        }
        
    }
    
    return sorted;
}
