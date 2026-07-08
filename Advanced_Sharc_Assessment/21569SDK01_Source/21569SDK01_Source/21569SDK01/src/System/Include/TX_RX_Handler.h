/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	TX_RX_Handler.h
*  Description      :
******************************************************************************/
#ifndef TX_RX_HANDLER_H_
#define TX_RX_HANDLER_H_


#include "..\src\system\Include\Commn.h"
#include "..\src\system\Include\Extern.h"
#include "..\src\system\Include\Def_Struct.h"

#include <services/dma/adi_dma.h>
#include <drivers\sport\adi_sport.h>


extern int TX_EXT_DMA_BUFFER[];
extern int *Next_dac_count;
extern int *predac_rd_ptr_c1;
extern ADI_DMA_STREAM_HANDLE   hMemDmaStream;

int Current_DMA_address = 0;
int *Reference_Start_Address;
int srcAddress;
int dstAddress;
int mdma_done = 0;
int EMDMA_START =0;
int EMDMA_MIPS = 0;
int dma_buff_size = 1024;
int counttransmitter;
int read_status = 0;
int curr_DMA_ptr_tx=0;
static bool bMemCopyInProgress = true;
int ReconfigCount = 0;

void receiver1(void);
void receiver2(void);
void transmitter(void);
void SET_TIMER(void);
void CALCULATE_MIPS(int*);


#endif  /*	TX_RX_HANDLER_H_  */
