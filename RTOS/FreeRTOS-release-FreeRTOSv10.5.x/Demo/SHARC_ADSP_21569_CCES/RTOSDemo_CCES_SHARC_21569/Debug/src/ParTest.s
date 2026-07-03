	.file "..\src\ParTest.c";
//  Compilation time: Thu Oct 24 14:40:13 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\src -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo src\ParTest.d -o src\ParTest.doj
//  Compiler version: 9.0.1.0 (3c32de17843e2a15d59cba36e76935c59d53d107)
//  Architecture: ADSP-21569
//  Silicon revision: any
//  Anomalies summary:
//   Disabled: w_anomaly_45, w_anomaly_2126x_4, w_dag_stall, w_2136x_multi, w_2136x_mem_write, w_09000014, w_09000018, w_09000020, w_07000009_1, w_07000009_2, w_09000021, w_15000003, w_09000022, w_15000004, w_15000011, w_09000023, w_15000005, w_15000016, w_15000023, w_20000022, w_20000020, w_20000024, w_20000023, w_20000009, w_20000083
//   Enabled: w_20000002, w_20000069
//   Always on: w_simd, w_restore_loop_stack

.MESSAGE/SUPPRESS 2555;
.MESSAGE/SUPPRESS 2561;
.MESSAGE/SUPPRESS 2565;


	.section/SW/DOUBLE32 seg_swco;

.epctext:

vParTestSetLED.:
.LNvParTestSetLED.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "..\src\ParTest.c":89
	modify(i7,-2) (nw);
	dm(-2,i6)=r8;
	dm(-3,i6)=r4;
.LN0:
// line 91
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vParTestSetLED..end:
.vParTestSetLED..end:
	.global vParTestSetLED.;
	.type vParTestSetLED.,STT_FUNC;

vParTestInitialise.:
.LNvParTestInitialise.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
//  Original Loop at "..\src\ParTest.c" line 80 col 6 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
//  Original Loop at "..\src\ParTest.c" line 81 col 6 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
//  Original Loop at "..\src\ParTest.c" line 82 col 6 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
//  Original Loop at "..\src\ParTest.c" line 83 col 6 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
// line "..\src\ParTest.c":63
	modify(i7,-2) (nw);
.LN1:
// line 67
	i4=modify(i6,-2) (nw);
	r12=i4;
	r8=16;
	r4=gpioMemory.0.;
	cjump adi_gpio_Init. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
	r2=pass r0;
.LN2:
	if eq jump (pc,.P38L2);

.LN3:
// line 69
	r2=.sadigpi.1;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
	modify(i7,2) (nw);
.LN4:
// line 70
	r4=m6;
	cjump exit. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:

.P38L2:
.LN5:
// line 74
	r8=8;
	r12=m6;
	r4=m6;
	cjump adi_gpio_SetDirection. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
	r2=pass r0;
.LN6:
	if eq jump (pc,.P38L6);

.LN7:
// line 76
	r2=.sadigpi.2;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
	modify(i7,2) (nw);
.LN8:
// line 77
	r4=m6;
	cjump exit. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:

.P38L6:

.LN9:
// line 80
	r2=dm(822907364);
	r1=-258049;
	r2=r2 and r1;
	r1=12;
	r2=bset r2 by r1;
	dm(822907364)=r2;


.LN10:
// line 81
	r2=dm(822907368);
	r1=-64;
	r2=r2 and r1;
	r1=m5;
	r2=bset r2 by r1;
	dm(822907368)=r2;


.LN11:
// line 82
	r2=dm(822907268);
	r1=-266338305;
	r2=r2 and r1;
	r1=264241152;
	r2=r2 or r1;
	dm(822907268)=r2;


.LN12:
// line 83
	r2=dm(822907272);
	r1=-2080769;
	r2=r2 and r1;
	r1=2064384;
	r2=r2 or r1;
	dm(822907272)=r2;

.LN13:
// line 84
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vParTestInitialise..end:
.vParTestInitialise..end:
	.global vParTestInitialise.;
	.type vParTestInitialise.,STT_FUNC;

vParTestToggleLED.:
.LNvParTestToggleLED.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r1-r2,r4,r8,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
//  Original Loop at "..\src\ParTest.c" line 107 col 6 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
//  Original Loop at "..\src\ParTest.c" line 112 col 6 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
//  Original Loop at "..\src\ParTest.c" line 120 col 6 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
//  Original Loop at "..\src\ParTest.c" line 125 col 6 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
// line "..\src\ParTest.c":96
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;
.LN14:
// line 97
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
.LN15:
// line 99
	r2=dm(-2,i6);
	r1=lshift r2 by 0;
	if sz jump (pc,.P43L25);

	r1=m5;
	r1=btgl r2 by r1;
	if sz jump (pc,.P43L4);

	r1=m6;
	r1=btgl r2 by r1;
	if sz jump (pc,.P43L5);

	jump (pc,.P43L2);

.P43L25:
	r2=pass r2;
	if ne jump (pc,.P43L2);

