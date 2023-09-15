#include <stdbool.h>
#include <assert.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include "command.h"
#include "builtin.h"
#include "tests/syscall_mock.h"


bool builtin_is_internal(scommand cmd)
{
    assert(cmd != NULL);
    return strcmp(scommand_front(cmd), "exit") == 0 ||
           strcmp(scommand_front(cmd), "cd") == 0 ||
           strcmp(scommand_front(cmd), "help") == 0;
}

bool builtin_alone(pipeline p)
{
    assert(p != NULL);
    return pipeline_length(p) == 1 && builtin_is_internal(pipeline_front(p));
}

void builtin_run(scommand cmd)
{
    assert(builtin_is_internal(cmd));
    if (strcmp(scommand_front(cmd), "exit") == 0)
    {
        exit(EXIT_SUCCESS);
    }

    if (strcmp(scommand_front(cmd), "cd") == 0)
    {
        if (scommand_get_argument(cmd, 2) != NULL)
        {
            printf("cd: Too many arguments");
        }

        char *path = scommand_get_argument(cmd, 1);
        
        if (path == NULL)
        {
            chdir("~");
        }
        else
        {
            chdir(path);
        }

    }
    if (strcmp(scommand_front(cmd), "help") == 0)
        {
            printf("My Bash 2022 by Spice Girls B)\n\nAuthors:* Tomas Pablo Bazan\n* Milagros Carabelos\n* Juan Cruz Pereyra Carrillo\n* Ignacio Scavuzzo\n\nInteranal commands :     cd : Navigate the file system in your device\n    exit : Clean close the terminal\n    help : Show this text!\n");
        }
}