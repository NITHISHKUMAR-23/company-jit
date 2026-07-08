/*********************************************************************************
Copyright(c) 2020 - 2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*!
* @file      OSPI_Command.c
*
* @brief     This file contains the command structure and other functions for OSPI Flash Direct read access example.
*
*/


#include "ospi_flashdirectaccess.h"

extern void ConfigSoftSwitches_ISSI_Flash(void);

extern uint8_t STIG_RW_Buffer[8];
#ifdef __ADSPSC598_FAMILY__
extern uint8_t ReadBuff[ADI_CACHE_ROUND_UP_SIZE(DESC_BUFFER_SIZE, uint8_t)];
extern uint8_t WriteBuff[ADI_CACHE_ROUND_UP_SIZE(DESC_BUFFER_SIZE, uint8_t)];
#else
extern uint8_t ReadBuff[1024];
extern uint8_t WriteBuff[1024];
#endif

/* Descriptors for Reading back the data from Flash */
ADI_DMA_DESC_LIST_MODE  Read_Dest_List[MEMCOPY_NUM_DESC] = {
														   	   {   	0,
#if defined(__ADSPSC598_FAMILY__) && defined(__ADSPCORTEXA55__)
														   			((uint32_t)(uint64_t)0x00000000),
#else
																	((uint8_t *)ReadBuff + 0),
#endif
																	ENUM_DMA_CFG_MSIZE04 | ENUM_DMA_CFG_PSIZE04,
																	sizeof(ReadBuff)/4,
																	4,
																	0,
																	0,
																	NULL,
																	true
														   	   }
															};

ADI_DMA_DESC_LIST_MODE  Read_Src_List[MEMCOPY_NUM_DESC] ={
														 	 {     0,
#if defined(__ADSPSC598_FAMILY__) && defined(__ADSPCORTEXA55__)
														 		   ((uint32_t)(uint64_t)FLASHADDRESS),
#else
																   (uint8_t *)FLASHADDRESS,
#endif
																   ENUM_DMA_CFG_MSIZE04 | ENUM_DMA_CFG_PSIZE04,
																   sizeof(ReadBuff)/4,
																   4,
																   0,
																   0,
																   NULL,
																   false
														 	 }
														 };



/* Descriptors for Programming the Flash */
ADI_DMA_DESC_LIST_MODE  Program_Dest_List[MEMCOPY_NUM_DESC] = {
															  	  {		0,
#if defined(__ADSPSC598_FAMILY__) && defined(__ADSPCORTEXA55__)
															  			((uint32_t)(uint64_t)FLASHADDRESS),
#else
																		(uint8_t *)FLASHADDRESS,
#endif
																		ENUM_DMA_CFG_MSIZE04 | ENUM_DMA_CFG_PSIZE04,
																		sizeof(ReadBuff)/4,
																		4,
																		0,
																		0,
																		NULL,
																		true
															  	  }
															  };

ADI_DMA_DESC_LIST_MODE  Program_Src_List[MEMCOPY_NUM_DESC] ={
																{	0,
#if defined(__ADSPSC598_FAMILY__) && defined(__ADSPCORTEXA55__)
																	((uint32_t)(uint64_t)0x00000000),
#else
																	(uint8_t *)WriteBuff,
#endif
																	ENUM_DMA_CFG_MSIZE04 | ENUM_DMA_CFG_PSIZE04,
																	sizeof(ReadBuff)/4,
																	4,
																	0,
																	0,
																	NULL,
																	false
																}
													 	 	 };

/* OSPI DAC command structure for read operations */
ADI_OSPI_DAC_CMD DAC_Read_Command = {    /*! command op-code */
										FLASH_READ,
										/*! 2nd command byte for commands with extended op-code, OPTIONAL */
										0x0,
										/*! Bus mode */
										ADI_OSPI_SINGLE,
										/*! Transfer mode */
										ADI_OSPI_TRANSFERMODE_STR,
										/*! DMA mode or Core mode */
										OSPI_ADI_DMAMODE,
										/*! Number of Address Bytes */
										ADI_OSPI_CMD_ADDR_SIZE_3,
										/*! Number of dummy bytes */
										0,
										/*! Whether Mode data will be sent */
										0,
										/*! Mode byte data */
										0,
										/*! Source Pointer to the data buffer in Core mode or pointer to descriptor list in DMA mode */
										(uint8_t *)Read_Src_List,
										/*! Destination Pointer to the data buffer in Core mode or pointer to descriptor list in DMA mode */
										(uint8_t *)Read_Dest_List,
										/*! Size of data buffer in Core mode or Size of descriptor list in DMA mode */
										1
									};


/* OSPI DAC command structure for write operations */
ADI_OSPI_DAC_CMD DAC_Program_Command = {    /*! command op-code */
											FLASH_PG_PRM,
											/*! 2nd command byte for commands with extended op-code, OPTIONAL */
											0x0,
											/*! Bus mode */
											ADI_OSPI_SINGLE,
											/*! Transfer mode */
											ADI_OSPI_TRANSFERMODE_STR,
											/*! DMA mode or Core mode */
											OSPI_ADI_DMAMODE,
											/*! Number of Address Bytes */
											ADI_OSPI_CMD_ADDR_SIZE_3,
											/*! Number of dummy bytes */
											0,
											/*! Whether Mode data will be sent */
											0,
											/*! Mode byte data */
											0,
											/*! Source Pointer to the data buffer in Core mode or pointer to descriptor list in DMA mode */
											(uint8_t *)Program_Src_List,
											/*! Destination Pointer to the data buffer in Core mode or pointer to descriptor list in DMA mode */
											(uint8_t *)Program_Dest_List,
											/*! Size of data buffer in Core mode or Size of descriptor list in DMA mode */
											1
										};



