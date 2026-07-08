/*********************************************************************************

Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/

/*
 * @file      TMUAlertFault.c
 *
 * @brief     This example demonstrates how to manage the Alerts and Faults detected by the TMU in the system.
 *
 * @details   This example demonstrates how to manage the Alerts and Faults detected by the TMU in the system
 *
 *            This example is a reference code, and requires a temperature forcing / controlling setup for execution.
 *
 *            It also demonstrates how to connect Alert and Fault triggers to a trigger slave, via TRU unit.
 *            Counters are provided to identify which and how many of the conditions are asserted.
 *            alertlo_cnt - for counting number of ALERT_LO interrupts.
 *            alerthi_cnt - for counting number of ALERT_HI interrupts.
 *            faultlo_cnt - for counting number of FAULT_LO interrupts.
 *            faulthi_cnt - for counting number of FAULT_HI interrupts.
 *
 *            Temperature value read is continuously printed to the console.
 *
 *            When ADI_TMU_EVENT_FAULT_HIGH OR ADI_TMU_EVENT_ALERT_HIGH is asserted, the callback
 *            prints the temperature before and after clearing the status.
 *
 *            A structure pEventLimit1 of type ADI_TMU_EVENT_LIMIT is used to set the limit values for
 *            each of the cases - ALERT_HI, FAULT_HI, ALERT_LO and FAULT_LO.
 *
 *            User is expected to refer to the TMU chapter in the hardware reference manual, for more details about the TMU
 *            and how Alert/Fault management works. Management and control of temperature varies from system to system.
 */

#include "TMUAlertFault.h"
#include <sys/adi_core.h>

#if defined(__ADSPARM__)
#include <services/int/adi_gic.h>
#endif

/* TMU driver handle */
ADI_TMU_HANDLE hDevice;

/* TMU Event*/
ADI_TMU_EVENT       pStatus;

/* TMU driver API result code */
ADI_TMU_RESULT result;

/* TRU service API result code*/
ADI_TRU_RESULT resultTRU;

/* Interrupt service API result code*/
ADI_INT_STATUS resultINT;

/* TMU driver memory */
static uint8_t TMUDriverMemory[ADI_TMU_MEMORY_SIZE];

/*Call back additional arg parameter*/
static volatile bool g_bFaultHiEvent = false;

/*Static functions*/
static void TMUCallback(void* pHandle, uint32_t u32Arg, void* pArg);
static void TRU0_SLV0_Interrupt_Handler(void);
static void TRU0_SLV1_Interrupt_Handler(void);

/**
 * @brief       TMU driver callback.
 *
 * @details     TMU driver callback.
 *
 * @param [in]  pHandle      Driver handle info
 * @param [in]  u32Arg       Event type in TMU
 * @param [in]  pArg         Event argument
 *
 */
static void TMUCallback(void* pHandle, uint32_t u32Arg, void* pArg)
{
	ADI_TMU_EVENT event = (ADI_TMU_EVENT)u32Arg;

	adi_tmu_GetEventStatus(hDevice,&pStatus);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to get event status \n");
	}

	switch (event)
	{
	case ADI_TMU_EVENT_FAULT_HIGH:
		faulthi_cnt++;
		result = adi_tmu_ReadTemperature(hDevice, &TempC);
		if(result != ADI_TMU_SUCCESS)
		{
			REPORT_ERROR("Failed to read temperature \n");
		}
		printf("Temperature: %5.1f deg C\n", TempC);

		/*Write to IMSK register*/
		result = adi_tmu_WriteIMSKReg(hDevice, false, false, true, true);

		result = adi_tmu_ClearFaultHighStatus(hDevice);
		if(result != ADI_TMU_SUCCESS)
		{
			REPORT_ERROR("Failed to clear status \n");
		}

		result = adi_tmu_ReadTemperature(hDevice, &TempC_Reset);
		if(result != ADI_TMU_SUCCESS)
		{
			REPORT_ERROR("Failed to read temperature \n");
		}
		printf("Temperature: %5.1f deg C\n", TempC);
		break;

	case ADI_TMU_EVENT_FAULT_LOW:
		faultlo_cnt++;

		/*Write to IMSK register*/
		result = adi_tmu_WriteIMSKReg(hDevice, true, true, false, false);
		break;

	case ADI_TMU_EVENT_ALERT_HIGH:
		alerthi_cnt++;
		result = adi_tmu_ReadTemperature(hDevice, &TempC);
		if(result != ADI_TMU_SUCCESS)
		{
			REPORT_ERROR("Failed to read temperature \n");
		}
		printf("Temperature: %5.1f deg C\n", TempC);

		result = adi_tmu_ClearAlertHighStatus(hDevice);
		if(result != ADI_TMU_SUCCESS)
		{
			REPORT_ERROR("Failed to clear status \n");
		}

		result = adi_tmu_ReadTemperature(hDevice, &TempC_Reset);
		if(result != ADI_TMU_SUCCESS)
		{
			REPORT_ERROR("Failed to read temperature \n");
		}
		printf("Temperature: %5.1f deg C\n", TempC);
		break;

	case ADI_TMU_EVENT_ALERT_LOW:
		alertlo_cnt++;
		break;

	default:
		break;
	}
}

