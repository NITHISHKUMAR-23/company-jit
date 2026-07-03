/*****************************************************************************
* SPI_Core1.h
*****************************************************************************/

#ifndef __SPI0_CORE1_H__
#define __SPI0_CORE1_H__


#include <stdio.h>
#include <stdint.h>
//#include <sys/platform.h>
//#include <sys/adi_core.h>
//#include <services/spu/adi_spu.h>
//#include <drivers/spi/adi_spi.h>
//#include <drivers/twi/adi_twi.h>
//#include "adi_initialize.h"

#define DEVICE_ID       ADI_SPI_0	// SPI device identifier (using SPI0 for this case)
#define LIST_SIZE       5			// Maximum number of SPI data elements to handle
#define TWI_NO		    2			// TWI number (TWI2 is used here)
#define TWI_BITRATE     (100u)		// TWI bitrate in kHz (100 kHz)
#define TWI_DUTYCYCLE   (50u)		// TWI duty cycle (50% - standard)
#define TWI_PRESCALE	(12u)		// TWI Prescaler value (used to set clock speed)
#define BUFFER_SIZE     (32u)		// Size of buffer for data transfer (32 bytes)
#define TWI2_SCL_EN		0<<28		// Bitmask to enable TWI2 SCL line (Clock line)
#define TWI2_SDA_EN		0<<30		// Bitmask to enable TWI2 SDA line (Data line)
#define PORTA_TWI2_EN   3<<14		// Bitmask to enable TWI2 (SCL & SDA) on Port A
#define TARGET_ADDRESS  (0x21u)		// Target device address for TWI2
#define LED_REG_ADDR	(0x12u)		// Register address for controlling LED
#define LED_SET			(0x04u)		// Value to set the LED (for turning it on or off)

/* Create a Structure and store the Register address and value in it */
typedef struct{

uint8_t register_addr;	// The register address of the device
uint8_t value;			// The value to be written to the register

}Led_config;


/**
 * @brief Checks the result of an SPI operation.
 *
 * This function takes the result of an SPI operation (of type `ADI_SPI_RESULT`) as input,
 * and verifies whether the operation was successful. If the result indicates an error,
 * the function typically handles it by printing an error message.
 *
 * This function should be called after any SPI operation to ensure that the operation was successful.
 * It helps to identify potential issues during communication with SPI peripherals.
 *
 * @param result The result of an SPI operation, typically returned by the SPI driver.
 */
static void Check(ADI_SPI_RESULT);


/**
 * @brief Checks the result of a TWI operation.
 *
 * This function takes the result of a TWI operation (of type `ADI_TWI_RESULT`) as input
 * and validates whether the operation completed successfully. It checks the returned
 * status code and typically prints an error message.
 *
 * This function should be called after any TWI operation to ensure that the operation was successful.
 * It helps to identify potential issues during communication with Target device.
 *
 * @param result The result of a TWI operation, typically returned by the TWI driver.
 */
static void Check_TWI(ADI_TWI_RESULT);


#endif /* __SPI0_CORE1_H__ */



