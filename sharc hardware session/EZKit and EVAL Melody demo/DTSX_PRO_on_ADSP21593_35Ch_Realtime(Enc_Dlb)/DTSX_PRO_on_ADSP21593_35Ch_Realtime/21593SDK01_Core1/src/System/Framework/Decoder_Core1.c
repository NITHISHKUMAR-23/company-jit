/*****************************************************************************
 *
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
 *
 *  Project          :  	21593SDK
 *  Organization     :  	Jasmin Infotech Private Limited,Chennai
 *  File Name        :		Decoder_Core1.c
 *  Description      :   	Decoder routines

 ******************************************************************************/
#pragma default_section(CODE,"Seg_Decoder_Code")
#pragma default_section(ALLDATA,"Seg_Decoder_Data")
#include "../Include/Decoder_Core1.h"
#include "../Include/Function_Prototype.h"

/**************************************************************************************************
*  Module Name        : PlayForgnd
*  Functionality      : All Decoders wrapper should be placed here,
*						In addition to the decoder wrapper, Memory allocation
*						of Kernel I/O Buffers for decoder will be done here
*
*  Input Parameters	  : None
*  Output Parameters  : 0 for success
***************************************************************************************************/
int PlayForgnd(void)
{

	Frmwk.ADI_DecoderError = NO_ERROR;
	Frmwk.StreamType = Frmwk.Autdet.MSGR_Save;
#ifdef DOWNSAMPLING
	down_samp_flag= down_samp_flag_cmd;
#endif //DOWNSAMPLING

	*stream_type=Frmwk.StreamType;
#ifdef TMU
	if(TMU_Enable == 1)
	{
		TMU_Monitoring();
	}
#endif
#ifdef DTSX_DECODER
	if((Frmwk.DTSXDecoderEnable == 1)&&((Frmwk.StreamType == SYNCSIGDTSHR)||(Frmwk.StreamType == SYNCSIGDTSMA)||(Frmwk.StreamType == SYNCSIGDTSLDCD)||(Frmwk.StreamType == SYNCSIGDTSDVD)||(Frmwk.StreamType == SYNCSIGDTSLBR)))
	{
			DTSX_Framework();
			return 0;
	}
#endif  //DTSX_DECODER
/**************************************************************************************************
*									PCM Decoder START
*************************************************************************************************/
#ifdef PCM_DECODER
	if((((Frmwk.StreamType==1)&&(Frmwk.PCMEnable==1))||
			((Frmwk.Autdet.mpegstreamdetected==0)&&(Frmwk.StreamType==0xF)&&(Frmwk.PackAllocateinProgress==0)&&(Frmwk.Misc.Control.ForcePcm==1)&&(Frmwk.PCMEnable==1)) ||
			((Frmwk.Autdet.mpegstreamdetected==0)&&(Frmwk.StreamType==0x0)&&(Frmwk.PackAllocateinProgress==0)&&(Frmwk.Misc.Control.ForcePcm==1)&&(Frmwk.PCMEnable==1)))&&
			(Frmwk.NoiseGenEnable==0))
	{
			/* Check if there is a necessity for Allocating Memory */
		if((Frmwk.InitDoneForStreamType!= SYNCSIGPCM)||((Frmwk.InitDoneForStreamType == 1)&&(Frmwk.PrevLPCMDelaySize_host!=Frmwk.LPCMDelaySize_host)))
		{
#ifdef DTSX_DECODER
			*Dtsx_Core2_init_done= 0;						// DTSX Core 2 Library Struct Initialisation
			*Core2_InitConfigStructureDone = 0;             // Need to init Core2 DTSX structure
#endif  //DTSX_DECODER
#ifdef DOWNSAMPLING
			if(Frmwk.sampling_fs_micro <= 2)
			{
				down_samp_flag_cmd = 0;
				down_samp_flag = 0;
				Frmwk.DS_Mode = 0;
			}
			if(down_samp_flag==1)
			{
				if(DnSamp192to48==1)
				{
					Frmwk.pack_length_pcm = PACK_LENGTH_PCM_INT_DS_192;
				}
				else
				{
					Frmwk.pack_length_pcm = PACK_LENGTH_PCM_INT_DS_96;
				}
			}
			else
			{
				Frmwk.pack_length_pcm = PACK_LENGTH_PCM_INT;
			}
#else
			Frmwk.pack_length_pcm = PACK_LENGTH_PCM_INT;
#endif //DOWNSAMPLING

			Frmwk.predac_length_pcm = PREDAC_LENGTH_PCM;

			Free_AllotMemoryPackDac(Frmwk.pack_length_pcm, Frmwk.predac_length_pcm, 1);

			for(int i=0;i<Frmwk.IOP.Predac.length;i++)
			{
				Predac_buffer_Ext[i]=0;
			}
			for(int i=0;i<(NO_OF_TX_SAMPLE_COUNT * NUMMAXCHAN);i++)
			{
				TX_EXT_DMA_BUFFER[i]=0;
			}
#ifdef DOWNSAMPLING
			if (down_samp_flag==1)
			{
				if(DnSamp192to48==1)
				{
					if((Frmwk.sampling_fs_micro == 6)||(Frmwk.sampling_fs_micro == 10))
					{
						Frmwk.OutputSampleRate=0x2;
					}
					if((Frmwk.sampling_fs_micro == 5)||(Frmwk.sampling_fs_micro == 9))
					{
						Frmwk.OutputSampleRate		= 0x1;
					}
			  		if((Frmwk.sampling_fs_micro == 4)||(Frmwk.sampling_fs_micro == 8))
			  		{
			  			Frmwk.OutputSampleRate		= 0;
					}
				}
				else
				{
					Frmwk.OutputSampleRate =  Frmwk.sampling_fs_micro-4;
				}
			}
			else
			{
				Frmwk.OutputSampleRate 			= Frmwk.sampling_fs_micro;
			}
#else
			Frmwk.OutputSampleRate 			= Frmwk.sampling_fs_micro;
#endif //DOWNSAMPLING

			SRU_Reconfigure(Frmwk.sampling_fs_micro, Frmwk.OutputSampleRate);

			Frmwk.Autdet.StreamDetectEnable		= 0;

			Frmwk.IOP.Predac.length 			= PREDAC_LENGTH_PCM;
			Frmwk.IOP.Predac.lengthhalf 		= PREDAC_LENGTH_PCM/THREE_HALF;

			Frmwk.SampleBlock					= Frmwk.IOP.Predac.lengthhalf/NUMMAXCHAN;
			Frmwk.Autdet.AlignFlg				= 0;	   /* Initialize stream detection variables to start fresh detection */
			Frmwk.Autdet.MSGR_Save				= 0xF;
			Frmwk.Autdet.StreamDetectEnable		= 1;
			Frmwk.IOP.Predac.wr_ptr 			= Frmwk.IOP.Predac.rd_ptr = Frmwk.IOP.Predac.heap;
			*Predac_length_half					= Frmwk.IOP.Predac.lengthhalf;
#ifdef DTSX_DECODER			
			*Stream_Profile						= 0;
#endif  //DTSX_DECODER
			Frmwk.Decoder_Channel_Assignment	= 0xA000;  // L, R
			Frmwk.InitDoneForStreamType 		= SYNCSIGPCM;
			Frmwk.LPCMDelaySize 				= Frmwk.LPCMDelaySize_host+(256*2*4);	// //Lpcm delay for 96k and 192k
			Frmwk.PrevLPCMDelaySize_host		= Frmwk.LPCMDelaySize_host;

			AllocateMemoryPCMDelay(Frmwk.LPCMDelaySize);
			Frmwk.MCLPCM_ON = 0;

			Frmwk.No_of_Channel = 2;
			Frmwk.Customer_pp.ChannelMask  = 0x1;
			Init_Var();				  //  General Initialization routine

			Frmwk.ADI_DecoderError = STREAM_NOT_DETECTED;

			return 0;
		}
		else
		{
			PCMDecoder();
			return 0;
		}
	}
#endif //PCM_DECODER
/**************************************************************************************************
*									PCM Decoder END
*************************************************************************************************/
#ifdef MCPCM_DECODER
/**************************************************************************************************
 *									MCPCM Decoder START
 *************************************************************************************************/
	if((Frmwk.MCLPCMEnable == 1))
	{
		if(!Frmwk.MemoryAllotMCLPCM)
		{
			/**************************************************************************************************
			 *				MCPCM Decoder Input/Output pointer- onetime initialization
			 *************************************************************************************************/
			Frmwk.Autdet.StreamDetectEnable = 0;
#ifdef DTSX_DECODER
			*Dtsx_Core2_init_done= 0;						// DTSX Core 2 Library Struct Initialisation
			*Core2_InitConfigStructureDone = 0;             // Need to init Core2 DTSX structure
#endif  //DTSX_DECODER
#ifdef DOWNSAMPLING
			if(Frmwk.sampling_fs_micro <= 2)
			{
				down_samp_flag_cmd = 0;
				down_samp_flag = 0;
				Frmwk.DS_Mode = 0;
			}
			if(down_samp_flag==1)
			{
				if(DnSamp192to48==1)
				{
					Frmwk.pack_length_mcpcm		 = PACK_LENGTH_MCPCM_DS_192;
				}
			    else
				{
					Frmwk.pack_length_mcpcm 	= PACK_LENGTH_MCPCM_DS_96;
				}
			}
			else
			{
				Frmwk.pack_length_mcpcm 		= PACK_LENGTH_MCPCM;
			}
#else
			Frmwk.pack_length_mcpcm 		= PACK_LENGTH_MCPCM;
#endif //DOWNSAMPLING
			Frmwk.predac_length_mcpcm		= PREDAC_LENGTH_MCPCM;

			Free_AllotMemoryPackDac(Frmwk.pack_length_mcpcm, Frmwk.predac_length_mcpcm, 1);
#ifdef DOWNSAMPLING
			if (down_samp_flag==1)
			{
				if(DnSamp192to48==1)
				{
					 Frmwk.OutputSampleRate =  Frmwk.sampling_fs_micro-8;
				}
				else
				{
				  Frmwk.OutputSampleRate =  Frmwk.sampling_fs_micro-4;

				}
			}
			else
			{
				Frmwk.OutputSampleRate 			= Frmwk.sampling_fs_micro;
			}
#else
			Frmwk.OutputSampleRate 			= Frmwk.sampling_fs_micro;
#endif //DOWNSAMPLING
			
			SRU_Reconfigure(Frmwk.sampling_fs_micro, Frmwk.OutputSampleRate);
			Frmwk.IOP.Predac.length 			= PREDAC_LENGTH_MCPCM;
			Frmwk.IOP.Predac.lengthhalf 		= PREDAC_LENGTH_MCPCM/THREE_HALF;
			Frmwk.SampleBlock 					= Frmwk.IOP.Predac.lengthhalf/NUMMAXCHAN;
			Frmwk.Autdet.AlignFlg				= 0;    /* Initialise stream detection variables to start fresh detection */
			Frmwk.Autdet.StreamDetectEnable		= 1;
			Frmwk.InitDoneForStreamType 		= SYNCSIGUNKNOWN;
			Frmwk.MemoryAllotMCLPCM				= 1;
			Frmwk.No_of_Channel 				= NO_OF_INPUT_CHANNEL;
			*Predac_length_half					= Frmwk.IOP.Predac.lengthhalf;
#ifdef DTSX_DECODER
			*Stream_Profile						= 0;
#endif  //DTSX_DECODER
			if(Frmwk.inputChannelConfig==2)
			{
				Frmwk.Decoder_Channel_Assignment = 0xA000;
				Frmwk.Customer_pp.ChannelMask  = 0x1;
			}
			else if(Frmwk.inputChannelConfig==6)
			{
				Frmwk.Decoder_Channel_Assignment = 0xF801;
				Frmwk.Customer_pp.ChannelMask  = 0xF;
			}
			else if(Frmwk.inputChannelConfig==8)
			{
				Frmwk.Decoder_Channel_Assignment = 0xFA01;   // L, R, C, LFE, Ls, Rs, Lsr, Rsr
				Frmwk.Customer_pp.ChannelMask  = 0x1F;
			}

			Init_Var();										//  General Initialization routine
			Frmwk.ADI_DecoderError 				 = STREAM_NOT_DETECTED;
			return 0;
		}
		else
		{

			MCPCMDecoder();
			return 0;
		}
	}
#endif /*	End of #ifdef MCPCM_DECODER	*/

/**************************************************************************************************
 *									MCPCM Decoder END
 *************************************************************************************************/
	Init_Var();
	return 0;
}	/*	End of PlayForgnd function	*/
/**************************************************************************************************
 *									PCM Decoder Function API Routine
 *************************************************************************************************/
