/*****************************************************************************
 * square_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "square_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

#include <stdio.h>

#define LOOP_COUNT 100

inline void printSquare(void)
{
	for (int32_t num = 1; num <= LOOP_COUNT; num++)
	{
		printf("The square of %d is %d\n", num, num * num);
	}
}

int32_t main(void)
{
	printSquare();

    return 0;
}

