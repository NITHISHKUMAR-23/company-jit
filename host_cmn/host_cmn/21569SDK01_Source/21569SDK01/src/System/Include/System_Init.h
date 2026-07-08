/***************************************************************************
*
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	System_Init.h
*  Description      :
******************************************************************************/

#include "..\src\system\Include\Commn.h"
#ifndef SYSTEM_INCLUDE_SYSTEM_INIT_H_
#define SYSTEM_INCLUDE_SYSTEM_INIT_H_

#include <stdint.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include <stdio.h>
#include <math.h>
#include "..\src\system\Include\Codeid.h"
#include "..\src\system\Include\HostDefines.h"
#include <cdef21569.h>
#include "sru21569.h"
#include <sys/cache.h>
#include "..\src\system\Include\Adr_Lkup_Tab_Macros.h"
#include "..\src\system\Include\Commn.h"
#include "..\src\system\Include\Extern.h"
#include "..\src\system\Include\Def_struct.h"

#include <drivers/sport/adi_sport.h>
#include <services/dma/adi_dma.h>
#include <services/spu/adi_spu.h>
#include <services/pcg/adi_pcg.h>
#include <drivers/asrc/adi_asrc.h>
#include <drivers\sport\adi_sport.h>
/**********************************************defines Declared**********************************************/

#define SMSIZE 4
#define DMSIZE 4
#define BUFF_SIZE 1024
#define SPI_BUFFER_SIZE 40

//This macro can be used to configure an MDMA stream by providing the source and destination DMA channel details
#define MDMA_CONFIG(S_MDMA_CHANNEL,S_CFG, S_ADDRSTART, S_MOD, S_COUNT,D_MDMA_CHANNEL,D_CFG, D_ADDRSTART, D_MOD, D_COUNT)\
		*pREG_DMA##S_MDMA_CHANNEL##_CFG = S_CFG;\
		*pREG_DMA##S_MDMA_CHANNEL##_ADDRSTART = S_ADDRSTART;\
		*pREG_DMA##S_MDMA_CHANNEL##_XCNT = S_COUNT;\
		*pREG_DMA##S_MDMA_CHANNEL##_XMOD = S_MOD;\
		*pREG_DMA##D_MDMA_CHANNEL##_CFG = D_CFG;\
		*pREG_DMA##D_MDMA_CHANNEL##_ADDRSTART = D_ADDRSTART;\
		*pREG_DMA##D_MDMA_CHANNEL##_XCNT = D_COUNT;\
		*pREG_DMA##D_MDMA_CHANNEL##_XMOD = D_MOD;\
		*pREG_DMA##D_MDMA_CHANNEL##_CFG |= 0x1;\
		*pREG_DMA##S_MDMA_CHANNEL##_CFG |= 0x1;

#define SPORT0A_DMA_SPU_ID 49
#define SPORT0B_DMA_SPU_ID 50
#define SPORT1A_DMA_SPU_ID 51
#define SPORT1B_DMA_SPU_ID 52

#define SPORT2A_DMA_SPU_ID 53  //EIGHTEEN_CHANNEL

#define SPORT3A_DMA_SPU_ID 55
#define SPORT3B_DMA_SPU_ID 56
#define SPORT4A_DMA_SPU_ID 57
#define SPORT4B_DMA_SPU_ID 58

#define SPORT5B_DMA_SPU_ID 60  //TWENTYFOUR_CHANNEL

#define MDMA0_SRC_SPU_ID  110
#define MDMA0_DST_SPU_ID  111
#define MDMA3_SPU_ID	  102
#define SPI0_TXDMA_SPU_ID  73
#define SPI0_RXDMA_SPU_ID  74

/**************************************************************************************************
 * 	Declared Function Prototype Section
 **************************************************************************************************/
void DAI_init(void);
void TX_DAC_Channel_check();
void System_Initialization(void);
void Kernal_Default_Init(void);
void Enable_Cache(void);
void SPI_Init(void);
void TRU_init(void);
void Sport_init(void);
void PCG_init(void);
void EXTMDMA_init(void);
void EXTMDMA_enable(int,int,int);
int Init_Struct(void);
int FlagsConfigure(void);
void Init_PORTs(void);
void Init_SPI0(void);
void ReInit_SPI0(void);
void AllocateMemoryKernel(void);
void Default_Command_Config(void);
void Free_AllotMemoryPackDac( int size1, int size2, int val1);
void AllocateMemoryPCMDelay( int LPCMDelaySize);
void SRC_init(void);
void SpuInit(void);
void ReInit_SPI0(void);
void Rx_DMA_HANDLER(int, void *);
void Tx_DMA_HANDLER(int, void *);

/**************************************************************************************************
 * 	Global Variable Declaration and Extern Section
 **************************************************************************************************/
extern int *run_flag;
extern int mdma_done;

section("seg_tx_dma_bw")
uint32_t uiTapList[32];
section("seg_dmda_nw")
int Spi_size[SPI_BUFFER_SIZE/4];
section("seg_ex_ds_bw")
int FSTemp_spt;
section("seg_ex_ds_bw")
int Frame_Sync=0;

