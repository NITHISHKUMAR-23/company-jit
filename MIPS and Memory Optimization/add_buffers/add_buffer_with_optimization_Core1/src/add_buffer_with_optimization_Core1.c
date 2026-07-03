/*****************************************************************************
 * add_buffer_with_optimization_Core1.c
 *****************************************************************************/

/*
 * 2. Write a c code to add two buffers of size 1000 and measure its cycles
 * and apply pragma vector_for and no_alias optimization and calculate cycles.
 */

#include "adi_initialize.h"
#include "add_buffer_with_optimization_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

#define SIZE 1000

void add_buffer(void)
{
	int32_t buffer1[SIZE];
	int32_t buffer2[SIZE];
	int32_t buffer3[SIZE];

	#pragma vector_for
    #pragma no_alias
	for(int32_t i=0; i<SIZE; i++)
	{
		buffer1[i]=i;
		buffer2[i]=i;
		buffer3[i] = buffer1[i]+buffer2[i];
		printf("%d ", buffer3[i]);
	}
}

int32_t main()
{
	add_buffer();

	return 0;

}

