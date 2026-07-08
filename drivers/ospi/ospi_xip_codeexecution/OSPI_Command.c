/*********************************************************************************
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*!
* @file      OSPI_Command.c
*
* @brief     This file contains the command structure and other functions for OSPI Octal Flash Direct read access example.
*
*/

#include "ospi_xip_codeexecution.h"

extern uint8_t ReadBuff_dummy[4];

ADI_OSPI_DAC_CMD DAC_Command = {    /*! command op-code */
									0xBB,
									/*! 2nd command byte for commands with extended op-code, OPTIONAL */
									0x0,
									/*! Bus mode */
									ADI_OSPI_DIOR,
									/*! Transfer mode */
									ADI_OSPI_TRANSFERMODE_STR,
									/*! DMA mode or Core mode */
									OSPI_ADI_COREMODE,
									/*! Number of Address Bytes */
									ADI_OSPI_CMD_ADDR_SIZE_3,
									/*! Number of dummy bytes */
									0,
									/*! Whether Mode data will be sent */
									1,
									/*! Mode byte data. This is needed for ISSI flash to enter XIP mode */
									0xAB,
									/*! Source Pointer to the data buffer in Core mode or pointer to descriptor list in DMA mode */
									(uint8_t *)0x60000000,
									/*! Destination Pointer to the data buffer in Core mode or pointer to descriptor list in DMA mode */
									ReadBuff_dummy,
									/*! Size of data buffer in Core mode or Size of descriptor list in DMA mode */
									4
								};



/*********************************************************************
 Function:       Select_FlashDevice

 Description:    Selects one of the flash devices on the EZKIT based
 	 	 	 	 on the test running
 *********************************************************************/
void Select_FlashDevice(void)
{
	/* Configure the softconfig switches on SOM and SOMCRR board to select
	 * ISSI flash on SOM oard */
#ifdef __ADSPSC598_FAMILY__
	ConfigSoftSwitches_SC598_SOM();
#else
	ConfigSoftSwitches_EV_21593_SOM();
#endif

#if defined (EV_SOMCRR_EZKIT_SUPPORT)
	ConfigSoftSwitches_EV_SOMCRR_EZKIT();
#elif defined (EV_SOMCRR_EZLITE_SUPPORT)
	ConfigSoftSwitches_SOMCRR_EZLITE();
#endif
}
