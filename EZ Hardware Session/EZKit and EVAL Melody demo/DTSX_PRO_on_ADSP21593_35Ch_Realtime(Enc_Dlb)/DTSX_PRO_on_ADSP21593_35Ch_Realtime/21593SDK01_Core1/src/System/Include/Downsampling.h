/***************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :  	DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Downsampling.h
*  Description      :   All the downsampling Variables and coeff buffers included
*
******************************************************************************/
#ifndef Downsampling_H
#define Downsampling_H
#include "..\src\system\Include\Commn.h"

#ifdef DOWNSAMPLING
#define DOLBYBLOCKCOUNTMAX      	48
#define COUNT                       64
#define TAPS_DS						129
#define CORE_BUFFER_SIZE       		129
#define ACC_BUFFER_SIZE        		384
#define ACC_COEFF_BUFFER_SIZE       129
#define CORE_HEAP_BUF_SIZE_64      	41
#define CORE_HEAP_BUF_SIZE     		65
#define ACC_TCP_CHAIN_BUF_SIZE 		13
#define NO_OF_SAMPLE_PROCESSING_DS	64

#define NO_OF_ACC_BUFFER			8
#define NO_OF_CORE_BUFFER			NO_OF_ACC_BUFFER

.segment/bw seg_DS_data_B0; // DS_DD_SYS_INIT should be taken care according to the buffer allocation
.var leftinput_delays_heap_buffer1[CORE_BUFFER_SIZE];//[CORE_BUFFER_SIZE];    //don't change the order
.var rightinput_delays_heap_buffer1[CORE_BUFFER_SIZE];//[CORE_BUFFER_SIZE];
.var centerinput_delays_heap_buffer1[CORE_BUFFER_SIZE];//[CORE_BUFFER_SIZE];
.var lfeinput_delays_heap_buffer1[CORE_BUFFER_SIZE];//[CORE_BUFFER_SIZE];
.var Ls_input_delays_heap_buffer1[CORE_BUFFER_SIZE];//[CORE_BUFFER_SIZE];
.var Rs_input_delays_heap_buffer1[CORE_BUFFER_SIZE];//[CORE_BUFFER_SIZE];
.var Lsr_input_delays_heap_buffer1[CORE_BUFFER_SIZE];//[CORE_BUFFER_SIZE];
.var Rsr_input_delays_heap_buffer1[CORE_BUFFER_SIZE];//[CORE_BUFFER_SIZE];
.endseg;

.segment/bw seg_DS_data_B0;
.var Add1_input_delays_heap_buffer1[CORE_BUFFER_SIZE];
.var Add2_input_delays_heap_buffer1[CORE_BUFFER_SIZE];
.var Add3_input_delays_heap_buffer1[CORE_BUFFER_SIZE];
.var Add4_input_delays_heap_buffer1[CORE_BUFFER_SIZE];
.var Add5_input_delays_heap_buffer1[CORE_BUFFER_SIZE];
.var Add6_input_delays_heap_buffer1[CORE_BUFFER_SIZE];
.var Add7_input_delays_heap_buffer1[CORE_BUFFER_SIZE];
.var Add8_input_delays_heap_buffer1[CORE_BUFFER_SIZE];
.endseg;

.global leftinput_delays_heap_buffer1;
.global rightinput_delays_heap_buffer1;
.global centerinput_delays_heap_buffer1;
.global lfeinput_delays_heap_buffer1;
.global Ls_input_delays_heap_buffer1;
.global Rs_input_delays_heap_buffer1;
.global Lsr_input_delays_heap_buffer1;
.global Rsr_input_delays_heap_buffer1;
.global Add1_input_delays_heap_buffer1;
.global Add2_input_delays_heap_buffer1;
.global Add3_input_delays_heap_buffer1;
.global Add4_input_delays_heap_buffer1;
.global Add5_input_delays_heap_buffer1;
.global Add6_input_delays_heap_buffer1;
.global Add7_input_delays_heap_buffer1;
.global Add8_input_delays_heap_buffer1;

