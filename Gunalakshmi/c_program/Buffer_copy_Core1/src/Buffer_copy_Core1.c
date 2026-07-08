/*****************************************************************************
 * Buffer_copy_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "Buffer_copy_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

#define SIZE 20
#define NO_OF_CHANNELS 8

int main()
{
    int src [SIZE * NO_OF_CHANNELS];
    int dst [SIZE * NO_OF_CHANNELS];

    int i,j,k;
    k=0;

    for (i=0; i < SIZE * NO_OF_CHANNELS; i++)
    {
        src[i] = (i % NO_OF_CHANNELS) + 1;
    }
    printf("Interleaved format:\n");
    for (i = 0; i < SIZE * NO_OF_CHANNELS; i++)
    {
        printf("%d ", src[i]);
    }
    printf("\n");

    for(i=0; i < NO_OF_CHANNELS; i++)
    {
        for(j=0; j < SIZE; j++)
        {
            dst[k++] = src[i];
        }
    }
    printf("Block-based format:\n");
    for (i = 0; i < SIZE * NO_OF_CHANNELS; i++) {
        printf("%d ", dst[i]);
    }
    printf("\n");

    return 0;
}

