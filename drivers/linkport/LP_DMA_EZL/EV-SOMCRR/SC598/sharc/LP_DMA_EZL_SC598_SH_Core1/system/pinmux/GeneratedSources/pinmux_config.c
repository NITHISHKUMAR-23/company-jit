/*
 **
 ** Source file generated on September 8, 2022 at 01:28:19.	
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
 ** LP0 (ACK, CLK, D0, D1, D2, D3, D4, D5, D6, D7)
 ** LP1 (ACK, CLK, D0, D1, D2, D3, D4, D5, D6, D7)
 ** TWI2 (SCL, SDA)
 **
 ** GPIO (unavailable)
 ** ------------------
 ** PA14, PA15, PB02, PB04, PB06, PB07, PB08, PB09, PB10, PB11, PB12, PB13, PB14,
 ** PB15, PC00, PC01, PC02, PC03, PC04, PC05, PC06, PC07
 */

#include <sys/platform.h>
#include <stdint.h>

#define LP0_ACK_PORTB_MUX  ((uint16_t) ((uint16_t) 2<<8))
#define LP0_CLK_PORTB_MUX  ((uint16_t) ((uint16_t) 0<<12))
#define LP0_D0_PORTB_MUX  ((uint16_t) ((uint16_t) 0<<14))
#define LP0_D1_PORTB_MUX  ((uint32_t) ((uint32_t) 0<<16))
#define LP0_D2_PORTB_MUX  ((uint32_t) ((uint32_t) 0<<18))
#define LP0_D3_PORTB_MUX  ((uint32_t) ((uint32_t) 0<<20))
#define LP0_D4_PORTB_MUX  ((uint32_t) ((uint32_t) 0<<22))
#define LP0_D5_PORTB_MUX  ((uint32_t) ((uint32_t) 0<<24))
#define LP0_D6_PORTB_MUX  ((uint32_t) ((uint32_t) 0<<26))
#define LP0_D7_PORTB_MUX  ((uint32_t) ((uint32_t) 0<<28))
#define LP1_ACK_PORTB_MUX  ((uint16_t) ((uint16_t) 2<<4))
#define LP1_CLK_PORTC_MUX  ((uint16_t) ((uint16_t) 0<<14))
#define LP1_D0_PORTB_MUX  ((uint32_t) ((uint32_t) 0<<30))
#define LP1_D1_PORTC_MUX  ((uint16_t) ((uint16_t) 0<<0))
#define LP1_D2_PORTC_MUX  ((uint16_t) ((uint16_t) 0<<2))
#define LP1_D3_PORTC_MUX  ((uint16_t) ((uint16_t) 0<<4))
#define LP1_D4_PORTC_MUX  ((uint16_t) ((uint16_t) 0<<6))
#define LP1_D5_PORTC_MUX  ((uint16_t) ((uint16_t) 0<<8))
#define LP1_D6_PORTC_MUX  ((uint16_t) ((uint16_t) 0<<10))
#define LP1_D7_PORTC_MUX  ((uint16_t) ((uint16_t) 0<<12))
#define TWI2_SCL_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<28))
#define TWI2_SDA_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<30))

#define LP0_ACK_PORTB_FER  ((uint16_t) ((uint16_t) 1<<4))
#define LP0_CLK_PORTB_FER  ((uint16_t) ((uint16_t) 1<<6))
#define LP0_D0_PORTB_FER  ((uint16_t) ((uint16_t) 1<<7))
#define LP0_D1_PORTB_FER  ((uint32_t) ((uint32_t) 1<<8))
#define LP0_D2_PORTB_FER  ((uint32_t) ((uint32_t) 1<<9))
#define LP0_D3_PORTB_FER  ((uint32_t) ((uint32_t) 1<<10))
#define LP0_D4_PORTB_FER  ((uint32_t) ((uint32_t) 1<<11))
#define LP0_D5_PORTB_FER  ((uint32_t) ((uint32_t) 1<<12))
#define LP0_D6_PORTB_FER  ((uint32_t) ((uint32_t) 1<<13))
#define LP0_D7_PORTB_FER  ((uint32_t) ((uint32_t) 1<<14))
#define LP1_ACK_PORTB_FER  ((uint16_t) ((uint16_t) 1<<2))
#define LP1_CLK_PORTC_FER  ((uint16_t) ((uint16_t) 1<<7))
#define LP1_D0_PORTB_FER  ((uint32_t) ((uint32_t) 1<<15))
#define LP1_D1_PORTC_FER  ((uint16_t) ((uint16_t) 1<<0))
#define LP1_D2_PORTC_FER  ((uint16_t) ((uint16_t) 1<<1))
#define LP1_D3_PORTC_FER  ((uint16_t) ((uint16_t) 1<<2))
#define LP1_D4_PORTC_FER  ((uint16_t) ((uint16_t) 1<<3))
#define LP1_D5_PORTC_FER  ((uint16_t) ((uint16_t) 1<<4))
#define LP1_D6_PORTC_FER  ((uint16_t) ((uint16_t) 1<<5))
#define LP1_D7_PORTC_FER  ((uint16_t) ((uint16_t) 1<<6))
#define TWI2_SCL_PORTA_FER  ((uint32_t) ((uint32_t) 1<<14))
#define TWI2_SDA_PORTA_FER  ((uint32_t) ((uint32_t) 1<<15))

int32_t adi_initpinmux(void);

/*
 * Initialize the Port Control MUX and FER Registers
 */
int32_t adi_initpinmux(void) {
    /* PORTx_MUX registers */
    *pREG_PORTA_MUX = TWI2_SCL_PORTA_MUX | TWI2_SDA_PORTA_MUX;
    *pREG_PORTB_MUX = LP0_ACK_PORTB_MUX | LP0_CLK_PORTB_MUX
     | LP0_D0_PORTB_MUX | LP0_D1_PORTB_MUX | LP0_D2_PORTB_MUX
     | LP0_D3_PORTB_MUX | LP0_D4_PORTB_MUX | LP0_D5_PORTB_MUX
     | LP0_D6_PORTB_MUX | LP0_D7_PORTB_MUX | LP1_ACK_PORTB_MUX
     | LP1_D0_PORTB_MUX;
    *pREG_PORTC_MUX = LP1_CLK_PORTC_MUX | LP1_D1_PORTC_MUX
     | LP1_D2_PORTC_MUX | LP1_D3_PORTC_MUX | LP1_D4_PORTC_MUX
     | LP1_D5_PORTC_MUX | LP1_D6_PORTC_MUX | LP1_D7_PORTC_MUX;

    /* PORTx_FER registers */
    *pREG_PORTA_FER = TWI2_SCL_PORTA_FER | TWI2_SDA_PORTA_FER;
    *pREG_PORTB_FER = LP0_ACK_PORTB_FER | LP0_CLK_PORTB_FER
     | LP0_D0_PORTB_FER | LP0_D1_PORTB_FER | LP0_D2_PORTB_FER
     | LP0_D3_PORTB_FER | LP0_D4_PORTB_FER | LP0_D5_PORTB_FER
     | LP0_D6_PORTB_FER | LP0_D7_PORTB_FER | LP1_ACK_PORTB_FER
     | LP1_D0_PORTB_FER;
    *pREG_PORTC_FER = LP1_CLK_PORTC_FER | LP1_D1_PORTC_FER
     | LP1_D2_PORTC_FER | LP1_D3_PORTC_FER | LP1_D4_PORTC_FER
     | LP1_D5_PORTC_FER | LP1_D6_PORTC_FER | LP1_D7_PORTC_FER;
    return 0;
}

