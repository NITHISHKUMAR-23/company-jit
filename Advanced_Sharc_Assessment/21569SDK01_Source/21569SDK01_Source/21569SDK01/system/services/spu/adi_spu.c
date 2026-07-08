/*********************************************************************************

Copyright(c) 2014-2018 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

*********************************************************************************/
/*!
* @file      adi_spu.c
*
* @brief     SPU global source file.
*
* @details
*            System Protection Unit source file which includes different versions
*            of the SPU source files based on the version of the SPU that is
*            used in a particular processor family.
*/

/** @defgroup SPU_Service System Protection Unit (SPU) Service
*/

#if defined(__ADSPBF707_FAMILY__) || defined(__ADSPBF716_FAMILY__) || defined(__ADSPSC573_FAMILY__) || defined(__ADSPSC589_FAMILY__) || defined(__ADSP21569_FAMILY__)
#include "adi_spu_v2.c"
#else
#error "This processor is not supported."
#endif 
