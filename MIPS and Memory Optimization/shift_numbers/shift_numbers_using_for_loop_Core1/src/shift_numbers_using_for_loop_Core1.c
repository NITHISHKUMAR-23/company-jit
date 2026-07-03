/*****************************************************************************
 * shift_numbers_using_for_loop_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "shift_numbers_using_for_loop_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

#include <stdio.h>

#define SIZE 10
int shift = 5;
int buffer[SIZE] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

inline void shift_right_using_for_loop(int buffer[], int size, int shift)
{
    int temp[SIZE];
    for (int i = 0; i < size; i++)
    {
        temp[(i + shift) % size] = buffer[i];
    }

    for (int i = 0; i < size; i++)
    {
    	buffer[i] = temp[i];
    }
}

int main()
{
	shift_right_using_for_loop(buffer, SIZE, shift);

    printf("Shifted Buffer : \n");
    for (int i = 0; i < SIZE; i++)
    {
        printf("%d ", buffer[i]);
    }

    return 0;
}

