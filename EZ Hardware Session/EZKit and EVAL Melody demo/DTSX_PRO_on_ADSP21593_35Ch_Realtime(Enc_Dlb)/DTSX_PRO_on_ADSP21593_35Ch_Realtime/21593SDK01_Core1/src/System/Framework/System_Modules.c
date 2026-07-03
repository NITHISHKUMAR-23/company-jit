/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	System_Modules.c
*  Description      : Variable Initialization, Memory allocation and PCG configuration routines are placed here.
******************************************************************************/
#pragma default_section(CODE,"Seg_System_Init_Code")
#pragma default_section(ALLDATA,"Seg_System_Init_Data")
#pragma default_section(SWITCH,"Seg_System_Init_Data")
#include "../Include/System_Modules.h"
#include "../Include/Function_Prototype.h"
#include "sru.h"

/**************************************************************************************************
 *  Module Name        : FreeMemoryAll
 *  Functionality      : Kernel I/O buffers should be cleared here
 *  Input Parameters   : None
 *  Output Parameters  : None
 *************************************************************************************************/
void FreeMemoryAll(void)
{
	if(Frmwk.MemoryAllotPack)
	{
		for(int i=0;i<Frmwk.IOP.Pack.length;i++)
		{
			Pack_buffer_ext[i]=0;
		}
		Frmwk.MemoryAllotPack = 0;
	}
	if(Frmwk.MemoryAllotDac)
	{
		for(int i=0;i<Frmwk.IOP.Predac.length;i++)
		{
			Predac_buffer_Ext[i]=0;
		}
		Frmwk.MemoryAllotDac=0;

#ifdef DTSX_DECODER
		Frmwk.MemoryAllotDTS = 0;   	// SRU configuration for while Switching PCM to DTSX
#endif //DTSX_DECODER

	}
}
/**************************************************************************************************
 *  Module Name        : Init_Var
 *  Functionality      : Variables which is need to be initialized to restart the system process for
 *  					any decoder switching and decoder error case should be placed here
						In this framework, Latency process & system process for decoder are initiated
						This function will be called during PLAY, STOP, SPORT INIT command & decoder error case
 *  Input Parameters   : None
 *  Output Parameters  : None
 *************************************************************************************************/
void Init_Var(void)
{
	Frmwk.IOP.LatencyDone			= 0;
	Frmwk.IOP.datacanbeprocessednow	= 0;
	Frmwk.IOP.DataValid             = 0;

#ifdef DTSX_DECODER
    Frmwk.DTSX.initdecoder					= 1;
	Frmwk.DTSX.nPrimaryFlags				= 26;
	*Parma_done = 0;
	*Rendering_done = 0;
	*Number_of_Objects = 0;
	*IMAX_Done = 0;
    *Type1cc_State = 0;
	*Downmix_Normalization = 0x7FFF;
	*Dialog_Interactivity = 0;
	Frmwk_DtsxCore2StatusValid		= 0;
	*Remapping_done = 0;

	Frmwk.DTSX.Status.Number_of_objects		= 0;
	Frmwk.DTSX.Status.Parma_done			= 0;
	Frmwk.DTSX.Status.Rendering_done 		= 0;
	Frmwk.DTSX.Status.Downmix_Normalization	= 0x7FFF;
	Frmwk.DTSX.Status.Dialog_Presence       = 0;
	Frmwk.DTSX.Status.Type1_Flag			= 0;
	Frmwk.DTSX.Status.Type1CC_State_Var     = 0;
	Frmwk.DTSX.Status.IMAX_Done				= 0;
	Frmwk.DTSX.Status.Remapping_Performed   = 0;
	Frmwk.DTSX.Status.Es_Flag               = 0;
	Frmwk.DTSX.Status.NeoX_Flag             = 0;
	Frmwk.DTSX.Status.DRC_Presence          = 0;
	Frmwk.DTSX.Status.DTSX_CoreFsize_Status = 0;
	Frmwk.DTSX.Status.DTS_AmbisonicStream   = 0;
	Frmwk.DTSX.Status.HeadPhoneStream       = 0;
	Frmwk.DTSX.Status.LtRtStream            = 0;
	Frmwk.DTSX.Status.LFE_Presence          = 0;
	Frmwk.DTSX.Status.ExtensionError        = 0;
#ifdef TRUBASS
	Frmwk.DTSX.Status.TruBass_Done	    = 0;
	*TruBassDone = 0;
#endif//TRUBASS

#endif	//DTSX_DECODER
}
/**************************************************************************************************
 *  Module Name        : Init_Var_Fs
 *  Functionality      : Variables which is need to be initialized to restart the
 *  					system process for decoder fs switching case should be placed here
						In this framework, Latency process & system process for decoder are initiated
						This function will be called in GENERAL_DECODING_COMMAND command Fs switching case

 *  Input Parameters   : None
 *  Output Parameters  : None
 *************************************************************************************************/
