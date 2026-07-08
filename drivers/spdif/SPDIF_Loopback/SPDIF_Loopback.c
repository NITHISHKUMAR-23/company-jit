/*********************************************************************************
Copyright(c) 2020-2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * SPDIF_Loopback.c
 *****************************************************************************/
#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include <services/int/adi_int.h>
#include <drivers/sport/adi_sport.h>
#include <drivers/spdif/adi_spdif_rx.h>
#include <drivers/spdif/adi_spdif_tx.h>
#include <services/pcg/adi_pcg.h>
#include <services/dai/adi_dai.h>
#include <services/spu/adi_spu.h>
#include <sru.h>
#include <stdio.h>
#include "SPDIF_Loopback.h"

ADI_CACHE_ALIGN static uint32_t SrcDataBuf[ADI_CACHE_ROUND_UP_SIZE(DMA_BUF_SIZE, uint32_t)];
ADI_CACHE_ALIGN static uint32_t DestDataBuf[ADI_CACHE_ROUND_UP_SIZE(DMA_BUF_SIZE, uint32_t)];

/***** Instances to handle List descriptor transfers ******/
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Src_List[DMA_NUM_DESC];
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Dest_List[DMA_NUM_DESC];


/* Memory required for SPORT */
static uint8_t SPORTMemory0[ADI_SPORT_MEMORY_SIZE];
static uint8_t SPORTMemory1[ADI_SPORT_MEMORY_SIZE];

/* SPORT Handle */
static ADI_SPORT_HANDLE hSPORTDev0ATx;//TX
static ADI_SPORT_HANDLE hSPORTDev0BRx;//RX


static uint8_t SpdifRxMemory[ADI_SPDIF_RX_MEMORY_SIZE];
static uint8_t SpdifTxMemory[ADI_SPDIF_TX_MEMORY_SIZE];

static ADI_SPDIF_RX_HANDLE hSpdifRx;//TX
static ADI_SPDIF_TX_HANDLE hSpdifTx;//RX

/* SPU handle */
static ADI_SPU_HANDLE   ghSpu;

/* Memory required for the SPU operation */
uint8_t             SpuMemory[ADI_SPU_MEMORY_SIZE];

ADI_PCG_CLK_INFO ClkConfig,ClkConfig1;
ADI_PCG_FS_INFO FsConfig;
uint32_t CallbackCount=0;

void SruConfig(void);
int Sportinit(void);
int SpdifRxinit(void);
int SpdifTxinit(void);
void Pcginit(void);
int CheckBuffer(void);
int SportStop(void);
int SpdifStop(void);
int SPU_init(void);
extern void ConfigSoftSwitchesCoaxial(void);
extern void ConfigSoftSwitchesOpt(void);

int delay;

int adi_SpdifCoaxialtest(void)
{
	/**
	 * Initialize managed drivers and/or services that have been added to
	 * the project.
	 * @return zero on success
	 */
	int result;

	CallbackCount=0;

	/* Switch configuration */
	ConfigSoftSwitchesCoaxial();

	/* SRU Configuration */
	SruConfig();

    /* making all the SPORT transactions as secure master */
    if(SPU_init() != SUCCESS)
    {
        REPORT_ERROR("Failed to initialize SPU\n");
    }

    /* SPORT Initialization */
	if((result=Sportinit())>0)
    {
        REPORT_ERROR("Failed to initialize SPORT\n");
        return FAILED;
    }

	/* SPDIF Rx Initialization */
	if((result=SpdifRxinit())>0)
    {
        REPORT_ERROR("Failed to initialize SPDIF Rx\n");
        return FAILED;
    }

	/* SPDIF Tx Initialization */
	if((SpdifTxinit())>0)
    {
        REPORT_ERROR("Failed to initialize SPDIF Tx\n");
        return FAILED;
    }

	/* PCG Initialization */
	Pcginit();

	while(CallbackCount<200)
	{
		asm("nop;");
	}

	if((result=CheckBuffer())>0)
		return FAILED;


	if((result=SpdifStop())>0)
		return FAILED;

	if((result=SportStop())>0)
		return FAILED;

	return SUCCESS;
}

