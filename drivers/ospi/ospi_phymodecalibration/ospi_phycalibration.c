/*********************************************************************************
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/
/*!
* @file      ospi_phycalibration.c
*
* @brief     This is the primary source file for OSPI-PHY mode Flash Direct read access example.
*
*/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include <services/gpio/adi_gpio.h>
#include "adi_initialize.h"
#include "ospi_phycalibration.h"
#include "time.h"

extern uint32_t adi_pwr_cfg0_init(void);

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
uint32_t HandleMem = 0;
volatile uint8_t DMA_Done = 0;

/* Buffer into which the data from Flash is read in to */
#if defined(__ADSPSC598_FAMILY__)
ADI_CACHE_ALIGN uint8_t ReadBuff[32];

ADI_CACHE_ALIGN uint8_t ReadBuffData[ADI_CACHE_ROUND_UP_SIZE(1024, uint8_t)];

/* Buffer containing the know reference data written in Flash device. Used for comparison of read data */
ADI_CACHE_ALIGN uint8_t WriteBuff[ADI_CACHE_ROUND_UP_SIZE(1024, uint8_t)] = {
#include"OSPI_Test_Data.dat"
};

#else
uint8_t ReadBuff[32];

ADI_CACHE_ALIGN uint8_t ReadBuffData[1024];

/* Buffer containing the know reference data written in Flash device. Used for comparison of read data */
ADI_CACHE_ALIGN uint8_t WriteBuff[1024] = {
#include"OSPI_Test_Data.dat"
};
#endif

ADI_DMA_DESC_LIST_MODE  Dest_List[MEMCOPY_NUM_DESC] =	{
															{	0,
#if defined(__ADSPSC598_FAMILY__) && defined(__ADSPCORTEXA55__)
																((uint32_t)(uint64_t)FLASHADDRESS),
#else
																(uint8_t *)FLASHADDRESS,
#endif
																ENUM_DMA_CFG_MSIZE04 | ENUM_DMA_CFG_PSIZE04,
																sizeof(WriteBuff)/4,
																4,
																0,
																0,
																NULL,
																true
															}
														};

ADI_DMA_DESC_LIST_MODE  Src_List[MEMCOPY_NUM_DESC] =	{
															{	0,
#if defined(__ADSPSC598_FAMILY__) && defined(__ADSPCORTEXA55__)
																((uint32_t)(uint64_t)0x00000000),
#else
																((uint8_t *)WriteBuff + 0),
#endif
																ENUM_DMA_CFG_MSIZE04 | ENUM_DMA_CFG_PSIZE04,
																sizeof(WriteBuff)/4,
																4,
																0,
																0,
																NULL,
																false
															}
														};

ADI_DMA_DESC_LIST_MODE  Dest_List1[MEMCOPY_NUM_DESC] =	{
															{	0,
#if defined(__ADSPSC598_FAMILY__) && defined(__ADSPCORTEXA55__)
																((uint32_t)(uint64_t)0x00000000),
#else
																((uint8_t *)ReadBuffData + 0),
#endif
																ENUM_DMA_CFG_MSIZE04 | ENUM_DMA_CFG_PSIZE04,
																sizeof(ReadBuffData)/4,
																4,
																0,
																0,
																NULL,
																true
															}
														};

ADI_DMA_DESC_LIST_MODE  Src_List1[MEMCOPY_NUM_DESC] =	{
															{	0,
#if defined(__ADSPSC598_FAMILY__) && defined(__ADSPCORTEXA55__)
																((uint32_t)(uint64_t)FLASHADDRESS),
#else
																(uint8_t *)FLASHADDRESS,
#endif
																ENUM_DMA_CFG_MSIZE04 | ENUM_DMA_CFG_PSIZE04,
																sizeof(ReadBuffData)/4,
																4,
																0,
																0,
																NULL,
																false
															}
														};

uint8_t STIG_RW_Buffer[8];

ADI_OSPI_DAC_CMD DAC_Command = 		{   /*! command op-code */
										FLASH_FST_READ,
										/*! 2nd command byte for commands with extended op-code, OPTIONAL */
										0x0,
										/*! Bus mode */
										ADI_OSPI_OPI,
										/*! Transfer mode */
										ADI_OSPI_TRANSFERMODE_DTR_P,
										/*! DMA mode or Core mode */
										OSPI_ADI_COREMODE,
										/*! Number of Address Bytes */
										ADI_OSPI_CMD_ADDR_SIZE_4,
										/*! Number of dummy bytes */
										16,
										/*! Whether Mode data will be sent */
										0,
										/*! Mode byte data */
										0,
										/*! Source Pointer to the data buffer in Core mode or pointer to descriptor list in DMA mode */
										(uint8_t *)FLASHADDRESS,
										/*! Destination Pointer to the data buffer in Core mode or pointer to descriptor list in DMA mode */
										(uint8_t *)ReadBuff,
										/*! Size of data buffer in Core mode or Size of descriptor list in DMA mode */
										4
									};

