/*****************************************************************************
 * diamond_pattern_without_optimization_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "diamond_pattern_without_optimization_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>
#include <stdio.h>
#include <stdint.h>

void diamond_pattern(int32_t n)
{
	for (int32_t i = 1; i <= n; i++)
	{
	    for (int32_t j = i; j < n; j++)
	    {
	        printf(" ");
	    }

	    for (int32_t k = 1; k <= (2 * i - 1); k++)
	    {
	        printf("*");
	    }
	    printf("\n");
	}

	for (int32_t i = n - 1; i >= 1; i--)
	{
	    for (int32_t j = n; j > i; j--)
	    {
	        printf(" ");
	    }

	    for (int32_t k = 1; k <= (2 * i - 1); k++)
	    {
	        printf("*");
	    }
	    printf("\n");
	}

}

int32_t main(void)
{
	int n=5;
	diamond_pattern(n);

	return 0;
}

