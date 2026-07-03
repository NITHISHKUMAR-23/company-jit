/******************************************************************************
 * @file:    adi_spi_config_SC59x.h
 * @brief:   SPI driver static configuration
 * @version: $Revision: 62861 $
 * @date:    $Date: 2019-11-27 09:36:45 -0500 (Wed, 27 Nov 2019) $
 *****************************************************************************

 Copyright (c) 2020 Analog Devices.  All Rights Reserved.

 This software is proprietary.  By using this software you agree
 to the terms of the associated Analog Devices License Agreement.
 
*******************************************************************************/

/*
 * @file      adi_spi_config_SC59x.h
 *
 * @brief     SPI driver static configuration
 *
 * @details   Header File which has the static configuration for SPI instances.
 *
 */

/** @addtogroup SPI_Driver SPI Device Driver
 *  @{
 */

/** @addtogroup SPI_Driver_Static_Configuration SPI Device Driver Static Configuration
 *  @{

  Static Configuration: Using this configuration application can configure the control register
  parameters upfront which can be set to default before SPI data transfer starts. This configuration
  has macros which can be configured through adi_spi_config_SC59x.h file which by default is available
  with SPI driver. Example project can maintain a copy of it locally for custom configuration.

  Default Static Configuration for SPI(0/1/2/3):
  The default configuration for SPI using preload:
        SPI clock rate : 12.50 MHz
        SPI0 - Master, SPI1 - Slave, SPI2 - Master, SPI3 - Slave.
        Rest of the values are power on reset values.

  Specifies the SPI(X)_CLK register Divisor\n
    ADI_SPI(X)_CFG_CLK_BAUD                   (9ul)-----SPI Clock - 12.5 MHz\n

  Specifies the SPI(X)_Control register Configuration\n
    ADI_SPI(0)_CFG_SLAVE_MASTER               (0x1ul)---SPI 0 Master\n
    ADI_SPI(1)_CFG_SLAVE_MASTER               (0x0ul)---SPI 1 Slave\n
    ADI_SPI(2)_CFG_SLAVE_MASTER               (0x1ul)---SPI 2 Master\n
    ADI_SPI(3)_CFG_SLAVE_MASTER               (0x0ul)---SPI 3 Slave\n
    ADI_SPI(X)_CFG_CLK_PHASE                  (0x1ul)---power on reset value\n
    ADI_SPI(X)_CFG_CLK_POLARITY               (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_HW_SLAVE_SELECT            (0x1ul)---power on reset value\n
    ADI_SPI(X)_CFG_TRANSFER_SIZE              (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_MSB_LSB                    (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_RXFIFO_REG_WATERMARK       (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_TXFIFO_REG_WATERMARK       (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_OPEN_DRAIN_MODE            (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_SLAVE_SELECT_POLARITY      (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_FLOW_CONTROL               (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_FLOW_CONTROL_WATERMARK     (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_FLOW_CONTROL_POLARITY      (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_FLOW_CONTROL_CHANNEL       (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_FASTMODE                   (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_MULTIPLE_I0_MODE           (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_START_ON_MOSI              (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_PROTECTED_SLV_SELECT_EN    (0x0ul)---power on reset value\n
    ADI_SPI(X)_CFG_ENABLE_MISO                (0x0ul)---power on reset value\n
*/

#ifndef __ADI_SPI_CONFIG_SC59x_H__
#define __ADI_SPI_CONFIG_SC59x_H__

#include <sys/platform.h>
#include <stdint.h>

#if defined(__ADSPSC594__) || defined(__ADSPSC592__) || \
    defined(__ADSPSC594W__) || defined(__ADSPSC592W__)
/*! Number of SPI instances that are enabled */
#define ADI_SPI_CFG_INSTANCES                         4ul
#else
/*! Number of SPI instances that are enabled */
#define ADI_SPI_CFG_INSTANCES                         3ul
#endif
/*! select/unselect SPI0 Instance */
#define ADI_SPI0_INSTANCE                             1ul

/*! select/unselect SPI1 Instance */
#define ADI_SPI1_INSTANCE                             1ul

/*! select/unselect SPI2 Instance */
#define ADI_SPI2_INSTANCE                             1ul

#if defined(__ADSPSC594__) || defined(__ADSPSC592__) || \
    defined(__ADSPSC594W__) || defined(__ADSPSC592W__)
/*! select/unselect SPI3 Instance */
#define ADI_SPI3_INSTANCE                             1ul
#endif

/**************************************************************************************************************/
/*! This configuration sets the baud rate for the SPI data transfers\n
    Baud can be calculated as BAUD = (SCLK0_0/SPI_Clock) - 1\n */
#define ADI_SPI0_CFG_CLK_BAUD                         9ul
/**************************************************************************************************************/

/**************************************************************************************************************/
/*! Master or Slave mode of operation\n
    SPI Control Register: Bit[1]\n
    (0) - Slave mode\n
    (1) - Master mode\n*/
#define ADI_SPI0_CFG_SLAVE_MASTER                     0x1ul

/*! Configures whether the SPI starts toggling the signal for the SPI clock\n
    from the start of the first data bit or from the middle of the first data bit\n
    SPI Control Register: Bit[4]\n
    (0) - Serial clock pulses at the end of each serial bit transfer\n
    (1) - Serial clock pulses at the beginning of each serial bit transfer\n*/
#define ADI_SPI0_CFG_CLK_PHASE                        0x1ul

/*! Configures whether the SPI uses an active-low or active-high signal for the SPI clock\n
    SPI Control Register: Bit[5]\n
    (0) - Active-high SPI Clock\n
    (1) - Active-low  SPI Clock\n*/
