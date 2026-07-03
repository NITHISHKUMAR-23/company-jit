/*****************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :  	DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	DTSX_Kernel.c
*  Description      :   DTSX Decoder Kernel related function can be
*  					 	included here
******************************************************************************/

#include "DTSX_Kernel.h"

#ifdef DTSX_DECODER
/******************************************************************************
 *  Module Name        : DTSX_Framework
 *  Functionality      : DTSX Framework will be called based on 256 bit key handling
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_dtsx_kernal_code")
void DTSX_Framework()
{
	if((Frmwk.DTSX.dec_mode_ctrl_var_1 != 0) || (Frmwk.DTSX.dec_mode_ctrl_var_2 != 0) || (Frmwk.DTSX.dec_mode_ctrl_var_3 != 0) || (Frmwk.DTSX.dec_mode_ctrl_var_4 != 0))
	{
		DTSX_Framework_main();
	}
}
/******************************************************************************
 *  Module Name        : DTSX_Framework_main
 *  Functionality      : DTSX Decoder initialization and Pack Predac memory
 *  					 allocations Routines.
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
#pragma optimize_for_speed
section("seg_dtsx_kernal_code")
void DTSX_Framework_main()
{
	int i;

	if( Frmwk.InitDoneForStreamType != Frmwk.StreamType )
	{

		Frmwk.DTSX.nPrimaryFlags 			= 26;
		Frmwk.DTSX.initdecoder 				= 1;				// Library Structures Initialisation
		Frmwk.DTSX.InitConfigStructureDone  = 0; // Player config structure initialisation
		*Core2_InitConfigStructureDone = Frmwk.DTSX.InitConfigStructureDone;
		Frmwk.PackAllocateinProgress 		= 1;
		Frmwk.InitDoneForStreamType 		= Frmwk.StreamType;
		*Stream_Profile = DTSX_STREAM_PROFILE;
		if( !Frmwk.MemoryAllotDTS )
		{
			Frmwk.DTSX.Status.SamplingFrequencyDecoded  = 48000;
			Frmwk.InitDoneForFS					 = -1;
			Frmwk.OutputSampleRate 				 = 0x2;
		}
		/*================= DTS-HD PCG_CONFIGURE=================*/
		if( Frmwk.DTSX.Status.SamplingFrequencyDecoded > 96000 )
		{
			Frmwk.OutputSampleRate = 0xA; // 192Khz
			if(Frmwk.DTSX.Status.SamplingFrequencyDecoded == 176400)
			{
				Frmwk.OutputSampleRate = 0x9; // 176.4Khz
			}
			Frmwk.SampleBlock = 1024;
		}
		else if(Frmwk.DTSX.Status.SamplingFrequencyDecoded <= 48000)
		{
			Frmwk.OutputSampleRate = 0x2; // 48Khz
			if(Frmwk.DTSX.Status.SamplingFrequencyDecoded == 44100)
			{
				Frmwk.OutputSampleRate = 0x1; // 44.1Khz
			}
			Frmwk.SampleBlock = 256;
		}
		else
		{
			Frmwk.OutputSampleRate = 0x6;
			if(Frmwk.DTSX.Status.SamplingFrequencyDecoded == 88200) //88.2Khz
			{
				Frmwk.OutputSampleRate = 0x5;
			}
			Frmwk.SampleBlock = 512;
		}
		*Stream_sample_rate = Frmwk.SampleBlock;
		if (Frmwk.Autdet.FormatStream)
		{
			Frmwk.DTSX.Frame_Length_ker = Frmwk.Autdet.DTSDataLength + 2;
		}
		else
		{
			Frmwk.DTSX.Frame_Length_ker = Frmwk.Autdet.DTSSampleCount;
		}

		Frmwk.pack_length_dtshdhr = Frmwk.DTSX.Frame_Length_ker*DTSX_NUM_OF_PACK_HALF;
		Frmwk.predac_length_dtshd = Frmwk.SampleBlock*DTSX_PREDAC_NUMMAXCHAN*DTSX_NUM_OF_PREDAC_HALF;
		Frmwk.addpredac_length_dtshd = ADDPREDAC_LENGTH_DTSX;
		Free_AllotMemoryPackDac(Frmwk.pack_length_dtshdhr,(Frmwk.predac_length_dtshd),(Frmwk.addpredac_length_dtshd));

		/*********** Configuring the predac into 4 halves *************************/
		Frmwk.IOP.Predac.lengthhalf=Frmwk.IOP.Predac.length/FOUR_HALF;
		Frmwk.IOP.AddPreDac.lengthhalf = Frmwk.addpredac_length_dtshd/FOUR_HALF;

		/**************************************************************************/

		*Predac_length_half = Frmwk.IOP.Predac.length/FOUR_HALF;

		if(Frmwk.InitDoneForFS!=Frmwk.DTSX.Status.SamplingFrequencyDecoded)
		{
			Frmwk.InitDoneForFS=Frmwk.DTSX.Status.SamplingFrequencyDecoded;
#ifdef DOWNSAMPLING_DTSX
		if( (*DTSX_DS_Enable == 1)&& (Frmwk.OutputSampleRate == 6))
		{
			Frmwk.OutputSampleRate = 2;
		}
		if( (*DTSX_DS_Enable == 1)&& (Frmwk.OutputSampleRate == 5 ))
		{
			Frmwk.OutputSampleRate = 1;
		}
		*Frmwk_Outputsamplerate_c1	= Frmwk.OutputSampleRate;
#endif //DOWNSAMPLING_DTSX
			SRU_Reconfigure(Frmwk.sampling_fs_micro,Frmwk.OutputSampleRate); // SRU Reconfiguring for all DTS cases
		}

		memset( InputParameter, 0, sizeof( InputParameter ));
		memset( OutputParameter, 0, sizeof( OutputParameter ));

		Frmwk.MemoryAllotDTS = 1;	// "This needs to be cleared for other decoders"
		Frmwk.DTSX.DTSXcommandprocessingdone_c1 = 0;
		*Cmd_processing_dne=Frmwk.DTSX.DTSXcommandprocessingdone_c1;//Core 2 command init
		Frmwk.MCLPCM_ON = 0;