.section/bw seg_DownSampling_kernal_data;
.var Do_Downsampling_process.;
.var Previous_DS_Mode.=0;
.endseg;

.global Do_Downsampling_process.;
.global Previous_DS_Mode.;

.section/bw seg_ds_coeff_data_l2;
/* Up/Downsampling FIR 128 taps coeffs  */
.var lp_cfs128_1to2or2to1.[CORE_BUFFER_SIZE]=
		0x39938F80,
		0x396EDEC0,
		0xB9B4C460,
		0xB9BAD6D0,
		0x39CF4980,
		0x3A07F178,
		0xB9DEB5F0,
		0xBA3B6B10,
		0x39DE1AB0,
		0x3A7784A8,
		0xB9C82310,
		0xBA9DB1CC,
		0x39973D60,
		0x3AC2CB3C,
		0xB90B9560,
		0xBAEA0474,
		0xB8C6AD40,
		0x3B08FEE2,
		0x39D43990,
		0xBB1C800A,
		0xBA532BD8,
		0x3B2E7EAE,
		0x3AAAE970,
		0xBB3DC972,
		0xBAF9AD30,
		0x3B4906A2,
		0x3B2B1A8A,
		0xBB4EB6AA,
		0xBB603D12,
		0x3B4D365E,
		0x3B8E04A2,
		0xBB42C088,
		0xBBAF0B1C,
		0x3B2D6D72,
		0x3BD2E31C,
		0xBB0B2ECA,
		0xBBF923DC,
		0x3AB38B54,
		0x3C10A609,
		0xB9B57580,
		0xBC256224,
		0xBA820368,
		0x3C3A710A,
		0x3B30DD84,
		0xBC4F760A,
		0xBB9EC473,
		0x3C640F4E,
		0x3BF6BC0B,
		0xBC77D879,
		0xBC3292C1,
		0x3C8536B6,
		0x3C78DBA1,
		0xBC8DB693,
		0xBCAA73DC,
		0x3C953E4C,
		0x3CE9B87F,
		0xBC9BA4B2,
		0xBD23FD53,
		0x3CA0C62C,
		0x3D7496EE,
		0xBCA485D3,
		0xBDD46518,
		0x3CA6CE56,
		0x3EA2904D,
		0x3EF586D5,
		0x3EA2904D,
		0x3CA6CE56,
		0xBDD46518,
		0xBCA485D3,
		0x3D7496EE,
		0x3CA0C62C,
		0xBD23FD53,
		0xBC9BA4B2,
		0x3CE9B87F,
		0x3C953E4C,
		0xBCAA73DC,
		0xBC8DB693,
		0x3C78DBA1,
		0x3C8536B6,
		0xBC3292C1,
		0xBC77D879,
		0x3BF6BC0B,
		0x3C640F4E,
		0xBB9EC473,
		0xBC4F760A,
		0x3B30DD84,
		0x3C3A710A,
		0xBA820368,
		0xBC256224,
		0xB9B57580,
		0x3C10A609,
		0x3AB38B54,
		0xBBF923DC,
		0xBB0B2ECA,
		0x3BD2E31C,
		0x3B2D6D72,
		0xBBAF0B1C,
		0xBB42C088,
		0x3B8E04A2,
		0x3B4D365E,
		0xBB603D12,
		0xBB4EB6AA,
		0x3B2B1A8A,
		0x3B4906A2,
		0xBAF9AD30,
		0xBB3DC972,
		0x3AAAE970,
		0x3B2E7EAE,
		0xBA532BD8,
		0xBB1C800A,
		0x39D43990,
		0x3B08FEE2,
		0xB8C6AD40,
		0xBAEA0474,
		0xB90B9560,
		0x3AC2CB3C,
		0x39973D60,
		0xBA9DB1CC,
		0xB9C82310,
		0x3A7784A8,
		0x39DE1AB0,
		0xBA3B6B10,
		0xB9DEB5F0,
		0x3A07F178,
		0x39CF4980,
		0xB9BAD6D0,
		0xB9B4C460,
		0x396EDEC0,
		0x39938F80;
.endseg;



