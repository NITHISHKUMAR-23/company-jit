	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\osal\adi_osal_freertos_arch_c.c";
//  Compilation time: Thu Oct 24 14:39:47 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\osal\SHARC_215xx -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\osal\SHARC_215xx\adi_osal_freertos_arch_c.d -o system\osal\SHARC_215xx\adi_osal_freertos_arch_c.doj
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

_adi_osal_stdWrapper.:
.LN_adi_osal_stdWrapper.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 536 bytes
//  Scratch registers used: {r0-r2,r4,r8,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//  Call preserved registers used: {r3,r5-r7,r9-r11,r13-r15,i0-i3,i5,i8-i11,i14-i15,b0-b3,b5,b8-b11,b14-b15,l0-l5,l8-l15,mode1stk,pcstk,curlcntr,laddr}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
	bit tst mode1stk 65536;
	if not tf jump (pc,.P35L2);

// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\osal\adi_osal_freertos_arch_c.c":113
	dm(i7,m7)=0;
	dm(i7,m7)=r0;
	r0=i6;
	i6=i7;
	dm(i7,m7)=r0;
	modify(i7,-134) (nw);
	dm(-5,i6)=mode1stk;
	dm(-4,i6)=pcstk;
	mode1stk=mode1;
	bit set mode1stk 4096;
	nop;                                    // Inserted to fix anomaly w_20000069. 
	dm(-58,i6)=r1;
	dm(-57,i6)=r2;
	dm(-56,i6)=r4;
	dm(-55,i6)=s0;
	dm(-54,i6)=s1;
	dm(-53,i6)=s2;
	dm(-52,i6)=s3;
	dm(-51,i6)=s4;
	dm(-50,i6)=s5;
	dm(-49,i6)=s6;
	dm(-48,i6)=s7;
	dm(-47,i6)=s8;
	dm(-46,i6)=s9;
	dm(-45,i6)=s10;
	dm(-44,i6)=s11;
	dm(-43,i6)=s12;
	dm(-42,i6)=s13;
	dm(-41,i6)=s14;
	dm(-40,i6)=s15;
	jump (pc,.P35L3);

.P35L2:
	px=r0;
	dm(i7,m7)=px1;
	dm(i7,m7)=px2;
	r0=i6;
	i6=i7;
	dm(i7,m7)=r0;
	modify(i7,-134) (nw);
	dm(-5,i6)=mode1stk;
	dm(-4,i6)=pcstk;
	bit tst mmask 65536;
	r0=mode1;
	r0=bset r0 by 12;
	if not tf r0=bset r0 by 16;
	mode1stk=r0;
	px=r1;
	dm(-116,i6)=px1;
	dm(-115,i6)=px2;
	px=r2;
	dm(-114,i6)=px1;
	dm(-113,i6)=px2;
	px=r3;
	dm(-112,i6)=px1;
	dm(-111,i6)=px2;
	px=r4;
	dm(-110,i6)=px1;
	dm(-109,i6)=px2;
	px=r5;
	dm(-108,i6)=px1;
	dm(-107,i6)=px2;
	px=r6;
	dm(-106,i6)=px1;
	dm(-105,i6)=px2;
	px=r7;
	dm(-104,i6)=px1;
	dm(-103,i6)=px2;
	px=r9;
	dm(-102,i6)=px1;
	dm(-101,i6)=px2;
	px=r10;
	dm(-100,i6)=px1;
	dm(-99,i6)=px2;
	px=r11;
	dm(-98,i6)=px1;
	dm(-97,i6)=px2;
	px=r13;
	dm(-96,i6)=px1;
	dm(-95,i6)=px2;
	px=r14;
	dm(-94,i6)=px1;
	dm(-93,i6)=px2;
	px=r15;
	dm(-92,i6)=px1;
	dm(-91,i6)=px2;
	px=s0;
	dm(-90,i6)=px1;
	dm(-89,i6)=px2;
	px=s1;
	dm(-88,i6)=px1;
	dm(-87,i6)=px2;
	px=s2;
	dm(-86,i6)=px1;
	dm(-85,i6)=px2;
	px=s3;
	dm(-84,i6)=px1;
	dm(-83,i6)=px2;
	px=s4;
	dm(-82,i6)=px1;
	dm(-81,i6)=px2;
	px=s5;
	dm(-80,i6)=px1;
	dm(-79,i6)=px2;
	px=s6;
	dm(-78,i6)=px1;
	dm(-77,i6)=px2;
	px=s7;
	dm(-76,i6)=px1;
	dm(-75,i6)=px2;
	px=s8;
	dm(-74,i6)=px1;
	dm(-73,i6)=px2;
	px=s9;
	dm(-72,i6)=px1;
	dm(-71,i6)=px2;
	px=s10;
	dm(-70,i6)=px1;
	dm(-69,i6)=px2;
	px=s11;
	dm(-68,i6)=px1;
	dm(-67,i6)=px2;
	px=s12;
	dm(-66,i6)=px1;
	dm(-65,i6)=px2;
	px=s13;
	dm(-64,i6)=px1;
	dm(-63,i6)=px2;
	px=s14;
	dm(-62,i6)=px1;
	dm(-61,i6)=px2;
	px=s15;
	dm(-60,i6)=px1;
	dm(-59,i6)=px2;

