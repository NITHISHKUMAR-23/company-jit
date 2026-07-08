/*********************************************************************************
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*!
* @file      OSPI_Command.c
*
* @brief     This file contains the command structure and other functions for OSPI Flash Direct read access example.
*
*/

#include "ospi_phycalibration.h"

extern  ADI_DMA_DESC_LIST_MODE  Dest_List[MEMCOPY_NUM_DESC];
extern  ADI_DMA_DESC_LIST_MODE  Src_List[MEMCOPY_NUM_DESC];

extern uint8_t ReadBuff[1024];
extern uint8_t WriteBuff[1024];

extern void ConfigSoftSwitches_SC598_SOM(void);
extern void ConfigSoftSwitches_EV_21593_SOM(void);

void Prepare_Ospi_Command(ADI_OSPI_DAC_CMD *pDAC_Command)
{
	pDAC_Command->CmdOpcode 		= FLASH_QIOR_DTRREAD;
	pDAC_Command->CmdOpcode2 		= 0;
	pDAC_Command->eBusMode			= ADI_OSPI_QIOR;
	pDAC_Command->eTransferMode		= ADI_OSPI_TRANSFERMODE_DTR;
	pDAC_Command->eOperatingMode	= OSPI_ADI_COREMODE;
	pDAC_Command->eAddrSize			= ADI_OSPI_CMD_ADDR_SIZE_3;
	pDAC_Command->NumOfDummyCycles	= 6;
	pDAC_Command->ModeDataEnable    = 0;
	pDAC_Command->ModeData			= 0;
	pDAC_Command->pSource			= (uint8_t *)FLASHADDRESS;
	pDAC_Command->pDestination      = (uint8_t *)ReadBuff;
	pDAC_Command->nCount			= 4;
}

ADI_OSPI_RESULT Erase_Flash_Block0(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;
	uint8_t Flash_Status[1];

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


	/* Wait till WIP bit in flash status register is not set */
	while(!(Flash_Status[0] & WEL) )
	{
		eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
		if(eResult != ADI_OSPI_SUCCESS)
		{
			printf("Error in reading the Flash status register. Error: %d \n", eResult);
			return eResult;
		}
	}


	/* Initialize the STIG command for Block Erase operation  */
	pSTIG_Command->CmdOpcode       = FLASH_BE;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_NODATA;
	pSTIG_Command->DataSize		   = 0;
	pSTIG_Command->AddressEnable   = 1;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_3;
	pSTIG_Command->Address         = 0;
	pSTIG_Command->pBuffer		   = 0;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error in sending the Erase command. Error: %d \n", eResult);
		return eResult;
	}


	/* Wait till erase operation is over */
	/* Initialize the STIG command to read Flash status */
	pSTIG_Command->CmdOpcode       = FLASH_RD_STAT1;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_READDATA_EN;
	pSTIG_Command->DataSize		   = 1;
	pSTIG_Command->AddressEnable   = 0;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_1;
	pSTIG_Command->pBuffer		   = Flash_Status;

	/* Initialize the STIG buffer */
	Flash_Status[0] = 0xFF;

	/* Wait till WIP bit in flash status register is not cleared */
	while((Flash_Status[0] & WIP) )
	{
		eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
		if(eResult != ADI_OSPI_SUCCESS)
		{
			printf("Error in reading the Flash status register. Error: %d \n", eResult);
			return eResult;
		}
	}

	return ADI_OSPI_SUCCESS;
}

/*********************************************************************
 Function:       Configure_Flash

 Description:    Configures the Flash device in a mode
  	  	  	  	 needed for the test
 *********************************************************************/
ADI_OSPI_RESULT Configure_Flash(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;

	eResult = QuadEn_IS25LP512M(hDevice, pSTIG_Command);
	return eResult;

}

/*********************************************************************
 Function:       QuadEn_IS25LP512M

 Description:    Enables the Quad I/O mode of IS25LP512M flash device
 *********************************************************************/
ADI_OSPI_RESULT QuadEn_IS25LP512M(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;
	uint8_t Flash_Status[1];

	/* Check if Quad mode is already enabled */
	/* Initialize the STIG command to read Flash status */
	pSTIG_Command->CmdOpcode       = FLASH_RD_STAT1;
	pSTIG_Command->CmdOpcode2      = 0;
	pSTIG_Command->eBusMode        = ADI_OSPI_STIG_SINGLE;
	pSTIG_Command->eTransferMode   = ADI_OSPI_TRANSFERMODE_STR;
	pSTIG_Command->NumOfDummyCycles= 0;
	pSTIG_Command->ModeDataEnable  = 0;
	pSTIG_Command->ModeData		   = 0;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_READDATA_EN;
	pSTIG_Command->DataSize		   = 1;
	pSTIG_Command->AddressEnable   = 0;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_1;
	pSTIG_Command->Address         = 0;
	pSTIG_Command->pBuffer         = Flash_Status;

	/* Initialize the STIG buffer */
	Flash_Status[0] = 0;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error in reading the Flash status register. Error: %d \n", eResult);
		return eResult;
	}

	if((Flash_Status[0] & 0x40) == 0x40)
	{
		printf("QuadEn bit already set \n");
		return ADI_OSPI_SUCCESS;
	}


	/* Enable the Write to flash registers by sending FLASH_WR_EN(0x6) command */
	pSTIG_Command->CmdOpcode       = FLASH_WR_EN;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_NODATA;
	pSTIG_Command->DataSize		   = 0;
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


	/* Initialize the STIG command to write to Flash status register */
	pSTIG_Command->CmdOpcode       = FLASH_WR_STAT;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_WRITEDATA_EN;
	pSTIG_Command->DataSize		   = 1;
	pSTIG_Command->pBuffer		   = Flash_Status;

	/* Update the the QuadEn bit in status value to be written to Flash status register */
	Flash_Status[0] |=  (1 << 6);

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error in writing the Status register. Error: %d \n", eResult);
		return eResult;
	}

	/* Check if the QuadEn bit is written correctly */
	/* Initialize the STIG command to read Flash status */
	pSTIG_Command->CmdOpcode       = FLASH_RD_STAT1;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_READDATA_EN;
	pSTIG_Command->DataSize		   = 1;
	pSTIG_Command->pBuffer		   = Flash_Status;

	/* Clear the buffer for next read */
	Flash_Status[0] = 0;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);

	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error in reading the Flash status register. Error: %d \n", eResult);
		return eResult;
	}

	if((Flash_Status[0] & 0x40) != 0x40)
	{
		printf("QuadEn bit not set correctly \n");
		return ADI_OSPI_FAILED;
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
#if defined(__ADSPSC598_FAMILY__)
	ConfigSoftSwitches_SC598_SOM();
#endif
#if defined(__ADSPSC594_FAMILY__)
	ConfigSoftSwitches_EV_21593_SOM();
#endif
}
