/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Tx_Rx_Handler.c
*  Description      :   Rx and Tx interrupt functions
******************************************************************************/
#pragma default_section(CODE,"Seg_TX_RX_Handler_Code")
#pragma default_section(ALLDATA,"Seg_TX_RX_Handler_Data")
#include "..\src\system\Include\TX_RX_Handler.h"
#include <cdef21593.h>
#include "../Include/Function_Prototype.h"


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

		Current_DMA_address=(int)*pREG_DMA0_ADDRSTART;


	Reference_Start_Address= (int*)((int)RX_SP0A_BUFFER_LCRSW0|(int)MP_OFFSET);

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
	uint32_t Event = (uint32_t)handlerArg;
	if(Event & (ADI_SPORT_HW_ERR_FS | ADI_SPORT_HW_ERR_SECONDARY_CHNL_OVERFLOW | ADI_SPORT_HW_ERR_SECONDARY_CHNL_UNDERFLOW | ADI_SPORT_HW_ERR_PRIMARY_CHNL_OVERFLOW | ADI_SPORT_HW_ERR_PRIMARY_CHNL_UNDERFLOW))
	{
		return;
	}


	Current_DMA_address=(int)*pREG_DMA10_ADDRSTART;
	Reference_Start_Address= (int*)((int)TX_SP4A_BUFFER_LCRSW0|(int)MP_OFFSET);

#ifdef CORE1_TX
	Frmwk.IOP.NextDacCount=Frmwk.SampleBlock;
#else
	Frmwk.IOP.NextDacCount=*Next_dac_count;
	Frmwk.IOP.Predac.wr_ptr_c2=*predac_wr_ptr_c2;
#endif

	Frmwk.internal_Tx_buff =(int )&TX_EXT_DMA_BUFFER[0];


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
#ifdef DOWNSAMPLING_DTSX
	if((*DTSX_DS_Enable == 1)&&(*Stream_sample_rate == 512))
	{
		DTS_down_samp_C2_kernel_changes_set = 1;
	}
	else
	{
		DTS_down_samp_C2_kernel_changes_set = 0;
	}
#endif //DOWNSAMPLING_DTSX
#ifdef DTSX_LATENCY_CALC
	DTSX_latency_rd_ptr_temp =	(int*)Frmwk.IOP.Predac.rd_ptr;
#endif//DTSX_LATENCY_CALC
	transmitter();
#ifdef DTSX_LATENCY_CALC

	if(*DTSX_latency_state_frm_c2 == 1)
	{
		if((DTSX_latency_rd_ptr_temp[0]) == 0x12345678)
		{
			DTSX_latency_cycles = 0;
		    CALCULATE_MIPS(&DTSX_latency_cycles);
		    *DTSX_latency_state_frm_c2  = 0;
		}
	}
#endif//DTSX_LATENCY_CALC
	*predac_rd_ptr_c1=Frmwk.IOP.Predac.rd_ptr;
	mdma_done = 0;

	if(Frmwk.IOP.DataValid==1)
	{
		srcAddress = curr_DMA_ptr_tx;
		dstAddress = (int)&TX_EXT_DMA_BUFFER[0];

#if defined (USE_MDMA_EXTCHANNEL) || defined (TX_NEW_LOGIC)
		if(srcAddress!=0)
		{
			EXTMDMA_Enable(Dma_Buff_Size, srcAddress, dstAddress);
		}
		else
		{
			/* Clear the given memory */
			memset((void*)dstAddress, 0, Dma_Buff_Size);
		}
		curr_DMA_ptr_tx=Frmwk.IOP.Predac.rd_ptr;
		mdma_done = 1;
#else//striaght copy instead of MDMA
	Predac_buffer_to_Tx_DMA(srcAddress,dstAddress);
	curr_DMA_ptr_tx=Frmwk.IOP.Predac.rd_ptr;
	mdma_done = 1;
#endif
	bMemCopyInProgress=true;
	}
	else
	{
		curr_DMA_ptr_tx=Frmwk.IOP.Predac.rd_ptr;

	}
}
/******************************************************************************
 *  Module Name        : Predac_buffer_to_Tx_DMA
 *  Functionality      : Copy Routine from Predac_Buffer to Tx_DMA Buffer
 *  Input Parameters   : srcptr,dstptr
 *  Output Parameters  : None
 ******************************************************************************/
void Predac_buffer_to_Tx_DMA(int* srcptr,int* dstptr)
{
	int k=0,l=0;
	for(int i = 0;i<NO_OF_TX_SAMPLE_COUNT;i++)
	{
	   for(int j = 0;j<NO_OF_PREDAC_CHANNEL;j++)	
	   {
	     	dstptr[l++] = srcptr[k++];
		}	
	}
}

