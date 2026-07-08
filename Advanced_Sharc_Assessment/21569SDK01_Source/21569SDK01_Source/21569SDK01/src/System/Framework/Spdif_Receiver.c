/*****************************************************************************

Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
 *
 *  Project          :  	21569SDK
 *  Organization     :  	Jasmin Infotech Private Limited,Chennai
 *  File Name        :		Spdif_Receiver.c
 *  Description      :		Receiving 2 channels 64 samples in L,R for Spdif Mode

 ******************************************************************************/

#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include "sruSC589.h"
#include <sys/cache.h>
#include <cdefSC589.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include <services/int/adi_int.h>
#include <drivers/asrc/adi_asrc.h>
#include <drivers/spdif/adi_spdif_rx_v1.h>
#include "..\src\system\Include\Commn.h"
#include "..\src\system\Include\Extern.h"
#include "..\src\system\Include\Def_struct.h"
#include "..\src\system\Include\Function_Prototype.h"
#include "..\src\system\Include\Adr_Lkup_Tab_Macros.h"

#ifdef SPDIF_ENABLE
extern ADI_SPDIF_RX_HANDLE hSpdifRx;

section("seg_TX_RX_Handler_code")
void Spdif_Rx_ISR(int iid, void *handlerArg)
{
	int temp;
	temp=*pREG_DAI1_IRPTL_H;

	adi_spdif_Rx_GetLockStatus(hSpdifRx,&SPDIF_Input_locked);

	if(SPDIF_Input_locked == 0)
	{  
		if(Spdif_Input_locked_DAC_Mute==0)
		{
			Spdif_Input_locked_DAC_Mute = 1;

			Frmwk.Spi.INTR_DESC_LOCN &= 0xFBFF;
			Frmwk.Spi.INTR_DESC_LOCN |= 0x0400;

			asm("bit set FLAGS 0x00000001;");

			asm("nop;"); asm("nop;"); asm("nop;");
			asm("nop;"); asm("nop;"); asm("nop;");
			asm("nop;"); asm("nop;");
#ifdef ASRC_ENABLE
           if(ASRC_Enable ==1)
           {
			adi_asrc_SetSoftMute (hAsrc0 ,true);
			adi_asrc_SetSoftMute (hAsrc1 ,true);
		    adi_asrc_SetSoftMute (hAsrc2 ,true);
			adi_asrc_SetSoftMute (hAsrc3 ,true);
			adi_asrc_SetSoftMute (hAsrc4 ,true);
			adi_asrc_SetSoftMute (hAsrc5 ,true);
			adi_asrc_SetSoftMute (hAsrc6 ,true);
			adi_asrc_SetSoftMute (hAsrc7 ,true);
           }
#endif
			Prev_Spdif_Rx_Fs = -1;
			Spdif_prev_sampling_frequency = -1;
		}

	}
	if(SPDIF_Enable == 1)
	{
		Spdif_Input_lock_check();
	}
}

section("seg_kernal_code_l3")
void Spdif_Command_argument()
{
	Spdif_Rx_Fs_conversion(Spdif_Rx_Fs);

	if(Spdif_prev_sampling_frequency != Spdif_Input_fs_micro)
	{
		Spdif_prev_sampling_frequency = Spdif_Input_fs_micro;
		I_CCALL_(Stop_Command);

		Frmwk.Spi.PARAMETER_1 = Spdif_parameter1;
		Frmwk.Spi.PARAMETER_2 = (Spdif_parameter2 & 0xFF0F)|((Spdif_Input_fs_micro << 4) & 0x00F0) ;
		Frmwk.Spi.PARAMETER_3 = Spdif_parameter3|0x0010;

		I_CCALL_(General_Decoding_Command);
		I_CCALL_(SportInitialize_Command);
		I_CCALL_(Play_Command);
	}
}

section("seg_kernal_code_l3")
void Spdif_Input_fs_calculate_fn()
{
	asm("lcntr=28125000; do (pc,1) until lce; nop;");//90000000//128125000

	Spdif_Rx_Fs = (*pREG_SPDIF1_RX_STAT0_A>>24)&0x0000000f;

	if(Spdif_Rx_Fs==14 )
	{
		Spdif_Rx_Div = ADI_SPDIF_RX_SF_192K;
	}
	else if((Spdif_Rx_Fs > 10) && (Spdif_Rx_Fs < 14))
	{
		Spdif_Rx_Div = ADI_SPDIF_RX_SF_96K_TO_192K;
	}
	else
	{
		Spdif_Rx_Div = ADI_SPDIF_RX_SF_96K_OR_LOWER;
	}
}

