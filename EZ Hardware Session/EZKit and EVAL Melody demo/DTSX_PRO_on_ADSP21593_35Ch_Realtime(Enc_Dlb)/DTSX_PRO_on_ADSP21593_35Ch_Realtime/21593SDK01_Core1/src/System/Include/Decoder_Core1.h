/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Decoder_Core1.h
*  Description      :   Shared Memory ,Global variables Declaration and Initialization
******************************************************************************/
#ifndef DECODER_CORE1_H_
#define DECODER_CORE1_H_

#include "Commn.h"
#include <platform_include.h>
#include <stdio.h>
#include "HostDefines.h"
#include <interrupt.h>
#include "Extern_Core1.h"
#include <math.h>
#include "Codeid.h"
#include "Def_Struct.h"

/*==============OPTICAL_MODULE Definition=================================================*/

int Prev_OutputSampleRate = -1;

#ifdef PCM_DECODER
section("seg_kernal_pcm_data")
int LPCMDelayBuffer[18434];//[16384]; //Lpcm delay for 96k and 192k(16384+(256*2*4))
#endif //PCM_DECODER

/**************************************************************************************************
 *				Global Variable Declaration and Initialization Section
 *************************************************************************************************/
int down_samp_flag=0;
int buff_cnt;
int framre_cnt=0;
int Source_Buf;
int Destination_Buf;

/*****************************************************************************************************
 * 						Shared Memory Between Core1 & Core2
 *****************************************************************************************************/
/*Dont Use this section for any other Buffers.It is for shared memory*/
section("Seg_Shared_Mem")
int   Shared_mem_reserved[500];

/*Kernal Data share variable from 0 to 50*/
int *sampling_frequency		 				=&Shared_mem_reserved[0];
int *Auto_detection_mode	 				=&Shared_mem_reserved[1];
int *Next_dac_count          				=&Shared_mem_reserved[2];
int *NextDataValid_ptr		 				=&Shared_mem_reserved[3];
int *core2_sync_bit			 				=&Shared_mem_reserved[4];
int *stream_type			 				=&Shared_mem_reserved[5];
int *datacanbeprocessnow 				 	=&Shared_mem_reserved[7];
int *core2_dcpn_done						=&Shared_mem_reserved[8];
int *Frmwk_SampleBlock_c1			     	=&Shared_mem_reserved[9];
int *Frmwk_Outputsamplerate_c1				=&Shared_mem_reserved[10];
int *Frmwk_nchannels_in_c1					=&Shared_mem_reserved[11];
int *Init_Start_Command_c1					=&Shared_mem_reserved[12];
int *Frmwk_nchannels_in_c1_MPCM				=&Shared_mem_reserved[13];
int *Stream_Profile							=&Shared_mem_reserved[14];
int *SampleBlock_Core2						=&Shared_mem_reserved[15];
int *run_flag                               =&Shared_mem_reserved[16];
int *testing_36_ch							=&Shared_mem_reserved[17];
#ifdef VALIDATION_36CH
	int *Ch36_Enable						=&Shared_mem_reserved[18];
#endif
#ifdef OPTICAL_TESTING
	int *optical_test						=&Shared_mem_reserved[19];
#endif
int *ChanReorder_AssignLines_1_6            =&Shared_mem_reserved[20];
int *ChanReorder_AssignLines_7_12           =&Shared_mem_reserved[21];
int *ChanReorder_AssignLines_13_16          =&Shared_mem_reserved[22];
/*Predac(51 to 75)  details share variable from 51 to 75 */
int *predac_heap			 				=&Shared_mem_reserved[51];
int *Predac_length           				=&Shared_mem_reserved[52];
int *Predac_length_half      				=&Shared_mem_reserved[53];
int *Latency_predac_wr_ptr_c1				=&Shared_mem_reserved[54];
int *predac_wr_ptr_c1		 				=&Shared_mem_reserved[55];
int *predac_wr_ptr           				=&Shared_mem_reserved[56];
int *predac_wr_ptr_c2		 				=&Shared_mem_reserved[57];
int *predac_rd_ptr_c1                       =&Shared_mem_reserved[58];

/*Addpredac(76 to 100) details share variable from 76 to 100*/
int *addpredac_heap			 				=&Shared_mem_reserved[76];
int *addpredac_length			 			=&Shared_mem_reserved[77];
int *addpredac_lengthhalf    				=&Shared_mem_reserved[78];
int *addpredac_wr_ptr		 				=&Shared_mem_reserved[79];
int *addpredac_rd_ptr		 				=&Shared_mem_reserved[80];

/****Core2 Post processing variable will use from 101 to 125****/
int *core2_command_processing_status_done 	 =&Shared_mem_reserved[101];
int *Decoder_Speaker_config                  =&Shared_mem_reserved[102];

