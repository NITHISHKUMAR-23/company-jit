/*********************************************************************************
Copyright(c) 2020 - 2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*!
* @file      ospi_flashdirectaccess_octal.c
*
* @brief     This is the primary source file for OSPI Octal Flash Direct read access example.
*
*/

#include "ospi_flashdirectaccess_octal.h"

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"




/* Buffers and variables used by the Test */

typedef struct
{
	uint32_t nSrcMdmaSpuId[8];
	uint32_t nDestMdmaSpuId[8];
}ADI_OSPI_MDMA_SPU_ID;


uint8_t nDriver_Memory[ADI_OSPI_MEMORY_SIZE + ADI_SPU_MEMORY_SIZE];

/*! \var ADI_OSPI_MDMA_SPU_ID gMdmaSpuIds
    This variable stores the SPU IDS for different MDMA channels
*/
#ifdef __ADSPSC598_FAMILY__
static ADI_OSPI_MDMA_SPU_ID gMdmaSpuIds = {	{ 147, 149, 135, 136, 151, 153, 159, 137 },
		                                    { 148, 150, 135, 136, 152, 154, 159, 137} };
#else
static ADI_OSPI_MDMA_SPU_ID gMdmaSpuIds = {	{ 146, 148, 134, 135, 150, 152, 158, 136 },
		                                    { 147, 149, 134, 135, 151, 153, 158, 136} };
#endif


/* Handle for OSPI driver */
uint32_t HandleMem = 0;
ADI_OSPI_HANDLE *phDevice = (ADI_OSPI_HANDLE)&HandleMem;

/* Handle for SPU*/
ADI_SPU_HANDLE hSpu;

/* Allocate memory for SPU service */
uint8_t *pSpuMemory = nDriver_Memory;

/* Flag to indicate DMA completion */
volatile uint8_t DMA_Done = 0;

/* Buffer into which the data from Flash is read in to */
ADI_CACHE_ALIGN uint8_t ReadBuff[ADI_CACHE_ROUND_UP_SIZE(DESC_BUFFER_SIZE, uint8_t)];

/* Buffer containing the know reference data written in Flash device. Used for comparison of read data */
ADI_CACHE_ALIGN uint8_t WriteBuff[ADI_CACHE_ROUND_UP_SIZE(DESC_BUFFER_SIZE, uint8_t)] = {
#include"FlashWrite_Data.dat"
};

/* Buffer into which the data from Flash is read in to */
ADI_CACHE_ALIGN uint8_t EraseBuff[ADI_CACHE_ROUND_UP_SIZE(DESC_BUFFER_SIZE, uint8_t)] = {
#include"Erased_Data.dat"
};

/* Buffer for use in STIG mode */
uint8_t STIG_RW_Buffer[8];


/* External definitions */
extern void adi_pwr_cfg0_init(void) ;

extern  ADI_DMA_DESC_LIST_MODE  Read_Dest_List[MEMCOPY_NUM_DESC];
extern  ADI_DMA_DESC_LIST_MODE  Read_Src_List[MEMCOPY_NUM_DESC];
extern  ADI_DMA_DESC_LIST_MODE  Program_Dest_List[MEMCOPY_NUM_DESC];
extern  ADI_DMA_DESC_LIST_MODE  Program_Src_List[MEMCOPY_NUM_DESC];

extern ADI_OSPI_DAC_CMD DAC_Read_Command;
extern ADI_OSPI_DAC_CMD DAC_Program_Command;
extern ADI_OSPI_STIGCMD STIG_Command;


int main(int argc, char *argv[])
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;
	uint32_t BUFF_size;

	adi_initComponents();
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif

	/* Configure the Clocks */
#ifndef __ADSPSC598_FAMILY__
	adi_pwr_cfg0_init();
#endif

	/* Initialize SPU for securing DMA accesses to memory*/
	if(Spu_Initialize() != 0U)
		return 0;

#ifndef __ADSPSC598_FAMILY__
	/* Initialize pin mux for TWI2 for soft config switch setting*/
	Init_TwiPinMux();

	/* Initialize OSPI pin mux */
	Init_pinmux();
#endif

#if defined(__ADSPSC598_FAMILY__) && defined(__ADSPCORTEXA55__)
	Read_Dest_List[0].pStartAddress = (uint32_t)(uint64_t)&ReadBuff[0];
	Program_Src_List[0].pStartAddress = (uint32_t)(uint64_t)&WriteBuff[0];
