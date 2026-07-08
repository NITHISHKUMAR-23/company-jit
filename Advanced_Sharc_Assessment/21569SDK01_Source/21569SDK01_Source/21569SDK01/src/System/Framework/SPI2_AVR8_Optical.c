/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	SPI2_AVR8_Optical.c
*  Description      :
*
******************************************************************************/
/******************************************************************************/
/*									Includes Header Files Section			  */
/******************************************************************************/
#include "..\Include\SPI2_AVR8_def.h"
#include "..\src\system\Include\sru21569.h"

#include <drivers\spi\adi_spi_2156x.h>

/* Driver memory required for SPI2 */
static uint8_t SPIMemory2[ADI_SPI_UNIDIR_MEMORY_SIZE];

/* SPI Handle */
ADI_SPI_HANDLE hSPISlave2;

/******************************************************************************/
/*									Global Variables declarations			  */
/******************************************************************************/

section("seg_optical_data") uint8_t Count;

section("seg_optical_data") uint32_t Optical_Cmds[] = {
				0x200100,
				0x200400,
				0x200460,
				0x200505,
				0x000000
};

/******************************************************************************
 *  Module Name        : SPI2_Init_DIT
 *  Functionality      :
 *  Input Parameters   : Fs
 *  Output Parameters  : None
 ******************************************************************************/
ADI_SPI_RESULT test;
section("seg_optical_code") void SPI2_Init_DIT(uint32_t Fs)
{
	SPI2_GPIO_Init();
	SH_SPI2_Master_Config();		//Configuration of SPI communication

	SPICS_Delay();

	Optical_Cmds[2] &= ~(0x03 << 0x04);
	Fs = (Fs >> 0x02);

	if(Fs == 0x00)		/* 1x Fs (32K, 44K1, 48K)*/
	{
		Fs = 0x02;
	}
	else if(Fs == 01)	/* 2x FS (64K, 88K2, 96K )*/
	{
		Fs = 0x00;
	}
	else
	{
		Fs = 0x03;		/*  4x Fs (128K, 176K4, 192K ) */
	}

	Optical_Cmds[2] |= (Fs << 0x04);

	SRU2(HIGH,DAI1_PBEN20_I);	//DAI1 Pin11 Enable For Chip Select

	for(Count = 0; Count < 5; ++Count)
	{
		SPI_Delay(10);
		SRU2(LOW,DAI1_PB20_I);

		Optical_Write(Optical_Cmds[Count]);

		SRU2(HIGH,DAI1_PB20_I);
//		SPI_Delay(30);
	}

	SPI_Delay(30);

	SPI_Disable();

}
/*	End of SPI2_AVR8_Optical.c File	*/
