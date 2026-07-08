/*********************************************************************************
Copyright(c) 2019-2024 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*****************************************************************************
 * UARTDMAMode.c
 *****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include <services/int/adi_int.h>
#include <services/spu/adi_spu.h>
#include <drivers/uart/adi_uart.h>
#include "adi_initialize.h"
#include "UARTDMAMode.h"

bool TestResult = true;


ADI_CACHE_ALIGN static uint8_t SrcData[DMA_NUM_DESC][ADI_CACHE_ROUND_UP_SIZE(DESC_BUFFER_SIZE, uint8_t)];

ADI_CACHE_ALIGN static uint8_t DestData[DMA_NUM_DESC][ADI_CACHE_ROUND_UP_SIZE(DESC_BUFFER_SIZE, uint8_t)];

ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Src_List[DMA_NUM_DESC];

ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Dest_List[DMA_NUM_DESC];

/* Prepares data buffers for UART DMA */
static void PrepareDataBuffers (void);
/* Prepares descriptors for UARt DMA */
static void PrepareDescriptors (void);
/* Verifies UART DMA transfers */
static int VerifyDataCopy (void);

/* SPU handle */
static ADI_SPU_HANDLE hSpu;
/* Memory required for the SPU operation */
static uint8_t  SpuMemory[ADI_SPU_MEMORY_SIZE];

static int SpuInit(void);

/* Count to track the number of callBacks */
volatile static uint32_t TxCallbackCount=0,RxCallbackCount=0,CallbackCount=0;

/* Memory required for UART devices */
static uint8_t UARTDev0[ADI_UART_BIDIR_MEMORY_SIZE];
static uint8_t UARTDev1[ADI_UART_BIDIR_MEMORY_SIZE];

/* UART Handle */
static ADI_UART_HANDLE hDev0;
static ADI_UART_HANDLE hDev1;

/* Check the UART result */
static void CheckResult(ADI_UART_RESULT Result) {
    if (Result != ADI_UART_SUCCESS) {
        REPORT_ERROR("Failed with error code 0x%08X\n", Result);
    }
}

/* UART callback function */
void Callback(void *pCBParam, uint32_t Event, void *pArg)
{
    if(Event == (uint32_t)ADI_UART_EVENT_TX_PROCESSED)
    {
      CallbackCount++;
      TxCallbackCount++;
    }
    if(Event == (uint32_t)ADI_UART_EVENT_RX_PROCESSED)
    {
      CallbackCount++;
      RxCallbackCount++;
    }
}

int main()
{
    /* UART return code */
    ADI_UART_RESULT    eResult;
    ADI_PDMA_MODE  ePDMAMode;

    /* By default, SCLK0_0 is 93.75MHz and if a preload code is added SCLK0_0 is 125 MHz
     * Baud rate = (SCLK0_0 / (pow(16,(1-Edbo))*Divisor)) */

    /* Set prescaler */
    bool         Edbo = 1u;

    /* Divisor value set such that Baud rate is set to 57600 for SCLK0_0 = 125 MHz*/
    uint32_t     Divisor = 2170u;

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

    /* making all the UART transactions as secure master */
    if(SpuInit() != SUCCESS)
    {
        REPORT_ERROR("Failed to initialize spu\n");
    }

#if defined(STOP_DMA_MODE)
    ePDMAMode = ADI_PDMA_STOP_MODE;
#elif defined(LISTDESCRIPTOR_DMA_MODE)
    ePDMAMode = ADI_PDMA_DESCRIPTOR_LIST;
#endif

    /* Open UART */
    eResult = adi_uart_Open(UART_DEVA, ADI_UART_DIR_BIDIRECTION, UARTDev0, ADI_UART_BIDIR_MEMORY_SIZE, &hDev0);
    CheckResult(eResult);

    /* Configure UART baud rate */
    eResult = adi_uart_ConfigBaudRate(hDev0, Edbo, Divisor);
    CheckResult(eResult);

    /* Register UART Callback function for DMA mode */
    eResult = adi_uart_RegisterCallback(hDev0, Callback, NULL);
    CheckResult(eResult);

    /* Open UART */
    eResult = adi_uart_Open(UART_DEVB, ADI_UART_DIR_BIDIRECTION, UARTDev1, ADI_UART_BIDIR_MEMORY_SIZE, &hDev1);
    CheckResult(eResult);

    /* Configure UART baud rate */
    eResult = adi_uart_ConfigBaudRate(hDev1, Edbo, Divisor);
    CheckResult(eResult);

    /* Register UART Callback function for DMA mode */
    eResult = adi_uart_RegisterCallback(hDev1, Callback, NULL);
    CheckResult(eResult);

    /* Prepare data buffers */
    PrepareDataBuffers();

    /* Prepare descriptors for memory copy using List mode */
    PrepareDescriptors();

    printf("\nUART(%d) is Configured as Tx\n",UART_DEVA);
    printf("UART(%d) is Configured as Rx\n",UART_DEVB);

    /* Read UART data to Rx buffer */
    eResult = adi_uart_DMARead(hDev1, Dest_List, DMA_NUM_DESC, ePDMAMode);
    CheckResult(eResult);

    /* Write Tx buffer to UART */
    eResult = adi_uart_DMAWrite(hDev0, Src_List, DMA_NUM_DESC, ePDMAMode);
    CheckResult(eResult);

    while(1)
    {
        if(CallbackCount == (DMA_NUM_DESC * 2))
        {
            CallbackCount=0;
            VerifyDataCopy();
            break;
        }
    }

    /* Close the UART device */
    eResult = adi_uart_Close(hDev0);
    CheckResult(eResult);

    /* Close the UART device */
    eResult = adi_uart_Close(hDev1);
    CheckResult(eResult);

    if(TestResult == true )
    {
       printf("All Done \n");
    }

    return 0;
}

