/*****************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Decoder_Core2.c
*  Description      :   Decoder routines

******************************************************************************/
/******************************************************************************/
#pragma default_section(CODE,"Seg_Decoder_Core2")
#pragma default_section(ALLDATA,"Seg_Decoder_Core2_Data")
#include "..\src\System\Include\Decoder_Core2.h"
#include "..\src\System\Include\Function_Prototype.h"


/******************************************************************************
*  Module Name        : PlayForgnd
*  Functionality      : All Decoders wrapper should be placed here, 
*						In addition to the decoder wrapper, Memory allocation of Kernel I/O Buffers for decoder will be done here
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/
int PlayForgnd(void)
{
	Frmwk.Init_begin_core2	= *Init_Start_Command_c1;

#ifdef MCPCM_DECODER
	Frmwk.StreamType=0xF;
	Frmwk.MCLPCMEnable=1;
	if((Frmwk.StreamType==0xF)&&(Frmwk.MCLPCMEnable==1))
	{
		/* Check if there is a necessity for Allocating Memory */
		if(Frmwk.InitDoneForStreamType!= Frmwk.StreamType)
		{
			if(Free_AllotMemoryPackDac(Frmwk.pack_length_mcpcm, Frmwk.predac_length_mcpcm, 1)==1)
			{
				return 1;
			}

			FreeMemoryAll();									/* Free Previously allocated memory */
			Frmwk.Stream_Profile            = *Stream_Profile;
			Stream_Type_frm_Core1 	        = *stream_type;
			Frmwk.IOP.Predac.length	    	= *Predac_length;
			Frmwk.IOP.Predac.lengthhalf	    = *Predac_length_half;
			Frmwk.SampleBlock				= SAMPLE_BLOCK_MCPCM;
			Frmwk.Max_No_of_channel		    = NO_OF_PREDAC_CHANNEL;  /* Initialise stream detection variables to start fresh detection */
			BufSize                         = (Frmwk.SampleBlock*Frmwk.Max_No_of_channel);
			Frmwk.InitDoneForStreamType 	= 0xF;
			Init_Var();											//  General Initialization routine
			Frmwk.ADI_DecoderError 			= 2;
			return 0;
		}
		else
		{
			MCPCMDecoder();
			return 0;
		}
	}
#endif
	return 0;
}