#ifdef PCM_DECODER
section("seg_kernal_pcm_code")
void PCMDecoder()
{
	Frmwk.ADI_DecoderError = NO_ERROR;
	while(1)
	{
        int i,j;
		if(Frmwk.IOP.datacanbeprocessednow == 0)
		{
			if(Frmwk.Autdet.HeaderPlaceWritten == 0)
			{
				Frmwk.ADI_DecoderError = HEADER_PLACE_WRITTEN_ERROR;
				break;
			}

			for(int i=0;i<Frmwk.IOP.Predac.length;i++)
			{
				Predac_buffer_Ext[i]=0;
			}

			for(int i=0;i<(NO_OF_TX_SAMPLE_COUNT*NUMMAXCHAN);i++)
			{
				TX_EXT_DMA_BUFFER[i]=0;
			}

			memset( output_parameter_buffer, 0, sizeof( output_parameter_buffer ));

#ifndef CORE1_TX
			if(*core2_dcpn_done==1)
			{
#endif
			*predac_wr_ptr_c2    = (int)Frmwk.IOP.Predac.heap;
			Frmwk.IOP.Predac.rd_ptr = (int)Frmwk.IOP.Predac.heap;
			Frmwk.IOP.Predac.wr_ptr = (int)Frmwk.IOP.Predac.heap;
			Frmwk.IOP.datacanbeprocessednow = 1;
			*datacanbeprocessnow=Frmwk.IOP.datacanbeprocessednow;
			*Init_Start_Command_c1=0;
#ifdef DTSX_DECODER
			*Dtsx_Core2_init_done= 0;
			*Core2_InitConfigStructureDone = 0;
#ifdef DOWNSAMPLING_DTSX
			*DTSX_DS_Enable = 0;
#endif //DOWNSAMPLING_DTSX
#endif//DTSX_DECODER

#ifndef CORE1_TX
			}
			else
			{
				return;
			}
#endif

			Frmwk.IOP.Pack.rd_ptr = Frmwk.Autdet.HeaderAddress;
			Frmwk.IOP.LatencyDone = 0;
			Frmwk.IOP.LatencyFlag = 0;
			Frmwk.SampleBlock=Frmwk.IOP.Predac.lengthhalf/NUMMAXCHAN;
			*core2_sync_bit=1;

		}
		/* Check for availability of data in input buffer (Pack Buffer) */
		i = Frmwk.IOP.Pack.wr_ptr-Frmwk.IOP.Pack.rd_ptr;
		if(i < 0)
		{
			i = i + (Frmwk.IOP.Pack.length*4);
		}
		if((i - (Frmwk.IOP.Pack.lengthhalf*4)) < 0)
		{
			Frmwk.ADI_DecoderError = FILLED_SPACE_ERROR ;
			break;
		}

		/* Check for availability of Empty space in output buffer (Predac Buffer) */
		i = Frmwk.IOP.Predac.rd_ptr - Frmwk.IOP.Predac.wr_ptr;

#ifndef CORE1_TX
		if(Frmwk.IOP.LatencyDone==0)
		{
			if(i<=0)
			{
				i = i + (Frmwk.IOP.Predac.length*4);
			}
		}

		if(Frmwk.IOP.LatencyDone==1)
		{
			if(i<0)
			{
				i = i + (Frmwk.IOP.Predac.length*4);
			}
		}
#else
		if(i<=0)
		{
			i = i + (Frmwk.IOP.Predac.length*4);
		}
#endif

		if((i - ((Frmwk.IOP.Predac.lengthhalf+NO_OF_TX_SAMPLE_COUNT*NUMMAXCHAN)*4)) < 0)
		{
			Frmwk.ADI_DecoderError = EMPTY_SPACE_ERROR;
			break;
		}
		if (Frmwk.IOP.LatencyDone == 0)
		{
			Frmwk.IOP.LatencyDone = 1;
			i = (Frmwk.LPCMDelaySize-(256*2*4))*4;                             //Lpcm delay for 96k and 192k(16384+(256*2*4))
			Frmwk.LPCMDelayBuffer_wr_ptr = (int) Frmwk.LPCMDelayBuffer_heap + i;
			Frmwk.LPCMDelayBuffer_rd_ptr = (int) Frmwk.LPCMDelayBuffer_heap ;
			Frmwk.Tx.Tx_LatencyFlag=0;
			ClearLPCMDelay();
#ifdef DOWNSAMPLING
			if (down_samp_flag==1)
			{
				Frmwk.IOP.Predac.wr_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.lengthhalf];
				#ifndef CORE1_TX
				if(*SampleBlock_Core2 == 256)
					Frmwk.IOP.Predac.rd_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.length-Frmwk.IOP.Predac.lengthhalf];
				else
					Frmwk.IOP.Predac.rd_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.length-Frmwk.IOP.Predac.lengthhalf/2];
				#endif
			}
			else
			{
				Frmwk.IOP.Predac.wr_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.lengthhalf];
				#ifndef CORE1_TX
				if(*SampleBlock_Core2 == 256)
					Frmwk.IOP.Predac.rd_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.length-Frmwk.IOP.Predac.lengthhalf];
				else
					Frmwk.IOP.Predac.rd_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.length-Frmwk.IOP.Predac.lengthhalf/2];
				#endif
			}
