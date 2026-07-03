/*
 **
 ** Source file generated on May 4, 2022 at 20:07:16.	
 **
 ** Copyright (C) 2011-2022 Analog Devices Inc., All Rights Reserved.
 **
 ** This file is generated automatically based upon the options selected in 
 ** the Pin Multiplexing configuration editor. Changes to the Pin Multiplexing
 ** configuration should be made by changing the appropriate options rather
 ** than editing this file.
 **
 ** Selected Peripherals
 ** --------------------
 ** SPI0 (CLK, MISO, MOSI)
 ** TWI2 (SCL, SDA)
 **
 ** GPIO (unavailable)
 ** ------------------
 ** PA06, PA07, PA08, PA14, PA15
 */

#include <sys/platform.h>
#include <stdint.h>

#define SPI0_CLK_PORTA_MUX  ((uint16_t) ((uint16_t) 0<<12))
#define SPI0_MISO_PORTA_MUX  ((uint16_t) ((uint16_t) 0<<14))
#define SPI0_MOSI_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<16))
#define TWI2_SCL_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<28))
#define TWI2_SDA_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<30))

#define SPI0_CLK_PORTA_FER  ((uint16_t) ((uint16_t) 1<<6))
#define SPI0_MISO_PORTA_FER  ((uint16_t) ((uint16_t) 1<<7))
#define SPI0_MOSI_PORTA_FER  ((uint32_t) ((uint32_t) 1<<8))
#define TWI2_SCL_PORTA_FER  ((uint32_t) ((uint32_t) 1<<14))
#define TWI2_SDA_PORTA_FER  ((uint32_t) ((uint32_t) 1<<15))

int32_t adi_initpinmux(void);

/*
 * Initialize the Port Control MUX and FER Registers
 */
int32_t adi_initpinmux(void) {
    /* PORTx_MUX registers */
    *pREG_PORTA_MUX = SPI0_CLK_PORTA_MUX | SPI0_MISO_PORTA_MUX
     | SPI0_MOSI_PORTA_MUX | TWI2_SCL_PORTA_MUX | TWI2_SDA_PORTA_MUX;

    /* PORTx_FER registers */
    *pREG_PORTA_FER = SPI0_CLK_PORTA_FER | SPI0_MISO_PORTA_FER
     | SPI0_MOSI_PORTA_FER | TWI2_SCL_PORTA_FER | TWI2_SDA_PORTA_FER;
    return 0;
}

