/*********************************************************************************
Copyright(c) 2020-2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
*      EMSI_SDCardTrans.c
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
#include "EMSI_SDCardTrans.h"
#include "adi_initialize.h"

/*SPU Service*/
/*SPU handle */
static ADI_SPU_HANDLE hSpu;

/* Memory required for the SPU operation */
static uint8_t  SpuMemory[ADI_SPU_MEMORY_SIZE];

static int SpuInit(void);

/*EMSI return code*/
volatile static ADI_EMSI_RESULT eResult;

/*Data transfer result*/
volatile static ADI_EMSI_RESULT eData_Transfer_Result;


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
		REPORT_ERROR("Failed with error code 0x%08X\n", Result);
	}
}

/*EMSI callback function*/
static void Callback (void *pCBParam, uint32_t Event, void *pArg)
{
	if((Event) == pow(2,ADI_EMSI_EVENT_XFER_COMPLETE))
	{
		eData_Transfer_Result = ADI_EMSI_DATA_TRANS_FINISHED;
	}
	else if((Event) == pow(2,ADI_EMSI_EVENT_CARD_INSERTION))
	{
		printf("Card Inserted\n");
	}
	else if((Event) == pow(2,ADI_EMSI_EVENT_CARD_REMOVAL))
	{
		printf("Card Removed\n");
	}
	else
	{
		/*Error Code Check error as per ADI_EMSI_EVENT structure*/
		REPORT_ERROR("Error Code:%x\n",Event);
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

	/* SoftConfig setting for using sockted SD card*/
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

	/* Open EMSI and initialize the clock with (<400 KHz for SD card identification)*/
	eResult = adi_emsi_Open(ADI_EMSI_DEVA,ADI_EMSI_CARD_TYPE_SDCARD,EMSIDev0,ADI_EMSI_DRIVER_MEMORY_SIZE,&hDev0);
	CheckResult(eResult);

	/*Set a APP usage*/
	eResult =  adi_emsi_SetAppUse(hDev0,ADI_EMSI_APP_USE_NORMAL_DATATRANSFER,false);
	CheckResult(eResult);

	/* eMSI call back function*/
	eResult = adi_emsi_RegisterCallback(hDev0, Callback, NULL);
	CheckResult(eResult);

	/*Check is SD card inserted in socket*/
	if (adi_emsi_SetCardConnector(hDev0,true) != ADI_EMSI_CARD_INSERTED)
	{
		printf("Card not present in socket\n");
		return 0;
	}
	else
	{
		printf("Card present in socket\n");
	}

	/*SD card Identification*/
	if (eMSI_Identify_SD_Card() != SUCCESS)
	{
		REPORT_ERROR("Failed to identify SD card\n");
		return 0;
	}

	/*Getting RCA(Relative card address)*/
	eResult = adi_emsi_SetRca(hDev0,SDCardRCA);
	CheckResult(eResult);

	/*Select the card using CMD7*/
	eResult =  adi_emsi_SelectCard(hDev0,true);
	CheckResult(eResult);

	/*Selecting the Speed Mode from controller and card side*/
	eResult = adi_emsi_SetSpeedMode(hDev0,ADI_EMSI_SPEED_MODE_LEGACY_OR_DSSDR);
	CheckResult(eResult);

	/*Set the bus width for eMSI operations from controller and card side.*/
	eResult = adi_emsi_SetBusWidth(hDev0,ADI_EMSI_BUS_WIDTH_4BIT);
	CheckResult(eResult);

	/*Changing clock frequency to 25MHz for data transfer operation*/
	eResult =adi_emsi_ChangeClockFreq(hDev0,DIVIDER_VALUE);
	CheckResult(eResult);

	/* Sets DMA type for an upcoming EMSI transfer(s) ignoring buffer boundary for ADMA2*/
	eResult = adi_emsi_SetDmaType(hDev0,ADI_EMSI_DMA_USED_ADMA2,ADI_EMSI_SDMA_BUF_BDARY_4K);
	CheckResult(eResult);

	/*AutoCMD Feature */
	eResult = adi_emsi_AutoCmd(hDev0,ADI_EMSI_AUTO_CMD_DIS);
	CheckResult(eResult);

	/* Set the block size for upcoming transfer(s).*/
	eResult = adi_emsi_SetBlkSze(hDev0,BLOCK_LENGTH);
	CheckResult(eResult);

	/*Perform a Single-block data write in non-blocking mode.*/
	eResult= adi_emsi_NonBlocking_Transfer(hDev0,ADI_EMSI_TRANSFER_TYPE_SINGLE_BLOCK_WR,NO_OF_BLOCKS,START_ADDRESS_BLOCK,&g_iMSITxBuffer[0]);
	CheckResult(eResult);
	/*Wait till write transfer is complete*/
	while (eData_Transfer_Result != ADI_EMSI_DATA_TRANS_FINISHED);
	printf("Write transfers Done\n");

	/*Updating data transfer to busy*/
	eData_Transfer_Result = ADI_EMSI_BUSY;

	/*Perform a Single-block block data read in non-blocking mode.*/
	eResult= adi_emsi_NonBlocking_Transfer(hDev0,ADI_EMSI_TRANSFER_TYPE_SINGLE_BLOCK_RD,NO_OF_BLOCKS,START_ADDRESS_BLOCK,&g_iMSIRxBuffer[0]);
	CheckResult(eResult);
	/*Wait till read transfer is complete*/
	while (eData_Transfer_Result != ADI_EMSI_DATA_TRANS_FINISHED);
	printf("Read transfers Done\n");

	/*Verifying the transfer*/
	if (VerifyDataCopy() != SUCCESS)
	{
		printf("Data Compare Failed\n");
	}
	else
	{
		printf("All Done!\n");
	}

	/*DeSelect the card using CMD7*/
	eResult =  adi_emsi_SelectCard(hDev0,false);
	CheckResult(eResult);

	/* Closes the EMSI handle */
	eResult = adi_emsi_Close(hDev0);
	CheckResult(eResult);

	return 0;

}


/*SD Card Identification*/
static int eMSI_Identify_SD_Card(void)
{
	/*Temporary variables*/
	volatile uint32_t iTemp1, iTemp2;
	/*Making g_iResponse clear*/
	g_iResponse[0] = 0x00000000u;

	/*Starting the SD card identification process
	 *Issuing the RESET(CMD0) command to the card*/
	ADI_EMSI_CMD_PARA CMD_PARA0 = {ADI_EMSI_RESPONSE_TYPE_NONE,ADI_EMSI_SUBCMD_TYPE_MAIN,ADI_EMSI_CMD_CRC_CHECK_DISABLE,ADI_EMSI_CMD_IDX_CHECK_DISABLE,ADI_EMSI_DATA_PRESENT_FALSE,ADI_EMSI_SND_CMD_TYPE_NORMAL};
	eResult= adi_emsi_SendCommand(hDev0,GO_IDLE_STATE,0u,&CMD_PARA0);
	if(eResult!=ADI_EMSI_SUCCESS)
	{
		REPORT_ERROR("Error In CMD0\n");
		return (FAILED);
	}


	/*Checking if the card connected is a compatible SD Card
	 *Sending SEND_IF_COND(CMD8) command Checking if the card connected is a compatible SD Card*/
	ADI_EMSI_CMD_PARA CMD_PARA8 = {ADI_EMSI_RESPONSE_TYPE_SHORT,ADI_EMSI_SUBCMD_TYPE_MAIN,ADI_EMSI_CMD_CRC_CHECK_ENABLE,ADI_EMSI_CMD_IDX_CHECK_ENABLE,ADI_EMSI_DATA_PRESENT_FALSE,ADI_EMSI_SND_CMD_TYPE_NORMAL};
	eResult= adi_emsi_SendCommand(hDev0,SEND_IF_COND,CHECK_PATTERN|(VHS<<8u),&CMD_PARA8);
	if(eResult!=ADI_EMSI_SUCCESS)
	{
		REPORT_ERROR("Error In CMD8\n");
		return (FAILED);
	}
	eResult= adi_emsi_GetResponse(hDev0,&g_iResponse[0]);
	/*No response has received, an incompatible card or supports 1.x specification or not an SD card.*/
	if (g_iResponse[0] == 0x00000000)
	{
		do
		{
			/*Sending APPCMD 55 to know next command is application specific*/
			ADI_EMSI_CMD_PARA CMD_PARA_APP_CMD55 = {ADI_EMSI_RESPONSE_TYPE_SHORT,ADI_EMSI_SUBCMD_TYPE_MAIN,ADI_EMSI_CMD_CRC_CHECK_ENABLE,ADI_EMSI_CMD_IDX_CHECK_ENABLE,ADI_EMSI_DATA_PRESENT_FALSE,ADI_EMSI_SND_CMD_TYPE_NORMAL};
			eResult= adi_emsi_SendCommand(hDev0,APP_CMD,0,&CMD_PARA_APP_CMD55);
			if(eResult!=ADI_EMSI_SUCCESS)
			{
				/*No response received*/
				REPORT_ERROR("Error In CMD55\n");
				return (FAILED);
			}
			else
			{
				adi_emsi_GetResponse(hDev0,&g_iResponse[0]);
				if((g_iResponse[0] & STATUS_APP_CMD) ==0u)
				{
					/*APP CMD was not recognized by card*/
					/*Not Valid SD card*/
					return (FAILED);
				}
				else
				{
					/*Sending ACMD41 SD_SEND_OP_COND command*/
					ADI_EMSI_CMD_PARA CMD_PARA_APP_CMD41 = {ADI_EMSI_RESPONSE_TYPE_SHORT,ADI_EMSI_SUBCMD_TYPE_MAIN,ADI_EMSI_CMD_CRC_CHECK_DISABLE,ADI_EMSI_CMD_IDX_CHECK_DISABLE,ADI_EMSI_DATA_PRESENT_FALSE,ADI_EMSI_SND_CMD_TYPE_NORMAL};
					eResult= adi_emsi_SendCommand(hDev0,SD_SEND_OP_COND,VOLTAGE_SUPPORTED,&CMD_PARA_APP_CMD41);
					if(eResult!=ADI_EMSI_SUCCESS)
					{
						/*No response received*/
						REPORT_ERROR("Error In CMD55\n");
						return (FAILED);
					}
					/*Making g_iResponse clear*/
					g_iResponse[0] = 0x00000000;
					adi_emsi_GetResponse(hDev0,&g_iResponse[0]);
					if(g_iResponse[0] == 0x00000000)
					{
						/*Not Valid SD card*/
						return (FAILED);
					}
				}
				/*Response received*/
				iTemp1=g_iResponse[0];
			}
		}while((iTemp1&CARD_BUSY)==0);/* DO it till card return busy*/
		/*SD card supporting ver 1.x detected.*/
		printf("An SD card supporting ver 1.x detected.\n");
	}
	else
	{
		if(eResult!= ADI_EMSI_SUCCESS)
		{
			/*"Response error-> Not a valid SD card card*/
			return (FAILED);
		}

		iTemp1=g_iResponse[0];
		iTemp2=iTemp1&0xFF;

		/*Check if the check pattern echoed back correctly*/
		if(iTemp2!=CHECK_PATTERN)
		{
			/*"Check pattern did not match ! Unusable SD card !*/
			return (FAILED);
		}

		/*Check if the voltage range was accepted by the card*/
		iTemp2=iTemp1>>8;
		iTemp2&=0xFF;
		if(iTemp2!=1)
		{
			/*"Voltage range was not accepted ! Unusable SD card !*/
			return (FAILED);
		}

		/*Now send the ACMD41 command with HCS bit set - host supports SDHC cards*/
		do
		{
			/*Sending APPCMD 55 to know next command is application specific*/
			ADI_EMSI_CMD_PARA CMD_PARA_APP_CMD55 = {ADI_EMSI_RESPONSE_TYPE_SHORT,ADI_EMSI_SUBCMD_TYPE_MAIN,ADI_EMSI_CMD_CRC_CHECK_ENABLE,ADI_EMSI_CMD_IDX_CHECK_ENABLE,ADI_EMSI_DATA_PRESENT_FALSE,ADI_EMSI_SND_CMD_TYPE_NORMAL};
			eResult= adi_emsi_SendCommand(hDev0,APP_CMD,0,&CMD_PARA_APP_CMD55);
			if(eResult!=ADI_EMSI_SUCCESS)
			{
				/*No response received*/
				REPORT_ERROR("Error In CMD55\n");
				return (FAILED);
			}
			/*Making g_iResponse clear*/
			g_iResponse[0] = 0x00000000;
			adi_emsi_GetResponse(hDev0,&g_iResponse[0]);
			/*Check if a valid response to APP_CMD was received*/
			if(g_iResponse[0]!= 0u)
			{
				/*Check if the command was recognized as APP_CMD by the card*/
				if((g_iResponse[0] & STATUS_APP_CMD)==0u)
				{
					/*Error, APP_CMD bit not set in the card status*/
					return (FAILED);
				}
				else
				{
					/*Sending SD_SEND_OP_COND(ACMD41) command*/
					ADI_EMSI_CMD_PARA CMD_PARA_APP_CMD41 = {ADI_EMSI_RESPONSE_TYPE_SHORT,ADI_EMSI_SUBCMD_TYPE_MAIN,ADI_EMSI_CMD_CRC_CHECK_DISABLE,ADI_EMSI_CMD_IDX_CHECK_DISABLE,ADI_EMSI_DATA_PRESENT_FALSE,ADI_EMSI_SND_CMD_TYPE_NORMAL};
					eResult= adi_emsi_SendCommand(hDev0,SD_SEND_OP_COND,VOLTAGE_SUPPORTED|(1u<<30u),&CMD_PARA_APP_CMD41);
					if(eResult!=ADI_EMSI_SUCCESS)
					{
						/*No valid response to ACMD41 received, the card is not a valid SD card*/
						return (FAILED);
					}
					/*Making g_iResponse clear*/
					g_iResponse[0] = 0x00000000;
					adi_emsi_GetResponse(hDev0,&g_iResponse[0]);
				}
				iTemp1=g_iResponse[0];
			}
			else
			{
				/*No valid response to APP_CMD received, the card is not a valid SD card*/
				/*No response-> not a valid SD card*/
				return (FAILED);
			}
		}while((iTemp1&CARD_BUSY)==0);

		/*Check if the CCS bit of the response is set/cleared - SD/SDHC card*/
		if((iTemp1&0x40000000)==0)
		{
			printf("SD card with version 2.00 or later detected.\n");
			/*SD card with version 2.00 or later detected !*/
		}
		else
		{
			printf("SDHC card with version 2.00 or later detected.\n");
			/*SDHC card with version 2.00 or later detected !*/
		}

	}
	/*Collect CID information of the card (Sending CMD2)*/
	ADI_EMSI_CMD_PARA CMD_PARA2 ={ADI_EMSI_RESPONSE_TYPE_LONG,ADI_EMSI_SUBCMD_TYPE_MAIN,ADI_EMSI_CMD_CRC_CHECK_DISABLE,ADI_EMSI_CMD_IDX_CHECK_DISABLE,ADI_EMSI_DATA_PRESENT_FALSE,ADI_EMSI_SND_CMD_TYPE_NORMAL};
	eResult= adi_emsi_SendCommand(hDev0,ALL_SEND_CID,0x1/*stuff bits*/, &CMD_PARA2);
	if(eResult!=ADI_EMSI_SUCCESS)
	{
		REPORT_ERROR("Error In CMD2\n");
		return (FAILED);
	}
	else
	{
		/*Get the RCA of the SD card (CMD3)*/
		ADI_EMSI_CMD_PARA CMD_PARA3 ={ADI_EMSI_RESPONSE_TYPE_SHORT,ADI_EMSI_SUBCMD_TYPE_MAIN,ADI_EMSI_CMD_CRC_CHECK_DISABLE,ADI_EMSI_CMD_IDX_CHECK_DISABLE,ADI_EMSI_DATA_PRESENT_FALSE,ADI_EMSI_SND_CMD_TYPE_NORMAL};
		eResult= adi_emsi_SendCommand(hDev0,SEND_RELATIVE_ADDR,0,&CMD_PARA3);
		if(eResult!=ADI_EMSI_SUCCESS)
		{
			REPORT_ERROR("Error In CMD3\n");
			return (FAILED);
		}
		eResult=adi_emsi_GetResponse(hDev0,&g_iResponse[0]);
		if(eResult!=ADI_EMSI_SUCCESS)
		{
			REPORT_ERROR("Error in CMD3\n");
			return (FAILED);
		}
		else
		{
			/*Saving RCA published by card*/
			SDCardRCA=(g_iResponse[0]>>16)&0xFFFF;
		}
	}


	/*Identification procedure completed*/
	printf("The SD card is now in stand by state and ready for data transfer\n");

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


