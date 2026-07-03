/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Extern_Core1.h
*  Description      :   Extern variables & modules for framework & ISR can be included here
******************************************************************************/
#ifndef EXTERN_CORE1_H_
#define EXTERN_CORE1_H_

#include "commn.h"
#include <services/dma/adi_dma.h>
extern int BufSize;
extern int Predac_buffer_Int[];
extern int prev_channel_count;
extern ADI_DMA_STREAM_HANDLE   hMemDmaStream1;

extern int PP_flag;

extern int check;

extern int dataType;

extern int *predac_wr_ptr_c2;


#pragma word_addressed
extern int InAutobuf[(((INAUTOBUFSIZEBY2 * 4)+INAUTOBUFSIZEBY2)/4)*4];
#pragma word_addressed
extern int Spi_size[SPI_BUFFER_SIZE*4];

extern int Prev_Clock_Div_Value;
extern int Clock_Div_Value;
extern int PCG_Sample_ratio;

extern int Freq_Table[];
/**********************************************RECEIVER DMA BUFFER**********************************************/



extern int   RX_SP0A_BUFFER_LCRSW0[COUNT_4CH];

extern int   RX_SP0A_BUFFER_LCRSW1[COUNT_4CH];

extern int   RX_SP0B_BUFFER_LsLsrRsRsr0[COUNT_4CH];

extern int   RX_SP0B_BUFFER_LsLsrRsRsr1[COUNT_4CH];

extern int RX_Intermediate_BUFFER[COUNT_4CH*2];
/**********************************************TRANSMITTER DMA BUFFER**********************************************/

extern int   TX_SP4A_BUFFER_LCRSW0[COUNT_4CH];

extern int   TX_SP4A_BUFFER_LCRSW1[COUNT_4CH];

extern int   TX_SP4B_BUFFER_LsLsrRsRsr0[COUNT_4CH];

extern int   TX_SP4B_BUFFER_LsLsrRsRsr1[COUNT_4CH];

extern int   TX_SP3A_BUFFER_ch9ch11ch10ch12_set0[COUNT_4CH];

extern int   TX_SP3A_BUFFER_ch9ch11ch10ch12_set1[COUNT_4CH];

extern int   TX_SP3B_BUFFER_ch13ch15ch14ch16_set0[COUNT_4CH];

extern int   TX_SP3B_BUFFER_ch13ch15ch14ch16_set1[COUNT_4CH];

extern int   TX_SP6A_BUFFER_ch17ch19ch18ch20_set0[COUNT_4CH];

extern int   TX_SP6A_BUFFER_ch17ch19ch18ch20_set1[COUNT_4CH];

extern int   TX_SP2A_BUFFER_ch21ch23ch22ch24_set0[COUNT_4CH];

extern int   TX_SP2A_BUFFER_ch21ch23ch22ch24_set1[COUNT_4CH];

extern int   TX_SP6B_BUFFER_ch25ch27ch26ch28_set0[COUNT_4CH];

extern int   TX_SP6B_BUFFER_ch25ch27ch26ch28_set1[COUNT_4CH];

extern int   TX_SP7A_BUFFER_ch29ch31ch30ch32_set0[COUNT_4CH];

extern int   TX_SP7A_BUFFER_ch29ch31ch30ch32_set1[COUNT_4CH];

extern int   TX_SP2B_BUFFER_ch33ch35ch34ch36_set0[COUNT_4CH];

extern int   TX_SP2B_BUFFER_ch33ch35ch34ch36_set1[COUNT_4CH];

extern int    TX_SP2B_BUFFER_ch37ch39ch38ch40_set0[COUNT_4CH];

extern int    TX_SP2B_BUFFER_ch37ch39ch38ch40_set1[COUNT_4CH];

/*************************************************DECODER BUFFERS***********************************************/
extern int Pack_buffer_ext[PACK_BUFFER_MAX_SIZE];
#ifdef DTSX_DECODER
extern int Predac_buffer_Ext[(1280*NUMMAXCHAN*FIVE_HALF)];
extern int AddPredac_buffer_ext[];
#else 
extern int Predac_buffer_Ext[(256*NUMMAXCHAN*THREE_HALF)];
#endif //DTSX_DECODER
extern int TX_EXT_DMA_BUFFER[NO_OF_TX_SAMPLE_COUNT*NUMMAXCHAN];

extern int Intr_count;




