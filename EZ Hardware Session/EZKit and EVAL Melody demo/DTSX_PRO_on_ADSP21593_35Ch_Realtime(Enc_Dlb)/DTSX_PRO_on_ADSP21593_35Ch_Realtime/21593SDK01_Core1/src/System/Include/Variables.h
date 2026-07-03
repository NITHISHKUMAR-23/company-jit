/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Variables.h
*  Description      :   Transmitter & Receiver DMA Buffer,Decoder Buffer Declaration and Initialization
******************************************************************************/
#ifndef VARIABLES_H_
#define VARIABLES_H_

#include "Commn.h"

section("Seg_Kernal_DataL3")
int No_of_Predac_Channel = NO_OF_PREDAC_CHANNEL;
/*PCG Related Variables*/
section("Seg_Kernal_DataL3")
int Prev_Clock_Div_Value;
section("Seg_Kernal_DataL3")
int Clock_Div_Value = MCLK_48KHZ;


section("Seg_Kernal_DataL3")
int *PACK_WR_PTR;
section("Seg_Kernal_DataL3")
int PP_flag = 1;

section("Seg_Kernal_DataL3")
int RX_receiver_Count=0;
section("Seg_Kernal_DataL3")
int check=0;
section("Seg_Kernal_DataL3")
int buff_zero=0;
section("Seg_Kernal_DataL3")
int DataValid;
section("Seg_Kernal_DataL3")
int SingleI2S_prev_b2;
section("Seg_Kernal_DataL3")
int flag_receiver2;

section("Seg_Kernal_DataL3")
int C_SW_Swap = 1;
/**********************************************RECEIVER DMA BUFFER**********************************************/



section("Seg_Rx_Dma_Bw")
int   RX_SP0A_BUFFER_LCRSW0[COUNT_4CH];
section("Seg_Rx_Dma_Bw")
int   RX_SP0A_BUFFER_LCRSW1[COUNT_4CH];
section("Seg_Rx_Dma_Bw")
int   RX_SP0B_BUFFER_LsLsrRsRsr0[COUNT_4CH];
section("Seg_Rx_Dma_Bw")
int   RX_SP0B_BUFFER_LsLsrRsRsr1[COUNT_4CH];


section("Seg_Rx_Dma_Bw")
int RX_Intermediate_BUFFER[COUNT_4CH*2];
/**********************************************TRANSMITTER DMA BUFFER**********************************************/

section("Seg_Tx_Dma_Bw")                           // L1 Memory Location
int  TX_SP4A_BUFFER_LCRSW0[COUNT_4CH];
section("Seg_Tx_Dma_Bw")                           // L1 Memory Location
int  TX_SP4A_BUFFER_LCRSW1[COUNT_4CH];

section("Seg_Tx_Dma_Bw")                           // L1 Memory Location
int   TX_SP4B_BUFFER_LsLsrRsRsr0[COUNT_4CH];
section("Seg_Tx_Dma_Bw")                           // L1 Memory Location
int   TX_SP4B_BUFFER_LsLsrRsRsr1[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP3A_BUFFER_ch9ch11ch10ch12_set0[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP3A_BUFFER_ch9ch11ch10ch12_set1[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP3B_BUFFER_ch13ch15ch14ch16_set0[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP3B_BUFFER_ch13ch15ch14ch16_set1[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP6A_BUFFER_ch17ch19ch18ch20_set0[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP6A_BUFFER_ch17ch19ch18ch20_set1[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP2A_BUFFER_ch21ch23ch22ch24_set0[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP2A_BUFFER_ch21ch23ch22ch24_set1[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP6B_BUFFER_ch25ch27ch26ch28_set0[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP6B_BUFFER_ch25ch27ch26ch28_set1[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP7A_BUFFER_ch29ch31ch30ch32_set0[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP7A_BUFFER_ch29ch31ch30ch32_set1[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP2B_BUFFER_ch33ch35ch34ch36_set0[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP2B_BUFFER_ch33ch35ch34ch36_set1[COUNT_4CH];


section("Seg_Tx_Dma_Bw")
int   TX_SP2B_BUFFER_ch37ch39ch38ch40_set0[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_SP2B_BUFFER_ch37ch39ch38ch40_set1[COUNT_4CH];

section("Seg_Tx_Dma_Bw")
int   TX_EXT_DMA_BUFFER[NO_OF_TX_SAMPLE_COUNT * NUMMAXCHAN];

/*************************************************DECODER BUFFERS***********************************************/

section("Seg_Pack_Bw")
int Pack_buffer_ext[PACK_BUFFER_MAX_SIZE];
#ifdef DTSX_DECODER
section("Seg_Predac_Bw")
int Predac_buffer_Ext[(1280*NUMMAXCHAN*FIVE_HALF)];
section("Seg_Predac_Bw")
int AddPredac_buffer_ext[36864];
#else 
section("Seg_Predac_Bw")
int Predac_buffer_Ext[(256*NUMMAXCHAN*THREE_HALF)];
#endif // DTSX_DECODER
section("Seg_Internal_Predac")
int Predac_buffer_Int[NO_OF_SAMPLE_PROCESSING*PREDAC_INT_NUMCHAN];

section("Seg_Predac_Bw")
int Intr_count = INVALID;

section("Seg_Kernal_DataL3")
int BufSize = NO_OF_SAMPLE_PROCESSING*NUMMAXCHAN;

#endif /* VARIABLES_H_ */
