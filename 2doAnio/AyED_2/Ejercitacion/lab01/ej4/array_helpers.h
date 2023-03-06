#include <stdbool.h>
#ifndef _ArrayHelpers_
#define _ArrayHelpers_
unsigned int array_from_file(int array[],unsigned int max_size, const char *filepath);

void array_dump(int a[], unsigned int length);

bool array_is_sorted(int a[], unsigned int length);

#endif