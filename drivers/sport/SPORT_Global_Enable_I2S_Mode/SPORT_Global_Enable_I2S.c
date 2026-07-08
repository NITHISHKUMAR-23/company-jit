/*********************************************************************************
Copyright(c) 2021-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*****************************************************************************
 * SPORT_Global_Enable_I2S.c
 *****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include <services/int/adi_int.h>
#include <drivers/sport/adi_sport.h>
#include <services/spu/adi_spu.h>
#include <assert.h>
#include "math.h"
#include <SRU.h>
#include "SPORT_Global_Enable_I2S.h"

/************************************** 0 *************************************/
ADI_CACHE_ALIGN static uint8_t SrcDataBuf[ADI_CACHE_ROUND_UP_SIZE(DMA_BUF_SIZE, uint8_t)];
ADI_CACHE_ALIGN static uint8_t DestDataBuf[ADI_CACHE_ROUND_UP_SIZE(DMA_BUF_SIZE, uint8_t)];

/***** Instances to handle List descriptor transfers ******/
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Src_List[DMA_NUM_DESC];
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Dest_List[DMA_NUM_DESC];

/* Prepares data buffers for SPORT DMA */
static void PrepareDataBuffers (void);
/* Prepares descriptors for SPORT DMA */
static void PrepareDescriptors (void);

/************************************** 1 *************************************/
ADI_CACHE_ALIGN static uint8_t SrcDataBuf1[ADI_CACHE_ROUND_UP_SIZE(DMA_BUF_SIZE1, uint8_t)];
ADI_CACHE_ALIGN static uint8_t DestDataBuf1[ADI_CACHE_ROUND_UP_SIZE(DMA_BUF_SIZE1, uint8_t)];

/***** Instances to handle List descriptor transfers ******/
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Src_List1[DMA_NUM_DESC1];
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Dest_List1[DMA_NUM_DESC1];

/* Prepares data buffers for SPORT DMA */
static void PrepareDataBuffers1 (void);
/* Prepares descriptors for SPORT DMA */
static void PrepareDescriptors1 (void);

/* Verifies SPORT DMA transfers */
static int VerifyDataCopy (uint32_t SportNo);
static int VerifyDataCopy1 (uint32_t SportNo);

/* Count to track the number of callBacks */
volatile uint32_t CallbackCountTx,CallbackCountRx = 0;


/* Memory required for SPORT */
static uint8_t SPORTMemory0[ADI_SPORT_MEMORY_SIZE];
static uint8_t SPORTMemory1[ADI_SPORT_MEMORY_SIZE];
static uint8_t SPORTMemory2[ADI_SPORT_MEMORY_SIZE];
static uint8_t SPORTMemory3[ADI_SPORT_MEMORY_SIZE];

/* SPORT Handle */
static ADI_SPORT_HANDLE hSPORTDev0ATx;
static ADI_SPORT_HANDLE hSPORTDev0BRx;
static ADI_SPORT_HANDLE hSPORTDev1ATx;
static ADI_SPORT_HANDLE hSPORTDev1BRx;

/* Global SPORT Array Handle */
static ADI_SPORT_HANDLE SportTxDai0Array[2]= {NULL,NULL};
static ADI_SPORT_HANDLE SportRxDai0Array[2]= {NULL,NULL};

/*GLobal sport group handle */
static ADI_GLOBAL_SPORT_HANDLE hDai0Group0Tx;
static ADI_GLOBAL_SPORT_HANDLE hDai0Group1Rx;

/* SPU handle */
static ADI_SPU_HANDLE      ghSpu;

/* Memory required for the SPU operation */
uint8_t             SpuMemory[ADI_SPU_MEMORY_SIZE];


static void SPORTCallbackTx(
    void        *pAppHandle,
    uint32_t     nEvent,
    void        *pArg
)
{
    /* CASEOF (event type) */
    switch (nEvent)
    {
        /* CASE (buffer processed) */
        case ADI_SPORT_EVENT_BUFFER_PROCESSED:
        	CallbackCountTx += 1;
           break;
        default:
        	break;
    }
    /* return */
}

