/*****************************************************************************
 *
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
 *
 *  Project          :  	21593SDK
 *  Organization     :  	Jasmin Infotech Private Limited,Chennai
 *  File Name        :		Main_Core1.c
 *  Description      :      Command Processing
 ******************************************************************************/
#pragma default_section(CODE,"Seg_Main_Code")
#pragma default_section(ALLDATA,"Seg_Main_Data")
#pragma default_section(SWITCH,"Seg_Main_Data")
#include "../Include/Main_Core1.h"
#include "../../../system/adi_initialize.h"
#include "../Include/Function_Prototype.h"
#ifdef DTSX_DECODER
#include "..\src\system\Include\Extern_C.h"
#endif //DTSX_DECODER
/**************************************************************************************************
 * If you want to use command program arguments, then place them in the following string. 
 *************************************************************************************************/

char __argv_string[] = "";

/**************************************************************************************************
 *			Global Functions Declaration Section
 *************************************************************************************************/
void ConfigSoftSwitches_EV_21593_SOM(void);
/*	main function Started Here	*/
void main()
{
	adi_initComponents();
	#ifndef CORE1_TX
		adi_core_enable(ADI_CORE_SHARC1);
	#endif
	#ifdef MELODY9
		ConfigSoftSwitches_EV_21593_SOM();
	#endif

	Enable_Cache();               // Enable Cache function
	System_Initialization();
	#ifdef LED_TOGGLE
		Initialize_Led1();
		Led1_Set_Routine();
	#endif

	Set_Priority();
	/* Enabling the global gate bit */
	if (SPI_Device == 1)
	{
		adi_int_InstallHandler (INTR_SPI1_RXDMA, SPI0_RxCore_Handler, 0, true);
	}
	else
	{
		adi_int_InstallHandler (INTR_SPI0_RXDMA, SPI0_RxCore_Handler, 0, true);
	}

	adi_sport_GlobalEnable(true);
	SendInitializationDone();
	
#ifndef DTSX_DECODER
	Stop_Command();
    Frmwk.Spi.PARAMETER_1 = 0x0910;
	Frmwk.Spi.PARAMETER_2 = 0x00A0;
	Frmwk.Spi.PARAMETER_3 = 0x0000;
	Frmwk.Spi.PARAMETER_4 = 0x0000;
	General_Decoding_Command();

	Frmwk.Spi.PARAMETER_1 =0x0; //I2S mode
	SportInitialize_Command();
	Play_Command();
#endif	//DTSX_DECODER

	while(1)
	{
		Frmwk.Spi.STATUS_BYTE1 = (Frmwk.Spi.STATUS_BYTE1&0xFFE0)|(Frmwk.Autdet.MSGR_Save&0x1F);
		if((Frmwk.Spi.serialflash_flag==0)&&(Frmwk.Spi.serialflash_cmd_flag==0)
				&&(Frmwk.Spi.download_flag==0)
				&&(Frmwk.Spi.DirectWrite_flag==0)
				&&(Frmwk.Spi.DirectRead_flag==0))
		{
				Status_Comparison();	// Valid only when NO SPECIAL COMMANDS
		}

		#ifdef	SPI_COMMAND
			if((Frmwk.Spi.COMMAND_BYTE&0xFF)!=0)
			{
				//Decoder & Post processing commands from HOST will be processed here
				CommandProcessing();
				Frmwk.Spi.COMMAND_BYTE = 0;
				SendIRQInterrupt();
			}
		#else
			Frmwk.run_flag=1;
		#endif

		*datacanbeprocessnow = Frmwk.IOP.datacanbeprocessednow;
		if(Frmwk.run_flag)
		{
			PlayForgnd();
			if((Frmwk.ADI_DecoderError == NO_ERROR)||(Frmwk.ADI_DecoderError == DECODER_ERROR))
			{
				Status_Update();
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
section("Seg_Cmd_Code")
#ifdef COMMAND_PROCESSING
void CommandProcessing(void)
{
	Frmwk.cmd_result = 0;					        // No Error
	if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x2)        // PLAY COMMAND
	{
		Play_Command();
	}
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x3)	// STOP COMMAND
	{
		Stop_Command();
	}
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x4)	// MUTE COMMAND
	{
		Mute_Command();
	}
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x5)	// RESUME COMMAND
	{
		Resume_Command();
	}
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x6)	// SPORTINIT COMMAND
	{
		SportInitialize_Command();
	}
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x0E)	// Special Function Command
	{
			Special_Function_Command();
	}

	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x0F)	//Tx_Rx_Mode_Command
	{
		Tx_Rx_Mode_Command();
	}
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x10)	// GENERAL COMMAND
	{
		General_Decoding_Command();
	}
