/*********************************************************************************
Copyright(c) 2021-2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/


/*****************************************************************************
 * SPORT_2D_DMA_Mode.c
 *****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include <services/int/adi_int.h>
#include <drivers/sport/adi_sport.h>
#include <services/spu/adi_spu.h>
#include "math.h"
#include <SRU.h>
#include "SPORT_2D_DMA_Mode.h"

#if ADI_CONFIG_2D_LIST_MODE
ADI_CACHE_ALIGN static uint32_t SrcDataBuf[ADI_CACHE_ROUND_UP_SIZE(COUNT, uint32_t)];
ADI_CACHE_ALIGN static uint32_t DestDataBuf[ADI_CACHE_ROUND_UP_SIZE(COUNT, uint32_t)];

/***** Instances to handle List descriptor transfers ******/
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Src_List[DMA_NUM_DESC];
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Dest_List[DMA_NUM_DESC];
#else
ADI_CACHE_ALIGN static uint32_t SrcDataBuf[ADI_CACHE_ROUND_UP_SIZE(COUNT, uint32_t)];
ADI_CACHE_ALIGN static uint32_t DestDataBuf[ADI_CACHE_ROUND_UP_SIZE(COUNT, uint32_t)];

/***** Instances to handle List descriptor transfers ******/
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Src_List;
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Dest_List;
#endif


/* Prepares data buffers for SPORT DMA */
static void PrepareDataBuffers (void);
/* Prepares descriptors for SPORT DMA */
static void PrepareDescriptors (void);

/* Verifies SPORT DMA transfers */
static int VerifyDataCopy (uint32_t SportNo);

void SRU_init(void);
static int SPU_init(void);

void Callback (void *pCBParam, uint32_t Event, void *pArg);

/* Count to track the number of callBacks */
volatile uint8_t CallbackCount = 0;

/* Memory required for SPORT */
static uint8_t SPORTMemory0[ADI_SPORT_MEMORY_SIZE];
static uint8_t SPORTMemory1[ADI_SPORT_MEMORY_SIZE];

/* SPORT Handle */
static ADI_SPORT_HANDLE hSPORTDev0ATx;//TX
static ADI_SPORT_HANDLE hSPORTDev0BRx;//RX

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
        case ADI_SPORT_EVENT_TX_BUFFER_PROCESSED:
        	CallbackCount += 1;
           break;
        default:
        	break;
    }
    /* return */
}

/* SPORT callback function */
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

        case ADI_SPORT_EVENT_RX_BUFFER_PROCESSED:
        	CallbackCount +=1;
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

	DEBUG_INFORMATION("SPORT 2D-DMA Mode Test\n");

    /* making all the SPORT transactions as secure master */
    if(SPU_init() != SUCCESS)
    {
        REPORT_ERROR("Failed to initialize SPU\n");
    }

    /* SRU Initialization */
    SRU_init();

    /* Open SPORT 0A Tx TDM 16 , sport will be configured using the sport driver static configuration file
     * adi_sport_config_2156x.h*/
	eResult = adi_sport_Open(SPORT_DEV_0,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_MC_MODE, SPORTMemory0,ADI_SPORT_MEMORY_SIZE,&hSPORTDev0ATx);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to open SPORT Device 0x%08X\n", eResult);
		return FAILED;
	}

    /* Open SPORT 0B RX TDM 16 , sport will be configured using the sport driver static configuration file
     * adi_sport_config_2156x.h*/
	eResult = adi_sport_Open(SPORT_DEV_0,ADI_HALF_SPORT_B,ADI_SPORT_DIR_RX, ADI_SPORT_MC_MODE, SPORTMemory1,ADI_SPORT_MEMORY_SIZE,&hSPORTDev0BRx);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to open SPORT Device 0x%08X\n", eResult);
		return FAILED;
	}

	/* Register SPORT0A Tx Callback */
	eResult = adi_sport_RegisterCallback(hSPORTDev0ATx,
									SPORTCallbackTx,
									NULL);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to register SPORT callback 0x%08X\n", eResult);
		return FAILED;
	}

	/* Register SPORT0B Rx Callback */
	eResult = adi_sport_RegisterCallback(hSPORTDev0BRx,
									SPORTCallbackRx,
									NULL);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to register SPORT callback 0x%08X\n", eResult);
		return FAILED;
	}

	/* Prepare data buffers */
	PrepareDataBuffers();

	/* Prepare descriptors for memory copy using List mode */
	PrepareDescriptors();


	/* select list descriptor/stop mode of DMA transfer.*/
#if ADI_CONFIG_2D_LIST_MODE
	/* Submit the buffer for Rx.  */
	eResult = adi_sport_2DDMATransfer(hSPORTDev0BRx,Dest_List,(DMA_NUM_DESC),ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to read using SPORT DMA 0x%08X\n", eResult);
		return FAILED;
	}

	/* Submit the buffer for Tx.  */
	eResult = adi_sport_2DDMATransfer(hSPORTDev0ATx,Src_List,(DMA_NUM_DESC),ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to write using SPORT DMA 0x%08X\n", eResult);
		return FAILED;
	}
