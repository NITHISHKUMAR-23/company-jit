/*****************************************************************************

Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
 *
 *  Project          :  	21569SDK
 *  Organization     :  	Jasmin Infotech Private Limited,Chennai
 *  File Name        :		Main.c
 *  Description      :		1. PlayForgnd Function Call
 *  						2. Command Processing

 ******************************************************************************/
#pragma default_section(CODE,"Seg_Main_Code")
#include "../Include/Main.h"
#include "../../../system/adi_initialize.h"

/**************************************************************************************************
 * If you want to use command program arguments, then place them in the following string. 
 *************************************************************************************************/

char __argv_string[] = "";

/**************************************************************************************************
 *			Global Functions Declaration Section
 *************************************************************************************************/

/*	main function Started Here	*/
void main()
{

	adi_initComponents();

	Enable_Cache();               // Enable Cache function
	System_Initialization();

	initialize_led();

	Set_Priority();

	/* Enabling the global gate bit */
	 adi_sport_GlobalEnable(true);

#ifdef EMDMA
	adi_int_InstallHandler(INTR_EMDMA0_DONE,EMDMA0_CORE2_Int_Handler,0,true);
#endif
	SendInitializationDone();

	Heartbeat_led_set_routine();
	while(1)
	{
		Frmwk.Spi.STATUS_BYTE1 = (Frmwk.Spi.STATUS_BYTE1&0xFFE0)|(Frmwk.Autdet.MSGR_Save&0x1F);


		if((Frmwk.Spi.serialflash_flag==0)&&(Frmwk.Spi.serialflash_cmd_flag==0)
				&&(Frmwk.Spi.download_flag==0)
				&&(Frmwk.Spi.DirectWrite_flag==0)
				&&(Frmwk.Spi.DirectRead_flag==0))
		{

				I_CCALL_ (Status_Comparison);	// Valid only when NO SPECIAL COMMANDS
		}

#ifdef SPDIF_ENABLE
		Spdif_Lock_check_fn();
#endif

#ifdef	SPI_COMMAND
		if((Frmwk.Spi.COMMAND_BYTE&0xFF)!=0)
		{
			//Decoder & Post processing commands from HOST will be processed here
			I_CCALL_(CommandProcessing);
			Frmwk.Spi.COMMAND_BYTE = 0;
			SendIRQInterrupt();
		}
#else
		Frmwk.run_flag=1;
#endif


		if(Frmwk.run_flag)
		{
			I_CCALL_( PlayForgnd );
			if((Frmwk.ADI_DecoderError == NO_ERROR)||(Frmwk.ADI_DecoderError == DECODER_ERROR))
			{
				I_CCALL_(Status_Update);
				NOP1;
			}
		}
		if(Frmwk.stop_flag)
		{
			Frmwk.run_flag  = 0;
			Frmwk.stop_flag = 0;
		}

	}
}

/******************************************************************************
 *  Module Name        : CommandProcessing
 *  Functionality      : CommandProcessing Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
section("seg_kernal_code_l3")
#ifdef COMMAND_PROCESSING
I_CLABEL_(CommandProcessing)
{

	Frmwk.cmd_result = 0;					        // No Error

	if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x2)		// PLAY COMMAND
		I_CCALL_(Play_Command);

	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x3)	// STOP COMMAND
		I_CCALL_(Stop_Command);

	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x4)	// MUTE COMMAND
		I_CCALL_(Mute_Command);

	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x5)	// RESUME COMMAND
		I_CCALL_(Resume_Command);

	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x6)	// SPORTINIT COMMAND
		I_CCALL_(SportInitialize_Command);
#ifdef ASRC_ENABLE
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0xF)	// SPECIAL COMMAND
			I_CCALL_(Special_Command);
#endif
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x10)	// GENERAL COMMAND
		I_CCALL_(General_Decoding_Command);
#ifdef MPCM_DMIX
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x35)
		I_CCALL_(MPCM_Input_command);
#endif
#ifdef CUSTOMER_PP
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x50)	// CUSTOMER EXAMPLE COMMAND
	I_CCALL_(CUSTOMER_PP_COMMAND);
#endif

}
#endif /*	End of #ifdef COMMAND_PROCESSING	*/

