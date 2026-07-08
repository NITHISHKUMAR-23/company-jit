/*********************************************************************************
Copyright(c) 2021-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*****************************************************************************
 * CANFD_Rxfifo_dma_Core0.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "CANFD_Rxfifo_dma_Core0.h"


/* Buffers and variables used by the Test */
uint8_t nCANFD0Driver_Memory[ADI_CANFD_MEMORY_SIZE];
uint32_t HandleMem0 = 0;


/* CAN MB header for each of the 64 MBs to be transmitted */
ADI_CANFD_MBHEADER Canfd0_MbHeader[64];

/* CAN MB data to be transmitted for each of the 64 MBs */
uint32_t MBData[64][2];



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
	
	/* Configure the clocks to source CANFD with 100 MHz clock */
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
	ADI_CANFD_HANDLE *phDevice0 = (ADI_CANFD_HANDLE)&HandleMem0;

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

	/* Configure Global Mask for CANFD0 */
	eResult = adi_canfd_SetRxGlobalMask(*phDevice0, 0xFFFFFFFF, 0xFFFFFFFF);
	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to set Global mask for CANFD0 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	/* Wait here till the Core 1 has run and initialized the CANFD1 Rx FIFO */
	while(!(*pREG_RCU0_MSG & 0x1000));


	/* Configure TX MBs 0-63 in CANFD0 */
	for(count = 0; count < 64; count++)
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
	for(count =0; count < 64; count++)
	{
		/* Define frame format and frame ID */
#ifdef STANDARDFRAME
		Canfd0_MbHeader[count].controlCode_u.controlCode_st.frameFormat = ADI_CANFD_FRAMEFORMAT_STD;
		Canfd0_MbHeader[count].id_prio_u.id_prio = count << 18;
#else
		Canfd0_MbHeader[count].controlCode_u.controlCode_st.frameFormat = ADI_CANFD_FRAMEFORMAT_EXT;
		Canfd0_MbHeader[count].id_prio_u.id_prio = count;
#endif
		/* Define the frame type */
		Canfd0_MbHeader[count].controlCode_u.controlCode_st.frameType = ADI_CANFD_FRAMETYPE_DATA;

		/* Define the frame data length. Set to 8 bytes for this example */
		Canfd0_MbHeader[count].controlCode_u.controlCode_st.length = 8;

		/* Link the user data buffer to each CANFD frame header */
		Canfd0_MbHeader[count].pMBData = &MBData[count][0];
	}


	/* Send the MBs 0-63 out one by one in blocking mode */
	for(count = 0; count < 64; count++)
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

		/* Add some delay before sending next frame */
		Delay(80000000);

	}


	/* Close the CANFD Driver */
	eResult = adi_canfd_Close(*phDevice0);

	if(eResult != ADI_CANFD_SUCCESS)
	{
		printf("Failed to Close CANFD0 driver. Error code returned %d \n", eResult);
		printf("Fail \n");
		return 0;
	}

	return 0;
}




/* Function to initialize CANFD user data */
void InitCanMBData(void)
{
	 /* Initialize the data with known pattern */
	int count = 0 ;

	for(; count < 64; count++)
	{
		MBData[count][0] = count+20;
		MBData[count][1] = count+120;
	}
}


/* Configures the Pin mux for CANFD0/1 */
void Init_pinmux(void)
{
	/* CANFD0 Pin-mux */
	*pREG_PORTF_MUX = 0x0;
	*pREG_PORTF_FER_SET = BITM_PORT_FER_PX15;

	*pREG_PORTG_MUX = 0x0;
	*pREG_PORTG_FER_SET = BITM_PORT_FER_PX0;

	/* CANFD1 Pin-mux */
	*pREG_PORTG_MUX = 0x0;
	*pREG_PORTG_FER_SET = BITM_PORT_FER_PX1 | BITM_PORT_FER_PX2 ;

	/* Configure the pin mux for TWI2 */
	*pREG_PORTA_MUX = 0x0;
	*pREG_PORTA_FER_SET = BITM_PORT_FER_PX14 | BITM_PORT_FER_PX15;
}



/* Callback function for CANFD0 */
static void CANFD0_CallBack(void *AppHandle, uint32_t Event, void *pArg)
{
	/* Empty call back */

}


void Delay(int delay)
{
	volatile int i;

	for(i = 0; i< delay; i++)
	{
		asm("nop;");
	}
}


