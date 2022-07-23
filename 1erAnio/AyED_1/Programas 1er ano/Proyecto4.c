/* que recibe un arreglo y su tamaño como argumento, y devuelve la suma de sus elementos. */
#include <stdio.h>
int pedirEntero(void)
{
    int x;
    printf("Ingrese un valor \n");
    scanf("%d", &x);
    return x;
}

int sumatoria(int a[], int tam)
{
    int suma;
    suma = 0;
    while (tam > 0)
    {
        suma = a[(tam - 1)];
        tam = tam - 1;
    }

    return suma; 
}

/* En la función main pedir los datos del arreglo al usuario asumiendo un tamaño constante. */
int main(void)
{
    #define tam 5 
    int a[tam], suma;

 printf("eliga los elementos de su vector \n");
 a[0] = pedirEntero();
 a[1] = pedirEntero();
 a[2] = pedirEntero();
 a[3] = pedirEntero();
 a[4] = pedirEntero();


suma = sumatoria(a[5],tam);
 printf("la sumatoria de los elementos es %d \n", suma); 
}