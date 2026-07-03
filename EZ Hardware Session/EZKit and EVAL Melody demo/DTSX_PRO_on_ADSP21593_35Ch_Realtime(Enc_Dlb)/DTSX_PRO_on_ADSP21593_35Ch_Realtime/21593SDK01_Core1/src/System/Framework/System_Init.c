/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	System_Init.c
*  Description      :   DAI,SPORT,PCG,ASRC,SPI,SPU,Kernel_default Initialization,
*                       CACHE Memory Allocation.
******************************************************************************/
#pragma default_section(CODE,"Seg_System_Init_Code")
#pragma default_section(ALLDATA,"Seg_System_Init_Data")
#include "..\src\system\Include\System_Init.h"
#include "../Include/Function_Prototype.h"
#include "../Include/Extern_Core1.h"
/**************************************************************************************************
 *  Module Name        : System_Initialization
 *  Functionality      : call all system and hardware cfg functions (SPORT, DIA, SPI)
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
void System_Initialization(void)
{
	*pREG_PADS0_DAI0_IE=0xfffff; //PADS Configuration register	
	*pREG_PADS0_DAI1_IE=0xfffff; //PADS Configuration register

	Init_Struct();
	SPI_Init();
	FlagsConfigure();
	Init_PORTs();
	Kernal_Default_Init();
	DAI_Init();
    Init_SPI0();
    Enable_SPI0();
   	PCG_Init();

	#if defined (USE_MDMA_EXTCHANNEL) || defined (TX_NEW_LOGIC)
   		EXTMDMA_Init();
	#endif

	SPORT_Init();

	Default_Command_Config();

#ifdef DTSX_DECODER
    DTS_Default_Command_config();
#ifdef TRUBASS
    DTSTrubass_Default_Command_config();
#endif //TRUBASS
#endif //DTSX_DECODER

#ifdef TMU
		TMU_Init();
#endif
}

#ifdef DTSX_DECODER
void DTS_Default_Command_config(void)
{
	Frmwk.Spi.PARAMETER_1 = 0xffff;
	Frmwk.Spi.PARAMETER_2 = 0x7a01;
	Frmwk.Spi.PARAMETER_3 = 0x0000;
	Frmwk.Spi.PARAMETER_4 = 0x0080;

	DTSX_OPTIONS_COMMAND();

	/* Channel Reorder Commands */
	Frmwk.Spi.PARAMETER_1 = 0x1041;
	Frmwk.Spi.PARAMETER_2 = 0x0D46;
	Frmwk.Spi.PARAMETER_3 = 0x636D;
	Frmwk.Spi.PARAMETER_4 = 0x3DD3;
	Frmwk.Spi.PARAMETER_5 = 0x7330;
	Frmwk.Spi.PARAMETER_6 = 0x0016;
	CHANNEL_REORDER_COMMAND();

}
#ifdef TRUBASS
void DTSTrubass_Default_Command_config(void)
{
	Frmwk.Spi.PARAMETER_1 = 0x6666;
	DTSX_PP_COMMAND();
}
#endif //TRUBASS
#endif //DTSX_DECODER


/**************************************************************************************************
 *  Module Name        : Set Priority
 *  Functionality      : Set priority of SPI and SPORT DMA interrupts
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/

void Set_Priority(void)
{
	if (SPI_Device == 1)
	{
		adi_sec_SetPriority(INTR_SPI1_RXDMA,0);
	}
	else
	{
		adi_sec_SetPriority(INTR_SPI0_RXDMA,0);
	}
	adi_sec_SetPriority(INTR_DAI1_IRQH,1);
	adi_sec_SetPriority(INTR_SYS_MDMA0_DST,1);


	adi_sec_SetPriority(INTR_DAI0_GBL_SPORT_INT1 ,2);  // For HDMI Receiver

	adi_sec_SetPriority(INTR_DAI1_GBL_SPORT_INT0,2); // For Transmitter
	adi_sec_SetPriority(INTR_DAI0_GBL_SPORT_INT0,2); // For Transmitter
}

/**************************************************************************************************
 *  Module Name        : Default_Command_Config
 *  Functionality      : default kernel run flag set to 1
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
void Default_Command_Config(void)
{
	Frmwk.run_flag = 1;
	*run_flag      = 1;
}

/**************************************************************************************************
 *  Module Name        : Kernal_Default_Init
 *  Functionality      : Kernal_Default_Initialazation (Memory allocation, predac, pack & lpc delay buffer
 *  					 Security bit set as per Sport cfg)
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
void Kernal_Default_Init(void)
{
#ifndef DTSX_DECODER
	Frmwk.autodetect_mode=FORCEPCM3;
#endif // DTSX_DECODER
	AllocateMemoryKernel();

	Free_AllotMemoryPackDac( Frmwk.pack_length_pcm, Frmwk.predac_length_pcm, 1);
#ifdef PCM_DECODER
	Frmwk.LPCMDelaySize = Frmwk.LPCMDelaySize_host+(Frmwk.SampleBlock*2);	//(4096samples*2ch*32bit)
	Frmwk.PrevLPCMDelaySize_host = Frmwk.LPCMDelaySize_host;
	AllocateMemoryPCMDelay(Frmwk.LPCMDelaySize);
#endif //PCM_DECODER

	SPU_Init();
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
	*pREG_SHL1C_CFG2 |= 0x3c00;
	 NOP10; NOP10; NOP10; NOP1; NOP1; NOP1;//33 NOPS

	// Non Cacheable region In L2 Memory (shared meemory) 
	*pREG_SHL1C_RANGE_START5 = 0x2015e420;
	 NOP10;NOP10;
	*pREG_SHL1C_RANGE_END5 =  0x2016642f;
	 NOP10;NOP10;

	// Non Cacheable region In DDR0 (PREDAC and Add_Predac buffer)
	*pREG_SHL1C_RANGE_START6=0x80600000;
	 NOP10;NOP10;

	*pREG_SHL1C_RANGE_END6=0x807400ff;
	 NOP10;NOP10;
}



/**************************************************************************************************
 *  Module Name        : DAI_init
 *  Functionality      : Interface between process and hardware.Configured DAI pins for inputs & outputs
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
void  DAI_Init(void)
{
/****************************************************Receiver DAI configuration******************************************************************/

	SRU(HIGH,DAI1_PBEN03_I);        //TX_I2S_BCLK
	SRU(HIGH,DAI1_PBEN04_I);        //TX_I2S_LRCLK

	SRU(HIGH, DAI1_PBEN12_I);
	SRU(DAI1_PB07_O, DAI1_PB12_I);

	SRU(LOW,DAI0_PBEN06_I);          //RX_I2S_BCLK
	SRU(LOW,DAI0_PBEN07_I);          //RX_I2S_LRCLK
    SRU(LOW,DAI0_PBEN05_I);         // External MCLK from 24.576MHz Oscillator
    SRU(LOW,DAI1_PBEN07_I);          //DAI 1 Pin 07 is connected with MCLK In pin of AD1939 Codec

	SRU(LOW,DAI0_PBEN08_I);
	SRU(LOW,DAI0_PBEN09_I);
	SRU(LOW,DAI0_PBEN10_I);
	SRU(LOW,DAI0_PBEN11_I);
	SRU(DAI0_PB06_O,SPT0_ACLK_I);
	SRU(DAI0_PB06_O,SPT0_BCLK_I);

	SRU(DAI0_PB07_O,SPT0_AFS_I);
	SRU(DAI0_PB07_O,SPT0_BFS_I);



	SRU(DAI0_PB08_O,SPT0_AD0_I);	//SPORT0A RX
	SRU(DAI0_PB09_O,SPT0_AD1_I);	//SPORT0B RX
	SRU(DAI0_PB10_O,SPT0_BD0_I);	//SPORT1A RX
	SRU(DAI0_PB11_O,SPT0_BD1_I);	//SPORT1B RX

	SRU(DAI1_PB07_O,PCG0_EXTCLKC_I);     // MCLK to PCG C
	SRU(PCG0_CLKC_O,DAI1_PB03_I);
	SRU(PCG0_FSC_O,DAI1_PB04_I);