#ifdef MCPCM_DECODER
void MCPCMDecoder(void)
{
	Frmwk.ADI_DecoderError = NO_ERROR;
	while(1)
	{
		int i,j;
		if(Frmwk.IOP.datacanbeprocessednow == 0)
		{
			Frmwk.IOP.Predac.rd_ptr_c2 		=*Latency_predac_wr_ptr_c1 ;
			Frmwk.IOP.Predac.wr_ptr_c2 		=*Latency_predac_wr_ptr_c1 ;
			*predac_wr_ptr_c1               =*Latency_predac_wr_ptr_c1 ;
			Frmwk.IOP.AddPreDac.heap		=*addpredac_heap;
			Frmwk.IOP.AddPreDac.rd_ptr_c2	=*addpredac_rd_ptr;
		    Frmwk.IOP.AddPreDac.wr_ptr_c2	=*addpredac_wr_ptr;
		    Frmwk.IOP.AddPreDac.length		=*addpredac_length;
		    Frmwk.IOP.AddPreDac.lengthhalf 	=*addpredac_lengthhalf;

			for(int i=0;i<BufSize;i++)
			{
				Predac_buffer_Int_c2[i]=0;
			}
			Frmwk.IOP.datacanbeprocessednow = 1;

#ifdef DTSX_DECODER
			Frmwk.DTSX.DTSXcommandprocessingdone_c2 = *Cmd_processing_dne;
#ifdef TRUBASS
			Frmwk.DTSX.TBHDX_CommandProcessingDone = *TBassCmd_processing_dne;
#endif //TRUBASS
#endif  //DTSX_DECODER
		}

		Frmwk.IOP.Predac.wr_ptr_c1=*predac_wr_ptr_c1;

		i = Frmwk.IOP.Predac.wr_ptr_c1-Frmwk.IOP.Predac.rd_ptr_c2;

		if(i < 0)
		{
			i = i + ((Frmwk.IOP.Predac.length)*4);
		}

#ifdef DTSX_DECODER
		   if(Frmwk.Stream_Profile == DTSX_STREAM_PROFILE)
		   {
				if((i - (((*Stream_sample_rate)*Frmwk.Max_No_of_channel)*4*2))  < 0)
				{
					Frmwk.ADI_DecoderError = 3 ;
					break;
				}

			}

		else
		{
#endif //DTSX_DECODER
			if((i - ((Frmwk.SampleBlock*Frmwk.Max_No_of_channel)*4))  < 0)
			{
				Frmwk.ADI_DecoderError = FILLED_SPACE_ERROR;
				break;
			}
#ifdef DTSX_DECODER			
		}
#endif // DTSX_DECODER
		Control_DataVariable_Update();
		*core2_sync_bit=1;
#ifdef DTSX_LATENCY_CALC
		DTSX_Latency_predac_rd_ptr_c2 = (int*)Frmwk.IOP.Predac.rd_ptr_c2;
		if(*DTSX_latency_state_frm_c1 == 1)
		{
			if(DTSX_Latency_predac_rd_ptr_c2[0] == 0x12345678)
			{
				DTSX_Latency_stat_var_c2 = 1;
				*DTSX_latency_state_frm_c1 = 0;
			}
		}
#endif// DTSX_LATENCY_CALC

#ifdef MDMA_COPY
		int BufSize_remain = 0,BufSize_MDMA = 0;
		Predac_Length_Ptr=Frmwk.IOP.Predac.heap+(Frmwk.IOP.Predac.length*4);
		bMemCopyInProgress_check = true;
		SrcBuf=Frmwk.IOP.Predac.rd_ptr_c2;
#ifdef DOWNSAMPLING_DTSX		
		if((*DTSX_DS_Enable == 1)&&(*Stream_sample_rate == 512))
		{
			BufSize_MDMA=(Frmwk.SampleBlock*Frmwk.Max_No_of_channel*2);
			DstBuf=(int)&Dtsx_DS_Ext_in[0];
		}
		else	
		{
#endif // DOWNSAMPLING_DTSX	
			BufSize_MDMA=(Frmwk.SampleBlock*Frmwk.Max_No_of_channel);
			DstBuf=(int)&Predac_buffer_Int_c2[0];
#ifdef DOWNSAMPLING_DTSX
		}
#endif // DOWNSAMPLING_DTSX	
		if((Predac_Length_Ptr-SrcBuf)<(Frmwk.SampleBlock*Frmwk.Max_No_of_channel*4))
		{
			BufSize_remain=(Predac_Length_Ptr-SrcBuf)/4;
			MDMA_Copy(BufSize_remain, SrcBuf, DstBuf);
			while(bMemCopyInProgress_check)
			{
				adi_mdma_IsCopyInProgress (hMemDmaStream2, &bMemCopyInProgress_check);
			}
				BufSize_MDMA=BufSize_MDMA-BufSize_remain;
			SrcBuf=Frmwk.IOP.Predac.heap;
			DstBuf=DstBuf+(BufSize_remain*4);
		}
		bMemCopyInProgress_check = true;
			MDMA_Copy(BufSize_MDMA, SrcBuf, DstBuf);

		while(bMemCopyInProgress_check)
		{
			adi_mdma_IsCopyInProgress (hMemDmaStream2, &bMemCopyInProgress_check);
		}

	#else
#ifdef DOWNSAMPLING_DTSX
		if((*DTSX_DS_Enable == 1)&&(*Stream_sample_rate == 512))
		{
			DTSX_DS_buff_cpy_flag = 1;
		}
		else
		{
			DTSX_DS_buff_cpy_flag = 0;
		}
#endif // DOWNSAMPLING_DTSX
		Predac_buffer_to_Predac_buffer_Int();
	#endif

			PostProcessing_Routine();
#ifndef CHANNEL_VALIDATION
if(Channel_36_Route==1)
{
#ifdef OPTICAL_TESTING
	if(optical_testing == 0)
	{
#endif //OPTICAL_TESTING
		Routing_To_Predac_buffer();
#ifdef OPTICAL_TESTING
	}
	else
	{
		Routing_To_Predac_buffer_optical_final();
	}
#endif //OPTICAL_TESTING
}
else
#endif
{
#ifdef OPTICAL_TESTING
	if(optical_testing == 0)
	{
#endif //OPTICAL_TESTING
		Predac_buffer_Int_to_Predac_buffer();
#ifdef OPTICAL_TESTING
	}
	else
	{
		Routing_To_Predac_buffer_optical();
	}
#endif //OPTICAL_TESTING
}

#ifdef DTSX_LATENCY_CALC
		DTSX_Latency_predac_wr_ptr_c2 = (int*)Frmwk.IOP.Predac.wr_ptr_c2;
		if(DTSX_Latency_stat_var_c2 == 1)
		{
			DTSX_Latency_predac_wr_ptr_c2[0] = 0x12345678;
			*DTSX_latency_state_frm_c2 = 1;
			DTSX_Latency_stat_var_c2 = 0;
		}
#endif //DTSX_LATENCY_CALC
		Pre_Dac_Ptr_Update_Rd_C2();

		Pre_Dac_Ptr_Update();
		Shared_Memory_Var_Update();

		Frmwk.ADI_DecoderError = NO_ERROR;
		break;
	}//While Loop
}
#endif
void Shared_Memory_Var_Update(void)
{
	*predac_wr_ptr_c2 	 = Frmwk.IOP.Predac.wr_ptr_c2;  // Send Predac Write pointer to core for Filled space checking
	*Next_dac_count   	 = Frmwk.IOP.NextDacCount; 		// Send DAC count for transmitting data's
}