.P35L3:
	pop pcstk;
	pop sts;
	dm(-120,i6)=astat;
	dm(-119,i6)=astaty;
	dm(-118,i6)=stky;
	dm(-117,i6)=stkyy;
	r0=m4;
	dm(-39,i6)=r0;
	dm(-38,i6)=m12;
	r0=b4;
	dm(-37,i6)=r0;
	dm(-36,i6)=b12;
	dm(-35,i6)=b13;
	r0=i4;
	dm(-34,i6)=r0;
	dm(-33,i6)=i13;
	r0=l0;
	dm(-32,i6)=r0;
	r0=l1;
	dm(-31,i6)=r0;
	r0=l2;
	dm(-30,i6)=r0;
	r0=l3;
	dm(-29,i6)=r0;
	r0=l4;
	dm(-28,i6)=r0;
	r0=l5;
	dm(-27,i6)=r0;
	dm(-26,i6)=l8;
	dm(-25,i6)=l9;
	dm(-24,i6)=l10;
	dm(-23,i6)=l11;
	dm(-22,i6)=l12;
	dm(-21,i6)=l13;
	dm(-20,i6)=l14;
	dm(-19,i6)=l15;
	l0=0;
	l1=0;
	l2=0;
	l3=0;
	l4=0;
	l5=0;
	l8=0;
	l9=0;
	l10=0;
	l11=0;
	l12=0;
	l13=0;
	l14=0;
	l15=0;
	dm(-18,i6)=lcntr;
	bit set mode1 0x200000; nop;
		r0=mr0f;
		r1=mr1f;
		r2=mr2f;
		bit clr mode1 0x200000;
	nop;                                    // Inserted to fix anomaly exit_simd. 
	dm(-17,i6)=r0;
	dm(-16,i6)=r1;
	dm(-15,i6)=r2;
	dm(-14,i6)=s0;
	dm(-13,i6)=s1;
	dm(-12,i6)=s2;
	bit set mode1 0x200000; nop;
		r0=mr0b;
		r1=mr1b;
		r2=mr2b;
		bit clr mode1 0x200000;
	nop;                                    // Inserted to fix anomaly exit_simd. 
	dm(-11,i6)=r0;
	dm(-10,i6)=r1;
	dm(-9,i6)=r2;
	dm(-8,i6)=s0;
	dm(-7,i6)=s1;
	dm(-6,i6)=s2;
	i4=i7;
	modify(i4,14) (nw);
	r0=m5;

.P35L4:
//-------------------------------------------------------------------
//   Part of Loop 4, depth 1
//-------------------------------------------------------------------
	bit tst stky 67108864;
	dm(i4,m7)=laddr;
	dm(i4,m7)=curlcntr;
	if tf jump (pc,.P35L6);

	pop loop;
	r0=r0+1;
	jump (pc,.P35L4);

.P35L6:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
	dm(m6,i7)=r0;
	r0=i4;
	dm(2,i7)=r0;
	r2=r8;
	m4=r8;
	r8=r12;
	dm(m7,i6)=r12;
	dm(-2,i6)=r2;
	dm(-3,i6)=r4;
.LN0:
// line 114
	i4=_adi_osal_gHandlerTable.;
	i12=dm(m4,i4);
