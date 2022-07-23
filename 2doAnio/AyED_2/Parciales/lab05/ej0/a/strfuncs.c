#include <stdio.h>
#include <stdlib.h>

#include "strfuncs.h"

size_t string_length(const char *str)
{
    size_t length = 0;
    const char *indice = str;
    while (*indice != '\0')
    {
        length++;
        indice++;
    }
    return length;
}

char *string_filter(const char *str, char c)
{
    char *stringFiltrado = NULL;
    const size_t length = string_length(str);
    size_t ocurreciasC = 0;
    unsigned int i = 0, j = 0;
    while (str[i] != '\0')
    {
        if (str[i] == c)
        {
            ocurreciasC++;
        }
        i++;
    }
    i = 0;
    stringFiltrado = malloc(sizeof(char) * (length - ocurreciasC + 1));

    while (str[i] != '\0')
    {
        if (str[i] != c)
        {
            stringFiltrado[j] = str[i];
            j++;
        }
        i++;
    }

    return stringFiltrado;
}