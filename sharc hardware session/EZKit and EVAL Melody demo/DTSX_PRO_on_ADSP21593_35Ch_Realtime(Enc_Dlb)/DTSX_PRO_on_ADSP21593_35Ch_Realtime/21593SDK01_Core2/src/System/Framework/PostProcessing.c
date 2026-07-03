
/*****************************************************************************
 *
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
 *
 *  Project          :  	21593SDK
 *  Organization     :  	Jasmin Infotech Private Limited,Chennai
 *  File Name        :		PostProcessing.c
 *  Description      :   	PostProcessing routines

 ******************************************************************************/
#pragma default_section(CODE,"Seg_Decoder_Core2")

#include "../Include/Commn.h"
#include "../Include/Def_Struct.h"
#include "../Include/Extern_Core2.h"
#include "../Include/Function_Prototype.h"

void PostProcessing_Routine()
{

#ifdef DTSX_DECODER
	if((Frmwk.DTSX.StreamType_DTSX == 1) || (Frmwk.DTSX.NeuralX_Enable == 1))
	{
	  if(Frmwk.DTSX.DTSX_Processing_enable == 1)
	  {
#ifdef DOWNSAMPLING_DTSX
		if((*Stream_sample_rate == 512) && (*DTSX_DS_Enable == 1))
		{
			for(count_ds=0 ; count_ds < 2 ; count_ds++)
			{
				DTSX_DS_internal_to_Predac_int_copy();
				DtsxPostProcessing();
				Predac_int_to_DTSX_DS_buffcopy();
			}
		}
		else
		{
			DTSX_DS_C2_var = 0;
#endif //DOWNSAMPLING_DTSX
			DtsxPostProcessing();
#ifdef DOWNSAMPLING_DTSX
		}
		  Dtsx_Downsampling();
#endif //DOWNSAMPLING_DTSX
	  }
	}
#endif //DTSX_DECODER
#ifdef  CUSTOMER_PP

		PreDac_Int_To_Cust_PP_Buffer();

	#ifdef FLOAT
		Frmwk.Customer_pp.Data_Format = FLOAT_PP;
	#endif

		if(Frmwk.Customer_pp.Data_Format == 1)
		{
			fixtofloatConversion();
		}

				Customer_PP_kernel();

		if(Frmwk.Customer_pp.Data_Format == 1)
		{
			floattofixConversion();
		}

		Cust_PP_To_PreDac_Int_Buffer();

#endif
#ifdef LED_TOGGLE
Led2_Toggle_Routine();
#endif

}
#ifdef DOWNSAMPLING_DTSX
void Dtsx_Downsampling()
{
	Frmwk.DTSX.DTSX_Downsamp_Enable = 0;
	if((*Stream_sample_rate == 512) && (*DTSX_DS_Enable == 1))
	{
		Frmwk.DTSX.DTSX_Downsamp_Enable = 1;
	}
	else
	{
		Frmwk.DTSX.DTSX_Downsamp_Enable = 0;

	}
	if(Frmwk.DTSX.DTSX_Downsamp_Enable == 1)
	{
		Int_predac_to_DS_Inputbuffer_cpy();
		Down_Samp_Processing_32ch();
		DS_outputbuffer_to_DSPredac_cpy();
		DTSX_DS_C2_var = 1;
	}
}
#endif //DOWNSAMPLING_DTSX