extern int Prev_OutputSampleRate;
extern int *datacanbeprocessnow;
extern int *core2_dcpn_done;
extern int	*Predac_length;
extern int	*predac_heap;
extern int	*predac_wr_ptr;
extern int	*Latency_predac_wr_ptr_c1;
extern int	*Init_Start_Command_c1;

extern int	*addpredac_heap;
extern int	*addpredac_wr_ptr;
extern int	*addpredac_rd_ptr;
extern int	*addpredac_length;


extern int down_samp_flag;
extern int down_samp_flag_cmd;
extern int DnSamp192to48;


extern int *run_flag;
extern int *PARAMETER_1_C2;
extern int *PARAMETER_2_C2;
extern int *PARAMETER_3_C2;
extern int *PARAMETER_4_C2;
extern int *PARAMETER_5_C2;
extern int *PARAMETER_6_C2;
extern int *PARAMETER_7_C2;
extern int *PARAMETER_8_C2;
extern int *PARAMETER_9_C2;
extern int *PARAMETER_10_C2;
extern int *PARAMETER_11_C2;
extern int *PARAMETER_12_C2;
extern int *PARAMETER_13_C2;
extern int *PARAMETER_14_C2;
extern int *PARAMETER_15_C2;
extern int *PARAMETER_16_C2;
extern int *PARAMETER_17_C2;
extern int *PARAMETER_18_C2;
extern int *PARAMETER_19_C2;
extern int *PARAMETER_20_C2;
extern int *PARAMETER_21_C2;
extern int *PARAMETER_22_C2;
extern int *PARAMETER_23_C2;
extern int *PARAMETER_24_C2;
extern int *PARAMETER_25_C2;
extern int *PARAMETER_26_C2;
extern int *PARAMETER_27_C2;
extern int *PARAMETER_28_C2;
extern int *PARAMETER_29_C2;
extern int *PARAMETER_30_C2;
extern int *PARAMETER_31_C2;

extern int *ChanReorder_AssignLines_1_6;
extern int *ChanReorder_AssignLines_7_12;
extern int *ChanReorder_AssignLines_13_16;

extern int *COMMAND_BYTE_C2;
extern int *core2_command_processing_status_done;

extern int TMU_Enable;
extern int SPI_Device;
extern int *testing_36_ch;
extern int *Ch36_Enable;
#ifdef OPTICAL_TESTING
extern int *optical_test;
#endif // OPTICAL_TESTING
extern int Mclk_192Khz;
extern int Mclk_96Khz;
extern int Mclk_48Khz;

extern int I2S_TDM_MODE;
extern int prev_I2S_TDM_Mode;

extern int *TX_SP4A_BUFFER_LCRSW0_BUF;
extern int *TX_SP4A_BUFFER_LsLsrRsRsr0_BUF;
extern int *TX_SP3A_BUFFER_ch9ch11ch10ch12_set0_BUF;
extern int *TX_SP3A_BUFFER_ch13ch15ch14ch16_set0_BUF;
extern int *TX_SP6A_BUFFER_ch17ch19ch18ch20_set0_BUF;
extern int *TX_SP6A_BUFFER_ch21ch23ch22ch24_set0_BUF;
extern int *TX_SP6B_BUFFER_ch25ch27ch26ch28_set0_BUF;
extern int *TX_SP6B_BUFFER_ch29ch31ch30ch32_set0_BUF;
extern int *TX_SP2B_BUFFER_ch33ch35ch34ch36_set0_BUF;
extern int *TX_SP2B_BUFFER_ch37ch39ch38ch40_set0_BUF;
extern int C_SW_Swap;

#ifdef DTSX_DECODER
extern int *Parma_done;
extern int *Rendering_done;
extern int *Number_of_Objects;
extern int *IMAX_Done;
extern int *Type1cc_State;
extern int *Downmix_Normalization;
extern int *Dialog_Interactivity;
extern int Frmwk_DtsxCore2StatusValid;
extern int *DtsxCore2StatusValid;
extern int *Stream_sample_rate;
extern int *Frmwk_Outputsamplerate_c1;
extern int Ver_No_4;
extern int *Remapping_done;
#ifdef TRUBASS  
extern int *TruBassDone;
#endif //#TRUBASS  
#ifdef DOWNSAMPLING_DTSX
extern int *DTSX_DS_Enable;
#endif // DOWNSAMPLING_DTSX
#endif //DTSX_DECODER
#endif /* EXTERN_CORE1_H_ */
