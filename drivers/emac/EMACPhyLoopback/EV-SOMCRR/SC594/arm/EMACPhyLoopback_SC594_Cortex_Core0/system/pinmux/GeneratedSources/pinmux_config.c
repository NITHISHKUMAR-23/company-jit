/*
 **
 ** Source file generated on March 14, 2022 at 16:39:33.	
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
 ** EMAC0 (COL, CRS, MDC, MDIO, PTPAUXIN0, PTPAUXIN1, PTPAUXIN2, PTPAUXIN3, PTPCLKIN0, PTPPPS0, PTPPPS1, PTPPPS2, PTPPPS3, RXCLK_REFCLK, RXCTL_RXDV, RXD0, RXD1, RXD2, RXD3, RXERR, TXCLK, TXCTL_TXEN, TXD0, TXD1, TXD2, TXD3)
 ** EMAC1 (CRS, MDC, MDIO, REFCLK, RXD0, RXD1, TXD0, TXD1, TXEN)
 ** TWI2 (SCL, SDA)
 **
 ** GPIO (unavailable)
 ** ------------------
 ** PA14, PA15, PD02, PD03, PD05, PD06, PD07, PE09, PE11, PE12, PE13, PE14, PE15,
 ** PF00, PF01, PF02, PF03, PH03, PH04, PH05, PH06, PH07, PH08, PH09, PH10, PH11,
 ** PH12, PH13, PH14, PH15, PI00, PI01, PI02, PI03, PI04, PI05, PI06
 */

#include <sys/platform.h>
#include <stdint.h>

#define EMAC0_COL_PORTD_MUX  ((uint16_t) ((uint16_t) 1<<14))
#define EMAC0_CRS_PORTD_MUX  ((uint16_t) ((uint16_t) 2<<4))
#define EMAC0_MDC_PORTH_MUX  ((uint16_t) ((uint16_t) 0<<6))
#define EMAC0_MDIO_PORTH_MUX  ((uint16_t) ((uint16_t) 0<<8))
#define EMAC0_PTPAUXIN0_PORTI_MUX  ((uint16_t) ((uint16_t) 1<<4))
#define EMAC0_PTPCLKIN0_PORTI_MUX  ((uint16_t) ((uint16_t) 1<<2))
#define EMAC0_PTPPPS0_PORTI_MUX  ((uint16_t) ((uint16_t) 2<<8))
#define EMAC0_PTPPPS1_PORTI_MUX  ((uint16_t) ((uint16_t) 2<<6))
#define EMAC0_PTPPPS2_PORTI_MUX  ((uint16_t) ((uint16_t) 0<<10))
#define EMAC0_PTPPPS3_PORTI_MUX  ((uint16_t) ((uint16_t) 0<<12))
#define EMAC0_RXCLK_REFCLK_PORTH_MUX  ((uint16_t) ((uint16_t) 0<<14))
#define EMAC0_RXCTL_RXDV_PORTH_MUX  ((uint32_t) ((uint32_t) 0<<16))
#define EMAC0_RXD0_PORTH_MUX  ((uint16_t) ((uint16_t) 0<<10))
#define EMAC0_RXD1_PORTH_MUX  ((uint16_t) ((uint16_t) 0<<12))
#define EMAC0_RXD2_PORTH_MUX  ((uint32_t) ((uint32_t) 0<<22))
#define EMAC0_RXD3_PORTH_MUX  ((uint32_t) ((uint32_t) 0<<24))
#define EMAC0_RXERR_PORTD_MUX  ((uint16_t) ((uint16_t) 1<<12))
#define EMAC0_TXCLK_PORTH_MUX  ((uint32_t) ((uint32_t) 0<<28))
#define EMAC0_TXCTL_TXEN_PORTH_MUX  ((uint32_t) ((uint32_t) 0<<26))
#define EMAC0_TXD0_PORTH_MUX  ((uint32_t) ((uint32_t) 0<<18))
#define EMAC0_TXD1_PORTH_MUX  ((uint32_t) ((uint32_t) 0<<20))
#define EMAC0_TXD2_PORTH_MUX  ((uint32_t) ((uint32_t) 0<<30))
#define EMAC0_TXD3_PORTI_MUX  ((uint16_t) ((uint16_t) 0<<0))
#define EMAC1_CRS_PORTF_MUX  ((uint16_t) ((uint16_t) 0<<6))
#define EMAC1_MDC_PORTF_MUX  ((uint16_t) ((uint16_t) 0<<4))
#define EMAC1_MDIO_PORTF_MUX  ((uint16_t) ((uint16_t) 0<<2))
#define EMAC1_REFCLK_PORTE_MUX  ((uint32_t) ((uint32_t) 0<<22))
#define EMAC1_RXD0_PORTE_MUX  ((uint32_t) ((uint32_t) 0<<30))
#define EMAC1_RXD1_PORTF_MUX  ((uint16_t) ((uint16_t) 0<<0))
#define EMAC1_TXD0_PORTE_MUX  ((uint32_t) ((uint32_t) 0<<26))
#define EMAC1_TXD1_PORTE_MUX  ((uint32_t) ((uint32_t) 0<<28))
#define EMAC1_TXEN_PORTE_MUX  ((uint32_t) ((uint32_t) 0<<24))
#define TWI2_SCL_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<28))
#define TWI2_SDA_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<30))

