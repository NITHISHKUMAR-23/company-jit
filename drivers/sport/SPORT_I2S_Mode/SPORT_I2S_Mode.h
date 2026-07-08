/*********************************************************************************
Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * SPORT_I2S_Mode.h
 *****************************************************************************/

#ifndef __SPORT_I2S_MODE_H__
#define __SPORT_I2S_MODE_H__

/* Add your custom header content here */

#define DMA_BUF_SIZE            256u
#define DMA_NUM_DESC            4u
#define DMA_BYTES_PER_DESC      64u
#define DMA_MSIZE_IN_BYTES      4u

#define SPORT_DEV_0      		0u

#define REPORT_ERROR        	printf
#define DEBUG_INFORMATION       printf

#define SPORT_0A_SPU  			63
#define SPORT_0B_SPU  			64

#define SUCCESS   0
#define FAILED   -1


#endif /* __SPORT_I2S_MODE_H__ */
