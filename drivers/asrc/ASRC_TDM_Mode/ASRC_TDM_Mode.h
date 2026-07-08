/*********************************************************************************
Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * ASRC_TDM_Mode.h
 *****************************************************************************/

#ifndef __ASRC_TDM_MODE_H__
#define __ASRC_TDM_MODE_H__

/* Add your custom header content here */

#define TDM_CHANNELS 8     /* If this macro is changed, the corresponding SRU routing must be changed to incorporate the appropriate Daisy Chaining */

#define CHANNEL_BUFF_SIZE       (128) /* Buffer Size */
#define UPCONVERSION            (0)    /* 1- Upconversion,0 - Downconversion */
#define RATIO                   (2)    /* Ratio of Higher Fs to Lower Fs. Always > 0 and an integer . This ratio will be interpreted and used
                                          by the example depending on UPCONVERSION macro configuration */

#if (UPCONVERSION == 1)
#define OUTPUT_PCG_CLOCK_DIV    (32u)
#elif (UPCONVERSION == 0)
#define INPUT_PCG_CLOCK_DIV     (32u)
#else
#error "UPCONVERSION macro incorrectly configured"
#endif

int   InputBuffer[CHANNEL_BUFF_SIZE*TDM_CHANNELS];

int   OutputBuffer[CHANNEL_BUFF_SIZE*TDM_CHANNELS];

#define REPORT_ERROR        	printf
#define DEBUG_INFORMATION       printf

#define SPORT_0A_SPU  			63
#define SPORT_0B_SPU  			64

#define SUCCESS   0
#define FAILED   -1

#endif /* __ASRC_TDM_MODE_H__ */
