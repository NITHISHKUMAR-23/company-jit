/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Function_Prototype.h
*  Description      :   Function prototypes for various functions can be included here
******************************************************************************/

#include <stdint.h>
#include <drivers/spi/adi_spi_2156x.h>
#include "Commn.h"

#ifndef _Function_Prototype_H_
#define _Function_Prototype_H_

/*****************************************************************************
	Framework Modules
*****************************************************************************/
    void Tx_Rx_Mode_Command(void);
    void SPIReceive(void);

	void FreeMemoryAll(void);
	void SendInitializationDone(void);
	void Status_Update(void);
	void Status_Comparison(void);
	void SPORT_Recongifuration(void);
	void SendIRQInterrupt(void);

	void CommandProcessing(void);
	void Play_Command(void);
	void Stop_Command(void);
	void Mute_Command(void);
	void Resume_Command(void);
	void General_Decoding_Command(void);
	void SportInitialize_Command(void);
	void MPCM_Input_Command(void);

	void CommandProcessing_Core2(void);

	void Flag_Toggle(void);
	void Set_Global_Interrupt(void);
	void Clear_Global_Interrupt(void);
	void Init_Var_Fs(void);

	void EXTMDMA_Enable(int, int, int);

	int PlayForgnd(void);
	void Init_Var(void);
	void PackUpdate(void);
	void Pre_Dac_Ptr_Update(void);
	void AddPredac_Ptr_Update(void);
	void MCPCMDecoder(void);

	void Pack_TO_Predac_MCPCM(void);

#ifdef MDMA_COPY
	void Predac_Buffer_Int_To_Predac_Buffer_Ext(int BufSize, int SrcBuff, int DstBuff);
#else
	void Predac_Buffer_Int_To_Predac_Buffer_Ext(void);
#endif
	void Predac_Buffer_Ext_To_Predac_Buffer_Int_DMA(int,int,int);

	void Control_Data_Update(void);
	void PostProcessing_Routine(void);
	void Free_AllotMemoryPackDac( int, int, int);
	void SRU_Reconfigure(int,int);

#ifdef LED_TOGGLE
	void Led1_Set_Routine(void);
	void Initialize_Led1(void);
#endif

	void System_Initialization(void);

	void SPI1_GPIO_Init(void);
	void SH_SPI1_Master_Config(void);
	void SPI1_Init_DIT(uint32_t Fs);
	void Optical_Write(uint32_t );
	void SPI_Disable(void);
	void SPI_Delay(int i);
	void Init_SPI0(void);
	void ReInit_SPI0(void);
	void SPI0_RxCore_Handler (uint32_t, void *);
	void SPICS_Delay(void);


	void Set_Priority(void);
	void Kernal_Default_Init(void);
	void Enable_Cache(void);
	void SPI_Init(void);
	void DAI_Init(void);
	void SPORT_Init(void);
	void PCG_Init(void);
	void SRC_Init(void);
	void EXTMDMA_Init(void);
	int Init_Struct(void);

	void Default_Command_Config(void);

	int FlagsConfigure(void);
	void Init_PORTs(void);

	void AllocateMemoryKernel(void);
	void Wait_Core1(int*, int);

	void SPU_Init(void);

	int adi_sec_SetPriority(uint32_t, uint32_t);
	int adi_dai_init(uint8_t);
	void Rx_DMA_HANDLER(int, void *);
	void Tx_DMA_HANDLER(int, void *);
	void *memset(void*, int,size_t);
	void PCG_Clock_Divider(int, int);
	void Enable_SPI0(void);
	void PCG_Config(void);
	void Special_Function_Command(void);
#ifdef TMU
    void TMU_Init(void);
    void TMU_Monitoring(void);
#endif

    void TX_Buf_Ptr_Allocation(void);
#ifdef PCM_DECODER
	void PCMDecoder(void);
	void ClearLPCMDelay(void);
	void CopyINTLPCMtoDelayBuf(void);
	void CopyLPCMToPredac(void);
	void AllocateMemoryPCMDelay(int);
#endif // PCM_DECODER	
#ifdef DOWNSAMPLING
	void CopyLPCMToPack(void);
	void Pack_TO_Predac_Downsam(void);
	void Down_Samp_Processing(void);
	void Predac_Int_TO_Predac_ext(void);
	void Pack_To_Int_MCPCM(void);
	void Down_Samp_Processing_8ch(void);
	void Int_Predac_MCPCM(void);
#endif //DOWNSAMPLING
#ifdef DTSX_DECODER
	void DTS_Default_Command_config(void);
	void CHANNEL_REORDER_COMMAND(void);
	void DTSX_OPTIONS_COMMAND(void);
	void DTSX_Framework(void);
	void SRU_Reconfigure(int sample_fs_micro,int Output_SampleRate);
	void DTSX_Core2_Status_Update(void);
#ifdef TRUBASS
	void DTSX_PP_COMMAND(void);
	void DTSTrubass_Default_Command_config(void);
#endif //TRUBASS
#ifdef DTSX_MIPS_CALC
	void STIMER_DTSX(void);
	int ETIMER_DTSX(void);
	void DtsxCalculateMIPS(void);
#endif //DTSX_MIPS_CALC
#endif //DTSX_DECODER

#endif /* FUNCTION_PROTOTYPE_H_ */