#ifdef DTSX_DECODER
    else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x31)	// DTSX OPTIONS COMMAND
    {
    	DTSX_OPTIONS_COMMAND();
    }
#ifdef TRUBASS
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x34)
	{
		DTSX_PP_COMMAND();
	}
#endif //TRUBASS
#endif //DTSX_DECODER

#ifdef MCPCM_DECODER
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x35)
	{
		MPCM_Input_Command();
	}
#endif
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x41)  // CHANNEL REORDER COMMAND
	{
	    CHANNEL_REORDER_COMMAND();
	}
#ifndef CORE1_TX
	else if((Frmwk.Spi.COMMAND_BYTE&0xFF) > 0x50)	// Core2  Command Processing
	{
		CommandProcessing_Core2();
	}
#endif
}
#endif /*	End of #ifdef COMMAND_PROCESSING	*/
/******************************************************************************
 *  Module Name        : Play_Command
 *  Functionality      : Play_Command Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
section("Seg_Cmd_Code")
void Play_Command(void)
{
	if(Frmwk.run_flag==0)
	{
		Frmwk.Autdet.HeaderPlaceWritten = 0;
		Frmwk.run_flag  = 1;
		Frmwk.stop_flag = 0;
		Init_Var();
		Frmwk.Spi.STATUS_BYTE1 &= 0x7FFF;		// STATUS INVALID
	}
	*run_flag = Frmwk.run_flag;
}
/******************************************************************************
 *  Module Name        : Stop_Command
 *  Functionality      : Stop_Command Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
section("Seg_Cmd_Code")
void Stop_Command(void)
{
	Frmwk.stop_flag = 1;
	Frmwk.run_flag  = 0;
	Frmwk.Spi.STATUS_BYTE1 &= 0x7FFF;			// STATUS INVALID
	*run_flag = Frmwk.run_flag;
}

/******************************************************************************
 *  Module Name        : MUTE_COMMAND
 *  Functionality      : Mute command processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("Seg_Cmd_Code")
void Mute_Command(void)
{
	Frmwk.Mute_flag_from_HOST = 1;
}

/******************************************************************************
 *  Module Name        : RESUME_COMMAND
 *  Functionality      : Resume command processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("Seg_Cmd_Code")
void Resume_Command(void)
{
	Frmwk.Mute_flag_from_HOST = 0;
}

void Tx_Rx_Mode_Command(void)
{
#ifdef eARC_ENABLE
	eARC_Mode    	= (Frmwk.Spi.PARAMETER_1 & 0x1);

	Frmwk.cmd_temp_read = (Frmwk.Spi.PARAMETER_1 >> 1) & 0x3;

	if(Frmwk.cmd_temp_read == 2)
	{
		eARC_Clock_Ratio = 256;
	}
	else if(Frmwk.cmd_temp_read == 3)
	{
		eARC_Clock_Ratio = 512;
	}
	else
	{
		eARC_Clock_Ratio = 128;
	}
	I2S_TDM_MODE = (Frmwk.Spi.PARAMETER_1 >>4) & 0x3;
	
	if(prev_I2S_TDM_Mode != I2S_TDM_MODE)
	{
		SPORT_Recongifuration();
		prev_I2S_TDM_Mode = I2S_TDM_MODE;
	}

#endif
}
/******************************************************************************
 *  Module Name        : Special_Function_Command
 *  Functionality      : Special_Function_Command processing(36 channel validation,
 *  					 Temperature monitoring unit)
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
void Special_Function_Command(void)
{

#ifdef OPTICAL_TESTING
	*optical_test = (Frmwk.Spi.PARAMETER_1>>6) &0x1; // for optical mode testing purpose (only for DTSX_PRO)
#endif // OPTICAL_TESTING
#ifdef TMU
	TMU_Enable   = (Frmwk.Spi.PARAMETER_1>>7)&0x1;
#endif
#ifdef VALIDATION_36CH
	*Ch36_Enable    	= (Frmwk.Spi.PARAMETER_1>>8) &0x1; // Routing Last 12 Channel (25ch-36ch) to First 12 channel and 1st 8 channel copy to CODEC 3 (17-24ch)

	*testing_36_ch  = (Frmwk.Spi.PARAMETER_1>>9) &0x1; // Copying First 8 channel data to remaining 24 channel
	DAI_Init();

#endif
}
/******************************************************************************
 *  Module Name        : General_Decoding_Command
 *  Functionality      : General Decoding Command processing(autodetect_mode,
 *  					 sampling_fs_micro,DRC cut and boost)
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("Seg_Cmd_Code")
void General_Decoding_Command(void)
{
#ifdef DTSX_DECODER
	int Address_store;
#endif // DTSX_DECODER
	Frmwk.autodetect_mode       = (Frmwk.Spi.PARAMETER_1>>8)&0xF;// FORCEPCM3;

	Frmwk.cmd_temp_read			= (Frmwk.Spi.PARAMETER_2>>4)&0xF;
	//values 3, 7 & greater than 10 of bit 4 - 7 is set as reserved
	if((Frmwk.cmd_temp_read == 3)||(Frmwk.cmd_temp_read == 7)||(Frmwk.cmd_temp_read>10))
	{
		Frmwk.cmd_temp_read=2;
	}


		Frmwk.sampling_fs_micro	= Frmwk.cmd_temp_read;


	if(Frmwk.prev_sampling_fs_micro != Frmwk.sampling_fs_micro)
	{
		Init_Var_Fs();
		Frmwk.prev_sampling_fs_micro = Frmwk.sampling_fs_micro;
	}
#ifdef DTSX_DECODER
	*Post_decoding_option_command =(Frmwk.Spi.PARAMETER_2)&0x00000003;//make this as 3 to enable NeuralX
#endif	//DTSX_DECODER
	switch(Frmwk.autodetect_mode)
	{
#if defined (PCM_DECODER) || defined(MCPCM_DECODER)
		case AUTODETECT1:
			Frmwk.Misc.Control.ForcePcm = 0;
			Frmwk.LPCMDelaySize_host = 0;
			Frmwk.PCMEnable=1;
			Frmwk.MCLPCMEnable=0;
			Frmwk.ADCEnable=0;
			Frmwk.Autdet.autodetect3 = 0;
			break;
#endif //defined (PCM_DECODER) || defined(MCPCM_DECODER)
		case FORCEPCM3:
			Frmwk.Misc.Control.ForcePcm = 0;
			Frmwk.LPCMDelaySize_host = 0;
			Frmwk.PCMEnable = 0;
			Frmwk.MCLPCMEnable = 1;
			Frmwk.Autdet.autodetect3 = 0;
			Frmwk.ADCEnable = 0;
			Frmwk.MCLPCM_ON = 1;
			Frmwk.MCLPCMEnable = 1;
		break;
#ifdef DTSX_DECODER	
		case AUTODETECT3:
			Frmwk.Misc.Control.ForcePcm = 0;
			Frmwk.LPCMDelaySize_host = 0;
			Frmwk.PCMEnable = 0;
			Frmwk.MCLPCMEnable = 0;
			Frmwk.Autdet.autodetect3 = 1;
			Frmwk.ADCEnable = 0;
			Address_store = (int)&InAutobuf[0];
			Frmwk.Rx.INPUTsamples_ptr = (int *)Address_store;		
			Frmwk.Autdet.InAutbuf_ptr = Frmwk.Rx.INPUTsamples_ptr ;
			break;
#endif	//DTSX_DECODER
		default:
		break;
	}
#ifdef DOWNSAMPLING
	Frmwk.DS_Mode = (Frmwk.Spi.PARAMETER_3>>5)&0x3;

	down_samp_flag_cmd = 0;
	DnSamp192to48 = 0;
	if(Frmwk.DS_Mode==0x2)//Invalid command
	{
		Frmwk.DS_Mode = 0;
	}
	if(Frmwk.DS_Mode != Previous_DS_Mode)
	{
		Frmwk.init_ds_processing 	= 1;

		Frmwk.InitDoneForStreamType = -1;
		Frmwk.InitDoneForFS = -1;
		Frmwk.MemoryAllotMCLPCM = 0;
		Previous_DS_Mode = Frmwk.DS_Mode;
	}

	if(Frmwk.DS_Mode==0x1)// 1/2 Downsampling
	{
		DnSamp192to48 = 0;
		down_samp_flag_cmd = 1;
	}
	else if(Frmwk.DS_Mode==0x3)// 1/4 Downsampling
	{
		DnSamp192to48 = 1;
		down_samp_flag_cmd = 1;
	}
#ifdef DOWNSAMPLING_DTSX
	*DTSX_DS_Enable = 0;
	if(Frmwk.DS_Mode == 0x1)// 1/2 Downsampling
	{
		*DTSX_DS_Enable = 1;
	}
#endif //DOWNSAMPLING_DTSX

#endif //DOWNSAMPLING
}
/******************************************************************************
 *  Module Name        : SportInitialize_Command
 *  Functionality      : Sport initialization command processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("Seg_Cmd_Code")
void SportInitialize_Command(void)
{
	Frmwk.Spi.STATUS_BYTE1 &= 0x7FFF;
	Frmwk.Autdet.AlignFlg = 0;
	Frmwk.Autdet.MSGR_Save	= SYNCSIGUNKNOWN;
	Frmwk.Autdet.MSGR4 = 0xF;

	SPORT_Recongifuration();

	Init_Var();
	Init_Var_Fs();
}
/******************************************************************************
 *  Module Name        : SendIRQInterrupt
 *  Functionality      : SendIRQInterrupt Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
void SendIRQInterrupt(void)
{
	Frmwk.Spi.INTR_DESC_LOCN &=0xfff9;

	if((Frmwk.cmd_result==0)&&(Frmwk.Spi.special_cmd_result == 0))
	{
		Frmwk.Spi.INTR_DESC_LOCN |= SIGNATURE_COMMAND_SUCCESSFUL;
	}
	else if((Frmwk.cmd_result == 1)||(Frmwk.Spi.special_cmd_result == 1))
	{
		Frmwk.Spi.INTR_DESC_LOCN |= SIGNATURE_COMMAND_ERROR;
	}

	if(Frmwk.cmd_result!=2)
	{
		Flag_Toggle();
	}

	Frmwk.cmd_result = 0;
	Frmwk.Spi.special_cmd_result = 0;
}

#ifdef DTSX_DECODER
/******************************************************************************
 *  Module Name        : DTSX_OPTIONS_COMMAND
 *  Functionality      : DTSX_OPTIONS_COMMAND Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("Seg_Dtsx_Cmd_Code")
void DTSX_OPTIONS_COMMAND()
{
	int TypeOneMode;

	Frmwk.DTSX.DTSX_Commands[0] = Frmwk.Spi.PARAMETER_1;
	Frmwk.DTSX.DTSX_Commands[1] = Frmwk.Spi.PARAMETER_2 | 0x1; //0x1 is to enable analog compensation by default
	Frmwk.DTSX.DTSX_Commands[2] = Frmwk.Spi.PARAMETER_3;
	Frmwk.DTSX.DTSX_Commands[3] = (Frmwk.Spi.PARAMETER_4 & 0xFFDF);// Ignore UHD set as '0' (14th bit of PARAMETER_4)
	TypeOneMode = (Frmwk.DTSX.DTSX_Commands[3] & 0x180) >> 7;//For offline handling auto/on/off mode value is added by 1.It is taken care inside library.
	TypeOneMode = TypeOneMode + 1;
	Frmwk.DTSX.DTSX_Commands[3] = (Frmwk.DTSX.DTSX_Commands[3] & 0xFE7F) | (TypeOneMode<<7); 		//command for core 2
	*Core2_command_parameter4 = Frmwk.DTSX.DTSX_Commands[3];

	Frmwk.DTSX.DTSXcommandprocessingdone_c1 = 0;				//Command Initialisation
	*Cmd_processing_dne=Frmwk.DTSX.DTSXcommandprocessingdone_c1;//Core 2 command init

	Frmwk.DTSX.OutputChannel_Confiq_command = Frmwk.DTSX.DTSX_Commands[0] | ((Frmwk.DTSX.DTSX_Commands[1] << 5 ) & 0x1f0000); // Core 1 SpkrOut command
	*Outputchannel_config_command = Frmwk.DTSX.OutputChannel_Confiq_command; 	//SpkrOut config for core2
}

#ifdef TRUBASS
section("Seg_trubass_Cmd_Code")
void DTSX_PP_COMMAND(void)
{
   *TruBass_cmd_parameter1  =  Frmwk.Spi.PARAMETER_1;
   *TBassCmd_processing_dne = 0;     //Core2 command init
}
#endif//TRUBASS
#endif //DTSX_DECODER

/******************************************************************************
 *  Module Name        : CHANNEL_REORDER_COMMAND
 *  Functionality      : CHANNEL_REORDER_COMMAND Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("Seg_Cmd_Code")
void CHANNEL_REORDER_COMMAND()
{
	*ChanReorder_AssignLines_1_6  = ((Frmwk.Spi.PARAMETER_1)&0x7FFF);              // Assign Lines (1,2,3)
	*ChanReorder_AssignLines_1_6 |= ((Frmwk.Spi.PARAMETER_2)&0x7FFF) << 16;        // Assign Lines (4,5,6)
	*ChanReorder_AssignLines_7_12  = ((Frmwk.Spi.PARAMETER_3)&0x7FFF);              // Assign Lines (7,8,9)
	*ChanReorder_AssignLines_7_12 |= ((Frmwk.Spi.PARAMETER_4)&0x7FFF) << 16;        // Assign Lines (10,11,12)
	*ChanReorder_AssignLines_13_16  = ((Frmwk.Spi.PARAMETER_5)&0x7FFF);              // Assign Lines (13,14,15)
	*ChanReorder_AssignLines_13_16 |= ((Frmwk.Spi.PARAMETER_6)&0x1F) << 16;          // Assign Lines (16)
}

/******************************************************************************
 *  Module Name        : MPCM_Input_command
 *  Functionality      : MPCM_Input_command Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("Seg_Cmd_Code")
void MPCM_Input_Command(void)
{

	Frmwk.inputChannelConfig=(Frmwk.Spi.PARAMETER_1)&0x3;

	if(Frmwk.inputChannelConfig==0)
	{
		Frmwk.inputChannelConfig			 = 2;
	}
	else if(Frmwk.inputChannelConfig==1)
	{
		Frmwk.inputChannelConfig			 = 6;
	}
	else if(Frmwk.inputChannelConfig==2)
	{
		Frmwk.inputChannelConfig			 = 8;
	}
}
/******************************************************************************
 *  Module Name        : CommandProcessing_Core2
 *  Functionality      : Core2 Command Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
section("Seg_Cmd_Code")
void CommandProcessing_Core2(void)
{
	volatile int *src_ptr;
	int *dst_ptr;
	dst_ptr = PARAMETER_1_C2;
	src_ptr = &(Frmwk.Spi.PARAMETER_1);
	for(int i=0;i<31;i++)
	{
		*dst_ptr++ = *src_ptr++;
	}
	*COMMAND_BYTE_C2 = Frmwk.Spi.COMMAND_BYTE;
#ifndef CORE1_TX
	Wait_Core1(core2_command_processing_status_done,0);
	*core2_command_processing_status_done = 0;
#endif

}
