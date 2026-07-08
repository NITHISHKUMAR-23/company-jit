/*********************************************************************************
Copyright(c) 2021-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*****************************************************************************
 * main.c
 *****************************************************************************/

#include "main.h"

#include <stdlib.h>
#include <sys/adi_core.h>
#include <sys/platform.h>
#include "adi_initialize.h"
#include <stdio.h>

/**
 * If you want to use command program arguments, then place them in the following string.
 */

/* CRC Device Handle */
static ADI_CRC_HANDLE   hCrcDev;
/* Memory to handle CRC Device */
static uint8_t          CrcDevMem[ADI_CRC_DMA_MEMORY_SIZE];

ADI_CACHE_ALIGN static uint32_t DataBuf[ADI_CACHE_ROUND_UP_SIZE(CRC_BUF_NUM_ELEMENTS, uint32_t)];
/* Memory required for the SPU operation */
static uint8_t          SpuMemory[ADI_SPU_MEMORY_SIZE];
/* SPU handle */
static ADI_SPU_HANDLE   hSpu;

volatile bool bCrcInProgress=true;
uint32_t adi_pwr_cfg0_init(void);
static void CrcCallback(void *pCBParam, uint32_t Event, void *pArg)
{

	bCrcInProgress = false;
    /* IF (Processed a CRC buffer) */
    if (Event == ADI_CRC_EVENT_DATA_COUNT_EXPIRED)
    {
        /* Update CRC status flag */
        bCrcInProgress = false;
    }
    /* ELSE IF (DMA Error) */
    else if (Event == ADI_CRC_EVENT_DMA_ERROR)
    {
        DEBUG_PRINT("CRC Callback - DMA error\n");
    }
    /* ELSE (Other events) */
    else
    {
        DEBUG_PRINT("CRC Callback - event 0x%08X\n", (unsigned int)Event);
    }

}

static void FillDataBuf (void)
{
    /* Loop variable */
    uint32_t        i;

    /* Compare the destination data with source */
    for (i = 0u; i < CRC_BUF_NUM_ELEMENTS; i++)
    {
      DataBuf[i] = rand();
     }


}
char __argv_string[] = "";

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
	
    ADI_CRC_RESULT	eResult = ADI_CRC_SUCCESS;
	uint32_t ExpecCrc,ReadCrc;
	/**
	 * Initialize managed drivers and/or services that have been added to
	 * the project.
	 * @return zero on success
	 */

	adi_pwr_cfg0_init();


	if(adi_spu_Init(0u, SpuMemory, NULL, NULL, &hSpu) != ADI_SPU_SUCCESS)
	{
		DEBUG_PRINT("Failed to initialize SPU service\n");

	}


	/* Make MDMA0 Source (CRC0) to generate secure transactions */
	if(adi_spu_EnableMasterSecure(hSpu, MDMASRCID, true) != ADI_SPU_SUCCESS)
	{
		DEBUG_PRINT("Failed to enable Master secure for MDMA 0 Source\n");


	}

	/* Make MDMA0 Destination (CRC0) to generate secure transactions */
	if(adi_spu_EnableMasterSecure(hSpu, MDMADSTID, true) != ADI_SPU_SUCCESS)
	{
		DEBUG_PRINT("Failed to enable Master secure for MDMA 0 Destination\n");
	}

	/* Open CRC device and initialize it with static configuration */
	eResult = adi_crc_Open (CRC_DEV_NUM, &CrcDevMem[0], MEM, &hCrcDev);

	/* Enable DMA mode for CRC */
	eResult = adi_crc_EnableDmaMode (hCrcDev, true);
	CHECK_RESULT(eResult);

	/* Set CRC DMA Callback function */
	eResult = adi_crc_RegisterCallback (hCrcDev, CrcCallback, hCrcDev);
	CHECK_RESULT(eResult);

    /* Fill in data buffer*/
	FillDataBuf();

    /* Expected CRC of the data buffer*/
	ExpecCrc = EXPECTED_CRC;

	eResult=adi_crc_SetExpectedVal(hCrcDev,ExpecCrc);
	CHECK_RESULT(eResult);

    /* Enable CRC is memory scan and compute mode*/
	eResult =  adi_crc_MemScan(hCrcDev, MODE,&DataBuf[0], CRC_BUF_NUM_ELEMENTS);
	CHECK_RESULT(eResult);

	/* Verify CRC data */
	while(bCrcInProgress==true);

	eResult=adi_crc_GetFinalCrcVal(hCrcDev,&ReadCrc);
	CHECK_RESULT(eResult);

	if(ReadCrc !=ExpecCrc)
		DEBUG_PRINT("CRC computation failed\n");
	else
		DEBUG_PRINT("CRC computation passed\n");

	/* Closes a CRC device instance */
	eResult = adi_crc_Close (hCrcDev);
	CHECK_RESULT(eResult);

	/* End of execution */
	DEBUG_PRINT("All done\n");
	
    return 0;
}

