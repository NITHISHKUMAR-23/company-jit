/*********************************************************************************
Copyright(c) 2019-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*****************************************************************************
 * UARTAutobaud.c
 *****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include <drivers/uart/adi_uart.h>
#include <services/pwr/adi_pwr.h>
#include <services/tmr/adi_tmr.h>
#include "adi_initialize.h"
#include "UARTAutobaud.h"

#if(defined AUTOTEST && defined CORE0)
#pragma GCC diagnostic ignored "-Wunused-variable"
#endif

/* Detected Baudrate */
volatile uint32_t nBaudRate = 0u;

/* ConfigSoftSwitches_EV_SOM() sets the software-controlled switches. */
#include "SoftConfig.h"

#if defined(__ADSPCORTEXA55__)
/* UART Buffer for Rx */
static uint8_t RxBuffer[BUFF_SIZE]__attribute__ ((section(".l2_uncached_data")));

/* Driver memory required for UART0 */
static uint8_t UARTMemory[ADI_UART_BIDIR_MEMORY_SIZE]__attribute__ ((section(".l2_uncached_data")));
#else
/* UART Buffer for Rx */
static uint8_t RxBuffer[BUFF_SIZE];

/* Driver memory required for UART0 */
static uint8_t UARTMemory[ADI_UART_BIDIR_MEMORY_SIZE];
#endif
/* UART0 Handle */
static ADI_UART_HANDLE hUART;

static void CheckResult(ADI_UART_RESULT Result) {
    if (Result != ADI_UART_SUCCESS) {
        REPORT_ERROR("Failed with error code 0x%08X\n", Result);
    }
}

int main()
{


    /* UART return code */
    ADI_UART_RESULT    eResult;

    ADI_PWR_RESULT  ePwrResult;

    /* Tx size */
    uint32_t nTxSize = 1u;

    /* Flag which indicates whether to stop the program */
    volatile bool bStopFlag = false;

    /**
     * Initialize managed drivers and/or services that have been added to
     * the project.
     * @return zero on success
     */
    adi_initComponents();
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif

    /* Set the Software controlled switches for UART */
    ConfigSoftSwitches_EV_SOM();

    /* Initialize the power services */
    ePwrResult = adi_pwr_Init(0u, CLKIN);
    if(ePwrResult != ADI_PWR_SUCCESS)
    {
        REPORT_ERROR("Power initialization failed 0x%08X\n", ePwrResult);
    }

    /* Open UART */
    eResult = adi_uart_Open(ADI_UART_DEVNUM, ADI_UART_DIR_BIDIRECTION, UARTMemory, ADI_UART_BIDIR_MEMORY_SIZE, &hUART);
    CheckResult(eResult);

    /* Configure UART for Autobaud mode */
    eResult = adi_uart_Autobaudmode(hUART);
    CheckResult(eResult);
	printf("Setup done\n");
	
#ifndef AUTOTEST
    printf("Setup the serial terminal and press character @ on Terminal to determine baudrate\n");

    /* Wait until auto baud detection is complete */
    while(nBaudRate == 0u)
    {
        eResult = adi_uart_GetBaudRate(hUART, &nBaudRate);
        CheckResult(eResult);
    }

    printf("Detected Baudrate is %d.\nPress any key on the terminal application and see that it is echoed.\nPress Enter key to exit.\n",(int)nBaudRate);

    /* UART processing loop */
    while(bStopFlag == false)
    {
    	int i;
        /* Read a character */
        eResult = adi_uart_CoreRead(hUART, &RxBuffer[0], 1u, ADI_OSAL_TIMEOUT_FOREVER);
        CheckResult(eResult);

        /* If return character is pressed, write back \n character along with \r */
        if((RxBuffer[0] & 0x7fu) == (uint8_t)'\r')
        {
            RxBuffer[1] = (uint8_t)'\n';

            /* Transmit two characters in this case */
            nTxSize     = 2u;

            /* Stop the program upon receiving carriage return */
            bStopFlag = true;
        }
        for(i=0; i<10000; i++);
        /* Write back the character. */
        eResult = adi_uart_CoreWrite(hUART, &RxBuffer[0], nTxSize);
        CheckResult(eResult);
    }

    eResult = adi_uart_Close(hUART);
    CheckResult(eResult);
#endif

    return 0;
}
