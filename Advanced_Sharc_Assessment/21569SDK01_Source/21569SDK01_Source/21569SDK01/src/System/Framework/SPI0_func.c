/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	SPI0_func.c
*  Description      :   SPI0 Initialization
*
******************************************************************************/
#pragma default_section(CODE,"Seg_SPI_Func_Code")

#include "..\src\system\Include\Common_macros__extern_definations.h"

#include <drivers/spi/adi_spi_2156x.h>
#include "stdio.h"

extern void SPI0_RxCore_Handler (uint32_t iid, void *handlerArg);
static ADI_SPI_RESULT SpuInit(void);

/* SPI Handle */
ADI_SPI_HANDLE hSPISlave;

/* Driver memory required for SPI */
static uint8_t SPIMemory0[ADI_SPI_BIDIR_MEMORY_SIZE];

/* Transfer parameters */
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Src_List;
ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  Dest_List;

extern int RXSPI;
extern int TXSPI;

DMA_Regs SPI0_DMA;

/******************************************************************************
*  Module Name        : Init_SPI0
*  Functionality      : Configured SPI0 Module Registers
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/
void Init_SPI0(void)
{
		ADI_SPI_RESULT eResult;

		/* Open SPI */
		adi_spi_Open(ADI_SPI_0, ADI_SPI_DIR_BIDIRECTION, SPIMemory0, ADI_SPI_BIDIR_MEMORY_SIZE, &hSPISlave);

		/* Register handler */
		adi_spi_RegisterCallback(hSPISlave, SPI0_RxCore_Handler, NULL);

		*pREG_TRU0_GCTL|=1;  //Cphas=0  purpose
		*pREG_TRU0_SSR36=68;
		/* Initialize SPI0 transfer parameters */
		Src_List.pStartAddr            = &TXSPI;
		Src_List.XCount                = 1;
		Src_List.XModify               = 4;
		Src_List.Config                = ENUM_DMA_CFG_TRGWAIT;
		Src_List.pNxtDscp 			   = &Src_List;

		/* Buffer Start Address */
		Dest_List.pStartAddr           = &RXSPI;
		Dest_List.XCount               = 1;
		Dest_List.XModify              = 4;
		Dest_List.Config               = ENUM_DMA_CFG_XCNT_INT;
		Dest_List.pNxtDscp             = &Dest_List;

		/* Start SPI RX transfers to start recieving the commands one by one from the host */

		adi_spi_DMARead(hSPISlave, &Dest_List, 1, ADI_PDMA_DESCRIPTOR_LIST);
		adi_spi_DMAWrite(hSPISlave, &Src_List, 1, ADI_PDMA_DESCRIPTOR_LIST);
}

/******************************************************************************
*  Module Name        : ReInit_SPI0
*  Functionality      : Configured SPI0 transfer parameters
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/
void ReInit_SPI0(void)
{
		ADI_SPI_RESULT eResult;

		/* Initialize SPI0 transfer parameters */
		Src_List.pStartAddr            = &TXSPI;
		Src_List.XCount                = 1;
		Src_List.XModify               = 4;
		Src_List.Config                = ENUM_DMA_CFG_TRGWAIT;
		Src_List.pNxtDscp 			   = &Src_List;

		/* Buffer Start Address */
		Dest_List.pStartAddr           = &RXSPI;
		Dest_List.XCount               = 1;
		Dest_List.XModify              = 4;
		Dest_List.Config               = ENUM_DMA_CFG_XCNT_INT;
		Dest_List.pNxtDscp             = &Dest_List;

		/* Start SPI RX transfers to start recieving the commands one by one from the host */

		adi_spi_DMARead(hSPISlave, &Dest_List, 1, ADI_PDMA_DESCRIPTOR_LIST);
		adi_spi_DMAWrite(hSPISlave, &Src_List, 1, ADI_PDMA_DESCRIPTOR_LIST);

}