int adi_SpdifOpttest(void)
{
	/**
	 * Initialize managed drivers and/or services that have been added to
	 * the project.
	 * @return zero on success
	 */

	int result;
	CallbackCount=0;

	/* Switch Configuration */
	ConfigSoftSwitchesOpt();

	/* SRU Configuration */
	SruConfig();

    /* making all the SPORT transactions as secure master */
    if(SPU_init() != SUCCESS)
    {
        REPORT_ERROR("Failed to initialize SPU\n");
    }

	/* PCG Initialization */
	Pcginit();

    /* SPORT Initialization */
	if((result=Sportinit())>0)
    {
        REPORT_ERROR("Failed to initialize SPORT\n");
        return FAILED;
    }

	/* SPDIF Rx Initialization */
	if((result=SpdifRxinit())>0)
    {
        REPORT_ERROR("Failed to initialize SPDIF RX\n");
        return FAILED;
    }

	/* SPDIF Tx Initialization */
	if(SpdifTxinit())
    {
        REPORT_ERROR("Failed to initialize SPDIF Tx\n");
        return FAILED;
    }

	while(CallbackCount<200)
	{
		asm("nop;");
	}

	if((result=CheckBuffer())>0)
		return FAILED;


	if((result=SpdifStop())>0)
		return FAILED;

	if((result=SportStop())>0)
		return FAILED;


	return SUCCESS;
}


/*
 * Main function
 */