#ifdef DTSX_MIPS_CALC
		Frmwk.DTSX.dtsxframecount = 0;
		Frmwk.DTSX.MipsIdx = 0;
#endif //DTSX_MIPS_CALC
		Init_Var();

		Frmwk.ADI_DecoderError = 2;
		return;

	}
	else
	{
		Frmwk.PackAllocateinProgress = 0;
		DTSXDecoder();
		return;
	}
}

/******************************************************************************
 *  Module Name        : DTSXDecoder
 *  Functionality      : DTSX Decoder Input copy and Output copy routines
 *                       DTSX Library function call
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_dtsx_kernal_code")
void DTSXDecoder()
{
	int i,DTSX_ERROR = 0,j;

	dtsInputParameter *p_InputParam = ( dtsInputParameter * )InputParameter;
	dtsOutputParameter *p_OutputParam = ( dtsOutputParameter * )OutputParameter;

/*========================== DTS:X Initialisation Block Starts here ==============================*/

	if(Frmwk.IOP.datacanbeprocessednow == 0)
	{
		if(Frmwk.Autdet.HeaderPlaceWritten == 0)
		{
			Frmwk.ADI_DecoderError = 1;
			return;
		}

		Frmwk.IOP.LatencyDone = 0;
		Frmwk.DTSX.frame_count_ker = 0;

		if(Frmwk.Autdet.FormatStream)
		{
			if((Frmwk.StreamType == SYNCSIGDTSHR) || (Frmwk.StreamType == SYNCSIGDTSMA))
			{
				Frmwk.IOP.Pack.rd_ptr = Frmwk.Autdet.HeaderAddress+(3*sizeof(int));
				Frmwk.DTSX.Offset = -3;
			}
			else
			{
				Frmwk.IOP.Pack.rd_ptr = Frmwk.Autdet.HeaderAddress;
				Frmwk.DTSX.Offset = 0;
			}
		}
		else
		{
			Frmwk.IOP.Pack.rd_ptr = Frmwk.Autdet.HeaderAddress-0;
			Frmwk.DTSX.Offset = 0;
		}
		if (Frmwk.Autdet.FormatStream)
		{
			Frmwk.DTSX.Frame_Length_ker = Frmwk.Autdet.DTSDataLength + 2;
		}
		else
		{
			Frmwk.DTSX.Frame_Length_ker = Frmwk.Autdet.DTSSampleCount;
		}

		if(Frmwk.DTSX.previous_Frame_Length_ker != Frmwk.DTSX.Frame_Length_ker)
		{
			Frmwk.DTSX.previous_Frame_Length_ker = Frmwk.DTSX.Frame_Length_ker;
			Frmwk.InitDoneForStreamType = -1;
		}

#ifndef CORE1_TX
		if(*core2_dcpn_done==1)
		{
#endif //CORE1_TX
			*predac_wr_ptr_c2    = (int)Frmwk.IOP.Predac.heap;
			Frmwk.IOP.Predac.rd_ptr = (int)Frmwk.IOP.Predac.heap;
			Frmwk.IOP.Predac.wr_ptr = (int)Frmwk.IOP.Predac.heap;
			Frmwk.IOP.datacanbeprocessednow = 1;
			*datacanbeprocessnow=Frmwk.IOP.datacanbeprocessednow;
			*Init_Start_Command_c1=0;
#ifndef CORE1_TX
		}
		else
		{
			return;
		}
#endif //CORE1_TX
		#pragma vector_for
		#pragma no_alias
		for(int i=0;i<PREDAC_LENGTH_DTSHD_MAX;i++)
			Predac_buffer_Ext[i]=0;

		#pragma vector_for
		#pragma no_alias
		for(int i=0;i<ADDPREDAC_LENGTH_DTSX;i++)
			AddPredac_buffer_ext[i]=0;

		#pragma vector_for
		#pragma no_alias
		for(int i=0;i<(DTSX_NO_OF_TX_SAMPLE_COUNT*DTSX_PREDAC_NUMMAXCHAN);i++)
			TX_EXT_DMA_BUFFER[i]=0;
		*core2_sync_bit=1;

	}

	        /**Do Presearch for Every Frame Beginning**/
	if( (Frmwk.DTSX.nPrimaryFlags == 0) || (Frmwk.DTSX.nPrimaryFlags == 26) )
	{
		i = Frmwk.IOP.Pack.wr_ptr - Frmwk.IOP.Pack.rd_ptr - (Frmwk.DTSX.Offset*4);
		if (i<0) i = i + (Frmwk.IOP.Pack.length*4);
		if ((i - ((Frmwk.DTSX.Frame_Length_ker + Frmwk.loop_offset)*4)) < 0)
		{
			Frmwk.ADI_DecoderError = FILLED_SPACE_ERROR;
			return;
		}
	}
	/**Empty space checking for enough empty space in predac buffer to write the output of Decoder**/
	i = Frmwk.IOP.Predac.rd_ptr - Frmwk.IOP.Predac.wr_ptr;

