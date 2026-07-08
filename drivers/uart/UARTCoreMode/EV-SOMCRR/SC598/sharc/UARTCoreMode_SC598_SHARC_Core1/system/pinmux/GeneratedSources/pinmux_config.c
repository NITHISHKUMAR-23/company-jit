/*
 **
 ** Source file generated on September 6, 2021 at 12:27:33.	
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
 ** UART0 (RX, TX)
 ** UART1 (RX, TX)
 **
 ** GPIO (unavailable)
 ** ------------------
 ** PD04, PD05, PD08, PD09
 */

#include <sys/platform.h>
#include <stdint.h>

#define UART0_RX_PORTD_MUX  ((uint32_t) ((uint32_t) 0<<16))
#define UART0_TX_PORTD_MUX  ((uint32_t) ((uint32_t) 0<<18))
#define UART1_RX_PORTD_MUX  ((uint16_t) ((uint16_t) 0<<8))
#define UART1_TX_PORTD_MUX  ((uint16_t) ((uint16_t) 0<<10))

#define UART0_RX_PORTD_FER  ((uint32_t) ((uint32_t) 1<<8))
#define UART0_TX_PORTD_FER  ((uint32_t) ((uint32_t) 1<<9))
#define UART1_RX_PORTD_FER  ((uint16_t) ((uint16_t) 1<<4))
#define UART1_TX_PORTD_FER  ((uint16_t) ((uint16_t) 1<<5))

int32_t adi_initpinmux(void);

/*
 * Initialize the Port Control MUX and FER Registers
 */
int32_t adi_initpinmux(void) {
    /* PORTx_MUX registers */
    *pREG_PORTD_MUX = UART0_RX_PORTD_MUX | UART0_TX_PORTD_MUX
     | UART1_RX_PORTD_MUX | UART1_TX_PORTD_MUX;

    /* PORTx_FER registers */
    *pREG_PORTD_FER = UART0_RX_PORTD_FER | UART0_TX_PORTD_FER
     | UART1_RX_PORTD_FER | UART1_TX_PORTD_FER;
    return 0;
}

