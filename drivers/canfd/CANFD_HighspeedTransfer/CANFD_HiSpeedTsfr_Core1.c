/*********************************************************************************

Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/

/*****************************************************************************
 * CANFD_HiSpeedTsfr_Core1.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "CANFD_HiSpeedTsfr_Core1.h"

/* Buffers and variables used by the Test */
uint8_t nCANFD1Driver_Memory[ADI_CANFD_MEMORY_SIZE];
ADI_CANFD_HANDLE HandleMem1 = 0;
uint8_t MaxMBs;
uint32_t iteration = 0;

/* CAN MB header for each of the 64 MBs to be received */
ADI_CANFD_MBHEADER Canfd1_MbHeader[64];
ADI_CANFD_RXMBCONFIG Canfd1_MbRx[64];
uint32_t MBReceivedData[64][16];

/* Buffers to store reference MB data for comparison */
uint32_t MBSentData[64][16];

/* Structure to hold Normal CAN timing */
ADI_CANFD_TIMINGCONFIG CANTiming = { true,        /*!< Whether to use extended range or not. Also should be
												       set to true when FD mode is used. */
									 0,           /*!< Clock Pre-scaler Division Factor. */
									 1,           /*!< Re-sync Jump Width. */
									 16,          /*!< Phase Segment 1. */
									 15,          /*!< Phase Segment 2. */
									 45           /*!< Propagation Segment. */
									};

/* Structure to hold Bit rate switching CAN timing */
ADI_CANFD_TIMINGCONFIG CANFastTiming = { true,        /*!< Whether to use extended range or not. Also should be
												       set to true when FD mode is used. */
										 0,           /*!< Clock Pre-scaler Division Factor. */
										 1,           /*!< Re-sync Jump Width. */
										 2,           /*!< Phase Segment 1. */
										 1,           /*!< Phase Segment 2. */
										 3            /*!< Propagation Segment. */
										};


int main(int argc, char *argv[])
{
	ADI_CANFD_RESULT eResult = ADI_CANFD_SUCCESS;
	int count = 0;

	adi_initComponents();

	/* Allocate CANFD driver handle */
	ADI_CANFD_HANDLE *phDevice1 = &HandleMem1;

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

	/* Configure Global Mask for CAN1 */
	eResult = adi_canfd_SetRxGlobalMask(*phDevice1, 0xFFFFFFFF, 0xFFFFFFFF);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to set Global mask for CANFD1 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}


	/* Configure Normal CAN timings for 1 Mbps */
	eResult = adi_canfd_SetCanTiming(*phDevice1, &CANTiming);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to Configure CAN0 normal timings correctly. Error code returned %d \n", count, eResult);
		printf("Fail \n");
		return 0;
	}

	/* Configure Bit rate switching CAN timings for 8.0 Mbps */
	eResult = adi_canfd_SetCanfastTiming(*phDevice1, &CANFastTiming);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to Configure CAN0 Fast timings correctly. Error code returned %d \n", count, eResult);
		printf("Fail \n");
		return 0;
	}


#ifdef ISOCOMPLIANT_FD
	/* Enable FD mode for CAN0 in ISO compliant mode */
	eResult =  adi_canfd_EnableFdMode(*phDevice1, true, true);
#else
	/* Enable FD mode for CAN0 in non ISO compliant mode */
	eResult =  adi_canfd_EnableFdMode(*phDevice1, true, false);