/* OSPI STIG command structure for STIG operations */
ADI_OSPI_STIGCMD STIG_Command =  {		/*! command op-code */
										0x3,
										/*! 2nd command byte for commands with extended op-code,
											! Must be set to '0' for all normal commands */
										0,

										/*! Bus mode */
										ADI_OSPI_STIG_SINGLE,

										/*! Transfer mode */
										ADI_OSPI_TRANSFERMODE_STR,

										/*! Number of dummy bytes */
										0,

										/*! Whether Mode data will be sent */
										0,

										/*! Mode byte data */
										0,

										/*! Specifies whether the command has any data requirements */
										ADI_OSPI_STIG_NODATA,

										/*! Number of Data Bytes */
										0,

										/*! address will be sent */
										0,

										/*! Number of Address Bytes */
										ADI_OSPI_CMD_ADDR_SIZE_1,

										/*! flash command address */
										0,
										 /*! Pointer to the data buffer.
										  * Acts as write buffer for commands which send out data
										  * Acts as read buffer for commands which expect data in response
										  */
										STIG_RW_Buffer
									};


/* Function to prepare the DAC read command for QPI DTR operation */
void Prepare_Ospi_Command(ADI_OSPI_DAC_CMD *pDAC_Command)
{
	/* Configure the DAC command structure to access flash in DPI DTR mode */
	pDAC_Command->CmdOpcode 		= FLASH_QIOR_DTRREAD;
	pDAC_Command->CmdOpcode2 		= 0;
	pDAC_Command->eBusMode			= ADI_OSPI_QPI;
	pDAC_Command->eTransferMode		= ADI_OSPI_TRANSFERMODE_DTR;
	pDAC_Command->eOperatingMode	= OSPI_ADI_DMAMODE;
	pDAC_Command->eAddrSize			= ADI_OSPI_CMD_ADDR_SIZE_3;
	pDAC_Command->NumOfDummyCycles	= 6;
	pDAC_Command->ModeDataEnable    = 0;
	pDAC_Command->ModeData			= 0;
	pDAC_Command->pSource			= (uint8_t *)Read_Src_List;
	pDAC_Command->pDestination      = (uint8_t *)Read_Dest_List;
	pDAC_Command->nCount			= 1;
}



/*********************************************************************
 Function:       Configure_Flash

 Description:    Configures the Flash device in a mode
 *********************************************************************/
ADI_OSPI_RESULT Configure_Flash(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;

	/* Enable QPI mode of IS25LP512M Flash device */
	eResult = QPI_En_IS25LP512M(hDevice, pSTIG_Command);
	return eResult;
}


/*********************************************************************
 Function:       Restore_Flash

 Description:    Restores the Flash back to SPI mode
 *********************************************************************/
ADI_OSPI_RESULT Restore_Flash(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;

	/* Send the Reset enable command in QPI mode */
	pSTIG_Command->CmdOpcode       = FLASH_RESETEN;
	pSTIG_Command->CmdOpcode2      = 0;
	pSTIG_Command->eBusMode        = ADI_OSPI_STIG_QPI;
	pSTIG_Command->eTransferMode   = ADI_OSPI_TRANSFERMODE_STR;
	pSTIG_Command->NumOfDummyCycles= 0;
	pSTIG_Command->ModeDataEnable  = 0;
	pSTIG_Command->ModeData		   = 0;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_NODATA;
	pSTIG_Command->DataSize		   = 0;
	pSTIG_Command->AddressEnable   = 0;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_1;
	pSTIG_Command->Address         = 0;
	pSTIG_Command->pBuffer         = 0;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to send the Reset EN command to flash. Error: %d \n", eResult);
		return eResult;
	}

	/* Send the Reset  command in QPI mode */
	pSTIG_Command->CmdOpcode       = FLASH_RESET;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to send the Reset command to flash. Error: %d \n", eResult);
		return eResult;
	}

	return ADI_OSPI_SUCCESS;
}


/*********************************************************************
 Function:       QPI_En_IS25LP512M

 Description:    Enables the QPI mode of IS25LP512M flash device
 *********************************************************************/
ADI_OSPI_RESULT QPI_En_IS25LP512M(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;

	/* Initialize the STIG command to enter QPI mode */
	pSTIG_Command->CmdOpcode       = FLASH_ENTER_QPI;
	pSTIG_Command->CmdOpcode2      = 0;
	pSTIG_Command->eBusMode        = ADI_OSPI_STIG_SINGLE;
	pSTIG_Command->eTransferMode   = ADI_OSPI_TRANSFERMODE_STR;
	pSTIG_Command->NumOfDummyCycles= 0;
	pSTIG_Command->ModeDataEnable  = 0;
	pSTIG_Command->ModeData		   = 0;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_NODATA;
	pSTIG_Command->DataSize		   = 0;
	pSTIG_Command->AddressEnable   = 0;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_1;
	pSTIG_Command->Address         = 0;
	pSTIG_Command->pBuffer         = 0;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error in sending the QPI command to Flash. Error: %d \n", eResult);
		return eResult;
	}

	printf("Flash successfully enter QPI mode \n");
	return ADI_OSPI_SUCCESS;

}




/*********************************************************************
 Function:       Select_FlashDevice

 Description:    Selects one of the flash devices on the EZKIT based
 	 	 	 	 on the test running
 *********************************************************************/
void Select_FlashDevice(void)
{
	/* Configure the softconfig switches on SOM and SOMCRR board to select
	 * ISSI S25LP512M flash on EV-21593-SOM board */
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