/*************************TRANSMITTER DESCRIPTION LIST STRUCTURE***********************/
  section("seg_list_bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_1_SP4A;
  section("seg_list_bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_2_SP4A;
  section("seg_list_bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_3_SP4B;
  section("seg_list_bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_4_SP4B;
  section("seg_list_bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_5_SP3A;
  section("seg_list_bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_6_SP3A;
  section("seg_list_bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_7_SP3B;
  section("seg_list_bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_8_SP3B;


  section("seg_list_bw")
  	ADI_PDMA_DESC_LIST iDESC_LIST_9_SP2A;  
  section("seg_list_bw")
  	ADI_PDMA_DESC_LIST iDESC_LIST_10_SP2A;  



  section("seg_list_bw")
  	ADI_PDMA_DESC_LIST iDESC_LIST_11_SP5B;  
  section("seg_list_bw")
  	ADI_PDMA_DESC_LIST iDESC_LIST_12_SP5B;  


  section("seg_list_bw")
    static uint8_t SPORTMemory4A[ADI_SPORT_MEMORY_SIZE];
  section("seg_list_bw")
    static uint8_t SPORTMemory4B[ADI_SPORT_MEMORY_SIZE];
  section("seg_list_bw")
    static uint8_t SPORTMemory3A[ADI_SPORT_MEMORY_SIZE];
  section("seg_list_bw")
    static uint8_t SPORTMemory3B[ADI_SPORT_MEMORY_SIZE];


  section("seg_list_bw")
     static uint8_t SPORTMemory2A[ADI_SPORT_MEMORY_SIZE];  



  section("seg_list_bw")
     static uint8_t SPORTMemory5B[ADI_SPORT_MEMORY_SIZE];  

 section("seg_list_bw")
    ADI_PDMA_DESC_LIST iSRC_LIST_1_SP0A;
 section("seg_list_bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_2_SP0A;
 section("seg_list_bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_3_SP0B;
 section("seg_list_bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_4_SP0B;
 section("seg_list_bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_5_SP1A;
 section("seg_list_bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_6_SP1A;
 section("seg_list_bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_7_SP1B;
 section("seg_list_bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_8_SP1B;

 section("seg_list_bw")
	static uint8_t SPORTMemory0A[ADI_SPORT_MEMORY_SIZE];
 section("seg_list_bw")
	static uint8_t SPORTMemory0B[ADI_SPORT_MEMORY_SIZE];
 section("seg_list_bw")
	static uint8_t SPORTMemory1A[ADI_SPORT_MEMORY_SIZE];
 section("seg_list_bw")
	static uint8_t SPORTMemory1B[ADI_SPORT_MEMORY_SIZE];


/****************DMA Variable Declaration and Initialization Section *************************/

/* Memory to handle DMA Stream */
static uint8_t MemDmaStreamMem[ADI_DMA_STREAM_REQ_MEMORY];

/* DMA Stream Handle */
ADI_DMA_STREAM_HANDLE   hMemDmaStream;

/* Source DMA Handle */
static ADI_DMA_CHANNEL_HANDLE  hSrcDmaChannel;

/* Destination DMA Handle */
static ADI_DMA_CHANNEL_HANDLE  hDestDmaChannel;

/* Memory to handle DMA Stream */
static uint8_t MemDmaStreamMem1[ADI_DMA_STREAM_REQ_MEMORY];

/* DMA Stream Handle */
ADI_DMA_STREAM_HANDLE   hMemDmaStream1;

/* Source DMA Handle */
static ADI_DMA_CHANNEL_HANDLE  hSrcDmaChannel1;

/* Destination DMA Handle */
static ADI_DMA_CHANNEL_HANDLE  hDestDmaChannel1;

/****************SPORT Variable Declaration and Initialization Section *************************/

ADI_SPORT_HANDLE hSPORT0ARx;
ADI_SPORT_HANDLE hSPORT0BRx;
ADI_SPORT_HANDLE hSPORT1ARx;
ADI_SPORT_HANDLE hSPORT1BRx;

ADI_SPORT_HANDLE hSPORT2ATx;  //EIGHTEEN_CHANNEL


ADI_SPORT_HANDLE hSPORT5BTx;  //TWENTYFOUR_CHANNEL

ADI_SPORT_HANDLE hSPORT4ATx;
ADI_SPORT_HANDLE hSPORT4BTx;
ADI_SPORT_HANDLE hSPORT3ATx;
ADI_SPORT_HANDLE hSPORT3BTx;

ADI_SPORT_RESULT Result;


/* Global SPORT Array Handle */

static ADI_SPORT_HANDLE SportTxDai1Array[3];  //TWENTYFOUR_CHANNEL


static ADI_SPORT_HANDLE SportTxDai0Array[3];  //EIGHTEEN_CHANNEL

static ADI_SPORT_HANDLE SportRxDai0Array[4];

/*GLobal sport group handle */
ADI_GLOBAL_SPORT_HANDLE hDai1Group0Tx;
ADI_GLOBAL_SPORT_HANDLE hDai0Group0Tx;
ADI_GLOBAL_SPORT_HANDLE hDai0Group1Rx;

#endif
