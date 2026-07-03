/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	System_Init.h
*  Description      :   Transmitter & Receiver description List structure,DMA,SPORT,ASRC Variable Declaration and Initialization
******************************************************************************/
#ifndef SYSTEM_INCLUDE_SYSTEM_INIT_H_
#define SYSTEM_INCLUDE_SYSTEM_INIT_H_

#include <stdint.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include <stdio.h>
#include <math.h>
#include <cdef21593.h>
#include "sru.h"
#include <sys/cache.h>
#include "Codeid.h"
#include "Commn.h"
#include "Extern_Core1.h"

#include <drivers/sport/adi_sport.h>
#include <services/dma/adi_dma.h>
#include <services/spu/adi_spu.h>
#include <services/pcg/adi_pcg.h>
#include <drivers/asrc/adi_asrc.h>
#include <drivers\sport\adi_sport.h>
#include "Def_Struct.h"
#include "TMU_ReadTemperature.h"

/**********************************************defines Declared**********************************************/


#define SPORT0A_DMA_SPU_ID 63
#define SPORT0B_DMA_SPU_ID 64



#define SPORT2A_DMA_SPU_ID 67
#define SPORT2B_DMA_SPU_ID 68

#define SPORT3A_DMA_SPU_ID 69
#define SPORT3B_DMA_SPU_ID 70
#define SPORT4A_DMA_SPU_ID 71
#define SPORT4B_DMA_SPU_ID 72

#define SPORT5A_DMA_SPU_ID 73
#define SPORT6A_DMA_SPU_ID 75
#define SPORT6B_DMA_SPU_ID 76
#define SPORT7A_DMA_SPU_ID 77
#define SPORT7B_DMA_SPU_ID 78


#define MDMA0_SRC_SPU_ID  146
#define MDMA0_DST_SPU_ID  147
#define MDMA1_SRC_SPU_ID  148
#define MDMA1_DST_SPU_ID  149
#define MDMA3_SPU_ID	  135 //MAX BW MDMA
#define SPI0_TXDMA_SPU_ID  93
#define SPI0_RXDMA_SPU_ID  94
#define SPI1_TXDMA_SPU_ID  95
#define SPI1_RXDMA_SPU_ID  96
/**************************************************************************************************
 * 	Global Variable Declaration and Extern Section
 **************************************************************************************************/
extern int *run_flag;
extern int mdma_done;
extern int SPI_Device;



section("Seg_Tx_Dma_Bw")
uint32_t uiTapList[32];


/*************************TRANSMITTER DESCRIPTION LIST STRUCTURE***********************/
  section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_1_SP4A;
  section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_2_SP4A;
  section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_3_SP4B;
  section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_4_SP4B;
  section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_5_SP3A;
  section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_6_SP3A;
  section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_7_SP3B;
  section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_8_SP3B;
  section("Seg_List_Bw")
  	ADI_PDMA_DESC_LIST iDESC_LIST_9_SP6A;
  section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_10_SP6A;
  section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_11_SP2A;
  section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_12_SP2A;
  section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iDESC_LIST_13_SP6B;
  section("Seg_List_Bw")
  	ADI_PDMA_DESC_LIST iDESC_LIST_14_SP6B;
  section("Seg_List_Bw")
  	ADI_PDMA_DESC_LIST iDESC_LIST_15_SP7A;
  section("Seg_List_Bw")
    ADI_PDMA_DESC_LIST iDESC_LIST_16_SP7A;
  section("Seg_List_Bw")
    ADI_PDMA_DESC_LIST iDESC_LIST_17_SP2B;
  section("Seg_List_Bw")
    ADI_PDMA_DESC_LIST iDESC_LIST_18_SP2B;


  section("Seg_List_Bw")
    static uint8_t SPORTMemory4A[ADI_SPORT_MEMORY_SIZE];
  section("Seg_List_Bw")
    static uint8_t SPORTMemory4B[ADI_SPORT_MEMORY_SIZE];
  section("Seg_List_Bw")
    static uint8_t SPORTMemory3A[ADI_SPORT_MEMORY_SIZE];
  section("Seg_List_Bw")
    static uint8_t SPORTMemory3B[ADI_SPORT_MEMORY_SIZE];
  section("Seg_List_Bw")
    static uint8_t SPORTMemory2A[ADI_SPORT_MEMORY_SIZE];
  section("Seg_List_Bw")
    static uint8_t SPORTMemory6A[ADI_SPORT_MEMORY_SIZE];
  section("Seg_List_Bw")
      static uint8_t SPORTMemory6B[ADI_SPORT_MEMORY_SIZE];
  section("Seg_List_Bw")
      static uint8_t SPORTMemory7A[ADI_SPORT_MEMORY_SIZE];
  section("Seg_List_Bw")
      static uint8_t SPORTMemory2B[ADI_SPORT_MEMORY_SIZE];




  /****************RECEIVER DESCRIPTION LIST STRUCTURE*************************/
   section("Seg_List_Bw")
    ADI_PDMA_DESC_LIST iSRC_LIST_1_SP5A;
 section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_2_SP5A;
 
 section("Seg_List_Bw")
    ADI_PDMA_DESC_LIST iSRC_LIST_1_SP0A;
 section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_2_SP0A;
 section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_3_SP0B;
 section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_4_SP0B;
 section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_5_SP1A;
 section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_6_SP1A;
 section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_7_SP1B;
 section("Seg_List_Bw")
	ADI_PDMA_DESC_LIST iSRC_LIST_8_SP1B;

 section("Seg_List_Bw")
	static uint8_t SPORTMemory0A[ADI_SPORT_MEMORY_SIZE];
 section("Seg_List_Bw")
	static uint8_t SPORTMemory0B[ADI_SPORT_MEMORY_SIZE];
 section("Seg_List_Bw")
	static uint8_t SPORTMemory1A[ADI_SPORT_MEMORY_SIZE];
 section("Seg_List_Bw")
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


