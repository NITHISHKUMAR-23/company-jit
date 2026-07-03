/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	System_Modules.h
*  Description      :   Sampling frequency,MCLK Related Initialization
******************************************************************************/
#ifndef SYSTEM_INCLUDE_SYSTEM_MODULES_H_
#define SYSTEM_INCLUDE_SYSTEM_MODULES_H_

#include "Commn.h"
#include "Extern_Core1.h"
#include <math.h>
#include <stdio.h>
#include "HostDefines.h"
#include "Codeid.h"
#include <services/pcg/adi_pcg.h>
#include "Def_Struct.h"

section("Seg_System_Init_Data")
int Freq_Table_SRU[11] = {48000,48000,48000,0,0,96000,96000,0,0,192000,192000};


#ifdef eARC_ENABLE
	extern int eARC_Mode;
	extern int eARC_Clock_Ratio;
#endif
section("Seg_System_Init_Data")
	int Mclk_192Khz = MCLK_192KHZ;
section("Seg_System_Init_Data")
	int Mclk_96Khz = MCLK_96KHZ;
section("Seg_System_Init_Data")
	int Mclk_48Khz = MCLK_48KHZ;

int *TX_SP4A_BUFFER_LCRSW0_BUF;
int *TX_SP4A_BUFFER_LsLsrRsRsr0_BUF;
int *TX_SP3A_BUFFER_ch9ch11ch10ch12_set0_BUF;
int *TX_SP3A_BUFFER_ch13ch15ch14ch16_set0_BUF;
int *TX_SP6A_BUFFER_ch17ch19ch18ch20_set0_BUF;
int *TX_SP6A_BUFFER_ch21ch23ch22ch24_set0_BUF;
int *TX_SP6B_BUFFER_ch25ch27ch26ch28_set0_BUF;
int *TX_SP6B_BUFFER_ch29ch31ch30ch32_set0_BUF;
int *TX_SP2B_BUFFER_ch33ch35ch34ch36_set0_BUF;
int *TX_SP2B_BUFFER_ch37ch39ch38ch40_set0_BUF;

#endif /* SYSTEM_INCLUDE_SYSTEM_MODULES_H_ */
