/***************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :   DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :   Jasmin Infotech Private Limited,Chennai
*  File Name        :	DTSX_Kernel.h
*  Description      :   DTSX Decoder related common variable declaration,
*  					 	Function prototype, enum and defines can be included here
******************************************************************************/

#ifndef AUDIOALGORITHMS_DECODER_DTSX_KERNEL_DTSX_KERNEL_H_
#define AUDIOALGORITHMS_DECODER_DTSX_KERNEL_DTSX_KERNEL_H_

#include "dts_interface.h"
#include "..\src\system\Include\Function_Prototype.h"
#include "..\src\system\Include\Def_struct.h"
#include "..\src\system\Include\Codeid.h"
#include "..\src\system\Include\Extern_C.h"
#include "..\src\system\Include\Extern_Core1.h"
#include <stdio.h>

#ifdef DTSX_DECODER
#pragma default_section(ALLDATA,"seg_dtsx_kernal_data")

/**************************************************************************************************
 *					 			DEFINE MACRO for DTSX KERNAL
*************************************************************************************************/
#define DTSX_NUM_OF_PACK_HALF 2
#define DTSX_NUM_OF_PREDAC_HALF 4
#define DTSX_MAX_SAMPLE_BLOCK_MAX 1024
#define DTSX_PREDAC_NUMMAXCHAN 36
#define DTSX_NO_OF_TX_SAMPLE_COUNT 32

#define PREDAC_LENGTH_DTSHD_MAX     DTSX_MAX_SAMPLE_BLOCK_MAX*DTSX_PREDAC_NUMMAXCHAN*DTSX_NUM_OF_PREDAC_HALF

#define DTSX32K			32000
#define DTSX44K1		44100
#define DTSX48K			48000
#define DTSX64K			64000
#define DTSX88K2		88200
#define DTSX96K			96000
#define DTSX176K4 		176400
#define DTSX192K		192000
#define DTSX8K			8000
#define DTSX16K			16000
#define DTSX11K25		11025
#define DTSX22K5		22050
#define DTSX24K			24000
#define DTSX12K			12000

#define ADDPREDAC_LENGTH_DTSX 	 	1700*4
#define DTSX_STREAM_PROFILE 10
#define OUT_PARAM_COPY 68
/**************************************************************************************************
 *			Global variables and Buffer Declaration for DTSX KERNAL
*************************************************************************************************/
unsigned int	InputParameter[121];
unsigned int	OutputParameter[335];
int Pack_buffer_Int[2048*4];
int Predac_int_ptr_dtsx;
int *metadata_wr_ptr_val;
int *MetaBuffer;

/************************ DTSX MIPS CALCULATION ************************/
#ifdef DTSX_MIPS_CALC
section("seg_mips_buff")
int EvryFrameMips[30000];
#endif //DTSX_MIPS_CALC

/************************ DTSX LATENCY CALCULATION ************************/
#ifdef DTSX_LATENCY_CALC
section("seg_dtsx_Latency_data")
int *DTSX_Latency_pack_ptr;
section("seg_dtsx_Latency_data")
int DTSX_Latency_loop_cnt = 100;
section("seg_dtsx_Latency_data")
int DTSX_Latency_temp_ptr;
section("seg_dtsx_Latency_data")
int *DTSX_Latency_predac_wrt_ptr;
section("seg_dtsx_Latency_data")
int DTSX_Latency_stat_var_c1;
extern int DTSX_Latency_unformat_header_chk;
extern int *DTSX_latency_state_frm_c1;
#endif //DTSX_LATENCY_CALC

/**************************************************************************************************
 *			Global Functions Prototype Section for DTSX KERNAL
*************************************************************************************************/
void DTSX_Framework_main(void);
void COPYEXTPACKTO_INTPACK_DTSX(void);
void DTSXDecoder(void);
void MODE_SAVE_DTSX(void);
void MODE_CLR_DTSX(void);
void DTSX_StatusUpdate_Kernel(dtsInputParameter *p_InputParam,	dtsOutputParameter *p_OutputParam);
void Change_Block_copy_for_96and192Khz(int*);
void ConvertBlock2Interleaved_2PredacExt(int*);
void Control_Data_Update_DTSX(void);
void SHIFTPREDACINT_MCPCM(void);
void update_pack_rd_ptr(int);
void PredacPtrUpdate_DTSX(void);
void memcpy(int*, unsigned int*, int);

/***************************************************************************************************/
#endif //DTSX_DECODER

#endif //AUDIOALGORITHMS_DECODER_DTSX_KERNEL_DTSX_KERNEL_H_
