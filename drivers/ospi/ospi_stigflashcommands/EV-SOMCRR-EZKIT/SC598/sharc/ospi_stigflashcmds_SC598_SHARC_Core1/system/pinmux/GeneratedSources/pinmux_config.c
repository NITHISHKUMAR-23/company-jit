/*
 **
 ** Source file generated on October 5, 2021 at 10:02:21.	
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
 ** OSPI0 (CLK, D2, D3, D4, D5, D6, D7, MISO, MOSI, SEL1)
 ** TWI2 (SCL, SDA)
 **
 ** GPIO (unavailable)
 ** ------------------
 ** PA00, PA01, PA02, PA03, PA04, PA05, PA06, PA07, PA08, PA09, PA14, PA15
 */

#include <sys/platform.h>
#include <stdint.h>

#define OSPI0_CLK_PORTA_MUX  ((uint16_t) ((uint16_t) 1<<8))
#define OSPI0_D2_PORTA_MUX  ((uint16_t) ((uint16_t) 1<<4))
#define OSPI0_D3_PORTA_MUX  ((uint16_t) ((uint16_t) 1<<6))
#define OSPI0_D4_PORTA_MUX  ((uint16_t) ((uint16_t) 2<<12))
#define OSPI0_D5_PORTA_MUX  ((uint16_t) ((uint16_t) 2<<14))
#define OSPI0_D6_PORTA_MUX  ((uint32_t) ((uint32_t) 2<<16))
#define OSPI0_D7_PORTA_MUX  ((uint32_t) ((uint32_t) 2<<18))
#define OSPI0_MISO_PORTA_MUX  ((uint16_t) ((uint16_t) 1<<0))
#define OSPI0_MOSI_PORTA_MUX  ((uint16_t) ((uint16_t) 1<<2))
#define OSPI0_SEL1_PORTA_MUX  ((uint16_t) ((uint16_t) 1<<10))
#define TWI2_SCL_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<28))
#define TWI2_SDA_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<30))

#define OSPI0_CLK_PORTA_FER  ((uint16_t) ((uint16_t) 1<<4))
#define OSPI0_D2_PORTA_FER  ((uint16_t) ((uint16_t) 1<<2))
#define OSPI0_D3_PORTA_FER  ((uint16_t) ((uint16_t) 1<<3))
#define OSPI0_D4_PORTA_FER  ((uint16_t) ((uint16_t) 1<<6))
#define OSPI0_D5_PORTA_FER  ((uint16_t) ((uint16_t) 1<<7))
#define OSPI0_D6_PORTA_FER  ((uint32_t) ((uint32_t) 1<<8))
#define OSPI0_D7_PORTA_FER  ((uint32_t) ((uint32_t) 1<<9))
#define OSPI0_MISO_PORTA_FER  ((uint16_t) ((uint16_t) 1<<0))
#define OSPI0_MOSI_PORTA_FER  ((uint16_t) ((uint16_t) 1<<1))
#define OSPI0_SEL1_PORTA_FER  ((uint16_t) ((uint16_t) 1<<5))
#define TWI2_SCL_PORTA_FER  ((uint32_t) ((uint32_t) 1<<14))
#define TWI2_SDA_PORTA_FER  ((uint32_t) ((uint32_t) 1<<15))

int32_t adi_initpinmux(void);

/*
 * Initialize the Port Control MUX and FER Registers
 */
int32_t adi_initpinmux(void) {
    /* PORTx_MUX registers */
    *pREG_PORTA_MUX = OSPI0_CLK_PORTA_MUX | OSPI0_D2_PORTA_MUX
     | OSPI0_D3_PORTA_MUX | OSPI0_D4_PORTA_MUX | OSPI0_D5_PORTA_MUX
     | OSPI0_D6_PORTA_MUX | OSPI0_D7_PORTA_MUX | OSPI0_MISO_PORTA_MUX
     | OSPI0_MOSI_PORTA_MUX | OSPI0_SEL1_PORTA_MUX | TWI2_SCL_PORTA_MUX
     | TWI2_SDA_PORTA_MUX;

    /* PORTx_FER registers */
    *pREG_PORTA_FER = OSPI0_CLK_PORTA_FER | OSPI0_D2_PORTA_FER
     | OSPI0_D3_PORTA_FER | OSPI0_D4_PORTA_FER | OSPI0_D5_PORTA_FER
     | OSPI0_D6_PORTA_FER | OSPI0_D7_PORTA_FER | OSPI0_MISO_PORTA_FER
     | OSPI0_MOSI_PORTA_FER | OSPI0_SEL1_PORTA_FER | TWI2_SCL_PORTA_FER
     | TWI2_SDA_PORTA_FER;
    return 0;
}