#ifndef CORE1_TX

	if(Frmwk.IOP.LatencyDone==0)
	{
		if(i<=0)  i = i + (Frmwk.IOP.Predac.length*4);
	}
	if(Frmwk.IOP.LatencyDone==1)
	{
		if(i<0)  i = i + (Frmwk.IOP.Predac.length*4);
	}
#else
	if(i<=0)  i = i + (Frmwk.IOP.Predac.length*4);
#endif //CORE1_TX

	if((i - ((Frmwk.IOP.Predac.lengthhalf)*4)) < 0)
	{
		Frmwk.ADI_DecoderError = 4;
		return;
	}

	if (Frmwk.IOP.LatencyDone == 0)
	{
		Frmwk.IOP.LatencyCnt=Frmwk.SampleBlock*3;
		Frmwk.IOP.LatencyDone = 1;
		Frmwk.Tx.Tx_LatencyFlag=0;
		Frmwk.IOP.Predac.wr_ptr=(int)&Predac_buffer_Ext[Frmwk.IOP.Predac.lengthhalf*2];
#ifndef CORE1_TX
		if(*SampleBlock_Core2 == 256)
		Frmwk.IOP.Predac.rd_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.length-Frmwk.IOP.Predac.lengthhalf];
		else
			Frmwk.IOP.Predac.rd_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.length-Frmwk.IOP.Predac.lengthhalf/2];
