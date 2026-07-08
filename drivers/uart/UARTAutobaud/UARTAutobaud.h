/*********************************************************************************
Copyright(c) 2019-2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * UARTAutobaud.h
 *****************************************************************************/

#ifndef __UARTAUTOBAUD_H__
#define __UARTAUTOBAUD_H__


#define BUFF_SIZE   8u

/* Set UART Device Number to the required UART to be tested
 *  UART0 -- ADI_UART_0
 *  UART1 -- ADI_UART_1
 *  UART2 -- ADI_UART_2
 *  UART3 -- ADI_UART_3
 */
#define ADI_UART_DEVNUM  ADI_UART_0

#define CLKIN                              (25u  * MHZTOHZ)

#define MHZTOHZ                            (1000000u)

/* Macro for reporting errors */
#define REPORT_ERROR        printf

#define SUCCESS   0
#define FAILED   -1

#endif /* __UARTAUTOBAUD_H__ */