/*
 * Initializes SPU
 *
 * Parameters           None
 *
 * Returns
 *  - SUCCESS   - SPU initialization passed
 *  - FAILURE   - SPU initialization failed
 *
 */
static int SpuInit(void)
{
    /* Initialize SPU Service */
    if(adi_spu_Init(0u, SpuMemory, NULL, NULL, &hSpu) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to initialize SPU service\n");
        return (FAILED);
    }

    /* Make UART0 to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, UART0_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for UART0\n");
        return (FAILED);
    }

    /* Make UART1 to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, UART1_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for UART1\n");
        return (FAILED);
    }

    /* Make UART0 Tx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, UART0_TxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for UART0 Tx DMA\n");
        return (FAILED);
    }

    /* Make UART1 Rx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, UART1_RxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for UART1 Rx DMA\n");
        return (FAILED);
    }

    return (SUCCESS);
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
static void PrepareDataBuffers (void)
{
    /* Loop variable */
    uint32_t descno,buff_index;

    /* Generate Source data, Clear destination buffer */
    for (descno = 0u; descno < DMA_NUM_DESC; descno++)
    {
        for (buff_index = 0u; buff_index < DESC_BUFFER_SIZE; buff_index++)
        {
            SrcData[descno][buff_index]  = (uint8_t)rand();
            DestData[descno][buff_index]  = 0u;
        }
    }
}

/*
 * Prepares descriptors
 *
 * Parameters
 *  None
 *
 * Returns
 *  None
 *
 */
static void PrepareDescriptors (void)
{
    /* Loop variable */
    uint32_t i;

    /* Populate List descriptor instances for UART DMA transfer */
    for (i = 0u; i < DMA_NUM_DESC; i++)
    {
        /* Buffer Start Address */
#if defined(__ADSPCORTEXA55__)
        Src_List[i].pStartAddr            = (uint32_t)(uintptr_t)&SrcData[i][0];
#else
        Src_List[i].pStartAddr            = &SrcData[i][0];
#endif
        /* DMA Config - only specify memory transfer size */
        Src_List[i].XCount                = (DESC_BUFFER_SIZE/DMA_MSIZE_IN_BYTES);
        Src_List[i].XModify               = DMA_MSIZE_IN_BYTES;
        Src_List[i].Config                = ENUM_DMA_CFG_XCNT_INT;

        /* Buffer Start Address */
#if defined(__ADSPCORTEXA55__)
        Dest_List[i].pStartAddr           = (uint32_t)(uintptr_t)&DestData[i][0];
#else
        Dest_List[i].pStartAddr           = &DestData[i][0];
#endif
        /* DMA Config - only specify memory transfer size */
        Dest_List[i].XCount               = (DESC_BUFFER_SIZE/DMA_MSIZE_IN_BYTES);
        Dest_List[i].XModify              = DMA_MSIZE_IN_BYTES;
        Dest_List[i].Config               = ENUM_DMA_CFG_XCNT_INT;

#if defined(LISTDESCRIPTOR_DMA_MODE)
        /* if it is an end of the list */
        if (i >= (DMA_NUM_DESC-1u))
        {
#if defined(__ADSPCORTEXA55__)
            Src_List[i].pNxtDscp = 0;
            Dest_List[i].pNxtDscp = 0;
#else
            Src_List[i].pNxtDscp = NULL;
            Dest_List[i].pNxtDscp = NULL;
#endif
        }
        /* if it is not an end of the list */
        else
        {
#if defined(__ADSPCORTEXA55__)
            Src_List[i].pNxtDscp  = (uint32_t)(uintptr_t)&Src_List[i+1];
            Dest_List[i].pNxtDscp = (uint32_t)(uintptr_t)&Dest_List[i+1];
#else
            Src_List[i].pNxtDscp  = &Src_List[i+1];
            Dest_List[i].pNxtDscp = &Dest_List[i+1];
#endif
        }
#elif defined(STOP_DMA_MODE)
#if defined(__ADSPCORTEXA55__)
        Src_List[i].pNxtDscp = 0;
        Dest_List[i].pNxtDscp = 0;
#else
        Src_List[i].pNxtDscp = NULL;
        Dest_List[i].pNxtDscp = NULL;
#endif
#endif

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
static int VerifyDataCopy (void)
{
    /* Loop variable */
    uint32_t descno,buff_index;

    /* Generate Source data, Clear destination buffer */
    for (descno = 0u; descno < DMA_NUM_DESC; descno++)
    {
        for (buff_index = 0u; buff_index < DESC_BUFFER_SIZE; buff_index++)
        {
            /* IF (Destination data not same as source) */
            if (DestData[descno][buff_index] != SrcData[descno][buff_index])
            {
                TestResult = false;
                printf("callback count = %d\n",(int)CallbackCount);
                printf("DMA transfer failed at %d, %d\n",(int)descno,(int)buff_index);

                /* Return error */
                return (FAILED);
            }
        }
    }

    printf("DMA transfer completed successfully for UART\n");

    /* Return success */
    return (SUCCESS);
}