/****************************************************Transmitter DAI configuration******************************************************************/
	if(I2S_TDM_MODE == I2S_MODE)
	{

	SRU(DAI1_PB03_O,SPT4_ACLK_I);	//SPORT4A TX
	SRU(DAI1_PB03_O,SPT4_BCLK_I);	//SPORT4B TX
	SRU(DAI1_PB03_O,SPT3_ACLK_I); 	//SPORT3A TX
	SRU(DAI1_PB03_O,SPT3_BCLK_I); 	//SPORT3B TX
	SRU(DAI1_PB03_O,SPT6_ACLK_I); 	//SPORT6A TX
	SRU(DAI1_PB03_O,SPT2_ACLK_I); 	//SPORT2A TX
	SRU(DAI1_PB03_O,SPT6_BCLK_I); 	//SPORT6B TX
	SRU(DAI1_PB03_O,SPT7_ACLK_I); 	//SPORT7A TX
	SRU(DAI1_PB03_O,SPT2_BCLK_I); 	//SPORT7B TX

	SRU(DAI1_PB04_O,SPT4_AFS_I);	//SPORT4A TX
	SRU(DAI1_PB04_O,SPT4_BFS_I);	//SPORT4B TX
	SRU(DAI1_PB04_O,SPT3_AFS_I);	//SPORT3A TX
	SRU(DAI1_PB04_O,SPT3_BFS_I);	//SPORT3B TX
	SRU(DAI1_PB04_O,SPT6_AFS_I); 	//SPORT6A TX
	SRU(DAI1_PB04_O,SPT2_AFS_I);    //SPORT2A TX
	SRU(DAI1_PB04_O,SPT6_BFS_I); 	//SPORT6B TX
	SRU(DAI1_PB04_O,SPT7_AFS_I); 	//SPORT7A TX
	SRU(DAI1_PB04_O,SPT2_BFS_I); 	//SPORT7B TX
#ifdef CHANNEL_VALIDATION

if(*Ch36_Enable==0)
{
#endif
	SRU(HIGH,DAI1_PBEN08_I); // 0
	SRU(HIGH,DAI1_PBEN09_I); // 1
	SRU(HIGH,DAI1_PBEN10_I); // 2
	SRU(HIGH,DAI1_PBEN11_I); // 3
	SRU(HIGH,DAI1_PBEN01_I); //8
	SRU(HIGH,DAI1_PBEN02_I); //9
	SRU(HIGH,DAI1_PBEN05_I); //13
	SRU(HIGH,DAI1_PBEN06_I); //15
	SRU(HIGH,DAI1_PBEN19_I); //12
	SRU(HIGH,DAI1_PBEN20_I); //14

	SRU(HIGH,DAI0_PBEN01_I); //4
	SRU(HIGH,DAI0_PBEN02_I); //5
	SRU(HIGH,DAI0_PBEN12_I); //6
	SRU(HIGH,DAI0_PBEN19_I); //7
	SRU(HIGH,DAI0_PBEN03_I);//10
	SRU(HIGH,DAI0_PBEN04_I);//11
	SRU(HIGH,DAI0_PBEN05_I); //17
	SRU(HIGH,DAI0_PBEN20_I); //16

	SRU(SPT4_AD0_O,DAI1_PB08_I);	//SPORT4A_D0 TX
	SRU(SPT4_AD1_O,DAI1_PB09_I);	//SPORT4A_D1 TX
	SRU(SPT4_BD0_O,DAI1_PB10_I);	//SPORT4B_D0 TX
	SRU(SPT4_BD1_O,DAI1_PB11_I);	//SPORT4B_D1 TX

	SRU(SPT3_AD0_O,DAI0_PB01_I);	//SPORT3A_D0 TX
	SRU(SPT3_AD1_O,DAI0_PB02_I);	//SPORT3A_D1 TX
	SRU(SPT3_BD0_O,DAI0_PB12_I);	//SPORT3B_D0 TX
	SRU(SPT3_BD1_O,DAI0_PB19_I);	//SPORT3B_D1 TX

	SRU(SPT6_AD0_O,DAI1_PB01_I);	//SPORT6A_D0 TX
	SRU(SPT6_AD1_O,DAI1_PB02_I);	//SPORT6A_D1 TX
	SRU(SPT2_AD0_O,DAI0_PB03_I);	//SPORT2A_D0 TX
	SRU(SPT2_AD1_O,DAI0_PB04_I);	//SPORT2A_D1 TX

	SRU(SPT6_BD0_O,DAI1_PB19_I);	//SPORT6B_D0 TX
	SRU(SPT6_BD1_O,DAI1_PB05_I);	//SPORT6B_D1 TX
	SRU(SPT7_AD0_O,DAI1_PB20_I);	//SPORT7A_D0 TX
	SRU(SPT7_AD1_O,DAI1_PB06_I);	//SPORT7A_D1 TX

	SRU(SPT2_BD0_O,DAI0_PB20_I);	//SPORT7B_D0 TX
	SRU(SPT2_BD1_O,DAI0_PB05_I);	//SPORT7B_D1 TX
#ifdef CHANNEL_VALIDATION
}
else
{

		SRU(LOW,DAI1_PBEN05_I);
		SRU(LOW,DAI1_PBEN06_I);
		SRU(LOW,DAI1_PBEN19_I);
		SRU(LOW,DAI1_PBEN20_I);
		SRU(LOW,DAI0_PBEN12_I);
		SRU(LOW,DAI0_PBEN19_I);
		SRU(LOW,DAI0_PBEN05_I);
		SRU(LOW,DAI0_PBEN20_I);

		SRU(SPT6_BD0_O,DAI1_PB08_I);	//SPORT6B_D0 TX
		SRU(SPT6_BD1_O,DAI1_PB09_I);	//SPORT6B_D1 TX
		SRU(SPT7_AD0_O,DAI1_PB10_I);	//SPORT7A_D0 TX
		SRU(SPT7_AD1_O,DAI1_PB11_I);	//SPORT7A_D1 TX

		SRU(SPT2_BD0_O,DAI0_PB01_I);	//SPORT7B_D0 TX
		SRU(SPT2_BD1_O,DAI0_PB02_I);	//SPORT7B_D1 TX


}
#endif
}

	else if(I2S_TDM_MODE == TDM_MODE)
	{
		//As we are not using this so making as low
		SRU(LOW,DAI1_PBEN09_I);
		SRU(LOW,DAI1_PBEN10_I);
		SRU(LOW,DAI1_PBEN11_I);
		SRU(LOW,DAI0_PBEN02_I);
		SRU(LOW,DAI0_PBEN12_I);
		SRU(LOW,DAI0_PBEN19_I);
		SRU(LOW,DAI1_PBEN02_I);
		SRU(LOW,DAI0_PBEN03_I);
		SRU(LOW,DAI0_PBEN04_I);
		SRU(LOW,DAI1_PBEN05_I);
		SRU(LOW,DAI1_PBEN20_I);
		SRU(LOW,DAI1_PBEN06_I);
		SRU(LOW,DAI0_PBEN05_I); 
	
		SRU(HIGH,DAI1_PBEN08_I);	//First 8 CH
		SRU(HIGH,DAI0_PBEN01_I);	//Second 8 CH
		SRU(HIGH,DAI1_PBEN01_I);	//Third 8 CH
		SRU(HIGH,DAI1_PBEN19_I);    //Fourth 8 CH
		SRU(HIGH,DAI0_PBEN20_I);    //Fifth 8 CH

		SRU(HIGH,DAI1_PBEN03_I);	//TX_I2S_BCLK
		SRU(HIGH,DAI1_PBEN04_I);	//TX_I2S_LRCLK
		SRU(LOW,DAI1_PBEN07_I);		//DAI 1 Pin 07 is connected with MCLK In pin of AD1939 Codec


		SRU(PCG0_INV_CLKC_O,DAI1_PB03_I);
		SRU(PCG0_FSC_O,DAI1_PB04_I);

		SRU2(HIGH,DAI1_PBEN12_I);
		SRU(DAI1_PB07_O,DAI1_PB12_I);

		SRU(DAI1_PB12_O,PCG0_EXTCLKC_I);     // MCLK to PCG C

		SRU(DAI1_PB03_O,SPT4_ACLK_I);	//SPORT4A TX
		SRU(DAI1_PB03_O,SPT3_ACLK_I); 	//SPORT3A TX
		SRU(DAI1_PB03_O,SPT6_ACLK_I);	//SPORT6A TX
		SRU(DAI1_PB03_O,SPT6_BCLK_I);	//SPORT2B TX
		SRU(DAI1_PB03_O,SPT2_BCLK_I);	//SPORT2B TX*/

		SRU(DAI1_PB04_O,SPT4_AFS_I);	//SPORT4A TX
		SRU(DAI1_PB04_O,SPT3_AFS_I);	//SPORT3A TX
		SRU(DAI1_PB04_O,SPT6_AFS_I); 	//SPORT6A TX
		SRU(DAI1_PB04_O,SPT6_BFS_I); 	//SPORT6B TX
		SRU(DAI1_PB04_O,SPT2_BFS_I); 	//SPORT2B TX
#ifdef CHANNEL_VALIDATION
		if(*Ch36_Enable==0)
		{
#endif
		SRU(SPT4_AD0_O,DAI1_PB08_I);	//SPORT4A_D0 TX
		SRU(SPT3_AD0_O,DAI0_PB01_I);	//SPORT3A_D0 TX
		SRU(SPT6_AD0_O,DAI1_PB01_I);	//SPORT6A_D0 TX
		SRU(SPT6_BD0_O,DAI1_PB19_I);	//SPORT6B_D0 TX
		SRU(SPT2_BD0_O,DAI0_PB20_I);	//SPORT2B_D0 TX
#ifdef CHANNEL_VALIDATION
		}
		else
		{
			//SRU(LOW,DAI1_PBEN01_I);	//Third 8 CH
			SRU(LOW,DAI1_PBEN19_I);    //Fourth 8 CH
			SRU(LOW,DAI0_PBEN20_I);    //Fifth 8 CH

			SRU(HIGH,DAI1_PBEN08_I);	//First 8 CH
			SRU(HIGH,DAI0_PBEN01_I);	//Second 8 CH

			SRU(SPT6_BD0_O,DAI1_PB08_I);	//SPORT6A_D0 TX
			SRU(SPT2_BD0_O,DAI0_PB01_I);	//SPORT2B_D0 TX

		}
#endif
	}
