/*****************************************************************************
 * Sharc_Same_Mem_Core1.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "Sharc_Same_Mem_Core1.h"
#define SIZE 20

int src [SIZE];
int dst [SIZE];


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
