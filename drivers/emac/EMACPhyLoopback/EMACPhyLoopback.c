/*********************************************************************************

Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

*********************************************************************************/
/*!
 * @file      EMACPhyLoopback.c
 * @brief     Example to demonstrate EMAC Tx/Rx data transfer in PHY loopback mode.
 *
 * @details
 *            This is the primary source file to demonstrate EMAC Tx/Rx data transfer in PHY loopback mode.
 */

/*=============  I N C L U D E S   =============*/
#include "EMACPhyLoopback.h"
/* Managed drivers and/or services include */
#include "EV-SOMCRR/SC594/arm/EMACPhyLoopback_SC594_Cortex_Core0/system/adi_initialize.h"
/* Managed drivers and/or services include */
#include "EV-SOMCRR/SC598/arm/EMACPhyLoopback_SC598_Cortex_Core0/system/adi_initialize.h"
/* Managed drivers and/or services include */
#include "EV-SOMCRR/SC594/sharc/EMACPhyLoopback_SC594_SHARC_Core1/system/adi_initialize.h"

#include <sys/adi_core.h>

/*=============  D A T A  =============*/

/* Hardware MAC address */
static uint8_t hwaddr[6] = {0xE1,0x2E,0x4F,0xFF,0x55,0xAB};

/* EMAC device handle */
static ADI_EMAC_HANDLE hemac;

/* Memory required for the driver */
uint8_t EMAC_MEMORY[ADI_EMAC_MEMORY_SIZE];

/* To store PHY API results */
ADI_EMAC_PHY_RESULT ePhyresult;

/* To store MAC API results */
ADI_EMAC_RESULT eMACResult= ADI_EMAC_SUCCESS;

/* Return value for data comparison */
int ret =0;

/* RX packet buffer*/
ADI_CACHE_ALIGN ETHER_PACKET_CHAIN emac_data_rx[NO_OF_DESCS];

/* TX packet buffer*/
ADI_CACHE_ALIGN ETHER_PACKET_CHAIN emac_data_tx[NO_OF_DESCS];

#if defined(__ADSPSC594_FAMILY__)
/* RX descriptors */
ADI_CACHE_ALIGN ADI_EMAC_DMA_DESC_ENH emac_desc_rx[NO_OF_DESCS];

/* TX descriptors */
ADI_CACHE_ALIGN ADI_EMAC_DMA_DESC_ENH emac_desc_tx[NO_OF_DESCS];

#elif defined(__ADSPSC598_FAMILY__)
/* RX descriptors */
ADI_CACHE_ALIGN ADI_EMAC_DMA_DESC emac_desc_rx[NO_OF_DESCS];

/* TX descriptors */
ADI_CACHE_ALIGN ADI_EMAC_DMA_DESC emac_desc_tx[NO_OF_DESCS];

#endif

/* Memory required for the SPU operation */
uint8_t	SpuMemory[ADI_SPU_MEMORY_SIZE];

/* SPU handle */
ADI_SPU_HANDLE	hSpu;

volatile int TxInt=0;							/* Variable to count Tx DMA interrupts */
volatile int RxInt=0;							/* Variable to count Rx DMA interrupts */
volatile int CallbackArgTx[NO_OF_DESCS];		/* Array to store Tx DMA callback arguments */
volatile int CallbackArgRx[NO_OF_DESCS];		/* Array to store Rx DMA callback arguments */

/*=============  C O D E  =============*/

/* DMA callback */
#if defined(__ADSPSC594_FAMILY__)
static void EmacDMACallback(void *pCBParam, uint32_t Event, void *pArg)
{
	uint32_t *pCallbackparamlist = (uint32_t*)pArg;

	if(Event&ADI_EMAC_EVENT_TX_PROCESSED)
	{
		CallbackArgTx[TxInt++]=pCallbackparamlist[0];
	}
	if(Event&ADI_EMAC_EVENT_RX_PROCESSED)
	{
		CallbackArgRx[RxInt++]=pCallbackparamlist[1];
	}
}