section("seg_kernal_code_l3")
void Spdif_Input_lock_check()
{
	I_CCALL_(Mute_Command);
	I_CCALL_(Stop_Command);

	Spdif_unlock_interrupt_occured = 1;
	SPDIF_Input_locked = 1;

	adi_spdif_Rx_GetLockStatus(hSpdifRx,&SPDIF_Input_locked);
	for(SPDIF_testcount = 1000000;(SPDIF_testcount > 0) &&(!SPDIF_Input_locked) ;SPDIF_testcount--)
	adi_spdif_Rx_GetLockStatus(hSpdifRx,&SPDIF_Input_locked);
	if(SPDIF_testcount<=0)
	{
		SPDIF_Input_locked = 0;
	}

	if(SPDIF_Input_locked == 0)
	{
		return;
	}

	adi_spdif_Rx_RestartAudio (hSpdifRx);
	adi_spdif_Rx_SetTdmsel(hSpdifRx,Spdif_Rx_Div);

	adi_spdif_Rx_GetLockStatus(hSpdifRx,&SPDIF_Input_locked);
	for(SPDIF_testcount = 1000000;(SPDIF_testcount > 0) &&(!SPDIF_Input_locked) ;SPDIF_testcount--)
	adi_spdif_Rx_GetLockStatus(hSpdifRx,&SPDIF_Input_locked);
	if(SPDIF_testcount<=0)
	{
		SPDIF_Input_locked=0;
	}
	Spdif_Input_fs_calculate_fn();
	adi_spdif_Rx_RestartAudio (hSpdifRx);
	adi_spdif_Rx_SetTdmsel(hSpdifRx,Spdif_Rx_Div);

	adi_spdif_Rx_GetLockStatus(hSpdifRx,&SPDIF_Input_locked);
	for(SPDIF_testcount = 1000000;(SPDIF_testcount > 0) &&(!SPDIF_Input_locked) ;SPDIF_testcount--)
	adi_spdif_Rx_GetLockStatus(hSpdifRx,&SPDIF_Input_locked);
	if(SPDIF_testcount<=0)
	{
		SPDIF_Input_locked=0;
	}

	if(SPDIF_Input_locked == 1)
	{
		if((Prev_Spdif_Rx_Fs != Spdif_Rx_Fs))
		{
			Prev_Spdif_Rx_Fs = Spdif_Rx_Fs;
			Spdif_Command_arg = 1;
		}
		Spdif_Input_locked_DAC_Mute = 0;
#ifdef ASRC_ENABLE
        if(ASRC_Enable ==1)
        {
		adi_asrc_SetSoftMute (hAsrc0 ,false);
		adi_asrc_SetSoftMute (hAsrc1 ,false);
		adi_asrc_SetSoftMute (hAsrc2 ,false);
		adi_asrc_SetSoftMute (hAsrc3 ,false);
		adi_asrc_SetSoftMute (hAsrc4 ,false);
		adi_asrc_SetSoftMute (hAsrc5 ,false);
		adi_asrc_SetSoftMute (hAsrc6 ,false);
		adi_asrc_SetSoftMute (hAsrc7 ,false);
        }
#endif
	}

}

section("seg_kernal_code_l3")
void Spdif_Rx_Fs_conversion(int Spdif_Rx_Fs)
{
	if(Spdif_Rx_Fs==3)
	{
		Spdif_Input_fs_micro = 0;
	}
	else if(Spdif_Rx_Fs==0)
	{
		Spdif_Input_fs_micro = 1;
	}
	else if(Spdif_Rx_Fs==2)
	{
		Spdif_Input_fs_micro = 2;
	}
	else if(Spdif_Rx_Fs==8)
	{
		Spdif_Input_fs_micro = 5;
	}
	else if(Spdif_Rx_Fs==10)
	{
		Spdif_Input_fs_micro = 6;
	}
	else if(Spdif_Rx_Fs==12)
	{
		Spdif_Input_fs_micro = 9;
	}
	else
	{
		Spdif_Input_fs_micro = 10;
	}
}

section("seg_kernal_code_l3")
void Spdif_Lock_check_fn()
{
	if((SPDIF_Input_locked == 0) && (SPDIF_Enable == 1))
	{
		Spdif_Input_lock_check();
	}
#ifdef ASRC_ENABLE
	else
	{
		if(Spdif_Input_locked_DAC_Mute==1 && ASRC_Enable ==1)
		{
			Spdif_Input_locked_DAC_Mute = 0;
			adi_asrc_SetSoftMute (hAsrc0 ,false);
			adi_asrc_SetSoftMute (hAsrc1 ,false);
			adi_asrc_SetSoftMute (hAsrc2 ,false);
			adi_asrc_SetSoftMute (hAsrc3 ,false);
			adi_asrc_SetSoftMute (hAsrc4 ,false);
			adi_asrc_SetSoftMute (hAsrc5 ,false);
			adi_asrc_SetSoftMute (hAsrc6 ,false);
			adi_asrc_SetSoftMute (hAsrc7 ,false);

		}
	}
#endif

	if((SPDIF_Enable==1) && ( Spdif_Command_arg==1))
	{
		Spdif_unlock_interrupt_occured=0;

		Spdif_Command_argument();

		if(Spdif_unlock_interrupt_occured == 0)
		{
			if(SPDIF_Input_locked == 1)
				spdif_status_valid_output_muted = 1;

			Spdif_Command_arg = 0;
		}
	}

	if((SPDIF_Enable==1) && ( Spdif_Command_arg==0))
	{
		if(Spdif_unlock_interrupt_occured == 1)
		{
			if(SPDIF_Input_locked == 1)
				spdif_status_valid_output_muted = 1;

			Spdif_unlock_interrupt_occured = 0;
		}
	}
}
#endif