#define ADI_SPI0_CFG_CLK_POLARITY                     0x0ul

/*! Configures the SPI to control the assertion/de-assertion of the slave select signal\n
    SPI Control Register: Bit[6]\n
    (0) - Slave select controlled by software\n
    (1) - Slave select controlled by hardware\n*/
#define ADI_SPI0_CFG_HW_SLAVE_SELECT                  0x1ul

/*! SPI transfer size\n
    SPI Control Register: Bit[10:9]\n
    (0)  -  8  bit word\n
    (1)  -  16 bit word\n
    (2)  -  32 bit word\n*/
#define ADI_SPI0_CFG_TRANSFER_SIZE                    0x0ul

/*! SPI transmits/receives LSB or MSB First\n
    SPI Control Register: Bit[12]\n
    (0) - MSB transmitted first\n
    (1) - LSB transmitted first\n*/
#define ADI_SPI0_CFG_MSB_LSB                          0x0ul

/*! Configure SPI MOSI and MISO pins to behave as open drain outputs\n
    to prevent bus contention\n
    SPI Control Register: Bit[3]\n
    (0) -  Disable\n
    (1) -  Enable\n*/
#define ADI_SPI0_CFG_OPEN_DRAIN_MODE                  0x0ul

/*! Configures slave select polarity between transfers\n
    SPI Control Register: Bit[7]\n
    (0) - De-assert slave select (high)\n
    (1) - Assert slave select (low)\n*/
#define ADI_SPI0_CFG_SLAVE_SELECT_POLARITY            0x0ul

/*! Configures the flow control bit to communicate with slow devices\n
    SPI Control Register: Bit[13]\n
    (0) - Disable\n
    (1) - Enable\n*/
#define ADI_SPI0_CFG_FLOW_CONTROL                     0x0ul

/*! Configures the watermark for flow control\n
    SPI Control Register: Bits[17:16]\n
    (0) - TFIFO empty or RFIFO full\n
    (1) - TFIFO 75% or more empty, or RFIFO 75% or more full\n
    (2) - TFIFO 50% or more empty, or RFIFO 50% or more full\n*/
#define ADI_SPI0_CFG_FLOW_CONTROL_WATERMARK           0x0ul

/*! Configure the polarity of the ready pin\n
    SPI Control Register: Bit[15]\n
    (0) - Active low ready\n
    (1) - Active High ready\n*/
#define ADI_SPI0_CFG_FLOW_CONTROL_POLARITY            0x0ul

/*! Configures Flow control for Transmit or Receive channel\n
    SPI Control Register: Bit[14]\n
    (0) - Flow control on Rx channel\n
    (1) - Flow control on Tx channel\n*/
#define ADI_SPI0_CFG_FLOW_CONTROL_CHANNEL             0x0ul

/*! Enable/Disable fast mode\n
    SPI Control Register: Bit[18]\n
    (0) - Disable\n
    (1) - Enable\n*/
#define ADI_SPI0_CFG_FASTMODE                         0x0ul

/*! Configure in Default or Dual I/O or Quad I/O mode\n
    SPI Control Register: Bits[21:20]\n
    (0) - SPI with MOSI and MISO, single I/O mode\n
    (1) - Dual I/O mode\n
    (2) - Quad I/O mode.(Not applicable for SPI0/SPI3)\n*/
#define ADI_SPI0_CFG_MULTIPLE_I0_MODE                 0x0ul
 
/*! configure start on MOSI\n
    SPI Control Register: Bit[22]\n
    (0) - Bit 0 on MOSI (for both DIOM and QIOM)\n
    (1) - Bit 0 on MISO(DIOM) or on D3(QIOM)\n*/
#define ADI_SPI0_CFG_START_ON_MOSI                    0x0ul

/*! Enables error detection in case of multi master\n
    environment when SPI is configured as master\n
    SPI Control Register: Bit[2]\n
    (0) - Disable\n
    (1) - Enable\n*/
#define ADI_SPI0_CFG_PROTECTED_SLV_SELECT_EN          0x0ul

/*! Enable SPI MISO mode. This mode is only applicable for SPI as a slave\n
    SPI Control Register: Bit[8]\n
    (0) - Disable\n
    (1) - Enable\n*/
#define ADI_SPI0_CFG_ENABLE_MISO                      0x0ul

/* Specifies the SPI0 Control register Configuration\n*/
#define ADI_SPI0_CTL                                  ((ADI_SPI0_CFG_SLAVE_MASTER << BITP_SPI_CTL_MSTR)|\
                                                       (ADI_SPI0_CFG_PROTECTED_SLV_SELECT_EN<<BITP_SPI_CTL_PSSE)|\
                                                       (ADI_SPI0_CFG_OPEN_DRAIN_MODE<<BITP_SPI_CTL_ODM)|\
                                                       (ADI_SPI0_CFG_CLK_PHASE<<BITP_SPI_CTL_CPHA)|\
                                                       (ADI_SPI0_CFG_CLK_POLARITY<<BITP_SPI_CTL_CPOL)|\
                                                       (ADI_SPI0_CFG_HW_SLAVE_SELECT<<BITP_SPI_CTL_ASSEL)|\
                                                       (ADI_SPI0_CFG_SLAVE_SELECT_POLARITY<<BITP_SPI_CTL_SELST)|\
                                                       (ADI_SPI0_CFG_ENABLE_MISO<<BITP_SPI_CTL_EMISO)|\
                                                       (ADI_SPI0_CFG_TRANSFER_SIZE<<BITP_SPI_CTL_SIZE)|\
                                                       (ADI_SPI0_CFG_MSB_LSB<<BITP_SPI_CTL_LSBF)|\
                                                       (ADI_SPI0_CFG_FLOW_CONTROL<<BITP_SPI_CTL_FCEN)|\
                                                       (ADI_SPI0_CFG_FLOW_CONTROL_CHANNEL<<BITP_SPI_CTL_FCCH)|\
                                                       (ADI_SPI0_CFG_FLOW_CONTROL_POLARITY<<BITP_SPI_CTL_FCPL)|\
                                                       (ADI_SPI0_CFG_FLOW_CONTROL_WATERMARK<<BITP_SPI_CTL_FCWM)|\
                                                       (ADI_SPI0_CFG_FASTMODE<<BITP_SPI_CTL_FMODE)|\
                                                       (ADI_SPI0_CFG_MULTIPLE_I0_MODE<<BITP_SPI_CTL_MIOM)|\
                                                       (ADI_SPI0_CFG_START_ON_MOSI<<BITP_SPI_CTL_SOSI))
