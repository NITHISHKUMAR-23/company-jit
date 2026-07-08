/*********************************************************************************
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * TRNG_ReadRandomNum.h
 *****************************************************************************/

#ifndef __TRNG_READRANDOMNUM_H__
#define __TRNG_READRANDOMNUM_H__

/* Add your custom header content here */

/* Use only one of the modes at a time */
/*Enable blocking mode*/
#define PERFORM_BLOCKINGMODE     (0)

/*Enable non-blocking mode*/
#define PERFORM_NONBLOCKINGMODE  (1)

/* Use static configuration done in adi_TRNG_Open function to configure TRNG */
#define USE_STATIC_CONFIG		 (1)


#endif /* __TRNG_READRANDOMNUM_H__ */