/******************************************************************************
 *  Module Name        : Play_Command
 *  Functionality      : Play_Command Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
section("seg_kernal_code_l3")
I_CLABEL_(Play_Command)
{
	if(Frmwk.run_flag==0)
	{
		Frmwk.Autdet.HeaderPlaceWritten = 0;
		Frmwk.run_flag  = 1;
		Frmwk.stop_flag = 0;

		I_CCALL_(Init_Var);
		Frmwk.Spi.STATUS_BYTE1 &= 0x7FFF;		// STATUS INVALID
	}

}
/******************************************************************************
 *  Module Name        : Stop_Command
 *  Functionality      : Stop_Command Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
section("seg_kernal_code_l3")
I_CLABEL_(Stop_Command)
{
	Frmwk.stop_flag = 1;
	Frmwk.run_flag  = 0;
	Frmwk.Spi.STATUS_BYTE1 &= 0x7FFF;			// STATUS INVALID

}

/******************************************************************************
 *  Module Name        : MUTE_COMMAND
 *  Functionality      : Mute command processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_kernal_code_l3")
I_CLABEL_(Mute_Command)
{
	Frmwk.Mute_flag_from_HOST = 1;
}

/******************************************************************************
 *  Module Name        : RESUME_COMMAND
 *  Functionality      : Resume command processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_kernal_code_l3")
I_CLABEL_(Resume_Command)
{
	Frmwk.Mute_flag_from_HOST = 0;
#ifdef SPDIF_ENABLE
	if(SPDIF_Enable == 1)
	{
		spdif_status_valid_output_muted = 0;
	}
#endif
}
#ifdef ASRC_ENABLE
/******************************************************************************
 *  Module Name        : SPECIAL_COMMAND
 *  Functionality      : Special command processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_kernal_code_l3")
I_CLABEL_(Special_Command)
{

	ASRC_Enable = (Frmwk.Spi.PARAMETER_1>>1)&0x00000001;

	/****************************ASRC O/P Sample rate configuration************************/
	if(ASRC_Enable == 1)
	{
		ASRC_Samplerate = (Frmwk.Spi.PARAMETER_1 >>2) & 0x00000003;

		if(ASRC_Samplerate == 0)
		{
			FS_Div_Value = MCLK_48KHZ;
		}
		else if(ASRC_Samplerate == 1)
		{
			FS_Div_Value = MCLK_96KHZ;
		}
		else if(ASRC_Samplerate == 2)
		{
			FS_Div_Value = MCLK_192KHZ;
		}
		else
		{
			FS_Div_Value = MCLK_48KHZ;
		}
	}
	else
	{
		ASRC_Samplerate = 0;
		FS_Div_Value = MCLK_48KHZ;
	}
}
#endif
/******************************************************************************
 *  Module Name        : General_Decoding_Command
 *  Functionality      : General Decoding Command processing(autodetect_mode,
 *  					 sampling_fs_micro,DRC cut and boost)
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_kernal_code_l3")
I_CLABEL_(General_Decoding_Command)
{
	Frmwk.autodetect_mode       =  FORCEPCM3;   //(Frmwk.Spi.PARAMETER_1>>8)&0xF;
	Frmwk.cmd_temp_read			= (Frmwk.Spi.PARAMETER_2>>4)&0xF;
	Frmwk.LPCM_delay_index      = (Frmwk.Spi.PARAMETER_1>>2)&0xF;
	Frmwk.SampleDropCountIndex  = (Frmwk.Spi.PARAMETER_1>>2)&0xF;

	if(Frmwk.SampleDropCountIndex==1)
		Frmwk.SampleDropCount = 2048;
	else if(Frmwk.SampleDropCountIndex==2)
		Frmwk.SampleDropCount = 4096;
	else if(Frmwk.SampleDropCountIndex==3)
		Frmwk.SampleDropCount = 12288;
	else if((Frmwk.SampleDropCountIndex==4) || (Frmwk.SampleDropCountIndex==0) || (Frmwk.SampleDropCountIndex>4))
		Frmwk.SampleDropCount = 16384;
	//values 3, 7 & greater than 10 of bit 4 - 7 is set as reserved
	if((Frmwk.cmd_temp_read == 3)||(Frmwk.cmd_temp_read == 7)||(Frmwk.cmd_temp_read>10))
	{
		Frmwk.cmd_temp_read=2;
	}
	Frmwk.sampling_fs_micro				= Frmwk.cmd_temp_read;

#ifdef SPDIF_ENABLE
	SPDIF_Enable = (Frmwk.Spi.PARAMETER_3>>4)&0x00000001;
	
	if(SPDIF_Enable == 1)
	{
		Spdif_parameter1 		= Frmwk.Spi.PARAMETER_1;
		Spdif_parameter2 		= Frmwk.Spi.PARAMETER_2;
		Spdif_parameter3 		= Frmwk.Spi.PARAMETER_3;
		Frmwk.sampling_fs_micro = Spdif_Input_fs_micro;
	}
#endif

	if(Frmwk.prev_sampling_fs_micro != Frmwk.sampling_fs_micro)
	{
		I_CCALL_ (Init_Var_Fs);
		Frmwk.prev_sampling_fs_micro = Frmwk.sampling_fs_micro;
	}

	switch(Frmwk.autodetect_mode)
	{
	case AUTODETECT1:
		Frmwk.Misc.Control.ForcePcm = 0;
		Frmwk.LPCMDelaySize_host = 0;
		Frmwk.DOLBYDecoderEnable = 1;
		Frmwk.DDPLUSDecoderEnable = 1;
		Frmwk.PCMEnable = 1;
		Frmwk.MCLPCMEnable = 0;
		Frmwk.ADCEnable = 0;
		Frmwk.Autdet.autodetect3 = 0;
		Frmwk.AACDecoderEnable = 1;
		break;

	case AUTODETECT2:
		Frmwk.Misc.Control.ForcePcm = 1;
		if(Frmwk.LPCM_delay_index==0) Frmwk.LPCMDelaySize_host = 1024;
		else if(Frmwk.LPCM_delay_index==1) Frmwk.LPCMDelaySize_host = 2048;
		else if(Frmwk.LPCM_delay_index==2) Frmwk.LPCMDelaySize_host = 4096;
		else if(Frmwk.LPCM_delay_index==3) Frmwk.LPCMDelaySize_host = 12288;
		else if(Frmwk.LPCM_delay_index==4) Frmwk.LPCMDelaySize_host = 16384;
		Frmwk.SampleDropCount = Frmwk.LPCMDelaySize_host;
		Frmwk.PCMEnable = 1;
		Frmwk.MCLPCMEnable = 0;
		Frmwk.ADCEnable = 0;
		Frmwk.Autdet.autodetect3 = 0;
		Frmwk.AACDecoderEnable = 0;
		break;

	case AUTODETECT3:
		Frmwk.Misc.Control.ForcePcm = 0;
		Frmwk.LPCMDelaySize_host = 0;
		Frmwk.PCMEnable = 0;
		Frmwk.MCLPCMEnable = 0;
		Frmwk.Autdet.autodetect3 = 1;
		Frmwk.ADCEnable = 0;
		Frmwk.TRUEHDDecoderEnable = 1;
		Frmwk.Rx.INPUTsamples_ptr = InAutobuf;
		Frmwk.Autdet.InAutbuf_ptr = Frmwk.Rx.INPUTsamples_ptr;
		Frmwk.AACDecoderEnable = 0;
		break;

	case FORCEPCM3:
		Frmwk.Misc.Control.ForcePcm = 0;
		Frmwk.LPCMDelaySize_host = 0;
		Frmwk.PCMEnable = 0;
		Frmwk.MCLPCMEnable = 1;
		Frmwk.Autdet.autodetect3 = 0;
		Frmwk.ADCEnable = 0;
		Frmwk.MCLPCM_ON = 1;
		Frmwk.MCLPCMEnable = 1;
		Frmwk.AACDecoderEnable = 0;
		break;

	default:
		break;
	}

}

/******************************************************************************
 *  Module Name        : SportInitialize_Command
 *  Functionality      : Sport initialization command processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_kernal_code_l3")
I_CLABEL_(SportInitialize_Command)
{
	Frmwk.Spi.STATUS_BYTE1 &= 0x7FFF;
	Frmwk.Autdet.AlignFlg = 0;
	Frmwk.Autdet.MSGR_Save	= SYNCSIGUNKNOWN;
	Frmwk.Autdet.MSGR4 = 0xF;

	SPORT_Recongifuration();

	I_CCALL_(Init_Var);
	I_CCALL_(Init_Var_Fs);
}


/******************************************************************************
 *  Module Name        : SendIRQInterrupt
 *  Functionality      : SendIRQInterrupt Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_kernal_code_l3")
void SendIRQInterrupt(void)
{
	Frmwk.Spi.INTR_DESC_LOCN &=0xfff9;

	if((Frmwk.cmd_result==0)&&(Frmwk.Spi.special_cmd_result == 0))
		Frmwk.Spi.INTR_DESC_LOCN |= SIGNATURE_COMMAND_SUCCESSFUL;
	else if((Frmwk.cmd_result == 1)||(Frmwk.Spi.special_cmd_result == 1))
		Frmwk.Spi.INTR_DESC_LOCN |= SIGNATURE_COMMAND_ERROR;

	if(Frmwk.cmd_result!=2)
	{
		I_CCALL_(Flag_Toggle);
	}

	Frmwk.cmd_result = 0;
	Frmwk.Spi.special_cmd_result = 0;
}

/******************************************************************************
 *  Module Name        : MPCM_Input_command
 *  Functionality      : MPCM_Input_command Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("seg_kernal_code_l3")
I_CLABEL_(MPCM_Input_command)
{

	Frmwk.lfepresent=(Frmwk.Spi.PARAMETER_1>> 2)&0x1;
	Frmwk.inputChannelConfig=(Frmwk.Spi.PARAMETER_1)&0x3;

	if(Frmwk.inputChannelConfig==0)
		Frmwk.inputChannelConfig			 = 2;
	else if(Frmwk.inputChannelConfig==1)
		Frmwk.inputChannelConfig			 = 6;
	else if(Frmwk.inputChannelConfig==2)
		Frmwk.inputChannelConfig			 = 8;
}

