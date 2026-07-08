/*********************************************************************************
Copyright(c) 2021-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*****************************************************************************
 * TWI_Ext_Loopback.c
 *
 * Connections: Connect TWI2_SCL - Pin 20(P3) to TWI1_SCL - Pin 18(P3).
 * 				Connect TWI2_SDA - Pin 21(P3) to TWI1_SDA - Pin 19(P3).
 *
 * Description: This example demonstrates an external loopback between TWI2 and TWI1.
 * 				At first, TWI2 is configured as Master Tx and TWI1 as Slave Rx.
 * 				To change the mode of operation of TWIs, define the "TWI_MODE_CHANGE" in
 * 				"TWI_Ext_Loopback.h" . This will configure the TWI1 as Master Tx and
 * 				TWI2 as slave Rx.
 * 				For TWI2 and TWI1 pin muxing is done.
 *
 *  Note        Please connect the jumper wires as mentioned above on EV-SOMCRR-BRKOUT
 *  			probing adapter board.
 *
 *****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include <services/int/adi_int.h>
#include <drivers/twi/adi_twi.h>
#include "math.h"
#include "TWI_Ext_Loopback.h"

#if(defined AUTOTEST && defined CORE0)
#pragma GCC diagnostic ignored "-Wunused-function"
#endif

static uint8_t SrcDataBuf[BUFFER_SIZE];

static uint8_t DestDataBuf[BUFFER_SIZE];

static uint8_t SrcDataBuf1[BUFFER_SIZE1];

static uint8_t DestDataBuf1[BUFFER_SIZE1];

/* Memory required for TWI */
uint8_t Twi2Memory[ADI_TWI_MEMORY_SIZE];
uint8_t Twi1Memory[ADI_TWI_MEMORY_SIZE];

/* TWI driver handle */
static ADI_TWI_HANDLE hTwi2Dev;
static ADI_TWI_HANDLE hTwi1Dev;

volatile uint8_t CallbackCount = 0;

/* Prepares data buffers for TWI */
static void PrepareDataBuffers (void);

/* Prepares data buffers for TWI */
static void PrepareDataBuffersAgain (void);

/* Verifies TWI transfers */
static int VerifyDataCopy (uint8_t TwiNum1,uint8_t TwiNum2);

static void TWICallback(
    void        *pAppHandle,
    uint32_t     nEvent,
    void        *pArg
)
{
    /* CASEOF (event type) */
    switch (nEvent)
    {
        /* CASE (buffer processed) */
        case ADI_TWI_EVENT_MSTR_XMT_PROCESSED:
        	 CallbackCount += 1;
            break;
        case ADI_TWI_EVENT_SLV_RCV_PROCESSED:
           	 CallbackCount += 1;
            break;
        default:
        	break;
    }
    /* return */
}


/** 
 * If you want to use command program arguments, then place them in the following string. 
 */
char __argv_string[] = "";

int main(int argc, char *argv[])
{
    /* driver API result code */
    ADI_TWI_RESULT result;

    adi_initComponents(); /* auto-generated code */
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif

    /* open the TWI driver in master mode */
    result = adi_twi_Open(TWIDEVNUM2, ADI_TWI_MASTER, &Twi2Memory[0],
                ADI_TWI_MEMORY_SIZE, &hTwi2Dev);
    if (result != ADI_TWI_SUCCESS)
    {
        REPORT_ERROR("Failed to open TWI Device 0x%08X\n", result);
        return FAILED;
    }
    /* open the TWI driver in slave mode */
    result = adi_twi_Open(TWIDEVNUM1, ADI_TWI_SLAVE, &Twi1Memory[0],
                ADI_TWI_MEMORY_SIZE, &hTwi1Dev);
    if (result != ADI_TWI_SUCCESS)
    {
        REPORT_ERROR("Failed to open TWI Device 0x%08X\n", result);
        return FAILED;
    }

    /* register the callback function */
    result = adi_twi_RegisterCallback(hTwi2Dev, TWICallback, NULL);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to register TWI callback 0x%08X\n", result);
		return FAILED;
	}

    /* register the callback function */
    result = adi_twi_RegisterCallback(hTwi1Dev, TWICallback, NULL);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to register TWI callback 0x%08X\n", result);
		return FAILED;
	}

    /* Prepare data buffers */
    PrepareDataBuffers();

    /* submit the data to the TWI device */
    result = adi_twi_SubmitTxBuffer(hTwi2Dev, &SrcDataBuf, BUFFER_SIZE, false);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to submit TWI Tx Buffer 0x%08X\n", result);
		return FAILED;
	}

    result = adi_twi_SubmitRxBuffer(hTwi1Dev, &DestDataBuf,BUFFER_SIZE ,false);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to submit TWI Rx Buffer 0x%08X\n", result);
		return FAILED;
	}

    /* enable the TWI transfer */
    result = adi_twi_Enable(hTwi1Dev);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable TWI1 0x%08X\n", result);
		return FAILED;
	}

    /* enable the TWI transfer */
    result = adi_twi_Enable(hTwi2Dev);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable TWI0 0x%08X\n", result);
		return FAILED;
	}

#ifndef AUTOTEST
	while(1)
	{
		if(CallbackCount == (2))
		{
			VerifyDataCopy(2,1);
			break;
		}
	}
#endif