#endif

	/* Initialize OSPI controller */
	if(Ospi_initialize() != 0U)
		return 0;

	/* Configures the on-board soft config switches to select Macronix Octal flash device */
	Select_FlashDevice();

	/* Erase the flash memory before attempting to program the flash */
	eResult = Erase_Flash_Block0(*phDevice, &STIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in while trying to erase the block0 of flash. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Read back the data from the Flash after Erase operation */
	eResult = adi_ospi_DirectRead( *phDevice, &DAC_Read_Command );

	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in OSPI Direct Read. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Wait for OSPI Read to finish */
	Wait_For_DMA();

	/* Check if the data in the flash is erased correctly */
	BUFF_size = sizeof(ReadBuff);

	if(VerifyData(ReadBuff, EraseBuff, BUFF_size) != 0)
	{
		printf("Data is not Erased properly \n");
		printf("Fail \n");
		return 0;
	}


	/* Perform the program operation in the Single of OSPI and flash */
	eResult = adi_ospi_DirectWrite( *phDevice, &DAC_Program_Command );
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in OSPI direct write operation. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Wait for Program operation to finish */
	Wait_For_DMA();

	/* Configures the flash device to enter the QPI mode of operation */
	Configure_Flash(*phDevice, &STIG_Command);

	/* Prepares the OSPI command to configure OSPI in QPI DTR mode  */
	Prepare_Ospi_Command(&DAC_Read_Command);

	/* Perform the read operation from flash in QPI DTR mode */
	eResult = adi_ospi_DirectRead( *phDevice, &DAC_Read_Command );

	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in OSPI Direct Read. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Wait for DMA to finish */
	Wait_For_DMA();

	/* Restores the flash device to normal SPI mode to enable the next read */
	Restore_Flash(*phDevice, &STIG_Command);

	/* Close the OPSI driver */
	eResult = adi_ospi_Close(*phDevice);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to Close OSPI driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Compare the data */
	BUFF_size = sizeof(ReadBuff);
	if(VerifyData(ReadBuff, WriteBuff, BUFF_size) == 0)
	{
		printf("Data transfer completed successfully \n");
		printf("All Done  \n");
	}
	else
	{
		printf("Data transfer failed with errors \n");
	}

	return 0;
}


#ifndef __ADSPSC598_FAMILY__
/* Configures the Pin mux for OSPI */
void Init_pinmux(void)
{
	*pREG_PORTA_MUX |= 0xAA555;
	*pREG_PORTA_FER_SET = (BITM_PORT_FER_PX0 |BITM_PORT_FER_PX1| BITM_PORT_FER_PX2 | BITM_PORT_FER_PX3 | BITM_PORT_FER_PX4| BITM_PORT_FER_PX5 |
					       BITM_PORT_FER_PX6 | BITM_PORT_FER_PX7 | BITM_PORT_FER_PX8 | BITM_PORT_FER_PX9 );

}


void Init_TwiPinMux(void)
{
	 /* PORTx_MUX registers */
	*pREG_PORTA_MUX |= TWI2_SCL_PORTA_MUX | TWI2_SDA_PORTA_MUX;

	/* PORTx_FER registers */
	*pREG_PORTA_FER_SET = TWI2_SCL_PORTA_FER | TWI2_SDA_PORTA_FER;
}
#endif


/* Callback function for OSPI MDMA transfer */
void OspiMdmaCallback(void *AppHandle, uint32_t Event, void *pArg)
{
	DMA_Done = 1;
}



/* Verifies the data */
int8_t VerifyData(uint8_t *pReadBuff, uint8_t *pWriteBuff, uint32_t BUFF_size)
{
	uint32_t count =0, error_count =0;

	for(count=0; count<BUFF_size; count++)
	{
		if(pReadBuff[count] != pWriteBuff[count])
		{
			error_count++;
			printf("Failed at count : %d !!! \n\n", (int)count);
			return -1;
		}
	}

	return 0;
}


/* For DMA test waits till the DMA_Done flag is set in Callback */
void Wait_For_DMA(void)
{
	while(!DMA_Done);

	/* Reset the flag for next operation */
	DMA_Done = 0;
}




/* Erases the First block of the Flash memory */
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


int Spu_Initialize(void)
{
	/* Initialize SPU for MDMA operation */
	if(adi_spu_Init(0u, pSpuMemory, NULL, NULL, &hSpu) != ADI_SPU_SUCCESS)
	{
		printf("SPU Initialization failed \n");
		return -1;
	}


	/* Configure MDMA Source to generate secure transactions */
	if(adi_spu_EnableMasterSecure(hSpu, gMdmaSpuIds.nSrcMdmaSpuId[MDMA_CHANNEL_USED], true) != ADI_SPU_SUCCESS)
	{
		printf("Enabling SPU Master failed \n");
		return -1;
	}

	/* Configure MDMA Destination to generate secure transactions */
	if(adi_spu_EnableMasterSecure(hSpu, gMdmaSpuIds.nDestMdmaSpuId[MDMA_CHANNEL_USED], true) != ADI_SPU_SUCCESS)
	{
		printf("Enabling SPU Master failed \n");
		return -1;
	}

	return 0;

}


int Ospi_initialize(void)
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;

	eResult = adi_ospi_Open(   (uint8_t *)nDriver_Memory + ADI_SPU_MEMORY_SIZE,
								ADI_OSPI_MEMORY_SIZE,
								OSPI_ADI_MDMAUSED,
								MDMA_CHANNEL_USED,
								phDevice
							 );


	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to Open OSPI driver. Error code returned %d \n", eResult);
		return -1;
	}

	eResult = adi_ospi_RegisterCallback (  *phDevice,
											NULL,
											OspiMdmaCallback,
											phDevice);

	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to Register OSPI Callback. Error code returned %d \n", eResult);
		return -1;
	}




	eResult = adi_ospi_ConfigBaud(*phDevice, ADI_OSPI_BAUD_DIV_BY_32);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to update the Baud rate. Error code returned %d \n", eResult);
		return -1;
	}

	eResult = adi_ospi_UpdateReadDelay(*phDevice, 8);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to update the Read delay capture value. Error code returned %d \n", eResult);
		return -1;
	}

	return 0;
}