.LN1:
	r2=i6; i6=i7; jump (m13,i12) (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:

.LN2:
// line 115
	bit clr mode1 4096;

	i4=dm(2,i7);
	modify(i4,m6) (nw);
	r0=dm(m6,i7);
	r0=pass r0;

.P35L9:
//-------------------------------------------------------------------
//   Part of Loop 9, depth 1
//-------------------------------------------------------------------
	curlcntr=dm(i4,m6);
	laddr=dm(i4,m6);
	if eq jump (pc,.P35L11);

	push loop;
	r0=r0-1;
	jump (pc,.P35L9);

.P35L11:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------

	bit set mode1 4096;

	r0=dm(-5,i6);
	btst r0 by 16;
	r0=dm(-17,i6);
	r1=dm(-16,i6);
	r2=dm(-15,i6);
	s0=dm(-14,i6);
	s1=dm(-13,i6);
	s2=dm(-12,i6);
	bit set mode1 0x200000; nop;
		mr0f=r0;
		mr1f=r1;
		mr2f=r2;
		bit clr mode1 0x200000;
	nop;                                    // Inserted to fix anomaly exit_simd. 
	r0=dm(-11,i6);
	r1=dm(-10,i6);
	r2=dm(-9,i6);
	s0=dm(-8,i6);
	s1=dm(-7,i6);
	s2=dm(-6,i6);
	bit set mode1 0x200000; nop;
		mr0b=r0;
		mr1b=r1;
		mr2b=r2;
		bit clr mode1 0x200000;
	nop;                                    // Inserted to fix anomaly exit_simd. 
	if sz jump (pc,.P35L15);

	r1=dm(-58,i6);
	r2=dm(-57,i6);
	r4=dm(-56,i6);
	s0=dm(-55,i6);
	s1=dm(-54,i6);
	s2=dm(-53,i6);
	s3=dm(-52,i6);
	s4=dm(-51,i6);
	s5=dm(-50,i6);
	s6=dm(-49,i6);
	s7=dm(-48,i6);
	s8=dm(-47,i6);
	s9=dm(-46,i6);
	s10=dm(-45,i6);
	s11=dm(-44,i6);
	s12=dm(-43,i6);
	s13=dm(-42,i6);
	s14=dm(-41,i6);
	s15=dm(-40,i6);
	jump (pc,.P35L16);

.P35L15:
	px1=dm(-116,i6);
	px2=dm(-115,i6);
	r1=px;
	px1=dm(-114,i6);
	px2=dm(-113,i6);
	r2=px;
	px1=dm(-112,i6);
	px2=dm(-111,i6);
	r3=px;
	px1=dm(-110,i6);
	px2=dm(-109,i6);
	r4=px;
	px1=dm(-108,i6);
	px2=dm(-107,i6);
	r5=px;
	px1=dm(-106,i6);
	px2=dm(-105,i6);
	r6=px;
	px1=dm(-104,i6);
	px2=dm(-103,i6);
	r7=px;
	px1=dm(-102,i6);
	px2=dm(-101,i6);
	r9=px;
	px1=dm(-100,i6);
	px2=dm(-99,i6);
	r10=px;
	px1=dm(-98,i6);
	px2=dm(-97,i6);
	r11=px;
	px1=dm(-96,i6);
	px2=dm(-95,i6);
	r13=px;
	px1=dm(-94,i6);
	px2=dm(-93,i6);
	r14=px;
	px1=dm(-92,i6);
	px2=dm(-91,i6);
	r15=px;
	px1=dm(-90,i6);
	px2=dm(-89,i6);
	s0=px;
	px1=dm(-88,i6);
	px2=dm(-87,i6);
	s1=px;
	px1=dm(-86,i6);
	px2=dm(-85,i6);
	s2=px;
	px1=dm(-84,i6);
	px2=dm(-83,i6);
	s3=px;
	px1=dm(-82,i6);
	px2=dm(-81,i6);
	s4=px;
	px1=dm(-80,i6);
	px2=dm(-79,i6);
	s5=px;
	px1=dm(-78,i6);
	px2=dm(-77,i6);
	s6=px;
	px1=dm(-76,i6);
	px2=dm(-75,i6);
	s7=px;
	px1=dm(-74,i6);
	px2=dm(-73,i6);
	s8=px;
	px1=dm(-72,i6);
	px2=dm(-71,i6);
	s9=px;
	px1=dm(-70,i6);
	px2=dm(-69,i6);
	s10=px;
	px1=dm(-68,i6);
	px2=dm(-67,i6);
	s11=px;
	px1=dm(-66,i6);
	px2=dm(-65,i6);
	s12=px;
	px1=dm(-64,i6);
	px2=dm(-63,i6);
	s13=px;
	px1=dm(-62,i6);
	px2=dm(-61,i6);
	s14=px;
	px1=dm(-60,i6);
	px2=dm(-59,i6);
	s15=px;
	jump (pc,.P35L16);

.P35L16:
	m4=dm(-39,i6);
	m12=dm(-38,i6);
	b4=dm(-37,i6);
	b12=dm(-36,i6);
	b13=dm(-35,i6);
	i4=dm(-34,i6);
	i13=dm(-33,i6);
	l0=dm(-32,i6);
	l1=dm(-31,i6);
	l2=dm(-30,i6);
	l3=dm(-29,i6);
	l4=dm(-28,i6);
	l5=dm(-27,i6);
	l8=dm(-26,i6);
	l9=dm(-25,i6);
	l10=dm(-24,i6);
	l11=dm(-23,i6);
	l12=dm(-22,i6);
	l13=dm(-21,i6);
	l14=dm(-20,i6);
	l15=dm(-19,i6);
	lcntr=dm(-18,i6);
	astat=dm(-120,i6);
	astaty=dm(-119,i6);
	stky=dm(-118,i6);
	stkyy=dm(-117,i6);
	bit clr mode1 4096;
	push sts;
	push pcstk;
	mode1stk=dm(-5,i6);
	nop;                                    // Inserted to fix anomaly w_20000069. 
	pcstk=dm(-4,i6);
	nop;                                    // Inserted to fix anomaly w_20000069. 
	px2=dm(m6,i6);
	px1=dm(2,i6);
	r0=px;
	rts (db); modify(i7,137) (nw); i6=dm(0,i6);
.LN._adi_osal_stdWrapper..end:
._adi_osal_stdWrapper..end:
	.global _adi_osal_stdWrapper.;
	.type _adi_osal_stdWrapper.,STT_FUNC;

adi_osal_InstallHandler.:
.LNadi_osal_InstallHandler.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0,r2,r4,r8,i4,i12,m4,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\osal\adi_osal_freertos_arch_c.c":66
	modify(i7,-6) (nw);
	dm(-4,i6)=r12;
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
.LN3:
// line 79
	r8=_adi_osal_stdWrapper.;
	cjump adi_rtl_register_dispatched_handler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN4:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN5:
// line 83
	if ge jump (pc,.P36L2);

.LN6:
// line 86
	dm(-2,i6)=m14;
	jump (pc,.P36L4);

.P36L2:
.LN7:
// line 89
	r2=dm(_adi_osal_gHandlerTableSize.);
	comp(r0,r2);
	if lt jump (pc,.P36L7);

.LN8:
// line 94
	r4=dm(-6,i6);
.LN9:
	cjump adi_rtl_unregister_dispatched_handler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
.LN10:
// line 95
	dm(-2,i6)=m14;
	jump (pc,.P36L4);

.P36L7:
.LN11:
// line 98
	r2=dm(-5,i6);
	m4=r0;
	i4=_adi_osal_gHandlerTable.;
	dm(m4,i4)=r2;
.LN12:
// line 99
	dm(-2,i6)=m13;

.P36L4:
.LN13:
// line 100
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_InstallHandler..end:
.adi_osal_InstallHandler..end:
	.global adi_osal_InstallHandler.;
	.type adi_osal_InstallHandler.,STT_FUNC;

	.file_attr libGroup="adi_osal.h";
	.file_attr libName="libosal";
	.file_attr prefersMem="internal";
	.file_attr prefersMemNum="30";
	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="_adi_osal_stdWrapper.";
	.file_attr FuncName="_adi_osal_IsMemoryAligned.";
	.file_attr FuncName="_adi_osal_IsCurrentLevelISR.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="adi_osal_InstallHandler.";
	.file_attr Encoding="SW";
	.file_attr Content="Code";
.epctext.end:

	.extern adi_rtl_register_dispatched_handler.;
	.type adi_rtl_register_dispatched_handler.,STT_FUNC;
	.extern adi_rtl_unregister_dispatched_handler.;
	.type adi_rtl_unregister_dispatched_handler.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\osal\SHARC_215xx\adi_osal_freertos_arch_c.sbn", 0, 302;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x41,0x1F,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x70,0x6F,0x72,0x74,0x61,0x62,0x6C,0x65,0x5C,0x43,
		0x43,0x45,0x53,0x5C,0x53,0x48,0x41,0x52,0x43,0x5F,0x32,0x31,
		0x35,0x78,0x78,0x5C,0x6F,0x73,0x61,0x6C,0x5C,0x61,0x64,0x69,
		0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x66,0x72,0x65,0x65,0x72,0x74,
		0x6F,0x73,0x5F,0x61,0x72,0x63,0x68,0x5F,0x63,0x2E,0x63,0x00,
		0x0C;
	.var = .epcline;
	.inc/binary ".\system\osal\SHARC_215xx\adi_osal_freertos_arch_c.sbn", 302, 7570;
	.var = .LN_adi_osal_stdWrapper.;
	.var = .LN._adi_osal_stdWrapper..end;
	.byte =
		0x01,0x01,0x00,0x13,0x69,0x69,0x64,0x00,0x32,0x05,0x00,0x00,
		0x02,0x86,0x74,0x00,0x13,0x69,0x6E,0x64,0x65,0x78,0x00,0x07,
		0x05,0x00,0x00,0x02,0x86,0x78,0x00,0x13,0x61,0x72,0x67,0x00,
		0xCB,0x0B,0x00,0x00,0x02,0x86,0x7C,0x00,0x14,0x00,0x00,0x00,
		0x00;
	.var = .LN0;
	.var = .LN._adi_osal_stdWrapper..end;
	.byte =
		0x00,0x00,0x15,0xDB,0x1E,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x49,0x6E,0x73,0x74,0x61,0x6C,0x6C,0x48,
		0x61,0x6E,0x64,0x6C,0x65,0x72,0x00,0x01;
	.var = .LNadi_osal_InstallHandler.;
	.var = .LN.adi_osal_InstallHandler..end;
	.byte =
		0x01,0x29,0x18,0x00,0x00,0x01,0x00,0x13,0x69,0x69,0x64,0x00,
		0x32,0x05,0x00,0x00,0x02,0x86,0x68,0x00,0x13,0x68,0x69,0x67,
		0x68,0x4C,0x65,0x76,0x65,0x6C,0x48,0x61,0x6E,0x64,0x6C,0x65,
		0x72,0x00,0x73,0x1D,0x00,0x00,0x02,0x86,0x6C,0x00,0x13,0x68,
		0x61,0x6E,0x64,0x6C,0x65,0x72,0x41,0x72,0x67,0x00,0xF6,0x03,
		0x00,0x00,0x02,0x86,0x70,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN3;
	.var = .LN.adi_osal_InstallHandler..end;
	.byte =
		0x16,0x69,0x6E,0x64,0x65,0x78,0x00,0x01,0x07,0x05,0x00,0x00,
		0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,0x5F,
		0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x67,0x48,0x61,
		0x6E,0x64,0x6C,0x65,0x72,0x54,0x61,0x62,0x6C,0x65,0x00,0x01,
		0x31,0x1F,0x00,0x00,0x05,0x03;
	.var = _adi_osal_gHandlerTable.;
	.byte =
		0x00,0x00,0x00,0x00,0x01,0x16,0x5F,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x67,0x48,0x61,0x6E,0x64,0x6C,0x65,0x72,
		0x54,0x61,0x62,0x6C,0x65,0x53,0x69,0x7A,0x65,0x00,0x01,0x32,
		0x05,0x00,0x00,0x05,0x03;
	.var = _adi_osal_gHandlerTableSize.;
	.byte =
		0x00,0x00,0x00,0x00,0x01,0x0C,0x43,0x1F,0x00,0x00,0x73,0x1D,
		0x00,0x00,0x0D,0x00,0x00,0xFF,0xFF,0xFF,0xFF,0x0F,0x00,0x00,
		0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\osal\SHARC_215xx\adi_osal_freertos_arch_c.sbn", 7872, 2327;
	.var = .LN_adi_osal_stdWrapper.;
	.byte =
		0x04,0x01,0x05,0x01,0x79,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x22,0x01,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN._adi_osal_stdWrapper..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_InstallHandler.;
	.byte =
		0x04,0x01,0x05,0x01,0x4A,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x31,0x16,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x2F,0x01,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_InstallHandler..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x43,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x45,0x1F,0x00,0x00,0xF2,0x1D,0x00,0x00,0x5F,0x61,0x64,0x69,
		0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x73,0x74,0x64,0x57,0x72,0x61,
		0x70,0x70,0x65,0x72,0x00,0x50,0x1E,0x00,0x00,0x61,0x64,0x69,
		0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x49,0x6E,0x73,0x74,0x61,0x6C,
		0x6C,0x48,0x61,0x6E,0x64,0x6C,0x65,0x72,0x00,0x00,0x00,0x00,
		0x00;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x24,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LN_adi_osal_stdWrapper.;
	.var = .LN._adi_osal_stdWrapper..end-.LN_adi_osal_stdWrapper.;
	.var = .LNadi_osal_InstallHandler.;
	.var = .LN.adi_osal_InstallHandler..end-.LNadi_osal_InstallHandler.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;


	.extern _adi_osal_gHandlerTable.;
	.type _adi_osal_gHandlerTable.,STT_OBJECT;
	.extern _adi_osal_gHandlerTableSize.;
	.type _adi_osal_gHandlerTableSize.,STT_OBJECT;
