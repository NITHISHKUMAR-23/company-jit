/*********************************************************************************
Copyright(c) 2021-2024 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*
* @file      HADCReadVoltage.c
*
* @brief     This example demonstrates how to use HADC driver to convert and read the voltage levels.
*
* @details   This example demonstrates how to use HADC driver to convert and read the voltage levels
*            in both blocking mode and non-blocking mode
*
*            If PERFORM_BLOCKINGMODE is configured as (1), then the HADC driver uses blocking mode API to read ADC data.
*            If PERFORM_NONBLOCKINGMODE is configured as (1), then the HADC driver uses non-blocking mode API to read ADC data.
*
*            If the voltages are within the range, their levels are reported in the console window.
*            Additionally, the program terminates with report of correct or incorrect levels.
*
*            Refer to the associated Readme file for the setup required.
*/

#include "HADCReadVoltage.h"

#include <sys/adi_core.h>

/* Memory required for the operation of HADC driver */
static uint8_t  HADCMemory[ADI_HADC_MEM_SIZE];

/* Result*/
static ADI_HADC_RESULT result;

/* HADC driver handle */
static ADI_HADC_HANDLE ghHADC;

/* Check for HADC ready*/
static bool pbReady = false;

/* Flags which record various events reported by the callback */
static volatile bool bSeqComplete = false;
static volatile bool bChnlComplete = false;
static volatile bool bReady = false;
static volatile uint32_t CompletedChnls = 0u;

/*Static functions*/
#if PERFORM_BLOCKINGMODE
static void ReadVoltageBlockingMode(void);
#endif
#if PERFORM_NONBLOCKINGMODE
static void Callback(void *pCBParam, uint32_t nEvent, void *pEventArg);
static void ReadVoltageCallbackMode(void);
#endif

#if PERFORM_NONBLOCKINGMODE

/**
 * @brief       HADC driver callback.
 *
 * @details     HADC driver callback.
 *
 * @param [in]  pCBParam     Driver handle info
 * @param [in]  nEvent       Event type
 * @param [in]  pEventArg    Event argument
 *
 */
static void Callback(void *pCBParam, uint32_t nEvent, void *pEventArg)
{
    switch((ADI_HADC_EVENT)nEvent)
    {
        /*! Conversion of the given channel is complete. Then event argument
         *  indicates the completed channel number. */
        case ADI_HADC_EVENT_CHNL_CONV_COMPLETE:
            bChnlComplete = true;
            CompletedChnls = (uint32_t) pEventArg;
            break;

        /*! Conversion of all the enabled channels is complete. */
        case ADI_HADC_EVENT_CHNL_SEQ_COMPLETE:
            bSeqComplete = true;
            break;

        /*! ADC is ready for sampling. */
        case ADI_HADC_EVENT_ADC_READY:
            bReady = true;
            break;

        default:
            break;
    }

    return;
}
#endif

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

  /* Open the HADC Device */
  result = adi_hadc_Open(
            0u,
            HADCMemory,
            &ghHADC
         ) ;
  if(result != ADI_HADC_SUCCESS)
  {
    REPORT_ERROR("Failed to open the HADC Device \n");
  }

  while(!pbReady)
  {
    /* Wait for tWakeup + 2 x fsample */
    result = adi_hadc_IsAdcReady(ghHADC, &pbReady);
    if(result != ADI_HADC_SUCCESS)
    {
      REPORT_ERROR("ADC Ready failed \n");
    }

  }

  /* Set the channel mask for the channels to be sampled */
  result = adi_hadc_SetChannelMask(ghHADC, CHNL_MASK);
  if(result != ADI_HADC_SUCCESS)
  {
     REPORT_ERROR("Failed to set the channel mask \n");
  }

  /* Set the divide factor for sampling frequency */
  result = adi_hadc_SetSampleFreqDivFactor(ghHADC, 0xFu);
  if(result != ADI_HADC_SUCCESS)
  {
      REPORT_ERROR("Failed to set the divide factor \n");
  }

  /* Set the number of conversions */
  result = adi_hadc_SetNumConversions(ghHADC, NO_CONV);
  if(result != ADI_HADC_SUCCESS)
  {
      REPORT_ERROR("Failed to set number of conversions \n");
  }

