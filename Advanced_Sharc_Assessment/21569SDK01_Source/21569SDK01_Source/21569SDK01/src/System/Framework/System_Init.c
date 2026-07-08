/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	System_Init.c
*  Description      :
*
******************************************************************************/
#pragma default_section(CODE,"Seg_System_Init_Code")
#include "..\src\system\Include\System_Init.h"

#ifdef SPDIF_ENABLE
void Spdif_Rx_ISR(int, void *);
extern int Spdif_fs_table[12];
#endif
/**************************************************************************************************
 *  Module Name        : System_Initialization
 *  Functionality      : call all system and hardware cfg functions (SPORT, DIA, SPI)
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
section("seg_kernal_code_l3")
void System_Initialization(void)
{
	*pREG_PADS0_DAI0_IE=0xc0fff;//0x1ffffe;//0x81fde;//0x1ffffe;//0x81ffe; //PADS Configuration register
	*pREG_PADS0_DAI1_IE=0xc0fff;//0x1ffffe;//0x181ffe;//0x1ffffe;//0x181ffe; //PADS Configuration register

	Init_Struct();
	
#ifdef ASRC_ENABLE
	FS_Div_Value = MCLK_48KHZ;
#endif
	FlagsConfigure();
	SPI_Init();
	Init_PORTs();
	Kernal_Default_Init();
    DAI_init();
    Init_SPI0();
#ifdef ASRC_ENABLE
   	SRC_init();
#endif
	PCG_init();

#if defined (USE_MDMA_EXTCHANNEL) || defined (TX_NEW_LOGIC)
	EXTMDMA_init();
#endif

	Sport_init();

	Default_Command_Config();

}


/******************************************************************************
 *  Module Name        : SPORT_Recongifuration
 *  Functionality      : SPORT_Recongifuration Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_kernal_code_l3")
void SPORT_Recongifuration()
{
#ifdef SPDIF_ENABLE
	if(Prev_SPDIF_Enable == 1)
	{
		SpdifRxStop();
	}
#endif

	 /* Clear global enable bit */
   adi_sport_GlobalEnable(false);

	 /* Destroy global groups */
	Clear_Global_Interrupt();

#ifdef SPDIF_ENABLE
	if(SPDIF_Enable == 0)
	{
#endif
		adi_sport_GlobalRegisterCallback(hDai0Group1Rx, NULL, NULL);   //clear Rx interrupt
#ifdef SPDIF_ENABLE
	}
#endif

	adi_sport_GlobalRegisterCallback(hDai1Group0Tx, NULL, NULL);   //clear tx interrupt

	adi_sport_DestroyGlobalGroup(hDai1Group0Tx);
	adi_sport_DestroyGlobalGroup(hDai0Group0Tx);

#ifdef SPDIF_ENABLE

	if(Prev_SPDIF_Enable == 1)
	{
		adi_sport_GlobalRegisterCallback(hDai1Group1Rx, NULL, NULL);   //clear Rx interrupt
		adi_sport_DestroyGlobalGroup(hDai1Group1Rx);
		adi_sport_Close(hSPORT5ARx);
		Prev_SPDIF_Enable = 0;
	}
	else
	{
		adi_sport_GlobalRegisterCallback(hDai0Group1Rx, NULL, NULL);   //clear Rx interrupt
		adi_sport_DestroyGlobalGroup(hDai0Group1Rx);
		adi_sport_Close(hSPORT0ARx);
		adi_sport_Close(hSPORT0BRx);
		adi_sport_Close(hSPORT1ARx);
		adi_sport_Close(hSPORT1BRx);
	}
	adi_sport_Close(hSPORT4ATx);
	adi_sport_Close(hSPORT4BTx);
	adi_sport_Close(hSPORT3ATx);
	adi_sport_Close(hSPORT3BTx);

#else
    adi_sport_GlobalRegisterCallback(hDai0Group1Rx, NULL, NULL);   //clear Rx interrupt
	adi_sport_DestroyGlobalGroup(hDai0Group1Rx);
	adi_sport_Close(hSPORT0ARx);
	adi_sport_Close(hSPORT0BRx);
	adi_sport_Close(hSPORT1ARx);
	adi_sport_Close(hSPORT1BRx);
#endif
	if(TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
	{
		adi_sport_Close(hSPORT2ATx);
	}
	if(TX_DAC_Output_Ch_Cnt == 3)
	{
		adi_sport_Close(hSPORT5BTx);
	}
	adi_sport_Close(hSPORT4ATx);
	adi_sport_Close(hSPORT4BTx);
	adi_sport_Close(hSPORT3ATx);
	adi_sport_Close(hSPORT3BTx);

 //  TX_Buf_Ptr_Allocation();
	 //Sport_init_Reconfig();
    DAI_init();
	Sport_init();
	
	TX_DAC_Channel_check();
#if 0 //def SPDIF_ENABLE
	if(SPDIF_Enable == 1)
	{
		int CLKDIV = 4;           //  default case FS2_FS1
        int CLKPHASE;

        CLKPHASE = ((3+CLKDIV/2)%CLKDIV);    //To synchronize 64*fs2 with fs1 and it's falling edge with fs2

		ADI_PCG_CLK_INFO gClkInfo_C;
				gClkInfo_C.eClkInput = ADI_PCG_CLK_EXT;      	      /* Clock Source */
				gClkInfo_C.nDiv = 0u;          					      /* Clock Divisor */
				gClkInfo_C.bExternalTrigger = false;                  /* External Trigger */
		ADI_PCG_FS_INFO gFsInfo_C;
				gFsInfo_C.eClkInput = ADI_PCG_FS_EXT;                     /* Clock Source */
				gFsInfo_C.nDiv = CLKDIV;     				              /* Frame Sync Divisor */
				gFsInfo_C.nPulseWidth = CLKDIV/2;                         /* Pulse Width */
				gFsInfo_C.nPhase = CLKPHASE;                              /* Phase */
				gFsInfo_C.bExternalTrigger = true;                        /* External Trigger */
				gFsInfo_C.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;   /* Bypass Mode */


		ADI_PCG_CLK_INFO gClkInfo_D;
				gClkInfo_D.eClkInput = ADI_PCG_CLK_EXT;      	/* Clock Source */
				gClkInfo_D.nDiv = 0u;          					/* Clock Divisor */
				gClkInfo_D.bExternalTrigger = false;            /* External Trigger */
		ADI_PCG_FS_INFO gFsInfo_D;
				gFsInfo_D.eClkInput = ADI_PCG_FS_EXT;                    /* Clock Source */
				gFsInfo_D.nDiv = 64*CLKDIV;     				         /* Frame Sync Divisor */
				gFsInfo_D.nPulseWidth = 32*CLKDIV;                       /* Pulse Width */
				gFsInfo_D.nPhase = FSPHASE;                              /* Phase */
				gFsInfo_D.bExternalTrigger = true;                       /* External Trigger */
				gFsInfo_D.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;  /* Bypass Mode */


		adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo_C,&gFsInfo_C);
		adi_pcg_Init(ADI_PCG_DEV_D,&gClkInfo_D,&gFsInfo_D);
	}
	else
	{
		ADI_PCG_CLK_INFO gClkInfo;
				gClkInfo.eClkInput = ADI_PCG_CLK_EXT;              		/* Clock Source */
				gClkInfo.nDiv = 8u;                                 	/* Clock Divisor */
				gClkInfo.bExternalTrigger = false;                      /* External Trigger */

		ADI_PCG_FS_INFO gFsInfo;
				gFsInfo.eClkInput = ADI_PCG_CLK_EXT;                	/* Clock Source */
				gFsInfo.nDiv = 512u;                                    /* Frame Sync Divisor */
				gFsInfo.nPulseWidth = (gFsInfo.nDiv)/2u;               /* Pulse Width */
				gFsInfo.nPhase = gClkInfo.nDiv/2;                      /* Phase */
				gFsInfo.bExternalTrigger = false;                      /* External Trigger */
				gFsInfo.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;  /* Bypass Mode */

	   adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo,&gFsInfo);
   }
//#else
	ADI_PCG_CLK_INFO gClkInfo;
			gClkInfo.eClkInput = ADI_PCG_CLK_EXT;              		/* Clock Source */
			gClkInfo.nDiv = 8u;                                 	/* Clock Divisor */
			gClkInfo.bExternalTrigger = false;                      /* External Trigger */

	ADI_PCG_FS_INFO gFsInfo;
			gFsInfo.eClkInput = ADI_PCG_CLK_EXT;                	/* Clock Source */
			gFsInfo.nDiv = 512u;                                    /* Frame Sync Divisor */
			gFsInfo.nPulseWidth = (gFsInfo.nDiv)/2u;               /* Pulse Width */
			gFsInfo.nPhase = gClkInfo.nDiv/2;                      /* Phase */
			gFsInfo.bExternalTrigger = false;                      /* External Trigger */
			gFsInfo.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;  /* Bypass Mode */

   adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo,&gFsInfo);
#endif

#ifdef ASRC_ENABLE
   if(ASRC_Enable == 1)
   {
	   Asrc_SRU_Reconfigure();
   }
#endif

	/* Set global enable bit */
	adi_sport_GlobalEnable(true);
	Set_Global_Interrupt();
}

