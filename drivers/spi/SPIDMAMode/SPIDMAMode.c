/*********************************************************************************
Copyright(c) 2020-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*****************************************************************************
*      SPIDMAMode.c
******************************************************************************/
#include <stdio.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include <services/spu/adi_spu.h>
#include <drivers/spi/adi_spi.h>
#include "adi_initialize.h"
#include "SPIDMAMode.h"

ADI_CACHE_ALIGN static uint8_t SrcData[DMA_NUM_DESC][ADI_CACHE_ROUND_UP_SIZE(DESC_BUFFER_SIZE, uint8_t)];

ADI_CACHE_ALIGN static uint8_t DestData[DMA_NUM_DESC][ADI_CACHE_ROUND_UP_SIZE(DESC_BUFFER_SIZE, uint8_t)];

ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Src_List[DMA_NUM_DESC];

ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Dest_List[DMA_NUM_DESC];

static bool TestResult = true;

/* prototype */
#if defined(EV_SOMCRR_EZKIT_SUPPORT)
    void ConfigSoftSwitches_EV_SOMCRR_EZKIT (void);
#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
    void ConfigSoftSwitches_SOMCRR_EZLITE (void);
#endif

#if defined(__ADSP21591__)||defined(__ADSP21593__)
void ConfigSoftSwitches_EV_21593_SOM(void);
#elif defined(__ADSPSC594__) || defined(__ADSPSC592__) || defined(__ADSPSC594W__) || defined(__ADSPSC592W__)
void ConfigSoftSwitches_EV_SC594_SOM(void);
#elif defined(__ADSPSC598_FAMILY__)
void ConfigSoftSwitches_EV_SC598_SOM(void);
#endif

/* SPU handle */
static ADI_SPU_HANDLE hSpu;
/* Memory required for the SPU operation */
static uint8_t  SpuMemory[ADI_SPU_MEMORY_SIZE];

static int SpuInit(void);

/* Driver memory required for SPI */
static uint8_t SPIMemory0[ADI_SPI_BIDIR_MEMORY_SIZE];
static uint8_t SPIMemory1[ADI_SPI_BIDIR_MEMORY_SIZE];

/* SPI Handle */
static ADI_SPI_HANDLE hSPIMaster;
static ADI_SPI_HANDLE hSPISlave;

/* Count to track the number of callBacks */
volatile static uint32_t CallbackCount=0,TxCount=0,RxCount=0;

/* Prepares data buffers for SPI DMA */
static void PrepareDataBuffers (void);
/* Prepares descriptors for SPI DMA */
static void PrepareDescriptors (void);
/* Verify received data */
static int VerifyDataCopy(void);

static void CheckResult(ADI_SPI_RESULT Result) {
    if (Result != ADI_SPI_SUCCESS) {
        REPORT_ERROR("Failed with error code 0x%08X\n", Result);
    }
}

/* SPI callback function */
static void Callback(void *pCBParam, uint32_t Event, void *pArg)
{
    if(Event == (uint32_t)ADI_SPI_EVENT_TX_PROCESSED)
    {
      CallbackCount++;
      TxCount++;
    }
    if(Event == (uint32_t)ADI_SPI_EVENT_RX_PROCESSED)
    {
      CallbackCount++;
      RxCount++;
    }
}

