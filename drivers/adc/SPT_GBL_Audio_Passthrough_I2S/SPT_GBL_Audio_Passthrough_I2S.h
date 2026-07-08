/*********************************************************************************
Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * SPT_GBL_Audio_Passthrough_I2S.h
 *****************************************************************************/

#ifndef __SPT_GBL_AUDIO_PASSTHROUGH_I2S_H__
#define __SPT_GBL_AUDIO_PASSTHROUGH_I2S_H__


/* Enable this macro for continuous audio */
#define ADI_CONFIG_CONTINUOUS_AUDIO		0


#define COUNT 200

#define SPORT_DEVICE_4A 			4u			/* SPORT device number */
#define SPORT_DEVICE_4B 			4u			/* SPORT device number */
#define TWIDEVNUM     				2u         /* TWI device number */

#define BITRATE       				(100u)      /* kHz */
#define DUTYCYCLE     				(50u)       /* percent */
#define PRESCALEVALUE 				(12u)       /* fSCLK/10MHz (112.5 sclk0_0) */
#define BUFFER_SIZE   				(8u)

#define TARGETADDR    				(0x38u)     /* hardware address */
#define TARGETADDR_1962    			(0x04u)     /* hardware address of adau1962 DAC */
#define TARGETADDR_1979    			(0x11u)     /* hardware address of adau1979 ADC */


#define SPORT_4A_SPU  					71
#define SPORT_4B_SPU   					72

#define DMA_NUM_DESC 				2u

#define SUCCESS   0
#define FAILED   -1

#define CHECK_RESULT(eResult) \
        if(eResult != 0)\
		{\
			return (1);\
        }

#define REPORT_ERROR        	 printf
#define DEBUG_INFORMATION        printf

#endif /* __SPT_GBL_AUDIO_PASSTHROUGH_I2S_H__ */
