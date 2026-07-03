/*****************************************************************************
 *
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
 *
 *  Project          :  	21593SDK
 *  Organization     :  	Jasmin Infotech Private Limited,Chennai
 *  File Name        :		Main_Core2.c
 *  Description      :      Command Processing,CACHE Memory allocation,PackDac Memory Allocation Related Function
 ******************************************************************************/
#include <stdlib.h>
#pragma default_section(CODE,"Seg_Main_Core2")
#pragma default_section(ALLDATA,"Seg_Main_Core2_Data")
#include <services/int/adi_int.h>
#include "..\src\System\Include\Main_Core2.h"
#include "..\src\System\Include\Function_Prototype.h"
#include "..\src\System\Include\Extern_Core2.h"


/** 
 * If you want to use command program arguments, then place them in the following string. 
 */
char __argv_string[] = "";

int main(int argc, char *argv[])
{
    adi_initComponents();

    *pREG_RCU0_MSG=1;

	Enable_Cache();

#ifdef LED_TOGGLE
	Initialize_Led2();
#endif

#ifdef MDMA_COPY
	MDMA_init();
#endif
		Init_Struct();

	*pREG_RCU0_MSG_CLR =  0xC000; // Clear bits 14/15 of RCU_MSG register
#ifdef TIMERENABLED_KERNAL
	Ext_Buffer_Data_Size = sizeof(Ext_Buffer_Data)/4;
#endif // TIMERENABLED_KERNAL
	Frmwk.Init_begin_core2=1;

	Free_AllotMemoryPackDac(Frmwk.pack_length_mcpcm, Frmwk.predac_length_mcpcm, 1);

	Frmwk.Init_begin_core2=0;
	*pREG_RCU0_MSG=1;
	*SampleBlock_Core2 = No_Sample_Processing;
	while(1)
	{
		Frmwk.IOP.datacanbeprocessednow_core1=*datacanbeprocessnow;
		if(*COMMAND_BYTE_C2 > 0x50)
			Command_Update();

		if((Frmwk.Spi.COMMAND_BYTE&0xFF) > 0x50)
		{
		   //Decoder & Post processing commands from HOST will be processed here
		   CommandProcessing();
		   Frmwk.Spi.COMMAND_BYTE = 0;
		}

		if((Frmwk.IOP.datacanbeprocessednow_core1==1) && (*run_flag==1))
		{
			*core2_dcpn_done=0;
			PlayForgnd();
		}
		else
		{
			Frmwk.InitDoneForStreamType=0;
			Frmwk.IOP.datacanbeprocessednow=0;
			Frmwk.Init_begin_core2=0;
			*core2_dcpn_done=1;
		}
	}
}

void Command_Update()
{
	int *src_ptr;
	volatile int *dst_ptr;
	src_ptr = PARAMETER_1_C2;
	dst_ptr = &(Frmwk.Spi.PARAMETER_1);

	Frmwk.Spi.COMMAND_BYTE 	= *COMMAND_BYTE_C2;

	for(int i=0;i<31;i++)
	{
		*dst_ptr++ = *src_ptr++;
	}

	*COMMAND_BYTE_C2		= 0;
}

/******************************************************************************
*  Module Name        : CommandProcessing
*  Functionality      : User commands from HOST will be processed here
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/
void CommandProcessing(void)
{
#ifdef CUSTOMER_PP
	if((Frmwk.Spi.COMMAND_BYTE&0xFF) == 0x61)	// CUSTOMER EXAMPLE COMMAND
	{
		CUSTOMER_PP_COMMAND();
	}
#endif
	*core2_command_processing_status_done=1;
}

int Free_AllotMemoryPackDac( int size1, int size2, int val1)
{
	if(Frmwk.Init_begin_core2==0)
	return 1;

	Frmwk.IOP.Predac.length 		= *Predac_length;
	Frmwk.IOP.Predac.lengthhalf 	= *Predac_length_half;
	Frmwk.StreamType 				= SYNCSIGUNKNOWN;
	Frmwk.IOP.Predac.heap 			= *predac_heap ;
	Frmwk.MemoryAllotDac			= 1;
	*predac_wr_ptr_c1               = *Latency_predac_wr_ptr_c1;
    Frmwk.IOP.Predac.wr_ptr_c2		= *Latency_predac_wr_ptr_c1;
    Frmwk.IOP.Predac.rd_ptr_c2 		= *Latency_predac_wr_ptr_c1;
    *predac_wr_ptr_c2            	= *Latency_predac_wr_ptr_c1;
    *core2_sync_bit					= 1;
    return 0;
}

void FreeMemoryAll(void)
{
	if(Frmwk.MemoryAllotPack)
	{
		Frmwk.MemoryAllotPack = 0;
	}

	if(Frmwk.MemoryAllotDac)
	{
		Frmwk.MemoryAllotDac=0;
	}

		Frmwk.MemoryAllotMCLPCM=1;
		Frmwk.MCLPCM_ON = 1;

}
	
void Enable_Cache(void)
{
	*pREG_SHL1C_CFG2 |= 0x3cc0;
	 NOP10; NOP10; NOP10; NOP1; NOP1; NOP1;//33 NOPS

	// Non Cacheable region In L2 Memory
	*pREG_SHL1C_RANGE_START5 = 0x2015e420;
	 NOP10;NOP10;
	*pREG_SHL1C_RANGE_END5 =  0x2016642f;
	 NOP10;NOP10;

	// Non Cacheable region In DDR0 (PREDAC & Addpredac buffer)
	*pREG_SHL1C_RANGE_START6=0x80600000;
	 NOP10;NOP10;

	*pREG_SHL1C_RANGE_END6=0x807400ff;
	 NOP10;NOP10;
}

