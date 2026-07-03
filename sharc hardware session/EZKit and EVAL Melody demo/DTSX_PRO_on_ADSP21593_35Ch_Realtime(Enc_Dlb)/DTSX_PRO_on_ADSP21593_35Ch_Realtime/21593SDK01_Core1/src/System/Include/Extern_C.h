/***************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :  	DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Extern_C.h
*  Description      :   Extern framework & ISR variables for C environment can be included here
*
******************************************************************************/
#include "Commn.h"
#ifndef EXTERN_C_H
#define EXTERN_C_H

/*****************************************************************************
	Framework Variables
*****************************************************************************/
#ifdef DTSX_DECODER
extern int *SampleBlock_Core2;
extern int *Core2_InitConfigStructureDone;
extern int Int_Block0_start_addr;
extern int L2_Core1data_start_addr;
extern int *Stream_Profile;
extern int *Dtsx_Core2_init_done;
extern int *sampling_frequency;
extern int Frmwk_DtsxCore2StatusValid;
extern int output_parameter_buffer[];
extern int *Stream_sample_rate;
extern int *core2_sync_bit;
extern int *Primary_flag;
extern int *Meta_update_C1;
extern int *Core2_command_parameter4;
extern int *Cmd_processing_dne;
extern int *Outputchannel_config_command;
extern int *predac_wr_ptr_c1;
extern int *predac_rd_ptr_c1;
extern int *Predac_length_half;
extern int *addpredac_lengthhalf;
extern int *Post_decoding_option_command;
extern int *Ver4_info_c1;
extern int DTSX_External_PP_Kernel;
#ifdef TRUBASS
extern int *TruBass_cmd_parameter1;
extern int *TBassCmd_processing_dne;
extern int *TruBassDone;
#endif//TRUBASS
#ifdef DOWNSAMPLING_DTSX
extern int *DTSX_DS_Enable;
#endif //DOWNSAMPLING_DTSX
#ifdef DTSX_MIPS_CALC
extern int EvryFrameMips[30000];
#endif //DTSX_MIPS_CALC

#endif//DTSX_DECODER

#endif  /*	EXTERN_C_H  */
