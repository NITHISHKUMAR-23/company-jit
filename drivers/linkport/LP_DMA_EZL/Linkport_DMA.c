/*********************************************************************************
Copyright(c) 2019-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/
 
/*****************************************************************************
 * Linkport_DMA_Example.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "Linkport_DMA.h"

#if defined(__ADSPSC598_FAMILY__)
void SoftConfig_EV_SC598_SOM(void);
#endif

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
	
#if defined(__ADSPSC598_FAMILY__)
   	SoftConfig_EV_SC598_SOM();
#endif

	/* Begin adding your custom code here */
	unsigned int  elpResult,elpResult1;
	ADI_LINKPORT_TRANSFER_MODE eTransferMode;

	//Disable the Fault functionality to use the pin PC_07 as Link port1 Clock
	*pREG_PADS0_PCFG0 |= BITM_PADS_PCFG0_FAULT_DIS;

	//Configure the SPU correspond to Linkport and Linkport DMAs
	adi_spu_EnableMasterSlaveSecure(3,true,true);
	adi_spu_EnableMasterSlaveSecure(4,true,true);
	adi_spu_EnableMasterSlaveSecure(5,true,true);
	adi_spu_EnableMasterSlaveSecure(6,true,true);

	elpResult = adi_linkport_Open(0,ADI_LINKPORT_DIR_TX,linkport_mem0,LINKPORT_MEM_SIZE,&hDevice0);
	if(elpResult != ADI_LINKPORT_SUCCESS)
		printf("Device 0 open failed\n");

	elpResult1 = adi_linkport_Open(1,ADI_LINKPORT_DIR_RX,linkport_mem1,LINKPORT_MEM_SIZE,&hDevice1);
	if(elpResult1 != ADI_LINKPORT_SUCCESS)
		printf("Device 1 open failed\n");

	elpResult1 = adi_linkport_ConfigClock(hDevice0,LP0_CLK_DIV);
	if(elpResult1 != ADI_LINKPORT_SUCCESS)
		printf("Device 0 clock configuration failed\n");

	elpResult=0;elpResult1=0;

	elpResult1 = adi_linkport_RegisterCallback(hDevice0,LINKPORTCallback0,NULL);
	if(elpResult1 != ADI_LINKPORT_SUCCESS)
		printf("LP0 Callback registering failed\n");

	elpResult = adi_linkport_RegisterCallback(hDevice1,LINKPORTCallback1,NULL);
	if(elpResult != ADI_LINKPORT_SUCCESS)
		printf("LP1 Callback registering failed\n");

#ifdef TEST_LINKPORT_SDR_8BIT_TRANSFER_MODE
	eTransferMode = ADI_LINKPORT_SDR_8BIT_TRANSFER_MODE;
#elif defined TEST_LINKPORT_SDR_4BIT_TRANSFER_MODE
	eTransferMode = ADI_LINKPORT_SDR_4BIT_TRANSFER_MODE;
#elif defined TEST_LINKPORT_SDR_2BIT_TRANSFER_MODE
	eTransferMode = ADI_LINKPORT_SDR_2BIT_TRANSFER_MODE;
#elif defined TEST_LINKPORT_DDR_4BIT_TRANSFER_MODE
	eTransferMode = ADI_LINKPORT_DDR_4BIT_TRANSFER_MODE;
#elif defined TEST_LINKPORT_DDR_2BIT_TRANSFER_MODE
	eTransferMode = ADI_LINKPORT_DDR_2BIT_TRANSFER_MODE;
#endif

	elpResult = adi_linkport_ConfigTransferMode(hDevice0,eTransferMode);
	if(elpResult != ADI_LINKPORT_SUCCESS)
		printf("Tx Callback registering failed\n");

	elpResult = adi_linkport_ConfigTransferMode(hDevice1,eTransferMode);
	if(elpResult != ADI_LINKPORT_SUCCESS)
		printf("Tx Callback registering failed\n");

	elpResult=0;elpResult1=0;

	InitBuffers();

	/* Setup Source DMA */
#if defined(__ADSPCORTEXA55__)
	LP0_Desc.pStartAddr            = (uint32_t)(uintptr_t)&nBufferTx0[0];