.LN16:
// line 101
	r8=8;
	r4=m6;
	cjump adi_gpio_Toggle. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
.LN17:
// line 102
	jump (pc,.P43L6);

.P43L4:
	i4=r2;
.LN18:
// line 105
	i4=modify(i4,m7);
	i4=modify(i4,DAI_LED_STATE.);
	r2=dm(m5,i4) (bw);
	r2=pass r2;
	if ne jump (pc,.P43L8);


.LN19:
// line 107
	r2=dm(822907272);
	r1=-2080769;
	r2=r2 and r1;
	r1=2080768;
	r2=r2 or r1;
	dm(822907272)=r2;

.LN20:
// line 108
	i4=dm(-2,i6);
	i4=modify(i4,m7);
	i4=modify(i4,DAI_LED_STATE.);
	dm(m5,i4)=m14 (bw);
.LN21:
// line 109
	jump (pc,.P43L9);

.P43L8:

.LN22:
// line 112
	r2=dm(822907272);
	r1=-2080769;
	r2=r2 and r1;
	r1=2064384;
	r2=r2 or r1;
	dm(822907272)=r2;

.LN23:
// line 113
	i4=dm(-2,i6);
	i4=modify(i4,m7);
	i4=modify(i4,DAI_LED_STATE.);
	dm(m5,i4)=m13 (bw);

.P43L9:
.LN24:
// line 115
	jump (pc,.P43L6);

.P43L5:
	i4=r2;
.LN25:
// line 118
	i4=modify(i4,m7);
	i4=modify(i4,DAI_LED_STATE.);
	r2=dm(m5,i4) (bw);
	r2=pass r2;
	if ne jump (pc,.P43L15);


.LN26:
// line 120
	r2=dm(822907268);
	r1=-266338305;
	r2=r2 and r1;
	r1=266338304;
	r2=r2 or r1;
	dm(822907268)=r2;

.LN27:
// line 121
	i4=dm(-2,i6);
	i4=modify(i4,m7);
	i4=modify(i4,DAI_LED_STATE.);
	dm(m5,i4)=m14 (bw);
.LN28:
// line 122
	jump (pc,.P43L16);

.P43L15:

.LN29:
// line 125
	r2=dm(822907268);
	r1=-266338305;
	r2=r2 and r1;
	r1=264241152;
	r2=r2 or r1;
	dm(822907268)=r2;

.LN30:
// line 126
	i4=dm(-2,i6);
	i4=modify(i4,m7);
	i4=modify(i4,DAI_LED_STATE.);
	dm(m5,i4)=m13 (bw);

.P43L16:
.LN31:
// line 128
	jump (pc,.P43L6);

.P43L2:

.P43L6:
.LN32:
// line 134
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
.LN33:
// line 135
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vParTestToggleLED..end:
.vParTestToggleLED..end:
	.global vParTestToggleLED.;
	.type vParTestToggleLED.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="vParTestSetLED.";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="vParTestInitialise.";
	.file_attr FuncName="vParTestToggleLED.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern adi_gpio_Init.;
	.type adi_gpio_Init.,STT_FUNC;
	.extern _printf32.;
	.type _printf32.,STT_FUNC;
	.extern exit.;
	.type exit.,STT_FUNC;
	.extern adi_gpio_SetDirection.;
	.type adi_gpio_SetDirection.,STT_FUNC;
	.extern vTaskSuspendAll.;
	.type vTaskSuspendAll.,STT_FUNC;
	.extern adi_gpio_Toggle.;
	.type adi_gpio_Toggle.,STT_FUNC;
	.extern xTaskResumeAll.;
	.type xTaskResumeAll.,STT_FUNC;

	.section/DOUBLE32 seg_dmda;

	.align 8;
	.type .epcbss,STT_OBJECT;
.epcbss:
	.byte gpioMemory.0.[16];
	.type gpioMemory.0.,STT_OBJECT;