/**************************************************************************************************************/

/**************************************************************************************************************/
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 1\n
    (1) - enables the slave select 1\n*/
#define ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_1            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 2\n
    (1) - enables the slave select 2\n*/
#define ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_2            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 3\n
    (1) - enables the slave select 3\n*/
#define ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_3            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 4\n
    (1) - enables the slave select 4\n*/
#define ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_4            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 5\n
    (1) - enables the slave select 5\n*/
#define ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_5            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 6\n
    (1) - enables the slave select 6\n*/
#define ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_6            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 7\n
    (1) - enables the slave select 7\n*/
#define ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_7            0x0ul

/* Specifies the SPI0 Slave select Control register Configuration\n*/
#define ADI_SPI0_CTL_SLAVE_SELECT_ENABLE              ((ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_7<<BITP_SPI_SLVSEL_SSE7)|\
                                                       (ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_6<<BITP_SPI_SLVSEL_SSE6)|\
                                                       (ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_5<<BITP_SPI_SLVSEL_SSE5)|\
                                                       (ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_4<<BITP_SPI_SLVSEL_SSE4)|\
                                                       (ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_3<<BITP_SPI_SLVSEL_SSE3)|\
                                                       (ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_2<<BITP_SPI_SLVSEL_SSE2)|\
                                                       (ADI_SPI0_CTL_SLAVE_SELECT_ENABLE_1<<BITP_SPI_SLVSEL_SSE1))
/*****************************************************************************************************************/

/**************************************************************************************************************/
/*! This configuration sets the baud rate for the SPI data transfers\n
    Baud can be calculated as BAUD = (SCLK0_0/SPI_Clock) - 1\n */
#define ADI_SPI1_CFG_CLK_BAUD                         9ul
/**************************************************************************************************************/

/**************************************************************************************************************/
/*! Master or Slave mode of operation\n
    SPI Control Register: Bit[1]\n
    (0) - Slave mode\n
    (1) - Master mode\n*/
#define ADI_SPI1_CFG_SLAVE_MASTER                     0x0ul

/*! Configures whether the SPI starts toggling the signal for the SPI clock\n
    from the start of the first data bit or from the middle of the first data bit\n
    SPI Control Register: Bit[4]\n
    (0) - Serial clock pulses at the end of each serial bit transfer\n
    (1) - Serial clock pulses at the beginning of each serial bit transfer\n*/
#define ADI_SPI1_CFG_CLK_PHASE                        0x1ul

/*! Configures whether the SPI uses an active-low or active-high signal for the SPI clock\n
    SPI Control Register: Bit[5]\n
    (0) - Active-high SPI Clock\n
    (1) - Active-low  SPI Clock\n*/
#define ADI_SPI1_CFG_CLK_POLARITY                     0x0ul

/*! Configures the SPI to control the assertion/de-assertion of the slave select signal\n
    SPI Control Register: Bit[6]\n
    (0) - Slave select controlled by software\n
    (1) - Slave select controlled by hardware\n*/
#define ADI_SPI1_CFG_HW_SLAVE_SELECT                  0x1ul

/*! SPI transfer size\n
    SPI Control Register: Bit[10:9]\n
    (0)  -  8  bit word\n
    (1)  -  16 bit word\n
    (2)  -  32 bit word\n*/
#define ADI_SPI1_CFG_TRANSFER_SIZE                    0x0ul

/*! SPI transmits/receives LSB or MSB First\n
    SPI Control Register: Bit[12]\n
    (0) - MSB transmitted first\n
    (1) - LSB transmitted first\n*/
#define ADI_SPI1_CFG_MSB_LSB                          0x0ul

/*! Configure SPI MOSI and MISO pins to behave as open drain outputs\n
    to prevent bus contention\n
    SPI Control Register: Bit[3]\n
    (0) -  Disable\n
    (1) -  Enable\n*/
#define ADI_SPI1_CFG_OPEN_DRAIN_MODE                  0x0ul

/*! Configures slave select polarity between transfers\n
    SPI Control Register: Bit[7]\n
    (0) - De-assert slave select (high)\n
    (1) - Assert slave select (low)\n*/
#define ADI_SPI1_CFG_SLAVE_SELECT_POLARITY            0x0ul

/*! Configures the flow control bit to communicate with slow devices\n
    SPI Control Register: Bit[13]\n
    (0) - Disable\n
    (1) - Enable\n*/
#define ADI_SPI1_CFG_FLOW_CONTROL                     0x0ul