/****************************************************PCG C DAI configuration******************************************************************/
	PCG_Init();

}

/**************************************************************************************************
 *  Module Name        : PrepareRxDescriptors
 *  Functionality      : Configuration SPORT Registers for Receiver & transmitter
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
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
static void PrepareTxDescriptors (ADI_PDMA_DESC_LIST* pDmaDescList1, ADI_PDMA_DESC_LIST* pDmaDescList2, void* Buf1, void* Buf2, uint16_t XCount, uint8_t XMod)
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
 *  Module Name        : SPORT_Init
 *  Functionality      : Configuration SPORT Registers for Receiver & transmitter
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
void SPORT_Init(void)
{

		Result = adi_sport_Open(0,ADI_HALF_SPORT_A,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory0A,ADI_SPORT_MEMORY_SIZE,&hSPORT0ARx);
		Result = adi_sport_Open(0,ADI_HALF_SPORT_B,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory0B,ADI_SPORT_MEMORY_SIZE,&hSPORT0BRx);
	
if(I2S_TDM_MODE == I2S_MODE)
{
	Result = adi_sport_Open(4,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory4A,ADI_SPORT_MEMORY_SIZE,&hSPORT4ATx);
	Result = adi_sport_Open(4,ADI_HALF_SPORT_B,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory4B,ADI_SPORT_MEMORY_SIZE,&hSPORT4BTx);
	Result = adi_sport_Open(3,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory3A,ADI_SPORT_MEMORY_SIZE,&hSPORT3ATx);
	Result = adi_sport_Open(3,ADI_HALF_SPORT_B,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory3B,ADI_SPORT_MEMORY_SIZE,&hSPORT3BTx);
	Result = adi_sport_Open(6,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory6A,ADI_SPORT_MEMORY_SIZE,&hSPORT6ATx);
	Result = adi_sport_Open(2,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory2A,ADI_SPORT_MEMORY_SIZE,&hSPORT2ATx);
	Result = adi_sport_Open(6,ADI_HALF_SPORT_B,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory6B,ADI_SPORT_MEMORY_SIZE,&hSPORT6BTx);
	Result = adi_sport_Open(7,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory7A,ADI_SPORT_MEMORY_SIZE,&hSPORT7ATx);
	Result = adi_sport_Open(2,ADI_HALF_SPORT_B,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory2B,ADI_SPORT_MEMORY_SIZE,&hSPORT2BTx);
}
else if(I2S_TDM_MODE == TDM_MODE)
{
	Result = adi_sport_Open(4,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_MC_MODE, SPORTMemory4A,ADI_SPORT_MEMORY_SIZE,&hSPORT4ATx);
	Result = adi_sport_ConfigMC( hSPORT4ATx,  1 , 7 , 0 , 1 );
	Result = adi_sport_SelectChannel(hSPORT4ATx ,0,7);
	Result = adi_sport_ConfigFrameSync( hSPORT4ATx, 23,false,false, false,true,false,true);
	Result = adi_sport_ConfigClock(hSPORT4ATx,0x20,false,false,false);
	Result = adi_sport_ConfigData(hSPORT4ATx,ADI_SPORT_DTYPE_ZERO_FILL, 31, false,false, false);

	Result = adi_sport_Open(3,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_MC_MODE, SPORTMemory3A,ADI_SPORT_MEMORY_SIZE,&hSPORT3ATx);
	Result = adi_sport_ConfigMC( hSPORT3ATx,  1 , 7 , 0 , 1 );
	Result = adi_sport_SelectChannel(hSPORT3ATx ,0,7);
	Result = adi_sport_ConfigFrameSync( hSPORT3ATx, 23,false,false, false,true,false,true);
	Result = adi_sport_ConfigClock(hSPORT3ATx,0x20,false,false,false);
	Result = adi_sport_ConfigData(hSPORT3ATx,ADI_SPORT_DTYPE_ZERO_FILL, 31, false,false, false);

	Result = adi_sport_Open(6,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_MC_MODE, SPORTMemory6A,ADI_SPORT_MEMORY_SIZE,&hSPORT6ATx);
	Result = adi_sport_ConfigMC( hSPORT6ATx,  1 , 7 , 0 , 1 );
	Result = adi_sport_SelectChannel(hSPORT6ATx ,0,7);
	Result = adi_sport_ConfigFrameSync( hSPORT6ATx, 23,false,false, false,true,false,true);
	Result = adi_sport_ConfigClock(hSPORT6ATx,0x20,false,false,false);
	Result = adi_sport_ConfigData(hSPORT6ATx,ADI_SPORT_DTYPE_ZERO_FILL, 31, false,false, false);

	Result = adi_sport_Open(6,ADI_HALF_SPORT_B,ADI_SPORT_DIR_TX, ADI_SPORT_MC_MODE, SPORTMemory6B,ADI_SPORT_MEMORY_SIZE,&hSPORT6BTx);
	Result = adi_sport_ConfigMC( hSPORT6BTx,  1 , 7 , 0 , 1 );
	Result = adi_sport_SelectChannel(hSPORT6BTx ,0,7);
	Result = adi_sport_ConfigFrameSync( hSPORT6BTx, 23,false,false, false,true,false,true);
	Result = adi_sport_ConfigClock(hSPORT6BTx,0x20,false,false,false);
	Result = adi_sport_ConfigData(hSPORT6BTx,ADI_SPORT_DTYPE_ZERO_FILL, 31, false,false, false);

	Result = adi_sport_Open(2,ADI_HALF_SPORT_B,ADI_SPORT_DIR_TX, ADI_SPORT_MC_MODE, SPORTMemory2B,ADI_SPORT_MEMORY_SIZE,&hSPORT2BTx);
	Result = adi_sport_ConfigMC( hSPORT2BTx,  1 , 7 , 0 , 1 );
	Result = adi_sport_SelectChannel(hSPORT2BTx ,0,7);
	Result = adi_sport_ConfigFrameSync( hSPORT2BTx, 23,false,false, false,true,false,true);
	Result = adi_sport_ConfigClock(hSPORT2BTx,0x20,false,false,false);
	Result = adi_sport_ConfigData(hSPORT2BTx,ADI_SPORT_DTYPE_ZERO_FILL, 31, false,false, false);
}

		PrepareRxDescriptors(&iSRC_LIST_1_SP0A, &iSRC_LIST_2_SP0A, &RX_SP0A_BUFFER_LCRSW0[0], &RX_SP0A_BUFFER_LCRSW1[0], 128, 4);
		PrepareRxDescriptors(&iSRC_LIST_3_SP0B, &iSRC_LIST_4_SP0B, &RX_SP0B_BUFFER_LsLsrRsRsr0[0], &RX_SP0B_BUFFER_LsLsrRsRsr1[0], 128, 4);

		iSRC_LIST_1_SP0A.Config |= ENUM_DMA_CFG_XCNT_INT;
		iSRC_LIST_2_SP0A.Config |= ENUM_DMA_CFG_XCNT_INT;
		iSRC_LIST_3_SP0B.Config |= ENUM_DMA_CFG_XCNT_INT;
		iSRC_LIST_4_SP0B.Config |= ENUM_DMA_CFG_XCNT_INT;

if(I2S_TDM_MODE == I2S_MODE)
{
	PrepareTxDescriptors(&iDESC_LIST_1_SP4A, &iDESC_LIST_2_SP4A, &TX_SP4A_BUFFER_LCRSW0[0], &TX_SP4A_BUFFER_LCRSW1[0], 128, 4);
	PrepareTxDescriptors(&iDESC_LIST_3_SP4B, &iDESC_LIST_4_SP4B, &TX_SP4B_BUFFER_LsLsrRsRsr0[0], &TX_SP4B_BUFFER_LsLsrRsRsr1[0], 128, 4);
	PrepareTxDescriptors(&iDESC_LIST_5_SP3A, &iDESC_LIST_6_SP3A, &TX_SP3A_BUFFER_ch9ch11ch10ch12_set0[0], &TX_SP3A_BUFFER_ch9ch11ch10ch12_set1[0], 128, 4);
	PrepareTxDescriptors(&iDESC_LIST_7_SP3B, &iDESC_LIST_8_SP3B, &TX_SP3B_BUFFER_ch13ch15ch14ch16_set0[0],&TX_SP3B_BUFFER_ch13ch15ch14ch16_set1[0], 128, 4);
	PrepareTxDescriptors(&iDESC_LIST_9_SP6A, &iDESC_LIST_10_SP6A,&TX_SP6A_BUFFER_ch17ch19ch18ch20_set0[0],&TX_SP6A_BUFFER_ch17ch19ch18ch20_set1[0], 128, 4);
	PrepareTxDescriptors(&iDESC_LIST_11_SP2A,&iDESC_LIST_12_SP2A,&TX_SP2A_BUFFER_ch21ch23ch22ch24_set0[0],&TX_SP2A_BUFFER_ch21ch23ch22ch24_set1[0], 128, 4);
	PrepareTxDescriptors(&iDESC_LIST_13_SP6B,&iDESC_LIST_14_SP6B,&TX_SP6B_BUFFER_ch25ch27ch26ch28_set0[0],&TX_SP6B_BUFFER_ch25ch27ch26ch28_set1[0], 128, 4);
	PrepareTxDescriptors(&iDESC_LIST_15_SP7A,&iDESC_LIST_16_SP7A,&TX_SP7A_BUFFER_ch29ch31ch30ch32_set0[0],&TX_SP7A_BUFFER_ch29ch31ch30ch32_set1[0], 128, 4);
	PrepareTxDescriptors(&iDESC_LIST_17_SP2B,&iDESC_LIST_18_SP2B,&TX_SP2B_BUFFER_ch33ch35ch34ch36_set0[0],&TX_SP2B_BUFFER_ch33ch35ch34ch36_set1[0], 128, 4);

	iDESC_LIST_1_SP4A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_2_SP4A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_3_SP4B.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_4_SP4B.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_5_SP3A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_6_SP3A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_7_SP3B.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_8_SP3B.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_9_SP6A.Config  = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_10_SP6A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_11_SP2A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_12_SP2A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_13_SP6B.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_14_SP6B.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_15_SP7A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_16_SP7A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_17_SP2B.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_18_SP2B.Config = ENUM_DMA_CFG_XCNT_INT;
}

else if(I2S_TDM_MODE == TDM_MODE)
{
	PrepareTxDescriptors(&iDESC_LIST_1_SP4A, &iDESC_LIST_2_SP4A, TX_SP4A_BUFFER_LCRSW0_BUF, TX_SP4A_BUFFER_LsLsrRsRsr0_BUF, 256, 4);
	PrepareTxDescriptors(&iDESC_LIST_5_SP3A, &iDESC_LIST_6_SP3A, TX_SP3A_BUFFER_ch9ch11ch10ch12_set0_BUF, TX_SP3A_BUFFER_ch13ch15ch14ch16_set0_BUF, 256, 4);
	PrepareTxDescriptors(&iDESC_LIST_9_SP6A, &iDESC_LIST_10_SP6A,TX_SP6A_BUFFER_ch17ch19ch18ch20_set0_BUF, TX_SP6A_BUFFER_ch21ch23ch22ch24_set0_BUF, 256, 4);
	PrepareTxDescriptors(&iDESC_LIST_13_SP6B, &iDESC_LIST_14_SP6B,TX_SP6B_BUFFER_ch25ch27ch26ch28_set0_BUF, TX_SP6B_BUFFER_ch29ch31ch30ch32_set0_BUF, 256, 4);
	PrepareTxDescriptors(&iDESC_LIST_17_SP2B, &iDESC_LIST_18_SP2B,TX_SP2B_BUFFER_ch33ch35ch34ch36_set0_BUF, TX_SP2B_BUFFER_ch37ch39ch38ch40_set0_BUF, 256, 4);

	iDESC_LIST_1_SP4A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_2_SP4A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_5_SP3A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_6_SP3A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_9_SP6A.Config  = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_10_SP6A.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_13_SP6B.Config  = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_14_SP6B.Config = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_17_SP2B.Config  = ENUM_DMA_CFG_XCNT_INT;
	iDESC_LIST_18_SP2B.Config = ENUM_DMA_CFG_XCNT_INT;
}
	   Result = adi_sport_DMATransfer(hSPORT0ARx,&iSRC_LIST_1_SP0A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
	   Result = adi_sport_DMATransfer(hSPORT0BRx,&iSRC_LIST_3_SP0B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);

if(I2S_TDM_MODE == I2S_MODE)
{
	Result = adi_sport_DMATransfer(hSPORT4ATx,&iDESC_LIST_1_SP4A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
	Result = adi_sport_DMATransfer(hSPORT4BTx,&iDESC_LIST_3_SP4B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
	Result = adi_sport_DMATransfer(hSPORT3ATx,&iDESC_LIST_5_SP3A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
	Result = adi_sport_DMATransfer(hSPORT3BTx,&iDESC_LIST_7_SP3B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
	Result = adi_sport_DMATransfer(hSPORT6ATx,&iDESC_LIST_9_SP6A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
	Result = adi_sport_DMATransfer(hSPORT2ATx,&iDESC_LIST_11_SP2A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
	Result = adi_sport_DMATransfer(hSPORT6BTx,&iDESC_LIST_13_SP6B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
	Result = adi_sport_DMATransfer(hSPORT7ATx,&iDESC_LIST_15_SP7A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
	Result = adi_sport_DMATransfer(hSPORT2BTx,&iDESC_LIST_17_SP2B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM_SEC);
}
else if(I2S_TDM_MODE == TDM_MODE)
{
	Result = adi_sport_DMATransfer(hSPORT4ATx,&iDESC_LIST_1_SP4A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	Result = adi_sport_DMATransfer(hSPORT3ATx,&iDESC_LIST_5_SP3A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	Result = adi_sport_DMATransfer(hSPORT6ATx,&iDESC_LIST_9_SP6A,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	Result = adi_sport_DMATransfer(hSPORT6BTx,&iDESC_LIST_13_SP6B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	Result = adi_sport_DMATransfer(hSPORT2BTx,&iDESC_LIST_17_SP2B,2,ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);

}

	/* This should be called only after setting up the DMA transfer */