#endif //CORE1_TX

		*Latency_predac_wr_ptr_c1   = (int)Frmwk.IOP.Predac.wr_ptr;
		Frmwk.IOP.AddPreDac.wr_ptr  = (int)&AddPredac_buffer_ext[Frmwk.IOP.AddPreDac.lengthhalf*2];
		*addpredac_wr_ptr   =  (int)Frmwk.IOP.AddPreDac.wr_ptr;
		*addpredac_rd_ptr   =  (int)Frmwk.IOP.AddPreDac.wr_ptr;
		*addpredac_lengthhalf = (int)Frmwk.IOP.AddPreDac.lengthhalf;
		*predac_rd_ptr_c1	=	Frmwk.IOP.Predac.rd_ptr;
		*Init_Start_Command_c1=1;
	}

/*======================== DTS:X Initialization Block Ends here =================================*/

	p_InputParam->InputFrameSize = 0;
	if( (Frmwk.DTSX.nPrimaryFlags == 0) || (Frmwk.DTSX.nPrimaryFlags == 26) )
	{
		COPYEXTPACKTO_INTPACK_DTSX();
		p_InputParam->InputFrameSize = 32768;
		if(Frmwk.DTSX.nPrimaryFlags ==0) Frmwk.DTSX.nPrimaryFlags = 16;
#ifdef DTSX_LATENCY_CALC
		if((Frmwk.Autdet.FormatStream == 1) && ((Frmwk.StreamType == 0xC) || (Frmwk.StreamType == 0xD)))
		{
			DTSX_Latency_pack_ptr = (int*)Frmwk.IOP.Pack.rd_ptr - 3;
		}
		if((Frmwk.Autdet.FormatStream == 0) || (Frmwk.StreamType == 4) || (Frmwk.StreamType == 0xE))
		{
			DTSX_Latency_pack_ptr = (int*)Frmwk.IOP.Pack.rd_ptr;

		}
		DTSX_Latency_temp_ptr = DTSX_Latency_pack_ptr[0];
		if((DTSX_Latency_temp_ptr) == 0xf8726053)
		{
			if(Frmwk.Autdet.FormatStream == 1)
			{
				DTSX_Latency_pack_ptr[0] = 0xf8724e1f;
			}
			else
			{
				if(DTSX_Latency_unformat_header_chk == 1)
				{
					DTSX_Latency_pack_ptr[0] = 0x7ffe8001;
				}
				if(DTSX_Latency_unformat_header_chk == 0)
				{
					DTSX_Latency_pack_ptr[0] = 0x1FFFE800;
				}
			}
			DTSX_Latency_stat_var_c1=1;
		}
#endif //DTSX_LATENCY_CALC
	}

	Predac_int_ptr_dtsx = L2_Core1data_start_addr;
	p_InputParam->Outputptr = (unsigned int *)Predac_int_ptr_dtsx; 	//Predac buffer internal

	p_InputParam->Inputptr = (unsigned int *)Pack_buffer_Int+2;

	if(Frmwk.StreamType == SYNCSIGDTSLDCD)
	{
		if (Frmwk.Autdet.FormatStream)
			p_InputParam->Inputptr = (unsigned int *) Pack_buffer_Int+2;
		else
			p_InputParam->Inputptr = (unsigned int *) Pack_buffer_Int;
	}

	if(Frmwk.StreamType == SYNCSIGDTSLBR)
	{
		p_InputParam->Inputptr = (unsigned int *) Pack_buffer_Int+5;
	}
	p_InputParam->PostProcessPcm 		   = 0;
	p_InputParam->nPrimaryFlags 		   = Frmwk.DTSX.nPrimaryFlags;
	p_InputParam->InitDecoder 			   = Frmwk.DTSX.initdecoder;
	p_InputParam->CommandProcessingDone    = Frmwk.DTSX.DTSXcommandprocessingdone_c1;
	p_InputParam->InitConfigStructureDone  = Frmwk.DTSX.InitConfigStructureDone;
	p_InputParam->buffer_pointer[0] 	   = (unsigned int *) Int_Block0_start_addr;
	p_InputParam->buffer_pointer[2] 	   = (unsigned int *) L2_Core1data_start_addr;
	p_InputParam->buffer_pointer[2] += (13*1024); // This add needed because already 12*1024 is used for Library predac;

	Frmwk.DTSX.DTSX_Commands[3] = ((Frmwk.DTSX.DTSX_Commands[3] & 0xFFDF));
	
	if(p_InputParam->InitDecoder == 1)
	{
		*Dtsx_Core2_init_done = 0;
	}
	/* 0 : Frame scanner will update stream type for first frame
	1 : Frame scanner will update stream type for Every frame*/
	p_InputParam->Frame_Scanner_enable_kernel = 0;
	p_InputParam->Realtime_cust_var_kernel = 1;
	p_InputParam->DTSX_External_PP_value = DTSX_External_PP_Kernel;

	if(Frmwk.DTSX.dec_mode_ctrl_var_1 == 1)
	{
		Frmwk.DTSX.nDecMode_value = 0;
	}

	if(Frmwk.DTSX.dec_mode_ctrl_var_2 == 1)
	{
		Frmwk.DTSX.nDecMode_value = 1;
	}

	if(Frmwk.DTSX.dec_mode_ctrl_var_3 == 1)
	{
		Frmwk.DTSX.nDecMode_value = 3;
	}

	if(Frmwk.DTSX.dec_mode_ctrl_var_4 == 1)
	{
		Frmwk.DTSX.nDecMode_value = 4;
	}

	p_InputParam->nDecMode = Frmwk.DTSX.nDecMode_value;