#ifdef TWI_MODE_CHANGE
	CallbackCount = 0;

    /* Prepare data buffers again */
	PrepareDataBuffersAgain();

	/* Disable the TWI device */
    result = adi_twi_Disable(hTwi1Dev);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to Disable TWI1 0x%08X\n", result);
		return FAILED;
	}

    /* Disable the TWI Device */
    result = adi_twi_Disable(hTwi2Dev);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to Disable TWI2 0x%08X\n", result);
		return FAILED;
	}

    /* Unregister the callback function */
    result = adi_twi_RegisterCallback(hTwi2Dev, NULL, NULL);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to register TWI callback 0x%08X\n", result);
		return FAILED;
	}

    /* Unregister the callback function */
    result = adi_twi_RegisterCallback(hTwi1Dev, NULL, NULL);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to register TWI callback 0x%08X\n", result);
		return FAILED;
	}

	/* Set the new mode for TWI device */
    result = adi_twi_SetMode(hTwi2Dev,ADI_TWI_SLAVE);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to Disable TWI2 0x%08X\n", result);
		return FAILED;
	}

	/* Set the new mode for TWI device */
	result = adi_twi_SetMode(hTwi1Dev,ADI_TWI_MASTER);
	if (result != ADI_TWI_SUCCESS)
	{
	REPORT_ERROR("Failed to Disable TWI1 0x%08X\n", result);
	return FAILED;
	}

	/* Set the prescalar for TWI device */
	result = adi_twi_SetPrescale(hTwi1Dev, PRESCALEVALUE);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to set TWI Prescale 0x%08X\n", result);
		return FAILED;
	}

	/* Set the prescalar for TWI device */
	result = adi_twi_SetPrescale(hTwi2Dev, PRESCALEVALUE);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to set TWI Prescale 0x%08X\n", result);
		return FAILED;
	}

	/* Set the bit rate for TWI device */
	result = adi_twi_SetBitRate(hTwi1Dev, BITRATE);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to set TWI Bitrate 0x%08X\n", result);
		return FAILED;
	}

	/* Set the duty cycle for TWI device */
	result = adi_twi_SetDutyCycle(hTwi1Dev, DUTYCYCLE);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to set TWI Duty cycle 0x%08X\n", result);
		return FAILED;
	}

    /* submit the data to the TWI device */
    result = adi_twi_SubmitTxBuffer(hTwi1Dev, &SrcDataBuf1, BUFFER_SIZE1, false);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to submit TWI Tx Buffer 0x%08X\n", result);
		return FAILED;
	}
	/* submit the data to the TWI device */
    result = adi_twi_SubmitRxBuffer(hTwi2Dev, &DestDataBuf1,BUFFER_SIZE1 ,false);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to submit TWI Rx Buffer 0x%08X\n", result);
		return FAILED;
	}

    /* Register the callback */
    result = adi_twi_RegisterCallback(hTwi2Dev, TWICallback, NULL);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to register TWI callback 0x%08X\n", result);
		return FAILED;
	}

    /* Register the callback */
    result = adi_twi_RegisterCallback(hTwi1Dev, TWICallback, NULL);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to register TWI callback 0x%08X\n", result);
		return FAILED;
	}

    /* enable the TWI transfer */
    result = adi_twi_Enable(hTwi2Dev);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable TWI2 0x%08X\n", result);
		return FAILED;
	}

    /* enable the TWI transfer */
    result = adi_twi_Enable(hTwi1Dev);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable TWI1 0x%08X\n", result);
		return FAILED;
	}

	while(1)
	{
		if(CallbackCount == (2))
		{
			VerifyDataCopy(1,2);
			break;
		}
	}
#endif


    /* close the TWI device */
    result = adi_twi_Close(hTwi2Dev);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to close TWI2 0x%08X\n", result);
		return FAILED;
	}

	 /* close the TWI device */
    result = adi_twi_Close(hTwi1Dev);
	if (result != ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("Failed to close TWI1 0x%08X\n", result);
		return FAILED;
	}


	if (result == ADI_TWI_SUCCESS) {
		DEBUG_INFORMATION("All done\n");
	} else {
		DEBUG_INFORMATION("Example failed.\n");
	}

	return 0;
}

/*
 * Prepares data buffers for Memory copy.
 *
 * Parameters
 *  None
 *
 * Returns
 *  None
 *
 */
static void PrepareDataBuffers (void)
{
    /* Loop variable */
    uint32_t loopvar;

    /* Generate Source data, Clear destination buffer */
    for (loopvar = 0u; loopvar < BUFFER_SIZE; loopvar++)
    {
        SrcDataBuf[loopvar]   = (uint8_t)loopvar+1;
        DestDataBuf[loopvar]  = 0u;
    }
}

static void PrepareDataBuffersAgain (void)
{
    /* Loop variable */
    uint32_t loopvar1;

    /* Generate Source data, Clear destination buffer */
    for (loopvar1 = 0u; loopvar1 < BUFFER_SIZE1; loopvar1++)
    {
        SrcDataBuf1[loopvar1]   = (uint8_t)loopvar1;
        DestDataBuf1[loopvar1]  = 0u;
    }
}

/*
 * Verifies memory by comparing destination data with source.
 *
 * Parameters
 *  None
 *
 * Returns
 *  - SUCCESS   - Data verification success
 *  - FAILURE   - Data verification failed
 *
 */
static int VerifyDataCopy (uint8_t TwiNum1,uint8_t TwiNum2)
{
    /* Loop variable */
    uint32_t  loopvar;

    /* Compare the destination data with source */
    for (loopvar = 0; loopvar < BUFFER_SIZE; loopvar++)
    {
        /* IF (Destination data not same as source) */
        if (DestDataBuf[loopvar] != SrcDataBuf[loopvar])
        {
        	DEBUG_INFORMATION("TWI Transfer failed between TWI%d Master and TWI%d Slave \n",TwiNum1,TwiNum2 );
            /* Return error */
            return (FAILED);
        }
    }

    DEBUG_INFORMATION("TWI Transfer Passed between TWI%d Master and TWI%d Slave\n",TwiNum1,TwiNum2 );

    /* Return success */
    return (SUCCESS);
}