/*! Configures the watermark for flow control\n
    SPI Control Register: Bits[17:16]\n
    (0) - TFIFO empty or RFIFO full\n
    (1) - TFIFO 75% or more empty, or RFIFO 75% or more full\n
    (2) - TFIFO 50% or more empty, or RFIFO 50% or more full\n*/
#define ADI_SPI1_CFG_FLOW_CONTROL_WATERMARK           0x0ul

/*! Configure the polarity of the ready pin\n
    SPI Control Register: Bit[15]\n
    (0) - Active low ready\n
    (1) - Active High ready\n*/
#define ADI_SPI1_CFG_FLOW_CONTROL_POLARITY            0x0ul

/*! Configures Flow control for Transmit or Receive channel\n
    SPI Control Register: Bit[14]\n
    (0) - Flow control on Rx channel\n
    (1) - Flow control on Tx channel\n*/
#define ADI_SPI1_CFG_FLOW_CONTROL_CHANNEL             0x0ul

/*! Enable/Disable fast mode\n
    SPI Control Register: Bit[18]\n
    (0) - Disable\n
    (1) - Enable\n*/
#define ADI_SPI1_CFG_FASTMODE                         0x0ul

/*! Configure in Default or Dual I/O or Quad I/O mode\n
    SPI Control Register: Bits[21:20]\n
    (0) - SPI with MOSI and MISO, single I/O mode\n
    (1) - Dual I/O mode\n
    (2) - Quad I/O mode.(Not applicable for SPI0/SPI3)\n*/
#define ADI_SPI1_CFG_MULTIPLE_I0_MODE                 0x0ul
 
/*! configure start on MOSI\n
    SPI Control Register: Bit[22]\n
    (0) - Bit 0 on MOSI (for both DIOM and QIOM)\n
    (1) - Bit 0 on MISO(DIOM) or on D3(QIOM)\n*/
#define ADI_SPI1_CFG_START_ON_MOSI                    0x0ul

/*! Enables error detection in case of multi master\n
    environment when SPI is configured as master\n
    SPI Control Register: Bit[2]\n
    (0) - Disable\n
    (1) - Enable\n*/
#define ADI_SPI1_CFG_PROTECTED_SLV_SELECT_EN          0x0ul

/*! Enable SPI MISO mode. This mode is only applicable for SPI as a slave\n
    SPI Control Register: Bit[8]\n
    (0) - Disable\n
    (1) - Enable\n*/
#define ADI_SPI1_CFG_ENABLE_MISO                      0x0ul

/* Specifies the SPI1 Control register Configuration\n*/
#define ADI_SPI1_CTL                                  ((ADI_SPI1_CFG_SLAVE_MASTER << BITP_SPI_CTL_MSTR)|\
                                                       (ADI_SPI1_CFG_PROTECTED_SLV_SELECT_EN<<BITP_SPI_CTL_PSSE)|\
                                                       (ADI_SPI1_CFG_OPEN_DRAIN_MODE<<BITP_SPI_CTL_ODM)|\
                                                       (ADI_SPI1_CFG_CLK_PHASE<<BITP_SPI_CTL_CPHA)|\
                                                       (ADI_SPI1_CFG_CLK_POLARITY<<BITP_SPI_CTL_CPOL)|\
                                                       (ADI_SPI1_CFG_HW_SLAVE_SELECT<<BITP_SPI_CTL_ASSEL)|\
                                                       (ADI_SPI1_CFG_SLAVE_SELECT_POLARITY<<BITP_SPI_CTL_SELST)|\
                                                       (ADI_SPI1_CFG_ENABLE_MISO<<BITP_SPI_CTL_EMISO)|\
                                                       (ADI_SPI1_CFG_TRANSFER_SIZE<<BITP_SPI_CTL_SIZE)|\
                                                       (ADI_SPI1_CFG_MSB_LSB<<BITP_SPI_CTL_LSBF)|\
                                                       (ADI_SPI1_CFG_FLOW_CONTROL<<BITP_SPI_CTL_FCEN)|\
                                                       (ADI_SPI1_CFG_FLOW_CONTROL_CHANNEL<<BITP_SPI_CTL_FCCH)|\
                                                       (ADI_SPI1_CFG_FLOW_CONTROL_POLARITY<<BITP_SPI_CTL_FCPL)|\
                                                       (ADI_SPI1_CFG_FLOW_CONTROL_WATERMARK<<BITP_SPI_CTL_FCWM)|\
                                                       (ADI_SPI1_CFG_FASTMODE<<BITP_SPI_CTL_FMODE)|\
                                                       (ADI_SPI1_CFG_MULTIPLE_I0_MODE<<BITP_SPI_CTL_MIOM)|\
                                                       (ADI_SPI1_CFG_START_ON_MOSI<<BITP_SPI_CTL_SOSI))
/**************************************************************************************************************/

/**************************************************************************************************************/
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 1\n
    (1) - enables the slave select 1\n*/
#define ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_1            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 2\n
    (1) - enables the slave select 2\n*/
#define ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_2            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 3\n
    (1) - enables the slave select 3\n*/
#define ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_3            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 4\n
    (1) - enables the slave select 4\n*/
#define ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_4            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 5\n
    (1) - enables the slave select 5\n*/
#define ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_5            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 6\n
    (1) - enables the slave select 6\n*/
#define ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_6            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 7\n
    (1) - enables the slave select 7\n*/
#define ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_7            0x0ul