#elif defined(__ADSPSC598_FAMILY__)
/*Tx DMA callback */
static void EmacDMATxCallback(void *pCBParam, uint32_t Event, void *pArg)
{
	if(Event&ADI_EMAC_EVENT_TX_PROCESSED)
	{
		CallbackArgTx[TxInt++]=(uint32_t)(uintptr_t)pArg;
	}
}

/*Rx DMA callback */
static void EmacDMARxCallback(void *pCBParam, uint32_t Event, void *pArg)
{
	if(Event&ADI_EMAC_EVENT_RX_PROCESSED)
	{
		CallbackArgRx[RxInt++]=(uint32_t)(uintptr_t)pArg;
	}
}
#endif

/* Main function */
int main()
{
	bool busy;

    /* SPU handle */
    ADI_SPU_HANDLE      hSpu;

	/* Initialize managed drivers and/or services */
	adi_initComponents();
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif

    /* Initialize SPU Service */
    if(adi_spu_Init(0u, SpuMemory, NULL, NULL, &hSpu) != ADI_SPU_SUCCESS)
    {
        DBG_MSG("Failed to initialize SPU service\n");
        exit(-2);
    }

    /* Make EMAC0 Source to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, EMAC0_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        DBG_MSG("Failed to enable Master secure for MDMA 0 Source\n");
        exit(-2);
    }

    /* Make EMAC1 Source to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, EMAC1_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        DBG_MSG("Failed to enable Master secure for MDMA 0 Source\n");
        exit(-2);
    }

	/* Initialize PHY */
	InitializePHY();

	/* Initialize MAC */
	InitializeMAC();

	/* Register DMA data callback */
#if defined(__ADSPSC594_FAMILY__)
	eMACResult = adi_emac_RegisterDma0DataCallback (hemac, EmacDMACallback, NULL); CHECK_EMAC_RESULT(eMACResult);
#elif defined(__ADSPSC598_FAMILY__)
	eMACResult = adi_emac_RegisterTxDmaDataCallback  (hemac, 0, EmacDMATxCallback, NULL); CHECK_EMAC_RESULT(eMACResult);
	eMACResult = adi_emac_RegisterRxDmaDataCallback (hemac, 0, EmacDMARxCallback, NULL); CHECK_EMAC_RESULT(eMACResult);
#endif

	/* Prepare Tx and Rx data buffers */
	PrepareDataBuffers();

	/* Initialize descriptors */
	RxDescriptorsInit();
	TxDescriptorsInit();

	/* Enable TX and RX */
	eMACResult =  adi_emac_EnableRx(hemac,true); CHECK_EMAC_RESULT(eMACResult);
	eMACResult =  adi_emac_EnableTx(hemac,true); CHECK_EMAC_RESULT(eMACResult);

	/* Submit TX and RX descriptors */
	eMACResult = adi_emac_SubmitDescriptorListRx(hemac,0,emac_desc_rx,NO_OF_DESCS, true); CHECK_EMAC_RESULT(eMACResult);
	eMACResult = adi_emac_SubmitDescriptorListTx(hemac,0,emac_desc_tx,NO_OF_DESCS, true); CHECK_EMAC_RESULT(eMACResult);

	/* Wait for the last Rx DMA to be over using polling */
	busy=true;
#if defined(__ADSPSC594_FAMILY__)
	while(busy==true)
	{
		eMACResult =  adi_emac_IsDescriptorBusy(&emac_desc_rx[NO_OF_DESCS-1],&busy); CHECK_EMAC_RESULT(eMACResult);
	}
#elif defined(__ADSPSC598_FAMILY__)
	while(busy==true)
	{
		eMACResult =  adi_emac_IsDescriptorBusyRx(&emac_desc_rx[NO_OF_DESCS-1],&busy); CHECK_EMAC_RESULT(eMACResult);
	}
#endif

	/* Wait for Tx and Rx DMA interrupts */
	while(TxInt<NO_OF_DESCS);
	while(RxInt<NO_OF_DESCS);

	for(int i=0; i<NO_OF_DESCS; i++)
	{
		DBG_MSG("\nTx descriptor no. = %d, descriptor address = 0x%x, callback argument = 0x%x", i, CallbackArgTx[i], (unsigned int)(uintptr_t)&emac_desc_tx[i]);
		DBG_MSG("\nRx descriptor no. = %d, descriptor address = 0x%x, callback argument = 0x%x", i, CallbackArgRx[i], (unsigned int)(uintptr_t)&emac_desc_rx[i]);
	}

	/* Compare RX data with TX data */
	if(ComnpareTxRxBuffers())
	{
		printf ("\n\nAll done\n");
	}
	else
	{
		printf ("\n\nFailed\n");
	}

	/* Close EMAC device */
	eMACResult=adi_emac_Close(hemac);
	CHECK_EMAC_RESULT(eMACResult);

	return 0;
}

