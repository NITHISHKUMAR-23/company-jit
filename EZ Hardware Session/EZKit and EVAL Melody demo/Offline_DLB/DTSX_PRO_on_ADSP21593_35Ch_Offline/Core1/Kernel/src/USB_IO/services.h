/*********************************************************************************

Copyright(c) 2010 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

*********************************************************************************/

#ifndef __SERVICES_H__
#define __SERVICES_H__

/*********************************************************************

Define the starting points for enumerations within the services.  This
insures that the enumeration values for each of the services do not
overlap with one another.  This only applies to items such as command IDs,
event IDs, and return codes.  Note that the return code from each service
for generic success is always 0, while the return code from each service
for generic failure is always 1, regardless of the enumeration starting
point.

*********************************************************************/

#define ADI_DEV_ENUMERATION_START     (0x00010000)
#define ADI_DCB_ENUMERATION_START     (0x00020000)
#define ADI_DMA_ENUMERATION_START     (0x00030000)
#define ADI_EBIU_ENUMERATION_START    (0x00040000)
#define ADI_INT_ENUMERATION_START     (0x00050000)
#define ADI_PWR_ENUMERATION_START     (0x00060000)

// integer typedefs - for all modules
#if !defined(_LANGUAGE_ASM)

typedef unsigned short u16;
typedef unsigned long  u32;
typedef unsigned long  ADI_PSL_UINT32;
typedef unsigned char  u8;
typedef short s16;
typedef long  s32;
typedef char  s8;

#endif

// TRUE, FALSE and NULL

#ifndef TRUE
#define TRUE (1)
#endif

#ifndef FALSE
#define FALSE (0)
#endif

#if !defined(_LANGUAGE_ASM)

#ifndef NULL
#define NULL ((void *)0)
#endif

// an in-line delay loop
#define ADI_DELAY(count)                        \
{                                               \
    volatile unsigned int vol_count = count;    \
    while (vol_count--) asm("nop;");            \
}

#endif

//#include "adi_int.h"


#endif // __SERVICES_H__
