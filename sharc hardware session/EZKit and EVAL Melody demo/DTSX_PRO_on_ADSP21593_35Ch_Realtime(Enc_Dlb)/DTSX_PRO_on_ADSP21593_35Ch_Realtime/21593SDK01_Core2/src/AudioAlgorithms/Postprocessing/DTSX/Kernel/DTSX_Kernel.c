/*****************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :  	DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	DTSX_Kernel.c
*  Description      :   DTSX Decoder Postprocessing Kernel related function can be
*  					 	included here
******************************************************************************/
#include "stdio.h"
#include "dts_interface.h"
#include "Commn.h"
#include "DTSX_Kernel.h"
#include "Def_struct.h"
#include "Extern_Core2.h"

#ifdef DTSX_DECODER
/*************************************************************************************************************
 *  Module Name        :DtsxPostProcessing
 *  Functionality      :Copying DTSX decoder data to internal pack, metadata copy for Non DTS stream,
 *                      DTSX Kernel call, Trubass processing call, changing DTSX decoder + PP output data from block to interleaved
 *  Input Parameters   :None
 *  Output Parameters  :None
 **************************************************************************************************************/
#pragma optimize_for_speed
section("seg_dtsx_kernal_code")
void DtsxPostProcessing()
{
	DTSX_Control_DataVariable_Update();                //DTSX control data updates only
	/******DTSX DSP2 PACK COPY********/
	if(Frmwk.DTSX.StreamType_DTSX== 1)
	{
		COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_OPTI(); //Core1 Op - Block,Core2 Copy - Block
	}
	else if(*McpcmNeuralX == 1)
	{
		COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_MCPCM();//Core1 Op - Interleaved,Core2 Copy - Block
	}
	else
	{
		COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON();      //Core1 Op - Interleaved,Core2 Copy - Block
	}

    if(Frmwk.DTSX.StreamType_DTSX == 0)
    {
		int CopyIdx;

		Frmwk.DTSX.speakerRemapMask = Frmwk.DTSX.outputconfig_DTSX;
		convertSpkrOut((unsigned int *)&Frmwk.DTSX.speakerRemapMask);

		#pragma vector_for
		#pragma no_alias
		for(CopyIdx = 0;CopyIdx < DTSXMETADATASIZE;CopyIdx++)
		{
			 Add_Meta_Data_buffer[CopyIdx] = 0;                   //Clear Metadata Buffer
		}

		Add_Meta_Data_buffer[0] = 0xBA;						 	  // "OxBA - Metadata Sync word"
		Add_Meta_Data_buffer[1] = Frmwk.DTSX.outputconfig_DTSX;   // playerConfig->nSpkrOut
		Add_Meta_Data_buffer[4] = Frmwk.DTSX.speakerRemapMask;    // playerConfig->primaryDecoderConfig.SpkrOut - 4th loc
		Add_Meta_Data_buffer[5] = Frmwk.DTSX.outputconfig_DTSX;   // playerConfig->nSpkrOut
		Add_Meta_Data_buffer[14] = 24;                            // Output Bitwidth
		Add_Meta_Data_buffer[20] = 0x1;		                      // Blindmode(disabledirectmode)
		Add_Meta_Data_buffer[33] = Frmwk.DTSX.speakerRemapMask;

		if(Frmwk.DTSX.outputconfig_DTSX& DTSSPKROUT_MASK_LtRt)    // To avoid Error printing in LtRt Streams
		{
			Add_Meta_Data_buffer[33] = 0;
		}

		//For Neural:X (Blind PARMA) enabled case, to enable speaker remapper for PCM/MCPCM streams if PARMA processing is not performed.
		Add_Meta_Data_buffer[34] = 0x1;                  //bSpeakerRemapRequired

		Add_Meta_Data_buffer[35]   = 0x1;		             // bAnalogCompensationEnabled(speakerRemapper.pSpeakerRemapRuntimeConfig->bAnalogCompModeEnabled)
		Add_Meta_Data_buffer[36]   = 0x4;		             // Decoder mode
		Add_Meta_Data_buffer[757]  = 0x1;	                 // bPostProcessPcm
		Add_Meta_Data_buffer[762]  = 0x1;	                 // bAnalogCompensationEnabled
		Add_Meta_Data_buffer[1697] = 0x4;		             // Decoder mode

		#pragma vector_for
		for(int i=0; i<PACK_LENGTH_MCPCM_INT; i++)
		{
			 Pack_buffer_Int[i] = Pack_buffer_Int[i] >> 8;
		}
	 }

	Frmwk.DTSX.dtsxframecount++;

	/********DTSX LIBRARY**********/
	DTSX_Kernel();

	SHIFTPREDACINT_MCPCM(Predac_buffer_Int_Ptr,DTSXINTPREDACSIZE,DTSXINTPREDACSIZEHALF);  //To lshift(8) the entire internal predac buffer

#ifdef TRUBASS
	/********TRUBASS HDX LIBRARY**********/
	TruBass_Process();
#endif
	DTSX_DecoderMask_pp = DTSX_DecoderMask;
	convertSpkrMask_pp((unsigned int*)&DTSX_DecoderMask_pp );
	Frmwk.Customer_pp.ChannelMask = DTSX_DecoderMask_pp;

#ifdef DTSX_CHANREORDER
	convertSpkrMask((unsigned int*)&DTSX_DecoderMask );
	Frmwk.DTSX.ChanReorder_inputConfig = DTSX_DecoderMask;
	Frmwk.DTSX.ChannelReorder_DTSX = 1;
	Channel_Reorder_Kernel();
#else
	COPYPREDACTO_EXTPREDAC_MCPCM_DTSX(Predac_buffer_Int_Ptr);
#endif //DTSX_CHANREORDER

	if(Frmwk.DTSX.StreamType_DTSX == 1)
	{
		if(MetaPtrUpdate_Var == 1)
		{			
			addpredac_rd_ptr_dtsx_update();
		}
	}
}
/******************************************************************************
 *  Module Name        :DTSX_Kernel
 *  Functionality      :DTSX Postprocessing memory allocation, DTSX Decoder Postprocessing call,
 *                      and status update for core1
 *  Input Parameters   :None
 *  Output Parameters  :None
 ******************************************************************************/
