/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Main_Core1.h
*  Description      :   Global variable Declaration
******************************************************************************/

#ifndef __MAIN_CORE1_H__
#define __MAIN_CORE1_H__

/* Add your custom header content here */
#include <stdint.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include <stdio.h>
#include <cdef21593.h>
#include "Init_Struct.h"
#include <sys/cache.h>
#include <drivers\sport\adi_sport.h>

#include <services/dma/adi_dma.h>

#include <math.h>
#include "Codeid.h"
#include "HostDefines.h"
#include "Commn.h"
#include "Variables.h"
#include "Function_Prototype.h"
#include "Extern_Core1.h"
#pragma default_section(ALLDATA,"Seg_Kernal_DataL3")

int SPI_Device = SPI_DEVICE;
int I2S_TDM_MODE = I2S_MODE;
int prev_I2S_TDM_Mode = I2S_MODE;

#ifdef eARC_ENABLE
	int eARC_Mode = 0;
	int eARC_Clock_Ratio = 128;
#endif

int PcmZeroCountMax=96000;

#ifdef DOWNSAMPLING
extern int down_samp_flag;
extern int Previous_DS_Mode;
extern int DnSamp192to48;
extern int down_samp_flag_cmd;
#endif //DOWNSAMPLING
#endif /* __MAIN_CORE1__H__ */
