/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Decoder_Core1.h
*  Description      :
******************************************************************************/
#ifndef DECODER_H_
#define DECODER_H_

//#include "Codeid.h"
#include "Commn.h"
#include "Def_struct.h"
#include <platform_include.h>
#include <asm_sprt.h>
#include <stdio.h>
#include "HostDefines.h"
#include <interrupt.h>
#include "Adr_Lkup_Tab_Macros.h"
#include "Extern.h"
#include <math.h>
#include "Codeid.h"
//#include "HostDefines.h"

#include <services/dma/adi_dma.h>

/*==============OPTICAL_MODULE Definition=================================================*/

#ifdef OPTICAL_MODULE
	#include "SPI2_AVR8_def.h"
#endif
int Prev_OutputSampleRate = -1;

/*==============Decoder Definition=================================================*/

#ifdef PCM_DECODER
#define PCM_DEC
#endif

#ifdef MCPCM_DECODER
#define MCPCM_DEC
#endif

/******************************************************************************
 * Version Number Variable Declaration and Initialization Section
 *****************************************************************************/
section("seg_int_str")
int   Ver_No_1=0x17040032;
section("seg_int_str")
int   Ver_No_3=0xAECD0D24;
section("seg_int_str")
int   Ver_No_5=0x501F0049;
section("seg_int_str")
int   Ver_No_7=0x2C200026;

section("seg_ext_str_bw")
int   Ver_No_2=0x19220F3F;
section("seg_ext_str_bw")
int   Ver_No_4=0x00361F0B;
section("seg_ext_str_bw")
int   Ver_No_6=0x004D0041;
section("seg_ext_str_bw")
int   Ver_No_8=0x004D0235;

/**************************************************************************************************
 *				Global Variable Declaration and Initialization Section
 *************************************************************************************************/

int down_samp_flag_cmd=0,down_samp_flag=0;
int cont=0;

int CustomAutoPCMZero;

int LPCM_AL24_Data1;
int buff_cnt;

int Peak_MIPS;
int tx_mips;

int framre_cnt=0;
int PP_process_cnt=0;
static bool bMemCopyInProgress1;

/**************************************************************************************************
 *			Global Functions Prototype Section
 *************************************************************************************************/

int PlayForgnd(void);
void Init_Var(void);
void PackUpdate(void);
void Pre_Dac_Ptr_Update(void);
void AddPredac_Ptr_Update(void);
void MCPCMDecoder(void);

void fixtofloatConversion(void);
void floattofixConversion(void);
void PreDac_Int_To_Cust_PP_Buffer(void);
void Cust_PP_To_PreDac_Int_Buffer(void);
void Predac_Buffer_Int_To_Predac_Buffer_Ext(void);
void Pack_TO_Predac_MCPCM(void);
void Pack_TO_Predac_MCPCM_SPDIF(void);

void Predac_Buffer_Ext_To_Predac_Buffer_Int_DMA(int,int,int);

void CustomerPP_gain_control(int *CustPPInputList);

/**************************************************************************************************
 *			Global Customer_PP Variable Declaration and Extern Section
 *************************************************************************************************/
int CustPP_Cycles;
/**************************************************************************************************
 *				Global Variable Extern Section
 *************************************************************************************************/
extern int mdma3_done;
extern int SrcBuf;
extern int DstBuf;
extern int BufSize;
extern int Predac_buffer_Int[];
extern int prev_channel_count;
extern ADI_DMA_STREAM_HANDLE   hMemDmaStream1;
/*****************************************************************************************************
 * 						PP Information Structure declaration
 *****************************************************************************************************/

typedef enum { NOT_YET_STARTED = 0,
	           IN_PROGRESS     = 1,
	           COMPLETED       = 2
             }Status_INFO;


struct PP_INFO
{
	char Name[120];
	int  Priority;
	int  Cycles;
	Status_INFO status;
}postprocess[]= {
		{ "Customer_PP", 1 , 34500, NOT_YET_STARTED }
                };


#endif /* DECODER_H_ */
