/*****************************************************************************
 * multiply_buffers_without_optimization_Core1.c
 *****************************************************************************/

/*
 * 1. Write a c code to multiply two static buffers and measure its cycles
 * without memory optimization(using pm qualifiers).
 */

#include "adi_initialize.h"
#include "multiply_buffers_without_optimization_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

void multiplication(int32_t buffer_1[], int32_t buffer_2[], int32_t buffer_3[])
{
	for(int32_t i = 0; i < 10; i++)
	{
		buffer_3[i] = buffer_1[i] * buffer_2[i];
		printf("%d ", buffer_3[i]);
	}
}

int32_t main(void)
{
	int32_t buffer_1[10] = {1,2,3,4,5,6,7,8,9,10};
	int32_t buffer_2[10] = {1,2,3,4,5,6,7,8,9,10};
	int32_t buffer_3[10];

	multiplication(buffer_1, buffer_2, buffer_3);

	return 0;
}