if(I2S_TDM_MODE == I2S_MODE)
{
	/* Initialize array of SPORT handles in TX and RX groups */
	SportTxDai1Array0[0]= hSPORT4ATx;
	SportTxDai1Array0[1]= hSPORT4BTx;
	SportTxDai1Array0[2]= hSPORT6ATx;
	SportTxDai1Array0[3]= hSPORT6BTx;
	SportTxDai1Array0[4]= hSPORT7ATx;


	SportTxDai0Array[0]= hSPORT3ATx;
	SportTxDai0Array[1]= hSPORT3BTx;
	SportTxDai0Array[2]= hSPORT2ATx;
	SportTxDai0Array[3]= hSPORT2BTx;
	/* Create DAI0 TX Group 0 */
	Result = adi_sport_CreateGlobalGroup(SportTxDai0Array,4u,&hDai0Group0Tx,false,true);

	/* Create DAI1 TX Group 0 */
	Result = adi_sport_CreateGlobalGroup(SportTxDai1Array0,5u,&hDai1Group0Tx,false,true);

}
else if(I2S_TDM_MODE == TDM_MODE)
{
	SportTxDai1Array0[0]= hSPORT4ATx;
	SportTxDai1Array0[1]= hSPORT6ATx;
	SportTxDai1Array0[2]= hSPORT6BTx;
	
	Result = adi_sport_CreateGlobalGroup(SportTxDai1Array0,3u,&hDai1Group0Tx,false,true);
	
	SportTxDai0Array[0]= hSPORT3ATx;
	SportTxDai0Array[1]= hSPORT2BTx;
	Result = adi_sport_CreateGlobalGroup(SportTxDai0Array,2u,&hDai0Group0Tx,false,true);
}
		SportRxDai0Array[0]= hSPORT0ARx;
		SportRxDai0Array[1]= hSPORT0BRx;
		Result = adi_sport_CreateGlobalGroup(SportRxDai0Array,2u,&hDai0Group1Rx,false,true);


	   /* Register RX group callback */
		Result = adi_sport_GlobalRegisterCallback(hDai0Group1Rx, (ADI_CALLBACK)Rx_DMA_HANDLER, NULL);

	/* Register TX group callback */
		Result = adi_sport_GlobalRegisterCallback(hDai1Group0Tx, (ADI_CALLBACK)Tx_DMA_HANDLER, NULL);

}

