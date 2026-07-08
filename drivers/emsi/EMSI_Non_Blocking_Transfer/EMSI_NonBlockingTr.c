/*********************************************************************************
Copyright(c) 2020-2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
*      EMSI_NonBlockingTr.c
******************************************************************************/
#include <sys/platform.h>
#include <sys/adi_core.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <services/int/adi_int.h>
#include <drivers/emsi/adi_emsi.h>
#include <services/spu/adi_spu.h>
#include <math.h>
#include "EMSI_NonBlockingTr.h"
#include "adi_initialize.h"

/*SPU Service*/
/* SPU handle */
static ADI_SPU_HANDLE hSpu;

/* Memory required for the SPU operation */
static uint8_t  SpuMemory[ADI_SPU_MEMORY_SIZE];

static int SpuInit(void);

/*EMSI return code*/
volatile static ADI_EMSI_RESULT    eResult;
/*Data transfer result*/
volatile static ADI_EMSI_RESULT    eData_Transfer_Result;

/*Transmit Buffer*/
#if defined(__ADSPSHARC__)
#pragma section("seg_l2")
#endif
ADI_CACHE_ALIGN static uint32_t g_iMSITxBuffer[ADI_CACHE_ROUND_UP_SIZE((TOTAL_LENGTH/4u), uint32_t)];

/*Receive Buffer*/
#if defined(__ADSPSHARC__)
#pragma section("seg_l2")
#endif
ADI_CACHE_ALIGN static uint32_t g_iMSIRxBuffer[ADI_CACHE_ROUND_UP_SIZE((TOTAL_LENGTH/4u), uint32_t)];

/*EMSI0 Handle*/
static ADI_EMSI_HANDLE hDev0;

/*Memory required for EMSI devices*/
static uint8_t EMSIDev0[ADI_EMSI_DRIVER_MEMORY_SIZE];


/*Check the eMSI result*/
static void CheckResult(ADI_EMSI_RESULT Result) {
	if (Result != ADI_EMSI_SUCCESS) {
		REPORT_ERROR(" \n Failed with error code 0x%08X\n", Result);
	}
}

/*EMSI callback function*/
static void Callback (void *pCBParam, uint32_t Event, void *pArg)
{
	if((Event) == pow(2,ADI_EMSI_EVENT_XFER_COMPLETE))
	{
		eData_Transfer_Result = ADI_EMSI_DATA_TRANS_FINISHED;
	}
	else
	{
		/*Error Code Check error as per ADI_EMSI_EVENT structure*/
		REPORT_ERROR(" \n Error Code:%x\n",Event);
	}
}


