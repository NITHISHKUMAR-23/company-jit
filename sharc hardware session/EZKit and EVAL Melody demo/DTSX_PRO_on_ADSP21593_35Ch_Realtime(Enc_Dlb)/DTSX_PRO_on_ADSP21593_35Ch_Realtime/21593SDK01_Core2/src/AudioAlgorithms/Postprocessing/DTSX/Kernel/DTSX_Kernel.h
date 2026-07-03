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

#include "..\src\system\Include\Function_Prototype.h"

#ifdef DTSX_DECODER
#pragma default_section(ALLDATA,"seg_dtsx_kernal_data")

typedef enum
{
    DTSSPKROUT_MASK_C       = 0x00001,  /**< Centre */
    DTSSPKROUT_MASK_LR      = 0x00002,  /**< Left and Right */
    DTSSPKROUT_MASK_LsRs    = 0x00004,  /**< Left Surround and Right Surround */
    DTSSPKROUT_MASK_LFE1    = 0x00008,  /**< Low Frequency Effects 1 */
    DTSSPKROUT_MASK_Cs      = 0x00010,  /**< Center Surround */
    DTSSPKROUT_MASK_LhRh    = 0x00020,  /**< Left Height and Right Height in front */
    DTSSPKROUT_MASK_LsrRsr  = 0x00040,  /**< Left Surround and Right Surround in Rear */
    DTSSPKROUT_MASK_Ch      = 0x00080,  /**< Centre Height in Front */
    DTSSPKROUT_MASK_Oh      = 0x00100,  /**< Over the listeners Head */
    DTSSPKROUT_MASK_LcRc    = 0x00200,  /**< Between Left and Centre, Right and Center in front */
    DTSSPKROUT_MASK_LwRw    = 0x00400,  /**< Left and Right on side in front */
    DTSSPKROUT_MASK_LssRss  = 0x00800,  /**< Left Surround and Right Surround on Side */
    DTSSPKROUT_MASK_LFE_2   = 0x01000,  /**< Low Frequency Effects 2 */
    DTSSPKROUT_MASK_LhsRhs  = 0x02000,  /**< Left Height and Right Height on Side */
    DTSSPKROUT_MASK_Chr     = 0x04000,  /**< Centre Height in Rear */
    DTSSPKROUT_MASK_LhrRhr  = 0x08000,  /**< Left Height and Right Height in Rear */
    DTSSPKROUT_MASK_Clf     = 0x10000,  /**< Center Low in Front */
    DTSSPKROUT_MASK_LlfRlf  = 0x20000,  /**< Low Left and Low Right in Front */
    DTSSPKROUT_MASK_LtfRtf  = 0x40000,  /**< Top Left and Top Right in Front */
    DTSSPKROUT_MASK_LtrRtr  = 0x80000,  /**< Top Left and Top Right in Rear */
    DTSSPKROUT_MASK_LtRt    = 0x100000  /**< Lt/Rt */
} dtsSpkrOutMask;

typedef enum
{
	DTSSPKROUT_MASK_LR_pp       = 0x00001,
    DTSSPKROUT_MASK_C_pp      	= 0x00002,
    DTSSPKROUT_MASK_LFE1_pp    	= 0x00004,
    DTSSPKROUT_MASK_LssRss_pp   = 0x00008,
    DTSSPKROUT_MASK_LsrRsr_pp   = 0x00010,
    DTSSPKROUT_MASK_LwRw_pp    	= 0x00020,
    DTSSPKROUT_MASK_LtfRtf_pp  	= 0x00040,
    DTSSPKROUT_MASK_LhsRhs_pp   = 0x00080,
    DTSSPKROUT_MASK_LtrRtr_pp   = 0x00100,
    DTSSPKROUT_MASK_LhRh_pp   	= 0x00200,
    DTSSPKROUT_MASK_LhrRhr_pp   = 0x00400,
    DTSSPKROUT_MASK_LcRc_pp  	= 0x00800,
    DTSSPKROUT_MASK_LlfRlf_pp   = 0x01000,
    DTSSPKROUT_MASK_LsRs_pp  	= 0x02000,
    DTSSPKROUT_MASK_Ch_pp     	= 0x04000,
    DTSSPKROUT_MASK_Chr_pp  	= 0x08000,
    DTSSPKROUT_MASK_Oh_pp     	= 0x10000,
    DTSSPKROUT_MASK_Clf_pp  	= 0x20000,
    DTSSPKROUT_MASK_LFE_2_pp  	= 0x40000,
    DTSSPKROUT_MASK_Cs_pp  		= 0x80000,
    DTSSPKROUT_MASK_LtRt_pp    	= 0x100000
} dtsSpkrOutMask_pp;

