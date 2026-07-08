/*********************************************************************************
Copyright(c) 2019 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/
/*****************************************************************************
 * Linkport_DMA.h
 *****************************************************************************/

#ifndef __LINKPORT_DMA_H__
#define __LINKPORT_DMA_H__

/* Add your custom header content here */

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include <stdio.h>
#include <drivers/linkport/adi_linkport.h>
#include <services/pdma/adi_pdma_2156x.h>
#include <services/spu/adi_spu.h>
#include <stdlib.h>

#define TEST_LINKPORT_SDR_8BIT_TRANSFER_MODE
//#define TEST_LINKPORT_SDR_4BIT_TRANSFER_MODE
//#define TEST_LINKPORT_SDR_2BIT_TRANSFER_MODE


//#define TEST_LINKPORT_DDR_4BIT_TRANSFER_MODE
//#define TEST_LINKPORT_DDR_2BIT_TRANSFER_MODE

//#define BITM_PADS_PCFG0_FAULT_DIS       		 (_ADI_MSK_3(0x00040000,0x00040000UL, uint32_t  ))    /*  Fault Disable */

#define LINKPORT_MEM_SIZE ADI_LP_MEMORY_SIZE

#define SIZE_OF_BUFFER  1024u

#define INC_PATTERN		0
#define RAND_PATTERN	-2
#define PATTERN_ALL_A	0xAAAAAAAA
#define PATTERN_ALL_5	0x55555555
#define PATTERN_ALL_F	0xFFFFFFFF
#define PATTERN_CUSTOM	0xAAAA5555
#define PATTERN_5A		0x55AA55AA
#define PATTERN_A5		0xAA55AA55
#define PATTERN_A5A5	0xA5A5A5A5

#define LP0_CLK_DIV 4
#define LP1_CLK_DIV 4

uint8_t linkport_mem0[LINKPORT_MEM_SIZE];
uint8_t linkport_mem1[LINKPORT_MEM_SIZE];

/* Handle for Tx channel */
ADI_LINKPORT_HANDLE          hDevice0;
/* Handle for Rx channel */
ADI_LINKPORT_HANDLE          hDevice1;


//#define LP0_TX_LP1_RX 	//-- Case 1
#define LP0_RX_LP1_TX		//-- Case 2

/* Link port Instance number*/
ADI_CACHE_ALIGN unsigned int nBufferTx0[SIZE_OF_BUFFER];

ADI_CACHE_ALIGN unsigned int nBufferRx0[SIZE_OF_BUFFER];

ADI_CACHE_ALIGN unsigned int nBufferTx1[SIZE_OF_BUFFER];

ADI_CACHE_ALIGN unsigned int nBufferRx1[SIZE_OF_BUFFER];

/* List Descriptors */
ADI_PDMA_DESC_LIST  LP0_Desc;
ADI_PDMA_DESC_LIST  LP1_Desc;

static void LINKPORTCallback0(void *pCBParam, uint32_t   Event, void  *pArg);
static void LINKPORTCallback1(void *pCBParam, uint32_t   Event, void  *pArg);
int Compare_Data(uint32_t *pSource, uint32_t *pDestination, uint32_t iXCount);

/*Rx callback counter */
volatile uint32_t   nCallbackCounter0=0u;

/* Tx callback counter */
volatile uint32_t   nCallbackCounter1=0u;
volatile uint32_t   nCallbackCounter=0u;
volatile uint32_t  debug_stat, debug_stat1=0;


void fillData(uint32_t *pBuff, int pattern );
void InitBuffers(void);

#endif /* __LINKPORT_DMA_H__ */