section("seg_dtsx_kernal_code")
void DTSX_Kernel(void)
{
	dtsInputParameter *p_InputParam;
	dtsOutputParameter *p_OutputParam;

	p_InputParam = ( dtsInputParameter * )InputParameter;
	p_OutputParam = ( dtsOutputParameter * )OutputParameter;

	Predac_buffer_Int_Ptr =(int *) L2_core2StartAddr + 98304; //added Core1 reserved L2 3Mbits size
	p_InputParam->PP_Outputptr =(unsigned int *) Predac_buffer_Int_Ptr;
	Frmwk.DTSX.post_pointer = (int)Predac_buffer_Int_Ptr;

	// Init DTSX Input Parameters
	DTSX_Param_Init( p_InputParam, p_OutputParam );

	FFTBlockZeroDmAddr =  (get_fft_ptr1(FFT_DM_start));
	FFTBlocktwoPmAddr  = (get_fft_ptr1(FFT_PM_start));

#ifdef DTSX_MIPS_CALC
	STIMER_DTSX();
#endif

	MODE_SAVE_DTSX();

	/********DTSX LIBRARY**********/
	DTSX_Decoder( p_InputParam, p_OutputParam, Frmwk.Misc.List.alg_input_list, (int*)&Frmwk.DTSX.DTSX_Commands );

	MODE_CLR_DTSX();

#ifdef DTSX_MIPS_CALC
	Frmwk.DTSX.cycles = ETIMER_DTSX();
	DtsxCalculateMIPS();
#endif

	Frmwk.DTSX.DTSXcommandprocessingdone_c2 = 	p_InputParam->CommandProcessingDone;
	if(Predac_Zero_Flag < 4)
	{
		for(int i=0;i<DTSXINTPREDACSIZE;i++)
		{
			Predac_buffer_Int_Ptr[i] = 0;
		}
		Predac_Zero_Flag++;
	}

	*Number_of_Objects 				= 	Frmwk.DTSX.Status.Number_of_objects = p_OutputParam->status.Number_of_objects;
	*Parma_done 					= 	Frmwk.DTSX.Status.parma_done = p_OutputParam->status.parma_done;
	*Rendering_done 				= 	Frmwk.DTSX.Status.rendering_done = p_OutputParam->status.rendering_done;
	*Dialog_Interactivity 			= 	Frmwk.DTSX.Status.Dialog_interactivity =  p_OutputParam->status.Dialog_interactivity;
	*Downmix_Normalization 			= 	Frmwk.DTSX.Status.Downmix_Normalization = p_OutputParam->status.Downmix_Normalization;
	*Type1cc_State                  =   Frmwk.DTSX.Status.Type1CC_State_Var =  p_OutputParam->status.Type1CC_State_Var;
	*IMAX_Done						=	Frmwk.DTSX.Status.IMAX_done   =   p_OutputParam->status.IMAX_done;
	DTSX_DecoderMask	    		=   p_OutputParam->Output.speakerMask;
	*Core2_InitConfigStructureDone  =   p_InputParam->InitConfigStructureDone;
	*Remapping_done                 = Frmwk.DTSX.Status.Remapping_Performed =  p_OutputParam->status.Remapping_done;
	*DtsxCore2StatusValid = 1;
	Stream_inp_spkmask = 0;
	Stream_inp_spkmask = p_InputParam->Input.speakerMask;
	Frmwk.DTSX.Status.Speaker_Remap_Done = p_OutputParam->status.Speaker_Remapper_Done;
	DTS_Lsrs_Swap = 0;
	if((Frmwk.DTSX.Status.Speaker_Remap_Done == 0) && (Frmwk.DTSX.Status.parma_done==1) && ((Frmwk.DTSX.outputconfig_DTSX>>0x2) & 0x1) && ((Frmwk.DTSX.outputconfig_DTSX>>0xb) & 0x1))
	{
		DTS_Lsrs_Swap = 1;
	}
}
/******************************************************************************
 *  Module Name        :DTSX_Param_Init
 *  Functionality      :DTSX Postprocessing initialization and
 *                      input parameter updation
 *  Input Parameters   :p_InputParam, p_OutputParam from DTSX_Kernel
 *  Output Parameters  :None
 ******************************************************************************/
