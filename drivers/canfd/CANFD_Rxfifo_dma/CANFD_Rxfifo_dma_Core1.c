/*********************************************************************************

Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/

/*****************************************************************************
 * CANFD_Rxfifo_dma_Core1.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "CANFD_Rxfifo_dma_Core1.h"


typedef struct
{
	uint32_t nSrcMdmaSpuId[8];
	uint32_t nDestMdmaSpuId[8];
}ADI_CANFD_MDMA_SPU_ID;


/* Buffers and variables used by the Test */
uint8_t nCANFD1Driver_Memory[ADI_CANFD_MEMORY_SIZE];
uint8_t nSPUDriver_Memory[ADI_SPU_MEMORY_SIZE];
uint32_t HandleMem1 = 0;


/*! \var ADI_CANFD_MDMA_SPU_ID gMdmaSpuIds
    This variable stores the SPU IDS for different MDMA channels
*/
#if defined(__ADSPSC594W__) || defined(__ADSPSC592W__) || defined(__ADSPSC591W__)
static ADI_CANFD_MDMA_SPU_ID gMdmaSpuIds = {	{ 146, 148, 134, 135, 150, 152, 158, 136 },
		                                        { 147, 149, 134, 135, 151, 153, 158, 136 } };

#else
static ADI_CANFD_MDMA_SPU_ID gMdmaSpuIds = {	{ 147, 149, 135, 136, 151, 153, 159, 137 },
		                                        { 148, 150, 135, 136, 152, 154, 159, 137 } };

#endif

ADI_CANFD_FIFODATA Canfd1_FifoData_FIFO[64];
ADI_CANFD_RXFIFOCONFIG Canfd1_RxFifoConfig;
uint32_t RxFifo_Filtertable[128];

/* Buffers to store reference MB data for comparison */
uint32_t MBSentData[64][2];



/* Callback count */
volatile int ReceivedMBCOunt = 0, OtherCallbackCount = 0, FifoDataReceived = 0;


int main(int argc, char *argv[])
{
	ADI_CANFD_RESULT eResult = ADI_CANFD_SUCCESS;
	int count = 0,  Received_Id;

	/* Allocate memory for SPU service */
	uint8_t *pSpuMemory = nSPUDriver_Memory;
	ADI_SPU_HANDLE hSpu;

	/* Allocate CANFD driver handle */
	ADI_CANFD_HANDLE *phDevice1 = (ADI_CANFD_HANDLE)&HandleMem1;

	adi_initComponents();

	/* Initialize the reference buffers for comparison */
	InitCanMBData();

	/* Initialize SPU for MDMA operation */
	if(adi_spu_Init(0u, pSpuMemory, NULL, NULL, &hSpu) != ADI_SPU_SUCCESS)
	{
		printf("SPU Initialization failed \n");
		printf("Fail \n");
		return 0;
	}

	/* Configure MDMA Source to generate secure transactions */
	if(adi_spu_EnableMasterSecure(hSpu, gMdmaSpuIds.nSrcMdmaSpuId[ADI_CANFD1_CFG_MDMASTREAMID], true) != ADI_SPU_SUCCESS)
	{
		printf("Enabling SPU Master failed \n");
		printf("Fail \n");
		return 0;
	}

	/* Configure MDMA Destination to generate secure transactions */
	if(adi_spu_EnableMasterSecure(hSpu, gMdmaSpuIds.nDestMdmaSpuId[ADI_CANFD1_CFG_MDMASTREAMID], true) != ADI_SPU_SUCCESS)
	{
		printf("Enabling SPU Master failed \n");
		printf("Fail \n");
		return 0;
	}

	/* Open the CANFD1 device */
	eResult = adi_canfd_Open( 1U,
							  (uint8_t *)nCANFD1Driver_Memory,
							  ADI_CANFD_MEMORY_SIZE,
							  phDevice1);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to Open CANFD1 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Register Callback for CANFD1 */
	eResult = adi_canfd_RegisterCallback (*phDevice1, CANFD1_CallBack, NULL);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to register callback for CANFD1 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Configure Global Mask for CANFD1 */
	eResult = adi_canfd_SetRxGlobalMask(*phDevice1, 0xFFFFFFFF, 0xFFFFFFFF);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to set Global mask for CANFD1 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}


	/* Initialize the RX FIFO configuration structure. Enable 64 filters */
	Canfd1_RxFifoConfig.pIdFilterTable = RxFifo_Filtertable;

	/*Define number of filter table entries. This shoud not exceed the number of filter available as per
	 * the setting in config file "ADI_CANFD1_CFG_NUM_FIFOFILTERS" */
	Canfd1_RxFifoConfig.numIdFilter = 64;
	Canfd1_RxFifoConfig.idFilterType = ADI_CANFD_FILTERTYPE_A;

	/* Assign priority to receive the messages in FIFO as compared to standard MBs */
	Canfd1_RxFifoConfig.priority = ADI_CANFD_FIFOPRIO_HI;

	/* Initialize the FIFO filter table to allow reception of different ID MBs */
	for(count = 0; count < Canfd1_RxFifoConfig.numIdFilter; count++)
	{
#ifdef STANDARDFRAME
		RxFifo_Filtertable[count] = (count << 1) << 18;
#else
		RxFifo_Filtertable[count] = (count) << 1 ;      // Bit 0 in ID filter is reserved
		RxFifo_Filtertable[count] |= 1 << 30;         // Set IDE bit
#endif
	}


	/* Configure the CANFD Rx FIFO to receive the message from CANFD0 */
	eResult = adi_canfd_ConfigureRxFifo(*phDevice1, &Canfd1_RxFifoConfig);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to configure RX FIFO for CANFD1 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}


    /* Set the flag in RCU_MSG to allow Core0 to proceed indicating RX MBs are ready to receive */
	*pREG_RCU0_MSG |=  0x1000;


	/* Read the Mbs one by one from FIFO */
	for(count = 0; count < 64; count++)
	{
		eResult = adi_canfd_RecvFifo_NonBlockingDma(*phDevice1, &Canfd1_FifoData_FIFO[count]);
		if(eResult != ADI_CANFD_SUCCESS)
		{
			printf("Failed to Receive data on RX FIFO for count %d for CANFD1 driver. Error code returned %d \n", count, eResult);
			printf("Fail \n");
			return 0;
		}

		/* Wait till FIFO is read before issuing next FIFO read */
		while(FifoDataReceived == 0);
		FifoDataReceived = 0;           /* Reset the flag */
	}


	/* Check if any other callback other than TX MB has occurred */
	if(OtherCallbackCount != 0)
	{
		printf("\n Notice : %d Other callback have occurred!!. You may want to check the reason for that. \n", OtherCallbackCount);

	}

	/* Fix the endianness of the received data as the data received through DMA is not endian-ness corrected */
	for(count = 0; count < 64; count++)
	{
		MBDataSwapEndian32((uint32_t *)&Canfd1_FifoData_FIFO[count].MBData[0]);
		MBDataSwapEndian32((uint32_t *)&Canfd1_FifoData_FIFO[count].MBData[4]);
	}


	/* Close the CAN Driver */
	eResult = adi_canfd_Close(*phDevice1);

	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to Close CANFD1 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}


	/* Compare the received data */
	eResult = VerifyData();

	if(eResult == 0)
	{
		printf("\n Successfully Received data from all MBs \n");
		printf("All Done \n");
	}
	else
	{
		printf("\n Test failed \n");
	}

    return 0;
}