.epcbss.end:

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\src\ParTest.sbn", 0, 305;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x89,0x30,0x06,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x2E,0x2E,0x5C,0x73,0x72,0x63,0x5C,0x50,0x61,0x72,
		0x54,0x65,0x73,0x74,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\src\ParTest.sbn", 305, 405322;
	.var = .LNvParTestSetLED.;
	.var = .LN.vParTestSetLED..end;
	.byte =
		0x01,0x01,0x00,0x15,0x75,0x78,0x4C,0x45,0x44,0x00,0xC8,0x0B,
		0x00,0x00,0x02,0x86,0x74,0x00,0x15,0x78,0x56,0x61,0x6C,0x75,
		0x65,0x00,0xB7,0x0B,0x00,0x00,0x02,0x86,0x78,0x00,0x16,0x00,
		0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.vParTestSetLED..end;
	.byte =
		0x00,0x00,0x14,0x0F,0x30,0x06,0x00,0x76,0x50,0x61,0x72,0x54,
		0x65,0x73,0x74,0x49,0x6E,0x69,0x74,0x69,0x61,0x6C,0x69,0x73,
		0x65,0x00,0x01;
	.var = .LNvParTestInitialise.;
	.var = .LN.vParTestInitialise..end;
	.byte =
		0x01,0x01,0x00,0x16,0x00,0x00,0x00,0x00;
	.var = .LN1;
	.var = .LN.vParTestInitialise..end;
	.byte =
		0x17,0x67,0x70,0x69,0x6F,0x4D,0x65,0x6D,0x6F,0x72,0x79,0x00,
		0x01,0x0F,0x30,0x06,0x00,0x05,0x03;
	.var = gpioMemory.0.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x17,0x6E,0x75,0x6D,0x43,0x61,0x6C,
		0x6C,0x62,0x61,0x63,0x6B,0x73,0x00,0x01,0x04,0x05,0x00,0x00,
		0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x0C,0x1D,
		0x30,0x06,0x00,0xE7,0x04,0x00,0x00,0x0D,0x10,0x00,0x0F,0x00,
		0x14,0x5E,0x30,0x06,0x00,0x76,0x50,0x61,0x72,0x54,0x65,0x73,
		0x74,0x54,0x6F,0x67,0x67,0x6C,0x65,0x4C,0x45,0x44,0x00,0x01;
	.var = .LNvParTestToggleLED.;
	.var = .LN.vParTestToggleLED..end;
	.byte =
		0x01,0x01,0x00,0x15,0x75,0x78,0x4C,0x45,0x44,0x00,0xC8,0x0B,
		0x00,0x00,0x02,0x86,0x78,0x00,0x16,0x00,0x00,0x00,0x00;
	.var = .LN14;
	.var = .LN.vParTestToggleLED..end;
	.byte =
		0x00,0x00,0x17,0x44,0x41,0x49,0x5F,0x4C,0x45,0x44,0x5F,0x53,
		0x54,0x41,0x54,0x45,0x00,0x01,0x7D,0x30,0x06,0x00,0x05,0x03;
	.var = DAI_LED_STATE.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x0C,0x8B,0x30,0x06,0x00,0xA6,0x01,
		0x00,0x00,0x0D,0x02,0x00,0x01,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\src\ParTest.sbn", 405627, 2769;
	.var = .LNvParTestSetLED.;
	.byte =
		0x04,0x01,0x05,0x01,0x61,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.vParTestSetLED..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvParTestInitialise.;
	.byte =
		0x04,0x01,0x05,0x01,0x47,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x2D,0x0D,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x13,0x0B,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x35,0x0D,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x10,0x0B,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x06,0x0C,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vParTestInitialise..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvParTestToggleLED.;
	.byte =
		0x04,0x01,0x05,0x01,0x68,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x1C,0x0B,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x06,0x0A,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x06,0x0B,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x06,0x0C,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x06,0x0B,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x06,0x0C,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x10,0x0F,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vParTestToggleLED..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x4E,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x8D,0x30,0x06,0x00,0x57,0x2F,0x06,0x00,0x76,0x50,0x61,0x72,
		0x54,0x65,0x73,0x74,0x53,0x65,0x74,0x4C,0x45,0x44,0x00,0xA5,
		0x2F,0x06,0x00,0x76,0x50,0x61,0x72,0x54,0x65,0x73,0x74,0x49,
		0x6E,0x69,0x74,0x69,0x61,0x6C,0x69,0x73,0x65,0x00,0x1D,0x30,
		0x06,0x00,0x76,0x50,0x61,0x72,0x54,0x65,0x73,0x74,0x54,0x6F,
		0x67,0x67,0x6C,0x65,0x4C,0x45,0x44,0x00,0x00,0x00,0x00,0x00;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x2C,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNvParTestSetLED.;
	.var = .LN.vParTestSetLED..end-.LNvParTestSetLED.;
	.var = .LNvParTestInitialise.;
	.var = .LN.vParTestInitialise..end-.LNvParTestInitialise.;
	.var = .LNvParTestToggleLED.;
	.var = .LN.vParTestToggleLED..end-.LNvParTestToggleLED.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type DAI_LED_STATE.,STT_OBJECT;
	.byte DAI_LED_STATE.[] =
		0x00,0x00;
	.align 8;
	.type .sadigpi.1,STT_OBJECT;
	.byte .sadigpi.1[] =
		0x61,0x64,0x69,0x5F,0x67,0x70,0x69,0x6F,0x5F,0x49,0x6E,0x69,
		0x74,0x20,0x66,0x61,0x69,0x6C,0x65,0x64,0x0A,0x00;
	.align 8;
	.type .sadigpi.2,STT_OBJECT;
	.byte .sadigpi.2[] =
		0x61,0x64,0x69,0x5F,0x67,0x70,0x69,0x6F,0x5F,0x53,0x65,0x74,
		0x44,0x69,0x72,0x65,0x63,0x74,0x69,0x6F,0x6E,0x20,0x66,0x61,
		0x69,0x6C,0x65,0x64,0x0A,0x00;