static void SPORTCallbackRx(
    void        *pAppHandle,
    uint32_t     nEvent,
    void        *pArg
)
{
    /* CASEOF (event type) */
    switch (nEvent)
    {
        /* CASE (buffer processed) */
        case ADI_SPORT_EVENT_BUFFER_PROCESSED:
        	CallbackCountRx += 1;
           break;
        default:
        	break;
    }
    /* return */
}

/*
 * Prepares SPU configuration.
 *
 * Parameters
 *  None
 *
 * Returns
 *  None
 *
 */
int SPU_init(void)
{
    if(adi_spu_Init(0, SpuMemory, NULL, NULL, &ghSpu) != ADI_SPU_SUCCESS)
    {
    	REPORT_ERROR("Failed to initialize SPU service\n");
		return FAILED;
    }

    /* Make SPORT 0A to generate secure transactions */
    if(adi_spu_EnableMasterSecure(ghSpu, SPORT_0A_SPU, true) != ADI_SPU_SUCCESS)
    {
    	REPORT_ERROR("Failed to enable Master secure for SPORT0A\n");
		return FAILED;
    }

    /* Make SPORT 0B to generate secure transactions */
    if(adi_spu_EnableMasterSecure(ghSpu, SPORT_0B_SPU, true) != ADI_SPU_SUCCESS)
    {
    	REPORT_ERROR("Failed to enable Master secure for SPORT0B\n");
		return FAILED;
    }

    /* Make SPORT 1A to generate secure transactions */
    if(adi_spu_EnableMasterSecure(ghSpu, SPORT_1A_SPU, true) != ADI_SPU_SUCCESS)
    {
    	REPORT_ERROR("Failed to enable Master secure for SPORT0A\n");
		return FAILED;
    }

    /* Make SPORT 1B to generate secure transactions */
    if(adi_spu_EnableMasterSecure(ghSpu, SPORT_1B_SPU, true) != ADI_SPU_SUCCESS)
    {
    	REPORT_ERROR("Failed to enable Master secure for SPORT0B\n");
		return FAILED;
    }

    return SUCCESS;

}


