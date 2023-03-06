#include "../kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char **argv)
{
    if (argc != 2)
    {
        printf("error invalid arguments\n");

        if (argc == 1)
        {
            printf("please re-run entering the rally number\n ");
        }

        return 0;
    }
    int N = atoi(argv[1]);
    int id = 0;
    
    id = sem_open(id, 1 );

    int pid = fork();

    for (unsigned int i = 0; i < N; i++)
    {

        if (pid == 0)
        {
            // child

            sem_down(id);
            printf("\t\tPONG\n");
            sleep(1);
            sem_up(id);
        }
        else
        {
            // father

            sem_down(id);
            printf("PING\n");
            sleep(1);
            sem_up(id);
        }
    }
    sleep(1);
    sem_close(id);

    return 0;
}