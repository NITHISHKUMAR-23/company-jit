/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	SPI2_AVR8_Fun.c
*  Description      :
*
******************************************************************************/
/******************************************************************************/
/*									Includes Header Files Section			  */
/******************************************************************************/
#include "../Include/SPI2_AVR8_def.h"
#include "../Include/Commn.h"

/******************************************************************************/
/*									Global Variables declarations			  */
/******************************************************************************/
section("seg_optical_data") uint16_t U16SPIBaud;
section("seg_optical_data") uint32_t Optical_Data;

/******************************************************************************
 *  Module Name        : SPI2_GPIO_Init
 *  Functionality      : GPIO ports Configuration for SPI2
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
section("seg_optical_code")
void SPI2_GPIO_Init(void)
{
	*pREG_PORTA_MUX &= ~(BITM_PORT_MUX_MUX0 | BITM_PORT_MUX_MUX1 | BITM_PORT_MUX_MUX4);

	/* PORTx_FER registers */
	*pREG_PORTA_FER_SET = (SPI2_CLK_PORTB_FER | SPI2_MOSI_PORTB_FER | SPI2_MISO_PORTB_FER);	//GPIO PORTB Configure as SPI Functionality

}

/******************************************************************************
 *  Module Name        : SH_SPI2_Master_Config
 *  Functionality      : Configured Sharc Processor as Master device through SPI2
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
section("seg_optical_code")
void SH_SPI2_Master_Config(void)
{
	U16SPIBaud = (uint16_t)(SYS_CLK / SPI_CLK) - 1;

	*pREG_SPI2_CLK = U16SPIBaud;	//2 MHz Frequency
	*pREG_SPI2_DLY = 0;//((1 << BITP_SPI_DLY_STOP) & BITM_SPI_DLY_STOP);

	//Configure SHARC as SPI Master

	*pREG_SPI2_CTL = (  ENUM_SPI_CTL_MASTER | ENUM_SPI_CTL_SIZE32 | ENUM_SPI_CTL_SCKBEG |
						ENUM_SPI_CTL_SCKLO | ENUM_SPI_CTL_MSB_FIRST | ENUM_SPI_CTL_SW_SSEL | ENUM_SPI_CTL_STMOSI);

	*pREG_SPI2_TXCTL = ENUM_SPI_TXCTL_TTI_EN | ENUM_SPI_TXCTL_TWC_EN | ENUM_SPI_TXCTL_ZERO;
	*pREG_SPI2_RXCTL |= ENUM_SPI_RXCTL_OVERWRITE;

 	*pREG_SPI2_TXCTL |= ENUM_SPI_TXCTL_TX_EN;           // Enable SPI Transmit
	*pREG_SPI2_CTL   |= ENUM_SPI_CTL_EN;			  //   Enable SPI Module(Start SPI Communication)

}

/******************************************************************************
 *  Module Name        : Optical_Write
 *  Functionality      : Write Data through SPI Protocol in Optical Module Registers
 *  Input Parameters   : U32Data
 *  Output Parameters  : None
 *****************************************************************************/
section("seg_optical_code")
void Optical_Write(uint32_t U32Data)
{
	U32Data = U32Data << 8;
	while(!(*pREG_SPI2_STAT & BITM_SPI_STAT_RFE));

	*pREG_SPI2_TWC = 0x01;         	 // 1 WORD = 4 bytes
	*pREG_SPI2_TFIFO = U32Data;    	//  command ID (24-Bit)

	while(!(*pREG_SPI2_STAT & BITM_SPI_STAT_TF));         // wait till completion

	*pREG_SPI2_STAT = BITM_SPI_STAT_TF;                  // clear latch
}

/******************************************************************************
 *  Module Name        : SPI_Disable
 *  Functionality      : Disable SPI Module Configure Pin
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
section("seg_optical_code")
void SPI_Disable(void)
{
	*pREG_SPI2_CTL = ENUM_SPI_CTL_DIS;		//   Disable SPI Module(Stop SPI Communication)
}

section("seg_optical_code")
void SPI_Delay(int i)
{
	int j=0;
	for(j=i; j > 0; --j)
		NOP1;
}
/******************************************************************************
 *  Module Name        : SPICS_Delay
 *  Functionality      : Delay for SPI Chip Select
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
section("seg_optical_code")
void SPICS_Delay(void)
{
	int temp_delay;
	for (temp_delay=0;temp_delay<17;temp_delay++)
	{
		NOP10;
		NOP1;
	}
}

/*	End of SPI2_AVR8_Fun.c	*/
