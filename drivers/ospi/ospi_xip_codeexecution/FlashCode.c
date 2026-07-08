/*********************************************************************************

Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/

#include "ospi_xip_codeexecution.h"

/* Map this function to Flash Address space*/
#ifdef CORE0
__attribute__((section(".ospi_flash_code"))) uint32_t Code_In_Flash(uint32_t nIteration)
#else
section("seg_ospi_flashcode")
uint32_t Code_In_Flash(uint32_t nIteration)
#endif
{
	uint32_t Val1, Val2, Val3, delay;

	Val2 = 10;
	Val3 = 15;

	/* Do some calculations */
	Val1 = (Val2*Val3) + (Val2*nIteration);
	*pREG_RCU0_MSG = Val1;

	/* Wait in a loop */
	delay = 100;
	while(delay > 3)
	{
		delay--;
	}

	/* Clear the variable */
	Val1 = 0;

	/* Read back form RCU_MSG */
	Val1 = *pREG_RCU0_MSG;

	return Val1;
}

