/*********************************************************************************
Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * SPORT_Global_Enable_I2S.h
 *****************************************************************************/

#ifndef __SPORT_GLOBAL_ENABLE_I2S_H__
#define __SPORT_GLOBAL_ENABLE_I2S_H__

/* Add your custom header content here */

#define DMA_BUF_SIZE            256u
#define DMA_NUM_DESC            4u
#define DMA_BYTES_PER_DESC      64u
#define DMA_MSIZE_IN_BYTES      4u

#define DMA_BUF_SIZE1            256u
#define DMA_NUM_DESC1            4u
#define DMA_BYTES_PER_DESC1      64u
#define DMA_MSIZE_IN_BYTES1      4u

#define SPORT_DEVICE_0 		0u
#define SPORT_DEVICE_1 		1u


#define SPORT_0A_SPU  			63
#define SPORT_0B_SPU  			64
#define SPORT_1A_SPU  			65
#define SPORT_1B_SPU  			66

#define REPORT_ERROR        printf
#define DEBUG_INFORMATION        printf

void SRU_init(void);

#define SUCCESS   0
#define FAILED   -1

#endif /* __SPORT_GLOBAL_ENABLE_I2S_H__ */