int main(int argc, char *argv[])
{
	/**
	 * Initialize managed drivers and/or services that have been added to 
	 * the project.
	 * @return zero on success 
	 */
	adi_initComponents();
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif

	/* SoftConfig setting for using on board eMMC*/
	/*SoftConfig for SOM SC598*/
#if defined(__ADSPSC598_FAMILY__)
	ConfigSoftSwitches_EV_SC598_SOM();
#endif

	/*Initialize Transmit buffer*/
	Buf_Init(g_iMSITxBuffer, (TOTAL_LENGTH/4u));

	/* Making all the EMSI0 transactions as secure master */
	if(SpuInit() != SUCCESS)
	{
		REPORT_ERROR("Failed to initialize spu\n");
	}

	/* Open EMSI and initialize the clock with (<400 KHz for eMMC device identification)*/
	eResult = adi_emsi_Open(ADI_EMSI_DEVA,ADI_EMSI_CARD_TYPE_EMMC,EMSIDev0,ADI_EMSI_DRIVER_MEMORY_SIZE,&hDev0);
	CheckResult(eResult);

	/*Setting RCA(Relative card address)*/
	eResult = adi_emsi_SetRca(hDev0,RCA);
	CheckResult(eResult);

	/*Set a APP usage*/
	eResult =  adi_emsi_SetAppUse(hDev0,ADI_EMSI_APP_USE_NORMAL_DATATRANSFER,false);
	CheckResult(eResult);

	/*eMMC device Identification*/
	if (eMSI_Identify_eMMC_Card(RCA) != SUCCESS)
	{
		REPORT_ERROR("Failed to identify eMMC card\n");
		return 0;
	}

	/* eMSI call back function*/
	eResult = adi_emsi_RegisterCallback(hDev0, Callback, NULL);
	CheckResult(eResult);

	/*Select the card using CMD7*/
	eResult =  adi_emsi_SelectCard(hDev0,true);
	CheckResult(eResult);

	/*Selecting the Speed Mode from controller and card side*/
	eResult = adi_emsi_SetSpeedMode(hDev0,ADI_EMSI_SPEED_MODE_HIGHSPEED_DDR);
	CheckResult(eResult);

	/*Set the bus width for eMSI operations from controller and card side.*/
	eResult = adi_emsi_SetBusWidth(hDev0,ADI_EMSI_BUS_WIDTH_8BIT);
	CheckResult(eResult);

	/*Changing clock frequency to 50MHz for data transfer operation*/
	eResult =adi_emsi_ChangeClockFreq(hDev0,DIVIDER_VALUE);
	CheckResult(eResult);

	/* Sets DMA type for an upcoming EMSI transfer(s) ignoring buffer boundary parameter for ADMA2 based transfers.*/
	eResult = adi_emsi_SetDmaType(hDev0,ADI_EMSI_DMA_USED_ADMA2,ADI_EMSI_SDMA_BUF_BDARY_4K);
	CheckResult(eResult);

	/*AutoCMD Feature use using Auto CMD 23 as predefined transfers we are using*/
	eResult = adi_emsi_AutoCmd(hDev0,ADI_EMSI_AUTO_CMD23EN);
	CheckResult(eResult);

	/* Set the block size for upcoming transfer(s).*/
	eResult = adi_emsi_SetBlkSze(hDev0,BLOCK_LENGTH);
	CheckResult(eResult);

	/*Updating data transfer to busy*/
	eData_Transfer_Result = ADI_EMSI_BUSY;

	/*Perform a Multi-block data write in non-blocking mode.*/
	eResult= adi_emsi_NonBlocking_Transfer(hDev0,ADI_EMSI_TRANSFER_TYPE_MULTI_BLOCK_WR_PREDEF,NO_OF_BLOCKS,START_ADDRESS_BLOCK,&g_iMSITxBuffer[0]);
	CheckResult(eResult);
	/*Wait till write transfer is complete*/
	while (eData_Transfer_Result != ADI_EMSI_DATA_TRANS_FINISHED);
	printf(" \n Write transfers Done");

	/*Updating data transfer to busy*/
	eData_Transfer_Result = ADI_EMSI_BUSY;

	/*Perform a Multi-block block data read in non-blocking mode.*/
	eResult= adi_emsi_NonBlocking_Transfer(hDev0,ADI_EMSI_TRANSFER_TYPE_MULTI_BLOCK_RD_PREDEF,NO_OF_BLOCKS,START_ADDRESS_BLOCK,&g_iMSIRxBuffer[0]);
	CheckResult(eResult);
	/*Wait till read transfer is complete*/
	while (eData_Transfer_Result != ADI_EMSI_DATA_TRANS_FINISHED);
	printf(" \n Read transfers Done");

	/*Verifying the transfer*/
	if (VerifyDataCopy() != SUCCESS)
	{
		printf("\nData Compare Failed");
	}
	else
	{
		printf("\n All Done!\n");
	}

	/*DeSelect the card using CMD7*/
	eResult =  adi_emsi_SelectCard(hDev0,false);
	CheckResult(eResult);

	/* Closes the EMSI handle */
	eResult = adi_emsi_Close(hDev0);
	CheckResult(eResult);

	return 0;

}


