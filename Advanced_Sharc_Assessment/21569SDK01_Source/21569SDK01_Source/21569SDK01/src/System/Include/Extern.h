/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Extern.h
*  Description      :   Extern variables & modules for framework & ISR can be included here
******************************************************************************/

#include "..\src\system\Include\Commn.h"
#include <drivers/asrc/adi_asrc.h>
#ifndef EXTERN_H_
#define EXTERN_H_


extern int PP_flag;

extern int PPflag;

extern int sync_detected;

extern int check;

extern int MSIZE;

extern int PSIZE;

extern int iEdge;
extern int gClock;
extern int SPDIF_Enable;

extern int lateFS;
extern int lowFS;
extern int dataIndFS;
extern int edgedetFS;
extern int FSR;

extern int LSBfirst;
extern int MSBfirst;
extern int dataType;
extern int packEnable;

extern int *predac_wr_ptr_c2;
extern int CustomAutoPCMZero;
extern int I2S_TDM_MODE;
extern int PP_process_cnt;

extern int InAutobuf[((INAUTOBUFSIZEBY2 * 4)+INAUTOBUFSIZEBY2)/4];


/**********************************************RECEIVER DMA BUFFER**********************************************/

extern int   RX_SP0A_BUFFER_LR0[COUNT_2CH];

extern int   RX_SP0A_BUFFER_LR1[COUNT_2CH];

extern int   RX_SP0B_BUFFER_CSW0[COUNT_2CH];

extern int   RX_SP0B_BUFFER_CSW1[COUNT_2CH];

extern int   RX_SP1A_BUFFER_LsRs0[COUNT_2CH];

extern int   RX_SP1A_BUFFER_LsRs1[COUNT_2CH];

extern int   RX_SP1B_BUFFER_LsrRsr0[COUNT_2CH];

extern int   RX_SP1B_BUFFER_LsrRsr1[COUNT_2CH];

/**********************************************TRANSMITTER DMA BUFFER**********************************************/

extern int  TX_SP4A_BUFFER_LCRSW0[COUNT_4CH];

extern int   TX_SP4A_BUFFER_LCRSW1[COUNT_4CH];

extern int   TX_SP4B_BUFFER_LsLsrRsRsr0[COUNT_4CH];

extern int   TX_SP4B_BUFFER_LsLsrRsRsr1[COUNT_4CH];

extern int   TX_SP3A_BUFFER_Addch1ch3ch2ch4_set0[COUNT_4CH];

extern int   TX_SP3B_BUFFER_Addch5ch7ch6ch8_set0[COUNT_4CH];

extern int   TX_SP3A_BUFFER_Addch1ch3ch2ch4_set1[COUNT_4CH];

extern int   TX_SP3B_BUFFER_Addch5ch7ch6ch8_set1[COUNT_4CH];

extern int   TX_SP3A_BUFFER_Addch1ch3Addch2ch4_set0[COUNT_4CH];

extern int   TX_SP3A_BUFFER_Addch1ch3Addch2ch4_set1[COUNT_4CH];

extern int   TX_SP3B_BUFFER_Addch5ch7Addch6ch8_set0[COUNT_4CH];

extern int   TX_SP3B_BUFFER_Addch5ch7Addch6ch8_set1[COUNT_4CH];


extern int   TX_SP2A_BUFFER_Addch9ch11Addch10ch12_set0[COUNT_4CH];  

extern int   TX_SP2A_BUFFER_Addch9ch11Addch10ch12_set1[COUNT_4CH];  



extern int   TX_SP5B_BUFFER_Addch13ch15Addch14ch16_set0[COUNT_4CH];  

extern int   TX_SP5B_BUFFER_Addch13ch15Addch14ch16_set1[COUNT_4CH];  

/*************************************************DECODER BUFFERS***********************************************/
extern int Pack_buffer_ext[PACK_BUFFER_MAX_SIZE];

extern int Predac_buffer_Ext[(1280*NUMMAXCHAN*FIVE_HALF)];

extern int TX_EXT_DMA_BUFFER[NO_OF_TX_SAMPLE_COUNT*NUMMAXCHAN];

extern int Intr_count;

/*************************************************Customer_PP BUFFERS***********************************************/
extern int CustPPInputList[20];

#ifdef FLOAT
extern float CustomerPP_Buffer[];
#else
extern int CustomerPP_Buffer[];
#endif

extern int CUSTOMER_PP_CHANNELS_CNT;
extern int PP_BUFF_MAX_SIZE_Var;
extern int PP_BUFF_MAX_SIZE_HALF_Var;
extern int TX_DAC_Output_Ch_Cnt;

extern int Prev_OutputSampleRate;

#ifdef SPDIF_ENABLE
extern int SPDIF_Enable;
extern int Prev_SPDIF_Enable;
extern int Spdif_I2S_Switch_Occured;

extern int Spdif_prev_sampling_frequency;
extern int Spdif_Input_fs_micro;
extern int Prev_Spdif_Rx_Fs;
extern int Lock_interrupt_occured;
extern int Spdif_Rx_Fs;
extern int Spdif_Rx_Div;
extern int spdif_status_valid_output_muted;
extern int Spdif_unlock_interrupt_occured;
extern int Spdif_Input_locked_DAC_Mute;
extern bool SPDIF_Input_locked;
extern int spdif_status_valid_output_muted;
extern int Spdif_Command_arg;
extern int SPDIF_testcount;

extern int Spdif_parameter1;
extern int Spdif_parameter2;
extern int Spdif_parameter3;
#endif
#ifdef ASRC_ENABLE
extern int ASRC_Enable;
extern int ASRC_Samplerate;
extern int FS_Div_Value;

extern ADI_ASRC_HANDLE  hAsrc0;
extern ADI_ASRC_HANDLE  hAsrc1;
extern ADI_ASRC_HANDLE  hAsrc2;
extern ADI_ASRC_HANDLE  hAsrc3;
extern ADI_ASRC_HANDLE  hAsrc4;
extern ADI_ASRC_HANDLE  hAsrc5;
extern ADI_ASRC_HANDLE  hAsrc6;
extern ADI_ASRC_HANDLE  hAsrc7;
#endif

#endif /* EXTERN_H_ */
