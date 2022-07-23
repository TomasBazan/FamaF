#include "arrayManagement.h"
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

void dumpArray(char a[], unsigned int length)
{
    printf("\"");
    for (unsigned int j = 0u; j < length; j++)
    {
        printf("%c", a[j]);
    }
    printf("\"");
    printf("\n\n");
}

void sortingArray(char palabraOrdenada[], unsigned int indices[], char letras[], unsigned int length)
{
    for (unsigned int i = 0; i < length; i++)
    {
        if (indices[i] > length) 
        {
        printf("ERROR: error al indexar palabras (MAL!!)\n");
        exit(EXIT_FAILURE);
        }
        palabraOrdenada[(indices[i])] = letras[i];
    }
}