#ifdef DTSX_MIPS_CALC
		   STIMER_DTSX();
#endif //DTSX_MIPS_CALC

    Frmwk.DTSX.dtsxframecount++;

	//DTS:X Decoder calling from here
    MODE_SAVE_DTSX();
#ifdef DTSX_LIB
	DTSX_Decoder(p_InputParam,p_OutputParam,(unsigned int *)Frmwk.DTSX.DTSX_Commands);
#endif //DTSX_LIB
	MODE_CLR_DTSX();

#ifdef DTSX_MIPS_CALC
	Frmwk.DTSX.cycles = ETIMER_DTSX();
	DtsxCalculateMIPS();
#endif //DTSX_MIPS_CALC


#ifdef DTSX_LIB
	DTSX_StatusUpdate_Kernel((dtsInputParameter *)InputParameter,(dtsOutputParameter *)OutputParameter);
#endif //DTSX_LIB

	metadata_wr_ptr_val = (int *) Frmwk.IOP.AddPreDac.wr_ptr;
	MetaBuffer =(int *) p_OutputParam->Metadata_Ptr;

	//#pragma vector_for
	//#pragma no_alias
	for(int meta_index=0; meta_index< p_OutputParam->Metadata_Size; meta_index++)
	{
		metadata_wr_ptr_val[meta_index] = MetaBuffer[meta_index];
	}

	*Meta_update_C1 = 1;	// Shared variable to CORE 2 for updating Metadata (based on Fs)

	if(Frmwk.DTSX.nPrimaryFlags == 0)
	{
		update_pack_rd_ptr(Frmwk.DTSX.Frame_Length_ker);
	}

	if( (Frmwk.DTSX.Status.SamplingFrequencyDecoded != Frmwk.InitDoneForFS) || (Frmwk.DTSX.Status.DecoderError == 1) )
	{
		Frmwk.InitDoneForFS = -1;
		Frmwk.DTSX.initdecoder = 1;
		Frmwk.InitDoneForStreamType = -1;
		Init_Var();
		Frmwk.Autdet.HeaderPlaceWritten = 0;
		Frmwk.ADI_DecoderError = DECODER_ERROR;

		return;
	}
	else
	{
		if(Frmwk.ADI_DecoderError > 0)
			return;
		if (Frmwk.DTSX.Status.SamplingFrequencyDecoded ==DTSX192K)
		{
			Frmwk.OutputSampleRate = 0xA;
		}
		else if (Frmwk.DTSX.Status.SamplingFrequencyDecoded==DTSX96K)
		{
			Frmwk.OutputSampleRate = 0x6;
		}
		else if (Frmwk.DTSX.Status.SamplingFrequencyDecoded==DTSX48K)
		{
			Frmwk.OutputSampleRate = 0x2;
		}
		else if (Frmwk.DTSX.Status.SamplingFrequencyDecoded ==DTSX44K1)
		{
			Frmwk.OutputSampleRate = 0x1;
		}
		else if (Frmwk.DTSX.Status.SamplingFrequencyDecoded ==DTSX88K2)
		{
			Frmwk.OutputSampleRate = 0x5;
		}
		else if (Frmwk.DTSX.Status.SamplingFrequencyDecoded ==DTSX176K4)
		{
			Frmwk.OutputSampleRate = 0x9;
		}

#ifdef CORE1_TX
		SHIFTPREDACINT_MCPCM();  //to shift predac values
		ConvertBlock2Interleaved_2PredacExt(Frmwk.DTSX.ppcmoutput);
#else
		Change_Block_copy_for_96and192Khz(Frmwk.DTSX.ppcmoutput);

#endif

#ifdef DOWNSAMPLING_DTSX
		if((Frmwk.DTSX.Status.SamplingFrequencyDecoded <=48000) || (Frmwk.DS_Mode == 0x3) || (Frmwk.DTSX.Status.SamplingFrequencyDecoded ==192000 && Frmwk.DS_Mode == 0x1))
		{
			down_samp_flag = 0;
			*DTSX_DS_Enable = 0;
			down_samp_flag_cmd = 0;
			DnSamp192to48 = 0;
		}
		if( (*DTSX_DS_Enable == 1)&& (Frmwk.OutputSampleRate == 6))
		{
			Frmwk.OutputSampleRate = 2;
		}
		if( (*DTSX_DS_Enable == 1)&& (Frmwk.OutputSampleRate == 5 ))
		{
			Frmwk.OutputSampleRate = 1;
		}
#endif //DOWNSAMPLING_DTSX

		DTSX_Core2_Status_Update();
		Control_Data_Update_DTSX();

#ifdef DTSX_LATENCY_CALC
		if(DTSX_Latency_stat_var_c1 == 1)
		{
			  DTSX_Latency_predac_wrt_ptr = (int* )Frmwk.IOP.Predac.wr_ptr;
			  DTSX_Latency_predac_wrt_ptr[0] = 0x12345678;
			  *DTSX_latency_state_frm_c1 = 1;
			  DTSX_Latency_stat_var_c1 = 0;
		}
#endif //DTSX_LATENCY_CALC

		PredacPtrUpdate_DTSX();

		AddPredac_Ptr_Update(); //Metadata buffer

		*predac_wr_ptr_c1=Frmwk.IOP.Predac.wr_ptr;
		Frmwk.ADI_DecoderError = NO_ERROR;
		if(Frmwk.DTSX.Status.Valid == 0)
		{
	       Frmwk.ADI_DecoderError=2;
		}
		return ;
	}
}

