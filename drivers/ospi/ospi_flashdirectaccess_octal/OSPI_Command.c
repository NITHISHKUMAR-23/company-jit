/*********************************************************************************
Copyright(c) 2020 - 2024 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*!
* @file      OSPI_Command.c
*
* @brief     This file contains the command structure and other functions for OSPI Octal Flash Direct read access example.
*
*/

#include "ospi_flashdirectaccess_octal.h"

extern void ConfigSoftSwitches_MacronixFlash(void);

extern uint8_t STIG_RW_Buffer[8];
extern uint8_t ReadBuff[ADI_CACHE_ROUND_UP_SIZE(DESC_BUFFER_SIZE, uint8_t)];
extern uint8_t WriteBuff[ADI_CACHE_ROUND_UP_SIZE(DESC_BUFFER_SIZE, uint8_t)];

/* Descriptors for Reading back the data from Flash */
ADI_DMA_DESC_LIST_MODE  Read_Dest_List[MEMCOPY_NUM_DESC] ={
														  	  {	0,
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
															{	0,
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
															  	  {	  0,
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
	/* Configure the DAC command structure to access flash in OPI STR mode */
	pDAC_Command->CmdOpcode 		= FLASH_OPI_READ_1;
	pDAC_Command->CmdOpcode2 		= FLASH_OPI_READ_2;
	pDAC_Command->eBusMode			= ADI_OSPI_OPI;
	pDAC_Command->eTransferMode		= ADI_OSPI_TRANSFERMODE_STR;
	pDAC_Command->eOperatingMode	= OSPI_ADI_DMAMODE;
	pDAC_Command->eAddrSize			= ADI_OSPI_CMD_ADDR_SIZE_4;
	pDAC_Command->NumOfDummyCycles	= 20;
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

	/* Enable OPI mode of Macronix MX66LM1G45G Flash device */
	eResult = OPI_En_MX66LM1G(hDevice, pSTIG_Command, STR_MODE);
	return eResult;
}



/*********************************************************************
 Function:       Restore_Flash

 Description:    Restores the Flash back to SPI mode
 *********************************************************************/
ADI_OSPI_RESULT Restore_Flash(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;

	/* Send the Reset enable command in OPI mode */
	pSTIG_Command->CmdOpcode       = FLASH_RESETEN;
	pSTIG_Command->CmdOpcode2      = 0x99;
	pSTIG_Command->eBusMode        = ADI_OSPI_STIG_OPI;
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
	pSTIG_Command->CmdOpcode2      = 0x66;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to send the Reset command to flash. Error: %d \n", eResult);
		return eResult;
	}

	return ADI_OSPI_SUCCESS;
}



/*********************************************************************
 Function:       OPI_En_MX66LM1G

 Description:    Enables the OPI mode of MX66LM1G flash device
 *********************************************************************/
ADI_OSPI_RESULT OPI_En_MX66LM1G(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command, FLASH_OPI_MODE Transfer_Mode)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;
	uint8_t Flash_Status[1];
	uint8_t Flash_WRCR2[1];

	/* Enable the Write to flash registers by sending FLASH_WR_EN(0x6) command */
	pSTIG_Command->CmdOpcode       = FLASH_WR_EN;
	pSTIG_Command->CmdOpcode2      = 0;
	pSTIG_Command->eBusMode        = ADI_OSPI_STIG_SINGLE;
	pSTIG_Command->eTransferMode   = ADI_OSPI_TRANSFERMODE_STR;
	pSTIG_Command->NumOfDummyCycles= 0;
	pSTIG_Command->ModeDataEnable  = 0;
	pSTIG_Command->ModeData		   = 0;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_NODATA;
	pSTIG_Command->DataSize		   = 1;
	pSTIG_Command->AddressEnable   = 0;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_1;
	pSTIG_Command->Address         = 0;
	pSTIG_Command->pBuffer         = 0;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to send the WREN command to flash. Error: %d \n", eResult);
		return eResult;
	}

	/* Initialize the STIG command to read Flash status */
	pSTIG_Command->CmdOpcode       = FLASH_RD_STAT1;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_READDATA_EN;
	pSTIG_Command->DataSize		   = 1;
	pSTIG_Command->pBuffer		   = Flash_Status;

	/* Initialize the STIG buffer */
	Flash_Status[0] = 0;

	/* Wait till WEL bit in flash status register is not set */
	while(!(Flash_Status[0] & WEL) )
	{
		eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
		if(eResult != ADI_OSPI_SUCCESS)
		{
			printf("Error in reading the Flash status register. Error: %d \n", eResult);
			return eResult;
		}
	}


	/* Initialize the STIG command to write to MX66LM1G WRCR2 register */
	pSTIG_Command->CmdOpcode       = FLASH_WR_WRCR2;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_WRITEDATA_EN;
	pSTIG_Command->DataSize		   = 1;
	pSTIG_Command->AddressEnable   = 1;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_4;
	pSTIG_Command->Address         = 0;
	pSTIG_Command->pBuffer		   = Flash_WRCR2;

	/* Update the value to be written to WRCR2 register */
	if(Transfer_Mode == STR_MODE)
	{
		Flash_WRCR2[0] =  0x1;
	}
	else
	{
		Flash_WRCR2[0] =  0x2;
	}

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error in writing the Status register. Error: %d \n", eResult);
		return eResult;
	}


	/* Put some delay here */
	int Delay = 0;
	while(Delay++ < 10000){ asm("nop;"); }

	/* Read back the Config2 Register in STT_OPI mode */
	pSTIG_Command->CmdOpcode       = FLASH_RD_WRCR2;
	pSTIG_Command->CmdOpcode2      = 0x8E;
	pSTIG_Command->eBusMode        = ADI_OSPI_STIG_OPI;
	if(Transfer_Mode == STR_MODE)
	{
		pSTIG_Command->eTransferMode   = ADI_OSPI_TRANSFERMODE_STR;
	}
	else
	{
		pSTIG_Command->eTransferMode   = ADI_OSPI_TRANSFERMODE_DTR_P;
	}
	pSTIG_Command->NumOfDummyCycles= 20;
	pSTIG_Command->ModeDataEnable  = 0;
	pSTIG_Command->ModeData		   = 0;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_READDATA_EN;
	pSTIG_Command->DataSize		   = 1;
	pSTIG_Command->AddressEnable   = 1;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_4;
	pSTIG_Command->Address         = 0;
	pSTIG_Command->pBuffer         = Flash_WRCR2;

	Flash_WRCR2[0] = 0;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error in Reading the Config2 register. Error: %d \n", eResult);
		return eResult;
	}

	if(Transfer_Mode == STR_MODE)
	{
		if(Flash_WRCR2[0] ==  0x1)
		{
			printf("Flash configured in OSPI-STR mode correctly. \n");
		}
		else
		{
			printf("Failed to configure Flash into OSPI-STR mode. Error: %d \n", eResult);
		}
	}
	else
	{
		if(Flash_WRCR2[0] ==  0x2)
		{
			printf("Flash configured in OSPI-DTR mode correctly. \n");
		}
		else
		{
			printf("Failed to configure Flash into OSPI-DTR mode. Error: %d \n", eResult);
		}
	}

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
	 * Macronix MX66LM1G45GMI00 flash on EV-SOMCRR_EZKIT board */
#ifdef __ADSPSC598_FAMILY__
	ConfigSoftSwitches_SC598_SOM();
#else
	ConfigSoftSwitches_EV_21593_SOM();
#endif
	ConfigSoftSwitches_EV_SOMCRR_EZKIT();
}
