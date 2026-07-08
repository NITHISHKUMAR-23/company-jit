/*
 ** Copyright (C) 2022 Analog Devices Inc., All Rights Reserved.
 **
 ** This file was originally generated based upon the options selected in
 ** the Basic Configuration of CGU Initialization configuration dialog.
 ** Subsequently it has been manually edited.
 */
/** @addtogroup Init_Preload_SC59x Processor Initialization Code
 *  @{
 *
 */

/*!
* @file      adi_pwr_SC59x_config.c
*
* @brief     power Service configuration file
*
* @details
*            power Service configuration file
*/

#include <sys/platform.h>
#include <stdint.h>
#include <stdlib.h>
#include <services/pwr/adi_pwr.h>

#define FREQ_80MHZ

uint32_t adi_pwr_cfg0_init(void);


/**********************************************************************************************
 *                     CGU Configuration Number 0
 **********************************************************************************************/
/*
Configuration Number    : 0
SDRAM Mode              : DDR3
SYS_CLKIN0 (MHz)        : 25
Use CGU1 ?              : Yes

CDU Initialization Options
--------------------------
SHARC0 & its Accelerators  (CLKO0) : CCLK0_0      : 1000 MHz
SHARC1 & its Accelerators  (CLKO1) : CCLK0_0      : 1000 MHz
ARM                        (CLKO2) : CCLK1_0      : 1000 MHz
DDR                        (CLKO3) : DCLK_1       :  800 MHz
CANFD                      (CLKO4) : OCLK_1       :  100 MHz
SPDIF                      (CLKO5) : SCLK1_EXEN_0 :  333.3 MHz
SPI                        (CLKO6) : SCLK0_0      :  125 MHz
GigE                       (CLKO7) : SCLK0_0      :  125 MHz
LP                         (CLKO8) : SCLK0_0      :  125 MHz
LP_DDR                     (CLKO9) : OCLK_0       :  250 MHz
OSPI_REFCLK                (CLKO10): SYSCLK_0     :  500 MHz
TRACE                      (CLKO12): SCLK0_0      :  125 MHz

CGU0 Initialization Options
---------------------------
fPLL                   :   2000.0 MHz
CCLK                   :   1000.0 MHz
SYSCLK                 :   500.0  MHz
SCLK0                  :   125.0 MHz
SCLK1                  :   250.0 MHz
SCLK1_EXEN             :   333.33 MHz
DCLK                   :   1000.0 MHz
OCLK                   :   250.0 MHz

MSEL                   :   80
Use DF?                :   No
DF                     :   0
CSEL                   :   2
CCLK to SYSCLK Ratio   :   2:1
SYSCLK to SCLK0 Ratio  :   4:1
S0SEL                  :   4
S1SEL                  :   2
DSEL                   :   2
OSEL                   :   8
Use S1SELEX?           :   Yes
S1SELEX                :   6

CGU1 Initialization Options
---------------------------
fPLL                   :   1600 MHz
CCLK                   :   800.0 MHz
SYSCLK                 :   400.0  MHz
SCLK0                  :   100.0 MHz
SCLK1                  :   200.0 MHz
SCLK1_EXEN             :   100.0 MHz
DCLK                   :   800.0 MHz
OCLK                   :   100.0 MHz

MSEL                   :   64
Use DF?                :   No
DF                     :   0
CSEL                   :   2
CCLK to SYSCLK Ratio   :   2:1
SYSCLK to SCLK0 Ratio  :   4:1
S0SEL                  :   4
S1SEL                  :   2
DSEL                   :   2
OSEL                   :   16
Use S1SELEX?           :   No
S1SELEX                :   8
*/
/**********************************************************************************************
 *                      CGU Configuration Number 0
 **********************************************************************************************/

#define CFG0_BIT_CGU0_CLKIN                                25000000 /*!< Macro for SYS_CLKIN */
#define CFG0_BIT_CGU1_CLKIN                                25000000 /*!< Macro for SYS_CLKIN */