/**************************************************************************************************
 *  Module Name        : Set Priority
 *  Functionality      : Set priority of SPI and SPORT DMA interrupts
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/

void Set_Priority()
{
	adi_sec_SetPriority(INTR_SPI0_RXDMA,0);
#ifdef SPDIF_ENABLE
	if(SPDIF_Enable == 1)
	{
		adi_sec_SetPriority(INTR_DAI1_IRQH,1);
	}
	else
	{
		adi_sec_SetPriority(INTR_DAI0_IRQH,1);
	}
#else
	adi_sec_SetPriority(INTR_DAI0_IRQH,1);
#endif

	adi_sec_SetPriority(INTR_SYS_MDMA0_DST,1);

#ifdef SPDIF_ENABLE
	if(SPDIF_Enable == 1)
	{
		adi_sec_SetPriority(INTR_DAI1_GBL_SPORT_INT1,2);  // For SPDIF Receiver
	}
#endif

	adi_sec_SetPriority(INTR_DAI0_GBL_SPORT_INT0,2);  //Rx_Dai0_Group0
	adi_sec_SetPriority(INTR_DAI1_GBL_SPORT_INT0,2);  //Tx_Dai1_Group0
}

/**************************************************************************************************
 *  Module Name        : Default_Command_Config
 *  Functionality      : default kernel run flag set to 1
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
section("seg_kernal_code_l3")
void Default_Command_Config()
{
	Frmwk.run_flag=1;

}

/**************************************************************************************************
 *  Module Name        : Kernal_Default_Init
 *  Functionality      : Kernal_Default_Initialazation (Memory allocation, predac, pack & lpc delay buffer
 *  					 Security bit set as per Sport cfg)
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
section("seg_kernal_code_l3")
void Kernal_Default_Init()
{

	Frmwk.autodetect_mode=FORCEPCM3;//AUTODETECT1; //FORCEPCM3
	AllocateMemoryKernel();

	Free_AllotMemoryPackDac( Frmwk.pack_length_pcm, Frmwk.predac_length_pcm, 1);

#ifdef PCM_DEC
	Frmwk.LPCMDelaySize = Frmwk.LPCMDelaySize_host+(Frmwk.SampleBlock*2);	//(4096samples*2ch*32bit)
	Frmwk.PrevLPCMDelaySize_host = Frmwk.LPCMDelaySize_host;

	I_CCALL_1ARG_(AllocateMemoryPCMDelay, Frmwk.LPCMDelaySize);
#endif

    SpuInit();

#ifdef EMDMA
	*pREG_SPU0_SECUREP112=BITM_SPU_SECUREP_MSEC;
#endif
}

/**************************************************************************************************
 *  Module Name        : Enable_Cache
 *  Functionality      : Enable_Cache memory with size of
 *  					 PM cache = 0.25 Mbits
 *  					 DM cache = 1 Mbits
 *  					 I cache = 0.5 Mbits
 *  					 cache_able and non cache_able memory region by using Range register
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
section("seg_int_code")
void Enable_Cache(void)

{

	//*pREG_SHL1C0_CFG |= 0x00404040;  // 0.25 Mbits--PM cache , 1 Mbits--DM cache, 0.5 Mbits--I cache
	// NOP10;NOP10;NOP10;NOP;NOP;NOP;//33 NOPS

#ifndef CACHE_EN
	*pREG_SHL1C_CFG2 |= 0x3cc0;
	 NOP10; NOP10; NOP10; NOP1; NOP1; NOP1;//33 NOPS

	/* Range register 0 to 4 is RESERVED */

	// Non Cacheable region In L1 Memory
	*pREG_SHL1C_RANGE_START3 = 0x28240000;
	 NOP10;NOP10;
	*pREG_SHL1C_RANGE_END3 =  0x2838FFFF;
	 NOP10;NOP10;

	// Non Cacheable region In L2 Memory (Pack buffer)
	*pREG_SHL1C_RANGE_START5 = 0x200D9f00;
	 NOP10;NOP10;
	*pREG_SHL1C_RANGE_END5 =  0x200f9fff;
	 NOP10;NOP10;

	// Non Cacheable region In DDR0 (PREDAC buffer)
	*pREG_SHL1C_RANGE_START6=0x80600000;
	 NOP10;NOP10;

	*pREG_SHL1C_RANGE_END6=0x806fffff;
	 NOP10;NOP10;

#endif


}

/**************************************************************************************************
 *  Module Name        : SPI_Init
 *  Functionality      : SPI  receiver buffer initialization
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
section("seg_kernal_code_l3")
void SPI_Init(void)
{
	Frmwk.Spi.SPIReceiveTempBuf  	= &Spi_size;
	Frmwk.Spi.SPIReceiveTempBufPtr 	= &Spi_size;
	Frmwk.Spi.SPIReceivebufsize 	= SPI_BUFFER_SIZE;
}

/**************************************************************************************************
 *  Module Name        : TRU_init (Not used)
 *  Functionality      : Based on Master event status slave triggered
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
section("seg_kernal_code_l3")
void TRU_init()
{
	*pREG_TRU0_GCTL  = ((1  << BITP_TRU_GCTL_EN) & BITM_TRU_GCTL_EN);
	*pREG_TRU0_SSR16 = ((67 << BITP_TRU_SSR_SSR) & BITM_TRU_SSR_SSR);
	*pREG_TRU0_SSR17 = ((67 << BITP_TRU_SSR_SSR) & BITM_TRU_SSR_SSR);
	*pREG_TRU0_SSR18 = ((67 << BITP_TRU_SSR_SSR) & BITM_TRU_SSR_SSR);
	*pREG_TRU0_SSR19 = ((67 << BITP_TRU_SSR_SSR) & BITM_TRU_SSR_SSR);
}


/**************************************************************************************************
 *  Module Name        : DAI_init
 *  Functionality      : Interface between process and hardware.Configured DAI pins for inputs & outputs
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
section("Seg_System_Init_Code")
void  DAI_init()
{
/****************************************************Receiver DAI configuration******************************************************************/
#ifdef SPDIF_ENABLE
	if(SPDIF_Enable == 1)
	{
		SRU2(LOW,DAI1_PBEN19_I);
		SRU2(DAI1_PB19_O,SPDIF1_RX_I);

		SRU2(SPDIF1_RX_FS_O,SPT5_AFS_I);
		SRU2(SPDIF1_RX_CLK_O,SPT5_ACLK_I);
		SRU2(SPDIF1_RX_DAT_O,SPT5_AD0_I);

		//Route SPDIF RX FS to DAI1 pin 12
		SRU2(HIGH,DAI1_PBEN20_I);
		SRU2(SPDIF1_RX_FS_O,DAI1_PB20_I);

		/**************************** PCGC and PCGD  ********************************/

		//PCGC generates BCLK 64*fs2 with SPDIF MCLK as input and LRCLK as trigger source
		SRU2(SPDIF1_RX_TDMCLK_O,PCG0_EXTCLKC_I);
		SRU2(SPDIF1_RX_TDMCLK_O,PCG0_EXTCLKD_I);

		SRU2(DAI1_PB20_O,PCG0_SYNC_CLKC_I);
		SRU2(DAI1_PB20_O,PCG0_SYNC_CLKD_I);

	   //Connect PCG FSC (64*fs2) output to DAI1 pin 3
		SRU2(HIGH,DAI1_PBEN03_I);
		SRU2(PCG0_FSC_O,DAI1_PB03_I);

	   //Connect PCG FSD (fs2) output to DAI1 pin 4
		SRU2(HIGH,DAI1_PBEN04_I);
		SRU2(PCG0_FSD_O,DAI1_PB04_I);
	}
	else
#endif
	{
		SRU2(LOW,DAI1_PBEN01_I);
		SRU2(LOW,DAI1_PBEN02_I);

		SRU(LOW,DAI0_PBEN06_I);          //RX_I2S_BCLK
		SRU(LOW,DAI0_PBEN07_I);          //RX_I2S_LRCLK

		SRU(DAI0_PB06_O,SPT0_ACLK_I);
		SRU(DAI0_PB06_O,SPT0_BCLK_I);
		SRU(DAI0_PB06_O,SPT1_ACLK_I);
		SRU(DAI0_PB06_O,SPT1_BCLK_I);

		SRU(DAI0_PB07_O,SPT0_AFS_I);
		SRU(DAI0_PB07_O,SPT0_BFS_I);
		SRU(DAI0_PB07_O,SPT1_AFS_I);
		SRU(DAI0_PB07_O,SPT1_BFS_I);

		SRU(LOW,DAI0_PBEN08_I);
		SRU(LOW,DAI0_PBEN09_I);
		SRU(LOW,DAI0_PBEN10_I);
		SRU(LOW,DAI0_PBEN11_I);

		SRU(DAI0_PB08_O,SPT0_AD0_I);	//SPORT0A RX
		SRU(DAI0_PB09_O,SPT0_BD0_I);	//SPORT0B RX
		SRU(DAI0_PB10_O,SPT1_AD0_I);	//SPORT1A RX
		SRU(DAI0_PB11_O,SPT1_BD0_I);	//SPORT1B RX
	}

