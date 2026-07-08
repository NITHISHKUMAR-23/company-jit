/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	SPI2_AVR8_def.h
*  Description      :
******************************************************************************/
#ifndef SYSTEM_INCLUDE_SPI2_AVR8_DEF_H_
#define SYSTEM_INCLUDE_SPI2_AVR8_DEF_H_

/**************************************************************************************************/
/*									Includes Header Files Section								  */
/**************************************************************************************************/
#include "ProcInclude.h"

/**************************************************************************************************/
/*									Define Macros Section										  */
/**************************************************************************************************/

#define SPI_CLK 		(0x2)	 	//2 Mhz
#define SYS_CLK 	 	(100000000)		//100 Mhz

#define SPI2_CLK_PORTB_FER  ((uint32_t) ((uint32_t) 1<<0x04))
#define SPI2_MISO_PORTB_FER  ((uint32_t) ((uint32_t) 1<<0x00))
#define SPI2_MOSI_PORTB_FER  ((uint32_t) ((uint32_t) 1<<0x01))


/**************************************************************************************************/
/*									User Functions Declaration									  */
/**************************************************************************************************/

void SPI2_GPIO_Init(void);
void SH_SPI2_Master_Config(void);
void Optical_Write(uint32_t );
void SPI_Disable(void);
void SPI_Delay(int i);
void SPICS_Delay(void);

void SPI2_Init_DIT(uint32_t Fs);

#endif /* SYSTEM_INCLUDE_SPI2_AVR8_DEF_H_ */