void Init_Var_Fs(void)
{
	Frmwk.IOP.LatencyDone			= 0;
	Frmwk.InitDoneForStreamType		= INVALID;
	Frmwk.IOP.datacanbeprocessednow	= 0;
	Frmwk.MemoryAllotMCLPCM			= 0;

#ifdef DTSX_DECODER
	Frmwk.InitDoneForFS = -1;
#endif //DTSX_DECODER

}

/**************************************************************************************************
 *  Module Name        : Free_AllotMemoryPackDac
 *  Functionality      : Initializing Receiver & transmitter SPORT DMA buffer pointers, SPI buffer pointers
 *  Input Parameters   : size1, size2, val1
 *  Output Parameters  : None
*************************************************************************************************/
void Free_AllotMemoryPackDac( int size1, int size2, int val1)
{
	Frmwk.Autdet.StreamDetectEnable   = 0;
	Frmwk.IOP.Pack.length 			  = size1;
	Frmwk.IOP.Pack.lengthhalf 		  = size1/TWO_HALF;



	FreeMemoryAll();

	if(Frmwk.MemoryAllotPack==0)
	{
		Frmwk.IOP.Pack.heap   		  = (int) Pack_buffer_ext;
		Frmwk.MemoryAllotPack 	  	  = 1;
	}
	Frmwk.IOP.Pack.rd_ptr			  = (int)Frmwk.IOP.Pack.heap;
	Frmwk.IOP.Pack.wr_ptr 			  = (int)Frmwk.IOP.Pack.heap;
	Frmwk.Autdet.HeaderAddress 		  = (int)Frmwk.IOP.Pack.heap;

	//After memory allocation of kernel I/O buffers, Re-initiate the stream detection process
	Frmwk.Autdet.AlignFlg   		  = 0;
	Frmwk.Autdet.MSGR_Save 			  = SYNCSIGUNKNOWN;
	Frmwk.Autdet.MSGR4 				  = SYNCSIGUNKNOWN;
	Frmwk.StreamType 				  = SYNCSIGUNKNOWN;
	if(Frmwk.MemoryAllotDac == 0)
	{
		Frmwk.IOP.Predac.heap     	  = (int)Predac_buffer_Ext;
#ifdef DTSX_DECODER
		Frmwk.IOP.AddPreDac.heap     =  (int)AddPredac_buffer_ext;
#endif // DTSX_DECODER
		Frmwk.MemoryAllotDac          = 1;
	}
	while(Frmwk.IOP.DataValid==1);
	#ifndef CORE1_TX
		*datacanbeprocessnow=0;
		Wait_Core1(core2_dcpn_done,0);
	#endif

	Frmwk.IOP.Predac.length 	 	  = size2;
	Frmwk.IOP.Predac.lengthhalf  	  = size2/THREE_HALF;
	Frmwk.IOP.Predac.wr_ptr		  	  = (int)Frmwk.IOP.Predac.heap;
	Frmwk.IOP.Predac.rd_ptr   		  = (int)Frmwk.IOP.Predac.heap;
	Frmwk.IOP.AddPreDac.length		  = val1;
	Frmwk.IOP.AddPreDac.lengthhalf	  = val1/THREE_HALF;
	Frmwk.IOP.AddPreDac.rd_ptr		  = (int)Frmwk.IOP.AddPreDac.heap;
	Frmwk.IOP.AddPreDac.wr_ptr		  = (int)Frmwk.IOP.AddPreDac.heap;
	Frmwk.Autdet.StreamDetectEnable   = 1;

	*predac_wr_ptr_c2   	  		  = (int)Frmwk.IOP.Predac.heap;
	*Predac_length			          = size2;
	*predac_heap                      = (int)Predac_buffer_Ext;
	*predac_wr_ptr		              = (int)Frmwk.IOP.Predac.heap;
	*Latency_predac_wr_ptr_c1         = (int)Frmwk.IOP.Predac.heap;
	*Init_Start_Command_c1            = 0;

	*addpredac_heap                   = (int)Frmwk.IOP.AddPreDac.heap;
	*addpredac_wr_ptr		          = (int)Frmwk.IOP.AddPreDac.heap;
	*addpredac_rd_ptr                 = (int)Frmwk.IOP.AddPreDac.heap;
	*addpredac_length                 = (int)Frmwk.IOP.AddPreDac.length;
}