#else
	LP0_Desc.pStartAddr            = (void *)&nBufferTx0[0];
#endif
	LP0_Desc.XCount                = SIZE_OF_BUFFER;
	LP0_Desc.XModify               = 4u;
	LP0_Desc.Config                = ENUM_DMA_CFG_XCNT_INT;

	/* Setup Destination DMA */
#if defined(__ADSPCORTEXA55__)
	LP1_Desc.pStartAddr           = (uint32_t)(uintptr_t)&nBufferRx1[0];
#else
	LP1_Desc.pStartAddr           = (void *)&nBufferRx1[0];
#endif
	LP1_Desc.XCount               = SIZE_OF_BUFFER;
	LP1_Desc.XModify              = 4u;
	LP1_Desc.Config               = ENUM_DMA_CFG_XCNT_INT;

	elpResult1 = adi_linkport_DMATransfer(hDevice0,&LP0_Desc,1,ADI_PDMA_STOP_MODE);
	if(elpResult1 != ADI_LINKPORT_SUCCESS)
			printf("Device receiver configuration failed\n");

	elpResult = adi_linkport_DMATransfer(hDevice1,&LP1_Desc,1,ADI_PDMA_STOP_MODE);
			if(elpResult != ADI_LINKPORT_SUCCESS)
					printf("Device transmitter configuration failed\n");

	while(1)
	{
		if((nCallbackCounter0 == 1u)&& (nCallbackCounter1 == 1u))
		{
			printf("Transfer is done\n");
			break;
		}
	}

	elpResult=0; elpResult1=0;

	int err=0;

	printf("\n LP0 - LP1 test observation \n");
	err=Compare_Data((uint32_t *)nBufferTx0,(uint32_t *)nBufferRx1,SIZE_OF_BUFFER);
	if(err==0)
	printf("Data matches\n");
	else
	printf("\n %d transfers Failed \n", err);

	elpResult1 = adi_linkport_Close(hDevice0);
	if(elpResult1 != ADI_LINKPORT_SUCCESS)
	 printf("Device 0 close failed\n");

	elpResult = adi_linkport_Close(hDevice1);
	if(elpResult != ADI_LINKPORT_SUCCESS)
	 printf("Device 1 close failed\n");

	printf("All Done\n");

	return 0;
	}

int Compare_Data(uint32_t *pSource, uint32_t *pDestination, uint32_t iXCount)
{
	int i = 0;
	int iErrorCount = 0;

	int source_test;
	int destination_test;

	for(i = 0; i < iXCount; i++)
	{
		source_test=*pSource++;
		destination_test=*pDestination++;
		if(source_test != destination_test)
		{
			iErrorCount++;
			printf("\n Expected data %x  Actual data %x", source_test, destination_test);
		}

	}

	return iErrorCount;
}


void fillData(uint32_t *pBuff, int pattern )
{
	uint32_t i;

	for(i=0u; i< SIZE_OF_BUFFER; i++)
	{
		if(pattern == INC_PATTERN)
		{
			pBuff[i]= 0x12340000 + i;
		}
		else if(pattern == RAND_PATTERN)
		{
			pBuff[i]= (uint32_t)rand();
		}
		else
		{
			pBuff[i]= pattern;
		}
	}

}

void InitBuffers(void)
{
	fillData((uint32_t *)nBufferTx0, INC_PATTERN);
	fillData((uint32_t *)nBufferTx1, INC_PATTERN);

	fillData((uint32_t *)nBufferRx0, 0xEDEDEDED);
	fillData((uint32_t *)nBufferRx1, 0xEDEDEDED);
}

static void LINKPORTCallback0(void *pCBParam, uint32_t   Event, void  *pArg)
{
	switch (Event)
	{
		case ADI_LINKPORT_EVENT_DMA_PROCESSED:
			nCallbackCounter0 += 1u;
			break;
		default:
			break;
	}

}


static void LINKPORTCallback1(void *pCBParam, uint32_t   Event, void  *pArg)
{
	switch (Event)
	{
		case ADI_LINKPORT_EVENT_DMA_PROCESSED:
			nCallbackCounter1 += 1u;
			break;
		default:
			break;
	}
}

