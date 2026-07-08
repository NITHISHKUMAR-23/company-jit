/*********************************************************************************
Copyright(c) 2021-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*****************************************************************************
 * CANFD_HiSpeedTsfr_Core0.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "CANFD_HiSpeedTsfr_Core0.h"


/* Buffers and variables used by the Test */
uint8_t nCANFD0Driver_Memory[ADI_CANFD_MEMORY_SIZE];
ADI_CANFD_HANDLE HandleMem0 = 0;
uint8_t MaxMBs;
uint32_t iteration = 0;

/* CAN MB header for each of the 64 MBs to be transmitted */
ADI_CANFD_MBHEADER Canfd0_MbHeader[64];

/* CAN MB data to be transmitted for each of the 64 MBs */
uint32_t MBData[64][16];


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




int main()
{
	int count = 0;
	ADI_CANFD_RESULT eResult = ADI_CANFD_SUCCESS;

	adi_initComponents();
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif

	/* Configure the clocks to source CANFD with 80 MHz clock
	 * This value is selected to get the exact 8mbps speed during bit rate switching*/
	adi_pwr_cfg0_init();

	/* Configure pin mux for CANFD0 and CANFD1*/
	Init_pinmux();

	/* Release other cores form reset */
	adi_core_enable(ADI_CORE_SHARC0);
	adi_core_enable(ADI_CORE_SHARC1);

	/* Initialize CANFD MB data to be transmitted */
	InitCanMBData();

	/* Enable CAN transceivers */
#if defined(__ADSPSC598W__)
    ConfigSoftSwitches_SC598_SOM();
#endif
	ConfigSoftSwitches_EVAL_EZKIT_SOM();

	/* Allocate CANFD driver handle */
	ADI_CANFD_HANDLE *phDevice0 = &HandleMem0;


	/* Open the CANFD0 device */
	eResult = adi_canfd_Open( 0U,
			                  (uint8_t *)nCANFD0Driver_Memory,
							  ADI_CANFD_MEMORY_SIZE,
							  phDevice0);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to Open CANFD0 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}


	/* Register Callback for CANFD0 */
	eResult = adi_canfd_RegisterCallback (*phDevice0, CANFD0_CallBack, NULL);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to register callback for CANFD0 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Configure Global Mask for CAN0 */
	eResult = adi_canfd_SetRxGlobalMask(*phDevice0, 0xFFFFFFFF, 0xFFFFFFFF);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to set Global mask for CANFD0 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}


	/* Configure Normal CAN timings for 1 Mbps */
	eResult = adi_canfd_SetCanTiming(*phDevice0, &CANTiming);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to Configure CAN0 normal timings correctly. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Configure Bit rate switching CAN timings for 8.0 Mbps */
	eResult = adi_canfd_SetCanfastTiming(*phDevice0, &CANFastTiming);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to Configure CAN0 Fast timings correctly. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

#ifdef ISOCOMPLIANT_FD
	/* Enable FD mode for CAN0 in ISO compliant mode */
	eResult =  adi_canfd_EnableFdMode(*phDevice0, true, true);
#else
	/* Enable FD mode for CAN0 in non ISO compliant mode */
	eResult =  adi_canfd_EnableFdMode(*phDevice0, true, false);