/******************************************************************************
 *  Module Name        : SPORT_Recongifuration
 *  Functionality      : SPORT_Recongifuration Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
void SPORT_Recongifuration(void)
{

	adi_sport_GlobalEnable(false);

	 /* Destroy global groups */
	Clear_Global_Interrupt();
	adi_sport_GlobalRegisterCallback(hDai1Group0Tx, NULL, NULL);
	adi_sport_DestroyGlobalGroup(hDai1Group0Tx);
	adi_sport_DestroyGlobalGroup(hDai0Group0Tx);
	if(prev_I2S_TDM_Mode == I2S_MODE)
	{
	adi_sport_Close(hSPORT4ATx);
	adi_sport_Close(hSPORT4BTx);
	adi_sport_Close(hSPORT3ATx);
	adi_sport_Close(hSPORT3BTx);
	adi_sport_Close(hSPORT6ATx);
	adi_sport_Close(hSPORT2ATx);
	adi_sport_Close(hSPORT6BTx);
	adi_sport_Close(hSPORT7ATx);
	adi_sport_Close(hSPORT2BTx);
	}
	else
	{
		adi_sport_Close(hSPORT4ATx);
		adi_sport_Close(hSPORT3ATx);
		adi_sport_Close(hSPORT6ATx);
		adi_sport_Close(hSPORT6BTx);
		adi_sport_Close(hSPORT2BTx);

	}

	   adi_sport_GlobalRegisterCallback(hDai0Group1Rx, NULL, NULL);
	   adi_sport_DestroyGlobalGroup(hDai0Group1Rx);
	   adi_sport_Close(hSPORT0ARx);
	   adi_sport_Close(hSPORT0BRx);

	TX_Buf_Ptr_Allocation();

	DAI_Init();
	SPORT_Init();

	/* Set global enable bit */
	adi_sport_GlobalEnable(true);
	Set_Global_Interrupt();
}