/**************************************************************************************************
 *  Module Name        : AllocateMemoryKernel
 *  Functionality      : Memory allocation for Transmitter and receiver DMA's
 *  Input Parameters   : None
 *  Output Parameters  : None
 *************************************************************************************************/
void AllocateMemoryKernel(void)
{

#ifdef DTSX_DECODER
	int Address_store1, Address_store2;
	Address_store1 = (int)&InAutobuf[0];
	Frmwk.Autdet.InAutbuf_ptr = (int *)Address_store1;
#else
	Frmwk.Autdet.InAutbuf_ptr	 			  = InAutobuf;
#endif // DTSX_DECODER
	Frmwk.Rx.DummyInAutbuf0_ptr				  = RX_SP0A_BUFFER_LCRSW0;
	Frmwk.Rx.DummyInAutbuf1_ptr				  = RX_SP0A_BUFFER_LCRSW1;
	Frmwk.Rx.DummyInAutbuf2_ptr				  = RX_SP0B_BUFFER_LsLsrRsRsr0;
	Frmwk.Rx.DummyInAutbuf3_ptr				  = RX_SP0B_BUFFER_LsLsrRsRsr1;
	if(I2S_TDM_MODE == I2S_MODE)
	{
	Frmwk.Tx.dac_buf_LCRSw0_ptr 			  = TX_SP4A_BUFFER_LCRSW0;
	Frmwk.Tx.dac_buf_LCRSw1_ptr				  = TX_SP4A_BUFFER_LCRSW1;
	Frmwk.Tx.dac_buf_LsLsrRsRsr0_ptr		  = TX_SP4B_BUFFER_LsLsrRsRsr0;
	Frmwk.Tx.dac_buf_LsLsrRsRsr1_ptr		  = TX_SP4B_BUFFER_LsLsrRsRsr1;
	Frmwk.Tx.dac_buf_ch9ch11ch10ch12_set0_ptr = TX_SP3A_BUFFER_ch9ch11ch10ch12_set0;
	Frmwk.Tx.dac_buf_ch9ch11ch10ch12_set1_ptr = TX_SP3A_BUFFER_ch9ch11ch10ch12_set1;
	Frmwk.Tx.dac_buf_ch13ch15ch14ch16_set0_ptr = TX_SP3B_BUFFER_ch13ch15ch14ch16_set0;
	Frmwk.Tx.dac_buf_ch13ch15ch14ch16_set1_ptr = TX_SP3B_BUFFER_ch13ch15ch14ch16_set1;
	Frmwk.Tx.dac_buf_ch17ch19ch18ch20_set0_ptr = TX_SP6A_BUFFER_ch17ch19ch18ch20_set0;
	Frmwk.Tx.dac_buf_ch17ch19ch18ch20_set1_ptr = TX_SP6A_BUFFER_ch17ch19ch18ch20_set1;
	Frmwk.Tx.dac_buf_ch21ch23ch22ch24_set0_ptr = TX_SP2A_BUFFER_ch21ch23ch22ch24_set0;
	Frmwk.Tx.dac_buf_ch21ch23ch22ch24_set1_ptr = TX_SP2A_BUFFER_ch21ch23ch22ch24_set1;
	Frmwk.Tx.dac_buf_ch25ch27ch26ch28_set0_ptr = TX_SP6B_BUFFER_ch25ch27ch26ch28_set0;
	Frmwk.Tx.dac_buf_ch25ch27ch26ch28_set1_ptr = TX_SP6B_BUFFER_ch25ch27ch26ch28_set1;
	Frmwk.Tx.dac_buf_ch29ch31ch30ch32_set0_ptr = TX_SP7A_BUFFER_ch29ch31ch30ch32_set0;
	Frmwk.Tx.dac_buf_ch29ch31ch30ch32_set1_ptr = TX_SP7A_BUFFER_ch29ch31ch30ch32_set1;
	Frmwk.Tx.dac_buf_ch33ch35ch34ch36_set0_ptr = TX_SP2B_BUFFER_ch33ch35ch34ch36_set0;
	Frmwk.Tx.dac_buf_ch33ch35ch34ch36_set1_ptr = TX_SP2B_BUFFER_ch33ch35ch34ch36_set1;
	}
	else if(I2S_TDM_MODE == TDM_MODE)
	{
		Frmwk.Tx.dac_buf_LCRSw0_ptr 				= TX_SP4A_BUFFER_LCRSW0;
		Frmwk.Tx.dac_buf_LCRSw1_ptr					= TX_SP4B_BUFFER_LsLsrRsRsr0;

		Frmwk.Tx.dac_buf_ch9ch11ch10ch12_set0_ptr 	= TX_SP3A_BUFFER_ch9ch11ch10ch12_set0;
		Frmwk.Tx.dac_buf_ch9ch11ch10ch12_set1_ptr 	= TX_SP3B_BUFFER_ch13ch15ch14ch16_set0;

		Frmwk.Tx.dac_buf_ch17ch19ch18ch20_set0_ptr  = TX_SP6A_BUFFER_ch17ch19ch18ch20_set0;
		Frmwk.Tx.dac_buf_ch17ch19ch18ch20_set1_ptr  = TX_SP2A_BUFFER_ch21ch23ch22ch24_set0;

		Frmwk.Tx.dac_buf_ch25ch27ch26ch28_set0_ptr  = TX_SP6B_BUFFER_ch25ch27ch26ch28_set0;
		Frmwk.Tx.dac_buf_ch25ch27ch26ch28_set1_ptr  = TX_SP7A_BUFFER_ch29ch31ch30ch32_set0;

		Frmwk.Tx.dac_buf_ch33ch35ch34ch36_set0_ptr  = TX_SP2B_BUFFER_ch33ch35ch34ch36_set0;
		Frmwk.Tx.dac_buf_ch33ch35ch34ch36_set1_ptr  = TX_SP2B_BUFFER_ch37ch39ch38ch40_set0;

		TX_SP4A_BUFFER_LCRSW0_BUF 					= &TX_SP4A_BUFFER_LCRSW0[0];
		TX_SP4A_BUFFER_LsLsrRsRsr0_BUF				= &TX_SP4B_BUFFER_LsLsrRsRsr0[0];
		TX_SP3A_BUFFER_ch9ch11ch10ch12_set0_BUF  	= &TX_SP3A_BUFFER_ch9ch11ch10ch12_set0[0];
		TX_SP3A_BUFFER_ch13ch15ch14ch16_set0_BUF 	= &TX_SP3B_BUFFER_ch13ch15ch14ch16_set0[0];
		TX_SP6A_BUFFER_ch17ch19ch18ch20_set0_BUF	= &TX_SP6A_BUFFER_ch17ch19ch18ch20_set0[0];
		TX_SP6A_BUFFER_ch21ch23ch22ch24_set0_BUF	= &TX_SP2A_BUFFER_ch21ch23ch22ch24_set0[0];

		TX_SP6B_BUFFER_ch25ch27ch26ch28_set0_BUF  	= &TX_SP6B_BUFFER_ch25ch27ch26ch28_set0[0];
		TX_SP6B_BUFFER_ch29ch31ch30ch32_set0_BUF 	= &TX_SP7A_BUFFER_ch29ch31ch30ch32_set0[0];

		TX_SP2B_BUFFER_ch33ch35ch34ch36_set0_BUF	= &TX_SP2B_BUFFER_ch33ch35ch34ch36_set0[0];
		TX_SP2B_BUFFER_ch37ch39ch38ch40_set0_BUF	= &TX_SP2B_BUFFER_ch37ch39ch38ch40_set0[0];
	}

	switch(Frmwk.autodetect_mode)
	{
#if defined (PCM_DECODER) || defined(MCPCM_DECODER)
		case AUTODETECT1:
			Frmwk.Misc.Control.ForcePcm = 0;
			Frmwk.LPCMDelaySize_host = 0;
			Frmwk.PCMEnable=1;
			Frmwk.MCLPCMEnable=0;
			Frmwk.ADCEnable=0;
			Frmwk.Autdet.autodetect3 = 0;
			break;
#endif //defined (PCM_DECODER) || defined(MCPCM_DECODER)
		case FORCEPCM3:
			Frmwk.Misc.Control.ForcePcm = 0;
			Frmwk.LPCMDelaySize_host 	= 0;
			Frmwk.PCMEnable				= 0;
			Frmwk.MCLPCMEnable = 1;
			Frmwk.Autdet.autodetect3 	= 0;
			Frmwk.ADCEnable				= 0;
			Frmwk.MCLPCM_ON				= 1;
			break;
#ifdef DTSX_DECODER			
		case AUTODETECT3:
			Frmwk.Misc.Control.ForcePcm = 0;
			Frmwk.LPCMDelaySize_host = 0;
			Frmwk.PCMEnable = 0;
			Frmwk.MCLPCMEnable = 0;
			Frmwk.Autdet.autodetect3 = 1;
			Frmwk.ADCEnable = 0;
			Address_store2 = (int)&InAutobuf[0];
			Frmwk.Rx.INPUTsamples_ptr = (int *)Address_store2;	
			Frmwk.Autdet.InAutbuf_ptr = Frmwk.Rx.INPUTsamples_ptr ;
			break;
#endif // DTSX_DECODER
		default:
		break;
	}
}

