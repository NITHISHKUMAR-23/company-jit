/*********************************************************************************
Copyright(c) 2019-2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * TWI_Si5356A_Config.h
 *****************************************************************************/

#ifndef __TWI_SI5356A_CONFIG_H__
#define __TWI_SI5356A_CONFIG_H__

/* Silicon Labs ClockBuilder register configuration */
#define code
#include "audio_clk_10MHz.h"  /* audio clock */

/* Add your custom header content here */

#define TARGETADDR    (0x70u)     /* hardware address for the Si5356A (clock generator) */

#define TWIDEVNUM     (2u)        /* TWI device number */
#define BITRATE       (100u)      /* kHz */
#define DUTYCYCLE     (50u)       /* percent */
#define PRESCALEVALUE (12u)       /* fSCLK/10MHz (125 sclk0_0) */
#define BUFFER_SIZE   (8)


#endif /* __TWI_SI5356A_CONFIG_H__ */
