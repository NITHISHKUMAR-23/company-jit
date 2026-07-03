/*********************************************************************************
Copyright(c) 2020-2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * SPI_MemoryMappedMode.h
 *****************************************************************************/

#ifndef __SPI_MEMORYMAPPEDMODE_H__
#define __SPI_MEMORYMAPPEDMODE_H__

/* This macro should be enabled when EV-SOMCRR-EZKIT is used */
//#define EV_SOMCRR_EZKIT_SUPPORT

/* This macro should be enabled when EV-SOMCRR-EZLITE is used */
//#define EV_SOMCRR_EZLITE_SUPPORT


/* This to make sure at a time only either EV-SOMCRR-EZKIT
 * is defined or EV-SOMCRR-EZLITE, both should not be defined together
 */
#if defined(EV_SOMCRR_EZKIT_SUPPORT) && defined(EV_SOMCRR_EZLITE_SUPPORT)
#error "Only one of the macro EV_SOMCRR_EZKIT_SUPPORT or EV_SOMCRR_EZLITE_SUPPORT should be defined"
#elif !defined(EV_SOMCRR_EZKIT_SUPPORT) && !defined(EV_SOMCRR_EZLITE_SUPPORT)
#error "Either one of the macro EV_SOMCRR_EZKIT_SUPPORT or EV_SOMCRR_EZLITE_SUPPORT should be defined"
#endif

/* spi Device Info */
#define SPI_DEVICE_NUM          2u
#define SPI_SELECT_NUM          ADI_SPI_SSEL_ENABLE1

#define CMD_SINGLE_MODE_READ    0x03u

/* SPI Flash start address */
#define SPI_FLASH_MEMORY   0x60000000u

/* This should be number of bytes that is to be read into the buffer */
#define BUFFER_SIZE  20u

#endif /* __SPI_MEMORYMAPPEDMODE_H__ */
