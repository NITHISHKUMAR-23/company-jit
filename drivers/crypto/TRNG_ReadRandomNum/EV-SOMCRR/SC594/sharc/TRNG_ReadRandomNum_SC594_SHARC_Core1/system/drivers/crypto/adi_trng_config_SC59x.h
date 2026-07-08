/******************************************************************************

Copyright (c) 2021 Analog Devices.  All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*******************************************************************************/

/*!
* @file      adi_trng_config_SC59x.h
*
* @brief     TRNG Config header file
*
* @details   This is the configuration file for the TRNG driver, which
*            contains the macro definitions which can be updated based on requirement
*            by the user. This file should be included by the application.
*/

/** @addtogroup TRNG_Driver TRNG Device Driver
 *  @{
 */	

/** @addtogroup TRNG_Drivers_Static_Configuration TRNG Device Driver Static Configuration
 *  @{
 * Static Configuration: Using this configuration application can configure the control register
 * parameters upfront which can be set to default before in the TRNG. Example project can maintain a copy of it locally for custom configuration 
*/


#ifndef __ADI_TRNG_CONFIG_2156X_H__
#define __ADI_TRNG_CONFIG_2156X_H__


/*! This field determines the number of samples (between 28 and 224) taken to gather entropy
 *  from the FROs during startup. If the written value of this field is zero, the number of
 *  samples is 224, otherwise the number of samples equals the written value times 28 */
#ifndef TRNG_STARTUP_CYCLES
#define TRNG_STARTUP_CYCLES 0u
#endif


 /*! This field determines the maximum number of samples (between 2^8 and 2^24) taken to re-generate
 *  entropy from the FROs after reading out a 64-bit random number. If the written value of this
 *  field is zero, the number of samples is 2^24, otherwise the number of samples equals the
 *  written value times 2^8. */
#ifndef TRNG_MAX_REFILL_CYCLES
#define TRNG_MAX_REFILL_CYCLES 0u
#endif



/*! This field determines the minimum number of samples (between 2^6 and 2^24) taken to re-generate
 *  entropy from the FROs after reading out a 64-bit random number. If the value of this field is
 *  zero, the number of samples is fixed to the value determined by the TRNG_MAX_REFILL_CYCLES
 *  parameter, otherwise the minimum number of samples equals the written value times 64
 *  (which can be up to 2^14). The number of samples defined here cannot be higher than the number
 *  defined by the TRNG_MAX_REFILL_CYCLES parameter (i.e. that parameter takes precedence). */
#ifndef TRNG_MIN_REFILL_CYCLES
#define TRNG_MIN_REFILL_CYCLES 0u
#endif


 /*! This field directly controls the number of clock input cycles between samples taken from the
 *  FROs. The default value 0 indicates that samples are taken every "clk" cycle, maximum value
 *  15 (decimal) takes one sample every 16 "clk" cycles. This field must be set to a value such
 *  that the slowest FRO (even under worst-case conditions) has a cycle time less than twice the
 *  sample period. As delivered, the default configuration of the FROs allows this field to remain 0. */
#ifndef TRNG_SAMPLE_DIVIDER
#define TRNG_SAMPLE_DIVIDER 0u
#endif

/*! Alarm detection threshold for the repeating pattern detectors on each FRO. A FRO "alarm event"
 * is declared when a repeating pattern (of up to four samples length) is detected continuously for
 * the number of samples defined by this parameter. Reset value 255 (decimal) should keep the number of
 * "alarm events" to a manageable level. */
#ifndef TRNG_ALARM_THRESHOLD
#define TRNG_ALARM_THRESHOLD 255u
#endif

/*! Threshold setting for generating the "Shutdown over flow" interrupt, which is activated when the
 *  "shutdown_count" value exceeds the threshold value set here. */
#ifndef TRNG_SHUTDOWN_THRESHOLD
#define TRNG_SHUTDOWN_THRESHOLD 7u
#endif

/*! Consider the "shutdown over flow" interrupt as a fatal error requiring taking
 * the complete TRNG engine to the reset state */
#ifndef TRNG_SHUTDOWN_FATAL
#define TRNG_SHUTDOWN_FATAL 0u
#endif

/*! Setting the TRNG_CTL.PPROCEN bit enables the FIPS post-processor. */
#ifndef TRNG_ENABLE_POST_PROCESSOR
#define TRNG_ENABLE_POST_PROCESSOR 0u
#endif


#endif /*__ADI_TRNG_CONFIG_SC59X_H__*/

/** @}*/
/** @}*/

