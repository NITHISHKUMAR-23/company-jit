/*********************************************************************************
Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * SPORT_2D_DMA_Mode.h
 *****************************************************************************/

#ifndef __SPORT_2D_DMA_MODE_H__
#define __SPORT_2D_DMA_MODE_H__

/* Add your custom header content here */

/* select list mode/stop mode*/
#define ADI_CONFIG_2D_LIST_MODE 1

/* Configure the 2D-DMA parameters*/
#define SLOTS 16   /*2D-DMA XCNT - TDM time slots/channels*/
#define COUNT 128//128
#define YMOD -(ROWS*SLOTS*4-ROWS*4)+4
#define XMOD ROWS*4

#define DMA_BYTES_PER_DESC      COUNT/DMA_NUM_DESC
#define ROWS 					DMA_BYTES_PER_DESC/SLOTS    //2D-DMA  ROWS = YCNT

#if ADI_CONFIG_2D_LIST_MODE
#define DMA_NUM_DESC            4u
#else
#define DMA_NUM_DESC            1u
#endif

#define SPORT_DEV_0      		0u

#define REPORT_ERROR        	 printf
#define DEBUG_INFORMATION        printf

#define SPORT_0A_SPU  			63
#define SPORT_0B_SPU  			64

#define SUCCESS   0
#define FAILED   -1

#endif /* __SPORT_2D_DMA_MODE_H__ */