#endif
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to Enable the FD mode for CANFD0 correctly. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}


	/* Wait here till the Core 1 has run and initialized the CANFD1 Rx FIFO */
	while(!(*pREG_RCU0_MSG & 0x1000));


	/* Get the number of MB available */
	adi_canfd_GetMaxMessageBuffers(*phDevice0, &MaxMBs);

	printf("\n Number of Message buffers available in CANFD0/1 as per bank configuration option defined by macros 'ADI_CANFD0_CFG_BLOCK0_MBSIZE/ADI_CANFD1_CFG_BLOCK0_MBSIZE' and 'ADI_CANFD0_CFG_BLOCK1_MBSIZE/ADI_CANFD1_CFG_BLOCK1_MBSIZE' %d  \n\n", MaxMBs);


	/* Configure TX MBs in CANFD0 */
	for(count = 0; count < MaxMBs; count++)
	{
		eResult = adi_canfd_ConfigureTxMb(*phDevice0, count, true);
		if(eResult != ADI_CANFD_SUCCESS)
		{
			printf("Failed to Configure Tx MB%d. Error code returned %d \n", count, eResult);
			printf("Fail \n");
			return 0;
		}
	}



	/* Initialize Message buffer headers for all the MBs to be transmitted */
	for(count =0; count < MaxMBs; count++)
	{
		/* Define frame format and frame ID */
#ifdef STANDARDFRAME
		Canfd0_MbHeader[count].controlCode_u.controlCode_st.frameFormat = ADI_CANFD_FRAMEFORMAT_STD;
		Canfd0_MbHeader[count].id_prio_u.id_prio = count << 18;
#else
		Canfd0_MbHeader[count].controlCode_u.controlCode_st.frameFormat = ADI_CANFD_FRAMEFORMAT_EXT;
		Canfd0_MbHeader[count].id_prio_u.id_prio = count;
#endif
		Canfd0_MbHeader[count].controlCode_u.controlCode_st.frameType = ADI_CANFD_FRAMETYPE_DATA;

		/* For FD frames brs and edl needs to be set to 1 to allow bit rate switching and payload greater than 8 bytes*/
		Canfd0_MbHeader[count].controlCode_u.controlCode_st.brs = 1;
		Canfd0_MbHeader[count].controlCode_u.controlCode_st.edl = 1;
		Canfd0_MbHeader[count].controlCode_u.controlCode_st.length = DLC;
		Canfd0_MbHeader[count].pMBData = &MBData[count][0];
	}


	/* Keep on continuously sending the MBs */
	while(iteration++ < NUM_ITERATIONS)
	{
		/* Send the MBs out one by one */
		for(count = 0; count < MaxMBs; count++)
		{
			eResult = adi_canfd_SendMB_Blocking(*phDevice0, count, &Canfd0_MbHeader[count]);
			if(eResult != ADI_CANFD_SUCCESS)
			{
				printf("Failed to Send Tx MB%d. Error code returned %d \n",count, eResult);
				printf("Fail \n");
				return 0;
			}
			else
			{
				printf("Successful to Send Tx MB%d. \n", count);
			}
		}

		/* Provide some Delay to Allow the slave side to read all the MBs before
		 * getting ready to receive next set of MBs */
		Delay(100000000);
	}


	/* Close the CAN Driver */
	eResult = adi_canfd_Close(*phDevice0);

	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to Close CANFD0 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	return 0;
}



/* Function to initialize CANFD user data
 * Mixed pattern data is used to initialize the buffers */
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
			MBData[count][count2] = Data;
		}
	}
}



/* Configures the Pin mux for CANFD0 and CANFD1 */
void Init_pinmux(void)
{
	/* CANFD 0 mux */
	*pREG_PORTF_MUX = 0x0;
	*pREG_PORTF_FER_SET = BITM_PORT_FER_PX15;

	*pREG_PORTG_MUX = 0x0;
	*pREG_PORTG_FER_SET = BITM_PORT_FER_PX0;

	/* CANFD 1 mux */
	*pREG_PORTG_MUX = 0x0;
	*pREG_PORTG_FER_SET = BITM_PORT_FER_PX1 | BITM_PORT_FER_PX2 ;

	/* Configure the pin mux for TWI2 */
	*pREG_PORTA_MUX = 0x0;
	*pREG_PORTA_FER_SET = BITM_PORT_FER_PX14 | BITM_PORT_FER_PX15;

}






/* Callback function for CANFD0 */
static void CANFD0_CallBack(void *AppHandle, uint32_t Event, void *pArg)
{
    if(Event & (1 << ADI_CANFD_BIT0ERR_F))
    {
    	printf("CANFD0 Fast Bit 0 error  has occurred. \n");
    }

    if(Event & (1 << ADI_CANFD_BIT1ERR_F))
    {
    	printf("CANFD0 Fast Bit 1 error has occurred. \n");
    }

    if(Event & (1 << ADI_CANFD_BIT0ERR))
    {
    	printf("CANFD0 Normal Bit 0 error  has occurred. \n");
    }

    if(Event & (1 << ADI_CANFD_BIT1ERR))
    {
    	printf("CANFD0 Normal Bit 1 error has occurred. \n");
    }

}

void Delay(int delay)
{
	int i;

	for(i = 0; i< delay; i++)
	{
		asm("nop;");
	}
}