#endif
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to Enable the FD mode for CANFD1 correctly. Error code returned %d \n", count, eResult);
		printf("Fail \n");
		return 0;
	}


	/* Get the number of MB available */
	adi_canfd_GetMaxMessageBuffers(*phDevice1, &MaxMBs);

	/* Initialize MB Configuration */
	for(count = 0; count < MaxMBs; count++)
	{
		/* Define frame format and frame ID */
#ifdef STANDARDFRAME
		Canfd1_MbRx[count].format = ADI_CANFD_FRAMEFORMAT_STD;
		Canfd1_MbRx[count].id = count << 18;
#else
		Canfd1_MbRx[count].format = ADI_CANFD_FRAMEFORMAT_EXT;
		Canfd1_MbRx[count].id = count ;
#endif
		Canfd1_MbRx[count].type = ADI_CANFD_FRAMETYPE_DATA;

		/* Initialize MB0 header */
		Canfd1_MbHeader[count].pMBData = &MBReceivedData[count][0];

		/* Configure the CANFD MBs as RX to receive the message from corresponding MBs from CANFD0 */
		eResult = adi_canfd_ConfigureRxMb(*phDevice1, count, &Canfd1_MbRx[count], true);
		if(eResult != ADI_CANFD_SUCCESS)
		{
			printf("Failed to  Configure RX MB%d. Error code returned %d \n", count, eResult);
			printf("Fail \n");
			return 0;
		}
	}


    /* Set the flag in RCU_MSG to allow Core0 to proceed indicating RX MBs are ready to receive */
	*pREG_RCU0_MSG |=  0x1000;


	int iteration = 0;

	while(iteration < NUM_ITERATIONS)
	{
		for(count = 0; count < MaxMBs; count++)
		{
			eResult = adi_canfd_RecvMB_Blocking(*phDevice1, count, &Canfd1_MbHeader[count]);
			if(eResult != ADI_CANFD_SUCCESS)
			{
				printf("Failed to Receive on MB%d. Error code returned %d \n", count, eResult);
				printf("Fail \n");
				return 0;
			}
			else
			{
				printf("Successful to receive Rx MB%d. \n", count);
			}
		}

		/* Compare the received data */
		eResult = VerifyData();
		if(eResult != 0)
		{
			printf("\n\n Data comparison failed for Iteration %d \n\n", iteration);
		}
		else
		{
			printf("\n\n Successfully received all %d bytes from %d MBs for Iteration %d \n\n", nDlcEncoding[DLC], MaxMBs, iteration);
		}

		/* Do not clear for last iteration */
		if(iteration < NUM_ITERATIONS-1)
		{
			/* Clear the buffers */
			ClearBuffers();
		}

		iteration++;
	}


	/* Close the CAN Driver */
    if(adi_canfd_Close(*phDevice1) != ADI_CANFD_SUCCESS)
	{
		printf("Failed to Close CANFD1 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}


	if(eResult == 0)
	{
		printf("\n Successfully Received data from all MBs multiple times at high speed \n");
		printf("All Done \n");
	}
	else
	{
		printf("\n Test failed \n");
	}

	return 0;
}



/* Function to initialize CANFD user data for reference comparison */
ADI_CANFD_RESULT VerifyData(void)
{
	int count = 0, count2 = 0;
	/* compare the data received in all MBs */
	for(count = 0; count < MaxMBs; count++)
	{
		for(count2 = 0; count2 < nDlcEncoding[DLC]/4; count2++)
		{
			if((MBReceivedData[count][count2] != MBSentData[count][count2]) )
			{
				printf("\n Data comparison for MB%d  for word %d failed. \n", count, count2);
				return ADI_CANFD_FAILED;
			}
		}
	}

	return ADI_CANFD_SUCCESS;
}


void ClearBuffers(void)
{
	int count = 0 , count2;

	for(; count < 64; count++)
	{
		for(count2 = 0; count2 < 16; count2++)
		{
			MBReceivedData[count][count2] = 0;
		}
	}
}

void InitCanMBData(void)
{
	 /* Initialize the data with known pattern */
	int count = 0, count2 = 0, shift = 0;
	int Data, FirstData = 0x46930499;

	for(; count < 64; count++, shift++)
	{
		if(shift == 32)
		{
			shift = 0;
			FirstData = 0x26052712;
		}

		for(count2 = 0; count2 < 16; count2++)
		{
			Data = ((FirstData >> shift) | ((FirstData) << shift)) + count2;
			MBSentData[count][count2] = Data;
		}
	}
}



/* Callback function for CANFD1 */
static void CANFD1_CallBack(void *AppHandle, uint32_t Event, void *pArg)
{
    if(Event & (1 << ADI_CANFD_BIT0ERR_F))
    {
    	printf("CANFD0 Fast Bit 0 error  has occurred. \n");
    }

    if(Event & (1 << ADI_CANFD_BIT1ERR_F))
    {
    	printf("CANFD0 Fast Bit 1 error has occurred. \n");
    }
}


