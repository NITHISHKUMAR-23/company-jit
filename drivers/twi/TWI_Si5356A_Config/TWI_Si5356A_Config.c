/*********************************************************************************
Copyright(c) 2019-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/


/*****************************************************************************
 * TWI_Si5356A_Config.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include <stdio.h>
#include <drivers/twi/adi_twi.h>
#include "TWI_Si5356A_Config.h"

/* ADI initialization header */
#include "adi_initialize.h"

static ADI_TWI_HANDLE hDevice;

static bool bError = false;

static void CheckResult(ADI_TWI_RESULT result, char *message);
static void ReadRegister(uint8_t reg, uint8_t *value);

static uint8_t devBuffer[BUFFER_SIZE];

/*
 * Report error if result code is not success
 */
static void CheckResult(ADI_TWI_RESULT result, char *message)
{
	if (result != ADI_TWI_SUCCESS) {
		printf("%s failed\n", message);
		bError = true;
	}
}

/*
 * Read a Si5356A register value
 */
static void ReadRegister(uint8_t reg, uint8_t *value)
{
	ADI_TWI_RESULT result;

	/* write register address */
	devBuffer[0] = reg;
	result = adi_twi_Write(hDevice, devBuffer, 1u, true);
	CheckResult(result, "adi_twi_Write");

	/* read register value */
	result = adi_twi_Read(hDevice, value, 1u, false);
	CheckResult(result, "adi_twi_Read");
}

/*
 * main
 */
int main(  )
{
	ADI_TWI_RESULT result;
	uint8_t value;
	uint8_t mask;
	uint32_t nReg;
	uint8_t deviceMemory[ADI_TWI_MEMORY_SIZE];

	/* clear error flag */
	bError = false;

	adi_initComponents(); /* auto-generated code */
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif

	result = adi_twi_Open(TWIDEVNUM, ADI_TWI_MASTER, &deviceMemory[0],
			ADI_TWI_MEMORY_SIZE, &hDevice);
	CheckResult(result, "adi_twi_Open");

	result = adi_twi_SetPrescale(hDevice, PRESCALEVALUE);
	CheckResult(result, "adi_twi_Prescale");

	result = adi_twi_SetBitRate(hDevice, BITRATE);
	CheckResult(result, "adi_twi_SetBitRate");

	result = adi_twi_SetDutyCycle(hDevice, DUTYCYCLE);
	CheckResult(result, "adi_twi_SetDutyCycle");

	/* set Si5356A slave address */
	result = adi_twi_SetHardwareAddress(hDevice, TARGETADDR);
	CheckResult(result, "adi_twi_SetHardwareAddress");

	/* write the ClockBuilder register configuration */
	for (nReg=0; nReg<NUM_REGS_MAX; nReg++)
	{
		mask = Reg_Store[nReg].Reg_Mask;
		if (mask != 0x00)
		{
			/* read the register */
			value = 0u;
			ReadRegister(Reg_Store[nReg].Reg_Addr, &value);

			/* apply mask */
			value &= ~mask;

			/* modify value */
			value |= (Reg_Store[nReg].Reg_Val & mask);

			/* write value */
			devBuffer[0] = Reg_Store[nReg].Reg_Addr;
			devBuffer[1] = value;
			result = adi_twi_Write(hDevice, devBuffer, 2u, false);
			CheckResult(result, "adi_twi_Write");
		}
	}

	if (!bError) {
		printf("All done\n");
	} else {
		printf("Example failed.\n");
	}

	return 0;
}