#define EMAC0_COL_PORTD_FER  ((uint16_t) ((uint16_t) 1<<7))
#define EMAC0_CRS_PORTD_FER  ((uint16_t) ((uint16_t) 1<<2))
#define EMAC0_MDC_PORTH_FER  ((uint16_t) ((uint16_t) 1<<3))
#define EMAC0_MDIO_PORTH_FER  ((uint16_t) ((uint16_t) 1<<4))
#define EMAC0_PTPAUXIN0_PORTI_FER  ((uint16_t) ((uint16_t) 1<<2))
#define EMAC0_PTPCLKIN0_PORTI_FER  ((uint16_t) ((uint16_t) 1<<1))
#define EMAC0_PTPPPS0_PORTI_FER  ((uint16_t) ((uint16_t) 1<<4))
#define EMAC0_PTPPPS1_PORTI_FER  ((uint16_t) ((uint16_t) 1<<3))
#define EMAC0_PTPPPS2_PORTI_FER  ((uint16_t) ((uint16_t) 1<<5))
#define EMAC0_PTPPPS3_PORTI_FER  ((uint16_t) ((uint16_t) 1<<6))
#define EMAC0_RXCLK_REFCLK_PORTH_FER  ((uint16_t) ((uint16_t) 1<<7))
#define EMAC0_RXCTL_RXDV_PORTH_FER  ((uint32_t) ((uint32_t) 1<<8))
#define EMAC0_RXD0_PORTH_FER  ((uint16_t) ((uint16_t) 1<<5))
#define EMAC0_RXD1_PORTH_FER  ((uint16_t) ((uint16_t) 1<<6))
#define EMAC0_RXD2_PORTH_FER  ((uint32_t) ((uint32_t) 1<<11))
#define EMAC0_RXD3_PORTH_FER  ((uint32_t) ((uint32_t) 1<<12))
#define EMAC0_RXERR_PORTD_FER  ((uint16_t) ((uint16_t) 1<<6))
#define EMAC0_TXCLK_PORTH_FER  ((uint32_t) ((uint32_t) 1<<14))
#define EMAC0_TXCTL_TXEN_PORTH_FER  ((uint32_t) ((uint32_t) 1<<13))
#define EMAC0_TXD0_PORTH_FER  ((uint32_t) ((uint32_t) 1<<9))
#define EMAC0_TXD1_PORTH_FER  ((uint32_t) ((uint32_t) 1<<10))
#define EMAC0_TXD2_PORTH_FER  ((uint32_t) ((uint32_t) 1<<15))
#define EMAC0_TXD3_PORTI_FER  ((uint16_t) ((uint16_t) 1<<0))
#define EMAC1_CRS_PORTF_FER  ((uint16_t) ((uint16_t) 1<<3))
#define EMAC1_MDC_PORTF_FER  ((uint16_t) ((uint16_t) 1<<2))
#define EMAC1_MDIO_PORTF_FER  ((uint16_t) ((uint16_t) 1<<1))
#define EMAC1_REFCLK_PORTE_FER  ((uint32_t) ((uint32_t) 1<<11))
#define EMAC1_RXD0_PORTE_FER  ((uint32_t) ((uint32_t) 1<<15))
#define EMAC1_RXD1_PORTF_FER  ((uint16_t) ((uint16_t) 1<<0))
#define EMAC1_TXD0_PORTE_FER  ((uint32_t) ((uint32_t) 1<<13))
#define EMAC1_TXD1_PORTE_FER  ((uint32_t) ((uint32_t) 1<<14))
#define EMAC1_TXEN_PORTE_FER  ((uint32_t) ((uint32_t) 1<<12))
#define TWI2_SCL_PORTA_FER  ((uint32_t) ((uint32_t) 1<<14))
#define TWI2_SDA_PORTA_FER  ((uint32_t) ((uint32_t) 1<<15))