/*****************************************CGU1_CLKINSELV**********************************************/
#define CFG0_BIT_CDU0_CLKINSEL                             (ADI_PWR_CDU_CLK_SELECT_CLKIN0) /*!< Macro for CDU CFG0 Selection */

/* CLKO0 : SHARC 0 and its accelerators : CCLK0_0 */
#define CFG0_BIT_CDU0_CFG0_SEL_VALUE                       (ENUM_CDU_CFG_IN0)        /*!< Macro for CDU CFG0 Selection */

/* CLKO1 : SHARC 1 and its accelerators : CCLK0_0 */
#define CFG0_BIT_CDU0_CFG1_SEL_VALUE                       (ENUM_CDU_CFG_IN0)        /*!< Macro for CDU CFG0 Selection */

/* CLKO2 : ARM : CCLK1_0 */
#define CFG0_BIT_CDU0_CFG2_SEL_VALUE                       (ENUM_CDU_CFG_IN0)        /*!< Macro for CDU CFG0 Selection */

/* CLKO3 : DDR CLOCK : DCLK_0 DCLK_1 */
#define CFG0_BIT_CDU0_CFG3_SEL_VALUE                       (ENUM_CDU_CFG_IN1)        /*!< Macro for CDU CFG0 Selection */

/* CLKO4 : CAN : OCLK_0 OCLK_1 */
#define CFG0_BIT_CDU0_CFG4_SEL_VALUE                       (ENUM_CDU_CFG_IN1)        /*!< Macro for CDU CFG0 Selection */

/* CLKO5 : SPDIF : SCLK1_0 */
#define CFG0_BIT_CDU0_CFG5_SEL_VALUE                       (ENUM_CDU_CFG_IN0)        /*!< Macro for CDU CFG0 Selection */

/* CLKO6 : SPI : SCLK0_0 OCLK_0 */
#define CFG0_BIT_CDU0_CFG6_SEL_VALUE                       (ENUM_CDU_CFG_IN0)        /*!< Macro for CDU CFG0 Selection */

/* CLKO7 : GigE : SCLK0_0 SCLK0_1 */
#define CFG0_BIT_CDU0_CFG7_SEL_VALUE                       (ENUM_CDU_CFG_IN0)        /*!< Macro for CDU CFG0 Selection */

/* CLKO8 : LP  : OCLK_0 SCLK0_0 CCLK0_1 */
#define CFG0_BIT_CDU0_CFG8_SEL_VALUE                       (ENUM_CDU_CFG_IN1)        /*!< Macro for CDU CFG0 Selection */

/* CLKO9 : LP_DDR : OCLK_0 DCLK0_0 SYSCLKO_1 */
#define CFG0_BIT_CDU0_CFG9_SEL_VALUE                       (ENUM_CDU_CFG_IN0)        /*!< Macro for CDU CFG0 Selection */

/* CLKO10 : OSPI_REFCLK : SYSCLK0_0 SCLK0_0 SCLK1_1 */
#define CFG0_BIT_CDU0_CFG10_SEL_VALUE                      (ENUM_CDU_CFG_IN1)        /*!< Macro for CDU CFG0 Selection */

/* CLKO12 : TRACE : SCLK0_0 SCLK1_1  */
#define CFG0_BIT_CDU0_CFG12_SEL_VALUE                      (ENUM_CDU_CFG_IN0)        /*!< Macro for CDU CFG0 Selection */

/**********************************************************************************************
 *                     CGU Configuration Number 0 Register Values
 **********************************************************************************************/