#else
			Frmwk.IOP.Predac.wr_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.lengthhalf];
			#ifndef CORE1_TX
			if(*SampleBlock_Core2 == 256)
				Frmwk.IOP.Predac.rd_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.length-Frmwk.IOP.Predac.lengthhalf];
			else
				Frmwk.IOP.Predac.rd_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.length-Frmwk.IOP.Predac.lengthhalf/2];
			#endif
#endif //DOWNSAMPLING
			*Latency_predac_wr_ptr_c1  = (int)Frmwk.IOP.Predac.wr_ptr;
			*predac_rd_ptr_c1	=	Frmwk.IOP.Predac.rd_ptr;
			*Init_Start_Command_c1	   = 1;
		}

#ifdef CORE2_DEBUG

		if(*core2_sync_bit==0)
		{
			break;
		}

		if(*core2_sync_bit==1)
		{
			*core2_sync_bit=0;
		}
#endif
		CopyINTLPCMtoDelayBuf();

#ifdef DOWNSAMPLING
		if (down_samp_flag==1)
		{
			CopyLPCMToPack();//Lpcm delay for 96k and 192k
			Pack_TO_Predac_Downsam();
			PackUpdate();
			Down_Samp_Processing();
			Predac_Int_TO_Predac_ext();
		}
		else
		{
			CopyLPCMToPredac();
			PackUpdate();
		}