/******************************************************************************
 *  Module Name        : DTSX_StatusUpdate_Kernel
 *  Functionality      : DTSX Decoder Status variables copied from Library 
 *					     structure to Kernel structure
 *  Input Parameters   : p_InputParam , p_OutputParam from DTSX decoder
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_dtsx_kernal_code")
void DTSX_StatusUpdate_Kernel(dtsInputParameter *p_InputParam,	dtsOutputParameter *p_OutputParam)
{

		int i;
		Frmwk.DTSX.initdecoder = p_InputParam->InitDecoder;
		Frmwk.DTSX.nPrimaryFlags = p_InputParam->nPrimaryFlags;
		Frmwk.DTSX.DTSXcommandprocessingdone_c1 = p_InputParam->CommandProcessingDone;
		Frmwk.DTSX.InitConfigStructureDone = p_InputParam->InitConfigStructureDone;
		Frmwk.DTSX.OutputChannel_Confiq_command = Frmwk.DTSX.DTSX_Commands[0] | ((Frmwk.DTSX.DTSX_Commands[1] << 5 ) & 0x1f0000);

		Frmwk.DTSX.Status.Valid = p_OutputParam->Status.Valid;
		Frmwk.DTSX.Status.Es_Flag = p_OutputParam->Status.Es_Flag;
		Frmwk.DTSX.Status.DialNorm = p_OutputParam->Status.DialNorm;
		Frmwk.DTSX.Status.DecoderError = p_OutputParam->Status.DecoderError;
		Frmwk.DTSX.Status.ExtensionError = p_OutputParam->Status.ExtensionError;
		Frmwk.DTSX.Status.SamplingFrequencyOriginal = p_OutputParam->Status.SamplingFrequencyOriginal;
		Frmwk.DTSX.Status.SamplingFrequencyDecoded = p_OutputParam->Status.SamplingFrequencyDecoded;
		Frmwk.DTSX.Status.NumberofChannelsOriginal = p_OutputParam->Status.NumberofChannelsOriginal;

		if ( (Frmwk.DTSX.DTSX_Commands[1] >> 1) & 0x1 )
		{
			if (Frmwk.DTSX.Status.SamplingFrequencyOriginal >= 176400)
			{
				Frmwk.DTSX.Status.SamplingFrequencyDecoded = Frmwk.DTSX.Status.SamplingFrequencyOriginal/2;
			}
		}

		Frmwk.DTSX.Status.ChannelConfigurationOriginal = p_OutputParam->Status.ChannelConfigurationOriginal;
		Frmwk.DTSX.Status.ReplacementGrp_ChSet[0] = p_OutputParam->Status.ReplacementGrp_ChSet[0];
		Frmwk.DTSX.Status.ReplacementGrp_ChSet[1] = p_OutputParam->Status.ReplacementGrp_ChSet[1];
		Frmwk.DTSX.Status.ReplacementGrp_ChSet[2] = p_OutputParam->Status.ReplacementGrp_ChSet[2];
		Frmwk.DTSX.Status.StreamType = p_OutputParam->Status.StreamType;
		Frmwk.DTSX.Status.LtRtStream = p_OutputParam->Status.LtRtStream;
		Frmwk.DTSX.Status.HeadPhoneStream = p_OutputParam->Status.HeadPhoneStream;
		Frmwk.DTSX.Status.LFE_Presence = p_OutputParam->Status.LFE_Presence;
		Frmwk.DTSX.Status.LFE_Count   = p_OutputParam->Status.LFE_Count;
		Frmwk.DTSX.Status.DRC_Presence = p_OutputParam->Status.DRC_Presence;
		Frmwk.DTSX.Status.NeoX_Flag = p_OutputParam->Status.NeoX_Flag;

		if(Frmwk.DTSX.Status.NeoX_Flag)
			Frmwk.DTSX.Status.NeoX_Flag = 1;

		Frmwk.DTSX.Status.Type1_Flag = p_OutputParam->Status.Type1CertifiedContent;
		Frmwk.DTSX.Status.DTSX_CoreFsize_Status      =	p_OutputParam->Status.CoreFsize_T1CC;

		if(Frmwk.DTSX.Status.SamplingFrequencyDecoded == 0)
		{
			if(Frmwk.DTSX.Status.SamplingFrequencyOriginal <= 12000)
			{
				Frmwk.DTSX.Status.SamplingFrequencyDecoded = 4 * Frmwk.DTSX.Status.SamplingFrequencyOriginal;
			}
			else if (Frmwk.DTSX.Status.SamplingFrequencyOriginal <= 24000)
			{
				Frmwk.DTSX.Status.SamplingFrequencyDecoded = 2 * Frmwk.DTSX.Status.SamplingFrequencyOriginal;
			}
			else
			{
				Frmwk.DTSX.Status.SamplingFrequencyDecoded = Frmwk.DTSX.Status.SamplingFrequencyOriginal;
			}
		}

		if(Frmwk.DTSX.Status.SamplingFrequencyDecoded == DTSX32K )
			Frmwk.DTSX.Status.SamplingFrequencyDecoded_status = 0;
		if(Frmwk.DTSX.Status.SamplingFrequencyDecoded == DTSX44K1 )
			Frmwk.DTSX.Status.SamplingFrequencyDecoded_status = 1;
		if(Frmwk.DTSX.Status.SamplingFrequencyDecoded == DTSX48K )
			Frmwk.DTSX.Status.SamplingFrequencyDecoded_status = 2;
		if(Frmwk.DTSX.Status.SamplingFrequencyDecoded == DTSX64K )
			Frmwk.DTSX.Status.SamplingFrequencyDecoded_status = 4;
		if(Frmwk.DTSX.Status.SamplingFrequencyDecoded == DTSX88K2 )
			Frmwk.DTSX.Status.SamplingFrequencyDecoded_status = 5;
		if(Frmwk.DTSX.Status.SamplingFrequencyDecoded == DTSX96K )
			Frmwk.DTSX.Status.SamplingFrequencyDecoded_status = 6;
		if(Frmwk.DTSX.Status.SamplingFrequencyDecoded == DTSX176K4 )
			Frmwk.DTSX.Status.SamplingFrequencyDecoded_status = 9;
		if(Frmwk.DTSX.Status.SamplingFrequencyDecoded == DTSX192K )
			Frmwk.DTSX.Status.SamplingFrequencyDecoded_status = 10;

		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX8K )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 11;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX16K )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 12;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX11K25 )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 13;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX22K5 )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 14;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX24K )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 16;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX12K )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 15;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX32K )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 0;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX44K1 )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 1;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX48K )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 2;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX64K )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 4;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX88K2 )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 5;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX96K )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 6;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX176K4 )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 9;
		if(Frmwk.DTSX.Status.SamplingFrequencyOriginal == DTSX192K )
			Frmwk.DTSX.Status.SamplingFrequencyOriginal_status = 10;

		for(i=0;i<33;i++)
		{
			if(p_OutputParam->Output.pSamples[i] != 0)
			{
				Frmwk.DTSX.numberofchannels++;
			}
		}
		if(Frmwk.DTSX.Status.SamplingFrequencyDecoded > DTSX96K)
			Frmwk.Number_Of_Channels = 8;
		else if(Frmwk.DTSX.Status.SamplingFrequencyDecoded > DTSX48K)
			Frmwk.Number_Of_Channels = 16;
		else
			Frmwk.Number_Of_Channels = 32;

		*sampling_frequency = Frmwk.DTSX.Status.SamplingFrequencyDecoded;
		Frmwk.DTSX.ppcmoutput =(int*) p_OutputParam->Output.pSamples;
		Frmwk.DTSX.Status.DTS_AmbisonicStream   = p_OutputParam->Status.Ambisonic_Stream;
}
/******************************************************************************
 *  Module Name        : DTSX_Core2_Status_Update
 *  Functionality      : DTSX Decoder Status variables from core2 to
 *					     Kernel structure
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_dtsx_kernal_code")
void DTSX_Core2_Status_Update(void)
{
/*****************core 2 status update*************************/

		Frmwk.DTSX.Status.Number_of_objects		= *Number_of_Objects;
		Frmwk.DTSX.Status.Parma_done			= *Parma_done;
		Frmwk.DTSX.Status.Rendering_done 		= *Rendering_done;
		Frmwk.DTSX.Status.Downmix_Normalization	= *Downmix_Normalization;
		Frmwk.DTSX.Status.Dialog_Presence		= *Dialog_Interactivity;
		Frmwk.DTSX.Status.IMAX_Done				= *IMAX_Done;
		Frmwk.DTSX.Status.Type1CC_State_Var     = *Type1cc_State;
		Frmwk_DtsxCore2StatusValid			    = *DtsxCore2StatusValid;
		Frmwk.DTSX.Status.Remapping_Performed   = *Remapping_done;
