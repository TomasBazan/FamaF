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
    y = y + y;
    printf("y = %d\n", y);
    x = x + y;

    return 0;
}