/*****************************************CGU0_CTL**********************************************/
#define CFG0_BIT_CGU0_CTL_DF                               0        /*!< Macro for CGU0 DF bit */
#ifdef FREQ_80MHZ
#define CFG0_BIT_CGU0_CTL_MSEL                             96       /*!< Macro for CGU0 MSEL field */
#else
#define CFG0_BIT_CGU0_CTL_MSEL                             80       /*!< Macro for CGU0 MSEL field */
#endif
/*****************************************CGU0_DIV**********************************************/
#ifdef FREQ_80MHZ
#define CFG0_BIT_CGU0_DIV_CSEL                             3       /*!< Macro for CGU0 CSEL field */
#else
#define CFG0_BIT_CGU0_DIV_CSEL                             2        /*!< Macro for CGU0 CSEL field */
#endif

#ifdef FREQ_80MHZ
#define CFG0_BIT_CGU0_DIV_SYSSEL                           6        /*!< Macro for CGU0 SYSSEL field */
#else
#define CFG0_BIT_CGU0_DIV_SYSSEL                           4        /*!< Macro for CGU0 SYSSEL field */
#endif

#ifdef FREQ_80MHZ
#define CFG0_BIT_CGU0_DIV_S0SEL                            5        /*!< Macro for CGU0 S0SEL field */
#else
#define CFG0_BIT_CGU0_DIV_S0SEL                            4        /*!< Macro for CGU0 S0SEL field */
#endif
#define CFG0_BIT_CGU0_DIV_S1SEL                            2        /*!< Macro for CGU0 S1SEL field */
#define CFG0_BIT_CGU0_DIV_DSEL                             2        /*!< Macro for CGU0 DSEL field */
#define CFG0_BIT_CGU0_DIV_OSEL                             8       /*!< Macro for CGU0 OSEL field */
/*****************************************CGU0_DIVEX**********************************************/
#define CFG0_BIT_CGU0_DIV_S1SELEX                          6        /*!< Macro for CGU0 S1SELEX field */

/*****************************************CGU1_CTL**********************************************/
#define CFG0_BIT_CGU1_CTL_DF                               0        /*!< Macro for CGU1 DF bit */
#define CFG0_BIT_CGU1_CTL_MSEL                             64       /*!< Macro for CGU1 MSEL field */
/*****************************************CGU1_DIV**********************************************/
#define CFG0_BIT_CGU1_DIV_CSEL                             2        /*!< Macro for CGU1 CSEL field */
#define CFG0_BIT_CGU1_DIV_SYSSEL                           4        /*!< Macro for CGU1 SYSSEL field */
#define CFG0_BIT_CGU1_DIV_S0SEL                            4        /*!< Macro for CGU1 S0SEL field */
#define CFG0_BIT_CGU1_DIV_S1SEL                            2        /*!< Macro for CGU1 S1SEL field */
#define CFG0_BIT_CGU1_DIV_DSEL                             2        /*!< Macro for CGU1 DSEL field */
#define CFG0_BIT_CGU1_DIV_OSEL                             16       /*!< Macro for CGU1 OSEL field */
/*****************************************CGU1_DIVEX**********************************************/
#define CFG0_BIT_CGU1_DIV_S1SELEX                          8        /*!< Macro for CGU1 S1SELEX field */

/**
 * @brief    Initializes clocks, including CGU and CDU modules.
 *
 * @return   Status
 *           - 0: Successful in all the initializations.
 *           - 1: Error.

 */
