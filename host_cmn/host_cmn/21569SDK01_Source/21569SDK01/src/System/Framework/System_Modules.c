/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	System_Modules.c
*  Description      :
******************************************************************************/

#include "../Include/System_Modules.h"
#include "..\src\system\Include\Commn.h"

/**************************************************************************************************
 *  Module Name        : Autodetect_MemoryAlloc
 *  Functionality      : Pack,Predac Memory allocation for Auto-detect during switching

 *  Input Parameters   : None
 *  Output Parameters  : None
 *************************************************************************************************/
section("seg_kernal_code_l3")
void Autodetect_MemoryAlloc()
{
	Free_AllotMemoryPackDac(Frmwk.pack_length_mcpcm, Frmwk.predac_length_mcpcm, Frmwk.AddPreDac_length_mcpcm);
	Frmwk.SampleBlock = Frmwk.IOP.Predac.lengthhalf/8;
}
/**************************************************************************************************
 *  Module Name        : FreeMemoryAll
 *  Functionality      : Kernel I/O buffers should be cleared here
 *  Input Parameters   : None
 *  Output Parameters  : None
 *************************************************************************************************/
section("seg_kernal_code_l3")
void FreeMemoryAll()
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
section("seg_kernal_code_l3")
void Init_Var(void)
{
	Frmwk.IOP.LatencyDone			= 0;
	Frmwk.IOP.datacanbeprocessednow	= 0;
	Frmwk.IOP.DataValid             = 0;

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
section("seg_kernal_code_l3")
void Init_Var_Fs()
{
	Frmwk.IOP.LatencyDone			= 0;
	Frmwk.InitDoneForStreamType		= INVALID;
	Frmwk.IOP.datacanbeprocessednow	= 0;
	Frmwk.MemoryAllotMCLPCM			= 0;
	PP_process_cnt 					= 0;
}

/**************************************************************************************************
 *  Module Name        : Free_AllotMemoryPackDac
 *  Functionality      : Initializing Receiver & transmitter SPORT DMA buffer pointers, SPI buffer pointers
 *  Input Parameters   : size1, size2, val1
 *  Output Parameters  : None
*************************************************************************************************/
section("seg_kernal_code_l3")
void Free_AllotMemoryPackDac( int size1, int size2, int val1)
{
	Frmwk.Autdet.StreamDetectEnable   = 0;
	Frmwk.IOP.Pack.length 			  = size1;
	Frmwk.IOP.Pack.lengthhalf 		  = size1/TWO_HALF;

	Frmwk.IOP.Predac.length 	 	  = size2;
	Frmwk.IOP.Predac.lengthhalf  	  = size2/THREE_HALF;


	I_CCALL_(FreeMemoryAll);

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
			//Frmwk.IOP.AddPreDac.heap    = (int)AddPredac_buffer_ext;
			Frmwk.MemoryAllotDac          = 1;
		}


		Frmwk.IOP.Predac.wr_ptr		  	  = (int)Frmwk.IOP.Predac.heap;
		Frmwk.IOP.Predac.rd_ptr   		  = (int)Frmwk.IOP.Predac.heap;
		Frmwk.IOP.AddPreDac.length		  = val1;
		Frmwk.IOP.AddPreDac.lengthhalf	  = val1/THREE_HALF;
		Frmwk.IOP.AddPreDac.rd_ptr		  = (int)Frmwk.IOP.AddPreDac.heap;
		Frmwk.IOP.AddPreDac.wr_ptr		  = (int)Frmwk.IOP.AddPreDac.heap;
		Frmwk.Autdet.StreamDetectEnable   = 1;

	}

/**************************************************************************************************
 *  Module Name        : AllocateMemoryKernel
 *  Functionality      : Memory allocation for Transmitter and receiver DMA's
 *  Input Parameters   : None
 *  Output Parameters  : None
 *************************************************************************************************/
