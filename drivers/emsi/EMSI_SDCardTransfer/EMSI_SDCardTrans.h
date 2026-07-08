/*********************************************************************************
Copyright(c) 2020-2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * EMSI_SDCardTrans.h
 *****************************************************************************/
#ifndef __EMSI_SDCARDTRANS_H__
#define __EMSI_SDCARDTRANS_H__


/* Add your custom header content here */

/* Set EMSI Device Number to the required EMSI to be tested
 *  EMSI0 -- ADI_EMSI_0
 */
#define ADI_EMSI_DEVA  ADI_EMSI_0

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
 *100 Blocks : 50 KB
 *200 Blocks : 100 KB
 *So On*/
#define TOTAL_LENGTH BLOCK_LENGTH*1u

/*Start Address of the block to read or write from the card (for <2GB card byte address,
 * for >2GB card sector address)*/
#define START_ADDRESS_BLOCK 	  0u

/*No of blocks to be transferred*/
#define NO_OF_BLOCKS (TOTAL_LENGTH/BLOCK_LENGTH)

/*Divider value for eMSI clock frequency change*/
/*0 =50 MHz
 *1 =25 MHz
 *2 =12.5 MHz so on*/
#define DIVIDER_VALUE				1u

/*SPU PID*/
#define EMSI0_SPU_PID             (175u)

#define SUCCESS   0
#define FAILED   -1

/*OCR register's bits for checking busy status*/
#define CARD_BUSY 0x80000000

/*SD Command definitions*/
#define GO_IDLE_STATE 							0u
#define SEND_RELATIVE_ADDR 						3u
#define ALL_SEND_CID 							2u
#define SEND_IF_COND 							8u
#define APP_CMD 								55u
#define SD_SEND_OP_COND 						41u

/*Voltage conditions supported by the host*/
#define VHS										1u
/*Check pattern used*/
#define CHECK_PATTERN 							0xAA
/*Card status bits*/
#define STATUS_APP_CMD 							0x20

#define VOLTAGE_SUPPORTED 						(1<<20u)

/*Stores the contents of the response registers is received from the card*/
uint32_t g_iResponse[4];

/*Stores SD Card RCA published by SD Card*/
volatile uint32_t  SDCardRCA;

/*Macro for reporting errors*/
#define REPORT_ERROR        printf

/*Functions*/
/*Identifying SD card*/
static int eMSI_Identify_SD_Card(void);

/*Buffer initialization*/
static void Buf_Init(void* InitBuf, uint32_t uiSize);

/*Verifies transfers*/
static int VerifyDataCopy(void);

/*SoftConfig*/
#if defined(__ADSPSC598_FAMILY__)
void ConfigSoftSwitches_EV_SC598_SOM(void);
#endif

#endif /* __EMSI_SDCARDTRANS_H__ */
