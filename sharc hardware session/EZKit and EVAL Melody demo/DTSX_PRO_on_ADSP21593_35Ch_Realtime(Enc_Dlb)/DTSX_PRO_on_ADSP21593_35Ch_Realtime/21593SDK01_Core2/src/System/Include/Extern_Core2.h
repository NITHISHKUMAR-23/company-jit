/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Extern_C.h
*  Description      :   Extern framework & ISR variables for C environment can be included here
******************************************************************************/


/*****************************************************************************
	OARi & OAR Variables
*****************************************************************************/
#ifndef EXTERN_CORE2_H
#define EXTERN_CORE2_H
#include "Commn.h"
extern int  Cuspp_cycles;
extern int Sampling_freq;
extern int DecoderBlockSize;

/*****************************************************************************/
extern int Predac_buffer_Int_c2[];

extern int *addpredac_heap;
extern int *addpredac_rd_ptr;
extern int *addpredac_length;
extern int *addpredac_wr_ptr;

extern int pre_dac_ptr_sync;
extern int addpredac_ptr_sync;
extern int Stream_Type_frm_Core1;
extern int *Stream_Profile;
extern int No_Sample_Processing;

#ifdef CUSTOMER_PP
extern int CustPPInputList[];
#endif
extern int *Latency_predac_wr_ptr_c1;
extern int *core2_sync_bit;
extern int *stream_type;
extern int *Next_dac_count;
extern int *core2_command_processing_status_done;
extern int *predac_heap;
extern int *datacanbeprocessnow;
extern int *predac_wr_ptr_c1;
extern int *predac_wr_ptr_c2;
extern int *Predac_length;
extern int *addpredac_rd_ptr;
extern int *addpredac_wr_ptr;
extern int *addpredac_heap;
extern int *addpredac_length;
extern int *Predac_length_half;
extern int *addpredac_lengthhalf;
extern int *SampleBlock_Core2;
extern int *run_flag;

extern int *c1_predac_rd_ptr;
extern int *c1_predac_wr_ptr;

extern int *Frmwk_Legacy_Decoding_Mode_c1;

extern int *Frmwk_Decoded_ChAssignment_FromHost_c1;
extern int *Frmwk_Outputsamplerate_c1;

extern int *Init_Start_Command_c1;

extern int *Upmix_ON_OFF_Status;

extern int *core2_dcpn_done;

extern int *PARAMETER_1_C2;
extern int *PARAMETER_2_C2;
extern int *PARAMETER_3_C2;
extern int *PARAMETER_4_C2;
extern int *PARAMETER_5_C2;
extern int *PARAMETER_6_C2;
extern int *PARAMETER_7_C2;
extern int *PARAMETER_8_C2;
extern int *PARAMETER_9_C2;
extern int *PARAMETER_10_C2;
extern int *PARAMETER_11_C2;
extern int *PARAMETER_12_C2;
extern int *PARAMETER_13_C2;
extern int *PARAMETER_14_C2;
extern int *PARAMETER_15_C2;
extern int *PARAMETER_16_C2;
extern int *PARAMETER_17_C2;
extern int *PARAMETER_18_C2;
extern int *PARAMETER_19_C2;
extern int *PARAMETER_20_C2;
extern int *PARAMETER_21_C2;
extern int *PARAMETER_22_C2;
extern int *PARAMETER_23_C2;
extern int *PARAMETER_24_C2;
extern int *PARAMETER_25_C2;
extern int *PARAMETER_26_C2;
extern int *PARAMETER_27_C2;
extern int *PARAMETER_28_C2;
extern int *PARAMETER_29_C2;
extern int *PARAMETER_30_C2;
extern int *PARAMETER_31_C2;

extern int *COMMAND_BYTE_C2;

extern int *ChanReorder_AssignLines_1_6;
extern int *ChanReorder_AssignLines_7_12;
extern int *ChanReorder_AssignLines_13_16;


#ifdef DTSX_DECODER
extern int *Primary_flag;
extern int *Outputchannel_config_command;
extern int *Parma_done;
extern int *Rendering_done;
extern int *Number_of_Objects;
extern int *Downmix_Normalization;
extern int *Dialog_Interactivity;
extern int DTSXDecoderEnable;
extern int  *Frmwk_nchannels_in_c1_MPCM;
extern int *IMAX_Done;
extern int *Type1cc_State;
extern int *Remapping_done;

extern int *Predac_buffer_Int_Ptr;
extern int input_parameter_buffer[];
extern int OutputParameter[];
extern int DTSX_SamplingFrequencyDecoded;

extern int *Meta_update_C1;
extern int *Dtsx_Core2_init_done;
extern int *Core2_command_parameter4;
extern int *Cmd_processing_dne;
extern int  *p_OutputParam;
extern int *McpcmNeuralX;
extern int *NeuralXSamplFreq;
extern int *Post_decoding_option_command;
extern int numchannels_c1_MCPCM;
extern int BlockZeroStartAddr;
extern int L2_core2StartAddr;
extern int *Stream_sample_rate;
extern int *sampling_frequency;
extern int *Core2_InitConfigStructureDone;
extern int *DtsxCore2StatusValid;
extern int Ext_Buffer_Data_Size;
extern int FFT_DM_start;
extern int FFT_PM_start;
extern int *Ver4_info_c1;
#ifdef TIMERENABLED_KERNAL
extern int Ext_Buffer_Data[EXT_BUFFER_DATA_SIZE];
#endif //TIMERENABLED_KERNAL

#ifdef TRUBASS
extern int DTSX_External_PP_Kernel;
extern int   Perform_Ext_PP;
extern int *TruBass_cmd_parameter1;
extern int *TBassCmd_processing_dne;
extern int *TruBassDone;
#endif //TRUBASS

#ifdef DOWNSAMPLING_DTSX
extern int *DTSX_DS_Enable;
extern int DTSX_DS_C2_var;
extern int count_ds;
#endif //DOWNSAMPLING_DTSX

#endif //DTSX_DECODER
#endif /* EXTERN_CORE2_H_ */
