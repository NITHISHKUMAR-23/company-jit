/*********************************************************************************
Copyright(c) 2020-2024 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * SPI_XIPCodeExecution.c
 *****************************************************************************/

#include <stdio.h>
#include <sys/adi_core.h>
#include <drivers/spi/adi_spi.h>
#include <services/gpio/adi_gpio.h>
#include "adi_initialize.h"
#include "SPI_XIPCodeExecution.h"

static ADI_SPI_HANDLE hSpi;
static uint8_t SpiMemory[ADI_SPI_BIDIR_MEMORY_SIZE];

/* prototypes */
static void Set_LEDs(void);
static void Clear_LEDs(void);
static void CheckResult(ADI_SPI_RESULT Result);
#if defined(EV_SOMCRR_EZKIT_SUPPORT)
    void ConfigSoftSwitches_EV_SOMCRR_EZKIT (void);
#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
    void ConfigSoftSwitches_SOMCRR_EZLITE (void);
    void SoftConfig_EV_SOMCRR_EZLITE_LED_ON(void);
    void SoftConfig_EV_SOMCRR_EZLITE_LED_OFF(void);
#endif

#if defined(__ADSP21591__) || defined(__ADSP21593__)
void ConfigSoftSwitches_EV_21593_SOM(void);
#elif defined(__ADSPSC594__) || defined(__ADSPSC592__) || defined(__ADSPSC594W__) || defined(__ADSPSC592W__)
void ConfigSoftSwitches_EV_SC594_SOM(void);
#elif defined(__ADSPSC598_FAMILY__)
void ConfigSoftSwitches_EV_SC598_SOM(void);
#endif

static void CheckResult(ADI_SPI_RESULT Result) {
    if (Result != ADI_SPI_SUCCESS) {
        printf("Failed with error code 0x%08X\n", (int32_t)Result);
    }
}

int main()
{
    ADI_SPI_RESULT eResult;
    ADI_SPI_MMRDH_PARAM Mmrdh;

    adi_initComponents();
#if defined(__ADSPARM__)
    adi_core_enable(ADI_CORE_SHARC0);
   #if (__NUM_SHARC_CORES__ == 2)
    adi_core_enable(ADI_CORE_SHARC1);
   #endif
#elif (__NUM_ARM_CORES__ == 0)
    adi_core_enable(ADI_CORE_SHARC1);
#endif

    /* softconfig setting */
#if defined(EV_SOMCRR_EZKIT_SUPPORT)
    ConfigSoftSwitches_EV_SOMCRR_EZKIT();
#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
    /* No soft config is required for EV-SOMCRR-EZLITE */
#endif
#if defined(__ADSP21591__)||defined(__ADSP21593__)
    ConfigSoftSwitches_EV_21593_SOM();
#elif defined(__ADSPSC594__) || defined(__ADSPSC592__) || defined(__ADSPSC594W__) || defined(__ADSPSC592W__)
    ConfigSoftSwitches_EV_SC594_SOM();
#elif defined(__ADSPSC598_FAMILY__)
    ConfigSoftSwitches_EV_SC598_SOM();
#endif

    /* open SPI */
    eResult = adi_spi_Open(SPI_DEVICE_NUM, ADI_SPI_DIR_BIDIRECTION, SpiMemory, ADI_SPI_BIDIR_MEMORY_SIZE, &hSpi);
    CheckResult(eResult);

    /* Set the MMRDH parameters
     * struct ADI_SPI_MMRDH_PARAM available in adi_spi_2156x.h has detailed description of
     * the below mentioned fields */
    Mmrdh.bCmdSkip = false;
    Mmrdh.bCmdPins = false;
    Mmrdh.bAddrPin = false;
    Mmrdh.bMergeEnable = false;
    Mmrdh.bWrapEnable = false;

    Mmrdh.nOpcode = CMD_SINGLE_MODE_READ;
    Mmrdh.nModeField = 0x00u;
    Mmrdh.nAddrSize = ADI_SPI_MMRDH_ADRSIZE_3BYTE;
    Mmrdh.nDummybytes = ADI_SPI_MMRDH_0_DUMMY_BYTE;
    Mmrdh.nTristateTiming = ADI_SPI_MMRDH_NEVER_TRISTATE;

    eResult = adi_spi_SetSlaveSelectDelay(hSpi,true,true,3u);
    CheckResult(eResult);

    eResult = adi_spi_SetWordSize(hSpi,ADI_SPI_WORDSIZE_32BIT);
    CheckResult(eResult);

    eResult = adi_spi_SetHWSlaveSelect(hSpi,true);
    CheckResult(eResult);

    eResult = adi_spi_SetSlaveSelect(hSpi,ADI_SPI_SSEL_ENABLE1);
    CheckResult(eResult);

    eResult = adi_spi_Enable_MemMappedMode(hSpi,Mmrdh,NULL);
    CheckResult(eResult);

    /* Code execution from Flash */
    uint32_t ExpVal, RecVal, Val2, Val3, Iteration = 0;
    int FlashError = 0;
    Val2 = 10;
    Val3 = 15;

    while(Iteration < 10)
    {
        /* Do some calculations */
        ExpVal = (Val2*Val3) + (Val2*Iteration);

        /* call the function in Flash memory */
        RecVal =  Code_In_Flash(Iteration);
        Iteration++;

        if(RecVal != ExpVal)
        {
            FlashError = -1;
            break;
        }
    }

    if(FlashError == 0)
    {
        printf(" Code Execution from Flash happened correctly  \n");
        printf(" All Done  \n");
    }
    else
    {
        printf("Failed \n");
    }

#if defined(EV_SOMCRR_EZKIT_SUPPORT)
    while(1)
    {
        Set_LEDs();
      /*Delay*/
        for(volatile int i=0;i<0x1000000;i++);

        Clear_LEDs();
      /*Delay*/
        for(volatile int i=0;i<0x1000000;i++);
    }
#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
    while(1)
    {
        Set_LEDs();
      /*Delay*/
        for(volatile int i=0;i<0x1000000;i++);

        Clear_LEDs();
      /*Delay*/
        for(volatile int j=0;j<0x1000000;j++);
    }
#endif

    /* Setting SPI Configuration back to default to undo the configuration done mandatory for memory mapped mode */
    eResult = adi_spi_Disable_MemMappedMode(hSpi);
    CheckResult(eResult);

    /* Close the SPI driver */
    eResult = adi_spi_Close(hSpi);
    CheckResult(eResult);

    return 0;
}

