/********************************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :  	DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	dts_extpp_interface.h
*  Description      :   Trubass Structure, function prototypes are included here
*
********************************************************************************************/
//dtsResult DTSPerformExtPostProcess(DTSExtPostProcessObj theInstance, dtsInt32 **ppDataInOut, dtsUint32 nInputChMask, dtsInt32 nSamplingRate, dtsInt32 nNumSamples, void *pWorkspace);
typedef struct _dtsExtPostProcessObj *DTSExtPostProcessObj;

typedef struct InputParameterStruc_ExtPP{

	DTSExtPostProcessObj *dtsPostProcessObj;
	int *ppMappedChannels[32];
	int speakerMask;
	int samplingRate;
	int numberOfSamples;
	float *pWorkspace;
	int *ExtPPBuf;
	int ExtPPInitDone;
	int Ex_PP_CommandProcessingDone;
	int ExtPP_Status;
}InputParameterStruc_ExtPP;
int DTSPerformExtPostProcess_Kernel(InputParameterStruc_ExtPP *p_ExtPP_InputParam,int *pCOMMAND_BYTE);
void DTSX_EX_PP_CommandProcessing( int *pCOMMAND_BYTE, DTSExtPostProcessObj p_dtsPostProcessObj );
