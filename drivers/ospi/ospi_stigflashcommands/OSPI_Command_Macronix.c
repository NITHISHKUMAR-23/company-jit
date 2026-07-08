/*********************************************************************************
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*!
* @file      OSPI_Command_Macronix.c
*
* @brief     This file contains the command structure and other functions for OSPI Flash command using stig mode example.
*
*/

#include "ospi_stigflashcommands.h"

extern void ConfigSoftSwitches_ISSI_Flash(void);

uint8_t STIG_RW_Buffer[8];

/* Command structure to hold the STIG command for OSPI controller */
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

extern uint8_t ReadBuff[1024];
extern uint8_t WriteBuff[1024];
extern uint8_t EraseBuff[1024];

extern int8_t VerifyData(uint8_t *pReadBuff, uint8_t *pWriteBuff, uint32_t BUFF_size);

/*********************************************************************
 Function:       Ospi_Flash_command_Sequence

 Description:    This function runs different STIG command in a sequence to do some meaningful operation on the flash.
 * 				 In the end flash is expected in a known state. If that matches with what is expected the test passes
 * 				- Read Man and Dev ID
 * 				- Issue Sector Erase
 * 				- Set WEL bit in Status register
 * 				- Read the WEL bit from status register
 * 				- Write 8 Bytes in single mode (STIG)
 * 				- Read 8 Bytes in single mode (STIG)
 * 				- Enter QPI mode
 * 				- Read 8 Bytes in QPI mode (STIG)
 * 				- Exit QPI mode
 * 				- Read 8 Bytes in single mode (STIG)
 * ********************************************************************/

