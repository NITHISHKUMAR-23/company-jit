/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	SPI_Interrupts.c
*  Description      :   SPI
*
******************************************************************************/
#pragma default_section(CODE,"Seg_SPI_Interrupt_Code")
#include "..\src\system\Include\Common_macros__extern_definations.h"
#include <services\int\adi_sec.h>
#include "adi_initialize.h"
#include <drivers/spi/adi_spi_2156x.h>

int Trans_value;// = 0xA5A5A5A5;
int Rx_Count;
int Tx_Count;
int Rx_Intr_count;

#pragma section("seg_kernal_data")
int RXSPI;
#pragma section("seg_kernal_data")
int TXSPI;
extern  ADI_PDMA_DESC_LIST  Src_List;
extern  ADI_PDMA_DESC_LIST  Dest_List;
extern ADI_SPI_HANDLE hSPISlave;

unsigned int SPI0_Rx_BUFFER[BUFF_SIZE1];
unsigned int SPI0_Tx_BUFFER[BUFF_SIZE1];

/******************************************************************************
*  Module Name        : SPI0_RxCore_Handler
*  Functionality      : This handler receives user commands i.e. PLAY, STOP, Decoder Configure.
*  Input Parameters	  : handlerArg
*  Output Parameters  : None
******************************************************************************/
void SPI0_RxCore_Handler (uint32_t iid, void *handlerArg)
{

#if SPI0_REN
	uint32_t Event = handlerArg;

	if(Event==ADI_SPI_EVENT_TX_PROCESSED)
	{
		return;
	}
	if(Event!=ADI_SPI_EVENT_RX_PROCESSED)
	{
		adi_spi_StopDMA(hSPISlave);
		/* Start SPI RX transfers to start recieving the commands one by one from the host */
		ReInit_SPI0();
		return;
	}
	SPI0_Rx_BUFFER[Rx_Count++] = RXSPI;
	SPIReceive();
	Rx_Intr_count++;
	if(Rx_Count >= BUFF_SIZE1)
	{
		Rx_Count = 0;
	}
	SPI0_Tx_BUFFER[Tx_Count++] = TXSPI;
	if(Tx_Count >= BUFF_SIZE1)
	{
		Tx_Count = 0;
	}

	*pREG_TRU0_MTR=68;  //cpas=0 purpose
	//eSPIResult = adi_spi_DMAWrite(hSPISlave, &Src_List, 1, ADI_PDMA_STOP_MODE);

#endif
}

/******************************************************************************
*  Module Name        : Init_PORTs
*  Functionality      : Configured Ports for Serial Peripheral interface lines
*  						MISO, MOSI, CLOCK, CS
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/
void Init_PORTs(void)
{
	int TempValue;

#if defined(__ADSP21569_FAMILY__)
    *pREG_PORTA_FER_SET = BITM_PORT_FER_PX12;

    TempValue = *pREG_PORTA_MUX;
    TempValue &=~BITM_PORT_MUX_MUX12;
    *pREG_PORTA_MUX = TempValue;
#else
    *pREG_PORTE_FER_SET = BITM_PORT_FER_PX13;

   TempValue = *pREG_PORTE_MUX;
   TempValue |=0x4000000;
   *pREG_PORTE_MUX = TempValue;
#endif

}