/****************************************************Transmitter DAI configuration******************************************************************/
	if(I2S_TDM_MODE == I2S_MODE)
	{
		SRU2(HIGH,DAI1_PBEN08_I);
		SRU2(HIGH,DAI1_PBEN09_I);
		SRU2(HIGH,DAI1_PBEN10_I);
		SRU2(HIGH,DAI1_PBEN11_I);
		SRU(HIGH,DAI0_PBEN01_I);
        SRU(HIGH,DAI0_PBEN02_I);
		SRU(HIGH,DAI0_PBEN12_I);
		SRU(HIGH,DAI0_PBEN19_I);

		SRU2(HIGH,DAI1_PBEN03_I);             //TX_I2S_BCLK
		SRU2(HIGH,DAI1_PBEN04_I);             //TX_I2S_LRCLK
		SRU2(LOW,DAI1_PBEN07_I);              //DAI 1 Pin 07 is connected with MCLK In pin of AD1939 Codec

		if(SPDIF_Enable == 0)
		{
			SRU2(PCG0_CLKC_O,DAI1_PB03_I);
			SRU2(PCG0_FSC_O,DAI1_PB04_I);
		}
		SRU2(HIGH,DAI1_PBEN12_I);

#ifdef  SPDIF_ENABLE
		if(SPDIF_Enable == 1)
     	{
           SRU2(SPDIF1_RX_TDMCLK_O,DAI1_PB12_I);
		}
		else
#endif
		{
		   SRU2(DAI1_PB07_O,DAI1_PB12_I);
		}

		SRU2(DAI1_PB12_O,PCG0_EXTCLKC_I);     // MCLK to PCG C

		if(TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
		{
			SRU(DAI0_CRS_PB03_O,SPT2_ACLK_I);	//SPORT2A TX
		}

		if(TX_DAC_Output_Ch_Cnt == 3)
		{
			SRU2(DAI1_PB03_O,SPT5_BCLK_I);		//SPORT5B TX
		}

		SRU2(DAI1_PB03_O,SPT4_ACLK_I);		//SPORT4A TX
		SRU2(DAI1_PB03_O,SPT4_BCLK_I);		//SPORT4B TX
		SRU(DAI0_CRS_PB03_O,SPT3_ACLK_I); 	//SPORT3A TX
		SRU(DAI0_CRS_PB03_O,SPT3_BCLK_I); 	//SPORT3B TX

		if(TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
		{
			SRU(DAI0_CRS_PB04_O,SPT2_AFS_I);	//SPORT2A TX
		}

		if(TX_DAC_Output_Ch_Cnt == 3)
		{
			SRU2(DAI1_PB04_O,SPT5_BFS_I);		//SPORT5B TX
		}

		SRU2(DAI1_PB04_O,SPT4_AFS_I);		//SPORT4A TX
		SRU2(DAI1_PB04_O,SPT4_BFS_I);		//SPORT4B TX
		SRU(DAI0_CRS_PB04_O,SPT3_AFS_I);	//SPORT3A TX
		SRU(DAI0_CRS_PB04_O,SPT3_BFS_I);	//SPORT3B TX

		if(TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
		{
			SRU(HIGH,DAI0_PBEN03_I);
			SRU(HIGH,DAI0_PBEN04_I);
		}

		if(TX_DAC_Output_Ch_Cnt == 3)
		{
			SRU2(HIGH,DAI1_PBEN01_I);
			SRU2(HIGH,DAI1_PBEN02_I);
		}

		SRU2(SPT4_AD0_O,DAI1_PB08_I);	//SPORT4A_D0 TX
		SRU2(SPT4_AD1_O,DAI1_PB09_I);	//SPORT4A_D1 TX

		SRU2(SPT4_BD0_O,DAI1_PB10_I);	//SPORT4B_D0 TX
		SRU2(SPT4_BD1_O,DAI1_PB11_I);	//SPORT4B_D1 TX

		SRU(SPT3_AD0_O,DAI0_PB01_I);	//SPORT3A_D0 TX
		SRU(SPT3_AD1_O,DAI0_PB02_I);	//SPORT3A_D1 TX

		SRU(SPT3_BD0_O,DAI0_PB12_I);	//SPORT3B_D0 TX
		SRU(SPT3_BD1_O,DAI0_PB19_I);	//SPORT3B_D1 TX

		if(TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
		{
			SRU(SPT2_AD0_O,DAI0_PB03_I);	//SPORT2A_D0 TX
			SRU(SPT2_AD1_O,DAI0_PB04_I);	//SPORT2A_D1 TX
		}

		if(TX_DAC_Output_Ch_Cnt == 3)
		{
			SRU2(SPT5_BD0_O,DAI1_PB01_I);	//SPORT5B_D0 TX
			SRU2(SPT5_BD1_O,DAI1_PB02_I);	//SPORT5B_D1 TX
		}

	}
	/*else if(I2S_TDM_MODE == TDM_MODE)
	{
		SRU2(HIGH,DAI1_PBEN08_I);
		SRU2(LOW,DAI1_PBEN09_I);
		SRU2(LOW,DAI1_PBEN10_I);
		SRU2(LOW,DAI1_PBEN11_I);
		SRU(HIGH,DAI0_PBEN01_I);
        SRU(LOW,DAI0_PBEN02_I);
		SRU(LOW,DAI0_PBEN12_I);
		SRU(LOW,DAI0_PBEN19_I);


		SRU2(HIGH,DAI1_PBEN03_I);             //TX_I2S_BCLK
		SRU2(HIGH,DAI1_PBEN04_I);             //TX_I2S_LRCLK
#ifdef SPORT_TDM_24_CHANNEL
		SRU(HIGH,DAI0_PBEN03_I);
#endif*/

		SRU2(LOW,DAI1_PBEN07_I);              //DAI 1 Pin 07 is connected with MCLK In pin of AD1939 Codec
		if(SPDIF_Enable == 0)
		{
			SRU2(PCG0_CLKC_O,DAI1_PB03_I);
			SRU2(PCG0_FSC_O,DAI1_PB04_I);
		}
			SRU2(HIGH,DAI1_PBEN12_I);
#ifdef  SPDIF_ENABLE
		if(SPDIF_Enable == 1)
     	{
           SRU2(SPDIF1_RX_TDMCLK_O,DAI1_PB12_I);
		}
		else
#endif
		{
		   SRU2(DAI1_PB07_O,DAI1_PB12_I);
		}


		SRU2(DAI1_PB12_O,PCG0_EXTCLKC_I);     // MCLK to PCG C


		SRU2(DAI1_PB03_O,SPT4_ACLK_I);		//SPORT4A TX
		SRU(DAI0_CRS_PB03_O,SPT3_ACLK_I); 	//SPORT3A TX
		SRU2(DAI1_PB04_O,SPT4_AFS_I);		//SPORT4A TX
		SRU(DAI0_CRS_PB04_O,SPT3_AFS_I);	//SPORT3A TX
#ifdef SPORT_TDM_24_CHANNEL
		SRU(DAI0_CRS_PB03_O,SPT2_ACLK_I); 	//SPORT3A TX
		SRU(DAI0_CRS_PB04_O,SPT2_AFS_I);	//SPORT3A TX
#endif

		SRU2(SPT4_AD0_O,DAI1_PB08_I);	//SPORT4A_D0 TX
		SRU(SPT3_AD0_O,DAI0_PB01_I);	//SPORT3A_D0 TX

#ifdef SPORT_TDM_24_CHANNEL
		SRU(SPT2_AD0_O,DAI0_PB03_I);	//SPORT3A_D0 TX
#endif
	//}

	if((I2S_TDM_MODE == ASRC_MODE))
		{

			if(SPDIF_Enable == 1)
			{
				ASRC_SPDIF_DAI_Init();
			}
			else
			{
				ASRC_DAI_Init();
			}

		}



	PCG_init();
}

/**************************************************************************************************
 *  Module Name        : PrepareRxDescriptors
 *  Functionality      : Configuration SPORT Registers for Receiver & transmitter
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
section("seg_kernal_code_l3")
static void PrepareRxDescriptors (ADI_PDMA_DESC_LIST* pDmaDescList1, ADI_PDMA_DESC_LIST* pDmaDescList2, void* Buf1, void* Buf2, uint8_t XCount, uint8_t XMod)
{
	pDmaDescList1->pStartAddr = (uint32_t*)((uint32_t)Buf1|MP_OFFSET);
	pDmaDescList1->pNxtDscp = pDmaDescList2;
	pDmaDescList1->XCount = XCount;
	pDmaDescList1->XModify = XMod;
	pDmaDescList1->Config = ENUM_DMA_CFG_XCNT_TRIG;

	pDmaDescList2->pStartAddr = (uint32_t*)((uint32_t)Buf2|MP_OFFSET);
	pDmaDescList2->pNxtDscp = pDmaDescList1;
	pDmaDescList2->XCount = XCount;
	pDmaDescList2->XModify = XMod;
	pDmaDescList2->Config = ENUM_DMA_CFG_XCNT_TRIG;
}


/**************************************************************************************************
 *  Module Name        : PrepareTxDescriptors
 *  Functionality      : Configuration SPORT Registers for Receiver & transmitter
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/

section("seg_kernal_code_l3")
static void PrepareTxDescriptors (ADI_PDMA_DESC_LIST* pDmaDescList1, ADI_PDMA_DESC_LIST* pDmaDescList2, void* Buf1, void* Buf2, uint8_t XCount, uint8_t XMod)
{
	pDmaDescList1->pStartAddr = (uint32_t*)((uint32_t)Buf1|MP_OFFSET);
	pDmaDescList1->pNxtDscp = pDmaDescList2;
	pDmaDescList1->XCount = XCount;
	pDmaDescList1->XModify = XMod;

	pDmaDescList2->pStartAddr = (uint32_t*)((uint32_t)Buf2|MP_OFFSET);
	pDmaDescList2->pNxtDscp = pDmaDescList1;
	pDmaDescList2->XCount = XCount;
	pDmaDescList2->XModify = XMod;
}

/**************************************************************************************************
 *  Module Name        : Sport_init
 *  Functionality      : Configuration SPORT Registers for Receiver & transmitter
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
section("seg_kernal_code_l3")
void Sport_init()
{
	ADI_SPORT_RESULT Result;

#ifdef SPDIF_ENABLE
	if(SPDIF_Enable == 1)
	{
		SpdifRxInit();
		Result = adi_sport_Open(5,ADI_HALF_SPORT_A,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory5A,ADI_SPORT_MEMORY_SIZE,&hSPORT5ARx);
	}
	else
	{
		Result = adi_sport_Open(0,ADI_HALF_SPORT_A,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory0A,ADI_SPORT_MEMORY_SIZE,&hSPORT0ARx);
		Result = adi_sport_Open(0,ADI_HALF_SPORT_B,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory0B,ADI_SPORT_MEMORY_SIZE,&hSPORT0BRx);
		Result = adi_sport_Open(1,ADI_HALF_SPORT_A,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory1A,ADI_SPORT_MEMORY_SIZE,&hSPORT1ARx);
		Result = adi_sport_Open(1,ADI_HALF_SPORT_B,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory1B,ADI_SPORT_MEMORY_SIZE,&hSPORT1BRx);
	}
#else
	Result = adi_sport_Open(0,ADI_HALF_SPORT_A,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory0A,ADI_SPORT_MEMORY_SIZE,&hSPORT0ARx);
	Result = adi_sport_Open(0,ADI_HALF_SPORT_B,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory0B,ADI_SPORT_MEMORY_SIZE,&hSPORT0BRx);
	Result = adi_sport_Open(1,ADI_HALF_SPORT_A,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory1A,ADI_SPORT_MEMORY_SIZE,&hSPORT1ARx);
	Result = adi_sport_Open(1,ADI_HALF_SPORT_B,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory1B,ADI_SPORT_MEMORY_SIZE,&hSPORT1BRx);
#endif

	Result = adi_sport_Open(4,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory4A,ADI_SPORT_MEMORY_SIZE,&hSPORT4ATx);
	Result = adi_sport_Open(4,ADI_HALF_SPORT_B,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory4B,ADI_SPORT_MEMORY_SIZE,&hSPORT4BTx);
	Result = adi_sport_Open(3,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory3A,ADI_SPORT_MEMORY_SIZE,&hSPORT3ATx);
	Result = adi_sport_Open(3,ADI_HALF_SPORT_B,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory3B,ADI_SPORT_MEMORY_SIZE,&hSPORT3BTx);
	if(TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
	{
		Result = adi_sport_Open(2,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory2A,ADI_SPORT_MEMORY_SIZE,&hSPORT2ATx);
	}
	if(TX_DAC_Output_Ch_Cnt == 3)
	{
		Result = adi_sport_Open(5,ADI_HALF_SPORT_B,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory5B,ADI_SPORT_MEMORY_SIZE,&hSPORT5BTx);
	}  

	
#ifdef SPDIF_ENABLE
	if(SPDIF_Enable == 1)
	{
		PrepareRxDescriptors(&iSRC_LIST_1_SP5A, &iSRC_LIST_2_SP5A, &RX_SP0A_BUFFER_LR0[0], &RX_SP0A_BUFFER_LR1[0], 64, 4);
		iSRC_LIST_1_SP5A.Config |= ENUM_DMA_CFG_XCNT_INT;
		iSRC_LIST_2_SP5A.Config |= ENUM_DMA_CFG_XCNT_INT;
	}
	else
	{
     	PrepareRxDescriptors(&iSRC_LIST_1_SP0A, &iSRC_LIST_2_SP0A, &RX_SP0A_BUFFER_LR0[0], &RX_SP0A_BUFFER_LR1[0], 64, 4);
		PrepareRxDescriptors(&iSRC_LIST_3_SP0B, &iSRC_LIST_4_SP0B, &RX_SP0B_BUFFER_CSW0[0], &RX_SP0B_BUFFER_CSW1[0], 64, 4);
		PrepareRxDescriptors(&iSRC_LIST_5_SP1A, &iSRC_LIST_6_SP1A, &RX_SP1A_BUFFER_LsRs0[0], &RX_SP1A_BUFFER_LsRs1[0], 64, 4);
		PrepareRxDescriptors(&iSRC_LIST_7_SP1B, &iSRC_LIST_8_SP1B, &RX_SP1B_BUFFER_LsrRsr0[0], &RX_SP1B_BUFFER_LsrRsr1[0], 64, 4);

		iSRC_LIST_1_SP0A.Config |= ENUM_DMA_CFG_XCNT_INT;
		iSRC_LIST_2_SP0A.Config |= ENUM_DMA_CFG_XCNT_INT;
		iSRC_LIST_3_SP0B.Config |= ENUM_DMA_CFG_XCNT_INT;
		iSRC_LIST_4_SP0B.Config |= ENUM_DMA_CFG_XCNT_INT;
		iSRC_LIST_5_SP1A.Config |= ENUM_DMA_CFG_XCNT_INT;
		iSRC_LIST_6_SP1A.Config |= ENUM_DMA_CFG_XCNT_INT;
		iSRC_LIST_7_SP1B.Config |= ENUM_DMA_CFG_XCNT_INT;
		iSRC_LIST_8_SP1B.Config |= ENUM_DMA_CFG_XCNT_INT;
	}
#else
	PrepareRxDescriptors(&iSRC_LIST_1_SP0A, &iSRC_LIST_2_SP0A, &RX_SP0A_BUFFER_LR0[0], &RX_SP0A_BUFFER_LR1[0], 64, 4);
	PrepareRxDescriptors(&iSRC_LIST_3_SP0B, &iSRC_LIST_4_SP0B, &RX_SP0B_BUFFER_CSW0[0], &RX_SP0B_BUFFER_CSW1[0], 64, 4);
	PrepareRxDescriptors(&iSRC_LIST_5_SP1A, &iSRC_LIST_6_SP1A, &RX_SP1A_BUFFER_LsRs0[0], &RX_SP1A_BUFFER_LsRs1[0], 64, 4);
	PrepareRxDescriptors(&iSRC_LIST_7_SP1B, &iSRC_LIST_8_SP1B, &RX_SP1B_BUFFER_LsrRsr0[0], &RX_SP1B_BUFFER_LsrRsr1[0], 64, 4);

	iSRC_LIST_1_SP0A.Config |= ENUM_DMA_CFG_XCNT_INT;
	iSRC_LIST_2_SP0A.Config |= ENUM_DMA_CFG_XCNT_INT;
	iSRC_LIST_3_SP0B.Config |= ENUM_DMA_CFG_XCNT_INT;
	iSRC_LIST_4_SP0B.Config |= ENUM_DMA_CFG_XCNT_INT;
	iSRC_LIST_5_SP1A.Config |= ENUM_DMA_CFG_XCNT_INT;
	iSRC_LIST_6_SP1A.Config |= ENUM_DMA_CFG_XCNT_INT;
	iSRC_LIST_7_SP1B.Config |= ENUM_DMA_CFG_XCNT_INT;
	iSRC_LIST_8_SP1B.Config |= ENUM_DMA_CFG_XCNT_INT;
#endif

	PrepareTxDescriptors(&iDESC_LIST_1_SP4A, &iDESC_LIST_2_SP4A, &TX_SP4A_BUFFER_LCRSW0[0], &TX_SP4A_BUFFER_LCRSW1[0], 128, 4);
	PrepareTxDescriptors(&iDESC_LIST_3_SP4B, &iDESC_LIST_4_SP4B, &TX_SP4B_BUFFER_LsLsrRsRsr0[0], &TX_SP4B_BUFFER_LsLsrRsRsr1[0], 128, 4);
	PrepareTxDescriptors(&iDESC_LIST_5_SP3A, &iDESC_LIST_6_SP3A,&TX_SP3A_BUFFER_Addch1ch3Addch2ch4_set0[0], &TX_SP3A_BUFFER_Addch1ch3Addch2ch4_set1[0], 128, 4);
	PrepareTxDescriptors(&iDESC_LIST_7_SP3B, &iDESC_LIST_8_SP3B, &TX_SP3B_BUFFER_Addch5ch7Addch6ch8_set0[0], &TX_SP3B_BUFFER_Addch5ch7Addch6ch8_set1[0], 128, 4);

	if(TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
	{
	PrepareTxDescriptors(&iDESC_LIST_9_SP2A, &iDESC_LIST_10_SP2A, &TX_SP2A_BUFFER_Addch9ch11Addch10ch12_set0[0], &TX_SP2A_BUFFER_Addch9ch11Addch10ch12_set1[0], 128, 4);
}
		if(TX_DAC_Output_Ch_Cnt == 3)
		{
	PrepareTxDescriptors(&iDESC_LIST_11_SP5B, &iDESC_LIST_12_SP5B, &TX_SP5B_BUFFER_Addch13ch15Addch14ch16_set0[0], &TX_SP5B_BUFFER_Addch13ch15Addch14ch16_set1[0], 128, 4);
}
	
	iDESC_LIST_1_SP4A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_2_SP4A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_3_SP4B.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_4_SP4B.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_5_SP3A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_6_SP3A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_7_SP3B.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_8_SP3B.Config = ENUM_DMA_CFG_XCNT_INT;

	if(TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
	{
	iDESC_LIST_9_SP2A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_10_SP2A.Config = ENUM_DMA_CFG_XCNT_INT;
}
		if(TX_DAC_Output_Ch_Cnt == 3)
		{
	iDESC_LIST_11_SP5B.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_12_SP5B.Config = ENUM_DMA_CFG_XCNT_INT;
}

#ifdef SPDIF_ENABLE
	if(SPDIF_Enable == 1)
	{
		Result = adi_sport_DMATransfer(hSPORT5ARx,&iSRC_LIST_1_SP5A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	}
	else
	{
		Result = adi_sport_DMATransfer(hSPORT0ARx,&iSRC_LIST_1_SP0A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
		Result = adi_sport_DMATransfer(hSPORT0BRx,&iSRC_LIST_3_SP0B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
		Result = adi_sport_DMATransfer(hSPORT1ARx,&iSRC_LIST_5_SP1A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
		Result = adi_sport_DMATransfer(hSPORT1BRx,&iSRC_LIST_7_SP1B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	}
#else
	Result = adi_sport_DMATransfer(hSPORT0ARx,&iSRC_LIST_1_SP0A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	Result = adi_sport_DMATransfer(hSPORT0BRx,&iSRC_LIST_3_SP0B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	Result = adi_sport_DMATransfer(hSPORT1ARx,&iSRC_LIST_5_SP1A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	Result = adi_sport_DMATransfer(hSPORT1BRx,&iSRC_LIST_7_SP1B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
#endif

	Result = adi_sport_DMATransfer(hSPORT4ATx,&iDESC_LIST_1_SP4A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
	Result = adi_sport_DMATransfer(hSPORT4BTx,&iDESC_LIST_3_SP4B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
	Result = adi_sport_DMATransfer(hSPORT3ATx,&iDESC_LIST_5_SP3A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
	Result = adi_sport_DMATransfer(hSPORT3BTx,&iDESC_LIST_7_SP3B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);

	if(TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
	{
	Result = adi_sport_DMATransfer(hSPORT2ATx,&iDESC_LIST_9_SP2A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
}
		if(TX_DAC_Output_Ch_Cnt == 3)
				{
	Result = adi_sport_DMATransfer(hSPORT5BTx,&iDESC_LIST_11_SP5B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
}


	/* This should be called only after setting up the DMA transfer */
	ADI_SPORT_RESULT    eResult;

	/* Initialize array of SPORT handles in TX and RX groups */
	SportTxDai1Array[0]= hSPORT4ATx;
	SportTxDai1Array[1]= hSPORT4BTx;

		if(TX_DAC_Output_Ch_Cnt == 3)
				{
	SportTxDai1Array[2]= hSPORT5BTx;
}

	/* Create DAI1 TX Group 0 */
	if(TX_DAC_Output_Ch_Cnt == 3)
			{
	eResult = adi_sport_CreateGlobalGroup(SportTxDai1Array,3u,&hDai1Group0Tx,false,true);
			}
	else
	{
	eResult = adi_sport_CreateGlobalGroup(SportTxDai1Array,2u,&hDai1Group0Tx,false,true);
	}
	SportTxDai0Array[0]= hSPORT3ATx;
	SportTxDai0Array[1]= hSPORT3BTx;

	if(TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
	{
	SportTxDai0Array[2]= hSPORT2ATx;
}

	/* Create DAI0 TX Group 1 */
	if(TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
	{
	eResult = adi_sport_CreateGlobalGroup(SportTxDai0Array,3u,&hDai0Group0Tx,false,true);
}
	else
	{
	eResult = adi_sport_CreateGlobalGroup(SportTxDai0Array,2u,&hDai0Group0Tx,false,true);
}



	
#ifdef SPDIF_ENABLE
	if(SPDIF_Enable == 1)
	{
		SportRxDai1Array[0]= hSPORT5ARx;

		Result = adi_sport_CreateGlobalGroup(SportRxDai1Array,1u,&hDai1Group1Rx,false,true);

		/* Register RX group callback */
		Result = adi_sport_GlobalRegisterCallback(hDai1Group1Rx, Rx_DMA_HANDLER, NULL);
	}
	else
	{
		SportRxDai0Array[0]= hSPORT0ARx;
		SportRxDai0Array[1]= hSPORT0BRx;
		SportRxDai0Array[2]= hSPORT1ARx;
		SportRxDai0Array[3]= hSPORT1BRx;

		/* Create DAI0 RX Group 0 */
		Result = adi_sport_CreateGlobalGroup(SportRxDai0Array,4u,&hDai0Group1Rx,false,true);

		/* Register RX group callback */
		Result = adi_sport_GlobalRegisterCallback(hDai0Group1Rx, Rx_DMA_HANDLER, NULL);
	}
#else
	SportRxDai0Array[0]= hSPORT0ARx;
	SportRxDai0Array[1]= hSPORT0BRx;
	SportRxDai0Array[2]= hSPORT1ARx;
	SportRxDai0Array[3]= hSPORT1BRx;

	/* Create DAI0 RX Group 0 */
	Result = adi_sport_CreateGlobalGroup(SportRxDai0Array,4u,&hDai0Group1Rx,false,true);

	/* Register RX group callback */
	Result = adi_sport_GlobalRegisterCallback(hDai0Group1Rx, Rx_DMA_HANDLER, NULL);
#endif

	/* Register TX group callback */
	Result = adi_sport_GlobalRegisterCallback(hDai1Group0Tx, Tx_DMA_HANDLER, NULL);
}

#if defined (USE_MDMA_EXTCHANNEL) || defined (TX_NEW_LOGIC)
/**************************************************************************************************
 *  Module Name        : EXTMDMA_init
 *  Functionality      : External Memory DMA Security bit configuration
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
void EXTMDMA_init()
{

 //  *pREG_SPU0_SECUREP93=0x3;
	adi_mdma_Open (ADI_DMA_MEMDMA_S0,
				  &MemDmaStreamMem[0],
				  &hMemDmaStream,
				  &hSrcDmaChannel,
				  &hDestDmaChannel,
				  NULL,
				  NULL);

	adi_mdma_Open (ADI_DMA_MEMDMA_S3,
					  &MemDmaStreamMem1[0],
					  &hMemDmaStream1,
					  &hSrcDmaChannel1,
					  &hDestDmaChannel1,
					  NULL,
					  NULL);

}
#define SMSIZE3 32
#define DMSIZE3 32

/**************************************************************************************************
 *  Module Name        : EXTMDMA_enable
 *  Functionality      : External DMA enable copy data from external predac buffer to internal buffer
 *  					 add offset to dest_buffer
 *  Input Parameters   : BuffSize, SrcBuff
 *  Output Parameters  : DstBuff
 **************************************************************************************************/
void EXTMDMA_enable(int BuffSize, int SrcBuff, int DstBuff)
{

		adi_mdma_Copy1D(
						hMemDmaStream,
						DstBuff,
						SrcBuff,
						ADI_DMA_MSIZE_4BYTES,
						BuffSize);
}
/**************************************************************************************************
 *  Module Name        : Predac_Buffer_Ext_To_Predac_Buffer_Int_DMA
 *  Functionality      : Predac_Buffer_Ext_To_Predac_Buffer_Int_DMA copy data from external predac
 *                       buffer to internal predac buffer
 *  Input Parameters   : BuffSize, SrcBuff
 *  Output Parameters  : DstBuff
 **************************************************************************************************/
void Predac_Buffer_Ext_To_Predac_Buffer_Int_DMA(int BuffSize, int SrcBuff, int DstBuff)
{

		adi_mdma_Copy1D(
						hMemDmaStream1,
						DstBuff,
						SrcBuff,
						ADI_DMA_MSIZE_4BYTES,
						BuffSize);

}
/**************************************************************************************************
 *  Module Name        : SRC_init
 *  Functionality      : To enable the ASRC
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
#ifdef ASRC_ENABLE
void SRC_init(void)
{
	adi_asrc_Open(0u,                    /* Block number */
				 0u,                     /* Device number */
				gAsrcMem0,               /* Pointer to Memory */
				ADI_ASRC_MEMORY_SIZE,    /* Memory Size */
				&hAsrc0);

	adi_asrc_Open(0u,                    /* Block number */
				 1u,                     /* Device number */
				gAsrcMem1,               /* Pointer to Memory */
				ADI_ASRC_MEMORY_SIZE,    /* Memory Size */
				&hAsrc1);

	adi_asrc_Open(0u,                    /* Block number */
				2u,                      /* Device number */
				gAsrcMem2,               /* Pointer to Memory */
				ADI_ASRC_MEMORY_SIZE,    /* Memory Size */
				&hAsrc2);

	adi_asrc_Open(0u,                   /* Block number */
				 3u,                    /* Device number */
				gAsrcMem3,              /* Pointer to Memory */
				ADI_ASRC_MEMORY_SIZE,   /* Memory Size */
				&hAsrc3);

	adi_asrc_Open(0u,                    /* Block number */
				 4u,                     /* Device number */
				gAsrcMem4,               /* Pointer to Memory */
				ADI_ASRC_MEMORY_SIZE,    /* Memory Size */
				&hAsrc4);

	adi_asrc_Open(0u,                    /* Block number */
				5u,                     /* Device number */
				gAsrcMem5,               /* Pointer to Memory */
				ADI_ASRC_MEMORY_SIZE,    /* Memory Size */
				&hAsrc5);

	adi_asrc_Open(0u,                    /* Block number */
				6u,                      /* Device number */
				gAsrcMem6,               /* Pointer to Memory */
				ADI_ASRC_MEMORY_SIZE,    /* Memory Size */
				&hAsrc6);

	adi_asrc_Open(0u,                   /* Block number */
				 7u,                    /* Device number */
				gAsrcMem7,              /* Pointer to Memory */
				ADI_ASRC_MEMORY_SIZE,   /* Memory Size */
				&hAsrc7);

	adi_asrc_Enable(hAsrc0,true);
	adi_asrc_Enable(hAsrc1,true);
	adi_asrc_Enable(hAsrc2,true);
	adi_asrc_Enable(hAsrc3,true);

	adi_asrc_Enable(hAsrc4,true);
	adi_asrc_Enable(hAsrc5,true);
	adi_asrc_Enable(hAsrc6,true);
	adi_asrc_Enable(hAsrc7,true);
}
#endif
/**************************************************************************************************
 *  Module Name        : SRU_Reconfigure
 *  Functionality      : Reconfiguring PCG clock based on input and output sample rate
 *  Input Parameters   : sample_fs_micro,
 *  Output Parameters  : Output_SampleRate
 *************************************************************************************************/
/*SRU Reconfigure definition*/
void SRU_Reconfigure(int sample_fs_micro,int Output_SampleRate)
{
	int Clock_Div_Value;

	if(Output_SampleRate == FS_48K||Output_SampleRate == FS_44K||Output_SampleRate == FS_32K)
	{
		Clock_Div_Value = MCLK_48KHZ; //MCLK value for 48KHz
	}
	if(Output_SampleRate == FS_96K||Output_SampleRate == FS_88K||Output_SampleRate == FS_64K)
	{
		Clock_Div_Value = MCLK_96KHZ; //MCLK value for 96KHz
	}
	if(Output_SampleRate == FS_192K || Output_SampleRate == FS_176K||Output_SampleRate == FS_128K)
	{
		Clock_Div_Value = MCLK_192KHZ;  //MCLK value for 192KHz
	}

#ifdef SPDIF_ENABLE
	if(SPDIF_Enable == 1)
	{
		int CLKPHASE,CLKDIV;

		CLKDIV = (4 * Spdif_fs_table[sample_fs_micro])/Spdif_fs_table[Output_SampleRate];

		CLKPHASE = ((3+CLKDIV/2)%CLKDIV);    //To synchronize 64*fs2 with fs1 and it's falling edge with fs2

		ADI_PCG_CLK_INFO gClkInfo_C;
			gClkInfo_C.eClkInput = ADI_PCG_CLK_EXT;      	      /* Clock Source */
			gClkInfo_C.nDiv = 0u;          					      /* Clock Divisor */
			gClkInfo_C.bExternalTrigger = false;                  /* External Trigger */
		ADI_PCG_FS_INFO gFsInfo_C;
			gFsInfo_C.eClkInput = ADI_PCG_FS_EXT;                     /* Clock Source */
			gFsInfo_C.nDiv = CLKDIV;     				              /* Frame Sync Divisor */
			gFsInfo_C.nPulseWidth = CLKDIV/2;                         /* Pulse Width */
			gFsInfo_C.nPhase = CLKPHASE;                              /* Phase */
			gFsInfo_C.bExternalTrigger = true;                        /* External Trigger */
			gFsInfo_C.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;   /* Bypass Mode */

		ADI_PCG_CLK_INFO gClkInfo_D;
			gClkInfo_D.eClkInput = ADI_PCG_CLK_EXT;      	/* Clock Source */
			gClkInfo_D.nDiv = 0u;          					/* Clock Divisor */
			gClkInfo_D.bExternalTrigger = false;            /* External Trigger */
		ADI_PCG_FS_INFO gFsInfo_D;
			gFsInfo_D.eClkInput = ADI_PCG_FS_EXT;                    /* Clock Source */
			gFsInfo_D.nDiv = 64*CLKDIV;     				         /* Frame Sync Divisor */
			gFsInfo_D.nPulseWidth = 32*CLKDIV;                       /* Pulse Width */
			gFsInfo_D.nPhase = FSPHASE;                              /* Phase */
			gFsInfo_D.bExternalTrigger = true;                       /* External Trigger */
			gFsInfo_D.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;  /* Bypass Mode */


		adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo_C,&gFsInfo_C);
		adi_pcg_Init(ADI_PCG_DEV_D,&gClkInfo_D,&gFsInfo_D);
	}
	else
	{
		ADI_PCG_CLK_INFO gClkInfo;
				gClkInfo.eClkInput = ADI_PCG_CLK_EXT;              		/* Clock Source */
				gClkInfo.nDiv = Clock_Div_Value/64;                     /* Clock Divisor */
				gClkInfo.bExternalTrigger = false;                      /* External Trigger */

		ADI_PCG_FS_INFO gFsInfo;
				gFsInfo.eClkInput = ADI_PCG_CLK_EXT;                	/* Clock Source */
				gFsInfo.nDiv = Clock_Div_Value;                     /* Frame Sync Divisor */
				gFsInfo.nPulseWidth = (gFsInfo.nDiv)/2u;               /* Pulse Width */
				gFsInfo.nPhase = gClkInfo.nDiv/2;                      /* Phase */
				gFsInfo.bExternalTrigger = false;                      /* External Trigger */
				gFsInfo.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;  /* Bypass Mode */

	   adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo,&gFsInfo);
	}
#else
	ADI_PCG_CLK_INFO gClkInfo;
			gClkInfo.eClkInput = ADI_PCG_CLK_EXT;              		/* Clock Source */
			gClkInfo.nDiv = Clock_Div_Value/64;                     /* Clock Divisor */
			gClkInfo.bExternalTrigger = false;                      /* External Trigger */

	ADI_PCG_FS_INFO gFsInfo;
			gFsInfo.eClkInput = ADI_PCG_CLK_EXT;                	/* Clock Source */
			gFsInfo.nDiv = Clock_Div_Value;                     /* Frame Sync Divisor */
			gFsInfo.nPulseWidth = (gFsInfo.nDiv)/2u;               /* Pulse Width */
			gFsInfo.nPhase = gClkInfo.nDiv/2;                      /* Phase */
			gFsInfo.bExternalTrigger = false;                      /* External Trigger */
			gFsInfo.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;  /* Bypass Mode */

   adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo,&gFsInfo);
