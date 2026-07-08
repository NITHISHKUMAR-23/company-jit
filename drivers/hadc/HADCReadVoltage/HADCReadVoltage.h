/*********************************************************************************

Copyright(c) 2021-2024 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

*********************************************************************************/
/*****************************************************************************
 * HADCReadVoltage.h
 *****************************************************************************/

#ifndef __HADCREADVOLTAGE_H__
#define __HADCREADVOLTAGE_H__

/* Add your custom header content here */
#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include <drivers/hadc/adi_hadc.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <services/pwr/adi_pwr.h>

/*Enable blocking mode*/
#define PERFORM_BLOCKINGMODE     (1)

/*Enable non-blocking mode*/
#define PERFORM_NONBLOCKINGMODE  (0)

/*MACRO for reporting error message*/
#define REPORT_ERROR(msg)  \
    do{\
        printf(msg);\
        exit(1);\
    }while(0)

/* Reference Voltage for the ADCs */
#define REF_VOLTAGE 1.8

/* Total Channels to convert */
#if defined (__ADSP21593__) || defined(__ADSP21593W__)
#define TOTAL_CHNL_CONV 4
#elif defined (__ADSPSC594__) || defined(__ADSPSC594W__) || defined (__ADSPSC598__) || defined(__ADSPSC598W__)
#define TOTAL_CHNL_CONV 8
#endif

/* Channels to convert*/
#if defined (__ADSP21593__) || defined(__ADSP21593W__)
#define CHNL_CONV 0xFul
#elif defined (__ADSPSC594__) || defined(__ADSPSC594W__) || defined (__ADSPSC598__) || defined(__ADSPSC598W__)
#define CHNL_CONV 0xFFul
#endif

/* Total number of conversions */
#define NO_CONV 1ul

/* Channel mask to enable for conversion - 0 -> enabled*/
#if defined (__ADSP21593__) || defined(__ADSP21593W__)
#define CHNL_MASK    0xF0ul
#elif defined (__ADSPSC594__) || defined(__ADSPSC594W__) || defined (__ADSPSC598__) || defined(__ADSPSC598W__)
#define CHNL_MASK    0x00ul
#endif

/*voltage*/
uint16_t Voltage[TOTAL_CHNL_CONV];

/*voltage converted to floating point*/
float  Voltage_Actual[TOTAL_CHNL_CONV];

/* Max Voltage for VIN0*/
#define MAX_VOLTAGE_VIN0 1.10

/* Min Voltage for VIN0*/
#define MIN_VOLTAGE_VIN0 0.90

/* Max Voltage for VIN1*/
#define MAX_VOLTAGE_VIN1 1.85

/* Min Voltage for VIN1*/
#define MIN_VOLTAGE_VIN1 1.75

/* Max Voltage for VIN2*/
#define MAX_VOLTAGE_VIN2 1.5

/* Min Voltage for VIN2*/
#define MIN_VOLTAGE_VIN2 1.30

/* Max Voltage for VIN3*/
#define MAX_VOLTAGE_VIN3 1.00

/* Min Voltage for VIN3*/
#define MIN_VOLTAGE_VIN3 0.80

#if defined (__ADSPSC594__) || defined(__ADSPSC594W__) || defined (__ADSPSC598__) || defined(__ADSPSC598W__)
/* Max Voltage for VIN4*/
#define MAX_VOLTAGE_VIN4 1.90

/* Min Voltage for VIN4*/
#define MIN_VOLTAGE_VIN4 1.70

/* Max Voltage for VIN5*/
#define MAX_VOLTAGE_VIN5 1.10

/* Min Voltage for VIN5*/
#define MIN_VOLTAGE_VIN5 0.90

/* Max Voltage for VIN6*/
#define MAX_VOLTAGE_VIN6 0.10

/* Min Voltage for VIN6*/
#define MIN_VOLTAGE_VIN6 0.00

/* Max Voltage for VIN7*/
#define MAX_VOLTAGE_VIN7 0.10

/* Min Voltage for VIN7*/
#define MIN_VOLTAGE_VIN7 0.00
#endif

#endif /* __HADCREADVOLTAGE_H__ */