/**
 * @brief       TRU Slave 0 Interrupt Handler
 *
 * @details     TRU Slave 0 Interrupt Handler
 *
 */
static void TRU0_SLV0_Interrupt_Handler()
{
	TRU0_SLV0_Interrupt++;
}


/**
 * @brief       TRU Slave 1 Interrupt Handler
 *
 * @details     TRU Slave 1 Interrupt Handler
 *
 */
static void TRU0_SLV1_Interrupt_Handler()
{
	TRU0_SLV1_Interrupt++;
}

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

	/*Enable TRU*/
	resultTRU = adi_tru_Init (true);
	if(resultTRU != ADI_TRU_SUCCESS)
	{
		REPORT_ERROR("Failed to intialize TRU \n");
	}


#if defined(__ADSPCORTEXA55__)

	/*Edge sensitivity for ARM interrupts*/
	adi_gic_ConfigInt(INTR_TRU0_INT0,   ADI_GIC_INT_EDGE_SENSITIVE);
	adi_gic_ConfigInt(INTR_TRU0_INT1,   ADI_GIC_INT_EDGE_SENSITIVE);

#elif defined(__ADSPCORTEXA5__)

	/*Edge sensitivity for ARM interrupts*/
	adi_gic_ConfigInt(INTR_TRU0_INT0,   ADI_GIC_INT_EDGE_SENSITIVE,  ADI_GIC_INT_HANDLING_MODEL_N_N);
	adi_gic_ConfigInt(INTR_TRU0_INT1,   ADI_GIC_INT_EDGE_SENSITIVE,  ADI_GIC_INT_HANDLING_MODEL_N_N);
#endif

#if defined(__ADSPARM__)
	/*Configure TRU Slave Interrupt 1 as TMU Fault Interrupt*/
	resultTRU = adi_tru_ConfigureSlave(TRGS_TRU0_SLV0, TRGM_TMU0_FAULT);
	if(resultTRU != ADI_TRU_SUCCESS)
	{
		REPORT_ERROR("Failed to configure TRU slave \n");
	}

	/*Install TRU Slave Interrupt 1 interrupt*/
	resultINT = adi_int_InstallHandler(INTR_TRU0_SLV0,(ADI_INT_HANDLER_PTR)TRU0_SLV1_Interrupt_Handler, NULL, true);
	if(resultINT != ADI_INT_SUCCESS)
	{
		REPORT_ERROR("Failed to install handler \n");
	}

	/*Configure TRU Slave Interrupt 0 as TMU Alert Interrupt*/
	resultTRU = adi_tru_ConfigureSlave(TRGS_TRU0_SLV1, TRGM_TMU0_ALERT);
	if(resultTRU != ADI_TRU_SUCCESS)
	{
		REPORT_ERROR("Failed to configure TRU slave \n");
	}

	/*Install TRU Slave Interrupt 0 interrupt*/
	resultINT = adi_int_InstallHandler(INTR_TRU0_SLV1, (ADI_INT_HANDLER_PTR)TRU0_SLV0_Interrupt_Handler, NULL, true);
	if(resultINT != ADI_INT_SUCCESS)
	{
		REPORT_ERROR("Failed to install handler \n");
	}

