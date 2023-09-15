//
// File-system system calls.
// Mostly argument checking, since we don't trust
// user code, and calls into file.c and fs.c.
//
#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "spinlock.h"
#include "proc.h"
#include "fs.h"
#include "sleeplock.h"
#include "file.h"
#include "fcntl.h"
#include "syscall.h"

#define N 20

int array_semaphores[N];
struct spinlock lock;

void array_init()
{
    for (unsigned int i = 0; i < N; i++)
    {
        array_semaphores[i] = -1;
    }
}

// On success, sem_open() returns the address of the new semaphore. On error, returns 0
int sys_sem_open(int sem, int value)
{
    argint(0, &sem);
    argint(1, &value);
    if (array_semaphores[sem] == -1 && 0 <= sem && sem < N && value >= 0)
    {

        array_semaphores[sem] = value;
        if (value == 0)
        {
            sleep(array_semaphores, &lock);
        }
        return sem;
    }
    else
    {
        // NOTA ver casos por error particulares
        // si el semaforo con id sem ya estaba inicializado o el id de sem excede el numero maximo de semaforos permitidos
        //  value es negativo
        return 0;
    }
}

int sys_sem_close(int sem)
{
    argint(0, &sem);

    if (array_semaphores[sem] < 0)
    {
        return -1;
    }
    acquire(&lock);
    if (array_semaphores[sem] >= 0)
    {
        array_semaphores[sem] = 0;
    }
    release(&lock);
    return 0;
}

int sys_sem_up(int sem)
{
    argint(0, &sem);
    if (array_semaphores[sem] > -1)
    {
        acquire(&lock);
        array_semaphores[sem] = array_semaphores[sem] + 1;
        wakeup(array_semaphores);
        release(&lock);
        return sem;
    }
    else
    {
        return 0;
    }
}

int sys_sem_down(int sem)
{
    argint(0, &sem);
    acquire(&lock);
    while (array_semaphores[sem] == 0)
    {
        sleep(array_semaphores, &lock);
    }
    release(&lock);

    if (array_semaphores[sem] != -1 && array_semaphores[sem] > 0)
    {
        array_semaphores[sem] = array_semaphores[sem] - 1;
    }

    return 0;
}
