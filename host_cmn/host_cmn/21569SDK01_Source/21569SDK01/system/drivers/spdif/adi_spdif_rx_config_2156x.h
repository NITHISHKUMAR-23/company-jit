/*********************************************************************************

Copyright(c) 2018 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

*********************************************************************************/
/*!
 *  @addtogroup SPDIF_RX_Driver Receive S/PDIF Driver
 *  @{
 */

/*!
 * @addtogroup SPDIF_RX_Driver_Static_Configuration Receive S/PDIF Driver Static Configuration
 * @{
  Static Configuration provides an easy and convient way for application to configure the device during driver's open
  call. When an application provides custom static configuration file, then according to the setting provided driver initialises
  the device during driver's open call. If application fails to provide any custom configuration file, then by default S/PDIF RX device
  driver does not perform any static configuration.
 */

 
/*!
 * @file     adi_spdif_rx_config_2156x.h
 *
 * @brief    Receive S/PDIF driver static configuration file
 *
 * @version  $Revision: 61437 $
 *
 * @date     $Date: 2019-02-21 07:38:15 -0500 (Thu, 21 Feb 2019) $
 *
 * @details
 *           This is the static configuration file for the receive S/PDIF Driver
 */





#ifndef __ADI_SPDIF_RX_CONGIF_2156X_H__
#define __ADI_SPDIF_RX_CONGIF_2156X_H__  


/*! SPDIF0 RX frame sync strength. Set for strong frame sync and clear for weak frame sync */
//#define SPDIF0_RX_FS_STRENGTH        0u

/*! SPDIF0 RX frame lock speed. Set for fast mode and clear for slow mode */
//#define SPDIF0_RX_LOCK_SPEED         0u

/*! SPDIF0 RX auto restart enable. Set for Auto mode and clear for manual mode */
//#define SPDIF0_RX_AUTO_RESTART       1u

//#define SPDIF0_RX_DIV       0u




/*! SPDIF1 RX frame sync strength. Set for strong frame sync and clear for weak frame sync */
#define SPDIF1_RX_FS_STRENGTH        0u

/*! SPDIF1 RX frame lock speed. Set for fast mode and clear for slow mode */
#define SPDIF1_RX_LOCK_SPEED         0u

/*! SPDIF1 RX auto restart enable. Set for Auto mode and clear for manual mode */
#define SPDIF1_RX_AUTO_RESTART       1u

#define SPDIF1_RX_DIV       0u


/*! Set to use static configuration for Spdif 0 */
//#define USE_STATIC_SPDIF0_RX 0u

/*! Set to use static configuration for Spdif 1 */
#define USE_STATIC_SPDIF1_RX 1u


//#define ADI_SPDIF0_RX_FS_STRENGTH       (SPDIF0_RX_FS_STRENGTH<<BITP_SPDIF_RX_CTL_STRENGTH)
//#define ADI_SPDIF0_RX_LOCK_SPEED        (SPDIF0_RX_LOCK_SPEED<<BITP_SPDIF_RX_CTL_FASTLOCK)
//#define ADI_SPDIF0_RX_AUTO_RESTART      (SPDIF0_RX_AUTO_RESTART<<BITP_SPDIF_RX_CTL_RSTRTAUDIO)


#define ADI_SPDIF1_RX_FS_STRENGTH       (SPDIF1_RX_FS_STRENGTH<<BITP_SPDIF_RX_CTL_STRENGTH)
#define ADI_SPDIF1_RX_LOCK_SPEED        (SPDIF1_RX_LOCK_SPEED<<BITP_SPDIF_RX_CTL_FASTLOCK)
#define ADI_SPDIF1_RX_AUTO_RESTART      (SPDIF1_RX_AUTO_RESTART<<BITP_SPDIF_RX_CTL_RSTRTAUDIO)




 
//#define ADI_SPDIF_RX0_CTL                    (ADI_SPDIF0_RX_FS_STRENGTH|ADI_SPDIF0_RX_LOCK_SPEED|ADI_SPDIF0_RX_AUTO_RESTART|SPDIF0_RX_DIV<<9)
#define ADI_SPDIF_RX1_CTL                    (ADI_SPDIF1_RX_FS_STRENGTH|ADI_SPDIF1_RX_LOCK_SPEED|ADI_SPDIF1_RX_AUTO_RESTART|SPDIF1_RX_DIV<<9)



#endif

/**@}*/
/*@}*/