/* Specifies the SPI1 Slave select Control register Configuration\n*/
#define ADI_SPI1_CTL_SLAVE_SELECT_ENABLE              ((ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_7<<BITP_SPI_SLVSEL_SSE7)|\
                                                       (ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_6<<BITP_SPI_SLVSEL_SSE6)|\
                                                       (ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_5<<BITP_SPI_SLVSEL_SSE5)|\
                                                       (ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_4<<BITP_SPI_SLVSEL_SSE4)|\
                                                       (ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_3<<BITP_SPI_SLVSEL_SSE3)|\
                                                       (ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_2<<BITP_SPI_SLVSEL_SSE2)|\
                                                       (ADI_SPI1_CTL_SLAVE_SELECT_ENABLE_1<<BITP_SPI_SLVSEL_SSE1))
/*****************************************************************************************************************/

/**************************************************************************************************************/
/*SPI2 Controller*/
/*! This configuration sets the baud rate for the SPI data transfers.
    Baud can be calculated as BAUD = (SCLK0_0/SPI_Clock) - 1.*/
#define ADI_SPI2_CFG_CLK_BAUD                         10u
/*! Master or Slave mode of operation\n
    SPI Control Register: Bit[1]\n
    ENUM_SPI_CTL_SLAVE - Slave mode.\n
    ENUM_SPI_CTL_MASTER - Master mode.*/
#define ADI_SPI2_CFG_SLAVE_MASTER                     0x1u
/*! Configures whether the SPI starts toggling the signal for the SPI clock\n
    from the start of the first data bit or from the middle of the first data bit\n
    SPI Control Register: Bit[4]\n
    ENUM_SPI_CTL_SCKMID - Serial clock pulses at the end of each serial bit transfer.\n
    ENUM_SPI_CTL_SCKBEG - Serial clock pulses at the beginning of each serial bit transfer.*/
#define ADI_SPI2_CFG_CLK_PHASE                        0x0u
/*! Configures whether the SPI uses an active-low or active-high signal for the SPI clock\n
    SPI Control Register: Bit[5]\n
    ENUM_SPI_CTL_SCKHI - Active-high SPI Clock .\n
    ENUM_SPI_CTL_SCKLO - Active-low  SPI Clock.*/
#define ADI_SPI2_CFG_CLK_POLARITY                     0x0u
/*! Selects the polarity of sf SSEl pin in between SPI transfers \n
    SPI Control Register: Bit[7]\n
    ENUM_SPI_CTL_DEASSRT_SSEL - De-assert slave select. \n
    ENUM_SPI_CTL_ASSRT_SSEL   - Assert slave select.*/
#define ADI_SPI2_CFG_HW_SLAVE_SELECT                  0x0u
/*! SPI transfer size\n
    SPI Control Register: Bit[10:9]\n
    ENUM_SPI_CTL_SIZE08  -  8  bit word.
    ENUM_SPI_CTL_SIZE16  -  16 bit word.
    ENUM_SPI_CTL_SIZE32  -  24 bit word. */
#define ADI_SPI2_CFG_TRANSFER_SIZE                    0x0u
/*! SPI transmits/receives LSB or MSB First\n
    SPI Control Register: Bit[12]\n
    ENUM_SPI_CTL_MSB_FIRST - MSB transmitted first.\n
    ENUM_SPI_CTL_LSB_FIRST - LSB transmitted first. */
#define ADI_SPI2_CFG_MSB_LSB                          0x0u
/*! Configures Flow control for Transmit or Receive channel \n
    SPI Control Register: Bit[14]\n
    ENUM_SPI_CTL_FLOW_RX - Flow control on Rx channel.\n
    ENUM_SPI_CTL_FLOW_TX - Flow control on Tx channel. */
#define ADI_SPI2_CFG_RXFIFO_REG_WATERMARK             0x0u
#define ADI_SPI2_CFG_TXFIFO_REG_WATERMARK             0x0u
/*! SPI Slave select regsiter \n
    This allows a set of slaves to be enabled : Bits[7:1]\n
    ENUM_SPI_SLVSEL_SSELn_EN  - This enables the nth slave
    ENUM_SPI_SLVSEL_SSELn_DIS - This disables the nth slave */
#define ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_1            0x1u
#define ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_2            0x0u
#define ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_3            0x0u
#define ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_4            0x0u
#define ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_5            0x0u
#define ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_6            0x0u
#define ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_7            0x0u
#define ADI_SPI2_CTL_SLAVE_SELECT_ENABLE              ((ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_7<<BITP_SPI_SLVSEL_SSE7)|(ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_6<<BITP_SPI_SLVSEL_SSE6)|(ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_5 <<BITP_SPI_SLVSEL_SSE5)|(ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_4 <<BITP_SPI_SLVSEL_SSE4 )|(ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_3<<BITP_SPI_SLVSEL_SSE3)|(ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_2<<BITP_SPI_SLVSEL_SSE2)|(ADI_SPI2_CTL_SLAVE_SELECT_ENABLE_1<<BITP_SPI_SLVSEL_SSE1))
/*! Configure SPI MOSI and MISO pins to behave as open drain outputs\n
    to prevent bus contention\n
    SPI Control Register: Bit[3]\n
    ENUM_SPI_CTL_ODM_DIS -  Disable.\n
    ENUM_SPI_CTL_ODM_EN -  Enable.*/
#define ADI_SPI2_CFG_OPEN_DRAIN_MODE                  0x0u

/*! Configures the SPI to control the assertion/de-assertion of the slave select signal\n
    SPI Control Register: Bit[6]\n
    ENUM_SPI_CTL_SW_SSEL - Slave select controlled by software.\n
    ENUM_SPI_CTL_HW_SSEL - Slave select controlled by hardware. */
