/*********************************************************************************
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*****************************************************************************
 * TRNG_ReadRandomNum.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "TRNG_ReadRandomNum.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>

#include <services/pkic/adi_pkic.h>
#include <drivers/crypto/adi_trng.h>

/**
 * If you want to use command program arguments, then place them in the following string.
 */
char __argv_string[] = "";

/* Memory required for the operation of TRNG driver */
static uint8_t gtrngMemory[ADI_TRNG_MEMORY_SIZE];

/* Result*/
ADI_TRNG_RESULT eResult;

/* TRNG driver handle */
static ADI_TRNG_HANDLE ghtrng;

/* buffer to hold Random numbers */
static uint32_t  RandomNum[8];
int i;

#if PERFORM_NONBLOCKINGMODE
static void Callback(void *pCBParam, uint32_t nEvent, void *pEventArg);
#endif

#if PERFORM_NONBLOCKINGMODE

/**
 * @brief       TRNG driver callback.
 *
 * @details     TRNG driver callback.
 *
 * @param [in]  pCBParam     Driver handle info
 * @param [in]  nEvent       Event type
 * @param [in]  pEventArg    Event argument
 *
 */
bool bChnlComplete = false;

static void Callback(void *pCBParam, uint32_t nEvent, void *pEventArg)
{
	switch((ADI_TRNG_EVENT)nEvent)
	{
	/*! Conversion of the given channel is complete. Then event argument
	 *  indicates the completed channel number. */
	case ADI_TRNG_EVENT_READY:
		bChnlComplete = true;
		break;

	default:
		break;
	}

	return;
}
#endif

#if USE_STATIC_CONFIG == 0
ADI_TRNG_LIST trngList1;
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

#if USE_STATIC_CONFIG
	eResult = adi_TRNG_Open(&ghtrng,&gtrngMemory,sizeof(gtrngMemory));
	if(eResult != ADI_TRNG_SUCCESS)
	{
		printf("Error opening TRNG\n");
	}
#else
	trngList1.startUpcyc = (uint32_t)0;
	trngList1.maxRefcyc  = (uint32_t)0;
	trngList1.minRefcyc  = (uint32_t)0;
	trngList1.sampleDiv  = (uint32_t)0;
	trngList1.almThresh  = (uint32_t)255;
	trngList1.shdnThresh = (uint32_t)7;
	trngList1.shdnfatal  = false;
	trngList1.enable_postProcessor  = false;

	eResult = adi_TRNG_Open(&ghtrng,&gtrngMemory,sizeof(gtrngMemory));
	if(eResult != ADI_TRNG_SUCCESS)
	{
		printf("Error opening TRNG\n");
	}

	eResult = adi_TRNG_Config(ghtrng,&trngList1);
	if(eResult != ADI_TRNG_SUCCESS)
	{
		printf("Error configuring TRNG\n");
	}
#endif

#if PERFORM_NONBLOCKINGMODE

	memset(RandomNum,0,32);

	eResult = adi_TRNG_GetOutput(ghtrng, Callback,ghtrng, RandomNum,ADI_TRNG_192_BITS);
	if(eResult != ADI_TRNG_SUCCESS)
	{
		printf("Failed to read Random numbers \n");
	}

	/* If the conversion sequence event is reported */
	while(bChnlComplete != true)
	{
#if defined(__ADSPCORTEXA5__) || defined(__ADSPCORTEXA55__)
  __asm__("dsb sy");
 #elif defined (__ADSPSHARC__)
     asm volatile("sync;");
 #endif
	}

	bChnlComplete = false;

	for(i=0; i<8;i++)
	{
#if defined(__ADSPCORTEXA5__)
		printf("%lX\n",RandomNum[i]);
#else
		printf("%X\n",RandomNum[i]);
#endif
	}
	printf("\n");

	memset(RandomNum,0,32);

	eResult = adi_TRNG_GetOutput(ghtrng, Callback,ghtrng, RandomNum,ADI_TRNG_256_BITS);
	if(eResult != ADI_TRNG_SUCCESS)
	{
		printf("Failed to read Random numbers \n");
	}

	/* If the conversion sequence event is reported */
	while(bChnlComplete != true)
	{
#if defined(__ADSPCORTEXA5__) || defined(__ADSPCORTEXA55__)
  __asm__("dsb sy");
 #elif defined (__ADSPSHARC__)
     asm volatile("sync;");
 #endif
	}

	bChnlComplete = false;
	
	for(i=0; i<8;i++)
	{
#if defined(__ADSPCORTEXA5__)
		printf("%lX\n",RandomNum[i]);
#else
		printf("%X\n",RandomNum[i]);
#endif
	}
	printf("\n");

	memset(RandomNum,0,32);

	eResult = adi_TRNG_GetOutput(ghtrng, Callback,ghtrng, RandomNum,ADI_TRNG_64_BITS);
	if(eResult != ADI_TRNG_SUCCESS)
	{
		printf("Failed to start Random number generation \n");
	}

	/* If the conversion sequence event is reported */
	while(bChnlComplete != true)
	{
#if defined(__ADSPCORTEXA5__) || defined(__ADSPCORTEXA55__)
  __asm__("dsb sy");
 #elif defined (__ADSPSHARC__)
     asm volatile("sync;");
 #endif
	}

	bChnlComplete = false;

	for(i=0; i<8;i++)
	{
#if defined(__ADSPCORTEXA5__)
		printf("%lX\n",RandomNum[i]);
#else
		printf("%X\n",RandomNum[i]);
#endif
	}
	printf("\n");

#endif

#if PERFORM_BLOCKINGMODE
	memset(RandomNum,0,32);

	eResult = adi_TRNG_Read_Output(ghtrng,RandomNum,ADI_TRNG_192_BITS);
	if(eResult != ADI_TRNG_SUCCESS)
	{
		printf("Failed to read Random numbers \n");
	}

	for(i=0; i<8;i++)
	{
#if defined(__ADSPCORTEXA5__)
		printf("%lX\n",RandomNum[i]);
#else
		printf("%X\n",RandomNum[i]);
#endif
	}
	printf("\n");
	memset(RandomNum,0,32);

	eResult = adi_TRNG_Read_Output(ghtrng,RandomNum,ADI_TRNG_256_BITS);
	if(eResult != ADI_TRNG_SUCCESS)
	{
		printf("Failed to read Random numbers \n");
	}

	for(i=0; i<8;i++)
	{
#if defined(__ADSPCORTEXA5__)
		printf("%lX\n",RandomNum[i]);
#else
		printf("%X\n",RandomNum[i]);
#endif
	}
	printf("\n");
	memset(RandomNum,0,32);

	eResult = adi_TRNG_Read_Output(ghtrng,RandomNum,ADI_TRNG_64_BITS);
	if(eResult != ADI_TRNG_SUCCESS)
	{
		printf("Failed to read Random numbers \n");
	}

	for(i=0; i<8;i++)
	{
#if defined(__ADSPCORTEXA5__)
		printf("%lX\n",RandomNum[i]);
#else
		printf("%X\n",RandomNum[i]);
#endif
	}
	printf("\n");
	memset(RandomNum,0,32);
#endif
	printf("All done\n");
	return 0;
}

