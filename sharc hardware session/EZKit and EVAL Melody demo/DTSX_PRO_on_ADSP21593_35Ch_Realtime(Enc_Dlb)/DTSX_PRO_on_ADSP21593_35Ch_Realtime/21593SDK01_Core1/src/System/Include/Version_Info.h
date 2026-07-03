/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Version_Info.h
*  Description      :   Version Number Variable Declaration and Initialization
******************************************************************************/
#ifndef VERSION_INFO_H_
#define VERSION_INFO_H_

#include "asm_sprt.h"
/******************************************************************************
 * Version Number Variable Declaration and Initialization Section
 *****************************************************************************/
.section/BW  seg_versioninfo_L1;

.var   Ver_No_1.= 0x02100018;
.var   Ver_No_3.= 0xB1814D23;
.var   Ver_No_5.= 0x10330024;
.var   Ver_No_7.= 0x351A235F;

.endseg;

.global   Ver_No_1.;
.global   Ver_No_3.;
.global   Ver_No_5.;
.global   Ver_No_7.;

.section/BW  seg_versioninfo_L2;

.var   Ver_No_2.= 0x2836195C;
.var   Ver_No_4.= 0x0B152747;
.var   Ver_No_6.= 0x002C0006;
.var   Ver_No_8.= 0x383F8350;

.endseg;

.global   Ver_No_2.;
.global   Ver_No_4.;
.global   Ver_No_6.;
.global   Ver_No_8.;


#endif /* VERSION_INFO_H_ */
