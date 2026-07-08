/*********************************************************************************
Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * main.h
 *****************************************************************************/

#ifndef _MAIN_H_
#define _MAIN_H_


/* Add your custom header content here */
/* CRC Driver includes */
#include <drivers/crc/adi_crc.h>
#include <services/spu/adi_spu.h>
#include <stdio.h>

#define DEBUG_PRINT printf  /* output is directed to the view console window */

/* CRC Device number to work on */
#define	CRC_DEV_NUM					(0u)
#if defined(__ADSPSC598_FAMILY__)
#define MDMASRCID                   147
#define MDMADSTID                   148
#else
#define MDMASRCID                   146
#define MDMADSTID                   147
#endif

/* Scan compute mode */
#define MODE ADI_CRC_SCAN_COMPUTE_COMPARE

/* CRC in DMA mode*/
#define MEM ADI_CRC_DMA_MEMORY_SIZE

/* Number of 32-bit elements in CRC Buffer used for testing */
#define CRC_BUF_NUM_ELEMENTS        (1024)

/* Memory Copy time out value */
#define CRC_TIME_OUT_VAL            (0x7FFFFFFu)

#define CHECK_RESULT(eResult) \
        if(eResult != 0)\
		{\
			DEBUG_PRINT("CHECK_RESULT failed at line %d of file %s \n",__LINE__,__FILE__);\
			;\
        }


/* Expected CRC value*/
#if defined(__ADSPARM__)
#define EXPECTED_CRC    0x8BF05A78u
#else
#define EXPECTED_CRC    0x7457A310u
#endif

#endif /* _MAIN_H_ */