#if defined (USE_MDMA_EXTCHANNEL) || defined (TX_NEW_LOGIC)
/**************************************************************************************************
 *  Module Name        : EXTMDMA_Init
 *  Functionality      : External Memory DMA Security bit configuration
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
void EXTMDMA_Init(void)
{

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

/**************************************************************************************************
 *  Module Name        : EXTMDMA_enable
 *  Functionality      : External DMA enable copy data from external predac buffer to internal buffer
 *  					 add offset to dest_buffer
 *  Input Parameters   : BuffSize, SrcBuff
 *  Output Parameters  : DstBuff
 **************************************************************************************************/
void EXTMDMA_Enable(int BuffSize, int SrcBuff, int DstBuff)
{
#ifdef DOWNSAMPLING_DTSX
	if((*DTSX_DS_Enable == 1)&&(*Stream_sample_rate == 512))
	{
		Src_2DMemXfer.pStartAddress  	= (void*)SrcBuff;
		Src_2DMemXfer.YCount			= 1u;
		Src_2DMemXfer.YModify			= 0;
		Src_2DMemXfer.XCount			= BuffSize*4/SMSIZE;
		Src_2DMemXfer.XModify			= SMSIZE*2;

		Dest_2DMemXfer.pStartAddress	= (void*)DstBuff;
		Dest_2DMemXfer.YCount			= 1u;
		Dest_2DMemXfer.YModify			= 0;
		Dest_2DMemXfer.XCount			= BuffSize*4/DMSIZE;
		Dest_2DMemXfer.XModify			= DMSIZE;

		adi_mdma_Copy2D(
								hMemDmaStream,
								ADI_DMA_MSIZE_4BYTES,
								&Dest_2DMemXfer,
								&Src_2DMemXfer);
	}
	else
	{
#endif //DOWNSAMPLING_DTSX
		adi_mdma_Copy1D(
						hMemDmaStream,
						(void*)DstBuff,
						(void*)SrcBuff,
						ADI_DMA_MSIZE_4BYTES,
						BuffSize);
#ifdef DOWNSAMPLING_DTSX
	}
#endif // DOWNSAMPLING_DTSX
}