/**************************************************************************************************
 *  Module Name        : SRU_Reconfigure
 *  Functionality      : Reconfiguring PCG clock based on input and output sample rate
 *  Input Parameters   : Clock_Div_Value
 *  Output Parameters  :
 *************************************************************************************************/
void SRU_Reconfigure(int sample_fs_micro,int Output_SampleRate)
{
	PCG_Clock_Divider(sample_fs_micro, Output_SampleRate);

	if(Prev_Clock_Div_Value != Clock_Div_Value)
	{
		if(I2S_TDM_MODE == I2S_MODE)
			{
			  ADI_PCG_CLK_INFO gClkInfo;
					gClkInfo.eClkInput = ADI_PCG_CLK_EXT;              /* Clock Source */
					gClkInfo.nDiv = Clock_Div_Value/64;                /* Clock Divisor */
					gClkInfo.bExternalTrigger = false;                 /* External Trigger */

			  ADI_PCG_FS_INFO gFsInfo;
					gFsInfo.eClkInput = (ADI_PCG_FRAMESYNC_SOURCE)ADI_PCG_CLK_EXT;                   /* Clock Source */
					gFsInfo.nDiv = Clock_Div_Value;                        /* Frame Sync Divisor */
					gFsInfo.nPulseWidth = (gFsInfo.nDiv)/2u;               /* Pulse Width */
					gFsInfo.nPhase = gClkInfo.nDiv/2;                      /* Phase */
					gFsInfo.bExternalTrigger = false;                      /* External Trigger */
					gFsInfo.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;  /* Bypass Mode */

			  adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo,&gFsInfo);
			}
		else if(I2S_TDM_MODE == TDM_MODE)
		{
			 ADI_PCG_CLK_INFO gClkInfo;
					gClkInfo.eClkInput = ADI_PCG_CLK_EXT;              	 /* Clock Source */
					gClkInfo.nDiv = Clock_Div_Value/256;                       			 /* Clock Divisor */
					gClkInfo.bExternalTrigger = false;                   /* External Trigger */
			 ADI_PCG_FS_INFO gFsInfo;
			 	 	gFsInfo.eClkInput = (ADI_PCG_FRAMESYNC_SOURCE)ADI_PCG_CLK_EXT;            	/* Clock Source */
					gFsInfo.nDiv = Clock_Div_Value;                                    /* Frame Sync Divisor */
					gFsInfo.nPulseWidth = (gFsInfo.nDiv)/256u;                /* Pulse Width */
					gFsInfo.nPhase = 0;                       /* Phase */
					gFsInfo.bExternalTrigger = false;                       /* External Trigger */
					gFsInfo.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;   /* Bypass Mode */

					  adi_pcg_Init(ADI_PCG_DEV_C,&gClkInfo,&gFsInfo);
		}
		Prev_Clock_Div_Value = Clock_Div_Value;
	}

