/*********************************************************************************

Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/

/*****************************************************************************
 * CANFD_StandardTsfr_Core1.h
 *****************************************************************************/

#ifndef __CANFD_STANDARDTSFR_CORE1_H__
#define __CANFD_STANDARDTSFR_CORE1_H__

#include <drivers/canfd/adi_canfd.h>
#include <services/dma/adi_dma.h>
#include <stdio.h>
#include <sys/adi_core.h>

/* uncomment this to test with Standard ID */
//#define STANDARDFRAME


ADI_CANFD_RESULT VerifyData(void);
ADI_CANFD_RESULT VerifyData(void);
void InitCanMBData(void);
static void CANFD1_CallBack(void *AppHandle, uint32_t Event, void *pArg);

#endif /* __CANFD_STANDARDTSFR_CORE1_H__ */
