#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>

#include "command.h"
#include "execute.h"
#include "parser.h"
#include "parsing.h"
#include "builtin.h"

static void show_prompt(void)
{
    char current_directory[1000];
    current_directory[999] = '\0';
    getcwd(current_directory, 1000);
    if (current_directory == NULL)
    {
        printf("You are currently in an inexistent directory");
        exit(EXIT_FAILURE);
    }
    printf("mybash: %s> ", current_directory);
    fflush(stdout);
}

int main(int argc, char *argv[])
{
    pipeline pipe;
    Parser input;
    bool quit = false;

    input = parser_new(stdin);
    while (!quit)
    {
        quit = parser_at_eof(input);
        if (!quit)
        {
            show_prompt();
            pipe = parse_pipeline(input);
            if (pipe != NULL)
            {
                execute_pipeline(pipe);
            }
        }
    }
    printf("\n");

    parser_destroy(input);
    input = NULL;
    return EXIT_SUCCESS;
}