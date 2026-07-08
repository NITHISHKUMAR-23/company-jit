/*********************************************************************************

Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

*********************************************************************************/
/*!
 *  @addtogroup SPDIF_TX_Driver Transmit S/PDIF Driver
 *  @{
 */

/*!
 * @addtogroup SPDIF_TX_Driver_Static_Configuration Transmit S/PDIF Driver Static Configuration
 * @{
  Static Configuration provides an easy and convient way for application to configure the device during driver's open
  call. When an application provides custom static configuration file, then according to the setting provided driver initialises
  the device during driver's open call. If application fails to provide any custom configuration file, then by default S/PDIF TX device
  driver does not perform any static configuration.
 */

/*!
 * @file     adi_spdif_tx_config_SC59x.h
 *
 * @brief    Transmit S/PDIF static configuration file
 *
 * @version  $Revision: 37632 $
 *
 * @date     $Date: 2019-10-09 12:35:37 +0530 (Wed, 09 Oct 2019) $
 *
 * @details
 *           This is the static configuration file for the transmit S/PDIF Driver.
 */



#ifndef __ADI_SPDIF_TX_CONGIF_SC59X_H__
#define __ADI_SPDIF_TX_CONGIF_SC59X_H__


#define SPDIF0_TX_FREQ               0u

#define SPDIF0_TX_SCDF               0u

#define SPDIF0_TX_SCDFLR             0u

#define SPDIF0_TX_SMODEIN            1u

#define SPDIF0_TX_AUTO               1u

#define SPDIF0_TX_VALIDL             1u

#define SPDIF0_TX_VALIDR             1u

#define SPDIF0_EXTSYNC				 0u


#define SPDIF0_TXCTL_STAT0A          0u

#define SPDIF0_TXCTL_STAT0B          0u


#define ADI_SPDIF0_TX_STATA0             0u

#define ADI_SPDIF0_TX_STATA1             0u

#define ADI_SPDIF0_TX_STATA2             0u

#define ADI_SPDIF0_TX_STATA3             0u

#define ADI_SPDIF0_TX_STATA4             0u

#define ADI_SPDIF0_TX_STATA5             0u


#define ADI_SPDIF0_TX_STATB0             0u

#define ADI_SPDIF0_TX_STATB1             0u

#define ADI_SPDIF0_TX_STATB2             0u

#define ADI_SPDIF0_TX_STATB3             0u

#define ADI_SPDIF0_TX_STATB4             0u

#define ADI_SPDIF0_TX_STATB5             0u



#define ADI_SPDIF0_TX_UBUFFA0             0u

#define ADI_SPDIF0_TX_UBUFFA1             0u

#define ADI_SPDIF0_TX_UBUFFA2             0u

#define ADI_SPDIF0_TX_UBUFFA3             0u

#define ADI_SPDIF0_TX_UBUFFA4             0u

#define ADI_SPDIF0_TX_UBUFFA5             0u


#define ADI_SPDIF0_TX_UBUFFB0             0u

#define ADI_SPDIF0_TX_UBUFFB1             0u

#define ADI_SPDIF0_TX_UBUFFB2             0u

#define ADI_SPDIF0_TX_UBUFFB3             0u

#define ADI_SPDIF0_TX_UBUFFB4             0u

#define ADI_SPDIF0_TX_UBUFFB5             0u



#define SPDIF1_TX_GUI_CONFIG         0u

#define SPDIF1_TX_FREQ               0u

#define SPDIF1_TX_SCDF               0u

#define SPDIF1_TX_SCDFLR             0u

#define SPDIF1_TX_SMODEIN            0u

#define SPDIF1_TX_AUTO               0u

#define SPDIF1_TX_VALIDL             0u

#define SPDIF1_TX_VALIDR             0u

#define SPDIF1_EXTSYNC				 0u


#define SPDIF1_TXCTL_STATA0          0u

#define SPDIF1_TXCTL_STATB0          0u


#define ADI_SPDIF1_TX_STATA0             0u

#define ADI_SPDIF1_TX_STATA1             0u

#define ADI_SPDIF1_TX_STATA2             0u

#define ADI_SPDIF1_TX_STATA3             0u

#define ADI_SPDIF1_TX_STATA4             0u

#define ADI_SPDIF1_TX_STATA5             0u


#define ADI_SPDIF1_TX_STATB0             0u

#define ADI_SPDIF1_TX_STATB1             0u

#define ADI_SPDIF1_TX_STATB2             0u

#define ADI_SPDIF1_TX_STATB3             0u

#define ADI_SPDIF1_TX_STATB4             0u

#define ADI_SPDIF1_TX_STATB5             0u



#define ADI_SPDIF1_TX_UBUFFA0             0u

#define ADI_SPDIF1_TX_UBUFFA1             0u