#endif

#ifdef ASRC_ENABLE
   if(ASRC_Enable == 1)
   {
	   Asrc_SRU_Reconfigure();
   }
#endif

#ifdef OPTICAL_MODULE
	if(Prev_OutputSampleRate != Output_SampleRate)
	{
		SPI2_Init_DIT(Output_SampleRate);
		Prev_OutputSampleRate = Output_SampleRate;
	}
#endif
}

/**************************************************************************************************
 *  Module Name        : PCG_init
 *  Functionality      : To enable the PCG C
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
void PCG_init(void)
{
#ifdef SPDIF_ENABLE
	if(SPDIF_Enable == 1)
	{
		int  CLKDIV = 4;           //  default case FS2_FS1
        int CLKPHASE;

        CLKPHASE = ((3+CLKDIV/2)%CLKDIV);    //To synchronize 64*fs2 with fs1 and it's falling edge with fs2

        ADI_PCG_CLK_INFO gClkInfo_C;
	        gClkInfo_C.eClkInput = ADI_PCG_CLK_EXT;      	      /* Clock Source */
	        gClkInfo_C.nDiv = 0u;          					      /* Clock Divisor */
	        gClkInfo_C.bExternalTrigger = false;                  /* External Trigger */
	    ADI_PCG_FS_INFO gFsInfo_C;
	        gFsInfo_C.eClkInput = ADI_PCG_FS_EXT;                     /* Clock Source */
	        gFsInfo_C.nDiv = CLKDIV;     				              /* Frame Sync Divisor */
			gFsInfo_C.nPulseWidth = CLKDIV/2;                         /* Pulse Width */
			gFsInfo_C.nPhase = CLKPHASE;                              /* Phase */
			gFsInfo_C.bExternalTrigger = true;                        /* External Trigger */
			gFsInfo_C.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;   /* Bypass Mode */


		ADI_PCG_CLK_INFO gClkInfo_D;
            gClkInfo_D.eClkInput = ADI_PCG_CLK_EXT;      	/* Clock Source */
            gClkInfo_D.nDiv = 0u;          					/* Clock Divisor */
            gClkInfo_D.bExternalTrigger = false;            /* External Trigger */
        ADI_PCG_FS_INFO gFsInfo_D;
            gFsInfo_D.eClkInput = ADI_PCG_FS_EXT;                    /* Clock Source */
            gFsInfo_D.nDiv = 64*CLKDIV;     				         /* Frame Sync Divisor */
			gFsInfo_D.nPulseWidth = 32*CLKDIV;                       /* Pulse Width */
			gFsInfo_D.nPhase = FSPHASE;                              /* Phase */
			gFsInfo_D.bExternalTrigger = true;                       /* External Trigger */
			gFsInfo_D.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;  /* Bypass Mode */

		adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo_C,&gFsInfo_C);
		adi_pcg_Init(ADI_PCG_DEV_D,&gClkInfo_D,&gFsInfo_D);
	}
	else
	{
		ADI_PCG_CLK_INFO gClkInfo;
			gClkInfo.eClkInput = ADI_PCG_CLK_EXT;              	 /* Clock Source */
			gClkInfo.nDiv = 8u;                       			 /* Clock Divisor */
			gClkInfo.bExternalTrigger = false;                   /* External Trigger */

		ADI_PCG_FS_INFO gFsInfo;
			gFsInfo.eClkInput = ADI_PCG_CLK_EXT;                	/* Clock Source */
			gFsInfo.nDiv = 512u;                                    /* Frame Sync Divisor */
			gFsInfo.nPulseWidth = (gFsInfo.nDiv)/2u;                /* Pulse Width */
			gFsInfo.nPhase = gClkInfo.nDiv/2;                       /* Phase */
			gFsInfo.bExternalTrigger = false;                       /* External Trigger */
			gFsInfo.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;   /* Bypass Mode */

	   adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo,&gFsInfo);
	}
