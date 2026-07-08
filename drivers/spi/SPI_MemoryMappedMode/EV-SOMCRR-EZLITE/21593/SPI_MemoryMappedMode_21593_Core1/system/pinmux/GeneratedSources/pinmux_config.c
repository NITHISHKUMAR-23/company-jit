/*
 **
 ** Source file generated on May 12, 2021 at 16:39:43.	
 **
 ** Copyright (C) 2011-2021 Analog Devices Inc., All Rights Reserved.
 **
 ** This file is generated automatically based upon the options selected in 
 ** the Pin Multiplexing configuration editor. Changes to the Pin Multiplexing
 ** configuration should be made by changing the appropriate options rather
 ** than editing this file.
 **
 ** Selected Peripherals
 ** --------------------
 ** SPI2 (CLK, D2, D3, MISO, MOSI, SEL1)
 ** TWI2 (SCL, SDA)
 **
 ** GPIO (unavailable)
 ** ------------------
 ** PA00, PA01, PA02, PA03, PA04, PA05, PA14, PA15
 */

#include <sys/platform.h>
#include <stdint.h>

#define SPI2_CLK_PORTA_MUX  ((uint16_t) ((uint16_t) 0<<8))
#define SPI2_D2_PORTA_MUX  ((uint16_t) ((uint16_t) 0<<4))
#define SPI2_D3_PORTA_MUX  ((uint16_t) ((uint16_t) 0<<6))
#define SPI2_MISO_PORTA_MUX  ((uint16_t) ((uint16_t) 0<<0))
#define SPI2_MOSI_PORTA_MUX  ((uint16_t) ((uint16_t) 0<<2))
#define SPI2_SEL1_PORTA_MUX  ((uint16_t) ((uint16_t) 0<<10))
#define TWI2_SCL_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<28))
#define TWI2_SDA_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<30))

#define SPI2_CLK_PORTA_FER  ((uint16_t) ((uint16_t) 1<<4))
#define SPI2_D2_PORTA_FER  ((uint16_t) ((uint16_t) 1<<2))
#define SPI2_D3_PORTA_FER  ((uint16_t) ((uint16_t) 1<<3))
#define SPI2_MISO_PORTA_FER  ((uint16_t) ((uint16_t) 1<<0))
#define SPI2_MOSI_PORTA_FER  ((uint16_t) ((uint16_t) 1<<1))
#define SPI2_SEL1_PORTA_FER  ((uint16_t) ((uint16_t) 1<<5))
#define TWI2_SCL_PORTA_FER  ((uint32_t) ((uint32_t) 1<<14))
#define TWI2_SDA_PORTA_FER  ((uint32_t) ((uint32_t) 1<<15))

int32_t adi_initpinmux(void);

/*
 * Initialize the Port Control MUX and FER Registers
 */
int32_t adi_initpinmux(void) {
    /* PORTx_MUX registers */
    *pREG_PORTA_MUX = SPI2_CLK_PORTA_MUX | SPI2_D2_PORTA_MUX
     | SPI2_D3_PORTA_MUX | SPI2_MISO_PORTA_MUX | SPI2_MOSI_PORTA_MUX
     | SPI2_SEL1_PORTA_MUX | TWI2_SCL_PORTA_MUX | TWI2_SDA_PORTA_MUX;

    /* PORTx_FER registers */
    *pREG_PORTA_FER = SPI2_CLK_PORTA_FER | SPI2_D2_PORTA_FER
     | SPI2_D3_PORTA_FER | SPI2_MISO_PORTA_FER | SPI2_MOSI_PORTA_FER
     | SPI2_SEL1_PORTA_FER | TWI2_SCL_PORTA_FER | TWI2_SDA_PORTA_FER;
    return 0;
}