#endif /* End of #if defined (USE_MDMA_EXTCHANNEL) || defined (TX_NEW_LOGIC)	*/

/**************************************************************************************************
 *  Module Name        : PCG_Init
 *  Functionality      : To enable the PCG C
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
void PCG_Init(void)
{
	if(I2S_TDM_MODE == I2S_MODE)
	{

	   ADI_PCG_CLK_INFO gClkInfo_C;
	        gClkInfo_C.eClkInput = ADI_PCG_CLK_EXT;                /* Clock Source */
	        gClkInfo_C.nDiv = Mclk_48Khz/64;                                  /* Clock Divisor */
	        gClkInfo_C.bExternalTrigger = false;                   /* External Trigger */

	   ADI_PCG_FS_INFO gFsInfo_C;
	        gFsInfo_C.eClkInput = (ADI_PCG_FRAMESYNC_SOURCE)ADI_PCG_CLK_EXT;                	  /* Clock Source */
	        gFsInfo_C.nDiv = Mclk_48Khz;                                    /* Frame Sync Divisor */
	        gFsInfo_C.nPulseWidth = (gFsInfo_C.nDiv)/2u;              /* Pulse Width */
	        gFsInfo_C.nPhase = gClkInfo_C.nDiv/2;                     /* Phase */
			gFsInfo_C.bExternalTrigger = false;                       /* External Trigger */
			gFsInfo_C.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;   /* Bypass Mode */

       adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo_C,&gFsInfo_C);
	}
	else if(I2S_TDM_MODE == TDM_MODE)
	{
		ADI_PCG_CLK_INFO gClkInfo_C;
			gClkInfo_C.eClkInput = ADI_PCG_CLK_EXT;                /* Clock Source */
			gClkInfo_C.nDiv = Mclk_48Khz/256;                                  /* Clock Divisor */
			gClkInfo_C.bExternalTrigger = false;                   /* External Trigger */

		ADI_PCG_FS_INFO gFsInfo_C;
			gFsInfo_C.eClkInput = (ADI_PCG_FRAMESYNC_SOURCE)ADI_PCG_CLK_EXT;                	  /* Clock Source */
			gFsInfo_C.nDiv = Mclk_48Khz;                                    /* Frame Sync Divisor */
			gFsInfo_C.nPulseWidth = (gFsInfo_C.nDiv)/256u;              /* Pulse Width */
			gFsInfo_C.nPhase = 0;									  /* Phase */
			gFsInfo_C.bExternalTrigger = false;                       /* External Trigger */
			gFsInfo_C.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;   /* Bypass Mode */

		adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo_C,&gFsInfo_C);
	}
	
	 Prev_Clock_Div_Value = Mclk_48Khz;
}
/**************************************************************************************************
 *  Module Name        : SPU_Init
 *  Functionality      : Initialize SPU Service and enabling the SPU
 *  Input Parameters   : None
 *  Output Parameters  : None
 **************************************************************************************************/