void InitializePHY(void)
{

	uint16_t deviceid[2], lstat;

	/* Reset PHY */
	ResetPHY();

#ifdef TEST_EMAC0
	/* Reset EMAC */
	adi_pads_Config((ADI_GPIO_PADS_CFG)(BITM_PADS_PCFG0_EMACRESET|(ADI_EMAC_PHY_EMACPHYISEL_RGMII<<BITP_PADS_PCFG0_EMACPHYISEL)),true);
#endif

	/* Open EMAC device */
	eMACResult=adi_emac_Open(EMAC_DEVICE_NO,EMAC_MEMORY,ADI_EMAC_MEMORY_SIZE,&hemac);
	CHECK_EMAC_RESULT(eMACResult);

#if defined(__ADSPSC594_FAMILY__)
	/* Configure PHY device address and SCLK range*/
	ePhyresult=adi_emac_phy_Config(hemac,PHY_DEVICE_ADD, ADI_SCLK_RANGE_100_150);
	CHECK_EMAC_RESULT(ePhyresult);
#elif defined(__ADSPSC598_FAMILY__)
	/* Configure both EMAC0 and EAMC1 blocks as little endian */
	adi_pads_Config((ADI_GPIO_PADS_CFG)(EMAC0_ENDIANNESS|EMAC1_ENDIANNESS),false);

	/* Configure PHY device address and SCLK range*/
	ePhyresult=adi_emac_phy_Config(hemac,PHY_DEVICE_ADD, ADI_SCLK_RANGE_100_150, false, false, 0, false, false);
	CHECK_EMAC_RESULT(ePhyresult);
#endif

	/* Read PHY device ID */
	ePhyresult=adi_emac_phy_GetBasicPhyIdentifiers(hemac,deviceid);
	CHECK_EMAC_RESULT(ePhyresult);
	DBG_MSG("\nPHY identifiers are 0x%x and 0x%x...\n", deviceid[0], deviceid[1]);

	/* Issue soft reset to PHY */
	ePhyresult=adi_emac_phy_IssueSoftReset(hemac);
	CHECK_EMAC_RESULT(ePhyresult);
	DBG_MSG("\nPHY reset successful...\n");

	/* Disable auto-negotiation */
	ePhyresult=adi_emac_phy_AutonegEnable(hemac,false);CHECK_EMAC_RESULT(ePhyresult);

#ifdef TEST_EMAC0
	/* Configure basic PHY parameters - 1 Gbps, Full Duplex, Collision Test Disabled */
	ePhyresult=adi_emac_phy_SetBasicConfiguration(hemac, true, ADI_EMAC_PHY_SPEED_1000, false); CHECK_EMAC_RESULT(ePhyresult);
#else
	/* Configure basic PHY parameters - 100 Mbps, Full Duplex, Collision Test Disabled */
	ePhyresult=adi_emac_phy_SetBasicConfiguration(hemac, true, ADI_EMAC_PHY_SPEED_100, false); CHECK_EMAC_RESULT(ePhyresult);
#endif

	#ifdef	EMAC_PHY_ADIN1300

		/* Enable loop back mode */
		ePhyresult=adi_emac_phy_LoopbackEnable(hemac,true);
		CHECK_EMAC_RESULT(ePhyresult);

		/* Enable all digital loopback - specific to ADIN1300 PHY */
		ePhyresult=adi_emac_phy_RegisterWrite(hemac,ADIN1300_PHY_CTRL_STATUS_1_REG,ADIN1300_PHY_CTRL_STATUS_1_REG_LB_MII_LS_OK|ADIN1300_PHY_CTRL_STATUS_1_REG_LB_ALL_DIG_SEL);
		CHECK_EMAC_RESULT(ePhyresult);

		/* Wait till PHY link is up and read PHY configuration  */
		do
		{
			ePhyresult = adi_emac_phy_RegisterRead(hemac,ADIN1300_PHY_STATUS_1_REG,&lstat);	CHECK_EMAC_RESULT(ePhyresult);

		} while(!(lstat & ADIN1300_PHY_STATUS_1_REG_LINK_STAT));
		printf("\nPHY Link Established...\n");


		/* Read and print PHY configuration */
		lstat = (lstat>>ADIN1300_PHY_STATUS_1_REG_HCD_TECH_BITP)&0x7;

		if (lstat == ADIN1300_PHY_STATUS_1_REG_1000FD)
		{
			printf("\nFull Duplex 1000 base T...\n");
			eMACResult=adi_emac_ConfigureMACSpeed(hemac,ADI_EMAC_MAC_SPEED_1000M);
			CHECK_EMAC_RESULT(eMACResult);
		}
		else
		{
			if (lstat == ADIN1300_PHY_STATUS_1_REG_1000HD)
			{
				printf("\nHalf Duplex 1000 base T...\n");
			}

			if (lstat == ADIN1300_PHY_STATUS_1_REG_100FD)
			{
				printf("\nFull Duplex 100 base T...\n");
			}

			if (lstat == ADIN1300_PHY_STATUS_1_REG_100HD)
			{
				printf("\nHalf Duplex 1000 base T...\n");
			}

			if (lstat == ADIN1300_PHY_STATUS_1_REG_10FD)
			{
				printf("\nFull Duplex 10 base T...\n");
			}
			if (lstat == ADIN1300_PHY_STATUS_1_REG_10HD)
			{
				printf("\nHalf Duplex 10 base T...\n");
			}
			else
			{
				printf("\nReserved..\n");
			}
		}
	#endif

	#ifdef	EMAC_PHY_ADIN1200

		/* Enable loop back mode */
		ePhyresult=adi_emac_phy_LoopbackEnable(hemac,true);
		CHECK_EMAC_RESULT(ePhyresult);

		/* Enable all digital loopback - specific to ADIN1300 PHY */
		ePhyresult=adi_emac_phy_RegisterWrite(hemac,ADIN1200_PHY_CTRL_STATUS_1_REG,ADIN1200_PHY_CTRL_STATUS_1_REG_LB_MII_LS_OK|ADIN1200_PHY_CTRL_STATUS_1_REG_LB_ALL_DIG_SEL);
		CHECK_EMAC_RESULT(ePhyresult);

		/* Wait till PHY link is up and read PHY configuration  */
		do
		{
			ePhyresult = adi_emac_phy_RegisterRead(hemac,ADIN1200_PHY_STATUS_1_REG,&lstat);	CHECK_EMAC_RESULT(ePhyresult);

		} while(!(lstat & ADIN1200_PHY_STATUS_1_REG_LINK_STAT));
		printf("\nPHY Link Established...\n");


		/* Read and print PHY configuration */
		lstat = (lstat>>ADIN1200_PHY_STATUS_1_REG_HCD_TECH_BITP)&0x7;

		if (lstat == ADIN1200_PHY_STATUS_1_REG_100FD)
		{
			printf("\nFull Duplex 100 base T...\n");
			eMACResult=adi_emac_ConfigureMACSpeed(hemac,ADI_EMAC_MAC_SPEED_100M);
			CHECK_EMAC_RESULT(eMACResult);
		}
		else
		{
			if (lstat == ADIN1200_PHY_STATUS_1_REG_100HD)
			{
				printf("\nHalf Duplex 1000 base T...\n");
			}

			if (lstat == ADIN1200_PHY_STATUS_1_REG_10FD)
			{
				printf("\nFull Duplex 10 base T...\n");
			}
			if (lstat == ADIN1200_PHY_STATUS_1_REG_10HD)
			{
				printf("\nHalf Duplex 10 base T...\n");
			}
			else
			{
				printf("\nReserved..\n");
			}
		}
	#endif

}

