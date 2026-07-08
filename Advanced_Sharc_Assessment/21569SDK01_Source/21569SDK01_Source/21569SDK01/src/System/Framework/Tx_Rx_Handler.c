/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Tx_Rx_Handler.c
*  Description      :   Rx and Tx interrupt functions
******************************************************************************/
#pragma default_section(CODE,"seg_TX_RX_Handler_code")
#include "..\src\system\Include\TX_RX_Handler.h"
#include <cdef21569.h>
//#define MDMA_DEBUG  //only for debugging purpose not to releses for customers
#ifdef MDMA_DEBUG
int Tx_DMA_Wait_Cnt = 0;
#endif
/******************************************************************************
 *  Module Name        : Rx_DMA_HANDLER
 *  Functionality      : Input buffer fill completed Trigger DMA Receiver
 *  					 Handler either Single I2S or Four I2S
 *  					 based on auto_detection mode
 *  Input Parameters   : handlerArg
 *  Output Parameters  : None
 ******************************************************************************/
void Rx_DMA_HANDLER(int iid, void *handlerArg)
{
#ifdef SPDIF_ENABLE
	if(SPDIF_Enable==1)
	{
	    Current_DMA_address=(int)*pREG_DMA12_ADDRSTART;
	}
	else
	{
		Current_DMA_address=(int)*pREG_DMA0_ADDRSTART;
	}
#else
	Current_DMA_address = (int)*pREG_DMA0_ADDRSTART;
#endif

	Reference_Start_Address= (uint32_t)RX_SP0A_BUFFER_LR0|MP_OFFSET;

	if(Current_DMA_address==(int)Reference_Start_Address)
	{
		counttransmitter=1;
		if(Frmwk.autodetect_mode<4)
		{
			receiver1();
		}
		else
		{
			receiver2();
		}
	}
	else 
	{
		counttransmitter=0;
		if(Frmwk.autodetect_mode<4)
		{
			receiver1();
		}
		else
		{
			receiver2();
		}
	}

}

/******************************************************************************
 *  Module Name        : Tx_DMA_HANDLER
 *  Functionality      : Input buffer fill completed Trigger DMA Transmitter
 *  					 Handler for Transmission
 *  Input Parameters   : iid ,handlerArg
 *  Output Parameters  : None
 ******************************************************************************/
void Tx_DMA_HANDLER(int iid, void *handlerArg)
{
	uint32_t Event = handlerArg;
	if(Event & (ADI_SPORT_HW_ERR_FS | ADI_SPORT_HW_ERR_SECONDARY_CHNL_OVERFLOW | ADI_SPORT_HW_ERR_SECONDARY_CHNL_UNDERFLOW | ADI_SPORT_HW_ERR_PRIMARY_CHNL_OVERFLOW | ADI_SPORT_HW_ERR_PRIMARY_CHNL_UNDERFLOW))
	{
		return;
	}


	Current_DMA_address=(int)*pREG_DMA10_ADDRSTART;
	Reference_Start_Address= (uint32_t)TX_SP4A_BUFFER_LCRSW0|MP_OFFSET;

	Frmwk.IOP.NextDacCount=Frmwk.SampleBlock;

#ifdef TX_NEW_LOGIC
	Frmwk.internal_Tx_buff =(int )&TX_EXT_DMA_BUFFER[0];
#endif


	if(mdma_done==1)
	{
#ifdef MDMA_DEBUG
		Tx_DMA_Wait_Cnt = 666666;
		while(bMemCopyInProgress && Tx_DMA_Wait_Cnt>=0)
		{
			Tx_DMA_Wait_Cnt--;
			adi_mdma_IsCopyInProgress (hMemDmaStream, &bMemCopyInProgress);
		}
#else
		while(bMemCopyInProgress)
		{
			adi_mdma_IsCopyInProgress (hMemDmaStream, &bMemCopyInProgress);
		}
#endif
	    curr_DMA_ptr_tx=Frmwk.IOP.Predac.rd_ptr;
	    mdma_done=0;
	}

	if(Current_DMA_address==(int)Reference_Start_Address)
		PP_flag=1;
	else
		PP_flag=0;

	transmitter();

//	mdma_done = 0;

	if(Frmwk.IOP.DataValid==1)
	{
#if defined (USE_MDMA_EXTCHANNEL) || defined (TX_NEW_LOGIC)
		srcAddress = curr_DMA_ptr_tx;
		dstAddress = (int)&TX_EXT_DMA_BUFFER[0];
		EXTMDMA_enable(dma_buff_size, srcAddress, dstAddress);
		mdma_done = 1;
#endif
	bMemCopyInProgress=true;
	}
	else
	{
		curr_DMA_ptr_tx=Frmwk.IOP.Predac.rd_ptr;
	}

}
