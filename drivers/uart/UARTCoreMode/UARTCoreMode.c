/*********************************************************************************
Copyright(c) 2019-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*****************************************************************************
 * UARTCoreMode.c
 *****************************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <adi_osal.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include <drivers/uart/adi_uart.h>
#include "adi_initialize.h"
#include "UARTCoreMode.h"

bool TestResult = true;

/* UART Buffers for Tx and Rx */
static uint8_t TxBuffer[BUFF_SIZE];
static uint8_t RxBuffer[BUFF_SIZE];

/* Driver memory required for UART */
static uint8_t UARTMemory0[ADI_UART_BIDIR_MEMORY_SIZE];
static uint8_t UARTMemory1[ADI_UART_BIDIR_MEMORY_SIZE];

/* UART Handles */
static ADI_UART_HANDLE hUARTDevA;
static ADI_UART_HANDLE hUARTDevB;

/* Configures Tx and Rx buffers */
static void PrepareDataBuffers(void);

/* Verifies received data */
static int VerifyDataCopy (uint8_t DevNoA,uint8_t DevNoB);

static void CheckResult(ADI_UART_RESULT Result) {
    if (Result != ADI_UART_SUCCESS) {
        REPORT_ERROR("Failed with error code 0x%08X\n", Result);
    }
}

int main()
{
    /* UART return code */
    ADI_UART_RESULT    eResult;

    /* By default, SCLK0_0 is 93.75MHz and if a preload code is added SCLK0_0 is 125 MHz
     * Baud rate = (SCLK0_0 / (pow(16,(1-Edbo))*Divisor)) */

    /* Set prescaler */
    bool Edbo = 1u;

    /* Divisor value set such that Baud rate is set to 9600 for SCLK0_0 = 125 MHz*/
    uint32_t Divisor = 13020;

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

    /* Open UART */
    eResult = adi_uart_Open(UART_DEVA, ADI_UART_DIR_BIDIRECTION, UARTMemory0, ADI_UART_BIDIR_MEMORY_SIZE, &hUARTDevA);
    CheckResult(eResult);

    /* Configure UART baud rate */
    eResult = adi_uart_ConfigBaudRate(hUARTDevA, Edbo, Divisor);
    CheckResult(eResult);

    /* Open UART */
    eResult = adi_uart_Open(UART_DEVB, ADI_UART_DIR_BIDIRECTION, UARTMemory1, ADI_UART_BIDIR_MEMORY_SIZE, &hUARTDevB);
    CheckResult(eResult);

    /* Configure UART baud rate */
    eResult = adi_uart_ConfigBaudRate(hUARTDevB, Edbo, Divisor);
    CheckResult(eResult);

    /* Configure Tx and Rx buffers */
    PrepareDataBuffers();

    printf("\nUART(%d) is Configured as Tx\n",UART_DEVA);
    printf("UART(%d) is Configured as Rx\n",UART_DEVB);

    /* Write Tx buffer to UART */
    eResult = adi_uart_CoreWrite(hUARTDevA, &TxBuffer, BUFF_SIZE);
    CheckResult(eResult);

    /* Read UART data to Rx buffer */
    eResult = adi_uart_CoreRead(hUARTDevB, &RxBuffer, BUFF_SIZE ,ADI_OSAL_TIMEOUT_FOREVER);
    CheckResult(eResult);

    /* Verify received data */
    VerifyDataCopy(UART_DEVA,UART_DEVB);

    /* Close the UART device */
    eResult = adi_uart_Close(hUARTDevA);
    CheckResult(eResult);

    eResult = adi_uart_Close(hUARTDevB);
    CheckResult(eResult);

    if(TestResult == true)
    {
        printf("All Done\n");
    }

    return 0;
}

/*
 * Prepares data buffers
 *
 * Parameters
 *  None
 *
 * Returns
 *  None
 *
 */
static void PrepareDataBuffers(void)
{
    /* Loop variable */
    uint32_t loopvar;

    /* Generate some random Source buffer and clear destination buffer */
    for (loopvar = 0u; loopvar < BUFF_SIZE; loopvar++)
    {
        TxBuffer[loopvar]  = (uint8_t)rand();
        RxBuffer[loopvar]  = 0u;
    }
}

/*
 * Verifies destination data with source.
 *
 * Parameters
 *  None
 *
 * Returns
 *  - SUCCESS   - Data verification success
 *  - FAILURE   - Data verification failed
 *
 */
static int VerifyDataCopy (uint8_t DevNoA,uint8_t DevNoB)
{
    /* Loop variable */
    uint32_t  loopvar;

    /* Compare the destination data with source */
    for (loopvar = 0u; loopvar < BUFF_SIZE; loopvar++)
    {
        /* IF (Destination data not same as source) */
        if ((RxBuffer[loopvar] != TxBuffer[loopvar]))
        {
            TestResult = false;
            printf("Buffer Comparison failed at Buffer Location %d\n",(int)loopvar);
            /* Return error */
            return (FAILED);
        }
    }

    printf("Core mode data transfer done between UART(%d) and UART(%d)\n",DevNoA,DevNoB);

    return (SUCCESS);
}