#if PERFORM_BLOCKINGMODE
  /* Read the voltage using blocking mode */
  ReadVoltageBlockingMode();
#endif

#if PERFORM_NONBLOCKINGMODE
  /* Read the voltage using non blocking mode */
  ReadVoltageCallbackMode();
#endif

#if defined (__ADSP21593__) || defined(__ADSP21593W__)
  /* Convert to actual Voltage*/
  Voltage_Actual[0] = (float)(REF_VOLTAGE/4096.0) * (float)Voltage[0];
  printf("voltage at VIN0 = %f\n", Voltage_Actual[0]);

  Voltage_Actual[1] = (float)(REF_VOLTAGE/4096.0) * (float)Voltage[1];
  printf("voltage at VIN1 = %f\n", Voltage_Actual[1]);

  Voltage_Actual[2] = (float)(REF_VOLTAGE/4096.0) * (float)Voltage[2];
  printf("voltage at VIN2 = %f\n", Voltage_Actual[2]);

  Voltage_Actual[3] = (float)(REF_VOLTAGE/4096.0) * (float)Voltage[3];
  printf("voltage at VIN3 = %f\n\n", Voltage_Actual[3]);

#elif defined (__ADSPSC594__) || defined(__ADSPSC594W__) || defined (__ADSPSC598__) || defined(__ADSPSC598W__)
  /* Convert to actual Voltage*/
  Voltage_Actual[0] = (float)(REF_VOLTAGE/4096.0) * (float)Voltage[0];
  printf("voltage at VIN0 = %f\n", Voltage_Actual[0]);

  Voltage_Actual[1] = (float)(REF_VOLTAGE/4096.0) * (float)Voltage[1];
  printf("voltage at VIN1 = %f\n", Voltage_Actual[1]);

  Voltage_Actual[2] = (float)(REF_VOLTAGE/4096.0) * (float)Voltage[2];
  printf("voltage at VIN2 = %f\n", Voltage_Actual[2]);

  Voltage_Actual[3] = (float)(REF_VOLTAGE/4096.0) * (float)Voltage[3];
  printf("voltage at VIN3 = %f\n", Voltage_Actual[3]);

  Voltage_Actual[4] = (float)(REF_VOLTAGE/4096.0) * (float)Voltage[4];
  printf("voltage at VIN4 = %f\n", Voltage_Actual[4]);

  Voltage_Actual[5] = (float)(REF_VOLTAGE/4096.0) * (float)Voltage[5];
  printf("voltage at VIN5 = %f\n", Voltage_Actual[5]);

  Voltage_Actual[6] = (float)(REF_VOLTAGE/4096.0) * (float)Voltage[6];
  printf("voltage at VIN6 = %f\n", Voltage_Actual[6]);

  Voltage_Actual[7] = (float)(REF_VOLTAGE/4096.0) * (float)Voltage[7];
  printf("voltage at VIN7 = %f\n\n", Voltage_Actual[7]);
#endif

  /*Compare voltage against expected range*/
  if(Voltage_Actual[0] <= MAX_VOLTAGE_VIN0 && Voltage_Actual[0] >= MIN_VOLTAGE_VIN0)
  {
    printf("Correct voltage at VIN0\n");
  }
  else
  {
    printf("Incorrect voltage at VIN0\n");
  }

  /*Compare voltage against expected range*/
  if(Voltage_Actual[1] <= MAX_VOLTAGE_VIN1 && Voltage_Actual[1] >= MIN_VOLTAGE_VIN1)
  {
    printf("Correct voltage at VIN1\n");
  }
  else
  {
    printf("Incorrect voltage at VIN1\n");
  }

  /*Compare voltage against expected range*/
  if(Voltage_Actual[2] <= MAX_VOLTAGE_VIN2 && Voltage_Actual[2] >= MIN_VOLTAGE_VIN2)
  {
    printf("Correct voltage at VIN2\n");
  }
  else
  {
    printf("Incorrect voltage at VIN2\n");
  }

  /*Compare voltage against expected range*/
  if(Voltage_Actual[3] <= MAX_VOLTAGE_VIN3 && Voltage_Actual[3] >= MIN_VOLTAGE_VIN3)
  {
    printf("Correct voltage at VIN3\n");
  }
  else
  {
    printf("Incorrect voltage at VIN3\n");
  }
