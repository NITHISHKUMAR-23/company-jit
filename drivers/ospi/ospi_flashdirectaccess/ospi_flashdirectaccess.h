/*********************************************************************************
Copyright(c) 2020 - 2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/
/*!
* @file      ospi_flashdirectaccess.h
*
* @brief     This is the primary header file for OSPI Flash Direct read access example.
*
*/

#ifndef __OSPI_FLASHDIRECTACCESS_H__
#define __OSPI_FLASHDIRECTACCESS_H__

#include <drivers/ospi/adi_ospi.h>
#include <drivers/twi/adi_twi.h>
#include <services/dma/adi_dma.h>
#include <services/pwr/adi_pwr.h>
#include <stdio.h>

/* This macro should be enabled when EV-SOMCRR-EZKIT is used */
//#define EV_SOMCRR_EZKIT_SUPPORT

/* This macro should be enabled when EV-SOMCRR-EZLITE is used */
//#define EV_SOMCRR_EZLITE_SUPPORT


/* This to make sure at a time only either EV-SOMCRR-EZKIT
 * is defined or EV-SOMCRR-EZLITE, both should not be defined together
 */
#if defined(EV_SOMCRR_EZKIT_SUPPORT) && defined(EV_SOMCRR_EZLITE_SUPPORT)
#error "Only one of the macro EV_SOMCRR_EZKIT_SUPPORT or EV_SOMCRR_EZLITE_SUPPORT should be defined"
#endif

#ifdef __ADSPSC598_FAMILY__
#define ADI_CACHE_ROUND_UP_SIZE(size, type) \
    (((((((size) * sizeof(type)) \
           + (ADI_CACHE_LINE_LENGTH - 1uL)) \
          / ADI_CACHE_LINE_LENGTH) * ADI_CACHE_LINE_LENGTH) \
      + (sizeof(type) - 1uL)) / sizeof(type))

/* Only one macro should be enabled between STOP_DMA_MODE and LISTDESCRIPTOR_DMA_MODE */
#define STOP_DMA_MODE
//#define LISTDESCRIPTOR_DMA_MODE

#if defined(STOP_DMA_MODE)
/* In Stop DMA mode it is similar to a single descriptor DMA mode so DMA_NUM_DESC should always be one */
#define DMA_NUM_DESC            1u
#elif defined(LISTDESCRIPTOR_DMA_MODE)
#define DMA_NUM_DESC            4u
#endif
#define DESC_BUFFER_SIZE        1024u
#define DMA_MSIZE_IN_BYTES      1u
#endif

#ifndef __ADSPSC598_FAMILY__
/* TWI2 Pin mux  */
#define TWI2_SCL_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<28))
#define TWI2_SDA_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<30))

#define TWI2_SCL_PORTA_FER  ((uint32_t) ((uint32_t) 1<<14))
#define TWI2_SDA_PORTA_FER  ((uint32_t) ((uint32_t) 1<<15))
#endif


/* Flash commands */
#define	FLASH_WR_EN					(0x06)  /*	Set Write Enable Latch */
#define FLASH_WR_DI					(0x04)  /*	Reset Write Enable Latch */
#define SPI_RDID            		(0x9F)  /*	Read Identification */
#define FLASH_RD_STAT1				(0x05)  /*	Read Status Register1 */
#define FLASH_RD_STAT2				(0x35)  /*	Read Status Register2 */
#define FLASH_WR_STAT				(0x01)	/*	Write status register */
#define FLASH_ENTER_QPI				(0x35)	/*	Enter Flash QPI mode */
#define FLASH_EXIT_QPI				(0xF5)	/*	Exit Flash QPI mode */

#define FLASH_RD_EVCR_MICRON		(0x65)	/*	Read Enhanced volatile configuration register Micron */
#define FLASH_WR_EVCR_MICRON		(0x61)	/*	Read Enhanced volatile configuration register Micron */