section("seg_kernal_code_l3")
void AllocateMemoryKernel()
{
	Frmwk.Autdet.InAutbuf_ptr	 			  = InAutobuf;

	Frmwk.Rx.DummyInAutbuf0_ptr				  = RX_SP0A_BUFFER_LR0;
	Frmwk.Rx.DummyInAutbuf1_ptr				  = RX_SP0A_BUFFER_LR1;
#ifdef MULTI_INPUT
	Frmwk.Rx.DummyInAutbuf2_ptr				  = RX_SP0B_BUFFER_CSW0;
	Frmwk.Rx.DummyInAutbuf3_ptr				  = RX_SP0B_BUFFER_CSW1;
	Frmwk.Rx.DummyInAutbuf4_ptr				  = RX_SP1A_BUFFER_LsRs0;
	Frmwk.Rx.DummyInAutbuf5_ptr				  = RX_SP1A_BUFFER_LsRs1;
	Frmwk.Rx.DummyInAutbuf6_ptr				  = RX_SP1B_BUFFER_LsrRsr0;
	Frmwk.Rx.DummyInAutbuf7_ptr				  = RX_SP1B_BUFFER_LsrRsr1;
#endif

		    Frmwk.Tx.dac_buf_LCRSw0_ptr 		= TX_SP4A_BUFFER_LCRSW0;
			Frmwk.Tx.dac_buf_LCRSw1_ptr			= TX_SP4A_BUFFER_LCRSW1;
			Frmwk.Tx.dac_buf_LsLsrRsRsr0_ptr	= TX_SP4B_BUFFER_LsLsrRsRsr0;
			Frmwk.Tx.dac_buf_LsLsrRsRsr1_ptr	= TX_SP4B_BUFFER_LsLsrRsRsr1;
			Frmwk.Tx.dac_buf_addch1ch3addch2ch4_set0_ptr = TX_SP3A_BUFFER_Addch1ch3Addch2ch4_set0;
			Frmwk.Tx.dac_buf_addch1ch3addch2ch4_set1_ptr = TX_SP3A_BUFFER_Addch1ch3Addch2ch4_set1;

				Frmwk.Tx.dac_buf_addch5ch7addch6ch8_set0_ptr = TX_SP3B_BUFFER_Addch5ch7Addch6ch8_set0;
				Frmwk.Tx.dac_buf_addch5ch7addch6ch8_set1_ptr = TX_SP3B_BUFFER_Addch5ch7Addch6ch8_set1;

				Frmwk.Tx.dac_buf_addch9ch11addch10ch12_set0_ptr = TX_SP2A_BUFFER_Addch9ch11Addch10ch12_set0;
				Frmwk.Tx.dac_buf_addch9ch11addch10ch12_set1_ptr = TX_SP2A_BUFFER_Addch9ch11Addch10ch12_set1;

				Frmwk.Tx.dac_buf_addch13ch15addch14ch16_set0_ptr = TX_SP5B_BUFFER_Addch13ch15Addch14ch16_set0;
				Frmwk.Tx.dac_buf_addch13ch15addch14ch16_set1_ptr = TX_SP5B_BUFFER_Addch13ch15Addch14ch16_set1;

		
	switch(Frmwk.autodetect_mode)
	{
	case AUTODETECT1:
		Frmwk.Misc.Control.ForcePcm = 0;
		Frmwk.LPCMDelaySize_host 	= 0;
		Frmwk.DOLBYDecoderEnable 	= 1;
		Frmwk.DDPLUSDecoderEnable	= 1;
		Frmwk.PCMEnable				= 1;
		Frmwk.MCLPCMEnable			= 0;
		Frmwk.ADCEnable				= 0;
		Frmwk.Autdet.autodetect3 	= 0;
		Frmwk.AACDecoderEnable      = 1;
		break;

	case AUTODETECT2:
		Frmwk.Misc.Control.ForcePcm = 1;
		if(Frmwk.LPCM_delay_index==0) Frmwk.LPCMDelaySize_host = 1024;
		else if(Frmwk.LPCM_delay_index==1) Frmwk.LPCMDelaySize_host = 2048;
		else if(Frmwk.LPCM_delay_index==2) Frmwk.LPCMDelaySize_host = 4096;
		else if(Frmwk.LPCM_delay_index==3) Frmwk.LPCMDelaySize_host = 12288;
		else if(Frmwk.LPCM_delay_index==4) Frmwk.LPCMDelaySize_host = 16384;
		Frmwk.SampleDropCount = Frmwk.LPCMDelaySize_host;
		Frmwk.PCMEnable = 1;
		Frmwk.MCLPCMEnable = 0;
		Frmwk.ADCEnable = 0;
		Frmwk.Autdet.autodetect3 = 0;
		Frmwk.AACDecoderEnable = 0;
		break;

	case AUTODETECT3:
		Frmwk.Misc.Control.ForcePcm = 0;
		Frmwk.LPCMDelaySize_host 	= 0;
		Frmwk.PCMEnable 			= 0;
		Frmwk.MCLPCMEnable 			= 0;
		Frmwk.Autdet.autodetect3 	= 1;
		Frmwk.ADCEnable 			= 0;
		Frmwk.TRUEHDDecoderEnable 	= 1;
		Frmwk.Rx.INPUTsamples_ptr 	= InAutobuf;
		//Frmwk.Misc.Control.InAutobufsizeby2 = Frmwk.Misc.Control.InAutobufsizeby2*4;
		Frmwk.Autdet.InAutbuf_ptr 	= Frmwk.Rx.INPUTsamples_ptr;
		Frmwk.Misc.Control.InAutobufsizeby2 = 64;
		Frmwk.AACDecoderEnable      = 0;
		break;

	case FORCEPCM3:
		Frmwk.Misc.Control.ForcePcm = 0;
		Frmwk.LPCMDelaySize_host 	= 0;
		Frmwk.PCMEnable				= 0;
		Frmwk.MCLPCMEnable			= 1;
		Frmwk.Autdet.autodetect3 	= 0;
		Frmwk.ADCEnable				= 0;
		Frmwk.MCLPCM_ON				= 1;
		Frmwk.MCLPCMEnable			= 1;
		Frmwk.AACDecoderEnable      = 0;
		break;

	default:
		break;
	}
}
/*void TX_Buf_Ptr_Allocation()
{
	if((I2S_TDM_MODE == I2S_MODE)|| (I2S_TDM_MODE == ASRC_MODE) ||(I2S_TDM_MODE == ASRC_TDM_MODE))
		{
			    Frmwk.Tx.dac_buf_LCRSw0_ptr 		= TX_SP4A_BUFFER_LCRSW0;
				Frmwk.Tx.dac_buf_LCRSw1_ptr			= TX_SP4A_BUFFER_LCRSW1;
				Frmwk.Tx.dac_buf_LsLsrRsRsr0_ptr	= TX_SP4B_BUFFER_LsLsrRsRsr0;
				Frmwk.Tx.dac_buf_LsLsrRsRsr1_ptr	= TX_SP4B_BUFFER_LsLsrRsRsr1;
				Frmwk.Tx.dac_buf_addch1ch3addch2ch4_set0_ptr = TX_SP3A_BUFFER_Addch1ch3Addch2ch4_set0;
				Frmwk.Tx.dac_buf_addch1ch3addch2ch4_set1_ptr = TX_SP3A_BUFFER_Addch1ch3Addch2ch4_set1;
				if(TX_DAC_Output_Ch_Cnt == 1 || TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
				{
				Frmwk.Tx.dac_buf_addch5ch7addch6ch8_set0_ptr = TX_SP3B_BUFFER_Addch5ch7Addch6ch8_set0;
				Frmwk.Tx.dac_buf_addch5ch7addch6ch8_set1_ptr = TX_SP3B_BUFFER_Addch5ch7Addch6ch8_set1;
				}
				if(TX_DAC_Output_Ch_Cnt == 2 || TX_DAC_Output_Ch_Cnt == 3)
				{
				Frmwk.Tx.dac_buf_addch9ch11addch10ch12_set0_ptr = TX_SP2A_BUFFER_Addch9ch11Addch10ch12_set0;
				Frmwk.Tx.dac_buf_addch9ch11addch10ch12_set1_ptr = TX_SP2A_BUFFER_Addch9ch11Addch10ch12_set1;
				}
				if(TX_DAC_Output_Ch_Cnt == 3)
				{
				Frmwk.Tx.dac_buf_addch13ch15addch14ch16_set0_ptr = TX_SP5B_BUFFER_Addch13ch15Addch14ch16_set0;
				Frmwk.Tx.dac_buf_addch13ch15addch14ch16_set1_ptr = TX_SP5B_BUFFER_Addch13ch15Addch14ch16_set1;
				}
		}
}*/