#if defined (__ADSPSC594__) || defined(__ADSPSC594W__) || defined (__ADSPSC598__) || defined(__ADSPSC598W__)
  /*Compare voltage against expected range*/
  if(Voltage_Actual[4] <= MAX_VOLTAGE_VIN4 && Voltage_Actual[4] >= MIN_VOLTAGE_VIN4)
  {
    printf("Correct voltage at VIN4\n");
  }
  else
  {
    printf("Incorrect voltage at VIN4\n");
  }

  /*Compare voltage against expected range*/
  if(Voltage_Actual[5] <= MAX_VOLTAGE_VIN5 && Voltage_Actual[5] >= MIN_VOLTAGE_VIN5)
  {
    printf("Correct voltage at VIN5\n");
  }
  else
  {
    printf("Incorrect voltage at VIN2\n");
  }

  /*Compare voltage against expected range*/
  if(Voltage_Actual[6] <= MAX_VOLTAGE_VIN6 && Voltage_Actual[6] >= MIN_VOLTAGE_VIN6)
  {
    printf("Correct voltage at VIN6\n");
  }
  else
  {
    printf("Incorrect voltage at VIN6\n");
  }

  /*Compare voltage against expected range*/
  if(Voltage_Actual[7] <= MAX_VOLTAGE_VIN7 && Voltage_Actual[7] >= MIN_VOLTAGE_VIN7)
  {
    printf("Correct voltage at VIN7\n");
  }
  else
  {
    printf("Incorrect voltage at VIN7\n");
  }

#endif

  /* close the hadc driver */
  result = adi_hadc_Close(ghHADC);
  if(result != ADI_HADC_SUCCESS)
  {
      REPORT_ERROR("Failed to close the HADC driver \n");
  }

  printf("\nAll done.\n");

  return 0;
}

#if PERFORM_BLOCKINGMODE
/**
 * @brief       Function to read the voltage in blocking mode.
 *
 * @details     Function to read the voltage in blocking mode.
 *
 *
 */
static void ReadVoltageBlockingMode(void)
{
  /* Start the conversion */
  result = adi_hadc_StartConversion(ghHADC, true);
  if(result != ADI_HADC_SUCCESS)
  {
    REPORT_ERROR("Failed to start the conversion \n");
  }

  /* Block until the conversion is done and read the data */
  result = adi_hadc_ReadConvertedData(ghHADC, CHNL_CONV, &Voltage[0]);
  if(result != ADI_HADC_SUCCESS)
  {
    REPORT_ERROR("Failed to read the converted data \n");
  }

}
#endif

#if PERFORM_NONBLOCKINGMODE
/**
 * @brief       Function to read the voltage in non-blocking mode.
 *
 * @details     Function to read the voltage in non-blocking mode.
 *
 *
 */
static void ReadVoltageCallbackMode(void)
{
    /* Register the callback with the driver */
    result = adi_hadc_RegisterCallback(ghHADC, Callback, NULL);
    if(result != ADI_HADC_SUCCESS)
    {
      REPORT_ERROR("Failed to register HADC driver callback \n");
    }

    /* Start the conversion */
    result = adi_hadc_StartConversion(ghHADC, true);
    if(result != ADI_HADC_SUCCESS)
    {
      REPORT_ERROR("Failed to start conversion\n");
    }

  /* If the conversion sequence event is reported */
  while(bSeqComplete != true);
  result = adi_hadc_GetConvertedData(ghHADC, CHNL_CONV, &Voltage[0] );
  if(result != ADI_HADC_SUCCESS)
  {
     REPORT_ERROR("Failed to get the converted data \n");
    }
}
#endif
