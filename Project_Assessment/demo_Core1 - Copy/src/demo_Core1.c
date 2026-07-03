/*****************************************************************************
 * demo_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "demo_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>


#include<stdio.h>
int array[256]={
				#include"sine_tone.dat"
			};

/** 
 * If you want to use command program arguments, then place them in the following string. 
 */
char __argv_string[] = "";

int main(int argc, char *argv[])
{
	/**
	 * Initialize managed drivers and/or services that have been added to 
	 * the project.
	 * @return zero on success 
	 */
	adi_initComponents();
	
	/**
	 * The default startup code does not include any functionality to allow
	 * core 1 to enable core 2. A convenient way to enable
	 * core 2 is to use the adi_core_enable function. 
	 */
	adi_core_enable(ADI_CORE_SHARC1);

	/* Begin adding your custom code here */


	sine(array);

	return 0;


}

void sine(int array[])
{
	for(int i=1;i<=256;i++)
	{
		printf("%d ",array[i]);
	}

}

