/*
 **
 ** Source file generated on May 10, 2021 at 18:16:50.	
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
 ** PA06, PA07, PA14, PA15
 */

#include <sys/platform.h>
#include <stdint.h>

#define UART0_RX_PORTA_MUX  ((uint16_t) ((uint16_t) 1<<14))
#define UART0_TX_PORTA_MUX  ((uint16_t) ((uint16_t) 1<<12))
#define UART1_RX_PORTA_MUX  ((uint32_t) ((uint32_t) 2<<28))
#define UART1_TX_PORTA_MUX  ((uint32_t) ((uint32_t) 2<<30))

#define UART0_RX_PORTA_FER  ((uint16_t) ((uint16_t) 1<<7))
#define UART0_TX_PORTA_FER  ((uint16_t) ((uint16_t) 1<<6))
#define UART1_RX_PORTA_FER  ((uint32_t) ((uint32_t) 1<<14))
#define UART1_TX_PORTA_FER  ((uint32_t) ((uint32_t) 1<<15))

int32_t adi_initpinmux(void);

/*
 * Initialize the Port Control MUX and FER Registers
 */
int32_t adi_initpinmux(void) {
    /* PORTx_MUX registers */
    *pREG_PORTA_MUX = UART0_RX_PORTA_MUX | UART0_TX_PORTA_MUX
     | UART1_RX_PORTA_MUX | UART1_TX_PORTA_MUX;

    /* PORTx_FER registers */
    *pREG_PORTA_FER = UART0_RX_PORTA_FER | UART0_TX_PORTA_FER
     | UART1_RX_PORTA_FER | UART1_TX_PORTA_FER;
    return 0;
}