#define ADI_SPI2_CFG_SLAVE_SELECT_POLARITY            0x0u
/*! Configures the flow control bit to communicate with slow devices\n
    SPI Control Register: Bit[13]\n
    ENUM_SPI_CTL_FLOW_DIS - Disable.\n
    ENUM_SPI_CTL_FLOW_EN - Enable. */
#define ADI_SPI2_CFG_FLOW_CONTROL                     0x0u
/*! Configures the watermark for flow control with RFIFO full\n
    SPI Control Register: Bits[17:16]\n
    ENUM_SPI_CTL_FIFO0 - TFIFO empty or RFIFO full. \n
    ENUM_SPI_CTL_FIFO1 - TFIFO 75% or more empty, or RFIFO 75% or more full. \n
    ENUM_SPI_CTL_FIFO2 - TFIFO 50% or more empty, or RFIFO 50% or more full. */
#define ADI_SPI2_CFG_FLOW_CONTROL_WATERMARK           0x0u
/*! Configure the polarity of the ready pin \n
    SPI Control Register: Bit[15]\n
    ENUM_SPI_CTL_FLOW_LO - Active low ready.\n
    ENUM_SPI_CTL_FLOW_HI - Active High ready. */
#define ADI_SPI2_CFG_FLOW_CONTROL_POLARITY            0x0u
/*! Configures Flow control for Transmit or Receive channel \n
    SPI Control Register: Bit[14]\n
    ENUM_SPI_CTL_FLOW_RX - Flow control on Rx channel.\n
    ENUM_SPI_CTL_FLOW_TX - Flow control on Tx channel. */
#define ADI_SPI2_CFG_FLOW_CONTROL_CHANNEL             0x0u
/*! Enable/Disable fast mode \n
    SPI Control Register: Bit[18]\n
    ENUM_SPI_CTL_FAST_DIS - Disable.\n
    ENUM_SPI_CTL_FAST_EN - Enable. */
#define ADI_SPI2_CFG_FASTMODE                         0x0u
/*! Configure in Default or Dual I/O or Quad I/O mode\n
    SPI Control Register: Bits[21:20]\n
    ENUM_SPI_CTL_MIO_DIS  - SPI with MOSI and MISO, single I/O mode .\n
    ENUM_SPI_CTL_MIO_DUAL - Dual I/O mode.\n
    ENUM_SPI_CTL_MIO_QUAD - Dual I/O mode.\n This should only be set for SPI2 mode */
#define ADI_SPI2_CFG_MULTIPLE_I0_MODE                 0x0u
 
/*! configure start on MOSI \n
    SPI Control Register: Bit[22]\n
    ENUM_SPI_CTL_STMOSI - Bit 0 on MOSI (for both DIOM and QIOM).\n
    ENUM_SPI_CTL_STMISO - Bit 0 on MISO(DIOM) or on D3(QIOM). */
#define ADI_SPI2_CFG_START_ON_MOSI                    0x0u
/*! Enables error detection in case of multi master\n
    environment when SPI is configured as master\n
    SPI Control Register: Bit[2]\n
    ENUM_SPI_CTL_PSSE_DIS - Disable.\n
    ENUM_SPI_CTL_PSSE_EN  - Enable.*/
#define ADI_SPI2_CFG_PROTECTED_SLV_SELECT_EN          0x0u
/*! Enable SPI MISO mode. This mode is only applicable for SPI as a slave\n
    SPI Control Register: Bit[8]\n
    ENUM_SPI_CTL_MISO_DIS -  Disable.\n
    ENUM_SPI_CTL_MISO_EN  -  Enable. */
#define ADI_SPI2_CFG_ENABLE_MISO                      0x0u
/*! Memory Mapped SPI Enable \n
    SPI Control Register: Bit[30]\n
    ENUM_SPI_CTL_MM_DIS - Disable hardware automated access of memory mapped SPI.\n
    ENUM_SPI_CTL_MM_EN  - Enable hardware automated access of memory mapped SPI. */
#define ADI_SPI2_CTL_MEMORY_MAPPED_MODE               0x0u
/*! Memory Mapped write error mask \n
    SPI Control Register: Bit[31]\n
    ENUM_SPI_CTL_WEM_UNMSK - Write errors are unmasked upon write attempts in memory mapped mode.\n
    ENUM_SPI_CTL_WEM_MSK   - Write errors are masked upon write attempts in memory mapped mode. */