#ifdef OPTICAL_MODULE
	if(Prev_OutputSampleRate != Output_SampleRate)
	{
		SPI1_Init_DIT(Output_SampleRate);
		Prev_OutputSampleRate = Output_SampleRate;
		SRU(SPT2_AD0_O,DAI0_PB03_I);	//To reconnect SPORT & DAI after Optical Module CHIP SELECTION
	}
#endif
}
/**************************************************************************************************
 *  Module Name        : PCG_Clock_Divider
 *  Functionality      : PCG Clock_Divider calculation based on input and output sample rate
 *  Input Parameters   : sample_fs_micro,
 *  Output Parameters  : Output_SampleRate
 *************************************************************************************************/
void PCG_Clock_Divider(int sample_fs_micro,int Output_SampleRate)
{
#ifdef eARC_ENABLE
	if(eARC_Mode == 1)		//Melody9 Platform
	{
		if(Frmwk.autodetect_mode == AUTODETECT3)
		{
			SRU(HIGH,DAI1_PBEN12_I);
			SRU(DAI1_PB07_O,PCG0_EXTCLKD_I);     // MCLK to PCG-D

			SRU(PCG0_CLKD_O, DAI1_PB12_I);
			SRU(DAI1_PB12_O,PCG0_EXTCLKC_I);     // PCG-D to PCG-C

			ADI_PCG_CLK_INFO gClkInfo_D;
			gClkInfo_D.eClkInput 		= ADI_PCG_CLK_EXT;			/* Clock Source */
			gClkInfo_D.nDiv 			= 4;						/* Clock Divisor */
			gClkInfo_D.bExternalTrigger = false;					/* External Trigger */

			ADI_PCG_FS_INFO gFsInfo_D;
			gFsInfo_D.eClkInput = ADI_PCG_FS_EXT;                     /* Clock Source */
			gFsInfo_D.nDiv = 4;      				      /* Frame Sync Divisor */
			gFsInfo_D.nPulseWidth = (gFsInfo_D.nDiv)/2u;                         /* Pulse Width */
			gFsInfo_D.nPhase = gClkInfo_D.nDiv/2;                              /* Phase */
			gFsInfo_D.bExternalTrigger = true;                        /* External Trigger */
			gFsInfo_D.eFsBypassMode = ADI_PCG_FSBYPASS_MODE_NORMAL;   /* Bypass Mode */

			adi_pcg_Init(ADI_PCG_DEV_D,&gClkInfo_D,&gFsInfo_D);
		}
		Clock_Div_Value = ((eARC_Clock_Ratio*Freq_Table_SRU[sample_fs_micro])/Freq_Table_SRU[Output_SampleRate]);
	}
	else
		{
#endif


		if((sample_fs_micro == FS_48K)||(sample_fs_micro == FS_44K)||(sample_fs_micro == FS_32K))
		{
			Clock_Div_Value = ((Freq_Table_SRU[sample_fs_micro]*Mclk_48Khz)/Freq_Table_SRU[Output_SampleRate]);
		}
		else if((sample_fs_micro == FS_96K)||(sample_fs_micro == FS_88K)||(sample_fs_micro == FS_64K))
		{
			Clock_Div_Value = (Freq_Table_SRU[sample_fs_micro]*Mclk_96Khz)/Freq_Table_SRU[Output_SampleRate];
		}
		else if((sample_fs_micro == FS_192K)||(sample_fs_micro == FS_176K)||(sample_fs_micro == FS_128K))
		{
			Clock_Div_Value = (Freq_Table_SRU[sample_fs_micro]*Mclk_192Khz)/Freq_Table_SRU[Output_SampleRate];
		}

	}
#ifdef eARC_ENABLE
}
#endif

