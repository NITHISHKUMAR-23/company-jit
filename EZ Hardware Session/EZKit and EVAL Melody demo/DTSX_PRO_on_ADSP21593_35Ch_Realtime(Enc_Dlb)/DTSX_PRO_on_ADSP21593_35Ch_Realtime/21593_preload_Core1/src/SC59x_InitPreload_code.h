/******************************************************************************

Copyright(c) 2020-2021 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

*******************************************************************************/

/*****************************************************************************
 * SC59x_InitPreload_code.h
 *****************************************************************************/

#ifndef ADSPSC59X_INITPRELOAD_CODE_H
#define ADSPSC59X_INITPRELOAD_CODE_H

/*!
* @file      SC59x_InitPreload_code.h
*
* @brief     Global header file for SC59x_InitPreload_code.c
*
* @details
*
*/

#include <stdlib.h>
#include <services/pwr/adi_pwr.h>
#include <sys/platform.h>
#include "adi_initialize.h"

#include "adi_clockrates_SC59x_config.h"
#include "adi_dmc_SC59x_config.h"
#include "adi_pwr_SC59x_config.h"
#include "adi_smpu_SC59x_config.h"
#include "adi_canfd_init.h"

#include "config.h"

#ifdef __cplusplus
extern "C" {
#endif

#if defined __ADSPSHARC__
#pragma retain_name /* retain resolved initcode entry */
#endif
uint32_t initcode(ADI_ROM_BOOT_CONFIG* pBootStruct);

#ifdef __cplusplus
}
#endif

#endif /* ADSPSC59X_INITPRELOAD_CODE_H */
