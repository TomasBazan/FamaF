#include <stdlib.h>
#include <stdio.h>

#include "stack.h"

void array_dump(stack_elem a[], unsigned int length)
{
    fprintf(stdout, "el tamanio del arreglo es: %u\nEl arreglo es: \n", length);
    for (unsigned int i = 0u; i < length; ++i)
    {
        fprintf(stdout, "%i", a[i]);
        if (i < length - 1)
        {
            fprintf(stdout, " ");
        }
        else
        {
            fprintf(stdout, "\n");
        }
    }
}

int main()
{
    stack nuevoStack = stack_empty();
    unsigned int length = 0;

    nuevoStack = stack_push(nuevoStack, 3);
    nuevoStack = stack_push(nuevoStack, 4);
    nuevoStack = stack_push(nuevoStack, 3);
    nuevoStack = stack_push(nuevoStack, 4);
    nuevoStack = stack_push(nuevoStack, 3);
    nuevoStack = stack_push(nuevoStack, 4);


    printf("el top es : %d\n", stack_top(nuevoStack));

    // nuevoStack = stack_pop(nuevoStack);
    //  nuevoStack = stack_pop(nuevoStack);

    length = stack_size(nuevoStack);
    stack_elem *array = stack_to_array(nuevoStack);
    array_dump(array, length);

    stack_destroy(nuevoStack);
    nuevoStack = NULL;
    // array_dump(array, length);
    free(array);
    return EXIT_SUCCESS;
}