/* Function to compare the received data */
ADI_CANFD_RESULT VerifyData(void)
{
	int count = 0;
	/* Compare the data for 64 frames received through FIFO */
	for(count = 0; count < 64; count++)
	{
		if( (Canfd1_FifoData_FIFO[count].MBData[0] != ((MBSentData[count][0] >> 0) & 0xFF) ) &&
			(Canfd1_FifoData_FIFO[count].MBData[1] != ((MBSentData[count][0] >> 1) & 0xFF) ) &&
			(Canfd1_FifoData_FIFO[count].MBData[2] != ((MBSentData[count][0] >> 2) & 0xFF) ) &&
			(Canfd1_FifoData_FIFO[count].MBData[3] != ((MBSentData[count][0] >> 3) & 0xFF) ) &&
			(Canfd1_FifoData_FIFO[count].MBData[4] != ((MBSentData[count][1] >> 1) & 0xFF) ) &&
			(Canfd1_FifoData_FIFO[count].MBData[5] != ((MBSentData[count][1] >> 2) & 0xFF) ) &&
			(Canfd1_FifoData_FIFO[count].MBData[6] != ((MBSentData[count][1] >> 3) & 0xFF) ) &&
			(Canfd1_FifoData_FIFO[count].MBData[7] != ((MBSentData[count][1] >> 4) & 0xFF) ) )
		{
			printf("\n Data comparison for MB%d failed. \n", count);
			return ADI_CANFD_FAILED;
		}
	}

	return ADI_CANFD_SUCCESS;
}


/* Function to initialize CANFD user data for reference comparison */
void InitCanMBData(void)
{
	 /* Initialize the data with known pattern */
	int count = 0;

	for(; count < 64; count++)
	{
		MBSentData[count][0] = count+20;
		MBSentData[count][1] = count+120;
	}
}


/* Callback function for CANFD1 */
static void CANFD1_CallBack(void *AppHandle, uint32_t Event, void *pArg)
{
	/* Increment the count for each transmitted MB */
    if(Event & (1 << ADI_CANFD_RXDATA))
    {
    	ReceivedMBCOunt++;
    	printf("Successfully Received MB%d in non-blocking mode. \n", (uint32_t)pArg);
    }
    else if(Event & (1 << ADI_CANFD_DMADONE))
    {
    	FifoDataReceived = 1;
    	printf("Successfully received MB with RX FIFO in DMA mode \n");
    }
    else if(Event & (1U << ADI_CANFD_DMAERROR))
    {
    	printf(" DMA FIFO read error !!!! \n");
    }
    else
    {
    	/* Count other callbacks other than TX MB callback */
    	OtherCallbackCount++;
    }
}


void MBDataSwapEndian32(uint32_t *pData)
{
	*pData = (uint32_t)((*pData >> 24U) & 0xFFUL) |      /* move byte 3 to byte 0 */
			 (uint32_t)((*pData << 8U)  & 0xFF0000UL) |  /* move byte 1 to byte 2 */
			 (uint32_t)((*pData >> 8U)  & 0xFF00UL) |    /* move byte 2 to byte 1 */
			 (uint32_t)((*pData << 24U) & 0xFF000000UL); /* move byte 0 to byte 3 */
}