ADI_OSPI_RESULT Ospi_Flash_command_Sequence_Macronix(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;
	uint8_t Flash_ID[3];
	uint16_t Device_ID;
	uint32_t BUFF_size;
	uint16_t i;

    /* Read the Flash Man ID and DeviceID */
	pSTIG_Command->CmdOpcode       = FLASH_RDID;
	pSTIG_Command->CmdOpcode2      = 0;
	pSTIG_Command->eBusMode        = ADI_OSPI_STIG_SINGLE;
	pSTIG_Command->eTransferMode   = ADI_OSPI_TRANSFERMODE_STR;
	pSTIG_Command->NumOfDummyCycles= 0;
	pSTIG_Command->ModeData		   = 0;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_READDATA_EN;
	pSTIG_Command->DataSize		   = 3;
	pSTIG_Command->AddressEnable   = 0;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_1;
	pSTIG_Command->Address         = 0;
	pSTIG_Command->pBuffer         = Flash_ID;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to send the FLASH_RDID command to flash. Error: %d \n", eResult);
		return eResult;
	}

	Device_ID = (Flash_ID[1] << 8)| Flash_ID[2];

	printf("Flash Man ID Read :0x%x \n", Flash_ID[0]);
	if(Flash_ID[0] != MX66LM1G45G_MANID)
	{
		printf("Failed to Read ManID of MX66LM1G Flash Device correctly \n");
		return ADI_OSPI_FAILED;
	}

	printf("Flash Device ID Read :0x%x \n", Device_ID);
	if(Device_ID != MX66LM1G45G_DEVID)
	{
		printf("Failed to Read DevID of MX66LM1G Flash Device correctly \n");
		return ADI_OSPI_FAILED;
	}


	/* Erase the first block of the Flash */
	eResult = Erase_Flash_Block0(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in while trying to erase the block0 of flash. Error code returned %d \n", eResult);
		printf("Fail \n");
		return ADI_OSPI_FAILED;
	}

	/* Read back 8 bytes in STIG mode */
	eResult = ReadFlash8_STIG(hDevice, pSTIG_Command, ReadBuff);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in while reading 8 bytes in STIG mode. Error code returned %d \n", eResult);
		printf("Fail \n");
		return ADI_OSPI_FAILED;
	}

	/* Compare the flash data with Erased Data */
	BUFF_size = 8;
	if(VerifyData(ReadBuff, EraseBuff, BUFF_size) != 0)
	{
		printf("The Flash was not Erased correctly \n");
		return ADI_OSPI_FAILED;
	}
	else
	{
		printf("Flash Sector 0 Erased successfully \n");
	}

	/* Program 8 bytes in STIG mode */
	eResult = ProgramFlash8_STIG(hDevice, pSTIG_Command, WriteBuff);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in while programming 8 bytes in STIG mode. Error code returned %d \n", eResult);
		printf("Fail \n");
		return ADI_OSPI_FAILED;
	}


	/* Read back 8 bytes in STIG mode */
	eResult = ReadFlash8_STIG(hDevice, pSTIG_Command, ReadBuff);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in while reading 8 bytes in STIG mode. Error code returned %d \n", eResult);
		printf("Fail \n");
		return ADI_OSPI_FAILED;
	}

	/* Compare the flash data with Date written */
	if(VerifyData(ReadBuff, WriteBuff, BUFF_size) != 0)
	{
		printf("The data was not programmed correctly \n");
		return ADI_OSPI_FAILED;
	}
	else
	{
		printf("Flash was programmed successfully using STIG mode \n");
	}


	/* Put the MX66LM1G45GMI00 flash in Octal STR mode */
	eResult = OPISTR_En_MX66LM1G(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Command to enter QPI mode failed. Error code returned %d \n", eResult);
		printf("Fail \n");
		return ADI_OSPI_FAILED;
	}


	/* Clear the read buffer before next read */
	for(i = 0; i<8; i++)
	{
		ReadBuff[i] = 0;
	}


	/* Read back 8 bytes in STIG mode - OPI mode */
	eResult = ReadFlash8_OPISTR_STIG(hDevice, pSTIG_Command, ReadBuff);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in while reading 8 bytes in OPI STR STIG mode. Error code returned %d \n", eResult);
		printf("Fail \n");
		return ADI_OSPI_FAILED;
	}


	/* Compare the flash data with Date written */
	if(VerifyData(ReadBuff, WriteBuff, BUFF_size) != 0)
	{
		printf("The data was not read correctly in OPI STR mode \n");
		return ADI_OSPI_FAILED;
	}
	else
	{
		printf("Flash data read in OPI STR mode using STIG was successful \n");
	}

	/* Exit OPI STR mode of MX66LM1G45GMI00 Flash device */
	eResult = 	Restore_Flash(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Reset flash to exit OPI exit mode failed. Error code returned %d \n", eResult);
		printf("Fail \n");
		return ADI_OSPI_FAILED;
	}

	Delay(10000);

	/* Clear the read buffer before next read */
	for(i = 0; i<8; i++)
	{
		ReadBuff[i] = 0;
	}


	/* Read back 8 bytes again in STIG mode to verify if exit form QPI was successful */
	eResult = ReadFlash8_STIG(hDevice, pSTIG_Command, ReadBuff);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in while reading 8 bytes in STIG mode. Error code returned %d \n", eResult);
		printf("Fail \n");
		return ADI_OSPI_FAILED;
	}


	/* Compare the flash data with Date written */
	if(VerifyData(ReadBuff, WriteBuff, BUFF_size) != 0)
	{
		printf("The data was not Read correctly after resettig the flash \n");
		return ADI_OSPI_FAILED;
	}
	else
	{
		printf("Flash data read in SPI after exiting OPI STR mode was successful \n");
	}


	return ADI_OSPI_SUCCESS;
}



/*********************************************************************
 Function:       OPISTR_En_MX66LM1G

 Description:    Enables the OPI STR mode of MX66LM1G flash device
 *********************************************************************/