#pragma section("seg_flash", SW)
uint32_t Code_In_Flash(uint32_t nIteration)
{
    uint32_t Val1, Val2, Val3, delay;

    Val2 = 10;
    Val3 = 15;

    /* Do some calculations */
    Val1 = (Val2*Val3) + (Val2*nIteration);
    *pREG_RCU0_MSG = Val1;

    /* Wait in a loop */
    delay = 100;
    while(delay > 3)
    {
        delay--;
    }

    /* Clear the variable */
    Val1 = 0;

    /* Read back form RCU_MSG */
    Val1 = *pREG_RCU0_MSG;

    return Val1;
}

#pragma section("seg_flash", SW)
static void Set_LEDs(void)
{
#if defined(EV_SOMCRR_EZKIT_SUPPORT)
    ADI_GPIO_RESULT GPIOResult;

    /*Configure the Port Pin PC_01 as output for LED blink*/
    GPIOResult = adi_gpio_SetDirection(ADI_GPIO_PORT_C,ADI_GPIO_PIN_1, ADI_GPIO_DIRECTION_OUTPUT);
    if(GPIOResult!= ADI_GPIO_SUCCESS)
    {
        printf("GPIO Initialization failed\n");
    }

    /*Configure the Port Pin PC_02 as output for LED blink*/
    GPIOResult = adi_gpio_SetDirection(ADI_GPIO_PORT_C,ADI_GPIO_PIN_2, ADI_GPIO_DIRECTION_OUTPUT);
    if(GPIOResult!= ADI_GPIO_SUCCESS)
    {
        printf("GPIO Initialization failed\n");
    }

    /*Configure the Port Pin PC_03 as output for LED blink*/
    GPIOResult = adi_gpio_SetDirection(ADI_GPIO_PORT_C,ADI_GPIO_PIN_3, ADI_GPIO_DIRECTION_OUTPUT);
    if(GPIOResult!= ADI_GPIO_SUCCESS)
    {
        printf("GPIO Initialization failed\n");
    }

    adi_gpio_Set(ADI_GPIO_PORT_C,ADI_GPIO_PIN_1);
    adi_gpio_Set(ADI_GPIO_PORT_C,ADI_GPIO_PIN_2);
    adi_gpio_Set(ADI_GPIO_PORT_C,ADI_GPIO_PIN_3);
#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
    /* LEDs on EV-SOMCRR-EZLITE */
    SoftConfig_EV_SOMCRR_EZLITE_LED_ON();
#endif
}

#pragma section("seg_flash", SW)
static void Clear_LEDs()
{
#if defined(EV_SOMCRR_EZKIT_SUPPORT)
    ADI_GPIO_RESULT GPIOResult;

    /*Configure the Port Pin PC_01 as output for LED blink*/
    GPIOResult = adi_gpio_SetDirection(ADI_GPIO_PORT_C,ADI_GPIO_PIN_1, ADI_GPIO_DIRECTION_OUTPUT);
    if(GPIOResult!= ADI_GPIO_SUCCESS)
    {
        printf("GPIO Initialization failed\n");
    }

    /*Configure the Port Pin PC_02 as output for LED blink*/
    GPIOResult = adi_gpio_SetDirection(ADI_GPIO_PORT_C,ADI_GPIO_PIN_2, ADI_GPIO_DIRECTION_OUTPUT);
    if(GPIOResult!= ADI_GPIO_SUCCESS)
    {
        printf("GPIO Initialization failed\n");
    }

    /*Configure the Port Pin PC_03 as output for LED blink*/
    GPIOResult = adi_gpio_SetDirection(ADI_GPIO_PORT_C,ADI_GPIO_PIN_3, ADI_GPIO_DIRECTION_OUTPUT);
    if(GPIOResult!= ADI_GPIO_SUCCESS)
    {
        printf("GPIO Initialization failed\n");
    }

    adi_gpio_Clear(ADI_GPIO_PORT_C,ADI_GPIO_PIN_1);
    adi_gpio_Clear(ADI_GPIO_PORT_C,ADI_GPIO_PIN_2);
    adi_gpio_Clear(ADI_GPIO_PORT_C,ADI_GPIO_PIN_3);
#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
    /* LEDs on EV-SOMCRR-EZLITE */
    SoftConfig_EV_SOMCRR_EZLITE_LED_OFF();
#endif
}