void TX_Buf_Ptr_Allocation( )
{

	if(I2S_TDM_MODE == I2S_MODE)
	{
		Frmwk.Tx.dac_buf_LCRSw0_ptr 			  		= TX_SP4A_BUFFER_LCRSW0;
		Frmwk.Tx.dac_buf_LCRSw1_ptr				  		= TX_SP4A_BUFFER_LCRSW1;
		Frmwk.Tx.dac_buf_LsLsrRsRsr0_ptr		  		= TX_SP4B_BUFFER_LsLsrRsRsr0;
		Frmwk.Tx.dac_buf_LsLsrRsRsr1_ptr		  		= TX_SP4B_BUFFER_LsLsrRsRsr1;
		Frmwk.Tx.dac_buf_ch9ch11ch10ch12_set0_ptr 		= TX_SP3A_BUFFER_ch9ch11ch10ch12_set0;
		Frmwk.Tx.dac_buf_ch9ch11ch10ch12_set1_ptr 		= TX_SP3A_BUFFER_ch9ch11ch10ch12_set1;
		Frmwk.Tx.dac_buf_ch13ch15ch14ch16_set0_ptr 		= TX_SP3B_BUFFER_ch13ch15ch14ch16_set0;
		Frmwk.Tx.dac_buf_ch13ch15ch14ch16_set1_ptr 		= TX_SP3B_BUFFER_ch13ch15ch14ch16_set1;
		Frmwk.Tx.dac_buf_ch17ch19ch18ch20_set0_ptr 		= TX_SP6A_BUFFER_ch17ch19ch18ch20_set0;
		Frmwk.Tx.dac_buf_ch17ch19ch18ch20_set1_ptr		= TX_SP6A_BUFFER_ch17ch19ch18ch20_set1;
		Frmwk.Tx.dac_buf_ch21ch23ch22ch24_set0_ptr 		= TX_SP2A_BUFFER_ch21ch23ch22ch24_set0;
		Frmwk.Tx.dac_buf_ch21ch23ch22ch24_set1_ptr		= TX_SP2A_BUFFER_ch21ch23ch22ch24_set1;
		Frmwk.Tx.dac_buf_ch25ch27ch26ch28_set0_ptr		= TX_SP6B_BUFFER_ch25ch27ch26ch28_set0;
		Frmwk.Tx.dac_buf_ch25ch27ch26ch28_set1_ptr	    = TX_SP6B_BUFFER_ch25ch27ch26ch28_set1;
		Frmwk.Tx.dac_buf_ch29ch31ch30ch32_set0_ptr		= TX_SP7A_BUFFER_ch29ch31ch30ch32_set0;
		Frmwk.Tx.dac_buf_ch29ch31ch30ch32_set1_ptr		= TX_SP7A_BUFFER_ch29ch31ch30ch32_set1;
		Frmwk.Tx.dac_buf_ch33ch35ch34ch36_set0_ptr		= TX_SP2B_BUFFER_ch33ch35ch34ch36_set0;
		Frmwk.Tx.dac_buf_ch33ch35ch34ch36_set1_ptr		= TX_SP2B_BUFFER_ch33ch35ch34ch36_set1;
	}
	else if(I2S_TDM_MODE == TDM_MODE)
	{
		Frmwk.Tx.dac_buf_LCRSw0_ptr 				= TX_SP4A_BUFFER_LCRSW0;
		Frmwk.Tx.dac_buf_LCRSw1_ptr					= TX_SP4B_BUFFER_LsLsrRsRsr0;

		Frmwk.Tx.dac_buf_ch9ch11ch10ch12_set0_ptr 	= TX_SP3A_BUFFER_ch9ch11ch10ch12_set0;
		Frmwk.Tx.dac_buf_ch9ch11ch10ch12_set1_ptr 	= TX_SP3B_BUFFER_ch13ch15ch14ch16_set0;

		Frmwk.Tx.dac_buf_ch17ch19ch18ch20_set0_ptr  = TX_SP6A_BUFFER_ch17ch19ch18ch20_set0;
		Frmwk.Tx.dac_buf_ch17ch19ch18ch20_set1_ptr  = TX_SP2A_BUFFER_ch21ch23ch22ch24_set0;

		Frmwk.Tx.dac_buf_ch25ch27ch26ch28_set0_ptr  = TX_SP6B_BUFFER_ch25ch27ch26ch28_set0;
		Frmwk.Tx.dac_buf_ch25ch27ch26ch28_set1_ptr  = TX_SP7A_BUFFER_ch29ch31ch30ch32_set0;

		Frmwk.Tx.dac_buf_ch33ch35ch34ch36_set0_ptr  = TX_SP2B_BUFFER_ch33ch35ch34ch36_set0;
		Frmwk.Tx.dac_buf_ch33ch35ch34ch36_set1_ptr  = TX_SP2B_BUFFER_ch37ch39ch38ch40_set0;

		TX_SP4A_BUFFER_LCRSW0_BUF 					= &TX_SP4A_BUFFER_LCRSW0[0];
		TX_SP4A_BUFFER_LsLsrRsRsr0_BUF				= &TX_SP4B_BUFFER_LsLsrRsRsr0[0];
		TX_SP3A_BUFFER_ch9ch11ch10ch12_set0_BUF  	= &TX_SP3A_BUFFER_ch9ch11ch10ch12_set0[0];
		TX_SP3A_BUFFER_ch13ch15ch14ch16_set0_BUF 	= &TX_SP3B_BUFFER_ch13ch15ch14ch16_set0[0];
		TX_SP6A_BUFFER_ch17ch19ch18ch20_set0_BUF	= &TX_SP6A_BUFFER_ch17ch19ch18ch20_set0[0];
		TX_SP6A_BUFFER_ch21ch23ch22ch24_set0_BUF	= &TX_SP2A_BUFFER_ch21ch23ch22ch24_set0[0];

		TX_SP6B_BUFFER_ch25ch27ch26ch28_set0_BUF  	= &TX_SP6B_BUFFER_ch25ch27ch26ch28_set0[0];
		TX_SP6B_BUFFER_ch29ch31ch30ch32_set0_BUF 	= &TX_SP7A_BUFFER_ch29ch31ch30ch32_set0[0];

		TX_SP2B_BUFFER_ch33ch35ch34ch36_set0_BUF	= &TX_SP2B_BUFFER_ch33ch35ch34ch36_set0[0];
		TX_SP2B_BUFFER_ch37ch39ch38ch40_set0_BUF	= &TX_SP2B_BUFFER_ch37ch39ch38ch40_set0[0];

	}
}