ADI_OSPI_RESULT OPISTR_En_MX66LM1G(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command)
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
	Flash_WRCR2[0] =  0x1;



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
	pSTIG_Command->eTransferMode   = ADI_OSPI_TRANSFERMODE_STR;


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

	if(Flash_WRCR2[0] ==  0x1)
	{
		printf("Flash configured in OSPI-STR mode correctly. \n");
	}
	else
	{
		printf("Flash failed to enter OSPI-STR mode correctly. Error: %d \n", eResult);
	}


	printf("Reading Flash ID in STR OPI mode.\n");
	Read_ManID_STR_OPI(hDevice);

	return ADI_OSPI_SUCCESS;
}



/*********************************************************************
 Function:       Read_ManID_STR_OPI

 Description:    Reads ManID of MX66LM1G flash device in STR OPI mode
 *********************************************************************/
ADI_OSPI_RESULT Read_ManID_STR_OPI(ADI_OSPI_HANDLE const hDevice)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;
	ADI_OSPI_STIGCMD STIG_Command;
	ADI_OSPI_STIGCMD *pSTIG_Command = &STIG_Command;
	uint8_t Flash_ID[3];
	uint16_t Device_ID;


	/* Read the Flash Man ID and DeviceID */
	pSTIG_Command->CmdOpcode       = FLASH_RDID;
	pSTIG_Command->CmdOpcode2      = 0x60;
	pSTIG_Command->eBusMode        = ADI_OSPI_STIG_OPI;
	pSTIG_Command->eTransferMode   = ADI_OSPI_TRANSFERMODE_STR;
#ifndef __ADSPSC598_FAMILY__
#if defined(_DEBUG)
	pSTIG_Command->NumOfDummyCycles= 4;
#else
	pSTIG_Command->NumOfDummyCycles= 2;
#endif
#else
	pSTIG_Command->NumOfDummyCycles= 4;
#endif
	pSTIG_Command->ModeData		   = 0;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_READDATA_EN;
	pSTIG_Command->DataSize		   = 3;
	pSTIG_Command->AddressEnable   = 1;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_4;
	pSTIG_Command->Address         = 0;
	pSTIG_Command->pBuffer         = Flash_ID;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to send the FLASH_RDID command to flash. Error: %d \n", eResult);
		return eResult;
	}

	Device_ID = (Flash_ID[1] << 8)| Flash_ID[2];

	printf("Flash Man ID Read :0x%x \n", Flash_ID[0]);
	if(Flash_ID[0] != MX66LM1G45G_MANID)
	{
		printf("Failed to Read ManID of MX66LM1G Flash Device correctly \n");
		return ADI_OSPI_FAILED;
	}

	printf("Flash Device ID Read :0x%x \n", Device_ID);
	if(Device_ID != MX66LM1G45G_DEVID)
	{
		printf("Failed to Read DevID of MX66LM1G Flash Device correctly \n");
		return ADI_OSPI_FAILED;
	}

	return ADI_OSPI_SUCCESS;
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
 Function:       ReadFlash8_OPISTR_STIG

 Description:    Reads 8 bytes from Flash memory in STIG mode - OPI STR mode
 *********************************************************************/
ADI_OSPI_RESULT ReadFlash8_OPISTR_STIG(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command, uint8_t *pDataBuff)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;

	/* Read from flash in OPI STR mode */
	pSTIG_Command->CmdOpcode       = FLASH_OPI_READ_1;
	pSTIG_Command->CmdOpcode2      = FLASH_OPI_READ_2;
	pSTIG_Command->eBusMode        = ADI_OSPI_STIG_OPI;
	pSTIG_Command->eTransferMode   = ADI_OSPI_TRANSFERMODE_STR;
	pSTIG_Command->NumOfDummyCycles= 20;
	pSTIG_Command->ModeDataEnable  = 0;
	pSTIG_Command->ModeData		   = 0;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_READDATA_EN;
	pSTIG_Command->DataSize		   = 8;
	pSTIG_Command->AddressEnable   = 1;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_4;
	pSTIG_Command->Address         = 0;
	pSTIG_Command->pBuffer         = pDataBuff;


	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to send Read command to flash. Error: %d \n", eResult);
		return eResult;
	}

	return ADI_OSPI_SUCCESS;
}

