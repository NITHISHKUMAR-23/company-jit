/*********************************************************************************

Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/
/*!
* @file      adi_pwr_SC59x_config.h
*
* @brief     Header file for Power Service Configuration.
*
* @details
*
*/

#ifndef INC_ADI_PWR_SC59X_CONFIG_H_
#define INC_ADI_PWR_SC59X_CONFIG_H_

#include <adi_types.h>

#ifdef __cplusplus
extern "C" {
#endif

uint32_t adi_pwr_cfg0_init(void) ;

/* The ratio between the core clock and the DDR clock. Used for delay cycles. */
#define cclkdclk_ratio (1.25f)
float32_t cclk_dclk_r(void);

#ifdef __cplusplus
}
#endif

#endif /* INC_ADI_PWR_SC59X_CONFIG_H_ */
