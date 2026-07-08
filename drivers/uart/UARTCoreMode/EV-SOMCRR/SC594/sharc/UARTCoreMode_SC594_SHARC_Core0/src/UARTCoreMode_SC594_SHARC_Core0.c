/*****************************************************************************
 * UARTCoreMode_SC594_SHARC_Core0.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "UARTCoreMode_SC594_SHARC_Core0.h"

int main()
{
	/**
	 * Initialize managed drivers and/or services that have been added to 
	 * the project.
	 * @return zero on success 
	 */
	adi_initComponents();
	
	adi_core_enable(ADI_CORE_SHARC0);

	return 0;
}