#else
	ADI_PCG_CLK_INFO gClkInfo;
		gClkInfo.eClkInput = ADI_PCG_CLK_EXT;              	 /* Clock Source */
		gClkInfo.nDiv = 8u;                       			 /* Clock Divisor */
		gClkInfo.bExternalTrigger = false;                   /* External Trigger */

	ADI_PCG_FS_INFO gFsInfo;
		gFsInfo.eClkInput = ADI_PCG_CLK_EXT;                	/* Clock Source */
		gFsInfo.nDiv = 512u;                                    /* Frame Sync Divisor */
		gFsInfo.nPulseWidth = (gFsInfo.nDiv)/2u;                /* Pulse Width */
		gFsInfo.nPhase = gClkInfo.nDiv/2;                       /* Phase */
		gFsInfo.bExternalTrigger = false;                       /* External Trigger */
		gFsInfo.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;   /* Bypass Mode */

   adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo,&gFsInfo);
#endif

#ifdef ASRC_ENABLE
   if(ASRC_Enable == 1)
   {
	   Asrc_SRU_Reconfigure();
   }
#endif
}
#ifdef EMDMA
int count_transmit;
void Predac_buffer_Ext_to_Predac_buffer_Int_DMA(int Sample_Block,int No_of_Channel, int SrcBuff, int DstBuff)
{
	if(count_transmit)
		NOP1;

	*pREG_EMDMA0_CTL&=0xfffffffe;
	*pREG_EMDMA0_CTL&=0x0;
	*pREG_EMDMA0_TPTR&=0x0;
	*pREG_EMDMA0_TCNT&=0x0;

	int temp=0;
	/*uiTapList is updated with offset value based on the sample_block size*/
	for(int i=0;i<Sample_Block;i++)
	{
		uiTapList[i]=temp;
		temp=temp+32;
	}
	/* Disable EMDMA0 before configuration*/


	/* TAB_LIST pointer and counter is updated with uiTapList address & Sample_Block Size*/
	*pREG_EMDMA0_TPTR=((uint32_t)(uiTapList)>>2|(0xA000000));
	*pREG_EMDMA0_TCNT=Sample_Block;

	/* Source buffer address is given to Channel 0 Index register */
	*pREG_EMDMA0_INDX0=(uint32_t)(DstBuff)>>2|(0xA000000);
	*pREG_EMDMA0_MOD0=1;
	*pREG_EMDMA0_CNT0=No_of_Channel;

	/* Destination buffer address is given to Channel 1 Index register */
	*pREG_EMDMA0_INDX1=((uint32_t)SrcBuff>>2);
	*pREG_EMDMA0_MOD1=1;

	/* Enable EMDMA0 before configuration and Transmission Direction to Channel 1 write and TapList enable*/
	*pREG_EMDMA0_CTL|=1<<BITP_EMDMA_CTL_EN|0<<BITP_EMDMA_CTL_TRAN|1<<BITP_EMDMA_CTL_TLEN;

	count_transmit++;
}