ADI_OSPI_DAC_CMD DAC_Command_Read = {    /*! command op-code */
										FLASH_QIOR_DTRREAD,
										/*! 2nd command byte for commands with extended op-code, OPTIONAL */
										0,
										/*! Bus mode */
										ADI_OSPI_QIOR,
										/*! Transfer mode */
										ADI_OSPI_TRANSFERMODE_DTR,
										/*! DMA mode or Core mode */
										OSPI_ADI_DMAMODE,
										/*! Number of Address Bytes */
										ADI_OSPI_CMD_ADDR_SIZE_3,
										/*! Number of dummy bytes */
										6,
										/*! Whether Mode data will be sent */
										0,
										/*! Mode byte data */
										0,
										/*! Source Pointer to the data buffer in Core mode or pointer to descriptor list in DMA mode */
										(uint8_t *)Src_List1,
										/*! Destination Pointer to the data buffer in Core mode or pointer to descriptor list in DMA mode */
										(uint8_t *)Dest_List1,
										/*! Size of data buffer in Core mode or Size of descriptor list in DMA mode */
										1
									};

ADI_OSPI_DAC_CMD DAC_Command_Write = {    /*! command op-code */
										0x02,
										/*! 2nd command byte for commands with extended op-code, OPTIONAL */
										0x00,
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
										(uint8_t *)Src_List,
										/*! Destination Pointer to the data buffer in Core mode or pointer to descriptor list in DMA mode */
										(uint8_t *)Dest_List,
										/*! Size of data buffer in Core mode or Size of descriptor list in DMA mode */
										1
									};