#define FLASH_WR_WRCR2				(0x72)	/*	MX66LM1G write WRCR2 register */
#define FLASH_RD_WRCR2				(0x71)	/*	MX66LM1G read WRCR2 register */

#define FLASH_RESETEN				(0x66)	/*	Flash Reset Enable */
#define FLASH_RESET					(0x99)	/*	Flash Reset */

#define	FLASH_READ					(0x03)	/*	Normal Read mode */
#define	FLASH_FST_READ				(0x0B)	/*	Fast Read mode */
#define	FLASH_SINGLE_DTRREAD		(0x0D)	/*	Fast Read mode */
#define	FLASH_DOR_READ      		(0x3B)	/*	Fast Read mode */
#define	FLASH_DOR_DTRREAD      		(0x3D)	/*	Fast Read mode */
#define	FLASH_DIOR_READ      		(0xBB)	/*	Fast Read mode */
#define	FLASH_DIOR_DTRREAD     		(0xBD)	/*	Fast Read mode */
#define	FLASH_QOR_READ      		(0x6B)	/*	Fast Read mode */
#define	FLASH_QOR_DTRREAD      		(0x6D)	/*	Fast Read mode */
#define	FLASH_QIOR_READ      		(0xEB)	/*	Fast Read mode */
#define	FLASH_QIOR_DTRREAD      	(0xED)	/*	Fast Read mode */
#define FLASH_OPI_READ_1			(0xEC)
#define FLASH_OPI_READ_2			(0x13)
#define FLASH_OPI_DTRREAD_1			(0xEE)
#define FLASH_OPI_DTRREAD_2			(0x11)

#define FLASH_BE					(0xD8)  /*  Flash Block Erase (64KB) command */
#define FLASH_PG_PRM				(0x02)	/*	Page Program */
#define FLASH_DI_PRM				(0xA2)	/*	Dual Input Page Program  (Data on 2 lines) */
#define FLASH_EDI_PRM				(0xD2)	/*	Extended Dual Input Page Program (Address also on 2 lines) */
#define FLASH_QI_PRM    			(0x32)	/*	Quad Input Page Program */
#define FLASH_EQI_PRM				(0x38)	/*	Extended Quad Input Page Program */
#define FLASH_EQI_PRM_MIC			(0x12)	/*	Extended Quad Input Page Program for Micron Flashes */


#define DUMMY_BYTE				    (0x00)	/* dummy word, used in read operations */
#define WIP                  	    (0x1)	/* Check the write in progress bit of the SPI status register */
#define WEL                  		(0x2)	/* Check the write enable bit of the SPI status register */


#define FLASHADDRESS 		0x60000000
#define MEMCOPY_NUM_DESC 	1
#define MDMA_CHANNEL_USED 	ADI_DMA_MEMDMA_S0




/* Function prototypes */
void Prepare_Ospi_Command(ADI_OSPI_DAC_CMD *pDAC_Command);
ADI_OSPI_RESULT Configure_Flash(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command);
ADI_OSPI_RESULT Restore_Flash(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command);
ADI_OSPI_RESULT QPI_En_IS25LP512M(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command);

void Select_FlashDevice(void);
#ifndef __ADSPSC598_FAMILY__
void Init_pinmux(void);
void Init_TwiPinMux(void);
#endif
int Ospi_initialize(void);
int Spu_Initialize(void);
ADI_OSPI_RESULT Erase_Flash_Block0(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command);
void OspiMdmaCallback(void *AppHandle, uint32_t Event, void *pArg);
void Wait_For_DMA(void);
int8_t VerifyData(uint8_t *pReadBuff, uint8_t *pWriteBuff, uint32_t BUFF_size);

extern void ConfigSoftSwitches_EV_21593_SOM(void);
extern void ConfigSoftSwitches_SC598_SOM(void);
extern void ConfigSoftSwitches_EV_SOMCRR_EZKIT(void);
extern void ConfigSoftSwitches_SOMCRR_EZLITE(void);
#endif /* __OSPI_FLASHDIRECTACCESS_H__ */
