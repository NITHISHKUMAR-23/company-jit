/*****************************************************************************
 * sine_tone_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "sine_tone_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>


int array[256]={
				#include"MCPCM_48K_Sine_input.dat"
			};

int main()
{
	sine(array);
	
	return 0;
}

