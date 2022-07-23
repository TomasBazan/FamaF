#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
int main(void)
{
    int x, y, x1, y1;
    printf("Ingrese un valor para x:\n");
    scanf("%d", &x);
    printf("Ingrese un valor para y:\n");
    scanf("%d", &y);
    assert(x * y != 0);
    x1 = x;
    y1 = y;
    x = y * x;
    y = x * y;
    assert(x == x1 * y1 && x == y);
    return 0;
}