.section/bw seg_ds_coeff_data;
/* Up/Downsampling FIR 128 taps coeffs  */
.var lp_cfs128_1to4or4to1.[CORE_BUFFER_SIZE]=
		0xBACCF1E8,
		0xBA31D000,
		0x3A39B680,
		0x3AF28790,
		0x3B06BFA8,
		0x3A9011D0,
		0xBA1CB5E8,
		0xBB0C09C6,
		0xBB2B4BE6,
		0xBAD71FC0,
		0x39C3BED0,
		0x3B1C07F8,
		0x3B53A196,
		0x3B17CCCE,
		0xB7269400,
		0xBB279D1C,
		0xBB7F18B4,
		0xBB4D84A8,
		0xBA087590,
		0x3B2CE4AA,
		0x3B96708F,
		0x3B86C822,
		0x3AA3ECCC,
		0xBB29A47E,
		0xBBAE0420,
		0xBBAC7F57,
		0xBB118392,
		0x3B1B2902,
		0x3BC5C02A,
		0x3BD8A8F6,
		0x3B643C00,
		0xBAFBFFAC,
		0xBBDD1490,
		0xBC063B0D,
		0xBBA78CC6,
		0x3A9AE0E4,
		0x3BF36CD3,
		0x3C24F772,
		0x3BECF3A4,
		0xB81A3100,
		0xBC041AA4,
		0xBC4A6194,
		0xBC248070,
		0xBADDB854,
		0x3C0D7036,
		0x3C7A0FA2,
		0x3C643141,
		0x3B8E4657,
		0xBC157603,
		0xBC9DDA47,
		0xBCA19FF7,
		0xBC0DE3DF,
		0x3C1BF30A,
		0x3CD15269,
		0x3CF2C804,
		0x3C88EB9A,
		0xBC20B883,
		0xBD1BC65E,
		0xBD53D3F6,
		0xBD185284,
		0x3C23A3AF,
		0x3DA72EBF,
		0x3E2283F1,
		0x3E5F0BBF,
		0x3E75B60D,
		0x3E5F0BBF,
		0x3E2283F1,
		0x3DA72EBF,
		0x3C23A3AF,
		0xBD185284,
		0xBD53D3F6,
		0xBD1BC65E,
		0xBC20B883,
		0x3C88EB9A,
		0x3CF2C804,
		0x3CD15269,
		0x3C1BF30A,
		0xBC0DE3DF,
		0xBCA19FF7,
		0xBC9DDA47,
		0xBC157603,
		0x3B8E4657,
		0x3C643141,
		0x3C7A0FA2,
		0x3C0D7036,
		0xBADDB854,
		0xBC248070,
		0xBC4A6194,
		0xBC041AA4,
		0xB81A3100,
		0x3BECF3A4,
		0x3C24F772,
		0x3BF36CD3,
		0x3A9AE0E4,
		0xBBA78CC6,
		0xBC063B0D,
		0xBBDD1490,
		0xBAFBFFAC,
		0x3B643C00,
		0x3BD8A8F6,
		0x3BC5C02A,
		0x3B1B2902,
		0xBB118392,
		0xBBAC7F57,
		0xBBAE0420,
		0xBB29A47E,
		0x3AA3ECCC,
		0x3B86C822,
		0x3B96708F,
		0x3B2CE4AA,
		0xBA087590,
		0xBB4D84A8,
		0xBB7F18B4,
		0xBB279D1C,
		0xB7269400,
		0x3B17CCCE,
		0x3B53A196,
		0x3B1C07F8,
		0x39C3BED0,
		0xBAD71FC0,
		0xBB2B4BE6,
		0xBB0C09C6,
		0xBA1CB5E8,
		0x3A9011D0,
		0x3B06BFA8,
		0x3AF28790,
		0x3A39B680,
		0xBA31D000,
		0xBACCF1E8;
.endseg;

.global lp_cfs128_1to4or4to1.;
.global lp_cfs128_1to2or2to1.;

#endif  //DOWNSAMPLING
#endif  /*	Downsampling_H  */
