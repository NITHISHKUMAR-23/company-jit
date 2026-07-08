/*********************************************************************************

Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

 *********************************************************************************/

/*****************************************************************************
 * CANFD_HiSpeedTsfr_Core0.h
 *****************************************************************************/

#ifndef __CANFD_HISPEEDTSFR_CORE0_H__
#define __CANFD_HISPEEDTSFR_CORE0_H__

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
#define DLC 15

void InitCanMBData(void);
void Init_pinmux(void);
static void CANFD0_CallBack(void *AppHandle, uint32_t Event, void *pArg);
void Delay(int delay);

void adi_pwr_cfg0_init();

#if defined(__ADSPSC598W__)
void ConfigSoftSwitches_SC598_SOM(void);
#endif
void ConfigSoftSwitches_EVAL_EZKIT_SOM(void);


#endif /* __CANFD_HISPEEDTSFR_CORE0_H__ */
