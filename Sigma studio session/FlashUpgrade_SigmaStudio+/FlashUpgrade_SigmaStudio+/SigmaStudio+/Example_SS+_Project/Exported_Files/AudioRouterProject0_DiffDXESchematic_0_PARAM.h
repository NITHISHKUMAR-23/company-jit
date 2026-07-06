/* 
 * File:	D:\Query\Hansong_SSP\SS+_test_for_query10\ExportedFiles\Project0\AudioRouterProject0_DiffDXESchematic_0_PARAM.h
 * Created:	Thursday, 26 September 2024 12:11 PM
 * Description:	DiffDXESchematic_0 parameter RAM definitions.
 * 
 * This software is distributed in the hope that it will be useful, 
 * but is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
 * CONDITIONS OF ANY KIND, without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
 * 
 * This software may only be used to program products purchased from 
 * Analog Devices for incorporation by you into audio products that 
 * are intended for resale to audio product end users.This software 
 * may not be distributed whole or in any part to third parties. 
 * 
 * Copyright © 2024 Analog Devices, Inc. All rights reserved.
 */
#ifndef __AUDIOROUTERPROJECT0_DIFFDXESCHEMATIC_0_PARAM_H__
#define __AUDIOROUTERPROJECT0_DIFFDXESCHEMATIC_0_PARAM_H__




/* Module SWSlewMute_0 - Mute (SW Slew) */
#define MOD_SWSLEWMUTE_0_COUNT             2
#define MOD_SWSLEWMUTE_0_SCHEMATIC         "DiffDXESchematic_0"
#define MOD_SWSLEWMUTE_0_MUTE_ADDR         2
#define MOD_SWSLEWMUTE_0_MUTE_FIXPT        0x3F800000
#define MOD_SWSLEWMUTE_0_MUTE_VALUE        SIGMASTUDIOTYPE_FLOAT_CONVERT(1)
#define MOD_SWSLEWMUTE_0_MUTE_TYPE         SIGMASTUDIOTYPE_FLOAT
#define MOD_SWSLEWMUTE_0_SLEWRATE_ADDR     1
#define MOD_SWSLEWMUTE_0_SLEWRATE_FIXPT    0x39800000
#define MOD_SWSLEWMUTE_0_SLEWRATE_VALUE    SIGMASTUDIOTYPE_FLOAT_CONVERT(0.000244140625)
#define MOD_SWSLEWMUTE_0_SLEWRATE_TYPE     SIGMASTUDIOTYPE_FLOAT

/* Module SimpleRouter_1 - Simple Router */
#define MOD_SIMPLEROUTER_1_COUNT                  2
#define MOD_SIMPLEROUTER_1_SCHEMATIC              "DiffDXESchematic_0"
#define MOD_SIMPLEROUTER_1_OUTPUTARRAY_0_ADDR     15
#define MOD_SIMPLEROUTER_1_OUTPUTARRAY_0_FIXPT    0x000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000B
#define MOD_SIMPLEROUTER_1_OUTPUTARRAY_0_VALUE    SIGMASTUDIOTYPE_INTEGER_CONVERT(0)
#define MOD_SIMPLEROUTER_1_OUTPUTARRAY_0_TYPE     SIGMASTUDIOTYPE_INTEGER
#define MOD_SIMPLEROUTER_1_GAINARRAY_0_ADDR       3
#define MOD_SIMPLEROUTER_1_GAINARRAY_0_FIXPT      0x3F8000003F8000003F8000003F8000003F8000003F8000003F8000003F8000003F8000003F8000003F8000003F800000
#define MOD_SIMPLEROUTER_1_GAINARRAY_0_VALUE      SIGMASTUDIOTYPE_FLOAT_CONVERT(0)
#define MOD_SIMPLEROUTER_1_GAINARRAY_0_TYPE       SIGMASTUDIOTYPE_FLOAT











#endif
