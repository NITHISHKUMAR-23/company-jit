/*********************************************************************************
Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * main.h
 *****************************************************************************/

#ifndef __MAIN_H__
#define __MAIN_H__

/* CRC Driver includes */
#include <drivers/crc/adi_crc.h>
#include <services/spu/adi_spu.h>

#define DEBUG_PRINT printf  /* output is directed to the view console window */

#define	CRC_DEV_NUM					(0u)
#if defined(__ADSPSC598_FAMILY__)
#define MDMASRCID                   147
#define MDMADSTID                   148
#else
#define MDMASRCID                   146
#define MDMADSTID                   147
#endif

/* CRC memory*/
#define MEM ADI_CRC_DMA_MEMORY_SIZE

/* Expected CRC value*/
#if defined(__ADSPARM__)
#define EXPECTED_CRC    0x99634648u
#else
#define EXPECTED_CRC    0xB150CBD0u
#endif

/* Number of 32-bit elements in CRC Buffer used for testing */
#define CRC_BUF_NUM_ELEMENTS        (10)

/* Memory Copy time out value */
#define CRC_TIME_OUT_VAL            (0x7FFFFFFu)

#define CHECK_RESULT(eResult) \
        if(eResult != 0)\
		{\
			DEBUG_PRINT("CHECK_RESULT failed at line %d of file %s \n",__LINE__,__FILE__);\
			;\
        }


#define CRC_POLYNOMIAL 0x12345678



#endif /* __MAIN_H__ */
