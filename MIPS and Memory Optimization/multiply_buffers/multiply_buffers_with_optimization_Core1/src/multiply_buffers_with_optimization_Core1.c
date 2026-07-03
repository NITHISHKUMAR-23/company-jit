/*****************************************************************************
 * multiply_buffers_with_optimization_Core1.c
 *****************************************************************************/

/*
 * 1. Write a c code to multiply two static buffers and measure its cycles
 * with memory optimization(using pm qualifiers).
 */

#include "adi_initialize.h"
#include "multiply_buffers_with_optimization_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

#define SIZE 10

#pragma section("first_buffer_mapped_in_l3")
static int32_t buffer_1[SIZE] = {1,2,3,4,5,6,7,8,9,10};

#pragma section("second_buffer_mapped_in_l3")
pm static int32_t buffer_2[SIZE] = {1,2,3,4,5,6,7,8,9,10};

pm static int32_t buffer_3[SIZE];

inline void multiplication(void)
{

	for(int32_t i = 0; i < SIZE; i++)
	{
		buffer_3[i] = buffer_1[i] * buffer_2[i];
		printf("%d ", buffer_3[i]);
	}
}

int32_t main(void)
{

	multiplication();

	return 0;
}