/****CommandProcessing variable will use from 126 to 159****/
int *COMMAND_BYTE_C2						=&Shared_mem_reserved[126];
int *PARAMETER_1_C2 						=&Shared_mem_reserved[127];
int *PARAMETER_2_C2 						=&Shared_mem_reserved[128];
int *PARAMETER_3_C2 						=&Shared_mem_reserved[129];
int *PARAMETER_4_C2							=&Shared_mem_reserved[130];
int *PARAMETER_5_C2 						=&Shared_mem_reserved[131];
int *PARAMETER_6_C2 						=&Shared_mem_reserved[132];
int *PARAMETER_7_C2 						=&Shared_mem_reserved[133];
int *PARAMETER_8_C2							=&Shared_mem_reserved[134];
int *PARAMETER_9_C2 						=&Shared_mem_reserved[135];
int *PARAMETER_10_C2 						=&Shared_mem_reserved[136];
int *PARAMETER_11_C2 						=&Shared_mem_reserved[137];
int *PARAMETER_12_C2						=&Shared_mem_reserved[138];
int *PARAMETER_13_C2 						=&Shared_mem_reserved[139];
int *PARAMETER_14_C2 						=&Shared_mem_reserved[140];
int *PARAMETER_15_C2 						=&Shared_mem_reserved[141];
int *PARAMETER_16_C2						=&Shared_mem_reserved[142];
int *PARAMETER_17_C2 						=&Shared_mem_reserved[143];
int *PARAMETER_18_C2 						=&Shared_mem_reserved[144];
int *PARAMETER_19_C2 						=&Shared_mem_reserved[145];
int *PARAMETER_20_C2						=&Shared_mem_reserved[146];
int *PARAMETER_21_C2 						=&Shared_mem_reserved[147];
int *PARAMETER_22_C2 						=&Shared_mem_reserved[148];
int *PARAMETER_23_C2 						=&Shared_mem_reserved[149];
int *PARAMETER_24_C2						=&Shared_mem_reserved[150];
int *PARAMETER_25_C2 						=&Shared_mem_reserved[151];
int *PARAMETER_26_C2 						=&Shared_mem_reserved[152];
int *PARAMETER_27_C2 						=&Shared_mem_reserved[153];
int *PARAMETER_28_C2						=&Shared_mem_reserved[154];
int *PARAMETER_29_C2 						=&Shared_mem_reserved[155];
int *PARAMETER_30_C2 						=&Shared_mem_reserved[156];
int *PARAMETER_31_C2 						=&Shared_mem_reserved[157];
#ifdef DTSX_LATENCY_CALC
section("seg_dtsx_Latency_data")
int *DTSX_latency_state_frm_c1              =&Shared_mem_reserved[158];
section("seg_dtsx_Latency_data")
int *DTSX_latency_state_frm_c2              =&Shared_mem_reserved[159];
#endif//DTSX_LATENCY_CALC
/****Resevered for the Customer will use from 160 to 250****/

/**************************************************************************************************
 *				Downsampling Global Variable Declaration and Initialization Section
 *************************************************************************************************/
#ifdef DOWNSAMPLING
section("seg_DownSampling_kernal_data")
int Predac_int[256*2];
section("seg_DownSampling_kernal_data")
float LR_int[1024*2];
section("seg_DownSampling_kernal_data")
float C_SW_int[1024*2];
section("seg_DownSampling_kernal_data")
float LS_RS_int[1024*2];
section("seg_DownSampling_kernal_data")
float LSR_RSR_int[1024*2];

section("seg_DownSampling_kernal_data")
float LR_out[256*2];
section("seg_DownSampling_kernal_data")
float C_SW_out[256*2];
section("seg_DownSampling_kernal_data")
float LS_RS_out[256*2];
section("seg_DownSampling_kernal_data")
float LSR_RSR_out[256*2];

section("seg_DownSampling_kernal_data")
int DnSamp192to48;
section("seg_DownSampling_kernal_data")
int down_samp_flag_cmd=0;
section("seg_DownSampling_kernal_data")
int dn_blkcnt_temp;
section("seg_DownSampling_kernal_data")
int leftinput_delays_heap;
section("seg_DownSampling_kernal_data")
int leftinput_delays_ptr;
section("seg_DownSampling_kernal_data")
int Ls_input_delays_heap;
section("seg_DownSampling_kernal_data")
int Ls_input_delays_ptr;
section("seg_DownSampling_kernal_data")
int Lsr_input_delays_heap;
section("seg_DownSampling_kernal_data")
int Lsr_input_delays_ptr;
section("seg_DownSampling_kernal_data")
int centerinput_delays_heap;
section("seg_DownSampling_kernal_data")
int centerinput_delays_ptr;
section("seg_DownSampling_kernal_data")
int lp_cfs_heap_ptr;
section("seg_DownSampling_kernal_data")
int rightinput_delays_heap;
section("seg_DownSampling_kernal_data")
int lfeinput_delays_heap;
section("seg_DownSampling_kernal_data")
int Rs_input_delays_heap;
section("seg_DownSampling_kernal_data")
int Rsr_input_delays_heap;
#endif //DOWNSAMPLING

