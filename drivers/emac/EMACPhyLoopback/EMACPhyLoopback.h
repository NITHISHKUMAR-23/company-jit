#ifndef __main_H__
#define __main_H__

/*********************************************************************************

Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

*********************************************************************************/
/*!
 * @file      EMACPhyLoopback.h
 * @brief     Example to to demonstrate EMAC Tx/Rx data transfer in PHY loopback mode.
 *
 * @details
 *            This is the primary include file to demonstrate EMAC Tx/Rx data transfer in PHY loopback mode.
 */

/*=============  I N C L U D E S   =============*/
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "adi_initialize.h"
#include <drivers/ethernet/emac/adi_emac.h>
#include <services/gpio/adi_gpio.h>
#include <services/spu/adi_spu.h>

/*=============  D E F I N E S  =============*/

/* Enable macro to display debug information */
#define ENABLE_DEBUG_INFO

/* This macro should be enabled when EV-SOMCRR-EZKIT is used */
#define EV_SOMCRR_EZKIT_SUPPORT

#ifndef EV_SOMCRR_EZKIT_SUPPORT
	/* This macro should be enabled when EV-SOMCRR-EZLITE is used */
	#define EV_SOMCRR_EZLITE_SUPPORT
#endif

#define TEST_EMAC0			/* Enable this macro to test EMAC0 */

#ifdef EV_SOMCRR_EZKIT_SUPPORT
	//#define TEST_EMAC1		/* Enable this macro to test EMAC1 */
#endif

/* Total number of descriptors/packets to be transferred */
#define NO_OF_DESCS 			5u

#ifdef TEST_EMAC0
		#define EMAC_PHY_ADIN1300
		#define EMAC_DEVICE_NO 		0u
		#define PHY_DEVICE_ADD 		0u
#else
	#define EMAC_DEVICE_NO 		1u
	#define EMAC_PHY_ADIN1200
	#define PHY_DEVICE_ADD 		1u
#endif

/* Packet size related parameters */
#define HEADER_SIZE_RX  		18u
#define HEADER_SIZE_TX  		14u
#define FRAME_SIZE_DELIMIT 		0u
#define FRAME_SIZE      		(800u-HEADER_SIZE_RX)
#define RX_BUFFER_SIZE			(FRAME_SIZE+HEADER_SIZE_RX)

/* Register definitions specific to ADIN1300 PHY */
#ifdef EMAC_PHY_ADIN1300
	#define ADIN1300_PHY_CTRL_STATUS_1_REG 						0x13
	#define ADIN1300_PHY_CTRL_STATUS_1_REG_LB_MII_LS_OK			0x01
	#define ADIN1300_PHY_CTRL_STATUS_1_REG_LB_ALL_DIG_SEL		0x1000

	#define ADIN1300_PHY_STATUS_1_REG							0x1A
	#define ADIN1300_PHY_STATUS_1_REG_LINK_STAT					0x40
	#define ADIN1300_PHY_STATUS_1_REG_1000FD					5
	#define ADIN1300_PHY_STATUS_1_REG_1000HD					4
	#define ADIN1300_PHY_STATUS_1_REG_100FD						3
	#define ADIN1300_PHY_STATUS_1_REG_100HD						2
	#define ADIN1300_PHY_STATUS_1_REG_10FD						1
	#define ADIN1300_PHY_STATUS_1_REG_10HD						0
	#define ADIN1300_PHY_STATUS_1_REG_HCD_TECH_BITP				7u
	#define ADIN1300_PHY_STATUS_1_REG_HCD_TECH_BITM				0x38
#endif

/* Register definitions specific to ADIN1200 PHY */
#ifdef EMAC_PHY_ADIN1200
	#define ADIN1200_PHY_CTRL_STATUS_1_REG 						0x13
	#define ADIN1200_PHY_CTRL_STATUS_1_REG_LB_MII_LS_OK			0x01
	#define ADIN1200_PHY_CTRL_STATUS_1_REG_LB_ALL_DIG_SEL		0x1000

	#define ADIN1200_PHY_STATUS_1_REG							0x1A
	#define ADIN1200_PHY_STATUS_1_REG_LINK_STAT					0x40
	#define ADIN1200_PHY_STATUS_1_REG_100FD						3
	#define ADIN1200_PHY_STATUS_1_REG_100HD						2
	#define ADIN1200_PHY_STATUS_1_REG_10FD						1
	#define ADIN1200_PHY_STATUS_1_REG_10HD						0
	#define ADIN1200_PHY_STATUS_1_REG_HCD_TECH_BITP				7u
	#define ADIN1200_PHY_STATUS_1_REG_HCD_TECH_BITM				0x38
#endif

#define EMAC0_SPU_PID 105
#define EMAC1_SPU_PID 106

/* Ethernet Packet Structure */
typedef struct ETHER_PACKET_CHAIN
{
    uint8_t  dst[6];
    uint8_t  src[6];
    uint8_t  length[2];
    uint8_t  data[FRAME_SIZE];
    uint8_t  fcs[4];
    uint8_t  fdlimit[FRAME_SIZE_DELIMIT];
} ETHER_PACKET_CHAIN;


/* Function Declarations */
void ResetPHY(void);
void PrepareDataBuffers(void);
void RxDescriptorsInit(void);
void TxDescriptorsInit(void);
void InitializePHY(void);
void InitializeMAC(void);
int ComnpareTxRxBuffers(void);
extern void SoftConfig_EVAL_EZKIT_SOM_EMAC_Reset_High(void);
extern void SoftConfig_EVAL_EZKIT_SOM_EMAC_Reset_Low(void);
extern void SoftConfig_EVAL_EZLITE_SOM_EMAC_Reset_High(void);
extern void SoftConfig_EVAL_EZLITE_SOM_EMAC_Reset_Low(void);

/* IF (Debug info enabled) */
#if defined(ENABLE_DEBUG_INFO)
#define DBG_MSG                     printf
#else
#define DBG_MSG(...)
#endif

/* Macro for checking result returned by the driver after API call */
#define CHECK_EMAC_RESULT(eResult)\
        if(eResult != 0)\
		{\
        	DBG_MSG("CHECK_RESULT failed at line %d of file %s \n",__LINE__,__FILE__);\
            exit(-2);\
        }
#endif /* __main_H__ */
/*****/

/*
** EOF
*/