section("seg_dtsx_kernal_code")
void DTSX_Param_Init(dtsInputParameter *p_InputParam, dtsOutputParameter *p_OutputParam)
{
	int k,CopyIdx;
	int *DTSX_InBuf_ptr,*MetaRdPtr;
	dtsInputParameter *InputParam = (dtsInputParameter *)p_InputParam;
	dtsOutputParameter *OutputParam = (dtsOutputParameter *)p_OutputParam;

	if(Frmwk.DTSX.StreamType_DTSX == 1)
	{
		p_InputParam->nPrimaryFlags = *Primary_flag;
		p_InputParam->InitConfigStructureDone = *Core2_InitConfigStructureDone;
		memcpy(&InputParam->Input, dtsDecoderInput, 68*sizeof(int));
		InputParam->Input.repTypes = dtsDecoderInput[68];
		InputParam->Input.numberOfSamples = 256;
		p_InputParam->DTSX_Downsampling_flag = 0;
		if(*Stream_sample_rate == 256)
		{
			p_InputParam->Output_samplingrate_c1 = 48000;
		}
		else if((*Stream_sample_rate == 512)&&(*DTSX_DS_Enable==1))
		{
			p_InputParam->Output_samplingrate_c1 = 48000;
			p_InputParam->DTSX_Downsampling_flag = 1;
		}
		else if(*Stream_sample_rate == 512)
		{
			p_InputParam->Output_samplingrate_c1 = 96000;
		}
		else
		{
			p_InputParam->Output_samplingrate_c1 = 192000;
		}

		if(*Dtsx_Core2_init_done == 0)
		{
			metadata_cpy_variable = 1;
			*DtsxCore2StatusValid = 0;
#ifdef TRUBASS
			Frmwk.DTSX.TruBass_init_done = 0;
#endif //TRUBASS
		}
		if(metadata_cpy_variable == 1)
		{
			MetaRdPtr = (int *)Frmwk.IOP.AddPreDac.rd_ptr_c2;
			#pragma vector_for
			#pragma no_alias
			for(CopyIdx = 0;CopyIdx < DTSXMETADATASIZE;CopyIdx++)
			{
				Add_Meta_Data_buffer[CopyIdx] = MetaRdPtr[CopyIdx];
				Temp_Meta_Data_buffer[CopyIdx] = Add_Meta_Data_buffer[CopyIdx];
			}
			metadata_cpy_variable = (*Stream_sample_rate)/256;
			MetaPtrUpdate_Var = 1;
		}
		else
		{
			metadata_cpy_variable--;
			#pragma vector_for
			#pragma no_alias
			for(CopyIdx = 0;CopyIdx < DTSXMETADATASIZE;CopyIdx++)
			 {
				Add_Meta_Data_buffer[CopyIdx] = Temp_Meta_Data_buffer[CopyIdx];
			 }
				MetaPtrUpdate_Var = 0;
		}

	}
	else
	{

		InputParam->Input.numberOfSamples = 256;
		InputParam->Input.speakerMask = 6;
		if((*McpcmNeuralX == 1) && (Stream_Type_frm_Core1==0xf ))
		{
			if(numchannels_c1_MCPCM == 8)
			{
				InputParam->Input.speakerMask = 447;
			}
			else if(numchannels_c1_MCPCM == 6)
			{
				InputParam->Input.speakerMask = 63;
			}
		}

	    if(*NeuralXSamplFreq <= 2)
		{
	    	p_InputParam->Output_samplingrate_c1 = 48000;
		}
		else if(*NeuralXSamplFreq > 6)
		{
			p_InputParam->Output_samplingrate_c1 = 192000;
		}
		else
		{
			p_InputParam->Output_samplingrate_c1 = 96000;
		}

		for( k = 0; k < 12; k++ )
		{
			InputParam->Input.bitsPerSample[k] = 24;
			InputParam->Input.samplingRate[k] = Freq_TableDtsx[Frmwk.OutputSampleRate];
		}

		Frmwk.IOP.AddPreDac.rd_ptr_c2 = (int)Add_Meta_Data_buffer;
	}
	if((*Dtsx_Core2_init_done) == 0)
	{
		Predac_Zero_Flag =1;
	}
	Frmwk.Misc.List.alg_input_list[0]  = (int)Dtsx_Core2_init_done;
	Frmwk.Misc.List.alg_input_list[1]  = Frmwk.DTSX.post_pointer;
	Frmwk.Misc.List.alg_input_list[2]  = (int)Add_Meta_Data_buffer;
	Frmwk.Misc.List.alg_input_list[3]  = Freq_TableDtsx[Frmwk.OutputSampleRate];
	DTSX_InBuf_ptr = Pack_buffer_Int;

	for( k = 0; k < 32; k++ )
	{
		InputParam->Input.pSamples[k] = DTSX_InBuf_ptr;
		DTSX_InBuf_ptr+=256;
	}
	Frmwk.DTSX.DTSX_Commands[3] = *Core2_command_parameter4;
	p_InputParam->CommandProcessingDone = Frmwk.DTSX.DTSXcommandprocessingdone_c2;
	p_InputParam->Realtime_cust_var_kernel = 1;
	p_InputParam->Ver_No_4 = *Ver4_info_c1;
	p_InputParam->Ext_Buffer_Data_inp_Size = sizeof(Ext_Buffer_Data)/4;
	p_InputParam->Ext_Buffer_Data_inp_ptr  = (unsigned int ) &Ext_Buffer_Data;
	p_InputParam->DTSX_External_PP_value = DTSX_External_PP_Kernel;

}
/******************************************************************************
 *  Module Name        : convertSpkrOut
 *  Functionality      : Convert Speaker Mask to Bit Mask
 *  Input Parameters   : spkrOut - (Speaker Mask from DTSX Decoder)
 *  Output Parameters  : spkrOut - (Converted Bit Mask will be stored)
 ******************************************************************************/
