/*********************************************************************************
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * SPDIF_Loopback.h
 *****************************************************************************/

#ifndef __SPDIF_LOOPBACK_H__
#define __SPDIF_LOOPBACK_H__

/* Add your custom header content here */

#include <stdlib.h>
/* Add your custom header content here */

#define SPDIF_OPTICAL_TEST


#define DMA_BUF_SIZE            256u
#define DMA_NUM_DESC            2u
#define DMA_WORDS_PER_DESC      128u
#define DMA_MSIZE_IN_BYTES      4u

#define SPORT_DEVICE_0A 0
#define SPORT_DEVICE_0B 0

#define divd 2

#define CHECK_RESULT(eResult) \
        if(eResult != 0)\
		{\
			return (1);\
        }

#define REPORT_ERROR        	printf
#define DEBUG_INFORMATION       printf

#define SPORT_0A_SPU  			63
#define SPORT_0B_SPU  			64

#define SUCCESS   0
#define FAILED   -1


#endif /* __SPDIF_LOOPBACK_H__ */
