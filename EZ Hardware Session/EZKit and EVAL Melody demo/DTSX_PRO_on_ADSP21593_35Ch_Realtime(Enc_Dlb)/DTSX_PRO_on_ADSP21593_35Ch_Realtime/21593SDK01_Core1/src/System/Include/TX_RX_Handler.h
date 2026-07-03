/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	TX_RX_Handler.h
*  Description      :   Transmitter and Receiver based Variables,functions declaration
******************************************************************************/
#ifndef TX_RX_HANDLER_H_
#define TX_RX_HANDLER_H_


#include "Commn.h"
#include "Extern_Core1.h"
#include <services/dma/adi_dma.h>
#include <drivers\sport\adi_sport.h>

#include "Def_Struct.h"
#pragma default_section(ALLDATA,"Seg_TX_RX_Handler_Data")

extern int TX_EXT_DMA_BUFFER[];
extern int *Next_dac_count;
extern int *predac_rd_ptr_c1;
extern ADI_DMA_STREAM_HANDLE   hMemDmaStream;

int Current_DMA_address = 0;
int *Reference_Start_Address;
int srcAddress;
int dstAddress;
int mdma_done = 0;
int Dma_Buff_Size = NO_OF_PREDAC_CHANNEL*NO_OF_TX_SAMPLE_COUNT;
int counttransmitter;
int curr_DMA_ptr_tx=0;
static bool bMemCopyInProgress = true;

#ifdef DOWNSAMPLING_DTSX
section("seg_dtsx_kernal_data")
int DTS_down_samp_C2_kernel_changes_set;
extern int *DTSX_DS_Enable;
extern int *Stream_sample_rate;
#endif //DOWNSAMPLING_DTSX

//#define MDMA_DEBUG  
#ifdef MDMA_DEBUG
int Tx_DMA_Wait_Cnt = 0;
#endif

void receiver1(void);
void receiver2(void);
void transmitter(void);
void SET_TIMER(void);
void CALCULATE_MIPS(int*);

#ifdef DTSX_LATENCY_CALC
section("seg_dtsx_Latency_data")
int DTSX_latency_cycles = 0;
section("seg_dtsx_Latency_data")
int *DTSX_latency_rd_ptr_temp;
extern int *DTSX_latency_state_frm_c2;
#endif

#endif  /*	TX_RX_HANDLER_H_  */
