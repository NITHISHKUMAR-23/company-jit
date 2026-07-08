/*
 **
 ** Source file generated on January 11, 2019 at 12:06:31.	
 **
 ** Copyright (C) 2011-2019 Analog Devices Inc., All Rights Reserved.
 **
 ** This file is generated automatically based upon the options selected in 
 ** the Pin Multiplexing configuration editor. Changes to the Pin Multiplexing
 ** configuration should be made by changing the appropriate options rather
 ** than editing this file.
 **
 ** Selected Peripherals
 ** --------------------
 ** SPI0 (CLK, MISO, MOSI, SEL1, SEL3, SEL4)
 **
 ** GPIO (unavailable)
 ** ------------------
 ** PA06, PA07, PA08, PA09, PB14, PB15
 */

#include <sys/platform.h>
#include <stdint.h>

#define SPI0_CLK_PORTA_MUX  ((uint16_t) ((uint16_t) 0<<12))
#define SPI0_MISO_PORTA_MUX  ((uint16_t) ((uint16_t) 0<<14))
#define SPI0_MOSI_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<16))
#define SPI0_SEL1_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<18))
#define SPI0_SEL3_PORTB_MUX  ((uint32_t) ((uint32_t) 1<<28))
#define SPI0_SEL4_PORTB_MUX  ((uint32_t) ((uint32_t) 1<<30))

#define SPI0_CLK_PORTA_FER  ((uint16_t) ((uint16_t) 1<<6))
#define SPI0_MISO_PORTA_FER  ((uint16_t) ((uint16_t) 1<<7))
#define SPI0_MOSI_PORTA_FER  ((uint32_t) ((uint32_t) 1<<8))
#define SPI0_SEL1_PORTA_FER  ((uint32_t) ((uint32_t) 1<<9))
#define SPI0_SEL3_PORTB_FER  ((uint32_t) ((uint32_t) 1<<14))
#define SPI0_SEL4_PORTB_FER  ((uint32_t) ((uint32_t) 1<<15))
int32_t adi_initpinmux(void);

/*
 * Initialize the Port Control MUX and FER Registers
 */
int32_t adi_initpinmux(void) {
    /* PORTx_MUX registers */

	  *pREG_PORTA_MUX = SPI0_CLK_PORTA_MUX | SPI0_MISO_PORTA_MUX
	     | SPI0_MOSI_PORTA_MUX | SPI0_SEL1_PORTA_MUX;
	    *pREG_PORTB_MUX = SPI0_SEL3_PORTB_MUX | SPI0_SEL4_PORTB_MUX;

	    /* PORTx_FER registers */
	    *pREG_PORTA_FER = SPI0_CLK_PORTA_FER | SPI0_MISO_PORTA_FER
	     | SPI0_MOSI_PORTA_FER | SPI0_SEL1_PORTA_FER;
	    *pREG_PORTB_FER = SPI0_SEL3_PORTB_FER | SPI0_SEL4_PORTB_FER;
	    return 0;
}