section("seg_dtsx_kernal_code")
void convertSpkrOut( volatile unsigned int *spkrOut )
{
	unsigned int newSpkrOut = 0;

    if( *spkrOut & DTSSPKROUT_MASK_C )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_C;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LR )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LR;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LsRs )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LsRs;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LFE1 )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LFE1;
    }
    if( *spkrOut & DTSSPKROUT_MASK_Cs )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_Cs;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LhRh )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LhRh;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LsrRsr )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LsrRsr;
    }
    if( *spkrOut & DTSSPKROUT_MASK_Ch )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_Ch;
    }
    if( *spkrOut & DTSSPKROUT_MASK_Oh )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_Oh;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LcRc )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LcRc;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LwRw )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LwRw;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LssRss )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LssRss;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LFE_2 )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LFE_2;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LhsRhs )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LhsRhs;
    }
    if( *spkrOut & DTSSPKROUT_MASK_Chr )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_Chr;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LhrRhr )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LhrRhr;
    }
    if( *spkrOut & DTSSPKROUT_MASK_Clf )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_Clf;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LlfRlf )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LlfRlf;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LtfRtf )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LtfRtf;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LtrRtr )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LtrRtr;
    }
    if( *spkrOut & DTSSPKROUT_MASK_LtRt )
    {
        newSpkrOut |= CONV_DTSSPKROUT_MASK_LtRt;
    }

    *spkrOut = newSpkrOut;
}