void SPU_Init(void)
{
    /* Memory required for the SPU operation */
    uint8_t SpuMemory[ADI_SPU_MEMORY_SIZE];

    /* SPU handle */
    ADI_SPU_HANDLE hSpu;

    ADI_SPU_RESULT eResult;

    /* Initialize SPU Service */
    eResult= adi_spu_Init(0u, SpuMemory, NULL, NULL, &hSpu);

	adi_spu_EnableMasterSecure(hSpu, SPORT5A_DMA_SPU_ID, true);

    adi_spu_EnableMasterSecure(hSpu, SPORT0A_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT0B_DMA_SPU_ID, true);

    adi_spu_EnableMasterSecure(hSpu, SPORT2A_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT3A_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT3B_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT4A_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT4B_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT6A_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT6B_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT7A_DMA_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, SPORT2B_DMA_SPU_ID, true);

    if (SPI_Device == 1)
    {
        adi_spu_EnableMasterSecure(hSpu, SPI1_RXDMA_SPU_ID, true);
		adi_spu_EnableMasterSecure(hSpu, SPI1_TXDMA_SPU_ID, true);
		
    }
    else
    {
        adi_spu_EnableMasterSecure(hSpu, SPI0_TXDMA_SPU_ID, true);
        adi_spu_EnableMasterSecure(hSpu, SPI0_RXDMA_SPU_ID, true);
    }
    adi_spu_EnableMasterSecure(hSpu, MDMA0_SRC_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, MDMA0_DST_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, MDMA3_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, MDMA1_SRC_SPU_ID, true);
    adi_spu_EnableMasterSecure(hSpu, MDMA1_DST_SPU_ID, true);

    


}
#ifdef TMU
/******************************************************************************
 *  Module Name        : TMU_Init
 *  Functionality      : Initialization of Temp_Measurement
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("Seg_Cmd_Code")
void TMU_Init()
{
	/* open the TMU driver */
				result = adi_tmu_Open(0u, TMUDriverMemory, (uint32_t)ADI_TMU_MEMORY_SIZE, &hDevice);
				if(result != ADI_TMU_SUCCESS)
				{
					REPORT_ERROR("Failed to open the TMU Device \n");
				}

		/* Configure the TMU for no Hardware Averaging, Continuous mode, SCLK Div as 3 */
				result = adi_tmu_ConfigureTMU(
						hDevice,
						true,
						true,
						false,
						3
				);
				if(result != ADI_TMU_SUCCESS)
				{
					REPORT_ERROR("Failed to open the TMU Device \n");
				}

				/* Enable TMU */
				result = adi_tmu_Enable(hDevice, true);
				if(result != ADI_TMU_SUCCESS)
				{
					REPORT_ERROR("Failed to open the TMU Device \n");
				}

				/* Enable Temperature conversion */
				result = adi_tmu_EnableConversion(hDevice, true);
				if(result != ADI_TMU_SUCCESS)
				{
					REPORT_ERROR("Failed to open the TMU Device \n");
				}

				/*Set Gain*/
				result = adi_tmu_SetGain_Raw(hDevice, 1.004);
				if(result != ADI_TMU_SUCCESS)
				{
					REPORT_ERROR("Failed to set Gain \n");
				}

				/*Set Offset*/
				result = adi_tmu_SetOffset(hDevice, -4.75);
				if(result != ADI_TMU_SUCCESS)
				{
					REPORT_ERROR("Failed to set Offset \n");
				}
}
/******************************************************************************
 *  Module Name        : TMU_Monitoring
 *  Functionality      : Temp_Measurement
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/

void TMU_Monitoring() // map to l3 
{
	/* Read the TMU temperature */
	result = adi_tmu_ReadTemperature(hDevice, &TMU_Value);
	if(result != ADI_TMU_SUCCESS)
	{
	REPORT_ERROR("Failed to open the TMU Device \n");
	}
}
#endif