#else
	/* Submit the buffer for Rx.  */
	eResult = adi_sport_2DDMATransfer(hSPORTDev0BRx,&Dest_List,(DMA_NUM_DESC),ADI_PDMA_STOP_MODE, ADI_SPORT_CHANNEL_PRIM);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to read using SPORT DMA 0x%08X\n", eResult);
		return FAILED;
	}

	/* Submit the buffer for Tx.  */
	eResult = adi_sport_2DDMATransfer(hSPORTDev0ATx,&Src_List,(DMA_NUM_DESC),ADI_PDMA_STOP_MODE, ADI_SPORT_CHANNEL_PRIM);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to write using SPORT DMA 0x%08X\n", eResult);
		return FAILED;
	}
#endif
	/* Enable SPORT 0B*/
	eResult = adi_sport_Enable(hSPORTDev0BRx,true);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable SPORT Rx  0x%08X\n", eResult);
		return FAILED;
	}

	/* Enable SPORT 0A */
	eResult = adi_sport_Enable(hSPORTDev0ATx,true);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable SPORT Tx  0x%08X\n", eResult);
		return FAILED;
	}

	while(1)
	{
		if(CallbackCount == (DMA_NUM_DESC * 2))
		{
			VerifyDataCopy(SPORT_DEV_0);
			break;
		}

	}

	/* Open SPORT 0A */
	eResult = adi_sport_Close(hSPORTDev0ATx);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to close SPORT device 0x%08X\n", eResult);
		return FAILED;
	}

	/* Open SPORT 0B */
	eResult = adi_sport_Close(hSPORTDev0BRx);
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
		DEBUG_INFORMATION("Example Failed\n");
	}

	return SUCCESS;
}

void SRU_init(void)
{
	/*Connect SPORT0A (Master) Clock and Frame sync to SPORT0B (Slave) Clock and Frame Sync signals */
	SRU(SPT0_ACLK_O,SPT0_BCLK_I);
	SRU(SPT0_AFS_O,SPT0_BFS_I);
    /*Connect Sport 0A primary channel data to Sport 0B Primary channel data  */
	SRU(SPT0_AD0_O, SPT0_BD0_I);
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
    for (loopvar = 0u; loopvar < COUNT; loopvar++)
    {
        SrcDataBuf[loopvar]   = (uint32_t)loopvar+1;
        DestDataBuf[loopvar]  = 0u;
    }
}

#if ADI_CONFIG_2D_LIST_MODE
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
        Src_List[i].XCount                = SLOTS;
        Src_List[i].XModify               = XMOD;
        Src_List[i].Config                = ENUM_DMA_CFG_YCNT_INT;
        Src_List[i].YCount                = ROWS;
        Src_List[i].YModify               = (int32_t)YMOD;

        /* DMA Config - only specify memory transfer size */
        Dest_List[i].XCount               = SLOTS;
        Dest_List[i].XModify              = XMOD;
        Dest_List[i].Config               = ENUM_DMA_CFG_YCNT_INT;
        Dest_List[i].YCount               = ROWS;
        Dest_List[i].YModify              = (int32_t)YMOD;
        /* IF (End of list) */
        if (i >= (DMA_NUM_DESC-1u))
        {
        	Src_List[i].Config                = ENUM_DMA_CFG_PERIPH_INT;
        	Dest_List[i].Config               = ENUM_DMA_CFG_YCNT_INT;
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
#else
static void PrepareDescriptors (void)
{
    /* Buffer Start Address */
#if defined(__ADSPCORTEXA55__)
    Src_List.pStartAddr            = (uint32_t)(uintptr_t)&SrcDataBuf[0];
    Dest_List.pStartAddr           = (uint32_t)(uintptr_t)&DestDataBuf[0];
#else
    Src_List.pStartAddr            = &SrcDataBuf[0];
    Dest_List.pStartAddr           = &DestDataBuf[0];
#endif
    /* DMA Config - only specify memory transfer size */
    Src_List.XCount                = SLOTS;
    Src_List.XModify               = XMOD;
    Src_List.Config                = ENUM_DMA_CFG_YCNT_INT;
    Src_List.YCount                = ROWS;
    Src_List.YModify               = (int32_t)YMOD;

    /* DMA Config - only specify memory transfer size */
    Dest_List.XCount               = SLOTS;
    Dest_List.XModify              = XMOD;
    Dest_List.Config               = ENUM_DMA_CFG_YCNT_INT;
    Dest_List.YCount               = ROWS;
    Dest_List.YModify              = (int32_t)YMOD;
}
#endif

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
    for (loopvar = 0; loopvar < COUNT; loopvar++)
    {
        /* IF (Destination data not same as source) */
        if (DestDataBuf[loopvar] != SrcDataBuf[loopvar])
        {
            /* Return error */
        	DEBUG_INFORMATION("2D-DMA transfer failed between SPORT %dA and SPORT %dB\n",(int)SportNo,(int)SportNo);
            return (FAILED);
        }
    }

    DEBUG_INFORMATION("2D-DMA transfer completed between SPORT %dA and SPORT %dB successfully\n",(int)SportNo,(int)SportNo);

    /* Return success */
    return (SUCCESS);
}