int main(int argc, char *argv[])
{
   /* SPI return code */
    ADI_SPI_RESULT    eResult;
    ADI_PDMA_MODE  ePDMAMode;

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

	 /* softconfig setting */
#if defined(EV_SOMCRR_EZKIT_SUPPORT)
    ConfigSoftSwitches_EV_SOMCRR_EZKIT();
#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
    ConfigSoftSwitches_SOMCRR_EZLITE();
#endif

#if defined(__ADSP21591__)||defined(__ADSP21593__)
    ConfigSoftSwitches_EV_21593_SOM();
#elif defined(__ADSPSC594__) || defined(__ADSPSC592__) || defined(__ADSPSC594W__) || defined(__ADSPSC592W__)
    ConfigSoftSwitches_EV_SC594_SOM();
#elif defined(__ADSPSC598_FAMILY__)
    ConfigSoftSwitches_EV_SC598_SOM();
#endif

    /* making all the SPI transactions as secure Main */
    if(SpuInit() != SUCCESS)
    {
        REPORT_ERROR("Failed to initialize spu\n");
    }

#if defined(STOP_DMA_MODE)
    ePDMAMode = ADI_PDMA_STOP_MODE;
#elif defined(LISTDESCRIPTOR_DMA_MODE)
    ePDMAMode = ADI_PDMA_DESCRIPTOR_LIST;
#endif

    /* Open SPI */
    eResult = adi_spi_Open(SPI_DEVA, ADI_SPI_DIR_BIDIRECTION, SPIMemory0, ADI_SPI_BIDIR_MEMORY_SIZE, &hSPIMaster);
    CheckResult(eResult);

    eResult = adi_spi_SetasMaster(hSPIMaster,true);
    CheckResult(eResult);

    /* Open SPI */
    eResult = adi_spi_Open(SPI_DEVB, ADI_SPI_DIR_BIDIRECTION, SPIMemory1, ADI_SPI_BIDIR_MEMORY_SIZE, &hSPISlave);
    CheckResult(eResult);

    /* Register SPI Callback function for DMA mode */
    eResult = adi_spi_RegisterCallback(hSPIMaster, Callback, NULL);
    CheckResult(eResult);

    /* Register SPI Callback function for DMA mode */
    eResult = adi_spi_RegisterCallback(hSPISlave, Callback, NULL);
    CheckResult(eResult);

    /* Configure SPI Clock */
    eResult = adi_spi_SetClock(hSPIMaster,20u);
    CheckResult(eResult);

    /* Set the Subordinate select for Subordinate 2 */
    eResult = adi_spi_SetSlaveSelect(hSPIMaster, ADI_SPI_SSEL_ENABLE2);
    CheckResult(eResult);

    /* Prepare data buffers */
    PrepareDataBuffers();

    /* Prepare descriptors for memory copy using List mode */
    PrepareDescriptors();

    printf("\nSPI(%d) is Configured as Master\n",SPI_DEVA);
    printf("SPI(%d) is Configured as Slave\n",SPI_DEVB);

    eResult = adi_spi_DMARead(hSPISlave, Dest_List, DMA_NUM_DESC, ePDMAMode);
    CheckResult(eResult);

    eResult = adi_spi_DMAWrite(hSPIMaster, Src_List, DMA_NUM_DESC, ePDMAMode);
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

    if(TestResult == true)
    {
        printf("All Done \n");
    }

    /* Close SPI Main */
    eResult = adi_spi_Close(hSPIMaster);
    CheckResult(eResult);

    /* Close SPI Subordinate */
    eResult = adi_spi_Close(hSPISlave);
    CheckResult(eResult);

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

    /* Make SPI0 to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI0_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Main secure for SPI0\n");
        return (FAILED);
    }

    /* Make SPI1 to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI1_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Main secure for SPI1\n");
        return (FAILED);
    }

    /* Make SPI2 to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI2_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Main secure for SPI2\n");
        return (FAILED);
    }

    /* Make SPI0 Tx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI0_TxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Main secure for SPI0 Tx DMA\n");
        return (FAILED);
    }

    /* Make SPI0 Rx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI0_RxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Main secure for SPI0 Rx DMA\n");
        return (FAILED);
    }

    /* Make SPI1 Tx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI1_TxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Main secure for SPI1 Tx DMA\n");
        return (FAILED);
    }

    /* Make SPI1 Rx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI1_RxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Main secure for SPI1 Rx DMA\n");
        return (FAILED);
    }

    /* Make SPI2 Tx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI2_TxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Main secure for SPI2 Tx DMA\n");
        return (FAILED);
    }

    /* Make SPI2 Rx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI2_RxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Main secure for SPI2 Rx DMA\n");
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
static void PrepareDataBuffers(void)
{
    /* Loop variable */
    uint32_t descno,buff_index;
    /* Generate Source data, Clear destination buffer */
    for (descno = 0u; descno < DMA_NUM_DESC; descno++)
    {
        for (buff_index = 0u; buff_index < DESC_BUFFER_SIZE; buff_index++)
        {
            SrcData[descno][buff_index]  = buff_index+1u;
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
#if defined(STOP_DMA_MODE)
static void PrepareDescriptors(void)
{
    /* Buffer Start Address */
#if defined(__ADSPCORTEXA55__)
    Src_List[0].pStartAddr            = (uint32_t)(uintptr_t)&SrcData[0][0];
    Dest_List[0].pStartAddr           = (uint32_t)(uintptr_t)&DestData[0][0];
#else
    Src_List[0].pStartAddr            = &SrcData[0][0];
    Dest_List[0].pStartAddr           = &DestData[0][0];
#endif
    /* DMA Config - only specify memory transfer size */
    Src_List[0].XCount                = (DESC_BUFFER_SIZE/DMA_MSIZE_IN_BYTES);
    Src_List[0].XModify               = DMA_MSIZE_IN_BYTES;
    Src_List[0].Config                = ENUM_DMA_CFG_PERIPH_INT;


    /* DMA Config - only specify memory transfer size */
    Dest_List[0].XCount               = (DESC_BUFFER_SIZE/DMA_MSIZE_IN_BYTES);
    Dest_List[0].XModify              = DMA_MSIZE_IN_BYTES;
    Dest_List[0].Config               = ENUM_DMA_CFG_XCNT_INT;
}
#elif defined(LISTDESCRIPTOR_DMA_MODE)
static void PrepareDescriptors(void)
{
    /* Loop variable */
    uint32_t i;

    /* Populate List descriptor instances for SPI DMA transfer */
    for (i = 0u; i < DMA_NUM_DESC; i++)
    {
        /* Buffer Start Address */
#if defined(__ADSPCORTEXA55__)
        Src_List[i].pStartAddr            = (uint32_t)(uintptr_t)&SrcData[i][0];
        Dest_List[i].pStartAddr           = (uint32_t)(uintptr_t)&DestData[i][0];
#else
        Src_List[i].pStartAddr            = &SrcData[i][0];
        Dest_List[i].pStartAddr           = &DestData[i][0];
#endif

        /* DMA Config - only specify memory transfer size */
        Src_List[i].XCount                = (DESC_BUFFER_SIZE/DMA_MSIZE_IN_BYTES);
        Src_List[i].XModify               = DMA_MSIZE_IN_BYTES;
        Src_List[i].Config                = ENUM_DMA_CFG_XCNT_INT;

        /* DMA Config - only specify memory transfer size */
        Dest_List[i].XCount               = (DESC_BUFFER_SIZE/DMA_MSIZE_IN_BYTES);
        Dest_List[i].XModify              = DMA_MSIZE_IN_BYTES;
        Dest_List[i].Config               = ENUM_DMA_CFG_XCNT_INT;

        /* if it is an end of the list */
        if (i >= (DMA_NUM_DESC-1u))
        {
            /* Last descriptor is always configured for PIRQ interrupt for the Tx FIFO to drain completely */
            Src_List[i].Config            = ENUM_DMA_CFG_PERIPH_INT;
#if defined(__ADSPCORTEXA55__)
            Src_List[i].pNxtDscp = 0u;
            Dest_List[i].pNxtDscp = 0u;
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
    }
}
#endif


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
static int VerifyDataCopy(void)
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
                printf("DMA transfer failed at %d, %d\n",(int)descno+1,(int)buff_index+1);
                return (FAILED);
            }
        }
    }

    printf("DMA transfer completed successfully for SPI \n");
    return (SUCCESS);
}


