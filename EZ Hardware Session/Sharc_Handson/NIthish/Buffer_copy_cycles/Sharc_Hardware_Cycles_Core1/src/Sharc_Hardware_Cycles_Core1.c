/*****************************************************************************
 * Sharc_Hardware_Cycles_Core1.c
 *****************************************************************************/
#include "adi_initialize.h"
#include "Sharc_Hardware_Cycles_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

#define SIZE 20

#pragma section("source_buffer_mapped_in_l1")
int src [SIZE];  // L1

#pragma section("destination_buffer_mapped_in_l3")
int dst [SIZE];   // L3


int main()
{
    int i;

    for (i=0; i < SIZE; i++)
    {
        src[i] = i+ 1;
    }

    for (i=0; i < SIZE; i++)
    {
    	dst[i] = src[i];
    }

    return 0;
}