ADI_OSPI_STIGCMD STIG_Command =  	{	/*! command op-code */
										0x3,
										/*! 2nd command byte for commands with extended op-code */
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

int main(int argc, char *argv[])
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;
	ADI_OSPI_PHYDLLSTATUS PhyDllStatus;
	ADI_OSPI_PHYCONFIGURATION *pPhyConfiguration;
	ADI_OSPI_PHYCONFIGURATION PhyConfiguration;
	pPhyConfiguration = &PhyConfiguration;

	ADI_OSPI_HANDLE *phDevice = (ADI_OSPI_HANDLE)&HandleMem;
	ADI_SPU_HANDLE hSpu;

	/* Allocate memory for SPU service */
	uint8_t *pSpuMemory = nDriver_Memory;

	adi_initComponents();
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif

	/* Configure the Clocks. For PHY test the clock source is selected as SCLK0_0 at 125 MHz */
	adi_pwr_cfg0_init();

	/* Initialize SPU for MDMA operation */
	if(adi_spu_Init(0u, pSpuMemory, NULL, NULL, &hSpu) != ADI_SPU_SUCCESS)
	{
		printf("SPU Initialization failed \n");
		printf("Fail \n");
		return 0;
	}

	/* Configure MDMA Source to generate secure transactions */
	if(adi_spu_EnableMasterSecure(hSpu, gMdmaSpuIds.nSrcMdmaSpuId[MDMA_CHANNEL_USED], true) != ADI_SPU_SUCCESS)
	{
		printf("Enabling SPU Master failed \n");
		printf("Fail \n");
		return 0;
	}

	/* Configure MDMA Destination to generate secure transactions */
	if(adi_spu_EnableMasterSecure(hSpu, gMdmaSpuIds.nDestMdmaSpuId[MDMA_CHANNEL_USED], true) != ADI_SPU_SUCCESS)
	{
		printf("Enabling SPU Master failed \n");
		printf("Fail \n");
		return 0;
	}

#if defined(__ADSPSC598_FAMILY__) && defined(__ADSPCORTEXA55__)
	Src_List[0].pStartAddress = (uint32_t)(uint64_t)&WriteBuff[0];
	Dest_List1[0].pStartAddress = (uint32_t)(uint64_t)&ReadBuffData[0];
#endif

	eResult = adi_ospi_Open(   (uint8_t *)nDriver_Memory + ADI_SPU_MEMORY_SIZE,
								ADI_OSPI_MEMORY_SIZE,
								OSPI_ADI_MDMAUSED,
								MDMA_CHANNEL_USED,
								phDevice
							 );

	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to Open OSPI driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	eResult = adi_ospi_RegisterCallback (  *phDevice,
											NULL,
											OspiMdmaCallback,
											phDevice);

	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to Register OSPI Callback. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/*This has no impact in PHY mode as the SPI is clock is same as Ref clock when PHY is enabled.
	This setting will, however, impact OPS operation before PHY is enabled*/
	eResult = adi_ospi_ConfigBaud(*phDevice, ADI_OSPI_BAUD_DIV_BY_8);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to update the Baud rate. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Configures the on-board soft config switches according to which FLash needs to be used for the test */
	Select_FlashDevice();

	/* Erase the flash memory before attempting to program the flash */
	eResult = Erase_Flash_Block0(*phDevice, &STIG_Command);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in while trying to erase the block0 of flash. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Write 1KB of random known value into the erased sector */
	eResult = adi_ospi_DirectWrite(*phDevice, &DAC_Command_Write);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in OSPI Write, Error code returned %d \n", eResult);
	}

	/* Wait for DMA to finish */
	Wait_For_DMA();

	/* Configures the flash device to enter into the Quad mode */
	Configure_Flash(*phDevice, &STIG_Command);

	/* Prepares the OSPI command according to the mode in which OSPI should operate */
	Prepare_Ospi_Command(&DAC_Command);


	/* Configure DS-2 for OSPI pins */
	*pREG_PADS0_PORTA0_DS =	(OSPI_DS << 0) | (OSPI_DS << 3) | (OSPI_DS << 6) | (OSPI_DS << 9) |
							(OSPI_DS << 12) | (OSPI_DS << 15) | (OSPI_DS << 18) | (OSPI_DS << 21);

	/* Initialize PHY data structure */
	pPhyConfiguration->bPhyPipelineModeEn = true ;
	pPhyConfiguration->ePhyBypassMode = ADI_OSPI_PHYBYPASS_EN;
	pPhyConfiguration->eTransferMode = DAC_Command.eTransferMode;
	pPhyConfiguration->TransferCommand = &DAC_Command;
	pPhyConfiguration->pDataPattern = WriteBuff;
	pPhyConfiguration->bAutoCalibEn = true;
	pPhyConfiguration->bDqsEnable =	false;

	/* PHY mode init and calibration */
	eResult = adi_ospi_PhyInit(*phDevice, pPhyConfiguration);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("PHY initialization failed: Error %d \n", eResult);
	}

	/* Read back DLL value set by Auto Calibration */
	adi_ospi_PhyGetDllStat(*phDevice, &PhyDllStatus);
	printf("\n----------------------------------------------------------\n");
	printf("Auto Calibration success");
	printf("\nSelected Rx Delay = %d", PhyDllStatus.dllRxOutput);
	printf("\nSelected Tx Delay = %d \n", PhyDllStatus.dllTxOutput);

	/* Perform the read operation in the configured mode of OSPI and flash */
	eResult = adi_ospi_DirectRead( *phDevice, &DAC_Command_Read );

	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Read back failed, Error code returned %d \n", eResult);
	}

	/* Wait for DMA to finish */
	Wait_For_DMA();

	/* Close the OPSI driver */
	eResult = adi_ospi_Close(*phDevice);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to Close OSPI driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Verifies the data */
	if (VerifyData(ReadBuffData, WriteBuff, sizeof(ReadBuffData)) == 0)
	{
		printf("Data transfer completed successfully \n");
		printf("All Done  \n");
	}

	else
	{
		printf(" Data transfer failed with errors \n");
	}

	return 0;
}


/* Callback function for OSPI MDMA transfer */
void OspiMdmaCallback(void *AppHandle, uint32_t Event, void *pArg)
{
	DMA_Done = 1;
}



/* Verifies the data */
int8_t VerifyData(uint8_t *pReadBuff, uint8_t *pWriteBuff, uint32_t BUFF_size)
{
	int count =0, error_count =0;

	for(count=0; count<BUFF_size; count++)
	{
		if(pReadBuff[count] != pWriteBuff[count])
		{
			error_count++;
			printf("Failed at count : %d !!! \n\n", count);
			return -1;
		}
	}

	return 0;
}


/* For DMA test waits till the DMA_Done flag is set in Callback
 * For Core mode it returns without doing anything */
void Wait_For_DMA(void)
{
	while(!DMA_Done);
	DMA_Done = 0;
}
