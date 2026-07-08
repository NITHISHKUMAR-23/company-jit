/*****************************************************************************
 *
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
 *
 *  Project          :  	21569SDK
 *  Organization     :  	Jasmin Infotech Private Limited,Chennai
 *  File Name        :		PostProcessing.c
 *  Description      :   	PostProcessing routines

 ******************************************************************************/
#pragma default_section(CODE,"Seg_Decoder_Code")
#include "../Include/Commn.h"
#include "../Include/Def_struct.h"
#include "../Include/Extern.h"
#include "..\src\system\Include\Commn.h"
void PostProcessing_Routine()
{

#ifdef  CUSTOMER_PP
	PreDac_Int_To_Cust_PP_Buffer();

#ifdef FLOAT
	Frmwk.Customer_pp.Data_Format = FLOAT_PP;
#endif

	if(Frmwk.Customer_pp.Data_Format == 1)
    {
	    fixtofloatConversion();
	}

	CustPPInputList[0] = CustomerPP_Buffer;
	CustPPInputList[1] = Frmwk.SampleBlock*CUSTOMER_PP_CHANNELS_CNT;
	CustPPInputList[2] = Frmwk.SampleBlock ;
	CustPPInputList[3] = CUSTOMER_PP_CHANNELS_CNT;
	CustPPInputList[4] = Frmwk.Customer_pp.Data_Format;
	CustPPInputList[5] = Frmwk.Customer_pp.ChannelMask;
	CustPPInputList[6] = Frmwk.StreamType;
	CustPPInputList[7] = Frmwk.OutputSampleRate;
	CustPPInputList[8] = Frmwk.Customer_pp.Volume;

	CustomerPP_gain_control(CustPPInputList);

	if(Frmwk.Customer_pp.Data_Format == 1)
	{
		floattofixConversion();
	}

#ifdef LED_TOGGLE
	PP_process_cnt++;
	if(PP_process_cnt == 188)
	{
		led_set_routine();
	}
	else if(PP_process_cnt == 375)
	{
		led_clr_routine();
		PP_process_cnt = 0;
	}
#endif
    Cust_PP_To_PreDac_Int_Buffer();
#endif
}