#ifdef DTSX_CHANREORDER
/******************************************************************************
 *  Module Name        : convertSpkrMask
 *  Functionality      : Convert Bitmask to Speaker Mask.
 *  Input Parameters   : spkrmask(Bit Mask from DTSX Decoder)
 *  Output Parameters  : spkrmask(Converted Speaker Mask will be stored)
 ******************************************************************************/
section("seg_dtsx_kernal_code")
 void convertSpkrMask( unsigned int *spkrmask )
{
	unsigned int newspkrmask = 0;

    if( *spkrmask & CONV_DTSSPKROUT_MASK_C )
    {
        newspkrmask |= DTSSPKROUT_MASK_C;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LR )
    {
        newspkrmask |= DTSSPKROUT_MASK_LR;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LsRs )
    {
        newspkrmask |= DTSSPKROUT_MASK_LsRs;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LFE1 )
    {
        newspkrmask |= DTSSPKROUT_MASK_LFE1;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_Cs )
    {
        newspkrmask |= DTSSPKROUT_MASK_Cs;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LhRh )
    {
        newspkrmask |= DTSSPKROUT_MASK_LhRh;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LsrRsr )
    {
        newspkrmask |= DTSSPKROUT_MASK_LsrRsr;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_Ch )
    {
        newspkrmask |= DTSSPKROUT_MASK_Ch;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_Oh )
    {
        newspkrmask |= DTSSPKROUT_MASK_Oh;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LcRc )
    {
        newspkrmask |= DTSSPKROUT_MASK_LcRc;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LwRw )
    {
        newspkrmask |= DTSSPKROUT_MASK_LwRw;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LssRss )
    {
        newspkrmask |= DTSSPKROUT_MASK_LssRss;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LFE_2 )
    {
        newspkrmask |= DTSSPKROUT_MASK_LFE_2;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LhsRhs )
    {
        newspkrmask |= DTSSPKROUT_MASK_LhsRhs;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_Chr )
    {
        newspkrmask |= DTSSPKROUT_MASK_Chr;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LhrRhr )
    {
        newspkrmask |= DTSSPKROUT_MASK_LhrRhr;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_Clf )
    {
        newspkrmask |= DTSSPKROUT_MASK_Clf;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LlfRlf )
    {
        newspkrmask |= DTSSPKROUT_MASK_LlfRlf;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LtfRtf )
    {
        newspkrmask |= DTSSPKROUT_MASK_LtfRtf;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LtrRtr )
    {
        newspkrmask |= DTSSPKROUT_MASK_LtrRtr;
    }
    if( *spkrmask & CONV_DTSSPKROUT_MASK_LtRt )
    {
        newspkrmask |= DTSSPKROUT_MASK_LtRt;
    }

    *spkrmask = newspkrmask;
}
/******************************************************************************
 *  Module Name        : convertSpkrMask_pp
 *  Functionality      : Convert Bitmask to Speaker Mask.
 *  Input Parameters   : spkrmask_pp(Bit Mask from DTSX Decoder)
 *  Output Parameters  : spkrmask_pp(Converted Speaker Mask will be stored)
 ******************************************************************************/
