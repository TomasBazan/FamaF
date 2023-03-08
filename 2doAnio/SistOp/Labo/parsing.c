#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>
#include "parsing.h"
#include "parser.h"
#include "command.h"

static scommand parse_scommand(Parser p)
{
    /* Devuelve NULL cuando hay un error de parseo */
    assert(p != NULL && !parser_at_eof(p));
    scommand simple_command = scommand_new();

    char *command_text = strdup("");
    arg_kind_t argument_type;

    parser_skip_blanks(p);
    command_text = parser_next_argument(p, &argument_type);
    /* Si la cadena es vacia devuelvo un scommand vacio */
    if (command_text == NULL)
    {
        simple_command = scommand_destroy(simple_command);
    }

    while (command_text != NULL)
    {
        if (argument_type == ARG_NORMAL)
        {
            scommand_push_back(simple_command, command_text);
        }
        else if (argument_type == ARG_INPUT)
        {
            scommand_set_redir_in(simple_command, command_text);
        }
        else if (argument_type == ARG_OUTPUT)
        {
            scommand_set_redir_out(simple_command, command_text);
        }
        command_text = parser_next_argument(p, &argument_type);
    }

    free(command_text);
    command_text = NULL;
    return simple_command;
}

pipeline parse_pipeline(Parser p)
{
    assert(p != NULL && !parser_at_eof(p));
    pipeline result = pipeline_new();
    scommand cmd = NULL;
    bool error = false, another_pipe = false;
    bool wait, garbage;
    bool secuencial = false;
    cmd = parse_scommand(p);
    error = (cmd == NULL); /* Comando inválido al empezar */

    if (!error)
    {
        pipeline_push_back(result, cmd);
    }

    parser_skip_blanks(p);
    parser_op_pipe(p, &another_pipe);

    if (another_pipe)
    {
        cmd = parse_scommand(p);
        error = (cmd == NULL);
        if (!error)
        {
            pipeline_push_back(result, cmd);
        }
    }

    parser_op_background(p, &wait);
    pipeline_set_wait(result, !(wait));   // si hay un & no espera
    parser_op_background(p, &secuencial); // si hay otro & es secuencial
    if (secuencial)
    {
        wait = false;
        cmd = parse_scommand(p);
        error = (cmd == NULL);
        if (!error)
        {
            pipeline_push_back(result, cmd);
        }
        pipeline_set_wait(result, !(wait));
    }
    pipeline_set_secuencial(result, secuencial);

    /* Tolerancia a espacios posteriores */
    parser_skip_blanks(p);
    /* Consumir todo lo que hay inclusive el \n */
    parser_garbage(p, &garbage);
    /* Si hubo error, hacemos cleanup */

    if (error)
    {
        pipeline_destroy(result);
        result = NULL;
    }

    return result;
}