typedef enum
{
DTS_MASK_SPEAKER_CENTRE = 0x00000001, /**< Centre */
DTS_MASK_SPEAKER_LEFT   = 0x00000002, /**< Left */
DTS_MASK_SPEAKER_RIGHT  = 0x00000004, /**< Right */
DTS_MASK_SPEAKER_LS     = 0x00000008, /**< Left Surround */
DTS_MASK_SPEAKER_RS     = 0x00000010, /**< Right Surround */
DTS_MASK_SPEAKER_LFE1   = 0x00000020, /**< Low Frequency Effects 1 */
DTS_MASK_SPEAKER_Cs     = 0x00000040, /**< Center Surround */
DTS_MASK_SPEAKER_Lsr    = 0x00000080, /**< Left Surround in Rear */
DTS_MASK_SPEAKER_Rsr    = 0x00000100, /**< Right Surround in Rear */
DTS_MASK_SPEAKER_Lss    = 0x00000200, /**< Left Surround on Side */
DTS_MASK_SPEAKER_Rss    = 0x00000400, /**< Right Surround on Side */
DTS_MASK_SPEAKER_Lc     = 0x00000800, /**< Between Left and Centre in front */
DTS_MASK_SPEAKER_Rc     = 0x00001000, /**< Between Right and Centre in front */
DTS_MASK_SPEAKER_Lh     = 0x00002000, /**< Left Height in front */
DTS_MASK_SPEAKER_Ch     = 0x00004000, /**< Centre Height in Front */
DTS_MASK_SPEAKER_Rh     = 0x00008000, /**< Right Height in front */
DTS_MASK_SPEAKER_LFE2   = 0x00010000, /**< Low Frequency Effects 2 */
DTS_MASK_SPEAKER_Lw     = 0x00020000, /**< Left on side in front */
DTS_MASK_SPEAKER_Rw     = 0x00040000, /**< Right on side in front */
DTS_MASK_SPEAKER_Oh     = 0x00080000, /**< Over the listeners Head */
DTS_MASK_SPEAKER_Lhs    = 0x00100000, /**< Left Height on Side */
DTS_MASK_SPEAKER_Rhs    = 0x00200000, /**< Right Height on Side */
DTS_MASK_SPEAKER_Chr    = 0x00400000, /**< Centre Height in Rear */
DTS_MASK_SPEAKER_Lhr    = 0x00800000, /**< Left Height in Rear */
DTS_MASK_SPEAKER_Rhr    = 0x01000000, /**< Right Height in Rear */
DTS_MASK_SPEAKER_Clf    = 0x02000000, /**< Low Center in Front */
DTS_MASK_SPEAKER_Llf    = 0x04000000, /**< Low Left in Front */
DTS_MASK_SPEAKER_Rlf    = 0x08000000, /**< Low Right in Front */
DTS_MASK_SPEAKER_Ltf    = 0x10000000, /**< Top Left in Front */
DTS_MASK_SPEAKER_Rtf    = 0x20000000, /**< Top Right in Front */
DTS_MASK_SPEAKER_Ltr    = 0x40000000, /**< Top Left in Rear */
DTS_MASK_SPEAKER_Rtr    = 0x80000000U /**< Top Right in Rear */
} dtsSpeakerMask;

typedef enum
{
    DTS_MASK_REPTYPE_Lt     = 0x10000000,
    DTS_MASK_REPTYPE_Rt     = 0x20000000,
} DTS_MASK_REPTYPE;

