/*********************************************************************************
Copyright(c) 2020-2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * SPIDMAMode.h
 *****************************************************************************/

#ifndef __SPIDMAMODE_H__
#define __SPIDMAMODE_H__

/* This macro should be enabled when EV-SOMCRR-EZKIT is used */
//#define EV_SOMCRR_EZKIT_SUPPORT

/* This macro should be enabled when EV-SOMCRR-EZLITE is used */
#define EV_SOMCRR_EZLITE_SUPPORT


/* This to make sure at a time only either EV-SOMCRR-EZKIT
 * is defined or EV-SOMCRR-EZLITE, both should not be defined together
 */
#if defined(EV_SOMCRR_EZKIT_SUPPORT) && defined(EV_SOMCRR_EZLITE_SUPPORT)
#error "Only one of the macro EV_SOMCRR_EZKIT_SUPPORT or EV_SOMCRR_EZLITE_SUPPORT should be defined"
#elif !defined(EV_SOMCRR_EZKIT_SUPPORT) && !defined(EV_SOMCRR_EZLITE_SUPPORT)
#error "Either one of the macro EV_SOMCRR_EZKIT_SUPPORT or EV_SOMCRR_EZLITE_SUPPORT should be defined"
#endif

/*  Possible SPI instances are
    ADI_SPI_0,ADI_SPI_1 and ADI_SPI_2  */

#define SPI_DEVA      ADI_SPI_0
#define SPI_DEVB      ADI_SPI_1

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

#define SPI0_SPU_PID             (ADI_SPU0_SPI0_ID)
#define SPI1_SPU_PID             (ADI_SPU0_SPI1_ID)
#define SPI2_SPU_PID             (ADI_SPU0_SPI2_ID)

#define SPI0_TxDMA_SPU_PID       (ADI_SPU0_DMA22_ID)
#define SPI0_RxDMA_SPU_PID       (ADI_SPU0_DMA23_ID)

#define SPI1_TxDMA_SPU_PID       (ADI_SPU0_DMA24_ID)
#define SPI1_RxDMA_SPU_PID       (ADI_SPU0_DMA25_ID)

#define SPI2_TxDMA_SPU_PID       (ADI_SPU0_DMA26_ID)
#define SPI2_RxDMA_SPU_PID       (ADI_SPU0_DMA27_ID)

#endif /* __SPIDMAMODE_H__ */
