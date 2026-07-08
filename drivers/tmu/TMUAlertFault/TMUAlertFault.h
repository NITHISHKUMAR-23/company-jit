/*********************************************************************************

Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/

/*****************************************************************************
 * TMUAlertFault.h
 *****************************************************************************/

#ifndef __TMUALERTFAULT_H__
#define __TMUALERTFAULT_H__

/* Add your custom header content here */
#include <sys/platform.h>
#include "adi_initialize.h"
#include <drivers/tmu/adi_tmu.h>
#include <services/tru/adi_tru.h>
#include <stdio.h>
#include <stdlib.h>

/*MACRO for reporting error message*/
#define REPORT_ERROR(msg)  \
		do{\
			printf(msg);\
			exit(1);\
		}while(0)

/*Initial delay for reading temperature**/
#define DELAY     (0xFFFFFFu)

/*Count variables for each condition*/
volatile uint32_t alertlo_cnt = 0;
volatile uint32_t alerthi_cnt = 0;
volatile uint32_t faulthi_cnt = 0;
volatile uint32_t faultlo_cnt = 0;

/*Count variables TRU interrupts*/
uint32_t TRU0_SLV0_Interrupt = 0;
uint32_t TRU0_SLV1_Interrupt = 0;

/* TMU Temperature value */
float TempC, TempF, TempC_Reset;

/*Event Limit values*/
ADI_TMU_EVENT_LIMIT    pEventLimit1 =
{
		10, /*alrtLimLo*/
		5,  /*fltLimLo*/
		70, /*alrtLimHi*/
		85  /*fltLimHi*/
};

#endif /* __TMUALERTFAULT_H__ */
