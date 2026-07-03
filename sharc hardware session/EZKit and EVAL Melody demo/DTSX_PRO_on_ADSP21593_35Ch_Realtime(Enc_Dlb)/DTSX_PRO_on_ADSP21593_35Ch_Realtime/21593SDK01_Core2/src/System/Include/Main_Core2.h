/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Main_Core2.h
*  Description      :   Global variable Declaration
******************************************************************************/

#pragma default_section(ALLDATA,"Seg_Kernal_Data")

#ifndef __MAIN_CORE2_H__
#define __MAIN_CORE2_H__

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "Init_Struct.h"
#include "Commn.h"
#include "Extern_Core2.h"


int Sampling_freq;
int Stream_Type_frm_Core1;
int pre_dac_ptr_sync;
int addpredac_ptr_sync;

#define NOP asm("nop;");
#define NOP10 asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");

#endif /* __MAIN_CORE2_H__ */