int main(int argc, char *argv[])
{

	adi_initComponents();
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif

#ifdef SPDIF_OPTICAL_TEST
	DEBUG_INFORMATION("SPDIF Optical Test\n");
	if (adi_SpdifOpttest() != SUCCESS)
	{
		REPORT_ERROR("Failed to Run SPDIF Optical Test\n");
		REPORT_ERROR("Example Failed\n");
	}
	else
	{
		DEBUG_INFORMATION("SPDIF Optical Test Passed\n");
		DEBUG_INFORMATION("All done\n");
	}
#else
	DEBUG_INFORMATION("SPDIF Coaxial Test\n");
	if(adi_SpdifCoaxialtest() != SUCCESS)
	{
		REPORT_ERROR("Failed to Run SPDIF Coaxial Test\n");
		REPORT_ERROR("Example Failed\n");
	}
	else
	{
		DEBUG_INFORMATION("SPDIF Coaxial Test Passed\n");
		DEBUG_INFORMATION("All done\n");
	}
#endif
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
void SruConfig(void)
{
	*pREG_PADS0_DAI0_IE=0x1fffff;
	*pREG_PADS0_DAI1_IE=0x1fffff;

	SRU(PCG0_FSA_O,SPT0_AFS_I);
	SRU(PCG0_CLKA_O,SPT0_ACLK_I);

	SRU(PCG0_FSA_O,SPDIF0_TX_FS_I);
	SRU(PCG0_CLKA_O,SPDIF0_TX_CLK_I);
	SRU(PCG0_CLKB_O,SPDIF0_TX_HFCLK_I);
	SRU(SPT0_AD0_O,SPDIF0_TX_DAT_I);

    SRU(SPDIF0_RX_FS_O,SPT0_BFS_I);
	SRU(SPDIF0_RX_CLK_O,SPT0_BCLK_I);
	SRU(SPDIF0_RX_DAT_O,SPT0_BD0_I);

    SRU(SPDIF0_TX_O,DAI0_PB10_I);
    SRU(HIGH,DAI0_PBEN10_I);

	SRU(LOW,DAI0_PBEN09_I);
	SRU(DAI0_PB09_O,SPDIF0_RX_I);
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


static void PrepareDataBuffers (void)
{
    /* Loop variable */
    uint32_t loopvar;

    /* Generate Source data, Clear destination buffer */
    for (loopvar = 0u; loopvar < DMA_BUF_SIZE; loopvar++)
    {
        SrcDataBuf[loopvar]   = loopvar<<8;
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
        Src_List[i].pStartAddr            = (uintptr_t)&SrcDataBuf[i * DMA_WORDS_PER_DESC];
        Dest_List[i].pStartAddr           = (uintptr_t)&DestDataBuf[i * DMA_WORDS_PER_DESC];
#else
        Src_List[i].pStartAddr            = &SrcDataBuf[i * DMA_WORDS_PER_DESC];
        Dest_List[i].pStartAddr           = &DestDataBuf[i * DMA_WORDS_PER_DESC];
#endif

        /* DMA Config - only specify memory transfer size */
        Src_List[i].XCount                = (DMA_WORDS_PER_DESC);
        Src_List[i].XModify               = DMA_MSIZE_IN_BYTES;
        Src_List[i].Config                = ENUM_DMA_CFG_XCNT_INT;
        Src_List[i].YCount                = 0;
        Src_List[i].YModify               = 0;

        /* DMA Config - only specify memory transfer size */
        Dest_List[i].XCount               = (DMA_WORDS_PER_DESC);
        Dest_List[i].XModify              = DMA_MSIZE_IN_BYTES;
        Dest_List[i].Config               = ENUM_DMA_CFG_XCNT_INT;
        Dest_List[i].YCount               = 0;
        Dest_List[i].YModify              = 0;
        /* IF (End of list) */
        if (i >= (DMA_NUM_DESC-1u))
        {
        	Src_List[i].Config                = ENUM_DMA_CFG_XCNT_INT;
        	Dest_List[i].Config               = ENUM_DMA_CFG_XCNT_INT;
#if defined(__ADSPCORTEXA55__)
			Src_List[i].pNxtDscp = (uintptr_t)&Src_List[0];
			Dest_List[i].pNxtDscp = (uintptr_t)&Dest_List[0];
#else
			Src_List[i].pNxtDscp = &Src_List[0];
			Dest_List[i].pNxtDscp = &Dest_List[0];
#endif
        }
        /* ELSE (More descriptors in list) */
        else
        {
#if defined(__ADSPCORTEXA55__)
			Src_List[i].pNxtDscp  = (uintptr_t)&Src_List[i+1];
			Dest_List[i].pNxtDscp = (uintptr_t)&Dest_List[i+1];
#else
			Src_List[i].pNxtDscp  = &Src_List[i+1];
			Dest_List[i].pNxtDscp = &Dest_List[i+1];
#endif
        }
    }
}

int Sportinit(void)
{
    /* SPORT return code */
    ADI_SPORT_RESULT    eResult;


    eResult = adi_sport_Open(SPORT_DEVICE_0A,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory0,ADI_SPORT_MEMORY_SIZE,&hSPORTDev0ATx);
    CHECK_RESULT(eResult);
    eResult = adi_sport_Open(SPORT_DEVICE_0B,ADI_HALF_SPORT_B,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory1,ADI_SPORT_MEMORY_SIZE,&hSPORTDev0BRx);
    CHECK_RESULT(eResult);

    /* Prepare data buffers */
    PrepareDataBuffers();

    /* Prepare descriptors for memory copy using List mode */
    PrepareDescriptors();

    /* Submit the first buffer for Rx.  */
    eResult = adi_sport_DMATransfer(hSPORTDev0BRx,Dest_List,(DMA_NUM_DESC),ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
    CHECK_RESULT(eResult);

    /* Submit the first buffer for Tx.  */
    eResult = adi_sport_DMATransfer(hSPORTDev0ATx,Src_List,(DMA_NUM_DESC),ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	/* Register SPORT Callback function for DMA mode */
    CHECK_RESULT(eResult);
    eResult = adi_sport_RegisterCallback(hSPORTDev0BRx,
										SPORTCallbackRx,
										NULL);
    CHECK_RESULT(eResult);

    eResult = adi_sport_Enable(hSPORTDev0BRx,true);
    CHECK_RESULT(eResult);

    eResult = adi_sport_Enable(hSPORTDev0ATx,true);
    CHECK_RESULT(eResult);

    return 0;
}

void Pcginit(void)
{
	ClkConfig.bExternalTrigger=0;
	ClkConfig.eClkInput=ADI_PCG_CLK_CLKIN0;
	ClkConfig.nDiv=divd*4;


	FsConfig.bExternalTrigger=0;
	FsConfig.eClkInput=ADI_PCG_FS_CLKIN0;
	FsConfig.eFsBypassMode=ADI_PCG_FSBYPASS_MODE_NORMAL;
	FsConfig.nDiv=divd*256;
	FsConfig.nPhase=divd*2;
	FsConfig.nPulseWidth=divd*128;

	adi_pcg_Init(ADI_PCG_DEV_A,&ClkConfig,&FsConfig);

	ClkConfig1.bExternalTrigger=0;
	ClkConfig1.eClkInput=ADI_PCG_CLK_CLKIN0;
	ClkConfig1.nDiv=divd;

	adi_pcg_Init(ADI_PCG_DEV_B,&ClkConfig1,NULL);

}
int SpdifRxinit(void)
{
	ADI_SPDIF_RX_RESULT    eResult;

	eResult=adi_spdif_Rx_Open(0,SpdifRxMemory,ADI_SPDIF_RX_MEMORY_SIZE,&hSpdifRx);
    CHECK_RESULT(eResult);
	eResult=adi_spdif_Rx_Enable(hSpdifRx,true);
    CHECK_RESULT(eResult);
    return 0;

}


int SpdifTxinit(void)
{
	ADI_SPDIF_TX_RESULT    eResult;

	eResult=adi_spdif_Tx_Open(0,SpdifTxMemory,ADI_SPDIF_TX_MEMORY_SIZE,&hSpdifTx);
    CHECK_RESULT(eResult);
	eResult=adi_spdif_Tx_Enable(hSpdifTx,true);
    CHECK_RESULT(eResult);
    return 0;

}

int CheckBuffer(void)
{
	uint32_t offset=0;
	uint32_t i=0;
	uint32_t fail=0;
	for(i=0;i<DMA_BUF_SIZE;i++)
	{
		if(SrcDataBuf[i]==(DestDataBuf[0] & 0xffffff00))

			{offset=i;break;}
	}

	for( i=0;i<DMA_BUF_SIZE;i++)
	{
		if(SrcDataBuf[(i+offset)%DMA_BUF_SIZE]!=(DestDataBuf[i] & 0xffffff00))
		fail=1;
	}

	return fail;

}


int SpdifStop(void)
{
	ADI_SPDIF_TX_RESULT    eResult;
	ADI_SPDIF_RX_RESULT    Result;

	eResult=adi_spdif_Tx_Enable(hSpdifTx,false);
    CHECK_RESULT(eResult);

    Result=adi_spdif_Rx_Enable(hSpdifRx,false);
    CHECK_RESULT(Result);


	eResult=adi_spdif_Tx_Close(hSpdifTx);
    CHECK_RESULT(eResult);

    Result=adi_spdif_Rx_Close(hSpdifRx);
    CHECK_RESULT(Result);
    return 0;

}

int SportStop(void)
{
    /* SPORT return code */
    ADI_SPORT_RESULT    eResult;


	/* Begin adding your custom code here */
    eResult=adi_sport_StopDMATransfer(hSPORTDev0BRx);
    CHECK_RESULT(eResult);

    eResult=adi_sport_StopDMATransfer(hSPORTDev0ATx);
     CHECK_RESULT(eResult);

    eResult = adi_sport_Enable(hSPORTDev0BRx,false);
    CHECK_RESULT(eResult);

    eResult = adi_sport_Enable(hSPORTDev0ATx,false);
    CHECK_RESULT(eResult);

    eResult = adi_sport_Close(hSPORTDev0BRx);
    CHECK_RESULT(eResult);

    eResult = adi_sport_Close(hSPORTDev0ATx);
    CHECK_RESULT(eResult);
    return 0;

}

