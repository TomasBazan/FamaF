#ifndef _LIST
#define _LIST

#include <stdbool.h>

typedef struct node * list;

typedef int list_elem;
/* Constructors */
list list_empty(void);
/*
    Create a new list with initial value. Allocates new memory.
    Being c the returned counter, counter_is_init(c) should be true.
*/

list list_addl (list_elem e, list l );
/*
   Add to the left of the list a new element
*/

//      Destroy
void list_destroy(list l);
/*
   Free the memory in case of need it
*/
/* Operations */
bool list_is_empty(list l);
/*
   Check if the list is empty
*/

list_elem list_head(list l);
/*
   Return the first element of the list
   PRE: !is_empty(l)
*/

list list_tail (list l);

/*
   Drop the first element of the list
   PRE: !is_empty(l)
*/

list list_addr(list l, int e);
/*
   Add to the right of the lis the new element e
*/

unsigned int list_length(list l);
/*
   Return the amount of elements in the list
*/

list list_concat(list l, list l0);
/*
   Add the list l0 at the end of the list l
*/

list_elem list_index (list l, unsigned int n);
/*
   Return the n-element of the list l
   PRE: lenght(l) > n
*/

list list_take(list l,unsigned int n);
/*
   Let in l only the first n elements,
   eliminating the rest
*/

list list_drop(list l, unsigned int n);
/*
   Eliminate the firs n elements of l
*/


list copy_list(list l);
/*
   Copy all the elements of l and return.
*/

#endif //_LIST
