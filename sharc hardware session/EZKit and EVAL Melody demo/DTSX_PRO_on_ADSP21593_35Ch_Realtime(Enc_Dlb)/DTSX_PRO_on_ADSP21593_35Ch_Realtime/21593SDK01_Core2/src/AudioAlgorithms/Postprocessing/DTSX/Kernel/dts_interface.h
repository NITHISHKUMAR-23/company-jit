/***************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :   DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :   Jasmin Infotech Private Limited,Chennai
*  File Name        :	dts_interface.h
*  Description      :   DTSX Decoder related Input/Output parameter,
*                       Library function prototypes and enum declaration
*  					    can be included here
******************************************************************************/
#ifndef __DTS_INTERFACE_H__
#define __DTS_INTERFACE_H__
#include "..\src\system\Include\Commn.h"

#ifdef DTSX_DECODER
/** \brief Library instance  */
typedef void* dtsLibrary;

/** \brief Input parameter instance  */
typedef void* dtsInputParam;

/** \brief Ouptut parameter instance  */
typedef void* dtsOutputParam;

typedef void* dtsFramePlayer;

typedef struct DTS_COMMAND_BYTE
{
    unsigned int PARAMETER_1;
	unsigned int PARAMETER_2;
	unsigned int PARAMETER_3;
	unsigned int PARAMETER_4;
	unsigned int PARAMETER_5;
	float PARAMETER_6;
	float PARAMETER_7;
	unsigned int PARAMETER_8;
} dts_commmand_byte;

typedef struct dtsDecoderStatus
{
	int	parma_done;
	unsigned int	rendering_done;
	unsigned int	Number_of_objects;
	bool  Dialog_interactivity;
	unsigned int Downmix_Normalization;
	unsigned int IMAX_done;
	int    Type1CC_State_Var;
	unsigned int Tone_Dump_Enable;
	unsigned int Remapping_done;
	bool Speaker_Remapper_Done;
} dtsDecoderStatus;

/** \brief Decoder PCM Output Data structure */
typedef struct dtsxDecoderPCMOutput
{
	int  bitsPerSample[32 + 1]; /**< The bit resolution of the PCM output */
    int  samplingRate[32 + 1];   /**< The sampling rate of the PCM output */
    int  speakerMask;                              /**< The speaker mask for the PCM output, should be a combination of channel masks. Refer #dtsSpeakerMask for channel masks */
    int  numberOfSamples;                          /**< The number of samples in PCM buffers */
    int  *pSamples[32 + 1];  /**< Array of pointers to PCM output. Each PCM value is right justified and sign extended to 32 bits */
                                                         /**< +1 speaker for DTS_SPEAKER_NONE */
    int repTypes;                                 /**< Representation types */
    int silentSpeakerMask;                        /**< The speaker mask for the silent channels in PCM output, where "1" indicates silence. Refer #dtsSpeakerMask for silent channel masks */
} dtsxDecoderPCMOutput;

typedef struct dtsInputParameter
{
	int nPrimaryFlags;
	int InputFrameSize;
	dtsxDecoderPCMOutput Input;
	dtsFramePlayer playerDSPB;
	unsigned int CommandProcessingDone;
	unsigned int InitConfigStructureDone;
	unsigned int InitConfigDone;
	unsigned int *PP_Outputptr;
	unsigned int Realtime_cust_var_kernel;
	unsigned int Ver_No_4;
	unsigned int Ext_Buffer_Data_inp_Size;
	unsigned int Ext_Buffer_Data_inp_ptr;
	unsigned int Output_samplingrate_c1;
	unsigned int DTSX_Downsampling_flag;
	unsigned int DTSX_External_PP_value;
} dtsInputParameter ;

typedef struct dtsOutputParameter
{
	dtsxDecoderPCMOutput Output;
	dtsxDecoderPCMOutput Output51;
	dtsxDecoderPCMOutput Output20;
	dtsDecoderStatus status;
} dtsOutputParameter ;

int DTSDecFilePlayer_SAPI_Create_DSPB_Library(
    dtsLibrary *pLibrary
);

void DTSX_StatusUpdate( dtsFramePlayer theFramePlayer, dtsDecoderStatus *Status );

int DTSX_Decoder( dtsInputParameter *p_InputParam,	dtsOutputParameter *p_OutputParam, volatile int *ip_list, int *pCOMMAND_BYTE );

#endif //DTSX_DECODER
#endif /* #ifndef __DTS_INTERFACE_H__ */