section("seg_dtsx_kernal_code")
 void convertSpkrMask_pp( unsigned int *spkrmask_pp )
{
	unsigned int newspkrmask_pp = 0;

	if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LR )
	{
		newspkrmask_pp |= DTSSPKROUT_MASK_LR_pp;
	}
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_C )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_C_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LFE1 )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_LFE1_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LssRss )
	{
    	newspkrmask_pp |= DTSSPKROUT_MASK_LssRss_pp;
	}
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LsrRsr )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_LsrRsr_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LwRw )
	{
    	newspkrmask_pp |= DTSSPKROUT_MASK_LwRw_pp;
	}
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LtfRtf )
	{
    	newspkrmask_pp |= DTSSPKROUT_MASK_LtfRtf_pp;
	}
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LhsRhs )
	{
    	newspkrmask_pp |= DTSSPKROUT_MASK_LhsRhs_pp;
	}
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LtrRtr )
	{
    	newspkrmask_pp |= DTSSPKROUT_MASK_LtrRtr_pp;
	}
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LhRh )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_LhRh_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LhrRhr )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_LhrRhr_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LcRc )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_LcRc_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LlfRlf )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_LlfRlf_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LsRs )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_LsRs_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_Ch )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_Ch_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_Chr )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_Chr_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_Oh )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_Oh_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_Clf )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_Clf_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LFE_2 )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_LFE_2_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_Cs )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_Cs_pp;
    }
    if( *spkrmask_pp & CONV_DTSSPKROUT_MASK_LtRt )
    {
    	newspkrmask_pp |= DTSSPKROUT_MASK_LtRt_pp;
    }

    *spkrmask_pp = newspkrmask_pp;
}

