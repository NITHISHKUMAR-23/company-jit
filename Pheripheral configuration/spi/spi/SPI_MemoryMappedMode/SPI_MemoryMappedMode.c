/*********************************************************************************
Copyright(c) 2020-2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * SPI_MemoryMappedMode.c
 *****************************************************************************/

#include <stdio.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include <drivers/spi/adi_spi.h>
#include "adi_initialize.h"
#include "SPI_MemoryMappedMode.h"

/* prototype */
#if defined(EV_SOMCRR_EZKIT_SUPPORT)
    void ConfigSoftSwitches_EV_SOMCRR_EZKIT (void);
#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
    void ConfigSoftSwitches_SOMCRR_EZLITE (void);
#endif

#if defined(__ADSP21591__)||defined(__ADSP21593__)
void ConfigSoftSwitches_EV_21593_SOM(void);
#elif defined(__ADSPSC594__) || defined(__ADSPSC592__) || defined(__ADSPSC594W__) || defined(__ADSPSC592W__)
void ConfigSoftSwitches_EV_SC594_SOM(void);
#elif defined(__ADSPSC598_FAMILY__)
void ConfigSoftSwitches_EV_SC598_SOM(void);
#endif

ADI_SPI_HANDLE hSpi;
uint8_t SpiMemory[ADI_SPI_BIDIR_MEMORY_SIZE];

uint8_t WrittenData[20] = {0x87,0x15,0xFF,0xFF,0xFA,0xFF,0x08,0x9D,0x7A,0x02,0x9C,0x0F,0x0A,0x00,0x08,0x9D,0x7C,0x0E,0x9C,0x0F};

uint8_t volatile ReadBuffer[BUFFER_SIZE]={0};

static void CheckResult(ADI_SPI_RESULT Result) {
    if (Result != ADI_SPI_SUCCESS) {
        printf("Failed with error code 0x%08X\n", Result);
    }
}

int main()
{
    ADI_SPI_RESULT eResult;
    ADI_SPI_MMRDH_PARAM Mmrdh;
    uint8_t *pSPI_MEM =  (uint8_t *)SPI_FLASH_MEMORY;
    bool bPass = true;

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
    ConfigSoftSwitches_SOMCRR_EZLITE();
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

    eResult = adi_spi_SetSlaveSelectDelay(hSpi,true,true,3ul);
    CheckResult(eResult);

    eResult = adi_spi_SetWordSize(hSpi,ADI_SPI_WORDSIZE_32BIT);
    CheckResult(eResult);

    eResult = adi_spi_SetHWSlaveSelect(hSpi,true);
    CheckResult(eResult);

    eResult = adi_spi_SetSlaveSelect(hSpi,ADI_SPI_SSEL_ENABLE1);
    CheckResult(eResult);

    eResult = adi_spi_Enable_MemMappedMode(hSpi,Mmrdh,NULL);
    CheckResult(eResult);

    /* Read the contents of the SPI Flash memory which should be verified with
     * the data written into by the flash programmer */
    for(uint32_t volatile LoopVar=0; LoopVar<BUFFER_SIZE; LoopVar++)
    {
        ReadBuffer[LoopVar]= *pSPI_MEM++;
    }

    for(uint32_t volatile LoopVar=0; LoopVar<BUFFER_SIZE; LoopVar++)
    {
        if(ReadBuffer[LoopVar] != WrittenData[LoopVar])
        {
            printf("Example Fails\n");
            bPass = false;
            break;
        }
    }

    if(bPass == true)
    {
    	printf("All Done\n");
    }

    eResult = adi_spi_Disable_MemMappedMode(hSpi);
    CheckResult(eResult);

    /* Close the SPI driver */
    eResult = adi_spi_Close(hSpi);
    CheckResult(eResult);

    return 0;

}