#define ADI_SPDIF1_TX_UBUFFA2             0u

#define ADI_SPDIF1_TX_UBUFFA3             0u

#define ADI_SPDIF1_TX_UBUFFA4             0u

#define ADI_SPDIF1_TX_UBUFFA5             0u


#define ADI_SPDIF1_TX_UBUFFB0             0u

#define ADI_SPDIF1_TX_UBUFFB1             0u

#define ADI_SPDIF1_TX_UBUFFB2             0u

#define ADI_SPDIF1_TX_UBUFFB3             0u

#define ADI_SPDIF1_TX_UBUFFB4             0u

#define ADI_SPDIF1_TX_UBUFFB5             0u






#define ADI_SPDIF0_TX_FREQ               (SPDIF0_TX_FREQ<<BITP_SPDIF_TX_CTL_FREQ)

#define ADI_SPDIF0_TX_SCDF               (SPDIF0_TX_SCDF<<BITP_SPDIF_TX_CTL_SCDF)

#define ADI_SPDIF0_TX_SCDFLR             (SPDIF0_TX_SCDFLR<<BITP_SPDIF_TX_CTL_SCDFLR)

#define ADI_SPDIF0_TX_SMODEIN            (SPDIF0_TX_SMODEIN<<BITP_SPDIF_TX_CTL_SMODEIN)

#define ADI_SPDIF0_TX_AUTO               (SPDIF0_TX_AUTO<<BITP_SPDIF_TX_CTL_AUTO)

#define ADI_SPDIF0_TX_VALIDL             (SPDIF0_TX_VALIDL<<BITP_SPDIF_TX_CTL_VALIDL)

#define ADI_SPDIF0_TX_VALIDR             (SPDIF0_TX_VALIDR<<BITP_SPDIF_TX_CTL_VALIDR)

#define ADI_SPDIF0_EXTSYNC				 (SPDIF0_EXTSYNC<<BITP_SPDIF_TX_CTL_EXTSYNC)


#define ADI_SPDIF1_TX_FREQ               (SPDIF1_TX_FREQ<<BITP_SPDIF_TX_CTL_FREQ)

#define ADI_SPDIF1_TX_SCDF               (SPDIF1_TX_SCDF<<BITP_SPDIF_TX_CTL_SCDF)

#define ADI_SPDIF1_TX_SCDFLR             (SPDIF1_TX_SCDFLRu<<BITP_SPDIF_TX_CTL_SCDFLR)

#define ADI_SPDIF1_TX_SMODEIN            (SPDIF1_TX_SMODEIN<<BITP_SPDIF_TX_CTL_SMODEIN)

#define ADI_SPDIF1_TX_AUTO               (SPDIF1_TX_AUTO<<BITP_SPDIF_TX_CTL_AUTO)

#define ADI_SPDIF1_TX_VALIDL             (SPDIF1_TX_VALIDL<<BITP_SPDIF_TX_CTL_VALIDL)

#define ADI_SPDIF1_TX_VALIDR             (SPDIF1_TX_VALIDR<<BITP_SPDIF_TX_CTL_VALIDR)

#define ADI_SPDIF1_EXTSYNC				 (SPDIF0_EXTSYNC<<BITP_SPDIF_TX_CTL_EXTSYNC)


#define USE_STATIC_SPDIF0_TX 1u
#define USE_STATIC_SPDIF1_TX 0u





#define ADI_SPDIF0_TX_CTL (SPDIF0_TXCTL_STAT0A<<BITP_SPDIF_TX_CTL_BYTE0A| SPDIF0_TXCTL_STAT0B<<BITP_SPDIF_TX_CTL_BYTE0B|ADI_SPDIF0_TX_FREQ|ADI_SPDIF0_TX_SCDF|ADI_SPDIF0_TX_SCDFLR|ADI_SPDIF0_TX_SMODEIN|ADI_SPDIF0_TX_AUTO|ADI_SPDIF0_TX_VALIDL|ADI_SPDIF0_TX_VALIDR|ADI_SPDIF0_EXTSYNC)



#define ADI_SPDIF1_TX_CTL (SPDIF1_TXCTL_STAT0A<<BITP_SPDIF_TX_CTL_BYTE0A| SPDIF1_TXCTL_STAT0B<<BITP_SPDIF_TX_CTL_BYTE0B|ADI_SPDIF1_TX_FREQ|ADI_SPDIF1_TX_SCDF|ADI_SPDIF1_TX_SCDFLR|ADI_SPDIF1_TX_SMODEIN|ADI_SPDIF1_TX_AUTO|ADI_SPDIF1_TX_VALIDL|ADI_SPDIF1_TX_VALIDR|ADI_SPDIF1_EXTSYNC)



#endif

/**@}*/
/**@}*/
