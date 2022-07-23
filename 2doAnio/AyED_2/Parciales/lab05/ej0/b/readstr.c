#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LENGTH 20

int main(void) {
    char user_input[MAX_LENGTH];

    printf("Ingrese su nombre y apellido: ");
    fgets(user_input, MAX_LENGTH, stdin);
    user_input [strlen(user_input) - 1] = '\0';
    /*
       Otra opcion: puedo elimnar el \n de la cadena
       strtok(user_input, "\n");
    */
    printf("Te damos la bienvenida %s a este maravilloso programa!\n", user_input);

    return EXIT_SUCCESS;
}

