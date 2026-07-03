/**********************************************************************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :  	DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	TruBass_Kernel.c
*  Description      :   TruBass postprocessing, Input parameter initialization and command Extraction routines are included here
*
************************************************************************************************************************************/
#include "..\src\system\Include\Commn.h"
#include "..\src\system\Include\Def_struct.h"
#include "..\src\system\Include\Extern_Core2.h"
#include "..\src\System\Include\Function_Prototype.h"
#include "..\src\AudioAlgorithms\Postprocessing\DTSX\Kernel\dts_interface.h"
#include "dts_extpp_interface.h"

#ifdef TRUBASS
void TruBassParamInit(InputParameterStruc_ExtPP *,dtsOutputParameter *,dts_commmand_byte *);
#pragma default_section(SWITCH,"seg_trubass_kernal_data")

/***********************************************************************************************************
*  Module Name        : TruBass_Process
*  Functionality      : Trubass Command extraction, parameter initialization, Trubass Process are done here
*                       In addition to Fix to float and float to fix conversion for trubass will be done here.
*  Input Parameters	  : None
*  Output Parameters  : None
************************************************************************************************************/
section("seg_trubass_kernal_code")
void TruBass_Process(void)
{
	dts_commmand_byte *pCOMMAND_BYTE;
	dtsInputParameter *p_InputParam;
	dtsOutputParameter *p_OutputParam;
	int TBass_Ip_Freq = 0,ExtPp_rc=0;
	int Type1State = 0;
	int shiftsamplescount_Trubass = 0;
	p_OutputParam = ( dtsOutputParameter * )OutputParameter;
	InputParameterStruc_ExtPP *InputParameter_ExtPP = (InputParameterStruc_ExtPP *)Frmwk.DTSX.InputParameter_ExtPPBuf;
	pCOMMAND_BYTE = (dts_commmand_byte *)Frmwk.DTSX.TBasscommand_byte_buf;

	if((Perform_Ext_PP && DTSX_External_PP_Kernel) == 0)
	{
		return;
	}

	TBass_Ip_Freq =  p_OutputParam->Output.samplingRate[0];
	if(TBass_Ip_Freq == 0)
		TBass_Ip_Freq = p_OutputParam->Output.samplingRate[1];

	Type1State = p_OutputParam->status.Type1CC_State_Var; //This flag is updated from DTSX Decoder

	if((Type1State==0) && (TBass_Ip_Freq>48000))
	{
		return;
	}

	MODE_SAVE_DTSX();

	if((Frmwk.DTSX.TBHDX_CommandProcessingDone == 0)||(Frmwk.DTSX.TruBass_init_done == 0))
	{
		TruBassCommandExtraction();                //User command extraction for library
	}

	if((Frmwk.DTSX.TruBass_Enable == 1) && ( TBass_Ip_Freq <= 48000 ) && (Type1State == 1))
	{
		TruBassParamInit(InputParameter_ExtPP, p_OutputParam, pCOMMAND_BYTE);                        //Input Parameter Structure update
		shiftsamplescount_Trubass = DTSX_NUM_OUT_CHANNELS * Frmwk.SampleBlock;
		FixToFloatTruBass(shiftsamplescount_Trubass);
#ifdef DTSX_MIPS_CALC
	STIMER_DTSX();
#endif

#ifdef DTSX_LIB
	ExtPp_rc = DTSPerformExtPostProcess_Kernel(InputParameter_ExtPP, (int*)pCOMMAND_BYTE);              //TruBass library call
#endif

#ifdef DTSX_MIPS_CALC
	Frmwk.DTSX.cycles = ETIMER_DTSX();
	DtsxCalculateMIPS();
#endif

	FloatToFixTruBass(shiftsamplescount_Trubass);

	Frmwk.DTSX.TruBass_init_done = InputParameter_ExtPP->ExtPPInitDone;
	Frmwk.DTSX.TBHDX_CommandProcessingDone = InputParameter_ExtPP->Ex_PP_CommandProcessingDone;
	*TruBassDone = 	Frmwk.DTSX.Status.TruBassDone = InputParameter_ExtPP->ExtPP_Status;
	}

	MODE_CLR_DTSX();

}
/**********************************************************************************************************
*  Module Name        : TruBassParamInit
*  Functionality      : Trubass Input parameter initialization are done here
*  Input Parameters	  : Trubass Input Parameter, output parameter and command byte
*  Output Parameters  : None
***********************************************************************************************************/
section("seg_trubass_kernal_code")
void TruBassParamInit(InputParameterStruc_ExtPP *p_InputParameter_ExtPP, dtsOutputParameter *p_OutputParam, dts_commmand_byte *p_pCOMMAND_BYTE)
{
	int *DTSX_OpBuf_ptr_t,idx;

	p_InputParameter_ExtPP->ExtPPInitDone = Frmwk.DTSX.TruBass_init_done;
	p_InputParameter_ExtPP->Ex_PP_CommandProcessingDone = Frmwk.DTSX.TBHDX_CommandProcessingDone;

	if(Frmwk.DTSX.TruBass_init_done == 0)                           //TruBass_init_done = 0 ,when core1 init set
    {
		p_InputParameter_ExtPP->Ex_PP_CommandProcessingDone = 0;
    }

	p_pCOMMAND_BYTE->PARAMETER_5 = (Frmwk.DTSX.TruBass_Enable << 8) | (Frmwk.DTSX.TruBass_ChEnable) | (Frmwk.DTSX.TruBass_SpkrSize << 4);
	p_pCOMMAND_BYTE->PARAMETER_6 = Frmwk.DTSX.TruBass_BassLvl;
	p_pCOMMAND_BYTE->PARAMETER_7 = Frmwk.DTSX.TruBass_Dynamics;
	p_pCOMMAND_BYTE->PARAMETER_8 = Frmwk.DTSX.TruBass_SmallSpkrMask;

	p_InputParameter_ExtPP->speakerMask = p_OutputParam->Output.speakerMask;
	p_InputParameter_ExtPP->samplingRate = p_OutputParam->Output.samplingRate[0];
	p_InputParameter_ExtPP->numberOfSamples = p_OutputParam->Output.numberOfSamples;

	DTSX_OpBuf_ptr_t = Predac_buffer_Int_Ptr;
	for( idx = 0; idx < DTSX_NUM_OUT_CHANNELS; idx++ )
	{
		p_InputParameter_ExtPP->ppMappedChannels[idx] = DTSX_OpBuf_ptr_t;
		DTSX_OpBuf_ptr_t += 256;
	}
}
/************************************************************************************************
*  Module Name        : TruBassCommandExtraction
*  Functionality      : Trubass Input Command extraction are done here
*  Input Parameters	  : None
*  Output Parameters  : None
*************************************************************************************************/
section("seg_trubass_kernal_code")
void TruBassCommandExtraction(void)
{
	int ParamVal;
	Frmwk.DTSX.TruBass_Commands[0] = *TruBass_cmd_parameter1;
	ParamVal = (( Frmwk.DTSX.TruBass_Commands[0] >> 13) & 0x3 );

	/*********TruBass Enable**********/
	Frmwk.DTSX.TruBass_Enable = 0;
	if (ParamVal == 0)
	{
		return;
	}
	if (ParamVal == 3)
	{
		Frmwk.DTSX.TruBass_Enable = 1;
	}

	/*****************TruBass Dynamics****************/
	ParamVal = (Frmwk.DTSX.TruBass_Commands[0]>>5) & 0xf;
	switch(ParamVal)
	{
		case 0:
			Frmwk.DTSX.TruBass_Dynamics = 0.001;
		   break;
		case 1:
			Frmwk.DTSX.TruBass_Dynamics = 0.1;
		   break;
		case 2:
			Frmwk.DTSX.TruBass_Dynamics = 0.2;
			break;
		case 3:
			Frmwk.DTSX.TruBass_Dynamics = 0.3;
			break;
		case 4:
			Frmwk.DTSX.TruBass_Dynamics = 0.4;
			break;
		case 5:
			Frmwk.DTSX.TruBass_Dynamics = 0.5;
			break;
		case 6:
			Frmwk.DTSX.TruBass_Dynamics = 0.6;
			break;
		case 7:
			Frmwk.DTSX.TruBass_Dynamics = 0.7;
			break;
		case 8:
			Frmwk.DTSX.TruBass_Dynamics = 0.8;
			break;
		case 9:
			Frmwk.DTSX.TruBass_Dynamics = 0.9;
			break;
		case 10:
			Frmwk.DTSX.TruBass_Dynamics = 1.0;
			break;
	}

	/*****************TruBass Bass Level****************/
	ParamVal = (Frmwk.DTSX.TruBass_Commands[0]>>9) & 0xf;
	switch(ParamVal)
	{
		case 0:
			Frmwk.DTSX.TruBass_BassLvl = 0.001;
		   break;
		case 1:
			Frmwk.DTSX.TruBass_BassLvl = 0.1;
		   break;
		case 2:
			Frmwk.DTSX.TruBass_BassLvl = 0.2;
			break;
		case 3:
			Frmwk.DTSX.TruBass_BassLvl = 0.3;
			break;
		case 4:
			Frmwk.DTSX.TruBass_BassLvl = 0.4;
			break;
		case 5:
			Frmwk.DTSX.TruBass_BassLvl = 0.5;
			break;
		case 6:
			Frmwk.DTSX.TruBass_BassLvl = 0.6;
			break;
		case 7:
			Frmwk.DTSX.TruBass_BassLvl = 0.7;
			break;
		case 8:
			Frmwk.DTSX.TruBass_BassLvl = 0.8;
			break;
		case 9:
			Frmwk.DTSX.TruBass_BassLvl = 0.9;
			break;
		case 10:
			Frmwk.DTSX.TruBass_BassLvl = 1.0;
			break;
	}

	/*****************TruBass Bass Speaker Size****************/
	Frmwk.DTSX.TruBass_SpkrSize = (Frmwk.DTSX.TruBass_Commands[0]>>1) & 0xf;
	Frmwk.DTSX.TruBass_SpkrSize = Frmwk.DTSX.TruBass_SpkrSize + 1; //This offset 1 is needed to match offline and realtime command processing

	/*****************TruBass Bass Speaker Mask****************/
	Frmwk.DTSX.TruBass_SmallSpkrMask = (Frmwk.DTSX.TruBass_Commands[0]>>13) & 0x3;

	/*****************TruBass Bass Channel Enable****************/
	Frmwk.DTSX.TruBass_ChEnable = 3;//C,L,R

	/*****************TruBass Bass Command Processing Done****************/
	Frmwk.DTSX.TBHDX_CommandProcessingDone = 0;

}
#endif //TRUBASS