/* Memory to handle DMA Stream */
static uint8_t MemDmaStreamMem2[ADI_DMA_STREAM_REQ_MEMORY];

/* DMA Stream Handle */
ADI_DMA_STREAM_HANDLE   hMemDmaStream2;

/* Source DMA Handle */
static ADI_DMA_CHANNEL_HANDLE  hSrcDmaChannel2;

/* Destination DMA Handle */
static ADI_DMA_CHANNEL_HANDLE  hDestDmaChannel2;
/****************ASRC Variable Declaration and Initialization Section *************************/

uint8_t gAsrcMem0[ADI_ASRC_MEMORY_SIZE];
ADI_ASRC_HANDLE  hAsrc0    = NULL;

uint8_t gAsrcMem1[ADI_ASRC_MEMORY_SIZE];
ADI_ASRC_HANDLE  hAsrc1    = NULL;

uint8_t gAsrcMem2[ADI_ASRC_MEMORY_SIZE];
ADI_ASRC_HANDLE  hAsrc2    = NULL;

uint8_t gAsrcMem3[ADI_ASRC_MEMORY_SIZE];
ADI_ASRC_HANDLE  hAsrc3    = NULL;

/****************SPORT Variable Declaration and Initialization Section *************************/

ADI_SPORT_HANDLE hSPORT5ARx;
ADI_SPORT_HANDLE hSPORT0ARx;
ADI_SPORT_HANDLE hSPORT0BRx;
ADI_SPORT_HANDLE hSPORT1ARx;
ADI_SPORT_HANDLE hSPORT1BRx;

ADI_SPORT_HANDLE hSPORT4ATx;
ADI_SPORT_HANDLE hSPORT4BTx;
ADI_SPORT_HANDLE hSPORT3ATx;
ADI_SPORT_HANDLE hSPORT3BTx;
ADI_SPORT_HANDLE hSPORT2ATx;
ADI_SPORT_HANDLE hSPORT6ATx;

ADI_SPORT_HANDLE hSPORT6BTx;
ADI_SPORT_HANDLE hSPORT7ATx;
ADI_SPORT_HANDLE hSPORT2BTx;


ADI_SPORT_RESULT Result;


/* Global SPORT Array Handle */

static ADI_SPORT_HANDLE SportTxDai1Array0[5];

static ADI_SPORT_HANDLE SportTxDai0Array[4];

static ADI_SPORT_HANDLE SportRxDai0Array[4];


/*GLobal sport group handle */
ADI_GLOBAL_SPORT_HANDLE hDai1Group0Tx;
ADI_GLOBAL_SPORT_HANDLE hDai0Group0Tx;
ADI_GLOBAL_SPORT_HANDLE hDai0Group1Rx;
ADI_GLOBAL_SPORT_HANDLE hDai1Group1Rx;

#ifdef DOWNSAMPLING_DTSX
#define SMSIZE 4
#define DMSIZE 4

static ADI_DMA_2D_MEM_TRANSFER Src_2DMemXfer;
static ADI_DMA_2D_MEM_TRANSFER Dest_2DMemXfer;

#endif //DOWNSAMPLING_DTSX
#endif
