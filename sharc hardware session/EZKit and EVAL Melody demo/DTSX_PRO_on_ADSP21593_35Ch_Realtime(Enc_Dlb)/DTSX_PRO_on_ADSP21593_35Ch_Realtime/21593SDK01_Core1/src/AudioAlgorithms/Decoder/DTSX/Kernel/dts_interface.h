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

/**
 * Enumerated type for boolean operations.
 */
typedef enum
{
    DTS_SPEAKER_CENTRE       = 0,   /**< Centre */
    DTS_SPEAKER_LEFT         = 1,   /**< Left */
    DTS_SPEAKER_RIGHT        = 2,   /**< Right */
    DTS_SPEAKER_LS           = 3,   /**< Left Surround */
    DTS_SPEAKER_RS           = 4,   /**< Right Surround */
    DTS_SPEAKER_LFE1         = 5,   /**< Low Frequency Effects 1 */
    DTS_SPEAKER_Cs           = 6,   /**< Center Surround */
    DTS_SPEAKER_Lsr          = 7,   /**< Left Surround in Rear */
    DTS_SPEAKER_Rsr          = 8,   /**< Right Surround in Rear */
    DTS_SPEAKER_Lss          = 9,   /**< Left Surround on Side */
    DTS_SPEAKER_Rss          = 10,  /**< Right Surround on Side */
    DTS_SPEAKER_Lc           = 11,  /**< Between Left and Centre in front */
    DTS_SPEAKER_Rc           = 12,  /**< Between Right and Centre in front */
    DTS_SPEAKER_Lh           = 13,  /**< Left Height in front */
    DTS_SPEAKER_Ch           = 14,  /**< Centre Height in Front */
    DTS_SPEAKER_Rh           = 15,  /**< Right Height in front */
    DTS_SPEAKER_LFE2         = 16,  /**< Low Frequency Effects 2 */
    DTS_SPEAKER_Lw           = 17,  /**< Left on side in front */
    DTS_SPEAKER_Rw           = 18,  /**< Right on side in front */
    DTS_SPEAKER_Oh           = 19,  /**< Over the listeners Head */
    DTS_SPEAKER_Lhs          = 20,  /**< Left Height on Side */
    DTS_SPEAKER_Rhs          = 21,  /**< Right Height on Side */
    DTS_SPEAKER_Chr          = 22,  /**< Centre Height in Rear */
    DTS_SPEAKER_Lhr          = 23,  /**< Left Height in Rear */
    DTS_SPEAKER_Rhr          = 24,  /**< Right Height in Rear */
    DTS_SPEAKER_Clf          = 25,  /**< Low Center in Front */
    DTS_SPEAKER_Llf          = 26,  /**< Low Left in Front */
    DTS_SPEAKER_Rlf          = 27,  /**< Low Right in Front */
    DTS_SPEAKER_Ltf          = 28,  /**< Top Left in Front */
    DTS_SPEAKER_Rtf          = 29,  /**< Top Right in Front */
    DTS_SPEAKER_Ltr          = 30,  /**< Top Left in Rear */
    DTS_SPEAKER_Rtr          = 31,  /**< Top Right in Rear */
    DTS_SPEAKER_NONE         = 32,  /**< Dummy used for stereo output with only one channel */
    DTS_SPEAKER_MAX_SPEAKERS = 32   /**< This must always be the last entry on the list */
} dtsDecoderSpeakers;


/** \brief Decoder PCM Output Data structure */
typedef struct dtsxDecoderPCMOutput
{
	int  bitsPerSample[DTS_SPEAKER_MAX_SPEAKERS + 1]; /**< The bit resolution of the PCM output */
    int  samplingRate[DTS_SPEAKER_MAX_SPEAKERS + 1];   /**< The sampling rate of the PCM output */
    int speakerMask;                              /**< The speaker mask for the PCM output, should be a combination of channel masks. Refer #dtsSpeakerMask for channel masks */
    int  numberOfSamples;                          /**< The number of samples in PCM buffers */
    int   *pSamples[DTS_SPEAKER_MAX_SPEAKERS + 1];  /**< Array of pointers to PCM output. Each PCM value is right justified and sign extended to 32 bits */
                                                         /**< +1 speaker for DTS_SPEAKER_NONE */
    int repTypes;                                 /**< Representation types */
    int silentSpeakerMask;                        /**< The speaker mask for the silent channels in PCM output, where "1" indicates silence. Refer #dtsSpeakerMask for silent channel masks */
} dtsxDecoderPCMOutput;


