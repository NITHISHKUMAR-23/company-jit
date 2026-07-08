/*********************************************************************************
Copyright(c) 2019-2024 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * UARTDMAMode.h
 *****************************************************************************/

#ifndef __UARTDMAMODE_H__
#define __UARTDMAMODE_H__

#define ADI_CACHE_ROUND_UP_SIZE(size, type) \
    (((((((size) * sizeof(type)) \
           + (ADI_CACHE_LINE_LENGTH - 1uL)) \
          / ADI_CACHE_LINE_LENGTH) * ADI_CACHE_LINE_LENGTH) \
      + (sizeof(type) - 1uL)) / sizeof(type))

/* Macro for reporting errors */
#define REPORT_ERROR        printf
#define SUCCESS   0
#define FAILED   -1

/* Only one macro should be enabled between STOP_DMA_MODE and LISTDESCRIPTOR_DMA_MODE */
#define STOP_DMA_MODE
//#define LISTDESCRIPTOR_DMA_MODE

#if defined(STOP_DMA_MODE)
/* In Stop DMA mode it is similar to a single descriptor DMA mode so DMA_NUM_DESC should always be one */
#define DMA_NUM_DESC            1u
#elif defined(LISTDESCRIPTOR_DMA_MODE)
#define DMA_NUM_DESC            4u
#endif
#define DESC_BUFFER_SIZE        500u
#define DMA_MSIZE_IN_BYTES      1u


/*   UART instances  */
#define UART_DEVA      ADI_UART_0
#define UART_DEVB      ADI_UART_1


#define UART0_SPU_PID             (29)
#define UART1_SPU_PID             (30)

#define UART0_TxDMA_SPU_PID       (80)
#define UART1_RxDMA_SPU_PID       (81)

#endif /* __UARTDMAMODE_H__ */
