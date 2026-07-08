/*********************************************************************************
Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * TWI_Ext_Loopback.h
 *****************************************************************************/

#ifndef __TWI_EXT_LOOPBACK_H__
#define __TWI_EXT_LOOPBACK_H__

/* Add your custom header content here */

#define TWIDEVNUM0     (0u)        /* TWI device number */
#define TWIDEVNUM1     (1u)        /* TWI device number */
#define TWIDEVNUM2     (2u)
#define BITRATE       (100u)      /* kHz */
#define DUTYCYCLE     (50u)       /* percent */
#define PRESCALEVALUE (12u)  /* fSCLK/10MHz */

#define BUFFER_SIZE   (256u)

#define BUFFER_SIZE1   (128u)

#ifndef AUTOTEST
#define TWI_MODE_CHANGE
#endif

#define REPORT_ERROR        printf
#define DEBUG_INFORMATION         printf


#define SUCCESS   0
#define FAILED   -1

#endif /* __TWI_EXT_LOOPBACK_H__ */