#else
		CopyLPCMToPredac();
		PackUpdate();

#endif //DOWNSAMPLING

		Pre_Dac_Ptr_Update();

#ifdef DTSX_DECODER
	*McpcmNeuralX = Frmwk.MCLPCMEnable;  //Needed for DTSX Neuralx for MCPCM in core2
	*NeuralXSamplFreq = Frmwk.OutputSampleRate;
	DTSX_Core2_Status_Update();
#endif	//DTSX_DECODER

		Control_Data_Update();
		/*Update Write pointer for filled space checking in core 2 */
		*predac_wr_ptr_c1=Frmwk.IOP.Predac.wr_ptr;
		Frmwk.ADI_DecoderError = NO_ERROR;
		break;
	}//While Loop
}
#endif // PCM_DECODER
/**************************************************************************************************
*  Module Name        : MCPCMDecoder
*  Functionality      : MCPCMDecoder function initialization, latency process and pointers updates are
*  						done here
*
*  Input Parameters	  : None
***************************************************************************************************/
#ifdef MCPCM_DECODER
void MCPCMDecoder(void)
{
	Frmwk.ADI_DecoderError = NO_ERROR;
	while(1)
	{
		int i,j;
		if(Frmwk.IOP.datacanbeprocessednow == 0)
		{
			#ifndef CORE1_TX
			if(*core2_dcpn_done==1)
			{
			#endif
			for(int i=0;i<Frmwk.IOP.Predac.length;i++)
			{
				Predac_buffer_Ext[i]=0;
			}
			for(int i=0;i<(NO_OF_TX_SAMPLE_COUNT*NUMMAXCHAN);i++)
			{
				TX_EXT_DMA_BUFFER[i]=0;
			}
			for(int i=0;i<(NO_OF_SAMPLE_PROCESSING*PREDAC_INT_NUMCHAN);i++)
			{
				Predac_buffer_Int[i]=0;
			}

			memset( output_parameter_buffer, 0, sizeof( output_parameter_buffer ));

				*predac_wr_ptr_c2    = (int)Frmwk.IOP.Predac.heap;
				Frmwk.IOP.Predac.rd_ptr = (int)Frmwk.IOP.Predac.heap;
				Frmwk.IOP.Predac.wr_ptr = (int)Frmwk.IOP.Predac.heap;
				Frmwk.IOP.datacanbeprocessednow = 1;
				*datacanbeprocessnow=Frmwk.IOP.datacanbeprocessednow;
				*Init_Start_Command_c1 = 0;
#ifdef DTSX_DECODER
				*Dtsx_Core2_init_done= 0;
				*Core2_InitConfigStructureDone = 0;
#ifdef DOWNSAMPLING_DTSX
				*DTSX_DS_Enable = 0;
#endif //DOWNSAMPLING_DTSX
#endif//DTSX_DECODER
			#ifndef CORE1_TX
			}
			else
			{
				return;
			}
			#endif
#ifdef DOWNSAMPLING
			if(down_samp_flag==1)
			{
				if(DnSamp192to48==1)
				{
					Frmwk.pack_length_mcpcm = PACK_LENGTH_MCPCM_DS_192;
				}
				else
				{
					Frmwk.pack_length_mcpcm = PACK_LENGTH_MCPCM_DS_96;
				}
			}
			else
			{
				Frmwk.pack_length_mcpcm 		= PACK_LENGTH_MCPCM;
			}
#else
			Frmwk.pack_length_mcpcm 		= PACK_LENGTH_MCPCM;
#endif //DOWNSAMPLING
			Frmwk.predac_length_mcpcm		= PREDAC_LENGTH_MCPCM;
			Frmwk.IOP.Pack.rd_ptr = Frmwk.Autdet.HeaderAddress;
			Frmwk.IOP.LatencyDone = 0;
			Frmwk.IOP.LatencyFlag = 0;
			Frmwk.SampleBlock=Frmwk.IOP.Predac.lengthhalf/NUMMAXCHAN;
			*core2_sync_bit=1;
		}

		/* Check for availability of data in input buffer (Pack Buffer) */
		i = Frmwk.IOP.Pack.wr_ptr-Frmwk.IOP.Pack.rd_ptr;
		if(i < 0)
		{
			i = i + (Frmwk.IOP.Pack.length*4);
		}

		if((i - (Frmwk.IOP.Pack.lengthhalf*4)) < 0)
		{
			Frmwk.ADI_DecoderError = FILLED_SPACE_ERROR ;
			break;
		}

		/* Check for availability of Empty space in output buffer (Predac Buffer) */
		i = Frmwk.IOP.Predac.rd_ptr - Frmwk.IOP.Predac.wr_ptr;
		#ifndef CORE1_TX
			if(Frmwk.IOP.LatencyDone==0)
			{
				if(i<=0)
				{
					i = i + (Frmwk.IOP.Predac.length*4);
				}
			}
			if(Frmwk.IOP.LatencyDone==1)
			{
				if(i<0)
				{
					i = i + (Frmwk.IOP.Predac.length*4);
				}
			}
		#else
			if(i<=0)
			{
				i = i + (Frmwk.IOP.Predac.length*4);
			}
		#endif
		if((i - ((Frmwk.IOP.Predac.lengthhalf+(NO_OF_TX_SAMPLE_COUNT*NUMMAXCHAN))*4)) < 0)
		{
			Frmwk.ADI_DecoderError = EMPTY_SPACE_ERROR;
			break;
		}

		/* Transfer latency content before processing */
		if (Frmwk.IOP.LatencyDone == 0)
		{			
			Frmwk.IOP.LatencyCnt=Frmwk.SampleBlock*2;
			Frmwk.IOP.LatencyDone = 1;
			Frmwk.Tx.Tx_LatencyFlag=0;
			Frmwk.IOP.Predac.wr_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.lengthhalf];
			#ifndef CORE1_TX
			if(*SampleBlock_Core2 == 256)
				Frmwk.IOP.Predac.rd_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.length-Frmwk.IOP.Predac.lengthhalf];
			else
				Frmwk.IOP.Predac.rd_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.length-Frmwk.IOP.Predac.lengthhalf/2];
			#endif

			*Latency_predac_wr_ptr_c1   = (int)Frmwk.IOP.Predac.wr_ptr;
			*predac_rd_ptr_c1	=	Frmwk.IOP.Predac.rd_ptr;
			*Init_Start_Command_c1=1;
		}
