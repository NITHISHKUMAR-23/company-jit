/*********************************************************************************
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/
/*!
* @file      ospi_phycalibration.h
*
* @brief     This is the primary source file for OSPI-PHY mode Flash Direct read access example.
*
*/

#ifndef __OSPI_PHYCALIBRATION_H__
#define __OSPI_PHYCALIBRATION_H__

#include <drivers/ospi/adi_ospi.h>
#include <drivers/twi/adi_twi.h>
#include <services/dma/adi_dma.h>
#include <services/pwr/adi_pwr.h>
#include <stdio.h>
#include <sys/adi_core.h>


#define OSPI_DS  2

/* Flash commands */
#define FLASH_RD_STAT1			(0x05u)  //	Read Status Register1
#define FLASH_WR_STAT			(0x01u)	//	Write status register
#define	FLASH_WR_EN				(0x06u)  //	Set Write Enable Latch

#define FLASH_BE				(0xD8u)  //  Flash Block Erase (64KB) command
#define FLASH_PG_PROGRAM		(0x02u)	//  Normal Write mode
#define	FLASH_READ				(0x03u)	//	Normal Read mode
#define	FLASH_FST_READ			(0x0Bu)	//	Fast Read mode
#define	FLASH_QIOR_DTRREAD      (0xEDu)	//	Fast Read mode

#define WIP                  	(0x1u)	//Check the write in progress bit of the SPI status register
#define WEL                  	(0x2u)	//Check the write enable bit of the SPI status register


#define FLASHADDRESS 			0x60000000
#define MEMCOPY_NUM_DESC 		1
#define MDMA_CHANNEL_USED 		ADI_DMA_MEMDMA_S0


typedef enum
{
    /*! Flash is configured in STR OPI mode */
	STR_MODE,

    /*!  Flash is configured in DTR OPI mode */
	DTR_MODE,

} FLASH_OPI_MODE;


/* Test case specific functions definitions */
void OspiMdmaCallback(void *AppHandle, uint32_t Event, void *pArg);
void Wait_For_DMA(void);
int8_t VerifyData(uint8_t *pReadBuff, uint8_t *pWriteBuff, uint32_t BUFF_size);
void Prepare_Ospi_Command(ADI_OSPI_DAC_CMD *pDAC_Command);
void Select_FlashDevice(void);

ADI_OSPI_RESULT Erase_Flash_Block0(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command);
ADI_OSPI_RESULT Configure_Flash(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command);
ADI_OSPI_RESULT QuadEn_IS25LP512M(ADI_OSPI_HANDLE const hDevice, ADI_OSPI_STIGCMD *pSTIG_Command);
#endif /* __OSPI_PHYCALIBRATION_H__ */