/* Function to initialize EMAC controller */
void InitializeMAC(void)
{

	ADI_EMAC_RESULT  eMACResult = ADI_EMAC_SUCCESS;

	/* Set MAC address */
	eMACResult = adi_emac_SetMACAddress(hemac,0, hwaddr); CHECK_EMAC_RESULT(eMACResult);

#if defined(__ADSPSC594_FAMILY__)
	/* Configure DMA burst - 32 bytes burst for TX, 1 byte burst for RX, fixed burst - false, PBL8 = false*/
	eMACResult = adi_emac_ConfigureDMABurst(hemac, 0, ADI_EMAC_TRANSMIT_32, ADI_EMAC_RECEIVE_BL_32, false, false); CHECK_EMAC_RESULT(eMACResult);
#endif

	/* MAC configuration - enable duplex mode  */
	eMACResult = adi_emac_EnableMACConfigurationModes(hemac, ADI_EMAC_MAC_CONFIG_DUPLEX_ENABLE); CHECK_EMAC_RESULT(eMACResult);

	/* Configure RX frame filters - no filters, pass all types of frames */
	eMACResult = adi_emac_EnableRXFrameFilters(hemac, ADI_EMAC_MACFRMFILT_RA|ADI_EMAC_MACFRMFILT_PAC|ADI_EMAC_MACFRMFILT_PM|ADI_EMAC_MACFRMFILT_PR);	CHECK_EMAC_RESULT(eMACResult);

#if defined(__ADSPSC598_FAMILY__)
	/* Configure DMA burst - 32 bytes burst for TX, 1 byte burst for RX, fixed burst - false, PBL8 = false*/
	eMACResult = adi_emac_ConfigureDMABurst(hemac, 0, ADI_EMAC_TRANSMIT_32, ADI_EMAC_RECEIVE_BL_32, false); CHECK_EMAC_RESULT(eMACResult);

#ifdef TEST_EMAC0
	/* Configure SCB interface */
	eMACResult = adi_emac_ConfigureSCBInterface (hemac, 16, 16, ADI_EMAC_SCB_BURSTMODE_16_8_4, false, false, false);CHECK_EMAC_RESULT(eMACResult);
#else
	eMACResult = adi_emac_ConfigureSCBInterface (hemac, 4, 4, ADI_EMAC_SCB_BURSTMODE_16_8_4, false, false, false);CHECK_EMAC_RESULT(eMACResult);
#endif

	/* Configure RX buffer size  */
	eMACResult = adi_emac_SetRxBuffSizeLimit(hemac, 0, false, RX_BUFFER_SIZE, 0); CHECK_EMAC_RESULT(eMACResult);


#ifdef TEST_EMAC0
	/* Enable Tx Queue 0 */
	eMACResult = adi_emac_EnableTxQueue(hemac, 0, ADI_EMAC_TXQ_ENABLE_GEN); CHECK_EMAC_RESULT(eMACResult);

	/* Use maximum queue size for EMAC0 = 64*256 = 16384 bytes */
	eMACResult = adi_emac_SetTxQueueSize(hemac, 0, 63); CHECK_EMAC_RESULT(eMACResult);

	/* Enable Rx Queue 0 */
	eMACResult = adi_emac_EnableRxQueue(hemac, 0, ADI_EMAC_RXQ_ENABLE_DCB_GEN); CHECK_EMAC_RESULT(eMACResult);

	/* Use maximum queue size for EMAC0 = 64*256 = 16384 bytes */
	eMACResult = adi_emac_SetRxQueueSize(hemac, 0, 63); CHECK_EMAC_RESULT(eMACResult);

#endif

	/* Configure opmode settings for Tx queue 0 */
	eMACResult = adi_emac_SetTxQueueOpmode(hemac, 0, false, ADI_EMAC_OPMODE_TTC_32); CHECK_EMAC_RESULT(eMACResult);

	/* Configure opmode settings for Rx queue 0 */
	eMACResult = adi_emac_SetRxQueueOpmode(hemac, 0, false, false, false, ADI_EMAC_OPMODE_RTC_64); CHECK_EMAC_RESULT(eMACResult);

	/* Configure DMA in OSF mode if needed */
	eMACResult = adi_emac_TxDMAEnableOSFMode(hemac, 0, true); CHECK_EMAC_RESULT(eMACResult);
#endif

#ifdef TEST_EMAC0

	uint32_t Mlstat=0;

    /* Check GIGE MAC link status */
	eMACResult =  adi_emac_GigELinkStatus(hemac,&Mlstat); CHECK_EMAC_RESULT(eMACResult);

	if(Mlstat & ADI_EMAC_MAC_GIGE_LINK_UP)
	{
		DBG_MSG("\nGIGE MAC Link Status: Link up, Link Speed: ");
	}
	if(Mlstat & ADI_EMAC_MAC_GIGE_LINK_SPEED_125M)
	{
		DBG_MSG(" GigE ");
	}
	else if(Mlstat & ADI_EMAC_MAC_GIGE_LINK_SPEED_25M)
	{
		DBG_MSG(" 100 ");
	}
	else
	{
		DBG_MSG(" 10 ");
	}
	if(Mlstat & ADI_EMAC_MAC_GIGE_LINK_FULLDUPLEX)
	{
		DBG_MSG(" and Full Duplex...\n");
	}
	else
	{
		DBG_MSG(" and Half Duplex...\n");
	}
#endif
}

