/*********************************************************************************

Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/

/*****************************************************************************
 * CANFD_StandardTsfr_Core1.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "CANFD_StandardTsfr_Core1.h"


/* Buffers and variables used by the Test */
uint8_t nCANFD1Driver_Memory[ADI_CANFD_MEMORY_SIZE];
uint32_t HandleMem1 = 0;


ADI_CANFD_MBHEADER Canfd1_MbHeader_FIFO[32];
ADI_CANFD_RXFIFOCONFIG Canfd1_RxFifoConfig;
uint32_t RxFifo_Filtertable[128];

/* User buffers to receive each of the 64 MBs */
uint32_t MBReceivedData[64][2];

/* Buffers to store reference MB data for comparison */
uint32_t MBSentData[64][2];


/* CAN MB header and configuration for each of the 32 MBs to be received
 * through standard MBs */
ADI_CANFD_MBHEADER Canfd1_MbHeader_MB[32];
ADI_CANFD_RXMBCONFIG Canfd1_MbRx[32];


/* Callback count */
volatile int ReceivedMBCOunt = 0, OtherCallbackCount = 0;


int main(int argc, char *argv[])
{
	ADI_CANFD_RESULT eResult = ADI_CANFD_SUCCESS;
	int count = 0,  Received_Id;

	adi_initComponents();

	/* Allocate CANFD driver handle */
	ADI_CANFD_HANDLE *phDevice1 = (ADI_CANFD_HANDLE *)&HandleMem1;

	/* Initialize the reference buffers for comparison */
	InitCanMBData();

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


	/* Initialize the RX FIFO configuration structure. Enable 32 filters to allow to receive 32 incoming MBs
	 * with ID 0 to 31 through the FIFO*/
	Canfd1_RxFifoConfig.pIdFilterTable = RxFifo_Filtertable;

	/*Define number of filter table entries. This shoud not exceed the number of filter available as per
	 * the setting in config file "ADI_CANFD1_CFG_NUM_FIFOFILTERS" */
	Canfd1_RxFifoConfig.numIdFilter = 32;
	Canfd1_RxFifoConfig.idFilterType = ADI_CANFD_FILTERTYPE_A;

	/* Assign priority to receive the messages in FIFO as compared to standard MBs */
	Canfd1_RxFifoConfig.priority = ADI_CANFD_FIFOPRIO_HI;

	/* Initialize the FIFO filter table to allow reception of different ID MBs */
	for(count = 0; count < Canfd1_RxFifoConfig.numIdFilter; count++)
	{
		/* Initialize the FIFO filter table with IDs 0 to 31*/
#ifdef STANDARDFRAME
		RxFifo_Filtertable[count] = (count << 1) << 18;
#else
		RxFifo_Filtertable[count] = (count) << 1 ;      // Bit 0 in ID filter is reserved
		RxFifo_Filtertable[count] |= 1 << 30;           // Set IDE bit
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


	/* Initialize FIFO Configuration */
	for(count = 0; count < 32; count++)
	{
		/* Initialize MB0 header */
		Canfd1_MbHeader_FIFO[count].pMBData = &MBReceivedData[count][0];
	}


	/* Since 32 filters are used, total MBs used in by FIFO and ID filter are 14. 6 by FIFO + 32/4 = 8
	 * by 32 FIFO filters */

	/* Initialize MB Configuration for receiving remaining incoming MBs with ID 32 to 64
	 *  through standard MBs MB32 to 64 configured with matching IDs */
	for(count = 0; count < 32; count++)
	{
		/* Define frame format and frame ID. ID is defined to start from the last ID assigned to FIFO ID filter */
#ifdef STANDARDFRAME
		Canfd1_MbRx[count].format = ADI_CANFD_FRAMEFORMAT_STD;
		Canfd1_MbRx[count].id = (count +32) << 18;
#else
		Canfd1_MbRx[count].format = ADI_CANFD_FRAMEFORMAT_EXT;
		Canfd1_MbRx[count].id = count +32;
#endif
		/* Define the frame type */
		Canfd1_MbRx[count].type = ADI_CANFD_FRAMETYPE_DATA;

		/* Link the user data buffer to each CANFD frame header */
		Canfd1_MbHeader_MB[count].pMBData = &MBReceivedData[count+32][0];

		/* Configure the CANFD MBs as RX to receive the message from corresponding MBs from CANFD0
		 * starting from MB32 thats why count +32 in the argument below */
		eResult = adi_canfd_ConfigureRxMb(*phDevice1, count + 32, &Canfd1_MbRx[count], true);
		if(eResult != ADI_CANFD_SUCCESS)
		{
			printf("Failed to  Configure RX MB%d. Error code returned %d \n", count, eResult);
			printf("Fail \n");
			return 0;
		}
	}



    /* Set the flag in RCU_MSG to allow Core0 to proceed indicating RX MBs are ready to receive */
	*pREG_RCU0_MSG |=  0x1000;


	/* Receive the matching MBs through Message buffers in non-blocking mode */
	for(count = 0; count < 32; count++)
	{
		eResult = adi_canfd_RecvMB_NonBlocking(*phDevice1, count+32, &Canfd1_MbHeader_MB[count]);
		if(eResult != ADI_CANFD_SUCCESS)
		{
			printf("Failed to Receive on MB%d. Error code returned %d \n", count+32, eResult);
			printf("Fail \n");
			return 0;
		}
	}


	/* Read the matching MBs one by one from FIFO in Blocking mode while other MBs are
	 * received in background through standard MBs in non-blocking mode*/
	for(count = 0; count < 32; count++)
	{
		eResult = adi_canfd_RecvFifo_Blocking(*phDevice1, &Canfd1_MbHeader_FIFO[count]);
		if(eResult != ADI_CANFD_SUCCESS)
		{
			printf("Failed to Receive data on RX FIFO for count % for CANFD1 driver. Error code returned %d \n", count, eResult);
			printf("Fail \n");
			return 0;
		}
		else
		{
			if(Canfd1_MbHeader_FIFO[count].controlCode_u.controlCode_st.frameFormat == 1)
			{
				/* Extended frame */
				Received_Id = Canfd1_MbHeader_FIFO[count].id_prio_u.id_prio_st.id;
			}
			else
			{
				/* Standard frame. Shift by 18 bits frame */
				Received_Id = Canfd1_MbHeader_FIFO[count].id_prio_u.id_prio_st.id >> 18;
			}

			printf("Successfully received MB with RX FIFO from ID%d. Filter hit %d \n", Received_Id, Canfd1_MbHeader_FIFO[count].nFifoHitIndicator);
		}
	}


	/* Wait till all MBs are Received */
	while(ReceivedMBCOunt  < 32);

	/* Check if any other callback other than TX MB has occured */
	if(OtherCallbackCount != 0)
	{
		printf("\n Notice : %d Other callback have occurred!!. You may want to check the reason for that. \n", OtherCallbackCount);

	}


	/* Close the CANFD Driver */
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
	/* compare the data received in all MBs */
	for(count = 0; count < 64; count++)
	{
		if((MBReceivedData[count][0] != MBSentData[count][0]) ||(MBReceivedData[count][1] != MBSentData[count][1]))

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
    	printf("Successfully Received MB%d through standard Message Buffer in non-blocking mode. \n", (uint32_t)pArg);
    }
    else
    {
    	/* Count other callbacks other than TX MB callback */
    	OtherCallbackCount++;
    }
}