#else
	/*Configure TRU Slave Interrupt 4 as TMU Fault Interrupt*/
	resultTRU = adi_tru_ConfigureSlave(TRGS_TRU0_SLV4, TRGM_TMU0_FAULT);
	if(resultTRU != ADI_TRU_SUCCESS)
	{
		REPORT_ERROR("Failed to configure TRU slave \n");
	}

	/*Install TRU Slave Interrupt 4 interrupt*/
	resultINT = adi_int_InstallHandler(INTR_TRU0_SLV4,(ADI_INT_HANDLER_PTR)TRU0_SLV1_Interrupt_Handler, NULL, true);
	if(resultINT != ADI_INT_SUCCESS)
	{
		REPORT_ERROR("Failed to install handler \n");
	}

	/*Configure TRU Slave Interrupt 0 as TMU Alert Interrupt*/
	resultTRU = adi_tru_ConfigureSlave(TRGS_TRU0_SLV6, TRGM_TMU0_ALERT);
	if(resultTRU != ADI_TRU_SUCCESS)
	{
		REPORT_ERROR("Failed to configure TRU slave \n");
	}

	/*Install TRU Slave Interrupt 0 interrupt*/
	resultINT = adi_int_InstallHandler(INTR_TRU0_SLV6, (ADI_INT_HANDLER_PTR)TRU0_SLV0_Interrupt_Handler, NULL, true);
	if(resultINT != ADI_INT_SUCCESS)
	{
		REPORT_ERROR("Failed to install handler \n");
	}
#endif

	/* open the TMU driver */
	result = adi_tmu_Open(0u, TMUDriverMemory, (uint32_t)ADI_TMU_MEMORY_SIZE, &hDevice);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to open the TMU device \n");
	}

	/*Enable TMU as SEC Fault source*/
	result = adi_tmu_EnableAsSECFaultSource(hDevice, true);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to Enable TMU as SEC Fault source \n");
	}

	/* Configure TMU */
	result = adi_tmu_ConfigureTMU(
			hDevice,
			false,
			true,
			false,
			3
	);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to Configure TMU \n");
	}

	/*Write to IMSK register*/
	result = adi_tmu_WriteIMSKReg(
			hDevice,
			false,
			false,
			false,
			false
	);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to Write to IMSK register \n");
	}

	/* Set EVent Limits */
	result = adi_tmu_SetEventLimits(hDevice, &pEventLimit1);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to set Event Limits \n");
	}

	/* Register callback */
	result = adi_tmu_RegisterCallback(hDevice, TMUCallback, (uint32_t*)&g_bFaultHiEvent);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to set Event Limits \n");
	}

	/*Set Gain*/
	result = adi_tmu_SetGain_Raw(hDevice, 1.004);
	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to set Gain \n");
	}

#if defined(__ADSPSC598_FAMILY__)
	/*Set Offset*/
	result = adi_tmu_SetOffset(hDevice, -5.5);
#elif defined(__ADSPSC594_FAMILY__)	
	/*Set Offset*/
	result = adi_tmu_SetOffset(hDevice, -4.75);
#endif	

	if(result != ADI_TMU_SUCCESS)
	{
		REPORT_ERROR("Failed to set Offset \n");
	}

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

	uint32_t delay = 100000;
	while(delay>0u)
	{
		delay--;
	}

#ifndef AUTOTEST
	while(1)
#endif
	{
		/* Read the TMU temperature */
		result = adi_tmu_ReadTemperature(hDevice, &TempC);
		if(result != ADI_TMU_SUCCESS)
		{
			REPORT_ERROR("Failed to read temperature \n");
		}

		printf("Temperature: %5.1f deg C\n", TempC);
	}
#ifdef AUTOTEST
	printf("All done\n");
	return 0;
#endif
}





