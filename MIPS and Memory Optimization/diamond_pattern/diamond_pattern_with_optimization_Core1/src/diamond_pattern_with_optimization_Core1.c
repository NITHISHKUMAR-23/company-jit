/*****************************************************************************
 * diamond_pattern_with_optimization_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "diamond_pattern_with_optimization_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

#include <stdio.h>
#include <stdint.h>

#define SIZE 5

inline void diamond_pattern(void)
{
	#pragma vector_for
    #pragma no_alias
	for (int32_t i = 1; i <= SIZE; i++)
	{
	    for (int32_t j = i; j < SIZE; j++)
	    {
	    	putchar(" ");
	    }

	    for (int32_t k = 1; k <= (2 * i - 1); k++)
	    {
	        putchar("*");
	    }
	    putchar("\n");
	}

	#pragma vector_for
    #pragma no_alias
	for (int32_t i = SIZE - 1; i >= 1; i--)
	{
	    for (int32_t j = SIZE; j > i; j--)
	    {
	    	putchar(" ");
	    }

	    for (int32_t k = 1; k <= (2 * i - 1); k++)
	    {
	    	putchar("*");
	    }
	    putchar("\n");
	}

}

int32_t main(void)
{
	diamond_pattern();

	return 0;
}

