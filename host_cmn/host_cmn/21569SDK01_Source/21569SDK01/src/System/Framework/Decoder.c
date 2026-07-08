/*****************************************************************************
 *
 *  (C)Copyright Analog Devices Inc., India.
 *  All rights reserved. Reproduction in whole or part is prohibited without
 *  the written permission of the copyright owner.
 *
 *  Project          :  	21569SDK
 *  Organization     :  	Jasmin Infotech Private Limited,Chennai
 *  File Name        :		Decoder.c
 *  Description      :   	Decoder routines

 ******************************************************************************/

#pragma default_section(CODE,"Seg_Decoder_Code")

#include "../Include/Decoder.h"
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

	DAC_Channel_Size_Allocation();

#ifdef MCPCM_DEC
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
			Frmwk.pack_length_mcpcm 		= PACK_LENGTH_MCPCM;
			Frmwk.predac_length_mcpcm		= PREDAC_LENGTH_MCPCM;

			Free_AllotMemoryPackDac(Frmwk.pack_length_mcpcm, Frmwk.predac_length_mcpcm, 1);

		    Frmwk.OutputSampleRate 			= Frmwk.sampling_fs_micro;
			
			I_CCALL_2ARG_(SRU_Reconfigure, Frmwk.sampling_fs_micro, Frmwk.OutputSampleRate);   /*SRU Reconfigure call*/
			Frmwk.IOP.Predac.length 			= PREDAC_LENGTH_MCPCM;
			Frmwk.IOP.Predac.lengthhalf 		= PREDAC_LENGTH_MCPCM/THREE_HALF;
			Frmwk.SampleBlock 					= Frmwk.IOP.Predac.lengthhalf/NUMMAXCHAN;
			Frmwk.Autdet.AlignFlg				= 0;    /* Initialise stream detection variables to start fresh detection */
			Frmwk.Autdet.StreamDetectEnable		= 1;
			Frmwk.InitDoneForStreamType 		= SYNCSIGUNKNOWN;
			Frmwk.MemoryAllotMCLPCM				= 1;
			Frmwk.No_of_Channel 				= NO_OF_INPUT_CHANNEL;

			if(Frmwk.inputChannelConfig==2)
			{
				Frmwk.Decoder_Channel_Assignment = 0xA000;
				Frmwk.Customer_pp.ChannelMask = 0x3;
			}
			else if(Frmwk.inputChannelConfig==6)
			{
				Frmwk.Decoder_Channel_Assignment = 0xF801;
				Frmwk.Customer_pp.ChannelMask = 0x3F;
			}
			else if(Frmwk.inputChannelConfig==8)
			{
				Frmwk.Decoder_Channel_Assignment = 0xFA01;   // L, R, C, LFE, Ls, Rs, Lsr, Rsr
				Frmwk.Customer_pp.ChannelMask = 0xFF;
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
#endif /*	End of #ifdef MCPCM_DEC	*/

/**************************************************************************************************
 *									MCPCM Decoder END
 *************************************************************************************************/

	Init_Var();

	return 0;
}	/*	End of PlayForgnd function	*/


/**************************************************************************************************
*  Module Name        : MCPCMDecoder
*  Functionality      : MCPCMDecoder function initialization, latency process and pointers updates are
*  						done here
*
*  Input Parameters	  : None
***************************************************************************************************/
#ifdef MCPCM_DEC
section("seg_kernal_code_l3")
void MCPCMDecoder()
{
	Frmwk.ADI_DecoderError = NO_ERROR;
	while(1)
	{
		int i,j;
		if(Frmwk.IOP.datacanbeprocessednow == 0)
		{
			for(int i=0;i<Frmwk.IOP.Predac.length;i++)
			{
				Predac_buffer_Ext[i]=0;
			}
			for(int i=0;i<(NO_OF_TX_SAMPLE_COUNT*NUMMAXCHAN);i++)
			{
				TX_EXT_DMA_BUFFER[i]=0;
			}

			Frmwk.IOP.Predac.rd_ptr = (int)Frmwk.IOP.Predac.heap;
			Frmwk.IOP.Predac.wr_ptr = (int)Frmwk.IOP.Predac.heap;
			Frmwk.IOP.datacanbeprocessednow = 1;
			Frmwk.pack_length_mcpcm 		= PACK_LENGTH_MCPCM;
			Frmwk.predac_length_mcpcm		= PREDAC_LENGTH_MCPCM;
			//Free_AllotMemoryPackDac(Frmwk.pack_length_mcpcm, Frmwk.predac_length_mcpcm,1);
			Frmwk.IOP.Pack.rd_ptr = Frmwk.Autdet.HeaderAddress;
			Frmwk.IOP.LatencyDone = 0;
			Frmwk.IOP.LatencyFlag = 0;
			Frmwk.SampleBlock=Frmwk.IOP.Predac.lengthhalf/NUMMAXCHAN;
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

		if((i - ((Frmwk.IOP.Predac.lengthhalf+(NO_OF_TX_SAMPLE_COUNT*NUMMAXCHAN))*4)) < 0)
		{
			Frmwk.ADI_DecoderError = EMPTY_SPACE_ERROR;
			break;
		}

		/* Transfer latency content before processing */
		if (Frmwk.IOP.LatencyDone == 0)
		{
			//Frmwk.IOP.LatencyCnt=Frmwk.SampleBlock*2;
			Frmwk.IOP.LatencyDone = 1;
			Frmwk.Tx.Tx_LatencyFlag=0;
			Frmwk.IOP.Predac.wr_ptr=(uint32_t)&Predac_buffer_Ext[Frmwk.IOP.Predac.lengthhalf];
		}

		/* Copy MCPCM content from Pack buffer to Predac Buffer */
			Pack_TO_Predac_MCPCM();

		/* Update the Input buffer read pointer to copy next input frame 	*/
		PackUpdate();

		SrcBuf=Frmwk.IOP.Predac.wr_ptr;
		DstBuf=&Predac_buffer_Int[0];

		bMemCopyInProgress1 = true;

		/* Copy MCPCM content from External Predac buffer to Internal Predac Buffer using MDMA */
		Predac_Buffer_Ext_To_Predac_Buffer_Int_DMA(BufSize,SrcBuf,DstBuf);

		while(bMemCopyInProgress1)
		{
			adi_mdma_IsCopyInProgress (hMemDmaStream1, &bMemCopyInProgress1);
		}

//SET_TIMER();
	PostProcessing_Routine();
//CALCULATE_MIPS(&CustPP_Cycles);

		/* Copy MCPCM content from Internal Predac buffer to External Predac Buffer */
		Predac_Buffer_Int_To_Predac_Buffer_Ext();

		/* Update the Output buffer write pointer to copy next decoded frame 	*/
		Pre_Dac_Ptr_Update();

		Frmwk.ADI_DecoderError = NO_ERROR;
		break;
	}//While Loop

}//MCPCM
#endif
