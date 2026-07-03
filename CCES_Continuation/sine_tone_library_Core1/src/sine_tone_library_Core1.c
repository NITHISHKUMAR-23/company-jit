/*****************************************************************************
 * sine_tone_library_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "sine_tone_library_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

void sine(int array[])
{
	for(int i=1;i<=256;i++)
	{
		printf("%d ",array[i]);
	}

}
