/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Common_macros_extern_definations.h
*  Description      :   SPI Related variables can be included here
******************************************************************************/
#pragma default_section(ALLDATA,"Seg_SPI_Interrupt_Data")
#include "ProcInclude.h"
#include "SPI0_macros.h"
#include "SPI1_macros.h"
#include "Def_Struct.h"


#define BUFF_SIZE1	100
int Trans_value;
int Rx_Count;
int Tx_Count;
int Rx_Intr_count;
int RXSPI;
int TXSPI;
unsigned int SPI_Rx_BUFFER[BUFF_SIZE1];
unsigned int SPI_Tx_BUFFER[BUFF_SIZE1];