#ifdef TRUBASS
		Frmwk.DTSX.Status.TruBass_Done = *TruBassDone;
#endif
		/**************************************************************/
}
/******************************************************************************
 *  Module Name        : Control_Data_Update_DTSX
 *  Functionality      : DTSX Decoder OutputParameter copy
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_dtsx_kernal_code")
void Control_Data_Update_DTSX(void)
{
 	*Primary_flag = Frmwk.DTSX.nPrimaryFlags;
	memcpy(output_parameter_buffer,OutputParameter,OUT_PARAM_COPY*sizeof(int));
	output_parameter_buffer[68] = OutputParameter[101];
	*Frmwk_Outputsamplerate_c1	= Frmwk.OutputSampleRate;
	*Ver4_info_c1 = Ver_No_4;
}

/******************************************************************************
 *  Module Name        : DtsxCalculateMIPS
 *  Functionality      : Used to calculate MIPS and store frame wise MIPS in 
 *						 EvryFrameMips Buffer
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
#ifdef DTSX_MIPS_CALC
section("seg_dtsx_kernal_code")
void DtsxCalculateMIPS()
{
	Frmwk.DTSX.TempMips = ((float)Frmwk.DTSX.cycles/256000)*((float)48000/1000);

	if( Frmwk.DTSX.dtsxframecount > 10)
	{
		EvryFrameMips[Frmwk.DTSX.MipsIdx++] = Frmwk.DTSX.TempMips;
	}

	if(Frmwk.DTSX.MipsIdx > 29999)
	{
		Frmwk.DTSX.MipsIdx = 0;
	}
}

#endif //DTSX_MIPS_CALC

#endif //DTSX_DECODER
