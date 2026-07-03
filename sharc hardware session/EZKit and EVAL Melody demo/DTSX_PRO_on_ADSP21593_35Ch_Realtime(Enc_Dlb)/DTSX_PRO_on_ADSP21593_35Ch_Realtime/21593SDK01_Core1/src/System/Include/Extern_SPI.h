/***************************************************************************
 *
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
 *
 *  Project          :   21593SDK
 *  Organization     :   Jasmin Infotech Private Limited,Chennai
 *  File Name        :	 Extern_SPI.h
 *  Description      :   Extern variables & modules for framework & ISR can be included here
 ******************************************************************************/
.IMPORT "..\src\system\Include\Def_Struct.h";
#ifndef EXTERN_H
#define EXTERN_H

/*****************************************************************************
	Framework Modules
 *****************************************************************************/
.extern RXSPI.;
.extern TXSPI.;
.extern TAGCOUNTADDR;
.extern FLAG_TOGGLE_ROUTINE;
.extern	saveforCEnv;
.extern	unsaveforCEnv;
.extern	saveforCEnvNoMode1;
.extern	unsaveforCEnvNoMode1;
.extern serialflashAddrRoutine;

.extern ReadHeader;
.extern DirectReadRoutine;


/*****************************************************************************
	ISR Modules
 *****************************************************************************/

.extern save_lbrm_reg_tx;
.extern unsave_lbrm_reg_tx;
.extern ExitSPIReceiveInterrupt;
.extern save_lbrm_reg_spi;
.extern unsave_lbrm_reg_spi;
.extern _receiver2;
.extern transmitter;
.extern save_lbrm_reg_rx;
.extern unsave_lbrm_reg_rx;
.extern _receiver1;

/************************************************************************/
.extern _bypass;
.extern  _high;
.extern CRC_ERROR;
.extern PlayForgnd_DSD2PCM;
.extern DSD2PCMDecoder;
.extern Deemphasis;
.extern copy_to_pre_dac_dummy;
.extern CopyPack2Work;
.extern Init_Struct;
.extern SystemInitialisation_DSD2PCM;
.extern Init_Var;
.extern _channels;
.extern struct kernel Frmwk.;


#endif