#ifdef CORE2_DEBUG

		if(*core2_sync_bit==0)
		{
			break;
		}

		if(*core2_sync_bit==1)
		{
			*core2_sync_bit=0;
		}
#endif

#ifdef DOWNSAMPLING
		if (down_samp_flag==1)
		{
			Pack_To_Int_MCPCM();
			PackUpdate();
			Down_Samp_Processing_8ch();
			Int_Predac_MCPCM();
		}
		else
		{
			/* Copy MCPCM content from Pack buffer to Predac Buffer */
			Pack_TO_Predac_MCPCM();
			/* Update the Input buffer read pointer to copy next input frame 	*/
			PackUpdate();
		}
#else
		/* Copy MCPCM content from Pack buffer to Predac Internal Buffer */
		Pack_TO_Predac_MCPCM();
		/* Update the Input buffer read pointer to copy next input frame 	*/
		PackUpdate();
#endif //DOWNSAMPLING
#ifdef MDMA_COPY
		Source_Buf=(int)&Predac_buffer_Int[0];
		Destination_Buf=Frmwk.IOP.Predac.wr_ptr;
		bMemCopyInProgress1 = true;

		Predac_Buffer_Int_To_Predac_Buffer_Ext(BufSize,Source_Buf,Destination_Buf);

		while(bMemCopyInProgress1)
		{
		   adi_mdma_IsCopyInProgress (hMemDmaStream1, &bMemCopyInProgress1);
		}

