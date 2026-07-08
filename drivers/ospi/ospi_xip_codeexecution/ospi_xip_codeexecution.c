/*********************************************************************************

Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/

/*****************************************************************************
 * ospi_xip_codeexecution_21593_Core1.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "ospi_xip_codeexecution.h"



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
static ADI_OSPI_MDMA_SPU_ID gMdmaSpuIds = {	{ 147, 148, 134, 135, 150, 152, 158, 136 },
		                                    { 148, 149, 134, 135, 151, 153, 158, 136} };
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

volatile uint8_t DMA_Done = 0;


/* Buffer into which the data from Flash is read in to */
uint8_t ReadBuff_dummy[4];


/* External definitions */
extern ADI_OSPI_DAC_CMD DAC_Command;
extern void adi_pwr_cfg0_init(void);



int main()
{
	ADI_OSPI_RESULT eResult = ADI_OSPI_SUCCESS;

	adi_initComponents();
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif

#ifndef __ADSPSC598_FAMILY__
	/* Configure the Clocks */
	adi_pwr_cfg0_init();
#endif

	/* Initialize SPU for securing DMA accesses to memory*/
	if(Spu_Initialize() != 0U)
		return 0;

	/* Initialize pin mux for TWI2 for soft config switch setting*/
	Init_TwiPinMux();

	/* Initialize OSPI pin mux */
	Init_pinmux();

	/* Initialize OSPI controller */
	if(Ospi_initialize() != 0U)
		return 0;

	/* Configures the on-board soft config switches to select ISSI flash device */
	Select_FlashDevice();

	/* Configure the controller for Read operations. Dummy read with mode bits set to
	 * 0xAX value to put the flash in Xip mode */
	eResult = adi_ospi_DirectRead( *phDevice, &DAC_Command );
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in OSPI Direct Read. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Enter XIP mode immediately as by now, flash will already be in XIP mode */
	eResult = adi_ospi_EnterXipmode(*phDevice, true);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in entering XiP mode. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Code execution from Flash */
	uint32_t ExpVal, RecVal, Val2, Val3, Iteration = 0;
	int FlashError = 0;
	Val2 = 10;
	Val3 = 15;

	while(Iteration < 10)
	{
		/* Do some calculations */
		ExpVal = (Val2*Val3) + (Val2*Iteration);

		/* call the function in Flash memory */
		RecVal =  Code_In_Flash(Iteration);
		Iteration++;

		if(RecVal != ExpVal)
		{
			FlashError = -1;
			break;
		}
	}


	/* Exit XIP mode of controller */
	eResult = adi_ospi_ExitXipmode(*phDevice);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in exiting XiP mode. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	Delay(1000);

	/* Dummy read with mode bits set to non-0xAX value to take flash out of Xip mode
	 * This extra read is also needed for controller to exit the Xip mode */
	DAC_Command.ModeData = 0xBB;
	eResult = adi_ospi_DirectRead( *phDevice, &DAC_Command );
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Error occurred in OSPI Direct Read. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}


	/* Close the OPSI driver */
	eResult = adi_ospi_Close(*phDevice);
	if(eResult != ADI_OSPI_SUCCESS)
	{
		printf("Failed to Close OSPI driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}


	if(FlashError == 0)
	{
		printf("Code Execution from Flash happened correctly  \n");
		printf("All Done  \n");
	}
	else
	{
		printf("Fail \n");
	}

	return 0;
}




/* Configures the Pin mux for OSPI */
void Init_pinmux(void)
{
	*pREG_PORTA_MUX |= 0xAA555;
	*pREG_PORTA_FER_SET = (BITM_PORT_FER_PX0 |BITM_PORT_FER_PX1| BITM_PORT_FER_PX2 | BITM_PORT_FER_PX3 | BITM_PORT_FER_PX4| BITM_PORT_FER_PX5 |
					       BITM_PORT_FER_PX6 | BITM_PORT_FER_PX7 | BITM_PORT_FER_PX8 | BITM_PORT_FER_PX9 );

}


/* Configures the Pin mux for TWI */
void Init_TwiPinMux(void)
{
	 /* PORTx_MUX registers */
	*pREG_PORTA_MUX |= TWI2_SCL_PORTA_MUX | TWI2_SDA_PORTA_MUX;

	/* PORTx_FER registers */
	*pREG_PORTA_FER_SET = TWI2_SCL_PORTA_FER | TWI2_SDA_PORTA_FER;
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


/* For DMA test waits till the DMA_Done flag is set in Callback
 * For Core mode it returns without doing anything */
void Wait_For_DMA(void)
{
	DMA_Done = 0;

}



/* Initializes SPU */
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


/* Initializes OSPI controller */
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


void Delay(uint32_t delay)
{
	while(delay--)
	{
		asm("nop;");
	}
}
