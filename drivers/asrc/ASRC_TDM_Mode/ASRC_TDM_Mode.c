/*********************************************************************************
Copyright(c) 2021-2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/


/*****************************************************************************
 * ASRC_TDM_Mode.c
 *****************************************************************************/
#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "math.h"
#include <SRU.h>
#include <stdio.h>
#include <drivers/asrc/adi_asrc.h>
#include <assert.h>
#include <services/pcg/adi_pcg.h>
#include <drivers/sport/adi_sport.h>
#include <services/spu/adi_spu.h>
#include <services/dai/adi_dai.h>
#include "ASRC_TDM_Mode.h"

#define fs 96000
#define pi 3.14
#define f0 3000


/* ASRC handle */
ADI_ASRC_HANDLE  hAsrc[4] = {NULL,NULL,NULL,NULL};
/* SPORT handle */
ADI_SPORT_HANDLE hSportTx = NULL;
ADI_SPORT_HANDLE hSportRx = NULL;
/* SPU handle */
static ADI_SPU_HANDLE   ghSpu;

/* Memory required for the SPU operation */
uint8_t             SpuMemory[ADI_SPU_MEMORY_SIZE];
/* Memory required for the ASRC operation */
uint8_t gAsrcMem0[ADI_ASRC_MEMORY_SIZE];
uint8_t gAsrcMem1[ADI_ASRC_MEMORY_SIZE];
uint8_t gAsrcMem2[ADI_ASRC_MEMORY_SIZE];
uint8_t gAsrcMem3[ADI_ASRC_MEMORY_SIZE];
/* Memory required for the SPORT operation */
uint8_t gSportMemTx[ADI_SPORT_MEMORY_SIZE];
uint8_t gSportMemRx[ADI_SPORT_MEMORY_SIZE];

void Buffer_init(void);
static int SRC_init(void);
static int SPU_init(void);
void SRU_init(void);
void PCG_init(void);
static int Sport_init(void);

