/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Extern_asm.h
*  Description      :   Extern variables & modules for framework & ISR can be included here
******************************************************************************/

#ifndef EXTERN_ASM_H
#define EXTERN_ASM_H

#include "..\src\system\Include\Commn.h"

.extern RX_Intermediate_BUFFER.;
.extern struct kernel Frmwk.;
.extern save_timer.;
.extern unsave_timer.;
.extern SingleI2S_prev_b2.;
.extern counttransmitter.;
.extern flag_receiver2.;
.extern common_rtn_label;
.extern int_SP0ABuffer4_ptr.;
.extern int_SP0ABuffer4_ptr.;

.extern unsave_lbrm_reg_rx;
.extern save_lbrm_reg_rx;

.extern rdma_rd_ptr.;
.extern unsave_lbrm_reg_tx;
.extern save_lbrm_reg_tx;
.extern PP_flag.;
.extern save_timer.;
.extern unsave_timer.;

.extern buff_cnt.;
.extern framre_cnt.;
.extern Dma_Buff_Size.;
.extern struct kernel Frmwk.;
.extern Tag_Location32.;
.extern PARAMETER_1_C2.;
.extern PARAMETER_2_C2.;
.extern PARAMETER_3_C2.;
.extern PARAMETER_4_C2.;
.extern RXSPI.;
.extern SPI_Device.;
.extern TXSPI.;

.extern Status_Compare;
.extern struct kernel Frmwk.;
.extern Predac_buffer_Int.;
.extern down_samp_flag.;
.extern No_of_Predac_Channel.;
.extern TMU_Value.;
.extern C_SW_Swap.;
.extern I2S_TDM_MODE.;
#ifdef DOWNSAMPLING
.extern DnSamp192to48.;
#endif // DOWNSAMPLING
#ifdef DTSX_DECODER
.extern	DTS_Init_Var;
#ifdef DOWNSAMPLING_DTSX
.extern DTS_down_samp_C2_kernel_changes_set.;
#endif //DOWNSAMPLING_DTSX
#endif	//DTSX_DECODER

#endif  /*	EXTERN_ASM_H  */
