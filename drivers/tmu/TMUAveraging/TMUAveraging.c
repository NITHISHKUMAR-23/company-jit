/*********************************************************************************

Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/

/*
 * @file      TMUAveraging.c
 *
 * @brief     This example demonstrates how to perform multiple ways of averaging on TMU data.
 *
 * @details   This example demonstrates how to perform multiple ways of averaging on TMU data.
 *
 *            Hardware Averaging: When the PERFORM_HARDWARE_AVERAGING macro is enabled, TMU hardware
 *            averaging is enabled
 *            Software Averaging: When the PERFORM_SOFTWARE_AVERAGING macro is enabled, software averaging
 *            of the TMU data with a non-blocked mechanism is used.
 *            Software Averaging blocked: When PERFORM_SOFTWARE_AVERAGING_BLOCKED is enabled, software averaging
 *            of the TMU data with a blocked mechanism is used.
 *
 *            TMU data is printed to the console. For software averaging cases, TOTAL_COUNT determines
 *            the size of the buffer used to buffer the TMU data up on averaging is applied.
 */

#include "TMUAveraging.h"
#include <sys/adi_core.h>

/* TMU driver handle */
ADI_TMU_HANDLE hDevice;

/* TMU driver API result code */
ADI_TMU_RESULT result;

/* TMU driver memory */
static uint8_t TMUDriverMemory[ADI_TMU_MEMORY_SIZE];

int main()
{

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

	/* open the TMU driver */
	result = adi_tmu_Open(0u, TMUDriverMemory, (uint32_t)ADI_TMU_MEMORY_SIZE, &hDevice);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to open the TMU device \n");
	}

#ifdef PERFORM_HARDWARE_AVERAGING
	/*Configure the TMU*/
	result = adi_tmu_ConfigureTMU(
			hDevice,
			true,
			false,
			false,
			3
	);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to Configure TMU \n");
	}
#else
	/*Configure the TMU*/
	result = adi_tmu_ConfigureTMU(
			hDevice,
			false,
			false,
			false,
			3
	);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to Configure TMU \n");
	}
#endif

	/* Enable TMU */
	result = adi_tmu_Enable(hDevice, true);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to enable TMU \n");
	}

	/* Enable Temperature conversion */
	result = adi_tmu_EnableConversion(hDevice, true);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to start conversion \n");
	}

	/* Initial temperature measurement delay */
	uint32_t delay = TMU_DELAY;
	while(delay>0u)
	{
		delay--;
	}

	/* Read the TMU temperature */
	printf("Printing TMU data without software averaging\n");
#ifdef PERFORM_HARDWARE_AVERAGING
	printf("Hardware Averaging is enabled\n");
#endif
	for(int i =0; i< BUF_COUNT; i++)
	{
		result = adi_tmu_ReadTemperature(hDevice, &Temp);
		if(result != ADI_TMU_SUCCESS)
		{
			REPORT_ERROR("Failed to read temperature \n");
		}

		printf("%fC\t",Temp);
	}

	printf("\n\n");

#ifdef PERFORM_SOFTWARE_AVERAGING
	for(int j =0; j< BUF_COUNT; j++)
	{
		TempCAv[j] = 0;
	}

	/* Read the TMU temperature */
	printf("Printing TMU data with software averaging\n");
	for(int i =0; i< BUF_COUNT; i++)
	{
		/*Read the current average from the buffer*/
		result = adi_tmu_ReadLastAverageBufferVal(&TempCAv[0],BUF_COUNT,&TempC);
		if(result != ADI_TMU_SUCCESS)
		{
			REPORT_ERROR("Failed to read last average buffer value \n");
		}

		/*Write TMU data in to average buffer*/
		result = adi_tmu_WriteAverageBufferVal(
				hDevice,
				&TempCAv[0],
				BUF_COUNT,
				&pAverageBufCnt);
		if(result != ADI_TMU_SUCCESS)
		{
			REPORT_ERROR("Failed to write in to average buffer \n");
		}

		for(int k =0; k< BUF_COUNT; k++)
		{
			printf("%fC\t",TempCAv[k]);
		}

		printf("\n");
	}
#endif

	printf("\n\n");

#ifdef PERFORM_SOFTWARE_AVERAGING_BLOCKED
	printf("Printing TMU data with software averaging blocked mechanism\n");

	/*Write TMU data in to average buffer - blocking mode*/
	result = adi_tmu_WriteAverageBuffer(
			hDevice,
			&TempCAv[0],
			BUF_COUNT,
			TMU_DELAY,
			&TempC
	);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to write in to average buffer - blocking mode \n");
	}

	for(int k =0; k< BUF_COUNT; k++)
	{
		printf("%fC\t",TempCAv[k]);
	}
#endif

	printf("\nAll done\n");
	return 0;
}
