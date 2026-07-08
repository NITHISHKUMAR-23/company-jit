/*********************************************************************************

Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/

/*****************************************************************************
 * CANFD_HiSpeedTsfr_Core1.h
 *****************************************************************************/

#ifndef __CANFD_HISPEEDTSFR_CORE1_H__
#define __CANFD_HISPEEDTSFR_CORE1_H__

#include <drivers/canfd/adi_canfd.h>
#include <services/dma/adi_dma.h>
#include <stdio.h>
#include <sys/adi_core.h>

/* Define number of time the all packet transfer at high speed is repeated
 * Should be same in core0 and core1*/
#define NUM_ITERATIONS 5

/* uncomment this to test with Standard ID */
//#define STANDARDFRAME


/* uncomment this to test with ISO compliant FD operation */
#define ISOCOMPLIANT_FD


/* Valid values 0-15 */
#define DLC  15

static uint8_t nDlcEncoding[] = {0U, 1U, 2U, 3U, 4U, 5U, 6U, 7U, 8U, 12U, 16U, 20U, 24U, 32U, 48U, 64U};



ADI_CANFD_RESULT VerifyData(void);
ADI_CANFD_RESULT VerifyData(void);
void InitCanMBData(void);
static void CANFD1_CallBack(void *AppHandle, uint32_t Event, void *pArg);
void ClearBuffers(void);

#endif /* __CANFD_HISPEEDTSFR_CORE1_H__ */