typedef enum
{
CONV_DTSSPKROUT_MASK_C      = DTS_MASK_SPEAKER_CENTRE,
CONV_DTSSPKROUT_MASK_LR     = DTS_MASK_SPEAKER_LEFT | DTS_MASK_SPEAKER_RIGHT,
CONV_DTSSPKROUT_MASK_LsRs   = DTS_MASK_SPEAKER_LS | DTS_MASK_SPEAKER_RS,
CONV_DTSSPKROUT_MASK_LFE1   = DTS_MASK_SPEAKER_LFE1,
CONV_DTSSPKROUT_MASK_Cs     = DTS_MASK_SPEAKER_Cs,
CONV_DTSSPKROUT_MASK_LhRh   = DTS_MASK_SPEAKER_Lh | DTS_MASK_SPEAKER_Rh,
CONV_DTSSPKROUT_MASK_LsrRsr = DTS_MASK_SPEAKER_Lsr | DTS_MASK_SPEAKER_Rsr,
CONV_DTSSPKROUT_MASK_Ch     = DTS_MASK_SPEAKER_Ch,
CONV_DTSSPKROUT_MASK_Oh     = DTS_MASK_SPEAKER_Oh,
CONV_DTSSPKROUT_MASK_LcRc   = DTS_MASK_SPEAKER_Lc | DTS_MASK_SPEAKER_Rc,
CONV_DTSSPKROUT_MASK_LwRw   = DTS_MASK_SPEAKER_Lw | DTS_MASK_SPEAKER_Rw,
CONV_DTSSPKROUT_MASK_LssRss = DTS_MASK_SPEAKER_Lss | DTS_MASK_SPEAKER_Rss,
CONV_DTSSPKROUT_MASK_LFE_2  = DTS_MASK_SPEAKER_LFE2,
CONV_DTSSPKROUT_MASK_LhsRhs = DTS_MASK_SPEAKER_Lhs | DTS_MASK_SPEAKER_Rhs,
CONV_DTSSPKROUT_MASK_Chr    = DTS_MASK_SPEAKER_Chr,
CONV_DTSSPKROUT_MASK_LhrRhr = DTS_MASK_SPEAKER_Lhr | DTS_MASK_SPEAKER_Rhr,
CONV_DTSSPKROUT_MASK_Clf    = DTS_MASK_SPEAKER_Clf,
CONV_DTSSPKROUT_MASK_LlfRlf = DTS_MASK_SPEAKER_Llf | DTS_MASK_SPEAKER_Rlf,
CONV_DTSSPKROUT_MASK_LtfRtf = DTS_MASK_SPEAKER_Ltf | DTS_MASK_SPEAKER_Rtf,
CONV_DTSSPKROUT_MASK_LtrRtr = DTS_MASK_SPEAKER_Ltr | DTS_MASK_SPEAKER_Rtr,
CONV_DTSSPKROUT_MASK_LtRt   = DTS_MASK_REPTYPE_Lt | DTS_MASK_REPTYPE_Rt
} CONVERTED_DTSSPKROUT_MASK;

section("seg_dtsx_kernal_data") int dtsDecoderInput[100];   //To store the Control data from shared memory
section("seg_dtsx_kernal_data") int InputParameter[120];    //To allocate memory to Input parameter of decoder
section("seg_dtsx_kernal_data") int OutputParameter[322];   //To store status,version info of DSP2

#define METADATASIZE_INT			4096

int Add_Meta_Data_buffer[METADATASIZE_INT];
int Temp_Meta_Data_buffer[DTSXMETADATASIZE];

int Pack_buffer_Int[8192];
int MODE1_save=0;
int Predac_Zero_Flag=0;
int numchannels_c1_MCPCM=0;
int metadata_cpy_variable;
int MetaPtrUpdate_Var;
int Ext_Buffer_Data_Size;
unsigned int DTSX_DecoderMask;
unsigned int DTSX_DecoderMask_pp;
int *Predac_buffer_Int_Ptr;
unsigned int Stream_inp_spkmask = 0;
int DTS_Lsrs_Swap = 0;

int Freq_TableDtsx[12]={ 32000,
					 44100,
					 48000,
					 48000,
					 64000,
					 88200,
					 96000,
					 96000,
					 128000,
					 176400,
					 192000,
					 192000};

int FFTBlockZeroDmAddr;
int FFTBlocktwoPmAddr;

#ifdef DTSX_MIPS_CALC
section("seg_mips_buff")
int EvryFrameMips[30000];
#endif

int Chanreorder_cmd_1_6;
int Chanreorder_cmd_7_12;
int Chanreorder_cmd_13_16;

void DTSX_Param_Init(dtsInputParameter *p_In, dtsOutputParameter *p_Out);
void memcpy(dtsxDecoderPCMOutput*, int*, int);

int skip_frame = 0;
#endif //DTSX_DECODER
#endif //AUDIOALGORITHMS_DECODER_DTSX_KERNEL_DTSX_KERNEL_H_