int main(int argc, char *argv[])
{
    /* SPORT return code */
    ADI_SPORT_RESULT    eResult;

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

	DEBUG_INFORMATION("SPORT Global Enable I2S Mode Test\n");

    /* making all the SPORT transactions as secure master */
    if(SPU_init() != SUCCESS)
    {
        REPORT_ERROR("Failed to initialize SPU\n");
    }

    /* SRU Initialization */
	SRU_init();

	/********************************************************* SPORT 0 open***********************************************************/
    eResult = adi_sport_Open(SPORT_DEVICE_0,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory0,ADI_SPORT_MEMORY_SIZE,&hSPORTDev0ATx);
    if (eResult != ADI_SPORT_SUCCESS)
    {
        REPORT_ERROR("Failed to open SPORT Device 0x%08X\n", eResult);
        return FAILED;
    }
    eResult = adi_sport_Open(SPORT_DEVICE_0,ADI_HALF_SPORT_B,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory1,ADI_SPORT_MEMORY_SIZE,&hSPORTDev0BRx);
    if (eResult != ADI_SPORT_SUCCESS)
    {
        REPORT_ERROR("Failed to open SPORT Device 0x%08X\n", eResult);
        return FAILED;
    }

	/********************************************************* SPORT 0 open***********************************************************/
    eResult = adi_sport_Open(SPORT_DEVICE_1,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory2,ADI_SPORT_MEMORY_SIZE,&hSPORTDev1ATx);
    if (eResult != ADI_SPORT_SUCCESS)
    {
        REPORT_ERROR("Failed to open SPORT Device 0x%08X\n", eResult);
        return FAILED;
    }
    eResult = adi_sport_Open(SPORT_DEVICE_1,ADI_HALF_SPORT_B,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory3,ADI_SPORT_MEMORY_SIZE,&hSPORTDev1BRx);
    if (eResult != ADI_SPORT_SUCCESS)
    {
        REPORT_ERROR("Failed to open SPORT Device 0x%08X\n", eResult);
        return FAILED;
    }

    /**************************************************Sport Global Group Array Handle***********************************************************/
    SportTxDai0Array[0]= hSPORTDev0ATx;
    SportTxDai0Array[1]= hSPORTDev1ATx;

    SportRxDai0Array[0]= hSPORTDev0BRx;
    SportRxDai0Array[1]= hSPORTDev1BRx;

    /******************************* Prepare data buffers and Prepare descriptors***********************************************/

	PrepareDataBuffers();
	PrepareDescriptors();
	PrepareDataBuffers1();
	PrepareDescriptors1();

	/********************************************************* SPORT 0***********************************************************/
	/* Submit the buffer for Rx.  */
	eResult = adi_sport_DMATransfer(hSPORTDev0BRx,Dest_List,(DMA_NUM_DESC),ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to read using SPORT DMA 0x%08X\n", eResult);
		return FAILED;
	}

	/* Submit the buffer for Tx.  */
	eResult = adi_sport_DMATransfer(hSPORTDev0ATx,Src_List,(DMA_NUM_DESC),ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to write using SPORT DMA 0x%08X\n", eResult);
		return FAILED;
	}

	/********************************************************* SPORT 1***********************************************************/
	/* Submit the buffer for Rx.  */
	eResult = adi_sport_DMATransfer(hSPORTDev1BRx,Dest_List1,(DMA_NUM_DESC1),ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to read using SPORT DMA 0x%08X\n", eResult);
		return FAILED;
	}

	/* Submit the buffer for Tx.  */
	eResult = adi_sport_DMATransfer(hSPORTDev1ATx,Src_List1,(DMA_NUM_DESC1),ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to write using SPORT DMA 0x%08X\n", eResult);
		return FAILED;
	}

	/**************************************************Create Global Groups*****************************************************/
	eResult = adi_sport_CreateGlobalGroup(SportTxDai0Array,2u,&hDai0Group0Tx,false,false);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to Create SPORT Global Group 0x%08X\n", eResult);
		return FAILED;
	}

	eResult = adi_sport_CreateGlobalGroup(SportRxDai0Array,2u,&hDai0Group1Rx,false,false);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to Create SPORT Global Group 0x%08X\n", eResult);
		return FAILED;
	}

    /********************************************************* SPORT Global Register Callback***********************************************************/
	/* Register SPORT Callback function for DMA mode */
	eResult = adi_sport_GlobalRegisterCallback(hDai0Group0Tx,
								SPORTCallbackTx,
								NULL);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to register Global SPORT callback for TX group 0x%08X\n", eResult);
		return FAILED;
	}

	eResult = adi_sport_GlobalRegisterCallback(hDai0Group1Rx,
										SPORTCallbackRx,
										NULL);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to register Global SPORT callback for TX group 0x%08X\n", eResult);
		return FAILED;
	}

	/**************************************************Global Sport Enable*****************************************************/
	eResult = adi_sport_GlobalEnable(true);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable SPORT Global Gate 0x%08X\n", eResult);
		return FAILED;
	}

	while(1)
	{
		if(CallbackCountTx + CallbackCountRx == 8u)
		{
			VerifyDataCopy(SPORT_DEVICE_0);
			VerifyDataCopy1(SPORT_DEVICE_1);
			break;
		}
	}

	/**************************************************Destroy Global Groups*****************************************************/
	eResult = adi_sport_DestroyGlobalGroup(hDai0Group0Tx);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to Create SPORT Global Group 0x%08X\n", eResult);
		return FAILED;
	}

	eResult = adi_sport_DestroyGlobalGroup(hDai0Group1Rx);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to Create SPORT Global Group 0x%08X\n", eResult);
		return FAILED;
	}

	/**************************************************Disable Global Groups*****************************************************/

	eResult = adi_sport_GlobalEnable(false);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable SPORT Global Gate 0x%08X\n", eResult);
		return FAILED;
	}

	/**************************************************Close SPORT 0*****************************************************/
	eResult = adi_sport_Close(hSPORTDev0ATx);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to close SPORT device 0x%08X\n", eResult);
		return FAILED;
	}
	eResult = adi_sport_Close(hSPORTDev0BRx);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to close SPORT device 0x%08X\n", eResult);
		return FAILED;
	}

	/**************************************************Close SPORT 1*****************************************************/
	eResult = adi_sport_Close(hSPORTDev1ATx);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to close SPORT device 0x%08X\n", eResult);
		return FAILED;
	}
	eResult = adi_sport_Close(hSPORTDev1BRx);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to close SPORT device 0x%08X\n", eResult);
		return FAILED;
	}


	if (eResult== 0u)
	{
		DEBUG_INFORMATION("All done\n");
	}
	else
	{
		DEBUG_INFORMATION("Error\n");
	}


	return 0;
}