#define ADI_SPI2_CTL_MEMORY_MAPPED_WRITE_ERROR        0x0u
#define ADI_SPI2_CTL                                  ((ADI_SPI2_CFG_SLAVE_MASTER << BITP_SPI_CTL_MSTR)|(ADI_SPI2_CFG_PROTECTED_SLV_SELECT_EN<<BITP_SPI_CTL_PSSE)|(ADI_SPI2_CFG_OPEN_DRAIN_MODE<<BITP_SPI_CTL_ODM)|(ADI_SPI2_CFG_CLK_PHASE<<BITP_SPI_CTL_CPHA)|(ADI_SPI2_CFG_CLK_POLARITY<<BITP_SPI_CTL_CPOL)|(ADI_SPI2_CFG_HW_SLAVE_SELECT<<BITP_SPI_CTL_ASSEL)|(ADI_SPI2_CFG_SLAVE_SELECT_POLARITY<<BITP_SPI_CTL_SELST)|(ADI_SPI2_CFG_ENABLE_MISO<<BITP_SPI_CTL_EMISO)|(ADI_SPI2_CFG_TRANSFER_SIZE<<BITP_SPI_CTL_SIZE)|(ADI_SPI2_CFG_MSB_LSB<<BITP_SPI_CTL_LSBF)|(ADI_SPI2_CFG_FLOW_CONTROL<<BITP_SPI_CTL_FCEN)|(ADI_SPI2_CFG_FLOW_CONTROL_CHANNEL<<BITP_SPI_CTL_FCCH)|(ADI_SPI2_CFG_FLOW_CONTROL_POLARITY<<BITP_SPI_CTL_FCPL)|(ADI_SPI2_CFG_FLOW_CONTROL_WATERMARK<<BITP_SPI_CTL_FCWM)|(ADI_SPI2_CFG_FASTMODE<<BITP_SPI_CTL_FMODE)|(ADI_SPI2_CFG_MULTIPLE_I0_MODE<<BITP_SPI_CTL_MIOM)|(ADI_SPI2_CFG_START_ON_MOSI<<BITP_SPI_CTL_SOSI)|(ADI_SPI2_CTL_MEMORY_MAPPED_WRITE_ERROR<<BITP_SPI_CTL_MMWEM)|(ADI_SPI2_CTL_MEMORY_MAPPED_MODE<<BITP_SPI_CTL_MMSE))
/*****************************************************************************************************************/

/* start of HPC family macro check */
#if defined(__ADSPSC594__) || defined(__ADSPSC592__) || \
    defined(__ADSPSC594W__) || defined(__ADSPSC592W__)

/**************************************************************************************************************/
/*! This configuration sets the baud rate for the SPI data transfers\n
    Baud can be calculated as BAUD = (SCLK0_0/SPI_Clock) - 1\n */
#define ADI_SPI3_CFG_CLK_BAUD                         9ul
/**************************************************************************************************************/

/**************************************************************************************************************/
/*! Master or Slave mode of operation\n
    SPI Control Register: Bit[1]\n
    (0) - Slave mode\n
    (1) - Master mode\n*/
#define ADI_SPI3_CFG_SLAVE_MASTER                     0x0ul

/*! Configures whether the SPI starts toggling the signal for the SPI clock\n
    from the start of the first data bit or from the middle of the first data bit\n
    SPI Control Register: Bit[4]\n
    (0) - Serial clock pulses at the end of each serial bit transfer\n
    (1) - Serial clock pulses at the beginning of each serial bit transfer\n*/
#define ADI_SPI3_CFG_CLK_PHASE                        0x1ul

/*! Configures whether the SPI uses an active-low or active-high signal for the SPI clock\n
    SPI Control Register: Bit[5]\n
    (0) - Active-high SPI Clock\n
    (1) - Active-low  SPI Clock\n*/
#define ADI_SPI3_CFG_CLK_POLARITY                     0x0ul

/*! Configures the SPI to control the assertion/de-assertion of the slave select signal\n
    SPI Control Register: Bit[6]\n
    (0) - Slave select controlled by software\n
    (1) - Slave select controlled by hardware\n*/
#define ADI_SPI3_CFG_HW_SLAVE_SELECT                  0x1ul

/*! SPI transfer size\n
    SPI Control Register: Bit[10:9]\n
    (0)  -  8  bit word\n
    (1)  -  16 bit word\n
    (2)  -  32 bit word\n*/
#define ADI_SPI3_CFG_TRANSFER_SIZE                    0x0ul

/*! SPI transmits/receives LSB or MSB First\n
    SPI Control Register: Bit[12]\n
    (0) - MSB transmitted first\n
    (1) - LSB transmitted first\n*/
#define ADI_SPI3_CFG_MSB_LSB                          0x0ul

/*! Configure SPI MOSI and MISO pins to behave as open drain outputs\n
    to prevent bus contention\n
    SPI Control Register: Bit[3]\n
    (0) -  Disable\n
    (1) -  Enable\n*/
#define ADI_SPI3_CFG_OPEN_DRAIN_MODE                  0x0ul

/*! Configures slave select polarity between transfers\n
    SPI Control Register: Bit[7]\n
    (0) - De-assert slave select (high)\n
    (1) - Assert slave select (low)\n*/
#define ADI_SPI3_CFG_SLAVE_SELECT_POLARITY            0x0ul

/*! Configures the flow control bit to communicate with slow devices\n
    SPI Control Register: Bit[13]\n
    (0) - Disable\n
    (1) - Enable\n*/
#define ADI_SPI3_CFG_FLOW_CONTROL                     0x0ul

/*! Configures the watermark for flow control\n
    SPI Control Register: Bits[17:16]\n
    (0) - TFIFO empty or RFIFO full\n
    (1) - TFIFO 75% or more empty, or RFIFO 75% or more full\n
    (2) - TFIFO 50% or more empty, or RFIFO 50% or more full\n*/
#define ADI_SPI3_CFG_FLOW_CONTROL_WATERMARK           0x0ul

/*! Configure the polarity of the ready pin\n
    SPI Control Register: Bit[15]\n
    (0) - Active low ready\n
    (1) - Active High ready\n*/
#define ADI_SPI3_CFG_FLOW_CONTROL_POLARITY            0x0ul

/*! Configures Flow control for Transmit or Receive channel\n
    SPI Control Register: Bit[14]\n
    (0) - Flow control on Rx channel\n
    (1) - Flow control on Tx channel\n*/
#define ADI_SPI3_CFG_FLOW_CONTROL_CHANNEL             0x0ul

/*! Enable/Disable fast mode\n
    SPI Control Register: Bit[18]\n
    (0) - Disable\n
    (1) - Enable\n*/