/* Function to issue a hard reset to the PHY. Minimum reset pulse width timing requirement for both DP83867 and DP83848 is 1 us */
void ResetPHY(void)
{
	volatile int i;

	#if  defined(EV_SOMCRR_EZKIT_SUPPORT)
		SoftConfig_EVAL_EZKIT_SOM_EMAC_Reset_Low();
		for(i=0;i<0x100000;i++);
		SoftConfig_EVAL_EZKIT_SOM_EMAC_Reset_High();
		for(i=0;i<0x100000;i++);
	#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
		SoftConfig_EVAL_EZLITE_SOM_EMAC_Reset_Low();
		for(i=0;i<0x100000;i++);
		SoftConfig_EVAL_EZLITE_SOM_EMAC_Reset_High();
		for(i=0;i<0x100000;i++);
	#endif
}

/* Function to initialize Tx and Rx buffers */
void PrepareDataBuffers(void)
{
	int k,i;

	for(k=0;k<NO_OF_DESCS;k++)
	{
		for(i=0;i<FRAME_SIZE;i++)
		{
			emac_data_tx[k].data[i] = rand()%255;
			emac_data_rx[k].data[i] = 0;
		}
		emac_data_tx[k].length[1] = (FRAME_SIZE & 0x00FF);
		emac_data_tx[k].length[0] = (FRAME_SIZE & 0xFF00)>>8;
	}
}

