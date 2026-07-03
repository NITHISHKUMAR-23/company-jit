/*
** Copyright (C) 2018-2021 Analog Devices Inc., All Rights Reserved.
**
** This file was originally generated automatically based upon options
** selected in the DMC Initialization configuration dialog.
*/

/*!
* @file      adi_dmc.h
*
* @brief     DMC Configuration header file
*
* @details
*            DMC Configuration header file
*/

#ifndef ADI_DMC_H
#define ADI_DMC_H

#include "config.h"

#if CONFIG_DMC0

#include <sys/platform.h>
#include <stdbool.h>
#if defined(__ADSPSHARC__)
#include <adi_types.h>
#endif
#include "adi_pwr_SC59x_config.h"

#ifdef _MISRA_RULES
#pragma diag(push)
#pragma diag(suppress:misra_rule_5_1:"Identifiers (internal and external) shall not rely on the significance of more than 31 characters")
#endif

/* Additional required DMC macros */

#define BITP_DMC_TR2_TWR            12 /* Timing Write Recovery */

#define BITP_DMC_EMR1_WL            7
#define BITM_DMC_EMR1_WL            (1ul<<BITP_DMC_EMR1_WL)

#define pREG_DMC0_DDR_SCRATCH_2     ((volatile uint32_t*)0x31071074)
#define pREG_DMC0_DDR_SCRATCH_3     ((volatile uint32_t*)0x31071078)
#define pREG_DMC0_DDR_SCRATCH_6     ((volatile uint32_t*)0x31071084)
#define pREG_DMC0_DDR_SCRATCH_7     ((volatile uint32_t*)0x31071088)
#define pREG_DMC0_DDR_SCRATCH_STAT0     ((volatile uint32_t*)0x3107107C)
#define pREG_DMC0_DDR_SCRATCH_STAT1     ((volatile uint32_t*)0x31071080)



typedef enum
{
  ADI_DMC_SUCCESS=0u,
  ADI_DMC_FAILURE
}ADI_DMC_RESULT;

/* structure which holds DMC register values */
typedef struct
{

  uint32_t ulDDR_DLLCTLCFG;               /*!< Content of DDR DLLCTL and DMC_CFG register     */
  uint32_t ulDDR_EMR2EMR3;                /*!< Content of the DDR EMR2 and EMR3 Register      */
  uint32_t ulDDR_CTL;                     /*!< Content of the DDR Control                   */
  uint32_t ulDDR_MREMR1;                  /*!< Content of the DDR MR and EMR1 Register      */
  uint32_t ulDDR_TR0;                     /*!< Content of the DDR Timing Register      */
  uint32_t ulDDR_TR1;                     /*!< Content of the DDR Timing Register      */
  uint32_t ulDDR_TR2;                     /*!< Content of the DDR Timing Register      */
  uint32_t ulDDR_ZQCTL0;                  /*!< Content of ZQCTL0 register */
  uint32_t ulDDR_ZQCTL1;                  /*!< Content of ZQCTL1 register */
  uint32_t ulDDR_ZQCTL2;                  /*!< Content of ZQCTL2 register */

}ADI_DMC_CONFIG;

/* delay function */
#if defined __ADSPARM__
static __inline__ void dmcdelay(uint32_t delay)
{
  /* There is no zero-overhead loop on ARM, so assume each iteration takes
   * 4 processor cycles (based on examination of -O3 and -Ofast output).
   */
  uint32_t i, remainder;

  /* Convert DDR cycles to core clock cycles */
  float f = (float)delay * cclkdclk_ratio;
  delay = (uint32_t)(f+0.5);

  /* Round up to multiple of 4 */
  remainder = delay % 4;
  if (remainder != 0u) {
    delay += (4u - remainder);
  }

  for(i=0; i<delay; i+=4) {
    __asm__("NOP");
  }
}
#elif defined __ADSPSHARC__
#pragma inline
static void dmcdelay(uint32_t delay)
{
  uint32_t i;

  /* Convert DDR cycles to core clock cycles */
  float32_t f = (float32_t)delay * cclk_dclk_r();
  delay = (uint32_t)f;

  for(i=delay; i>0ul; i--){
    NOP();
  }
}

#endif

#ifdef __cplusplus
extern "C" {
#endif

/* reset dmc lanes */
void adi_dmc_lane_reset(bool reset);
/* enter/exit self refresh mode */
void adi_dmc_self_refresh(bool enter);
/* program dmc controller timing registers */
ADI_DMC_RESULT adi_dmc_ctrl_init(ADI_DMC_CONFIG *pConfig);
/* trigger Zq calibration*/
void adi_dmc_phy_calibration(ADI_DMC_CONFIG *pConfig);

#ifdef __cplusplus
}
#endif

#ifdef _MISRA_RULES
#pragma diag(pop)
#endif

#endif /* CONFIG_DMC0 */

#endif /* ADI_DMC_H */