uint32_t adi_pwr_cfg0_init(void)
{
    uint32_t status = 0u; /*Return zero if there are no errors*/

    /* Structure pointer for CGU0 and CGU1 parameters*/
    ADI_PWR_CGU_PARAM_LIST pADI_CGU_Param_List;

    /* Structure pointer for CDU parameters*/
    ADI_PWR_CDU_PARAM_LIST pADI_CDU_Param_List;

    /* CDU Configuration*/
    pADI_CDU_Param_List.cdu_settings[0].cfg_SEL                     =       (ADI_PWR_CDU_CLKIN)CFG0_BIT_CDU0_CFG0_SEL_VALUE;
    pADI_CDU_Param_List.cdu_settings[0].cfg_EN                      =       true;

    pADI_CDU_Param_List.cdu_settings[1].cfg_SEL                     =       (ADI_PWR_CDU_CLKIN)CFG0_BIT_CDU0_CFG1_SEL_VALUE;
    pADI_CDU_Param_List.cdu_settings[1].cfg_EN                      =       true;

    pADI_CDU_Param_List.cdu_settings[2].cfg_SEL                     =       (ADI_PWR_CDU_CLKIN)CFG0_BIT_CDU0_CFG2_SEL_VALUE;
    pADI_CDU_Param_List.cdu_settings[2].cfg_EN                      =       true;

    pADI_CDU_Param_List.cdu_settings[3].cfg_SEL                     =       (ADI_PWR_CDU_CLKIN)CFG0_BIT_CDU0_CFG3_SEL_VALUE;
    pADI_CDU_Param_List.cdu_settings[3].cfg_EN                      =       true;

    pADI_CDU_Param_List.cdu_settings[4].cfg_SEL                     =       (ADI_PWR_CDU_CLKIN)CFG0_BIT_CDU0_CFG4_SEL_VALUE;
    pADI_CDU_Param_List.cdu_settings[4].cfg_EN                      =       true;

    pADI_CDU_Param_List.cdu_settings[5].cfg_SEL                     =       (ADI_PWR_CDU_CLKIN)CFG0_BIT_CDU0_CFG5_SEL_VALUE;
    pADI_CDU_Param_List.cdu_settings[5].cfg_EN                      =       true;

    pADI_CDU_Param_List.cdu_settings[6].cfg_SEL                     =       (ADI_PWR_CDU_CLKIN)CFG0_BIT_CDU0_CFG6_SEL_VALUE;
    pADI_CDU_Param_List.cdu_settings[6].cfg_EN                      =       true;

    pADI_CDU_Param_List.cdu_settings[7].cfg_SEL                     =       (ADI_PWR_CDU_CLKIN)CFG0_BIT_CDU0_CFG7_SEL_VALUE;
    pADI_CDU_Param_List.cdu_settings[7].cfg_EN                      =       true;

    pADI_CDU_Param_List.cdu_settings[8].cfg_SEL                     =       (ADI_PWR_CDU_CLKIN)CFG0_BIT_CDU0_CFG8_SEL_VALUE;
    pADI_CDU_Param_List.cdu_settings[8].cfg_EN                      =       true;

    pADI_CDU_Param_List.cdu_settings[9].cfg_SEL                     =       (ADI_PWR_CDU_CLKIN)CFG0_BIT_CDU0_CFG9_SEL_VALUE;
    pADI_CDU_Param_List.cdu_settings[9].cfg_EN                      =       true;

    pADI_CDU_Param_List.cdu_settings[10].cfg_SEL                    =       (ADI_PWR_CDU_CLKIN)CFG0_BIT_CDU0_CFG10_SEL_VALUE;
    pADI_CDU_Param_List.cdu_settings[10].cfg_EN                     =       true;


    pADI_CDU_Param_List.cdu_settings[12].cfg_SEL                    =       (ADI_PWR_CDU_CLKIN)CFG0_BIT_CDU0_CFG12_SEL_VALUE;
    pADI_CDU_Param_List.cdu_settings[12].cfg_EN                     =       true;


    /* CGU0 Configuration*/
    pADI_CGU_Param_List.cgu0_settings.clocksettings.ctl_MSEL        =       (uint32_t)CFG0_BIT_CGU0_CTL_MSEL;
    pADI_CGU_Param_List.cgu0_settings.clocksettings.ctl_DF          =       (uint32_t)CFG0_BIT_CGU0_CTL_DF;
    pADI_CGU_Param_List.cgu0_settings.clocksettings.div_CSEL        =       (uint32_t)CFG0_BIT_CGU0_DIV_CSEL;
    pADI_CGU_Param_List.cgu0_settings.clocksettings.div_SYSSEL      =       (uint32_t)CFG0_BIT_CGU0_DIV_SYSSEL;
    pADI_CGU_Param_List.cgu0_settings.clocksettings.div_S0SEL       =       (uint32_t)CFG0_BIT_CGU0_DIV_S0SEL;
    pADI_CGU_Param_List.cgu0_settings.clocksettings.div_S1SEL       =       (uint32_t)CFG0_BIT_CGU0_DIV_S1SEL;
    pADI_CGU_Param_List.cgu0_settings.clocksettings.divex_S1SELEX   =       (uint32_t)CFG0_BIT_CGU0_DIV_S1SELEX;
    pADI_CGU_Param_List.cgu0_settings.clocksettings.div_DSEL        =       (uint32_t)CFG0_BIT_CGU0_DIV_DSEL;
    pADI_CGU_Param_List.cgu0_settings.clocksettings.div_OSEL        =       (uint32_t)CFG0_BIT_CGU0_DIV_OSEL;
    pADI_CGU_Param_List.cgu0_settings.clkin                         =       (uint32_t)CFG0_BIT_CGU0_CLKIN;
    pADI_CGU_Param_List.cgu0_settings.enable_IDLE                   =       false;
    pADI_CGU_Param_List.cgu0_settings.enable_SCLK1ExDiv             =       true;

    /* CGU1 Configuration*/
    pADI_CGU_Param_List.cgu1_settings.clocksettings.ctl_MSEL        =       (uint32_t)CFG0_BIT_CGU1_CTL_MSEL;
    pADI_CGU_Param_List.cgu1_settings.clocksettings.ctl_DF          =       (uint32_t)CFG0_BIT_CGU1_CTL_DF;
    pADI_CGU_Param_List.cgu1_settings.clocksettings.div_CSEL        =       (uint32_t)CFG0_BIT_CGU1_DIV_CSEL;
    pADI_CGU_Param_List.cgu1_settings.clocksettings.div_SYSSEL      =       (uint32_t)CFG0_BIT_CGU1_DIV_SYSSEL;
    pADI_CGU_Param_List.cgu1_settings.clocksettings.div_S0SEL       =       (uint32_t)CFG0_BIT_CGU1_DIV_S0SEL;
    pADI_CGU_Param_List.cgu1_settings.clocksettings.div_S1SEL       =       (uint32_t)CFG0_BIT_CGU1_DIV_S1SEL;
    pADI_CGU_Param_List.cgu1_settings.clocksettings.divex_S1SELEX   =       (uint32_t)CFG0_BIT_CGU1_DIV_S1SELEX;
    pADI_CGU_Param_List.cgu1_settings.clocksettings.div_DSEL        =       (uint32_t)CFG0_BIT_CGU1_DIV_DSEL;
    pADI_CGU_Param_List.cgu1_settings.clocksettings.div_OSEL        =       (uint32_t)CFG0_BIT_CGU1_DIV_OSEL;
    pADI_CGU_Param_List.cgu1_settings.clkin                         =       (uint32_t)CFG0_BIT_CGU1_CLKIN;
    pADI_CGU_Param_List.cgu1_settings.enable_IDLE                   =       false;
    pADI_CGU_Param_List.cgu1_settings.enable_SCLK1ExDiv             =       false;
    pADI_CGU_Param_List.cgu1_settings.cgu1_clkinsel                 =       (ADI_PWR_CDU_CLK_SELECT)ADI_PWR_CDU_CLK_SELECT_CLKIN0;

    /* Initialize all the clocks*/
    if(adi_pwr_ClockInit(&pADI_CGU_Param_List, &pADI_CDU_Param_List) != ADI_PWR_SUCCESS)
    {
       /* Return non-zero */
       status = 1u;
    }


    return status;
}


/*@}*/