/*Configures SRU*/
void SRU_init(void)
{
	/*Connect SPORT signals */
	SRU(SPT0_ACLK_O,SPT0_BCLK_I);
	SRU(SPT0_AFS_O,SPT0_BFS_I);
	SRU(SPT0_AD0_O, SPT0_BD0_I);

	SRU(SPT1_ACLK_O,SPT1_BCLK_I);
	SRU(SPT1_AFS_O,SPT1_BFS_I);
	SRU(SPT1_AD0_O, SPT1_BD0_I);

}

/*
 * Prepares data buffers for Memory DMA copy.
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
    for (loopvar = 0u; loopvar < DMA_BUF_SIZE; loopvar++)
    {
        SrcDataBuf[loopvar]   = (uint8_t)loopvar+1;
        DestDataBuf[loopvar]  = 0u;
    }
}

static void PrepareDataBuffers1 (void)
{
    /* Loop variable */
    uint32_t loopvar;

    /* Generate Source data, Clear destination buffer */
    for (loopvar = 0u; loopvar < DMA_BUF_SIZE1; loopvar++)
    {
        SrcDataBuf1[loopvar]   = (uint8_t)loopvar+1;
        DestDataBuf1[loopvar]  = 0u;
    }
}


/*
 * Prepares descriptors for Memory DMA copy.
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

    /* Populate List descriptor instances for SPORT DMA transfer */
    for (i = 0u; i < DMA_NUM_DESC; i++)
    {
        /* Buffer Start Address */
#if defined(__ADSPCORTEXA55__)
        Src_List[i].pStartAddr            = (uint32_t)(uintptr_t)&SrcDataBuf[i * DMA_BYTES_PER_DESC];
        Dest_List[i].pStartAddr           = (uint32_t)(uintptr_t)&DestDataBuf[i * DMA_BYTES_PER_DESC];
#else
        Src_List[i].pStartAddr            = &SrcDataBuf[i * DMA_BYTES_PER_DESC];
        Dest_List[i].pStartAddr           = &DestDataBuf[i * DMA_BYTES_PER_DESC];
#endif
        /* DMA Config - only specify memory transfer size */
        Src_List[i].XCount                = (DMA_BYTES_PER_DESC/DMA_MSIZE_IN_BYTES);
        Src_List[i].XModify               = DMA_MSIZE_IN_BYTES;
        Src_List[i].Config                = ENUM_DMA_CFG_XCNT_INT;
        Src_List[i].YCount                = 0;
        Src_List[i].YModify               = 0;

        /* DMA Config - only specify memory transfer size */
        Dest_List[i].XCount               = (DMA_BYTES_PER_DESC/DMA_MSIZE_IN_BYTES);
        Dest_List[i].XModify              = DMA_MSIZE_IN_BYTES;
        Dest_List[i].Config               = ENUM_DMA_CFG_XCNT_INT;
        Dest_List[i].YCount               = 0;
        Dest_List[i].YModify              = 0;
        /* IF (End of list) */
        if (i >= (DMA_NUM_DESC-1u))
        {
        	Src_List[i].Config                = ENUM_DMA_CFG_PERIPH_INT;
        	Dest_List[i].Config               = ENUM_DMA_CFG_XCNT_INT;

#if defined(__ADSPCORTEXA55__)
            Src_List[i].pNxtDscp = 0u;
            Dest_List[i].pNxtDscp = 0u;
#else
            Src_List[i].pNxtDscp = NULL;
            Dest_List[i].pNxtDscp = NULL;
#endif
        }
        /* ELSE (More descriptors in list) */
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

static void PrepareDescriptors1 (void)
{
    /* Loop variable */
    uint32_t i;

    /* Populate List descriptor instances for SPORT DMA transfer */
    for (i = 0u; i < DMA_NUM_DESC1; i++)
    {
        /* Buffer Start Address */
#if defined(__ADSPCORTEXA55__)
        Src_List1[i].pStartAddr            = (uint32_t)(uintptr_t)&SrcDataBuf1[i * DMA_BYTES_PER_DESC1];
        Dest_List1[i].pStartAddr           = (uint32_t)(uintptr_t)&DestDataBuf1[i * DMA_BYTES_PER_DESC1];
#else
        Src_List1[i].pStartAddr            = &SrcDataBuf1[i * DMA_BYTES_PER_DESC1];
        Dest_List1[i].pStartAddr           = &DestDataBuf1[i * DMA_BYTES_PER_DESC1];
#endif
        /* DMA Config - only specify memory transfer size */
        Src_List1[i].XCount                = (DMA_BYTES_PER_DESC1/DMA_MSIZE_IN_BYTES1);
        Src_List1[i].XModify               = DMA_MSIZE_IN_BYTES1;
        Src_List1[i].Config                = ENUM_DMA_CFG_XCNT_INT;
        Src_List1[i].YCount                = 0;
        Src_List1[i].YModify               = 0;


        /* DMA Config - only specify memory transfer size */
        Dest_List1[i].XCount               = (DMA_BYTES_PER_DESC1/DMA_MSIZE_IN_BYTES1);
        Dest_List1[i].XModify              = DMA_MSIZE_IN_BYTES1;
        Dest_List1[i].Config               = ENUM_DMA_CFG_XCNT_INT;
        Dest_List1[i].YCount               = 0;
        Dest_List1[i].YModify              = 0;
        /* IF (End of list) */
        if (i >= (DMA_NUM_DESC1-1u))
        {
        	Src_List1[i].Config                = ENUM_DMA_CFG_PERIPH_INT;
        	Dest_List1[i].Config               = ENUM_DMA_CFG_XCNT_INT;
#if defined(__ADSPCORTEXA55__)
            Src_List1[i].pNxtDscp = 0u;
            Dest_List1[i].pNxtDscp = 0u;
#else
            Src_List1[i].pNxtDscp = NULL;
            Dest_List1[i].pNxtDscp = NULL;
#endif
        }
        /* ELSE (More descriptors in list) */
        else
        {
#if defined(__ADSPCORTEXA55__)
            Src_List1[i].pNxtDscp  = (uint32_t)(uintptr_t)&Src_List1[i+1];
            Dest_List1[i].pNxtDscp = (uint32_t)(uintptr_t)&Dest_List1[i+1];
#else
            Src_List1[i].pNxtDscp  = &Src_List1[i+1];
            Dest_List1[i].pNxtDscp = &Dest_List1[i+1];
#endif
        }
    }
}

/*
 * Verifies memory DMA copy by comparing destination data with source.
 *
 * Parameters
 *  None
 *
 * Returns
 *  - SUCCESS   - Data verification success
 *  - FAILURE   - Data verification failed
 *
 */
static int VerifyDataCopy (uint32_t SportNo)
{
    /* Loop variable */
    uint32_t  loopvar;

    /* Compare the destination data with source */
    for (loopvar = 0; loopvar < DMA_BUF_SIZE; loopvar++)
    {
        /* IF (Destination data not same as source) */
        if (DestDataBuf[loopvar] != SrcDataBuf[loopvar])
        {
            /* Return error */
        	DEBUG_INFORMATION("DMA transfer failed between SPORT %dA and SPORT %dB\n",(int)SportNo,(int)SportNo);
            return (FAILED);
        }
    }

    DEBUG_INFORMATION("DMA transfer completed between SPORT %dA and SPORT %dB successfully\n",(int)SportNo,(int)SportNo);

    /* Return success */
    return (SUCCESS);
}


static int VerifyDataCopy1 (uint32_t SportNo)
{
    /* Loop variable */
    uint32_t  loopvar;

    /* Compare the destination data with source */
    for (loopvar = 0; loopvar < DMA_BUF_SIZE1; loopvar++)
    {
        /* IF (Destination data not same as source) */
        if (DestDataBuf1[loopvar] != SrcDataBuf1[loopvar])
        {
            /* Return error */
        	DEBUG_INFORMATION("DMA transfer failed between SPORT %dA and SPORT %dB\n",(int)SportNo,(int)SportNo);
            return (FAILED);
        }
    }

    DEBUG_INFORMATION("DMA transfer completed between SPORT %dA and SPORT %dB successfully\n",(int)SportNo,(int)SportNo);

    /* Return success */
    return (SUCCESS);
}