int32_t adi_initpinmux(void);

/*
 * Initialize the Port Control MUX and FER Registers
 */
int32_t adi_initpinmux(void) {
    /* PORTx_MUX registers */
    *pREG_PORTA_MUX = TWI2_SCL_PORTA_MUX | TWI2_SDA_PORTA_MUX;
    *pREG_PORTD_MUX = EMAC0_COL_PORTD_MUX | EMAC0_CRS_PORTD_MUX
     | EMAC0_RXERR_PORTD_MUX;
    *pREG_PORTE_MUX = EMAC1_REFCLK_PORTE_MUX | EMAC1_RXD0_PORTE_MUX
     | EMAC1_TXD0_PORTE_MUX | EMAC1_TXD1_PORTE_MUX | EMAC1_TXEN_PORTE_MUX;
    *pREG_PORTF_MUX = EMAC1_CRS_PORTF_MUX | EMAC1_MDC_PORTF_MUX
     | EMAC1_MDIO_PORTF_MUX | EMAC1_RXD1_PORTF_MUX;
    *pREG_PORTH_MUX = EMAC0_MDC_PORTH_MUX | EMAC0_MDIO_PORTH_MUX
     | EMAC0_RXCLK_REFCLK_PORTH_MUX | EMAC0_RXCTL_RXDV_PORTH_MUX | EMAC0_RXD0_PORTH_MUX
     | EMAC0_RXD1_PORTH_MUX | EMAC0_RXD2_PORTH_MUX | EMAC0_RXD3_PORTH_MUX
     | EMAC0_TXCLK_PORTH_MUX | EMAC0_TXCTL_TXEN_PORTH_MUX | EMAC0_TXD0_PORTH_MUX
     | EMAC0_TXD1_PORTH_MUX | EMAC0_TXD2_PORTH_MUX;
    *pREG_PORTI_MUX = EMAC0_PTPAUXIN0_PORTI_MUX | EMAC0_PTPCLKIN0_PORTI_MUX
     | EMAC0_PTPPPS0_PORTI_MUX | EMAC0_PTPPPS1_PORTI_MUX | EMAC0_PTPPPS2_PORTI_MUX
     | EMAC0_PTPPPS3_PORTI_MUX | EMAC0_TXD3_PORTI_MUX;

    /* PORTx_FER registers */
    *pREG_PORTA_FER = TWI2_SCL_PORTA_FER | TWI2_SDA_PORTA_FER;
    *pREG_PORTD_FER = EMAC0_COL_PORTD_FER | EMAC0_CRS_PORTD_FER
     | EMAC0_RXERR_PORTD_FER;
    *pREG_PORTE_FER = EMAC1_REFCLK_PORTE_FER | EMAC1_RXD0_PORTE_FER
     | EMAC1_TXD0_PORTE_FER | EMAC1_TXD1_PORTE_FER | EMAC1_TXEN_PORTE_FER;
    *pREG_PORTF_FER = EMAC1_CRS_PORTF_FER | EMAC1_MDC_PORTF_FER
     | EMAC1_MDIO_PORTF_FER | EMAC1_RXD1_PORTF_FER;
    *pREG_PORTH_FER = EMAC0_MDC_PORTH_FER | EMAC0_MDIO_PORTH_FER
     | EMAC0_RXCLK_REFCLK_PORTH_FER | EMAC0_RXCTL_RXDV_PORTH_FER | EMAC0_RXD0_PORTH_FER
     | EMAC0_RXD1_PORTH_FER | EMAC0_RXD2_PORTH_FER | EMAC0_RXD3_PORTH_FER
     | EMAC0_TXCLK_PORTH_FER | EMAC0_TXCTL_TXEN_PORTH_FER | EMAC0_TXD0_PORTH_FER
     | EMAC0_TXD1_PORTH_FER | EMAC0_TXD2_PORTH_FER;
    *pREG_PORTI_FER = EMAC0_PTPAUXIN0_PORTI_FER | EMAC0_PTPCLKIN0_PORTI_FER
     | EMAC0_PTPPPS0_PORTI_FER | EMAC0_PTPPPS1_PORTI_FER | EMAC0_PTPPPS2_PORTI_FER
     | EMAC0_PTPPPS3_PORTI_FER | EMAC0_TXD3_PORTI_FER;
    return 0;
}