/*eMMC Card Identification CMD0->CMD1->CMD2->CMD3*/
static int eMSI_Identify_eMMC_Card(uint8_t CARD_RCA)
{
	/* Sending CMD0 to bring card to idle state*/
	ADI_EMSI_CMD_PARA CMD_PARA0 = {ADI_EMSI_RESPONSE_TYPE_NONE,ADI_EMSI_SUBCMD_TYPE_MAIN,ADI_EMSI_CMD_CRC_CHECK_DISABLE,ADI_EMSI_CMD_IDX_CHECK_DISABLE,ADI_EMSI_DATA_PRESENT_FALSE,ADI_EMSI_SND_CMD_TYPE_NORMAL};
	eResult= adi_emsi_SendCommand(hDev0,GO_IDLE_STATE,0u,&CMD_PARA0);
	if(eResult!=ADI_EMSI_SUCCESS)
	{
		REPORT_ERROR(" \n Error In CMD0");
		return (FAILED);
	}

	/*Sending CMD 1 till busy bit is set*/
	ADI_EMSI_CMD_PARA CMD_PARA1={ADI_EMSI_RESPONSE_TYPE_SHORT,ADI_EMSI_SUBCMD_TYPE_MAIN,ADI_EMSI_CMD_CRC_CHECK_DISABLE,ADI_EMSI_CMD_IDX_CHECK_DISABLE,ADI_EMSI_DATA_PRESENT_FALSE,ADI_EMSI_SND_CMD_TYPE_NORMAL};
	/*Making g_iResponse 0 for expected response*/
	g_iResponse[0]=0u;
	while((g_iResponse[0] & CARD_BUSY)==0)
	{
		eResult= adi_emsi_SendCommand(hDev0,SEND_OP_COND,0xC0ff8080u,&CMD_PARA1);
		if(eResult!=ADI_EMSI_SUCCESS)
		{
			REPORT_ERROR(" \n Error In CMD1");
			return (FAILED);
		}

		eResult= adi_emsi_GetResponse(hDev0,&g_iResponse[0]);
		if(eResult!=ADI_EMSI_SUCCESS)
		{
			REPORT_ERROR(" \n Error In CMD1");
			return (FAILED);
		}
	}

	/*Collect CID information of the card (Sending CMD2)*/
	ADI_EMSI_CMD_PARA CMD_PARA2 ={ADI_EMSI_RESPONSE_TYPE_LONG,ADI_EMSI_SUBCMD_TYPE_MAIN,ADI_EMSI_CMD_CRC_CHECK_DISABLE,ADI_EMSI_CMD_IDX_CHECK_DISABLE,ADI_EMSI_DATA_PRESENT_FALSE,ADI_EMSI_SND_CMD_TYPE_NORMAL};
	eResult= adi_emsi_SendCommand(hDev0,ALL_SEND_CID,0x1u/*stuff bits*/, &CMD_PARA2);
	if(eResult!=ADI_EMSI_SUCCESS)
	{
		REPORT_ERROR(" \n Error In CMD2");
		return (FAILED);
	}

	/*Setting the RCA of the card to 0x1*/
	/*Sending RCA command CMD3*/
	ADI_EMSI_CMD_PARA CMD_PARA3 ={ADI_EMSI_RESPONSE_TYPE_SHORT,ADI_EMSI_SUBCMD_TYPE_MAIN,ADI_EMSI_CMD_CRC_CHECK_DISABLE,ADI_EMSI_CMD_IDX_CHECK_DISABLE,ADI_EMSI_DATA_PRESENT_FALSE,ADI_EMSI_SND_CMD_TYPE_NORMAL};
	eResult= adi_emsi_SendCommand(hDev0,SET_RELATIVE_ADDR,(CARD_RCA<<16u),&CMD_PARA3);
	if(eResult!=ADI_EMSI_SUCCESS)
	{
		REPORT_ERROR(" \n Error in CMD3");
		return (FAILED);
	}

	/*eMMC identification process is over now*/
	printf(" \n The eMMC card is now in stand by state and ready for data transfer");

	return (SUCCESS);
}


/*Buffer Fill*/
static void Buf_Init(void* InitBuf, uint32_t uiSize)
{
	/*Loop variables*/
	uint32_t i = 0;
	/*Buffer pointer*/
	uint32_t *pBuff = InitBuf;

	/*Generate source data*/
	for(i=0 ; i < uiSize; i++)
	{
		*pBuff++ = 0xA5A5A5A5;
	}
}


/*SPU Initialization*/
/*
 * Initializes SPU
 *
 * Parameters           None
 *
 * Returns
 *  - SUCCESS   - SPU initialization passed
 *  - FAILURE   - SPU initialization failed
 *
 */
static int SpuInit(void)
{
	/* Initialize SPU Service */
	if(adi_spu_Init(0u, SpuMemory, NULL, NULL, &hSpu) != ADI_SPU_SUCCESS)
	{
		REPORT_ERROR("Failed to initialize SPU service\n");
		return (FAILED);
	}

	/* Make EMSI0 to generate secure transactions */
	if(adi_spu_EnableMasterSecure(hSpu, EMSI0_SPU_PID, true) != ADI_SPU_SUCCESS)
	{
		REPORT_ERROR("Failed to enable Master secure for EMSI0\n");
		return (FAILED);
	}

	return (SUCCESS);
}

/*
 * Verifies transfer by comparing transmit and received data.
 *
 * Parameters
 *  None
 *
 * Returns
 *  - SUCCESS   - Data verification success
 *  - FAILURE   - Data verification failed
 *
 */
static int VerifyDataCopy (void)
{
	/* Loop variable */
	uint32_t buff_index;

	for (buff_index = 0u; buff_index < (TOTAL_LENGTH/4u); buff_index++)
	{
		/* IF (Destination data not same as source) */
		if (g_iMSIRxBuffer[buff_index] != g_iMSITxBuffer[buff_index])
		{
			/* Return error */
			return (FAILED);
		}
	}
	return (SUCCESS);
}


