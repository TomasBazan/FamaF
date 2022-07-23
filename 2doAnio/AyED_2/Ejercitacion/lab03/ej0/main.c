#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "arrayManagement.h"
#define MAX_SIZE 1000


unsigned int data_from_file(const char *path,
                            unsigned int indexes[],
                            char letters[],
                            unsigned int max_size)
{

    unsigned int length = max_size;
    FILE *file;
    file = fopen(path, "r");
    unsigned int i = 0;
    while (!feof(file))
    {
        fscanf(file, "%u '%c'\n", &(indexes[i]), &(letters[i]));
        /* testing:
        printf("%u\n", indexes[i]);
        printf("%c\n", letters[i]);
         */
        if (i > max_size)
        {
            printf("El arreglo es muy grande\n");
            exit(EXIT_FAILURE);
        }
        
        i++;
    }
    fclose(file);
    length = i;
    return length;
}

char *parse_filepath(int argc, char *argv[])
{
    char *resultado = NULL;
    bool validarArgumentos = (argc == 2);
    if (!validarArgumentos)
    {
        printf("Error de formato \n");
        exit(EXIT_FAILURE);
    }
    resultado = argv[1];
    return resultado;
}

int main(int argc, char *argv[])
{
    char *path = NULL;
    unsigned int indexes[MAX_SIZE];
    char letters[MAX_SIZE];
    char sorted[MAX_SIZE];
    unsigned int length = 0;

    path = parse_filepath(argc, argv);
    length = data_from_file(path, indexes, letters, MAX_SIZE);
  
    sortingArray(sorted, indexes, letters, length);
    dumpArray(sorted, length);

    return EXIT_SUCCESS;
}