/* Function to initialize TX descriptor chain */
void TxDescriptorsInit(void)
{
        int desc_cnt = 0;

#if defined(__ADSPSC598_FAMILY__)
        for(desc_cnt=0;desc_cnt<NO_OF_DESCS;desc_cnt++)
        {
            emac_desc_tx[desc_cnt].TxDescRead.Buffer1		= 	(uint32_t)(uintptr_t)&emac_data_tx[desc_cnt];
            emac_desc_tx[desc_cnt].TxDescRead.BufferLen	= 	(FRAME_SIZE+HEADER_SIZE_TX)&ADI_EMAC_TX_DESC_READ_HB1LEN_BITM ;
            emac_desc_tx[desc_cnt].TxDescRead.BufferLen 	|=	 ADI_EMAC_TX_DESC_READ_IOC;
            emac_desc_tx[desc_cnt].TxDescRead.FrameLenCtrl	= 	(FRAME_SIZE+HEADER_SIZE_TX)&ADI_EMAC_TX_DESC_READ_PL_BITM;
            emac_desc_tx[desc_cnt].TxDescRead.FrameLenCtrl	|= 	ADI_EMAC_TX_DESC_READ_OWN|ADI_EMAC_TX_DESC_READ_FD|ADI_EMAC_TX_DESC_READ_LD;
       }
#elif defined(__ADSPSC594_FAMILY__)
        for(desc_cnt=0;desc_cnt<NO_OF_DESCS;desc_cnt++)
        {
            emac_desc_tx[desc_cnt].Status      	= ADI_EMAC_TX_DESC_FIRST | ADI_EMAC_TX_DESC_LAST|ADI_EMAC_TX_DESC_OWN|ADI_EMAC_TX_DESC_INT_ENABLE;
            emac_desc_tx[desc_cnt].Length 		= (FRAME_SIZE+HEADER_SIZE_TX) ;
            emac_desc_tx[desc_cnt].Buffer1   	= (void*)&emac_data_tx[desc_cnt];
            emac_desc_tx[desc_cnt].NextDesc   	= &emac_desc_tx[desc_cnt+1];
            emac_desc_tx[desc_cnt].Status     	|= ADI_EMAC_TX_DESC_CHAIN;
        }
        emac_desc_tx[NO_OF_DESCS-1].Status     |= ADI_EMAC_TX_DESC_ENDOFRING;
        emac_desc_tx[NO_OF_DESCS-1].NextDesc   = &emac_desc_tx[0];
#endif

}

