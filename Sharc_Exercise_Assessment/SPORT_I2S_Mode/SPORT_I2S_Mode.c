/*********************************************************************************
Copyright(c) 2021-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*****************************************************************************
 * SPORT_I2S_Mode.c
 *****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include <services/int/adi_int.h>
#include <drivers/sport/adi_sport.h>
#include <services/spu/adi_spu.h>
#include <services/pcg/adi_pcg.h>
#include "math.h"
#include <SRU.h>
#include "SPORT_I2S_Mode.h"

/*==============  D E F I N E S  ===============*/

/*=============  D A T A  =============*/
/* Buffers*/
ADI_CACHE_ALIGN static uint32_t SrcDataBuf[ADI_CACHE_ROUND_UP_SIZE(DMA_BUF_SIZE, uint8_t)];
ADI_CACHE_ALIGN static uint32_t DestDataBuf[ADI_CACHE_ROUND_UP_SIZE(DMA_BUF_SIZE, uint8_t)];

/***** Instances to handle List descriptor transfers ******/

ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Src_List[DMA_NUM_DESC];
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Dest_List[DMA_NUM_DESC];

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


/*=============  L O C A L    F U N C T I O N    P R O T O T Y P E S =============*/
/* Prepares data buffers for SPORT DMA */
static void PrepareDataBuffers (void);
/* Prepares descriptors for SPORT DMA */
static void PrepareDescriptors (void);
/* Verifies SPORT DMA transfers */
static int VerifyDataCopy (uint32_t SportNo);
/* PCG Initialization */
void PCG_init(void);
/* SRU Initialization */
void SRU_init(void);
/* SPU Initialization */
static int SPU_init(void);

/*=============  C O D E  =============*/

/* SPORT TX callback function */
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

/* SPORT RX callback function */
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

/* PCG initialization*/
void PCG_init(void)
{
	ADI_PCG_CLK_INFO gClkInfoA =
	{
		ADI_PCG_CLK_SCLK0,              /* Clock Source */
		32u,          					/* Clock Divisor */
		false                           /* External Trigger */
	};

	ADI_PCG_FS_INFO gFsInfoA =
	{
		ADI_PCG_FS_SCLK0,                /* Clock Source */
		2048u,     						 /* Frame Sync Divisor */
		1024u,                           /* Pulse Width */
		16u,                             /* Phase */
		false,                           /* External Trigger */
		ADI_PCG_FSBYPASS_MODE_NORMAL     /* Bypass Mode */
	};

	adi_pcg_Init(ADI_PCG_DEV_A,&gClkInfoA,&gFsInfoA);


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

/*
 * Main function
 */
int main(int argc, char *argv[])
{
    /* SPORT return code */
    ADI_SPORT_RESULT    eResult;
    int Result;
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

	DEBUG_INFORMATION("SPORT I2S Mode Test\n");

    /* making all the SPORT transactions as secure master */
    if(SPU_init() != SUCCESS)
    {
        REPORT_ERROR("Failed to initialize SPU\n");
    }

    /* PCG Initialization */
    PCG_init();

    /* SRU Initialization */
    SRU_init();

    /* Open SPORT 0A */
	eResult = adi_sport_Open(SPORT_DEV_0,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory0,ADI_SPORT_MEMORY_SIZE,&hSPORTDev0ATx);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to open SPORT Device 0x%08X\n", eResult);
		return FAILED;
	}

	/* Open SPORT 0B */
	eResult = adi_sport_Open(SPORT_DEV_0,ADI_HALF_SPORT_B,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory1,ADI_SPORT_MEMORY_SIZE,&hSPORTDev0BRx);
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
			Result=VerifyDataCopy(SPORT_DEV_0);
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

	if ((eResult== 0u)&&(Result==0u))
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
	/*Connect PCG Clock and Frame sync to SPORT Clock and Frame Sync signals */
    SRU(PCG0_CLKA_O,SPT0_BCLK_I);
    SRU(PCG0_CLKA_O,SPT0_ACLK_I);
    SRU(PCG0_FSA_O,SPT0_BFS_I);
    SRU(PCG0_FSA_O,SPT0_AFS_I);
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
    for (loopvar = 0u; loopvar < DMA_BUF_SIZE; loopvar++)
    {
        SrcDataBuf[loopvar]   = (uint32_t)loopvar+1;
        DestDataBuf[loopvar]  = 0u;
    }
}

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
        Src_List[i].XCount                = (DMA_BUF_SIZE/DMA_MSIZE_IN_BYTES);
        Src_List[i].XModify               = DMA_MSIZE_IN_BYTES;
        Src_List[i].Config                = ENUM_DMA_CFG_XCNT_INT;
        Src_List[i].YCount                = 0;
        Src_List[i].YModify               = 0;

        /* DMA Config - only specify memory transfer size */
        Dest_List[i].XCount               = (DMA_BUF_SIZE/DMA_MSIZE_IN_BYTES);
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

    DEBUG_INFORMATION("DMA transfer completed between SPORT %dA and SPORT %dB successfully\n", (int)SportNo, (int)SportNo);

    /* Return success */
    return (SUCCESS);
}