int main()
{
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
	
    /* making all the SPORT transactions as secure master */
    if(SPU_init() != SUCCESS)
    {
        REPORT_ERROR("Failed to initialize SPU\n");
    }

    /* Buffer Initialization*/
	Buffer_init();

	/* ASRC Initialization*/
	if(SRC_init() != SUCCESS)
	{
		REPORT_ERROR("Failed to initialize ASRC\n");
	}

	/* SRU Initialization*/
	SRU_init();

	/* Buffer Initialization*/
	PCG_init();

	/* SPORT Initialization*/
	if(Sport_init() != SUCCESS)
	{
		REPORT_ERROR("Failed to initialize SPORT\n");
	}

	DEBUG_INFORMATION("Normal Word Input Buffer Address for plots  = 0x%X\nNormal Word Output Buffer Address for plots  = 0x%X\n",(((int)(uintptr_t)(&InputBuffer))/0x04),((int)(uintptr_t)(&OutputBuffer))/0x04);
	DEBUG_INFORMATION("All done\n");
	DEBUG_INFORMATION("Reminder : Manual Check is a must.\n");
	
#ifndef AUTOTEST
	while(1);
#endif

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


void PCG_init()
{

#if (UPCONVERSION == 1)
	ADI_PCG_CLK_INFO gClkInfoB;
			gClkInfoB.eClkInput = ADI_PCG_CLK_SCLK0;               /* Clock Source */
			gClkInfoB.nDiv = OUTPUT_PCG_CLOCK_DIV;                 /* Clock Divisor */
			gClkInfoB.bExternalTrigger = false;                    /* External Trigger */


	ADI_PCG_FS_INFO gFsInfoB;
			gFsInfoB.eClkInput = ADI_PCG_FS_SCLK0;                               /* Clock Source */
			gFsInfoB.nDiv = (gClkInfoB.nDiv)*(ADI_SPORT0A_CTL_SLEN + 1)*(TDM_CHANNELS);     /* Frame Sync Divisor */
			gFsInfoB.nPulseWidth = (gFsInfoB.nDiv)/2;                            /* Pulse Width */
			gFsInfoB.nPhase = 0/*(gClkInfoB.nDiv)/2*/;                                /* Phase */
			gFsInfoB.bExternalTrigger = false;                                   /* External Trigger */
			gFsInfoB.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;               /* Bypass Mode */

	ADI_PCG_CLK_INFO gClkInfoA;
			gClkInfoA.eClkInput = ADI_PCG_CLK_SCLK0;               /* Clock Source */
			gClkInfoA.nDiv = (gClkInfoB.nDiv)*RATIO;               /* Clock Divisor */
			gClkInfoA.bExternalTrigger = false;                    /* External Trigger */

	ADI_PCG_FS_INFO gFsInfoA;
			gFsInfoA.eClkInput = ADI_PCG_FS_SCLK0;                 /* Clock Source */
			gFsInfoA.nDiv = (gFsInfoB.nDiv)*RATIO;                 /* Frame Sync Divisor */
			gFsInfoA.nPulseWidth = (gFsInfoA.nDiv)/2;              /* Pulse Width */
			gFsInfoA.nPhase = 0/*(gClkInfoA.nDiv)/2*/;                  /* Phase */
			gFsInfoA.bExternalTrigger = false;                     /* External Trigger */
			gFsInfoA.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL; /* Bypass Mode */
#elif (UPCONVERSION == 0)
			ADI_PCG_CLK_INFO gClkInfoA;
					gClkInfoA.eClkInput = ADI_PCG_CLK_SCLK0;               /* Clock Source */
					gClkInfoA.nDiv = INPUT_PCG_CLOCK_DIV;                 /* Clock Divisor */
					gClkInfoA.bExternalTrigger = false;                    /* External Trigger */


			ADI_PCG_FS_INFO gFsInfoA;
					gFsInfoA.eClkInput = ADI_PCG_FS_SCLK0;                               /* Clock Source */
					gFsInfoA.nDiv = (gClkInfoA.nDiv)*(ADI_SPORT0A_CTL_SLEN + 1)*(TDM_CHANNELS);     /* Frame Sync Divisor */
					gFsInfoA.nPulseWidth = (gFsInfoA.nDiv)/2;                            /* Pulse Width */
					gFsInfoA.nPhase = 0/*(gClkInfoA.nDiv)/2*/;                                /* Phase */
					gFsInfoA.bExternalTrigger = false;                                   /* External Trigger */
					gFsInfoA.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;               /* Bypass Mode */

			ADI_PCG_CLK_INFO gClkInfoB;
					gClkInfoB.eClkInput = ADI_PCG_CLK_SCLK0;               /* Clock Source */
					gClkInfoB.nDiv = (gClkInfoA.nDiv)*RATIO;               /* Clock Divisor */
					gClkInfoB.bExternalTrigger = false;                    /* External Trigger */

			ADI_PCG_FS_INFO gFsInfoB;
					gFsInfoB.eClkInput = ADI_PCG_FS_SCLK0;                 /* Clock Source */
					gFsInfoB.nDiv = (gFsInfoA.nDiv)*RATIO;                 /* Frame Sync Divisor */
					gFsInfoB.nPulseWidth = (gFsInfoB.nDiv)/2;              /* Pulse Width */
					gFsInfoB.nPhase = 0;                  /* Phase */
					gFsInfoB.bExternalTrigger = false;                     /* External Trigger */
					gFsInfoB.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL; /* Bypass Mode */

#endif

			adi_pcg_Init(ADI_PCG_DEV_A,&gClkInfoA,&gFsInfoA);

			adi_pcg_Init(ADI_PCG_DEV_B,&gClkInfoB,&gFsInfoB);

}


static int SRC_init()
{

	ADI_ASRC_RESULT eAsrcResult = ADI_ASRC_FAILED;

	eAsrcResult = adi_asrc_Open(0u, /* Block number */
								0u, /* Device number */
								gAsrcMem0, /* Pointer to Memory */
								ADI_ASRC_MEMORY_SIZE, /* Memory Size */
								&hAsrc[0]);
	if(eAsrcResult != ADI_ASRC_SUCCESS)
	{
		REPORT_ERROR("Failed to Open ASRC  0x%08X\n", eAsrcResult);
		return FAILED;
	}

	eAsrcResult = adi_asrc_Open(0u, /* Block number */
								1u, /* Device number */
								gAsrcMem1, /* Pointer to Memory */
								ADI_ASRC_MEMORY_SIZE, /* Memory Size */
								&hAsrc[1]);
	if(eAsrcResult != ADI_ASRC_SUCCESS)
	{
		REPORT_ERROR("Failed to Open ASRC  0x%08X\n", eAsrcResult);
		return FAILED;
	}

	eAsrcResult = adi_asrc_Open(0u, /* Block number */
								2u, /* Device number */
								gAsrcMem2, /* Pointer to Memory */
								ADI_ASRC_MEMORY_SIZE, /* Memory Size */
								&hAsrc[2]);
	if(eAsrcResult != ADI_ASRC_SUCCESS)
	{
		REPORT_ERROR("Failed to Open ASRC  0x%08X\n", eAsrcResult);
		return FAILED;
	}

	eAsrcResult = adi_asrc_Open(0u, /* Block number */
								3u, /* Device number */
								gAsrcMem3, /* Pointer to Memory */
								ADI_ASRC_MEMORY_SIZE, /* Memory Size */
								&hAsrc[3]);
	if(eAsrcResult != ADI_ASRC_SUCCESS)
	{
		REPORT_ERROR("Failed to Open ASRC  0x%08X\n", eAsrcResult);
		return FAILED;
	}

	eAsrcResult = adi_asrc_Enable(hAsrc[0],true);
	if(eAsrcResult != ADI_ASRC_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable ASRC  0x%08X\n", eAsrcResult);
		return FAILED;
	}


	eAsrcResult = adi_asrc_Enable(hAsrc[1],true);
	if(eAsrcResult != ADI_ASRC_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable ASRC  0x%08X\n", eAsrcResult);
		return FAILED;
	}


	eAsrcResult = adi_asrc_Enable(hAsrc[2],true);
	if(eAsrcResult != ADI_ASRC_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable ASRC  0x%08X\n", eAsrcResult);
		return FAILED;
	}

	eAsrcResult = adi_asrc_Enable(hAsrc[3],true);
	if(eAsrcResult != ADI_ASRC_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable ASRC  0x%08X\n", eAsrcResult);
		return FAILED;
	}

	return SUCCESS;

}

void SRU_init(void)
{

	*pREG_PADS0_DAI0_IE=0x1ffffE;
	*pREG_PADS0_DAI1_IE=0x1ffffE;

	/* Output Frame Sync */
	SRU(PCG0_FSB_O,SPT0_BFS_I);
	SRU(PCG0_FSB_O,SRC0_FS_OP_I);
	SRU(PCG0_FSB_O,SRC1_FS_OP_I);
	SRU(PCG0_FSB_O,SRC2_FS_OP_I);
	SRU(PCG0_FSB_O,SRC3_FS_OP_I);

    /* Output Clock */
	SRU(PCG0_CLKB_O,SPT0_BCLK_I);
	SRU(PCG0_CLKB_O, SRC0_CLK_OP_I);
	SRU(PCG0_CLKB_O, SRC1_CLK_OP_I);
	SRU(PCG0_CLKB_O, SRC2_CLK_OP_I);
	SRU(PCG0_CLKB_O, SRC3_CLK_OP_I);

    /* Frame Sync Input */
   SRU(PCG0_FSA_O,SPT0_AFS_I);
   SRU(PCG0_FSA_O,SRC0_FS_IP_I);
   SRU(PCG0_FSA_O,SRC1_FS_IP_I);
   SRU(PCG0_FSA_O,SRC2_FS_IP_I);
   SRU(PCG0_FSA_O,SRC3_FS_IP_I);

    /* Clock Input */
   SRU(PCG0_CLKA_O,SPT0_ACLK_I);
   SRU(PCG0_CLKA_O, SRC0_CLK_IP_I);
   SRU(PCG0_CLKA_O, SRC1_CLK_IP_I);
   SRU(PCG0_CLKA_O, SRC2_CLK_IP_I);
   SRU(PCG0_CLKA_O, SRC3_CLK_IP_I);

   /* Input Data Daisy Chaining */
   SRU (SPT0_AD0_O, SRC0_DAT_IP_I);
   SRU (SRC0_TDM_IP_O,SRC1_DAT_IP_I);
   SRU (SRC1_TDM_IP_O, SRC2_DAT_IP_I) ;
   SRU (SRC2_TDM_IP_O, SRC3_DAT_IP_I) ;

    /* Output Data Daisy Chaining */
	SRU (LOW, SRC0_TDM_OP_I) ;
	SRU (SRC0_DAT_OP_O, SRC1_DAT_TDM_OP_I) ;
	SRU (SRC1_DAT_OP_O, SRC2_DAT_TDM_OP_I) ;
	SRU (SRC2_DAT_OP_O, SRC3_DAT_TDM_OP_I) ;
	SRU (SRC3_DAT_OP_O, SPT0_BD0_I);



}

static int Sport_init()
{

    /* SPORT return code */
	ADI_SPORT_RESULT    eResult;

	 ADI_PDMA_DESC_LIST TxDescList[1] =
	 {{
#if defined(__ADSPCORTEXA55__)
		 0u,
		 (uint32_t)(uintptr_t)&InputBuffer[0],
#else
		 NULL,
		 &InputBuffer[0],
#endif
		 0,
		 CHANNEL_BUFF_SIZE*TDM_CHANNELS,
		 4,
		 0,
		 0
	 }};
	 ADI_PDMA_DESC_LIST RxDescList[1] =
	 {{
#if defined(__ADSPCORTEXA55__)
		 0u,
		 (uint32_t)(uintptr_t)&OutputBuffer[0],
#else
		 NULL,
		 &OutputBuffer[0],
#endif
		 0,
		 CHANNEL_BUFF_SIZE*TDM_CHANNELS,
		 4,
		 0,
		 0
	 }};

	eResult = adi_sport_Open(0,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX,ADI_SPORT_MC_MODE,gSportMemTx,ADI_SPORT_MEMORY_SIZE,&hSportTx);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to open SPORT Device 0x%08X\n", eResult);
		return FAILED;
	}

	eResult = adi_sport_Open(0,ADI_HALF_SPORT_B,ADI_SPORT_DIR_RX,ADI_SPORT_MC_MODE,gSportMemRx,ADI_SPORT_MEMORY_SIZE,&hSportRx);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to open SPORT Device 0x%08X\n", eResult);
		return FAILED;
	}

	eResult = adi_sport_DMATransfer(hSportRx,&RxDescList[0],1,ADI_PDMA_AUTOBUFFER_MODE,ADI_SPORT_CHANNEL_PRIM);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to read using SPORT DMA 0x%08X\n", eResult);
		return FAILED;
	}

	eResult = adi_sport_DMATransfer(hSportTx,&TxDescList[0],1,ADI_PDMA_AUTOBUFFER_MODE,ADI_SPORT_CHANNEL_PRIM);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to read using SPORT DMA 0x%08X\n", eResult);
		return FAILED;
	}

	eResult = adi_sport_Enable(hSportRx,true);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable SPORT Rx  0x%08X\n", eResult);
		return FAILED;
	}

	eResult = adi_sport_Enable(hSportTx,true);
	if (eResult != ADI_SPORT_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable SPORT Tx  0x%08X\n", eResult);
		return FAILED;
	}

	return SUCCESS;

}


void Buffer_init()
{

	int i,j = 0;
	int val = 0;
	float Omega0;

	Omega0 = 2*pi*f0/fs;
	for(i=0;i<CHANNEL_BUFF_SIZE;i++)
	{
		val = (sin(Omega0*i)*(0x7fffffff));
		for(j=0; j<TDM_CHANNELS; j++)
		{
			InputBuffer[(TDM_CHANNELS*i)+j] =val;
		}
	}
}

