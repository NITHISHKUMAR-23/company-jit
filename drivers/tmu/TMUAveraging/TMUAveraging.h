/*********************************************************************************

Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/

/*****************************************************************************
 * TMUAveraging.h
 *****************************************************************************/

#ifndef __TMUAVERAGING_H__
#define __TMUAVERAGING_H__

/* Add your custom header content here */
#include <sys/platform.h>
#include "adi_initialize.h"
#include <drivers/tmu/adi_tmu.h>
#include <stdio.h>
#include <stdlib.h>

/*MACRO for reporting error message*/
#define REPORT_ERROR(msg)  \
		do{\
			printf(msg);\
			exit(1);\
		}while(0)


/*Perform Hardware Averaging*/
#define PERFORM_HARDWARE_AVERAGING

/*Perform Software Averaging*/
#define PERFORM_SOFTWARE_AVERAGING

/*Perform Software Averaging, blocked mechanism*/
#define PERFORM_SOFTWARE_AVERAGING_BLOCKED

/*Initial delay for reading TMU data*/
#define TMU_DELAY     (0xFFFFFu)

/*Buffer count for averaging*/
#define BUF_COUNT 5

/* TMU Temperature value */
float TempC, TempF;
float TempCAv[BUF_COUNT];
float Temp = 0;
uint32_t  pAverageBufCnt = 0;

#endif /* __TMUAVERAGING_H__ */
