/*********************************************************************************
Copyright(c) 2014-2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * SPI_EEPROM_Access.c
 *****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "main.h"
#include <drivers/spi/adi_spi.h>
#include <services/pwr/adi_pwr.h>
#include <services/gpio/adi_gpio.h>

#define WRITE_DELAY     (1000000)

/* EEPROM Macros */
#define EEPROM_BIT_SIZE         1024                                        /* 1K-bit EEPROM size */
#define EEPROM_BYTE_SIZE        (EEPROM_BIT_SIZE / 8)                       /* eeprom size (in bytes) */
#define EEPROM_BYTES_PER_PAGE   16                                          /* bytes per page */
#define EEPROM_NUM_PAGES        (EEPROM_BYTE_SIZE / EEPROM_BYTES_PER_PAGE)  /* number of pages */
#define EEPROM_CMD_SIZE         1                                           /* eeprom command size (in bytes) */
#define EEPROM_ADR_SIZE         1                                           /* eeprom address size (in bytes) */

/* prototype */
void ConfigSoftSwitches_EV_SOMCRR_EZKIT (void);
#if defined(__ADSP21591__)||defined(__ADSP21593__)
void ConfigSoftSwitches_EV_21593_SOM(void);
#elif defined(__ADSPSC594__) || defined(__ADSPSC592__) || defined(__ADSPSC594W__) || defined(__ADSPSC592W__)
void ConfigSoftSwitches_EV_SC594_SOM(void);
#elif defined(__ADSPSC598_FAMILY__)
void ConfigSoftSwitches_EV_SC598_SOM(void);
#endif


/* EEPROM Commands */
typedef enum  {
    EEPROM_CMD_READ     = 3,    /* read data from memory array beginning at selected address */
    EEPROM_CMD_WRITE    = 2,    /* write data to memory array beginning at selected address */
    EEPROM_CMD_WRDI     = 4,    /* reset the write enable latch (disable write operations) */
    EEPROM_CMD_WREN     = 6,    /* set the write enable latch (enable write operations) */
    EEPROM_CMD_RDSR     = 5,    /* read status register */
    EEPROM_CMD_WRSR     = 1,    /* write status register */
} EEPROM_CMD_SET;


/* local prototypes */
uint32_t DoTheTest(ADI_SPI_HANDLE hSpi);
uint32_t SendCommand(ADI_SPI_HANDLE hSpi, uint8_t cmd);
int TEST_SPI_EEPROM(void);

static uint8_t SpiMemory[ADI_SPI_BIDIR_MEMORY_SIZE];

static uint8_t pWriteData[EEPROM_BYTE_SIZE];
static uint8_t pReadData[EEPROM_BYTE_SIZE];
static uint8_t pEraseData[EEPROM_BYTE_SIZE];

/* allocate memory for the GPIO service */
static uint8_t gpioMemory[ADI_GPIO_CALLBACK_MEM_SIZE];

int main()
{
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
   ConfigSoftSwitches_EV_SOMCRR_EZKIT ();
#if defined(__ADSP21591__)||defined(__ADSP21593__)
   ConfigSoftSwitches_EV_21593_SOM();
#elif defined(__ADSPSC594__) || defined(__ADSPSC592__) || defined(__ADSPSC594W__) || defined(__ADSPSC592W__)
   ConfigSoftSwitches_EV_SC594_SOM();
#elif defined(__ADSPSC598_FAMILY__)
   ConfigSoftSwitches_EV_SC598_SOM();
#endif

    TEST_SPI_EEPROM();

    return 0;
}

void AssertSlaveSelect(void)
{
    /* Asserting Chipselect SPI0 SEL1 */
    adi_gpio_Clear(ADI_GPIO_PORT_A, ADI_GPIO_PIN_9);
}

void DeassertSlaveSelect(void)
{
    /* De-asserting Chipselect SPI0 SEL1 */
    adi_gpio_Set(ADI_GPIO_PORT_A, ADI_GPIO_PIN_9);
}

/* the EEPROM test routine, called from main */
int TEST_SPI_EEPROM(void) {

    /* locals to reduce static memory */
    ADI_SPI_HANDLE hSpi;
    volatile bool bError = PASSED;
    ADI_GPIO_RESULT gpioresult;
    uint32_t gpioMaxCallbacks=0;


    printf( "SPI EEPROM Test\n" );

    /* initialize the GPIO service */
    gpioresult = adi_gpio_Init((void*)gpioMemory, ADI_GPIO_CALLBACK_MEM_SIZE, &gpioMaxCallbacks);
    if(gpioresult != ADI_GPIO_SUCCESS)
    {
        return FAILED;
    }
    /* Set the GPIO direction */
    gpioresult = adi_gpio_SetDirection(ADI_GPIO_PORT_A, ADI_GPIO_PIN_9, ADI_GPIO_DIRECTION_OUTPUT);
    if(gpioresult != ADI_GPIO_SUCCESS)
    {
        return FAILED;
    }
    /* De-asserting Chipselect */
    gpioresult = adi_gpio_Set(ADI_GPIO_PORT_A, ADI_GPIO_PIN_9);
    if(gpioresult != ADI_GPIO_SUCCESS)
    {
        return FAILED;
    }
    /* open SPI */
    if (adi_spi_Open(SPI_EEPROM_DEV_NUM,ADI_SPI_DIR_BIDIRECTION,SpiMemory,ADI_SPI_BIDIR_MEMORY_SIZE, &hSpi))
    {
        printf("adi_spi_Open() failed...\n");
        bError = FAILED;
    }

    /* do the test */
    if (!bError)
    {
        if (DoTheTest(hSpi))
        {
            bError = FAILED;
        }
    }

    /* close SPI */
    if (adi_spi_Close(hSpi))
    {
        printf("adi_spi_Close() failed...\n");
        bError = FAILED;
    }

    if(bError == PASSED)
    {
    	printf("All Done\n");
    }
    else
    {
    	printf("Failed\n");
    }

    if (bError)
        return FAILED;
    else
        return PASSED;

}

