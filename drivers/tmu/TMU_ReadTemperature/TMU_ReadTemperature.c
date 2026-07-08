/*********************************************************************************
Copyright(c) 2020-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*
* @file      TMU_ReadTemperature.c
*
* @brief     This example demonstrates how to use the TMU to read the chip die temperature
*/
#include "TMU_ReadTemperature.h"
/* Managed drivers and/or services include */
#include "../system/adi_initialize.h"
#include <sys/adi_core.h>

/* TMU driver handle */
static ADI_TMU_HANDLE hDevice;

/* TMU driver API result code */
static ADI_TMU_RESULT result;

/* TMU driver memory */
static uint8_t TMUDriverMemory[ADI_TMU_MEMORY_SIZE];

int main(void)
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

    /* open the TMU driver */
    result = adi_tmu_Open(0u, TMUDriverMemory, (uint32_t)ADI_TMU_MEMORY_SIZE, &hDevice);
    if(result != ADI_TMU_SUCCESS)
    {
        REPORT_ERROR("Failed to open the TMU Device \n");
    }

    /* Configure the TMU for no Hardware Averaging, Continuous mode, SCLK Div as 3 */
    result = adi_tmu_ConfigureTMU(
        hDevice,
        false,
        true,
        false,
        3
     );
    if(result != ADI_TMU_SUCCESS)
    {
        REPORT_ERROR("Failed to open the TMU Device \n");
    }

    /* Enable TMU */
    result = adi_tmu_Enable(hDevice, true);
    if(result != ADI_TMU_SUCCESS)
    {
        REPORT_ERROR("Failed to open the TMU Device \n");
    }

    /* Enable Temperature conversion */
    result = adi_tmu_EnableConversion(hDevice, true);
    if(result != ADI_TMU_SUCCESS)
    {
        REPORT_ERROR("Failed to open the TMU Device \n");
    }

    /* initial temperature measurement delay */
    uint32_t delay = TMU_DELAY;
	while(delay>0u)
	{
		delay--;
#if defined __ADSPARM__
		__asm__("NOP");
#elif defined __ADSPSHARC__
		asm("NOP;");
#endif
	}

    /* Read the TMU temperature */
    result = adi_tmu_ReadTemperature(hDevice, &TempC);
    if(result != ADI_TMU_SUCCESS)
    {
        REPORT_ERROR("Failed to open the TMU Device \n");
    }

    printf("Temperature: %5.1f deg C\n", TempC);

    if(TempC > MIN_TEMP && TempC < MAX_TEMP)
    {
        printf("Temperature in range\n");
    }
    else
    {
        printf("Temperature not in range\n");
    }

    /* close the TMU driver */
    result = adi_tmu_Close(hDevice);
    if(result != ADI_TMU_SUCCESS)
    {
        REPORT_ERROR("Failed to open the TMU Device \n");
    }

    printf("\nAll done.\n");

    return 0;
}