/* Function to initialize RX descriptor chain */
void RxDescriptorsInit(void)
{
        int desc_cnt = 0;

#if defined(__ADSPSC598_FAMILY__)
        for(desc_cnt=0;desc_cnt<NO_OF_DESCS;desc_cnt++)
        {
            emac_desc_rx[desc_cnt].RxDescRead.Buffer1   	= 	(uint32_t)(uintptr_t)&emac_data_rx[desc_cnt];
            emac_desc_rx[desc_cnt].RxDescRead.Status  		= 	ADI_EMAC_RX_DESC_READ_OWN|ADI_EMAC_RX_DESC_READ_BUF1V|ADI_EMAC_RX_DESC_READ_IOC;
        }
#elif defined(__ADSPSC594_FAMILY__)
        for(desc_cnt=0;desc_cnt<NO_OF_DESCS;desc_cnt++)
        {
            emac_desc_rx[desc_cnt].Status      	= 	(uint32_t)ADI_EMAC_RX_DESC_OWN;;
            emac_desc_rx[desc_cnt].Length 		= 	(FRAME_SIZE+HEADER_SIZE_RX+FRAME_SIZE_DELIMIT) ;
            emac_desc_rx[desc_cnt].Buffer1   	= 	(void*)&emac_data_rx[desc_cnt];
            emac_desc_rx[desc_cnt].NextDesc   	= 	&emac_desc_rx[desc_cnt+1];
            emac_desc_rx[desc_cnt].Length 		|=	ADI_EMAC_RX_DESC_CHAIN;
        }
        emac_desc_rx[NO_OF_DESCS-1].Length |= ADI_EMAC_RX_DESC_ENDOFRING;
        emac_desc_rx[NO_OF_DESCS-1].NextDesc   = &emac_desc_rx[0];
#endif
}

/* Function to compare RX data with TX data */
int ComnpareTxRxBuffers(void)
{
    int i = 0;
    int k = 0;

    for(k=0;k<NO_OF_DESCS;k++)
    {
    	for(i=0;i<FRAME_SIZE;i++)
    	{
    	 	 if(emac_data_tx[k].data[i]   != emac_data_rx[k].data[i])
    	 	 {
    	 		 return 0;
    	 	 }
    	}
    }
    return 1;
}

/*****/

/*
** EOF
*/
