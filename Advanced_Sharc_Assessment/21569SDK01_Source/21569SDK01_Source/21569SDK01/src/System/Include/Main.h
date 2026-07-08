/***************************************************************************
*
*  (C)Copyright Analog Devices Inc., India.
*  All rights reserved. Reproduction in whole or part is prohibited without
*  the written permission of the copyright owner.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Main.h
*  Description      :   All the global variables for framework can be included here
******************************************************************************/

#ifndef __GUL_ADC_DAC_CODES_H__
#define __GUL_ADC_DAC_CODES_H__

/* Add your custom header content here */
#include <stdint.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include "Init_Struct.h"
#include <stdio.h>
#include <math.h>
#include "Codeid.h"
#include "HostDefines.h"
#include <cdef21569.h>
#include "sru21569.h"
#include <sys/cache.h>
#include "Adr_Lkup_Tab_Macros.h"
#include "Commn.h"
#include "Variables.h"
#include "Extern.h"
#include "Function_Prototype.h"
#include "..\src\system\Include\Common_macros__extern_definations.h"
#include <drivers\sport\adi_sport.h>
#include <drivers/spdif/adi_spdif_rx_v1.h>
#include <services/dma/adi_dma.h>

/******************************************************************************
 * Global Variables Extern Section
 *****************************************************************************/

int I2S_TDM_MODE = I2S_MODE;
int prev_I2S_TDM_Mode = I2S_MODE;
extern int down_samp_flag;
extern int while_testcount;

int CUSTOMER_PP_CHANNELS_CNT = 0;
int PP_BUFF_MAX_SIZE_Var = 0;
int PP_BUFF_MAX_SIZE_HALF_Var = 0;
void TX_DAC_Channel_check();

extern ADI_SPDIF_RX_HANDLE hSpdifRx;
extern ADI_SPORT_HANDLE hSPORT5ARx;
extern ADI_SPORT_HANDLE hSPORT0ARx;
extern ADI_SPORT_HANDLE hSPORT0BRx;
extern ADI_SPORT_HANDLE hSPORT1ARx;
extern ADI_SPORT_HANDLE hSPORT1BRx;

extern ADI_SPORT_HANDLE hSPORT4ATx;
extern ADI_SPORT_HANDLE hSPORT4BTx;
extern ADI_SPORT_HANDLE hSPORT3ATx;
extern ADI_SPORT_HANDLE hSPORT3BTx;


extern ADI_SPORT_HANDLE hSPORT2ATx;  

extern ADI_SPORT_HANDLE hSPORT5BTx;  



ADI_SPORT_RESULT Result;
extern ADI_DMA_STREAM_HANDLE   hMemDmaStream;
extern ADI_DMA_STREAM_HANDLE   hMemDmaStream1;
extern int mdma_done;
extern int ReconfigCount;

extern ADI_GLOBAL_SPORT_HANDLE hDai1Group0Tx;
extern ADI_GLOBAL_SPORT_HANDLE hDai0Group0Tx;
extern ADI_GLOBAL_SPORT_HANDLE hDai0Group1Rx;
extern ADI_GLOBAL_SPORT_HANDLE hDai1Group1Rx;
int TX_DAC_Output_Ch_Cnt  = 1;  // 3 for TWENTYFOUR_CHANNEL, 2 for EIGHTEEN_CHANNEL, 1 for SIXTEEN_CHANNEL


#endif /* __GRIFFIN_ULTRA_LITE__H__ */