/*********************************************************************
 Function:       Erase_Flash_Block0

 Description:    Erases the Block 0 of Flash memory
 *********************************************************************/
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
 Function:       ReadFlash8_STIG

 Description:    Reads 8 bytes from Flash memory in STIG mode
 *********************************************************************/
ADI_OSPI_RESULT ReadFlash8_STIG(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command, uint8_t *pDataBuff)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;

	/* Enable the Write to flash registers by sending FLASH_WR_EN(0x6) command */
	pSTIG_Command->CmdOpcode       = FLASH_READ;
	pSTIG_Command->CmdOpcode2      = 0;
	pSTIG_Command->eBusMode        = ADI_OSPI_STIG_SINGLE;
	pSTIG_Command->eTransferMode   = ADI_OSPI_TRANSFERMODE_STR;
	pSTIG_Command->NumOfDummyCycles= 0;
	pSTIG_Command->ModeData		   = 0;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_READDATA_EN;
	pSTIG_Command->DataSize		   = 8;
	pSTIG_Command->AddressEnable   = 1;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_3;
	pSTIG_Command->Address         = 0;
	pSTIG_Command->pBuffer         = pDataBuff;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to send Read command to flash. Error: %d \n", eResult);
		return eResult;
	}

	return ADI_OSPI_SUCCESS;
}


/*********************************************************************
 Function:       ProgramFlash8_STIG

 Description:    Programs 8 bytes to Flash memory in STIG mode
 *********************************************************************/
ADI_OSPI_RESULT ProgramFlash8_STIG(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command, uint8_t *pDataBuff)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;
	uint8_t Flash_Status[1];

	/* Enable the Write to flash registers by sending FLASH_WR_EN(0x6) command */
	pSTIG_Command->CmdOpcode       = FLASH_WR_EN;
	pSTIG_Command->CmdOpcode2      = 0;
	pSTIG_Command->eBusMode        = ADI_OSPI_STIG_SINGLE;
	pSTIG_Command->eTransferMode   = ADI_OSPI_TRANSFERMODE_STR;
	pSTIG_Command->NumOfDummyCycles= 0;
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


	/* Initialize the STIG command for Program operation  */
	pSTIG_Command->CmdOpcode       = FLASH_PG_PRM;
	pSTIG_Command->eDataMode	   = ADI_OSPI_STIG_WRITEDATA_EN;
	pSTIG_Command->DataSize		   = 8;
	pSTIG_Command->AddressEnable   = 1;
	pSTIG_Command->AddrSize		   = ADI_OSPI_CMD_ADDR_SIZE_3;
	pSTIG_Command->Address         = 0;
	pSTIG_Command->pBuffer		   = pDataBuff;

	eResult = adi_ospi_StigCommand(hDevice, pSTIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error in sending the program command. Error: %d \n", eResult);
		return eResult;
	}


	/* Wait till Program operation is over */
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

void Select_FlashDevice(void)
{
#ifdef __ADSPSC598_FAMILY__
	/* Configure the softconfig switches on SOM board to disable ISSI Flash*/
	ConfigSoftSwitches_SC598_SOM_Macronix();
#else
	/* Configure the softconfig switches on SOM board to disable ISSI Flash*/
	ConfigSoftSwitches_EV_21593_SOM_Macronix();
#endif

	/* Configure the softconfig switches on CRR board to enable Macronix Flash*/
	ConfigSoftSwitches_EV_SOMCRR_EZKIT_Macronix();
}

void Delay(uint32_t nDelay)
{
	int i;
	for(i = 0; i<nDelay; i++ )
	{
		asm("nop;");
	}
}