#define ADI_SPI3_CFG_FASTMODE                         0x0ul

/*! Configure in Default or Dual I/O or Quad I/O mode\n
    SPI Control Register: Bits[21:20]\n
    (0) - SPI with MOSI and MISO, single I/O mode\n
    (1) - Dual I/O mode\n
    (2) - Quad I/O mode.(Not applicable for SPI0/SPI3)\n*/
#define ADI_SPI3_CFG_MULTIPLE_I0_MODE                 0x0ul

/*! configure start on MOSI\n
    SPI Control Register: Bit[22]\n
    (0) - Bit 0 on MOSI (for both DIOM and QIOM)\n
    (1) - Bit 0 on MISO(DIOM) or on D3(QIOM)\n*/
#define ADI_SPI3_CFG_START_ON_MOSI                    0x0ul

/*! Enables error detection in case of multi master\n
    environment when SPI is configured as master\n
    SPI Control Register: Bit[2]\n
    (0) - Disable\n
    (1) - Enable\n*/
#define ADI_SPI3_CFG_PROTECTED_SLV_SELECT_EN          0x0ul

/*! Enable SPI MISO mode. This mode is only applicable for SPI as a slave\n
    SPI Control Register: Bit[8]\n
    (0) - Disable\n
    (1) - Enable\n*/
#define ADI_SPI3_CFG_ENABLE_MISO                      0x0ul

/* Specifies the SPI3 Control register Configuration\n*/
#define ADI_SPI3_CTL                                  ((ADI_SPI3_CFG_SLAVE_MASTER << BITP_SPI_CTL_MSTR)|\
                                                       (ADI_SPI3_CFG_PROTECTED_SLV_SELECT_EN<<BITP_SPI_CTL_PSSE)|\
                                                       (ADI_SPI3_CFG_OPEN_DRAIN_MODE<<BITP_SPI_CTL_ODM)|\
                                                       (ADI_SPI3_CFG_CLK_PHASE<<BITP_SPI_CTL_CPHA)|\
                                                       (ADI_SPI3_CFG_CLK_POLARITY<<BITP_SPI_CTL_CPOL)|\
                                                       (ADI_SPI3_CFG_HW_SLAVE_SELECT<<BITP_SPI_CTL_ASSEL)|\
                                                       (ADI_SPI3_CFG_SLAVE_SELECT_POLARITY<<BITP_SPI_CTL_SELST)|\
                                                       (ADI_SPI3_CFG_ENABLE_MISO<<BITP_SPI_CTL_EMISO)|\
                                                       (ADI_SPI3_CFG_TRANSFER_SIZE<<BITP_SPI_CTL_SIZE)|\
                                                       (ADI_SPI3_CFG_MSB_LSB<<BITP_SPI_CTL_LSBF)|\
                                                       (ADI_SPI3_CFG_FLOW_CONTROL<<BITP_SPI_CTL_FCEN)|\
                                                       (ADI_SPI3_CFG_FLOW_CONTROL_CHANNEL<<BITP_SPI_CTL_FCCH)|\
                                                       (ADI_SPI3_CFG_FLOW_CONTROL_POLARITY<<BITP_SPI_CTL_FCPL)|\
                                                       (ADI_SPI3_CFG_FLOW_CONTROL_WATERMARK<<BITP_SPI_CTL_FCWM)|\
                                                       (ADI_SPI3_CFG_FASTMODE<<BITP_SPI_CTL_FMODE)|\
                                                       (ADI_SPI3_CFG_MULTIPLE_I0_MODE<<BITP_SPI_CTL_MIOM)|\
                                                       (ADI_SPI3_CFG_START_ON_MOSI<<BITP_SPI_CTL_SOSI))
/**************************************************************************************************************/

/**************************************************************************************************************/
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 1\n
    (1) - enables the slave select 1\n*/
#define ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_1            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 2\n
    (1) - enables the slave select 2\n*/
#define ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_2            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 3\n
    (1) - enables the slave select 3\n*/
#define ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_3            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 4\n
    (1) - enables the slave select 4\n*/
#define ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_4            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 5\n
    (1) - enables the slave select 5\n*/
#define ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_5            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 6\n
    (1) - enables the slave select 6\n*/
#define ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_6            0x0ul
/*! SPI Slave select regsiter \n
    This allows a slave select to be enabled/disabled\n
    (0) - disables the slave select 7\n
    (1) - enables the slave select 7\n*/
#define ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_7            0x0ul

/* Specifies the SPI3 Slave select Control register Configuration\n*/
#define ADI_SPI3_CTL_SLAVE_SELECT_ENABLE              ((ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_7<<BITP_SPI_SLVSEL_SSE7)|\
                                                       (ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_6<<BITP_SPI_SLVSEL_SSE6)|\
                                                       (ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_5<<BITP_SPI_SLVSEL_SSE5)|\
                                                       (ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_4<<BITP_SPI_SLVSEL_SSE4)|\
                                                       (ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_3<<BITP_SPI_SLVSEL_SSE3)|\
                                                       (ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_2<<BITP_SPI_SLVSEL_SSE2)|\
                                                       (ADI_SPI3_CTL_SLAVE_SELECT_ENABLE_1<<BITP_SPI_SLVSEL_SSE1))
/*****************************************************************************************************************/
#endif /* end of HPC family macro check defined(__ADSPSC594__) || defined(__ADSPSC592__) || \
    defined(__ADSPSC594W__) || defined(__ADSPSC592W__) */
#endif /* __ADI_SPI_CONFIG_SC59x_H__ */

/*@}*/

/*@}*/