uint32_t DoTheTest(ADI_SPI_HANDLE hSpi)
{
    uint32_t result = 0;
    uint8_t seqReadWrite[EEPROM_CMD_SIZE + EEPROM_ADR_SIZE];
    uint8_t pageAddress;
    volatile int i, page, n;

    /* initialize data */
    for (i = 0; i < EEPROM_BYTE_SIZE; i++) {
        pWriteData[i] = rand();
        pReadData[i] = 0;
        pEraseData[i] = 0xff;
    }

    /* writes cannot span the page size, so chunk it up */
    /* each page write requires a separate write enable/disable sequence */
    /* write data is latched for each page and only written on CS deassert */
    for (page = 0; page < EEPROM_NUM_PAGES; page++) {

        /* compute new page address */
        pageAddress = page * EEPROM_BYTES_PER_PAGE;

        /* write enable */
        if (!result) {
            result = SendCommand(hSpi, EEPROM_CMD_WREN);
        }

        /* data erase */
        if (!result) {
            seqReadWrite[0]         = EEPROM_CMD_WRITE;
            seqReadWrite[1]         = pageAddress;

            /* Asserting Chipselect */
            AssertSlaveSelect();
            if (!result) {
            result = adi_spi_CoreWrite(hSpi,seqReadWrite,(EEPROM_CMD_SIZE + EEPROM_ADR_SIZE));
            }

            if (!result) {
            result = adi_spi_CoreWrite(hSpi,&pEraseData[pageAddress],EEPROM_BYTES_PER_PAGE);
            }
            /* De-asserting Chipselect */
            DeassertSlaveSelect();
        }

        /* write disable */
        if (!result) {
            result = SendCommand(hSpi, EEPROM_CMD_WRDI);
        }

        /* need 5 ms write cycle time (per data sheet) */
        n= WRITE_DELAY;
        while (n > 0) {
            n--;
        }

        /* write enable */
        if (!result) {
            result = SendCommand(hSpi, EEPROM_CMD_WREN);
        }

        /* data write */
        if (!result) {
            seqReadWrite[0]         = EEPROM_CMD_WRITE;
            seqReadWrite[1]         = pageAddress;

            /* Asserting Chipselect */
            AssertSlaveSelect();
            if (!result) {
            result = adi_spi_CoreWrite(hSpi,seqReadWrite,(EEPROM_CMD_SIZE + EEPROM_ADR_SIZE));
            }

            if (!result) {
            result = adi_spi_CoreWrite(hSpi,&pWriteData[pageAddress],EEPROM_BYTES_PER_PAGE);
            }
            /* De-asserting Chipselect */
            DeassertSlaveSelect();

        }

        /* write disable */
        if (!result) {
            result = SendCommand(hSpi, EEPROM_CMD_WRDI);
        }

        /* need 5 ms write cycle time (per data sheet) */
        n= WRITE_DELAY;
        while (n > 0) {
            n--;
        }

        /* data read */
        if (!result) {
            seqReadWrite[0]         = EEPROM_CMD_READ;
            seqReadWrite[1]         = pageAddress;

            /* Asserting Chipselect */
            AssertSlaveSelect();
            if (!result) {
            result = adi_spi_CoreWrite(hSpi,seqReadWrite,(EEPROM_CMD_SIZE + EEPROM_ADR_SIZE));
            }

            if (!result) {
            result = adi_spi_CoreRead(hSpi,&pReadData[pageAddress],EEPROM_BYTES_PER_PAGE,ADI_OSAL_TIMEOUT_FOREVER);
            }
            /* De-asserting Chipselect */
            DeassertSlaveSelect();
        }

        /* breakout on failure */
        if (result)
            return FAILED;

    } /* end page loop */


    /* verify the data */
    if (!result)
    {
        for (i = 0; i < EEPROM_BYTE_SIZE; i++)
        {
            if (pWriteData[i] != pReadData[i])
            {
                printf("\nData verification failed...at %d\n",i);
                return FAILED;
            }
        }
    }

    printf("EEPROM Test Passed\n");

    return PASSED;
}

uint32_t SendCommand(ADI_SPI_HANDLE hSpi, uint8_t cmd)
{
    uint8_t command;
    uint32_t result;

    /* write enable */
    command = cmd;

    /* Asserting Chipselect */
    AssertSlaveSelect();
    result = adi_spi_CoreWrite(hSpi,&command,EEPROM_CMD_SIZE);
    /* De-asserting Chipselect */
    DeassertSlaveSelect();

    return result;
}
