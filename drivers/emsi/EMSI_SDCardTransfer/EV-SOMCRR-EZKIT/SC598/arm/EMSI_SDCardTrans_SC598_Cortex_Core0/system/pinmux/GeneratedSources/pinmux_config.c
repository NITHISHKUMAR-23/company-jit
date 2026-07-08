/*
 **
 ** Source file generated on September 5, 2022 at 17:55:30.	
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
 ** EMSI0 (CD, CLK, CMD, D0, D1, D2, D3)
 ** TWI2 (SCL, SDA)
 **
 ** GPIO (unavailable)
 ** ------------------
 ** PA14, PA15, PB15, PD15, PE01, PE06, PE08, PE09, PG01
 */

#include <sys/platform.h>
#include <stdint.h>

#define EMSI0_CD_PORTB_MUX  ((uint32_t) ((uint32_t) 2<<30))
#define EMSI0_CLK_PORTE_MUX  ((uint32_t) ((uint32_t) 1<<18))
#define EMSI0_CMD_PORTG_MUX  ((uint16_t) ((uint16_t) 2<<2))
#define EMSI0_D0_PORTD_MUX  ((uint32_t) ((uint32_t) 1<<30))
#define EMSI0_D1_PORTE_MUX  ((uint16_t) ((uint16_t) 1<<2))
#define EMSI0_D2_PORTE_MUX  ((uint16_t) ((uint16_t) 2<<12))
#define EMSI0_D3_PORTE_MUX  ((uint32_t) ((uint32_t) 1<<16))
#define TWI2_SCL_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<28))
#define TWI2_SDA_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<30))

#define EMSI0_CD_PORTB_FER  ((uint32_t) ((uint32_t) 1<<15))
#define EMSI0_CLK_PORTE_FER  ((uint32_t) ((uint32_t) 1<<9))
#define EMSI0_CMD_PORTG_FER  ((uint16_t) ((uint16_t) 1<<1))
#define EMSI0_D0_PORTD_FER  ((uint32_t) ((uint32_t) 1<<15))
#define EMSI0_D1_PORTE_FER  ((uint16_t) ((uint16_t) 1<<1))
#define EMSI0_D2_PORTE_FER  ((uint16_t) ((uint16_t) 1<<6))
#define EMSI0_D3_PORTE_FER  ((uint32_t) ((uint32_t) 1<<8))
#define TWI2_SCL_PORTA_FER  ((uint32_t) ((uint32_t) 1<<14))
#define TWI2_SDA_PORTA_FER  ((uint32_t) ((uint32_t) 1<<15))

int32_t adi_initpinmux(void);

/*
 * Initialize the Port Control MUX and FER Registers
 */
int32_t adi_initpinmux(void) {
    /* PORTx_MUX registers */
    *pREG_PORTA_MUX = TWI2_SCL_PORTA_MUX | TWI2_SDA_PORTA_MUX;
    *pREG_PORTB_MUX = EMSI0_CD_PORTB_MUX;
    *pREG_PORTD_MUX = EMSI0_D0_PORTD_MUX;
    *pREG_PORTE_MUX = EMSI0_CLK_PORTE_MUX | EMSI0_D1_PORTE_MUX
     | EMSI0_D2_PORTE_MUX | EMSI0_D3_PORTE_MUX;
    *pREG_PORTG_MUX = EMSI0_CMD_PORTG_MUX;

    /* PORTx_FER registers */
    *pREG_PORTA_FER = TWI2_SCL_PORTA_FER | TWI2_SDA_PORTA_FER;
    *pREG_PORTB_FER = EMSI0_CD_PORTB_FER;
    *pREG_PORTD_FER = EMSI0_D0_PORTD_FER;
    *pREG_PORTE_FER = EMSI0_CLK_PORTE_FER | EMSI0_D1_PORTE_FER
     | EMSI0_D2_PORTE_FER | EMSI0_D3_PORTE_FER;
    *pREG_PORTG_FER = EMSI0_CMD_PORTG_FER;
    return 0;
}

