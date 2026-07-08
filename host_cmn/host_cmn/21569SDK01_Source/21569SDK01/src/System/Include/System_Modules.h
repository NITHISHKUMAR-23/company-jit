/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	System_Modules.h
*  Description      :
******************************************************************************/

#ifndef SYSTEM_INCLUDE_SYSTEM_MODULES_H_
#define SYSTEM_INCLUDE_SYSTEM_MODULES_H_

#include "Commn.h"
#include "Extern.h"
#include <math.h>
#include <stdio.h>
#include "HostDefines.h"
#include "Codeid.h"
#include "Def_struct.h"
#include "Adr_Lkup_Tab_Macros.h"

#include <services/pcg/adi_pcg.h>


/**************************************************************************************************
 *			Global Functions Prototype Section
 *************************************************************************************************/
void AllocateMemoryKernel(void);
void Free_AllotMemoryPackDac(int,int,int);
void AllocateMemoryPCMDelay(int);
void SRU_Reconfigure(int sample_fs_micro,int Output_SampleRate);

int *TX_SP4A_BUFFER_LCRSW0_BUF;
int *TX_SP4A_BUFFER_LsLsrRsRsr0_BUF;
int *TX_SP3A_BUFFER_Addch1ch3Addch2ch4_set0_BUF;
int *TX_SP3A_BUFFER_Addch5ch7Addch6ch8_set0_BUF;

int *TX_SP3A_BUFFER_Addch1ch3ch2ch4_set0_BUF;

int *TX_SP3B_BUFFER_Addch5ch7ch6ch8_set0_BUF;

int *TX_SP3A_BUFFER_Addch1ch3ch2ch4_set1_BUF;

int *TX_SP3B_BUFFER_Addch5ch7ch6ch8_set1_BUF;


#endif /* SYSTEM_INCLUDE_SYSTEM_MODULES_H_ */
