/******************************************************************************

Copyright (c) 2019 - 2021 Analog Devices.  All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*******************************************************************************/

/*!
* @file      adi_ospi_config_SC59x.h
*
* @brief     OSPI driver static configuration Header file
*
* @details
*            OSPI driver static configuration Header file
*/


/** @addtogroup OSPI_Driver OSPI Device Driver
 *  @{
 */

/** @addtogroup OSPI_Driver_Static_Configuration OSPI Device Driver Static Configuration
 *  @{
 */


#ifndef _ADI_OSPI_CONFIG_DEF_H_
#define _ADI_OSPI_CONFIG_DEF_H_


/*! Defines CPHASE value 
	0U - SPI CLK toggles from middle
	1U - SPI CLK toggles from start
*/
#define ADI_OSPI_CPHASE                 (0U)

/*! Defines CPOL value 
	0U - Active-high SPI CLK
	1U - Active-low SPI CLK
*/
#define ADI_OSPI_CPOL                   (0U)

/*! Defines default Baudrate divider value */
#define ADI_OSPI_BAUD_DIV               (15U)

/*! Flash Slave select to use by default 
	1U - OSPI_SSEL1 chip select signal used
	2U - OSPI_SSEL2 chip select signal used
	3U - OSPI_SSEL3 chip select signal used
	4U - OSPI_SSEL4 chip select signal used
*/
#define ADI_OSPI_FLASH_CS  			     (1U)



/*! Define Number of address bytes for Direct Read and Direct Write modes
	0U - 1 address byte
	1U - 2 address bytes
	2U - 3 address bytes
	3U - 4 address bytes
*/
#define ADI_OSPI_NUM_ADDRBYTES           (2U)

/*! Number of bytes per device page for flash program */
#define ADI_OSPI_PAGE_SIZE               (256U)

/*! Number of bytes per block used for write protection
	0U - 1 byte
	1U - 2 bytes
	2U - 4 bytes
	3U - 8 bytes
	4U - 16 bytes
	5U - 32 bytes
	6U - 64 bytes
	7U - 128 bytes
	8U - 256 bytes
	9U - 512 bytes
	10U - 1024 bytes
	11U - 2048 bytes
	12U - 4096 bytes
	13U - 8192 bytes
	14U - 16384 bytes
	15U - 32768 bytes
	16U - 65535 bytes
*/
#define ADI_OSPI_BLOCK_SIZE               (16U)
   

/*! Defines delay in number of reference clocks between setting SSEL signal low and first bit transfer */
#define ADI_OSPI_DEVDELAY_INIT   		 (0U)

/*! Defines delay in number of reference clocks between last bit of current transaction and 
	de-asserting the SSEL signal. */
#define ADI_OSPI_DEVDELAY_LSTTRAN 		 (0U)

/*! Defines delay in number of reference clocks between one chip select being de-activated and the activation of another */
#define ADI_OSPI_DEVDELAY_DEACT  		 (0U)

/*! Defines delay in number of reference clocks for the length that the master mode chip select outputs are de-asserted between transactions */
#define ADI_OSPI_DEVDELAY_DEASRT   		 (0U)

/*! This defines whether the address remapping is enabled or not. This should be set to 0x1 for the DAC address remap provided in 
    ADI_OSPI_ADDRREMAP to take effect. */
#define ADI_OSPI_ADDRREMAP_EN            (0x0U)

/*! This value defines the address offset for DAC accesses. Any access to flash is offset by this address */
#define ADI_OSPI_ADDRREMAP               (0x0U)

/*! This value defines the lower boundary of the write protection area */
#define ADI_OSPI_WP_BOUNDARY_LOW         (0U)

/*! This value defines the upper boundary of the write protection area */
#define ADI_OSPI_WP_BOUNDARY_UPP         (0U)

/*! This value defines whether write protection is enabled or not 
	0U - Write Protection is disabled
	1U - Write Protection is enabled
*/
#define ADI_OSPI_WP_ENABLE               (0U)

/*! This value defines whether write protection range is inverted 
	0U - Write Protection is not inverted
	1U - Write Protection is inverted
*/
#define ADI_OSPI_WP_RANGE_INVERT         (0U)

/*! Defines the opcode for reading the flash status after write/program operation
	Controller uses this value to issue the flash status read
*/
#define ADI_OSPI_FLASH_POLLING_OPCODE    (0x5)

/*! Flash status polling bit Index : Bit position of "write in progress" bit in flash status register */
#define ADI_OSPI_FLASH_POLLING_INDEX 	 (0)

/*! Flash status polling bit polarity : value of bit when flash program operation is complete 
	0U - The write transfer to the device will be complete if the polled bit is equal to "0"
	1U - The write transfer to the device will be complete if the polled bit is equal to "1"
*/
#define ADI_OSPI_FLASH_POLLING_POLARITY  (0)

/*! OSPI Timeout duration in ticks: Timeouts are used in driver for certain expected results to avoid indefinite wait */
#define ADI_OSPI_TIMEOUT_TICKS           (5000U)

/*! Define whether the reset pin of Flash is mapped to the DQ3 pin 
	0U - RESET feature on DQ3 pin of the device
	1U - HOLD feature on DQ3 pin of the device
*/
#define ADI_OSPI_FLASHRESET_MAPPING      (1U)


#endif /* _ADI_OSPI_CONFIG_DEF_H_ */

/** @}*/

