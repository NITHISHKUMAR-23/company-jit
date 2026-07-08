/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Variables.h
*  Description      :
******************************************************************************/
#define VARIABLES_H_

#include "Commn.h"
#include "..\src\system\Include\Commn.h"
/************************************Decoder*************************************/
int CustPPInputList[20];

/**********************************Main*******************************************/
int BufSize = NO_OF_SAMPLE_PROCESSING*NUMMAXCHAN;
int SrcBuf,DstBuf,BufSize_remain;
int mdma3_done = 0;

int FLOW;
int MSIZE = 2;
int PSIZE = 2;

section("seg_ex_ds_bw")
int *PACK_WR_PTR;
section("seg_ex_ds_bw")
int PP_flag = 1;

int iEdge=1;
int gClock;

int lateFS;
int lowFS = 1;
int dataIndFS = 0;
int edgedetFS = 1;
int FSR;

int LSBfirst = 0;
int MSBfirst = 0;
int dataType = 0;
int packEnable;

int autodet = 0;
int previous_Auto_detection_mode = 0xF;
int count = 0;
int SPT_REINT_FLG;
int FSTemp_sptr;

int count, c = 0, *Sdram_buffer_ptr, k = 0,nz = 0, index = 0;
int curcount1, curcount2, curcount3, curcount4;


section("seg_ex_ds_bw")
int RX_receiver_Count=0;
section("seg_ex_ds_bw")
int sync_detected=0;
section("seg_ex_ds_bw")
int check=0;
section("seg_ex_ds_bw")
int buff_zero=0;
section("seg_ex_ds_bw")
int DataValid;
section("seg_ex_ds_bw")
int SingleI2S_prev_b2;
section("seg_ex_ds_bw")
int flag_receiver2;
section("seg_ex_ds_bw")
int Read_count = 0;
int PPflag = 1;

/************************INTERMEDIATE BUFFER FOR COPYTING DATA FROM DMA BUFFER TO DECODER**********************/
section("seg_dmda_nw")
int InAutobuf[((INAUTOBUFSIZEBY2 * 4)+INAUTOBUFSIZEBY2)/4];
section("seg_dmda_nw")
int save_buffer[INAUTOBUFSIZEBY2*4];

/**********************************************RECEIVER DMA BUFFER**********************************************/

section("seg_rx_dma_bw")
int   RX_SP0A_BUFFER_LR0[COUNT_2CH];
section("seg_rx_dma_bw")
int   RX_SP0A_BUFFER_LR1[COUNT_2CH];

#ifdef MULTI_INPUT

section("seg_rx_dma_bw")
int   RX_SP0B_BUFFER_CSW0[COUNT_2CH];
section("seg_rx_dma_bw")
int   RX_SP0B_BUFFER_CSW1[COUNT_2CH];
section("seg_rx_dma_bw")
int   RX_SP1A_BUFFER_LsRs0[COUNT_2CH];
section("seg_rx_dma_bw")
int   RX_SP1A_BUFFER_LsRs1[COUNT_2CH];
section("seg_rx_dma_bw")
int   RX_SP1B_BUFFER_LsrRsr0[COUNT_2CH];
section("seg_rx_dma_bw")
int   RX_SP1B_BUFFER_LsrRsr1[COUNT_2CH];
#endif

/**********************************************TRANSMITTER DMA BUFFER**********************************************/

section("seg_tx_dma_bw")  // L1 Memory Location
int  TX_SP4A_BUFFER_LCRSW0[COUNT_4CH];
section("seg_tx_dma_bw") // L1 Memory Location
int  TX_SP4A_BUFFER_LCRSW1[COUNT_4CH];

section("seg_tx_dma_bw") // L1 Memory Location
int   TX_SP4B_BUFFER_LsLsrRsRsr0[COUNT_4CH];
section("seg_tx_dma_bw") // L1 Memory Location
int   TX_SP4B_BUFFER_LsLsrRsRsr1[COUNT_4CH];



section("seg_tx_dma_bw")
int   TX_SP3A_BUFFER_Addch1ch3Addch2ch4_set0[COUNT_4CH];

section("seg_tx_dma_bw")
int   TX_SP3A_BUFFER_Addch1ch3Addch2ch4_set1[COUNT_4CH];


section("seg_tx_dma_bw")
int   TX_SP3B_BUFFER_Addch5ch7Addch6ch8_set0[COUNT_4CH];  

section("seg_tx_dma_bw")
int   TX_SP3B_BUFFER_Addch5ch7Addch6ch8_set1[COUNT_4CH]; 



section("seg_tx_dma_bw")
int   TX_SP2A_BUFFER_Addch9ch11Addch10ch12_set0[COUNT_4CH];  

section("seg_tx_dma_bw")
int   TX_SP2A_BUFFER_Addch9ch11Addch10ch12_set1[COUNT_4CH]; 



section("seg_tx_dma_bw")
int   TX_SP5B_BUFFER_Addch13ch15Addch14ch16_set0[COUNT_4CH]; 

section("seg_tx_dma_bw")
int   TX_SP5B_BUFFER_Addch13ch15Addch14ch16_set1[COUNT_4CH]; 


section("seg_tx_dma_bw")
int   TX_EXT_DMA_BUFFER[NO_OF_TX_SAMPLE_COUNT * NUMMAXCHAN];

/*************************************************DECODER BUFFERS***********************************************/

section("seg_pack_bw")
int Pack_buffer_ext[PACK_BUFFER_MAX_SIZE];

section("seg_predac_bw")
int Predac_buffer_Ext[(1280*NUMMAXCHAN*FIVE_HALF)];

section("seg_Internal_Predac")
int Predac_buffer_Int[NO_OF_SAMPLE_PROCESSING*NUMMAXCHAN];

section("seg_Internal_Lib")
int Internal_Library_memory[16380];


section("seg_predac_bw")
int Intr_count = INVALID;

#ifdef SPDIF_ENABLE
section("seg_spdif_data")
int SPDIF_Enable = 0;
section("seg_spdif_data")
int Prev_SPDIF_Enable = 0;
section("seg_spdif_data")
int Spdif_prev_sampling_frequency = -1;
section("seg_spdif_data")
int Spdif_Input_fs_micro = 2;
section("seg_spdif_data")
int Spdif_Rx_Fs;
section("seg_spdif_data")
int Prev_Spdif_Rx_Fs;
section("seg_spdif_data")
bool SPDIF_Input_locked;
section("seg_spdif_data")
int Spdif_Rx_Div = 0;
section("seg_spdif_data")
int Spdif_I2S_Switch_Occured = 1;
section("seg_spdif_data")
int Spdif_Input_locked_DAC_Mute = 0;
section("seg_spdif_data")
int Spdif_unlock_interrupt_occured = 0;
section("seg_spdif_data")
int SPDIF_testcount = 1000000;
section("seg_spdif_data")
int Spdif_Command_arg = 0;
section("seg_spdif_data")
int spdif_status_valid_output_muted = 0;

section("seg_spdif_data")
int Spdif_fs_table[12] = {32000,44100,48000,0,0,88200,96000,0,0,176400,192000};

section("seg_spdif_data")
int Spdif_parameter1;
section("seg_spdif_data")
int Spdif_parameter2;
section("seg_spdif_data")
int Spdif_parameter3;
#endif
#ifdef ASRC_ENABLE
int ASRC_Enable;
int ASRC_Samplerate;
int FS_Div_Value;
#endif
