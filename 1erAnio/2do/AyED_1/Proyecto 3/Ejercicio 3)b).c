#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
int main(void)
{
    int x, y;
    printf("Ingrese un valor para x: \n");
    scanf("%d", &x);
    assert(x == 2);
    printf("Ingrese un valor para y: \n");
    scanf("%d", &y);
    assert(y == 5);
    x = x + y;
    printf("x->%d y->%d \n", x, y);
    y = y + y;
    printf("x->%d y->%d \n", x, y);

    return 0;
}
