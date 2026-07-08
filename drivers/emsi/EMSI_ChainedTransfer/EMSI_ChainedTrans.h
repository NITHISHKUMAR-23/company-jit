/*********************************************************************************
Copyright(c) 2020-2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * EMSI_ChainedTrans.h
 *****************************************************************************/
#ifndef __EMSI_CHAINEDTRANS_H__
#define __EMSI_CHAINEDTRANS_H__


/* Add your custom header content here */

/* Set EMSI Device Number to the required EMSI to be tested
 *  EMSI0 -- ADI_EMSI_0
 */
#define ADI_EMSI_DEVA  ADI_EMSI_0

/*Number Transfer buffers*/
#define TxBuffers 		2u
/*Number Receive buffers*/
#define RxBuffers 		3u

#define ADI_CACHE_ROUND_UP_SIZE(size, type) \
    (((((((size) * sizeof(type)) \
           + (ADI_CACHE_LINE_LENGTH - 1uL)) \
          / ADI_CACHE_LINE_LENGTH) * ADI_CACHE_LINE_LENGTH) \
      + (sizeof(type) - 1uL)) / sizeof(type))

/*Transfer Related Parameters*/
/*Change this macro to change the block length for the transfers
 * It is suggested to keep block length as 512 Bytes as many cards supports
 * 512 Bytes and covers corner cases*/
#define BLOCK_LENGTH 512u

/*Buffer Size
 * 4 Blocks: 2 kB
 * 6 Blocks: 3 kB
 *100 Blocks : 50 kB
 *200 Blocks : 100 kB
 *So On*/
#define TOTAL_LENGTH1 BLOCK_LENGTH*6u
#define TOTAL_LENGTH2 BLOCK_LENGTH*6u
#define TOTAL_LENGTH3 BLOCK_LENGTH*6u
#define TOTAL_LENGTH4 BLOCK_LENGTH*6u
#define TOTAL_LENGTH5 BLOCK_LENGTH*4u


/*Start Address of the block to read or write from the card (for <2GB card byte address,
 * for >2GB card sector address)*/
#define START_ADDRESS_BLOCK0 	  0u
#define START_ADDRESS_BLOCK10 	  10u
#define START_ADDRESS_BLOCK12 	  12u

/*********No of blocks to be transferred*********/
#define NO_OF_BLOCKS1 (TOTAL_LENGTH1/BLOCK_LENGTH)
#define NO_OF_BLOCKS2 (TOTAL_LENGTH2/BLOCK_LENGTH)
#define NO_OF_BLOCKS3 (TOTAL_LENGTH3/BLOCK_LENGTH)
#define NO_OF_BLOCKS4 (TOTAL_LENGTH4/BLOCK_LENGTH)
#define NO_OF_BLOCKS5 (TOTAL_LENGTH5/BLOCK_LENGTH)

/*Relative Card address of the card which to be set using CMD3*/
#define RCA                  1u

/*Divider value for eMSI clock frequency change*/
/*0 =50 MHz
 *1 =25 MHz
 *2 =12.5 MHz so on*/
#define DIVIDER_VALUE				0u

/*SPU PID*/
#define EMSI0_SPU_PID             (175u)

#define SUCCESS   0
#define FAILED   -1

/*OCR register's bits for checking busy status*/
#define CARD_BUSY 0x80000000

/*eMMC Command definitions*/
#define GO_IDLE_STATE 							0u
#define SEND_OP_COND 							1u
#define SET_RELATIVE_ADDR 						3u
#define ALL_SEND_CID 							2u

/*Stores the contents of the response registers is received from the card*/
uint32_t g_iResponse[4];

/*Macro for reporting errors*/
#define REPORT_ERROR        printf

/*Functions*/
/*Identifying eMMC card (CMD0->CMD1->CMD2->CMD3)*/
static int eMSI_Identify_eMMC_Card(uint8_t CARD_RCA);

/*Buffer initialization*/
static void Buf_Init(void* InitBuf, uint32_t uiSize);

/*Verifies transfers*/
static int VerifyDataCopy(void);

/*SoftConfig*/
#if defined(__ADSPSC598_FAMILY__)
void ConfigSoftSwitches_EV_SC598_SOM(void);
#endif

#endif /* __EMSI_CHAINEDTRANS_H__ */