static bool bMemCopyInProgress1;

#ifdef DTSX_DECODER
/**************************************************************************************************
 *				                  DTSX Shared Global buffers
 *************************************************************************************************/
/*************************************DONT CHANGE THE ORDER **************************************/

section("seg_DTSX_Ctrl_data")
int output_parameter_buffer[69];

section("seg_DTSX_Ctrl_data")
int Dtsx_Shard_ControlData_buffer[16];

section("seg_DTSX_DSP2_status")
int Dtsx_Shard_StatusData_buffer[10];

section("seg_DTSX_Ctrl_data")
int DTSX_External_PP_Kernel;

section("seg_DTSX_Ctrl_data")
int Perform_Ext_PP;

/**************************************************************************************************
 *				DTSX Global buffers and Variable Declaration and Initialization Section
 *************************************************************************************************/
section("seg_dtsx_kernal_data")
int Frmwk_DtsxCore2StatusValid = 0;

//Dtsx_Shard_ControlData_buffer
section("seg_dtsx_kernal_data")
int *Primary_flag = &Dtsx_Shard_ControlData_buffer[0];
section("seg_dtsx_kernal_data")
int *Outputchannel_config_command = &Dtsx_Shard_ControlData_buffer[1];
section("seg_dtsx_kernal_data")
int *Post_decoding_option_command = &Dtsx_Shard_ControlData_buffer[2];
section("seg_dtsx_kernal_data")
int *Meta_update_C1 = &Dtsx_Shard_ControlData_buffer[3];
section("seg_dtsx_kernal_data")
int *Dtsx_Core2_init_done = &Dtsx_Shard_ControlData_buffer[4];
section("seg_dtsx_kernal_data")
int *Core2_command_parameter4 = &Dtsx_Shard_ControlData_buffer[5];
section("seg_dtsx_kernal_data")
int *Cmd_processing_dne = &Dtsx_Shard_ControlData_buffer[6];
section("seg_dtsx_kernal_data")
int *Ver4_info_c1 = &Dtsx_Shard_ControlData_buffer[7];
section("seg_dtsx_kernal_data")
int *McpcmNeuralX = &Dtsx_Shard_ControlData_buffer[8];
section("seg_dtsx_kernal_data")
int *NeuralXSamplFreq = &Dtsx_Shard_ControlData_buffer[9];
section("seg_dtsx_kernal_data")
int *Stream_sample_rate = &Dtsx_Shard_ControlData_buffer[10];
section("seg_dtsx_kernal_data")
int *Core2_InitConfigStructureDone = &Dtsx_Shard_ControlData_buffer[11];
section("seg_dtsx_kernal_data")
int *DtsxCore2StatusValid = &Dtsx_Shard_ControlData_buffer[12];
#ifdef TRUBASS
section("seg_trubass_kernal_data")
int *TruBass_cmd_parameter1 =  &Dtsx_Shard_ControlData_buffer[13];
section("seg_trubass_kernal_data")
int *TBassCmd_processing_dne = &Dtsx_Shard_ControlData_buffer[14];
#endif//TRUBASS
#ifdef DOWNSAMPLING_DTSX
int *DTSX_DS_Enable = &Dtsx_Shard_ControlData_buffer[15];
#endif //DOWNSAMPLING_DTSX

//Dtsx_Shard_StatusData_buffer
section("seg_dtsx_kernal_data")
int *Parma_done = &Dtsx_Shard_StatusData_buffer[0];
section("seg_dtsx_kernal_data")
int *Rendering_done = &Dtsx_Shard_StatusData_buffer[1];
section("seg_dtsx_kernal_data")
int *Number_of_Objects = &Dtsx_Shard_StatusData_buffer[2];
section("seg_dtsx_kernal_data")
int *Downmix_Normalization = &Dtsx_Shard_StatusData_buffer[3];
section("seg_dtsx_kernal_data")
int *Dialog_Interactivity = &Dtsx_Shard_StatusData_buffer[4];
section("seg_dtsx_kernal_data")
int *IMAX_Done = &Dtsx_Shard_StatusData_buffer[5];
section("seg_dtsx_kernal_data")
int *Type1cc_State = &Dtsx_Shard_StatusData_buffer[6];
#ifdef TRUBASS
section("seg_trubass_kernal_data")
int *TruBassDone = &Dtsx_Shard_StatusData_buffer[7];
#endif//TRUBASS
section("seg_dtsx_kernal_data")
int *Remapping_done = &Dtsx_Shard_StatusData_buffer[8];
#endif // DTSX_DECODER


#endif /* DECODER_CORE1_H_ */