#else

		/* Copy MCPCM content from Internal Predac buffer to External Predac Buffer */
		Predac_Buffer_Int_To_Predac_Buffer_Ext();
#endif
		/* Update the Output buffer write pointer to copy next decoded frame 	*/
		Pre_Dac_Ptr_Update();

#ifdef DTSX_DECODER
	*McpcmNeuralX = Frmwk.MCLPCMEnable;  //Needed for DTSX Neuralx for MCPCM in core2
	*NeuralXSamplFreq = Frmwk.OutputSampleRate; 
	DTSX_Core2_Status_Update();
#endif	//DTSX_DECODER

		Control_Data_Update();

		/*Update Write pointer for filled space checking in core 2 */
		*predac_wr_ptr_c1 = Frmwk.IOP.Predac.wr_ptr;

		Frmwk.ADI_DecoderError = NO_ERROR;
		break;
	}//While Loop

}//MCPCM
#endif	/*	End of #ifdef MCPCM_DECODER	*/
/**************************************************************************************************
*  Module Name        : Control_Data_Update
*  Functionality      : Control_Data_Update function definition (SampleBlock,O/P SampleRate,Input channel configuration,
*  						ChannelMask variables updates)
*
*  Input Parameters	  : None
***************************************************************************************************/
void Control_Data_Update(void)
{
	 *Frmwk_SampleBlock_c1			     	 = Frmwk.SampleBlock ;
	 *Frmwk_Outputsamplerate_c1				 = Frmwk.OutputSampleRate;
	 *Frmwk_nchannels_in_c1 	 	 	 	 = Frmwk.Customer_pp.ChannelMask;
	 *Frmwk_nchannels_in_c1_MPCM			 = Frmwk.inputChannelConfig;
#ifdef DTSX_DECODER
	 *Ver4_info_c1                           = Ver_No_4;
#endif	//DTSX_DECODER
}
#ifdef MDMA_COPY
/**************************************************************************************************
 *  Module Name        : Predac_Buffer_Int_To_Predac_Buffer_Ext
 *  Functionality      : Predac_Buffer_Int_To_Predac_Buffer_Ext copy data from internal  predac
 *                       buffer to external predac buffer
 *  Input Parameters   : BuffSize, SrcBuff
 *  Output Parameters  : DstBuff
 **************************************************************************************************/
void Predac_Buffer_Int_To_Predac_Buffer_Ext(int BufSize, int SrcBuff, int DstBuff)
{

		adi_mdma_Copy1D(
						hMemDmaStream1,
						(void*)DstBuff,
						(void*)SrcBuff,
						ADI_DMA_MSIZE_4BYTES,
						BufSize);

}
#endif
#ifdef PCM_DECODER
/**************************************************************************************************
 *  Module Name        : AllocateMemoryPCMDelay
 *  Functionality      : Allocation of Memory for LPCM delay pointers
 *  Input Parameters   : LPCMDelaySize
 *  Output Parameters  : None
 *************************************************************************************************/
section("seg_kernal_pcm_code")
void AllocateMemoryPCMDelay( int LPCMDelaySize)
{
	if(Frmwk.MemoryAllotPcm==0)
	{
		Frmwk.LPCMDelayBuffer_heap = (int)&LPCMDelayBuffer[0];
		Frmwk.MemoryAllotPcm=1;
	}
}
#endif //PCM_DECODER