void Control_DataVariable_Update(void)
{
	Frmwk.OutputSampleRate  = *Frmwk_Outputsamplerate_c1;
	Sampling_freq			= *Frmwk_Outputsamplerate_c1;
	Testing_36channel		= *testing_36_ch;
	Channel_36_Route	    = *Ch36_Enable;
#ifdef OPTICAL_TESTING
	optical_testing			= *optical_test;
#endif //OPTICAL_TESTING
#ifdef DTSX_DECODER
	Frmwk.DTSX.StreamType_DTSX = 0;
	Frmwk.DTSX.DTSX_Processing_enable = 0;
	Stream_Type_frm_Core1 	= *stream_type;
	Frmwk_Stream_Type = Stream_Type_frm_Core1;     //stream_type_core1 is updated from core1 stream type

	if((*Post_decoding_option_command == 3) && (Frmwk_Stream_Type != 0) && ((*McpcmNeuralX == 1)||!(Frmwk_Stream_Type==15))&& (Frmwk.OutputSampleRate <= 2))
	{
		Frmwk.DTSX.StreamType_DTSX = 0;
		Frmwk.DTSX.NeuralX_Enable = 1;
		Frmwk.DTSX.DTSX_Processing_enable = 1;
	}
	//Check for all the DTSX stream types
	if((Frmwk_Stream_Type == 0x3)||(Frmwk_Stream_Type == 0x4)||(Frmwk_Stream_Type == 0xC)||(Frmwk_Stream_Type == 0xD) || (Frmwk_Stream_Type == 0xE))
	{
		*McpcmNeuralX = 0;
		Frmwk.DTSX.StreamType_DTSX = 1;
		Frmwk.DTSX.DTSX_Processing_enable = 1;
		Frmwk.DTSX.NeuralX_Enable =0;
	 }
	 if(Frmwk.DTSX.StreamType_DTSX == 1)
	 {
	    if(*sampling_frequency > 96000)
		{
			Frmwk.DTSX.DTSX_NumChannel = 8;
		}
		else if((*sampling_frequency > 48000) && (*sampling_frequency <= 96000))
		{
			Frmwk.DTSX.DTSX_NumChannel = 16;
		}
		else
		{
			Frmwk.DTSX.DTSX_NumChannel = 32;
		}
	 }
	 else if(Frmwk.DTSX.NeuralX_Enable == 1)
	 {
		numchannels_c1_MCPCM = *Frmwk_nchannels_in_c1_MPCM;
		Frmwk.DTSX.DTSX_NumChannel = 32;
	 }
	 if(*Cmd_processing_dne == 0)
	 {
		 Frmwk.DTSX.DTSXcommandprocessingdone_c2 = *Cmd_processing_dne;
		 *Cmd_processing_dne = 1 ;
	 }

#ifdef TRUBASS
	if(*TBassCmd_processing_dne == 0)
	{
		Frmwk.DTSX.TBHDX_CommandProcessingDone = *TBassCmd_processing_dne; //For on the fly command processing
		*TBassCmd_processing_dne = 1;
	}
#endif//TRUBASS
#endif  //DTSX_DECODER
}

/******************************************************************************
*  Module Name        : Init_Var
*  Functionality      : Variables which is need to be initialized to restart the system process for any decoder switching and decoder error case should be placed here
						In this framework, Latency process & system process for decoder are initiated
						This function will be called during PLAY, STOP, SPORT INIT command & decoder error case
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/
void Init_Var(void)
{
	Frmwk.IOP.datacanbeprocessednow = 0;
#ifdef DOWNSAMPLING_DTSX
	Frmwk.init_ds_processing = 1;
	DTSX_DS_C2_var = 0;
#endif //DOWNSAMPLING_DTSX
}

/******************************************************************************
*  Module Name        : Init_Var_Fs
*  Functionality      : Variables which is need to be initialized to restart the system process for decoder fs switching caseshould be placed here
						In this framework, Latency process & system process for decoder are initiated
						This function will be called in GENERAL_DECODING_COMMAND command Fs switching case
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/
void Init_Var_Fs(void)
{
	Frmwk.IOP.datacanbeprocessednow = 0;
}

#ifdef MDMA_COPY
/******************************************************************************
 *  Module Name        : MDMA_init
 *  Functionality      : MDMA Initialization
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
void MDMA_init(void)
{
	adi_mdma_Open (ADI_DMA_MEMDMA_S1,
					  &MemDmaStreamMem2[0],
					  &hMemDmaStream2,
					  &hSrcDmaChannel2,
					  &hDestDmaChannel2,
					  NULL,
					  NULL);



}
/******************************************************************************
 *  Module Name        : MDMA_Copy
 *  Functionality      : Copying data using MDMA1
 *  Input Parameters   : Buffer size, Source buffer and Destination buffer
 *  Output Parameters  : None
 ******************************************************************************/
void MDMA_Copy(int BuffSize, int SrcBuff, int DstBuff)
{
	adi_mdma_Copy1D(
					hMemDmaStream2,
					(void*)DstBuff,
					(void*)SrcBuff,
					ADI_DMA_MSIZE_4BYTES,
					BuffSize);
}
#endif


