/*****************************************************************************
 * random_number_sum_library_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "random_number_sum_library_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

#define SIZE 10
int32_t num1 = 48, num2 = -27, sum = 0, total = 0, index = 0, buffer[SIZE] = {0};

void buffer_sum(void)
{
	// Fill Buffer
	for (int32_t i = 0; i < SIZE; i++)
	{
		int value = num1 + (i * num2);

		// Check for uniqueness in the buffer
		int unique = 1;

		for (int32_t j = 0; j < index; j++)
		{
		    if (buffer[j] == value)
		    {
		        unique = 0;
		        break;
		    }
		 }

		 if (unique)
		 {
		     buffer[index] = value;
		     index++;
		 }

		 // Check if buffer is full
		 if (index >= SIZE)
		 {
		     break;
		 }
	}

	// Sum of those values to adjust those buffer values
	for (int i = 0; i < index; i++)
	{
		sum += buffer[i];
	}

	// Adjust Buffer Values to get sum of those values to zero
	if (index > 0)
	{
		int adjustment = -sum / index;
		for (int i = 0; i < index; i++)
		{
		   buffer[i] += adjustment;
		}
	}

	// Handle Remaining data
	for (int i = 0; i < index; i++)
	{
		total += buffer[i];
	}

	// Final adjustment to ensure sum is zero
	if (total != 0)
	{
		buffer[0] -= total;
	}

	// Output Buffer
	 printf("Buffer Values: ");

	for (int i = 0; i < index; i++)
	{
		printf("%d ", buffer[i]);
	}
}