/******************************************************************************
 *  Module Name        : Channel_Reorder_Kernel
 *  Functionality      : Input list for Channel reorder will get updated and
 *				         channel reorder library function call.
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_dtsx_kernal_code")
void Channel_Reorder_Kernel()
{
	Chanreorder_cmd_1_6       = *ChanReorder_AssignLines_1_6;
	Chanreorder_cmd_7_12      = *ChanReorder_AssignLines_7_12;
	Chanreorder_cmd_13_16	  = *ChanReorder_AssignLines_13_16;
	Frmwk.DTSX.ChanReorder_AssignLines_1_6    = (Chanreorder_cmd_1_6 & 0x7FFF);
	Frmwk.DTSX.ChanReorder_AssignLines_1_6   |= (((Chanreorder_cmd_1_6 >> 16) & 0x7FFF)<<15);
	Frmwk.DTSX.ChanReorder_AssignLines_7_12   = (Chanreorder_cmd_7_12 & 0x7FFF);
	Frmwk.DTSX.ChanReorder_AssignLines_7_12  |= (((Chanreorder_cmd_7_12 >> 16) & 0x7FFF)<<15);
	Frmwk.DTSX.ChanReorder_AssignLines_13_16  = (Chanreorder_cmd_13_16 & 0x7FFF);
	Frmwk.DTSX.ChanReorder_AssignLines_13_16 |= (((Chanreorder_cmd_13_16 >> 16) & 0x1F)<<15);
	Frmwk.DTSX.PP_InputList[0]   = Frmwk.DTSX.ChanReorder_inputConfig;	      // Input Channel Configuration
	Frmwk.DTSX.PP_InputList[1]   = Frmwk.DTSX.ChanReorder_AssignLines_1_6;
	Frmwk.DTSX.PP_InputList[2]   = Frmwk.DTSX.ChanReorder_AssignLines_7_12;
	Frmwk.DTSX.PP_InputList[3]   = Frmwk.DTSX.ChanReorder_AssignLines_13_16;

	Frmwk.DTSX.PP_InputList[4]   = (int)Predac_buffer_Int_Ptr;	              // Base Address of input buffer
	Frmwk.DTSX.PP_InputList[5]   = (int)Predac_buffer_Int_Ptr; 	              // Pointer of input buffer
	Frmwk.DTSX.PP_InputList[6]   = DTSXINTPREDACSIZE;                         // Length of input buffer

	Frmwk.DTSX.PP_InputList[7]  = (int)Predac_buffer_Int_c2;			      // Base Address of output buffer
	Frmwk.DTSX.PP_InputList[8]  = (int)Predac_buffer_Int_c2;			      // Pointer of output buffer
	Frmwk.DTSX.PP_InputList[9]  = BUFF_MAX_SIZE;                             // Length of output buffer

	Frmwk.DTSX.PP_InputList[10]  = Frmwk.DTSX.ChannelReorder_DTSX;			  // DTS X Flag
	Frmwk.DTSX.PP_InputList[11]  = DTS_Lsrs_Swap;                             // lsrs swap

	// Call the DTSX Channel Reorder library
	Channel_Reorder_lib_DTSX((int*)Frmwk.DTSX.PP_InputList);
	Frmwk.DTSX.ChReorder_Done = 1;
	Frmwk.DTSX.ChannelReorder_DTSX = 0;
}
#endif //DTSX_CHANREORDER

section("seg_dtsx_kernal_code")
 void DTSX_Control_DataVariable_Update()
{
	int i = 0;
	Frmwk.DTSX.outputconfig_DTSX = *Outputchannel_config_command;  //User configured channel configuration for PCM and DTSX case

	for(i = 0; i < 69; i++)
	{
		dtsDecoderInput[i] = input_parameter_buffer[i];
	}

	DTSX_DecoderMask = dtsDecoderInput[66];               //User configured channel configuration for DTSX case

}

#ifdef DTSX_MIPS_CALC
/******************************************************************************
 *  Module Name        : DtsxCalculateMIPS
 *  Functionality      : Used to calculate MIPS and store frame wise MIPS in
 *						 EvryFrameMips Buffer
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_dtsx_kernal_code")
void DtsxCalculateMIPS()
{
	int DtsxSampFreq = *sampling_frequency;
	Frmwk.DTSX.TempMips = ((float)Frmwk.DTSX.cycles/256000)*((float)DtsxSampFreq/1000);//((cycles*DtsxSampFreq)/(256000*1000));

	if(Frmwk.DTSX.dtsxframecount > 10)
	{
	    EvryFrameMips[Frmwk.DTSX.MipsIdx++] = Frmwk.DTSX.TempMips;
	}

	if(Frmwk.DTSX.MipsIdx > 29999)
	{
		Frmwk.DTSX.MipsIdx = 0;
	}

}
#endif//DTSX_MIPS_CALC
#endif   //DTSX_DECODER