#endif
#endif /* End of #if defined (USE_MDMA_EXTCHANNEL) || defined (TX_NEW_LOGIC)	*/

/**************************************************************************************************
 *  Module Name        : SpuInit
 *  Functionality      : Initialize SPU Service and enabling the SPU
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
section("seg_kernal_code_l3")
void SpuInit(void)
{
    /* Memory required for the SPU operation */
    uint8_t SpuMemory[ADI_SPU_MEMORY_SIZE];

    /* SPU handle */
    ADI_SPU_HANDLE hSpu;

    ADI_SPU_RESULT eResult;

    /* Initialize SPU Service */
    eResult= adi_spu_Init(0u, SpuMemory, NULL, NULL, &hSpu);
#ifdef SPDIF_ENABLE
	adi_spu_EnableMasterSecure(hSpu, SPORT5A_DMA_SPU_ID, true);
#endif

    adi_spu_EnableMasterSecure(hSpu, SPORT0A_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT0B_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT1A_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT1B_DMA_SPU_ID, true);

    adi_spu_EnableMasterSecure(hSpu, SPORT3A_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT3B_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT4A_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT4B_DMA_SPU_ID, true);


    adi_spu_EnableMasterSecure(hSpu, SPORT2A_DMA_SPU_ID, true);

    adi_spu_EnableMasterSecure(hSpu, SPORT5B_DMA_SPU_ID, true);

    adi_spu_EnableMasterSecure(hSpu, SPI0_TXDMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPI0_RXDMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, MDMA0_SRC_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, MDMA0_DST_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, MDMA3_SPU_ID, true);
}
#ifdef SPDIF_ENABLE
ADI_SPDIF_RX_RESULT eResult;
/**************************************************************************************************
 *  Module Name        : SpdifRxInit
 *  Functionality      : Initialize SPDIF Service and enabling the SPDIF
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
section("seg_kernal_code_l3")
void SpdifRxInit(void)
{
	adi_spdif_Rx_Open(1,SpdifRxMemory,ADI_SPDIF_RX_MEMORY_SIZE,&hSpdifRx);

	adi_dai_init(1);
	eResult = adi_spdif_Rx_RegisterCallback(hSpdifRx,Spdif_Rx_ISR,NULL);
	adi_spdif_Rx_Enable(hSpdifRx,true);

    adi_spdif_Rx_SetTdmsel(hSpdifRx,ADI_SPDIF_RX_SF_96K_OR_LOWER);
    adi_spdif_Rx_RestartAudio (hSpdifRx);

    Prev_SPDIF_Enable = SPDIF_Enable;

}

/**************************************************************************************************
 *  Module Name        : SpdifRxStop
 *  Functionality      : Stop SPDIF Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
section("seg_kernal_code_l3")
void SpdifRxStop(void)
{
	eResult = adi_spdif_Rx_RegisterCallback(hSpdifRx,NULL,NULL);
	adi_dai_init(0);
    adi_spdif_Rx_Enable(hSpdifRx,false);
    adi_spdif_Rx_Close(hSpdifRx);

    Spdif_I2S_Switch_Occured = 1;
}
#endif

#ifdef ASRC_ENABLE
section("seg_kernal_code_l3")
void ASRC_DAI_Init()
{
	SRU2(PCG0_CRS_CLKB_O,DAI1_PB03_I);
	SRU2(PCG0_CRS_FSB_O,DAI1_PB04_I);

	SRU2(PCG0_CLKC_O,SPT4_ACLK_I);		//SPORT4A TX
	SRU2(PCG0_CLKC_O,SPT4_BCLK_I);		//SPORT4B TX
	SRU(PCG0_CRS_CLKC_O,SPT3_ACLK_I); 	//SPORT3A TX
	SRU(PCG0_CRS_CLKC_O,SPT3_BCLK_I); 	//SPORT3B TX

	SRU2(PCG0_FSC_O,SPT4_AFS_I);		//SPORT4A TX
	SRU2(PCG0_FSC_O,SPT4_BFS_I);		//SPORT4B TX
	SRU(PCG0_CRS_FSC_O,SPT3_AFS_I);		//SPORT3A TX
	SRU(PCG0_CRS_FSC_O,SPT3_BFS_I);		//SPORT3B TX

	SRU2(SPT4_AD0_O,SRC4_DAT_IP_I);		// SPORT4A --> SRC4 --> D1.P08
	SRU2(SRC4_DAT_OP_O,DAI1_PB08_I);

    SRU2(SPT4_AD1_O,SRC5_DAT_IP_I);		// SPORT4A --> SRC5 --> D1.P09
    SRU2(SRC5_DAT_OP_O,DAI1_PB09_I);

    SRU2(SPT4_BD0_O,SRC6_DAT_IP_I);		// SPORT4B --> SRC6 --> D1.P10
    SRU2(SRC6_DAT_OP_O,DAI1_PB10_I);

    SRU2(SPT4_BD1_O,SRC7_DAT_IP_I);		// SPORT4B --> SRC7 --> D1.P11
    SRU2(SRC7_DAT_OP_O,DAI1_PB11_I);    //check

	SRU(SPT3_AD0_O,SRC2_DAT_IP_I);		// SPORT3A --> SRC2 --> D0.P01
    SRU(SRC2_DAT_OP_O,DAI0_PB01_I);

	SRU(SPT3_AD1_O,SRC3_DAT_IP_I);		// SPORT3A --> SRC3 --> D0.P02
    SRU(SRC3_DAT_OP_O,DAI0_PB02_I);

	SRU(SPT3_BD0_O,SRC0_DAT_IP_I );		// SPORT3B --> SRC0 --> D0.P12
	SRU(SRC0_DAT_OP_O,DAI0_PB12_I);

	SRU(SPT3_BD1_O,SRC1_DAT_IP_I );		// SPORT3B --> SRC1 --> D0.P19
	SRU(SRC1_DAT_OP_O,DAI0_PB19_I);

	SRU2(PCG0_CLKC_O,SRC4_CLK_IP_I);	// PCG-C: clock to SR4 input
	SRU2(PCG0_FSC_O, SRC4_FS_IP_I );

	SRU2(DAI1_PB03_O, SRC4_CLK_OP_I );	// PCG-B: clock to SR4 output
	SRU2(DAI1_PB04_O,SRC4_FS_OP_I);

	SRU2(PCG0_CLKC_O,SRC5_CLK_IP_I);	// PCG-C: clock to SR5 input
	SRU2(PCG0_FSC_O, SRC5_FS_IP_I );

	SRU2(DAI1_PB03_O, SRC5_CLK_OP_I );	// PCG-B: clock to SR5 output
	SRU2(DAI1_PB04_O,SRC5_FS_OP_I);

	SRU2(PCG0_CLKC_O,SRC6_CLK_IP_I);	// PCG-C: clock to SR6 input
	SRU2(PCG0_FSC_O, SRC6_FS_IP_I );

	SRU2(DAI1_PB03_O, SRC6_CLK_OP_I );	// PCG-B: clock to SR6 output
	SRU2(DAI1_PB04_O,SRC6_FS_OP_I);

	SRU2(PCG0_CLKC_O,SRC7_CLK_IP_I);	// PCG-C: clock to SR7 input
	SRU2(PCG0_FSC_O, SRC7_FS_IP_I );

	SRU2(DAI1_PB03_O, SRC7_CLK_OP_I );	// PCG-B: clock to SR7 output
	SRU2(DAI1_PB04_O,SRC7_FS_OP_I);

	SRU(PCG0_CRS_CLKC_O,SRC0_CLK_IP_I);	// PCG-C: clock to SR0 input through D1.P03 & D1.P04
	SRU(PCG0_CRS_FSC_O, SRC0_FS_IP_I );

	SRU(PCG0_CLKB_O, SRC0_CLK_OP_I );	// PCG-B: clock to SR0 output through D0.P11 & D0.P12
	SRU(PCG0_FSB_O,SRC0_FS_OP_I);

	SRU(PCG0_CRS_CLKC_O,SRC1_CLK_IP_I);	// PCG-C: clock to SR1 input through D1.P03 & D1.P04
	SRU(PCG0_CRS_FSC_O, SRC1_FS_IP_I );

	SRU(PCG0_CLKB_O, SRC1_CLK_OP_I );	// PCG-B: clock to SR1 output through D0.P11 & D0.P12
	SRU(PCG0_FSB_O,SRC1_FS_OP_I);

	SRU(PCG0_CRS_CLKC_O,SRC2_CLK_IP_I);	// PCG-C: clock to SR2 input through D1.P03 & D1.P04
	SRU(PCG0_CRS_FSC_O, SRC2_FS_IP_I );

	SRU(PCG0_CLKB_O, SRC2_CLK_OP_I );	// PCG-B: clock to SR2 output through D0.P11 & D0.P12
	SRU(PCG0_FSB_O,SRC2_FS_OP_I);

	SRU(PCG0_CRS_CLKC_O,SRC3_CLK_IP_I);	// PCG-C: clock to SR3 input through D1.P03 & D1.P04
	SRU(PCG0_CRS_FSC_O, SRC3_FS_IP_I );

	SRU(PCG0_CLKB_O, SRC3_CLK_OP_I );	// PCG-B: clock to SR3 output through D0.P11 & D0.P12
	SRU(PCG0_FSB_O,SRC3_FS_OP_I);
}

section("seg_kernal_code_l3")
void ASRC_SPDIF_DAI_Init()
{
	SRU2(HIGH,DAI1_PBEN05_I);
	SRU2(HIGH,DAI1_PBEN06_I);

	SRU2(PCG0_CRS_CLKB_O,DAI1_PB03_I);
	SRU2(PCG0_CRS_FSB_O,DAI1_PB04_I);

	SRU2(PCG0_FSC_O,DAI1_PB05_I);		//SPORT4A TX
	SRU2(PCG0_FSD_O,DAI1_PB06_I);		//SPORT4A TX

	SRU2(DAI1_PB05_O,SPT4_ACLK_I);		//SPORT4A TX
	SRU2(DAI1_PB05_O,SPT4_BCLK_I);		//SPORT4B TX
	SRU(DAI0_CRS_PB05_O,SPT3_ACLK_I); 	//SPORT3A TX
	SRU(DAI0_CRS_PB05_O,SPT3_BCLK_I); 	//SPORT3B TX

	SRU2(DAI1_PB06_O,SPT4_AFS_I);		//SPORT4A TX
	SRU2(DAI1_PB06_O,SPT4_BFS_I);		//SPORT4B TX
	SRU(DAI0_CRS_PB06_O,SPT3_AFS_I);		//SPORT3A TX
	SRU(DAI0_CRS_PB06_O,SPT3_BFS_I);		//SPORT3B TX

	SRU2(SPT4_AD0_O,SRC4_DAT_IP_I);		// SPORT4A --> SRC4 --> D1.P08
	SRU2(SRC4_DAT_OP_O,DAI1_PB08_I);

    SRU2(SPT4_AD1_O,SRC5_DAT_IP_I);		// SPORT4A --> SRC5 --> D1.P09
    SRU2(SRC5_DAT_OP_O,DAI1_PB09_I);

    SRU2(SPT4_BD0_O,SRC6_DAT_IP_I);		// SPORT4B --> SRC6 --> D1.P10
    SRU2(SRC6_DAT_OP_O,DAI1_PB10_I);

    SRU2(SPT4_BD1_O,SRC7_DAT_IP_I);		// SPORT4B --> SRC7 --> D1.P11
    SRU2(SRC7_DAT_OP_O,DAI1_PB11_I);    //check

	SRU(SPT3_AD0_O,SRC2_DAT_IP_I);		// SPORT3A --> SRC2 --> D0.P01
    SRU(SRC2_DAT_OP_O,DAI0_PB01_I);

	SRU(SPT3_AD1_O,SRC3_DAT_IP_I);		// SPORT3A --> SRC3 --> D0.P02
    SRU(SRC3_DAT_OP_O,DAI0_PB02_I);

	SRU(SPT3_BD0_O,SRC0_DAT_IP_I );		// SPORT3B --> SRC0 --> D0.P12
	SRU(SRC0_DAT_OP_O,DAI0_PB12_I);

	SRU(SPT3_BD1_O,SRC1_DAT_IP_I );		// SPORT3B --> SRC1 --> D0.P19
	SRU(SRC1_DAT_OP_O,DAI0_PB19_I);

	SRU2(DAI1_PB05_O,SRC4_CLK_IP_I);	// PCG-C: clock to SR4 input
	SRU2(DAI1_PB06_O, SRC4_FS_IP_I );

	SRU2(DAI1_PB03_O, SRC4_CLK_OP_I );	// PCG-B: clock to SR4 output
	SRU2(DAI1_PB04_O,SRC4_FS_OP_I);

	SRU2(DAI1_PB05_O,SRC5_CLK_IP_I);	// PCG-C: clock to SR5 input
	SRU2(DAI1_PB06_O, SRC5_FS_IP_I );

	SRU2(DAI1_PB03_O, SRC5_CLK_OP_I );	// PCG-B: clock to SR5 output
	SRU2(DAI1_PB04_O,SRC5_FS_OP_I);

	SRU2(DAI1_PB05_O,SRC6_CLK_IP_I);	// PCG-C: clock to SR6 input
	SRU2(DAI1_PB06_O, SRC6_FS_IP_I );

	SRU2(DAI1_PB03_O, SRC6_CLK_OP_I );	// PCG-B: clock to SR6 output
	SRU2(DAI1_PB04_O,SRC6_FS_OP_I);

	SRU2(DAI1_PB05_O,SRC7_CLK_IP_I);	// PCG-C: clock to SR7 input
	SRU2(DAI1_PB06_O, SRC7_FS_IP_I );

	SRU2(DAI1_PB03_O, SRC7_CLK_OP_I );	// PCG-B: clock to SR7 output
	SRU2(DAI1_PB04_O,SRC7_FS_OP_I);

	SRU(DAI0_CRS_PB05_O,SRC0_CLK_IP_I);	// PCG-C: clock to SR0 input through D1.P03 & D1.P04
	SRU(DAI0_CRS_PB06_O, SRC0_FS_IP_I );

	SRU(PCG0_CLKB_O, SRC0_CLK_OP_I );	// PCG-B: clock to SR0 output through D0.P11 & D0.P12
	SRU(PCG0_FSB_O,SRC0_FS_OP_I);

	SRU(DAI0_CRS_PB05_O,SRC1_CLK_IP_I);	// PCG-C: clock to SR1 input through D1.P03 & D1.P04
	SRU(DAI0_CRS_PB06_O, SRC1_FS_IP_I );

	SRU(PCG0_CLKB_O, SRC1_CLK_OP_I );	// PCG-B: clock to SR1 output through D0.P11 & D0.P12
	SRU(PCG0_FSB_O,SRC1_FS_OP_I);

	SRU(DAI0_CRS_PB05_O,SRC2_CLK_IP_I);	// PCG-C: clock to SR2 input through D1.P03 & D1.P04
	SRU(DAI0_CRS_PB06_O, SRC2_FS_IP_I );

	SRU(PCG0_CLKB_O, SRC2_CLK_OP_I );	// PCG-B: clock to SR2 output through D0.P11 & D0.P12
	SRU(PCG0_FSB_O,SRC2_FS_OP_I);

	SRU(DAI0_CRS_PB05_O,SRC3_CLK_IP_I);	// PCG-C: clock to SR3 input through D1.P03 & D1.P04
	SRU(DAI0_CRS_PB06_O, SRC3_FS_IP_I );

	SRU(PCG0_CLKB_O, SRC3_CLK_OP_I );	// PCG-B: clock to SR3 output through D0.P11 & D0.P12
	SRU(PCG0_FSB_O,SRC3_FS_OP_I);
}

section("seg_kernal_code_l3")
void Asrc_SRU_Reconfigure()
{
	ADI_PCG_CLK_INFO gClkInfo;
		gClkInfo.eClkInput = ADI_PCG_CLK_EXT;             /* Clock Source */
		gClkInfo.nDiv = FS_Div_Value/64;                  /* Clock Divisor */
		gClkInfo.bExternalTrigger = false;                /* External Trigger */

	ADI_PCG_FS_INFO gFsInfo;
		gFsInfo.eClkInput = ADI_PCG_CLK_EXT;                	/* Clock Source */
		gFsInfo.nDiv = FS_Div_Value;                            /* Frame Sync Divisor */
		gFsInfo.nPulseWidth = (gFsInfo.nDiv)/2u;                /* Pulse Width */
		gFsInfo.nPhase = gClkInfo.nDiv/2;                       /* Phase */
		gFsInfo.bExternalTrigger = false;                       /* External Trigger */
		gFsInfo.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;   /* Bypass Mode */

	adi_pcg_Init(ADI_PCG_DEV_B,&gClkInfo,&gFsInfo);
}
#endif
section("seg_kernal_code_l3")
void TX_DAC_Channel_check()
{
	if(TX_DAC_Output_Ch_Cnt >= 4)
	{
		TX_DAC_Output_Ch_Cnt = 1;
	}
}