typedef struct dtsInputParameter
{
    unsigned int		*Inputptr;
	unsigned int		*Outputptr;
	unsigned int		nPrimaryFlags;
    unsigned int		InputFrameSize;
	unsigned int		PostProcessPcm;
	dtsxDecoderPCMOutput Input;
	void*				playerDSPA;
	unsigned int		InitDecoder;
	unsigned int		CommandProcessingDone;
	unsigned int		InitConfigStructureDone;
	unsigned int		DoCoreFsizeChangeChecking;
	unsigned int		Frame_Scanner_enable_kernel;
	unsigned int		*buffer_pointer[4];
	unsigned int		nDecMode;
	unsigned int        Realtime_cust_var_kernel;
	unsigned int        DTSX_External_PP_value;
} dtsInputParameter;

typedef struct dtsCOMMAND_BYTE
{
    unsigned int PARAMETER_1;
	unsigned int PARAMETER_2;
	unsigned int PARAMETER_3;   
	unsigned int PARAMETER_4; 

} dtsCOMMAND_BYTE;
/***If you add extra member,add the same member in lib structure also and increase OutputParameter buffer memory size***/
typedef struct dtsDecoderStatus
{
	unsigned int   	Valid;

	unsigned int   	Es_Flag;
	int				DialNorm;

	unsigned int 	DecoderError;
	unsigned int 	ExtensionError;

	unsigned int 	SamplingFrequencyOriginal;
	unsigned int 	SamplingFrequencyDecoded;

	unsigned int 	NumberofChannelsOriginal;

	unsigned int 	ChannelConfigurationOriginal;

	unsigned int 	ReplacementGrp_ChSet[3];

	unsigned int 	StreamType;
	unsigned int 	LtRtStream;
	unsigned int 	HeadPhoneStream;

	unsigned int 	LFE_Presence;
	unsigned int 	LFE_Count;
	unsigned int 	DRC_Presence;
	unsigned int	NeoX_Flag;
	unsigned int    Type1CertifiedContent;
	unsigned int	CoreFsize_T1CC;
	unsigned int    Ambisonic_Stream;

} dtsDecoderStatus;
/***If you add extra member,add the same member in lib structure also and increase OutputParameter buffer memory size***/
typedef struct dtsOutputParameter
{
    dtsxDecoderPCMOutput Output;
	dtsxDecoderPCMOutput Output51;
	dtsxDecoderPCMOutput Output20;
	dtsDecoderStatus	Status;
	unsigned int Metadata_Size;
	unsigned int *Metadata_Ptr;

} dtsOutputParameter ;

int DTSDecFilePlayer_SAPI_Create_DSPA_Library(
	dtsLibrary *pLibrary
);

int DTSX_Decoder( dtsInputParameter *p_InputParam,	dtsOutputParameter *p_OutputParam, unsigned int *pCOMMAND_BYTE );

void DTSX_CommandProcessing( unsigned int *pCOMMAND_BYTE, int *pPlayerConfig );

void DTSX_StatusUpdate(  void*  theFramePlayer, dtsOutputParameter *pOutputParameter );

extern unsigned int  DTSDec_SAPI_GetDecodedSamplingFrequency( dtsOutputParameter *pOutputParameter, unsigned int *SamplingFrequencyDecoded  );

/**************************************************************************************************/
#endif //DTSX_DECODER
#endif //#ifndef __DTS_INTERFACE_H__
