	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c";
//  Compilation time: Thu Oct 24 14:39:56 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\FreeRTOS\portable -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\FreeRTOS\portable\port.d -o system\FreeRTOS\portable\port.doj
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

vPortValidateInterruptPriority.:
.LNvPortValidateInterruptPriority.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
.LN0:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c":476
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vPortValidateInterruptPriority..end:
.vPortValidateInterruptPriority..end:
	.global vPortValidateInterruptPriority.;
	.type vPortValidateInterruptPriority.,STT_FUNC;

vPortFixupStack.:
.LNvPortFixupStack.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r1-r2,r12,i4,i12,acc,scc}
//  Call preserved registers used: {r11}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c":389
	modify(i7,-8) (nw);
	dm(-8,i6)=r11;
	i4=r4;
	dm(-6,i6)=r8;
	dm(-7,i6)=r4;
.LN1:
// line 391
	dm(-4,i6)=m13;
.LN2:
// line 392
	dm(-3,i6)=m13;
.LN3:
// line 393
	dm(-2,i6)=m13;
.LN4:
// line 390
	dm(-5,i6)=r4;
.LN5:
// line 395
	i4=modify(i4,16);
	r2=i4;
	dm(-5,i6)=r2;
.LN6:
// line 396
	dm(-4,i6)=r2;
.LN7:
// line 404
	r2=dm(89,i4);
	dm(-3,i6)=r2;
.LN8:
// line 405
	r2=r2-r8;
	r11=ashift r2 by -2;
	r2=r11+1;
	dm(-2,i6)=r2;
.LN9:
// line 412
	r12=2;
	r2=r11+r12;
	r1=m5;
	r2=bclr r2 by r1;
	dm(-2,i6)=r2;
.LN10:
// line 418
	dm(89,i4)=r8;
.LN11:
// line 419
	r2=dm(-6,i6);
	i4=dm(-4,i6);
	dm(90,i4)=r2;
.LN12:
// line 420
	r2=dm(-2,i6);
	i4=dm(-4,i6);
	dm(108,i4)=r2;
.LN13:
// line 421
	r2=dm(-2,i6);
	i4=dm(-4,i6);
	dm(107,i4)=r2;
.LN14:
// line 422
	r11=dm(-8,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vPortFixupStack..end:
.vPortFixupStack..end:
	.global vPortFixupStack.;
	.type vPortFixupStack.,STT_FUNC;

vPortClearInterruptMask.:
.LNvPortClearInterruptMask.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c":369
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;
	r2=pass r4;
.LN15:
// line 370
	if ne jump (pc,.P37L2);


.LN16:
// line 372
	bit set mode1 4096;

.LN17:
// line 373
	jump (pc,.P37L3);

.P37L2:

.P37L3:
.LN18:
// line 374
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vPortClearInterruptMask..end:
.vPortClearInterruptMask..end:
	.global vPortClearInterruptMask.;
	.type vPortClearInterruptMask.,STT_FUNC;

ulPortSetInterruptMask.:
.LNulPortSetInterruptMask.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,i12,acc,btf}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c":356
	modify(i7,-2) (nw);

.LN19:
// line 357
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	dm(-2,i6)=r2;

.LN20:
// line 359
	// ASM STATEMENT
	JUMP (PC, .SH_INT_DISABLED) (DB);  
                                   BIT CLR MODE1 0x1000;     
                                   NOP;                                      
                                   .SH_INT_DISABLED: 
	// END ASM STATEMENT

.LN21:
// line 364
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.ulPortSetInterruptMask..end:
.ulPortSetInterruptMask..end:
	.global ulPortSetInterruptMask.;
	.type ulPortSetInterruptMask.,STT_FUNC;

pxPortInitialiseStack.:
.LNpxPortInitialiseStack.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c":200
	modify(i7,-6) (nw);
	i12=r4;
	dm(-5,i6)=r12;
	dm(-6,i6)=r8;
	dm(-7,i6)=r4;
.LN22:
// line 204
	dm(-4,i6)=m13;
.LN23:
// line 205
	dm(-3,i6)=m13;
.LN24:
// line 206
	dm(-2,i6)=m13;
.LN25:
// line 208
	r2=-16;
	r2=r4+r2;
	dm(-7,i6)=r2;
.LN26:
// line 209
	dm(-4,i6)=r2;
.LN27:
// line 210
	i12=modify(i12,-24);
	dm(-7,i6)=i12;
.LN28:
// line 213
	dm(-3,i6)=i12;
.LN29:
// line 214
	i12=modify(i12,-516);
	r4=i12;
	dm(-3,i6)=i12;
.LN30:
// line 216
	dm(-2,i6)=i12;
.LN31:
// line 217
	i12=modify(i12,-16);
	dm(-2,i6)=i12;
.LN32:
// line 220
	r12=516;
	r8=m5;
	cjump __simd_memsetD. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
.LN33:
// line 221
	r4=dm(-2,i6);
.LN34:
	r12=16;
	r8=m5;
	cjump __simd_memsetD. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN35:
// line 224
	r2=dm(-7,i6);
	i4=dm(-3,i6);
	dm(89,i4)=r2;
.LN36:
// line 225
	r2=dm(-7,i6);
	i4=dm(-3,i6);
	dm(90,i4)=r2;
.LN37:
// line 228
	i4=dm(-3,i6);
	dm(73,i4)=m14;
.LN38:
// line 229
	i4=dm(-3,i6);
	dm(74,i4)=m15;
.LN39:
// line 230
	i4=dm(-3,i6);
	dm(81,i4)=m14;
.LN40:
// line 231
	i4=dm(-3,i6);
	dm(82,i4)=m15;
.LN41:
// line 234
	r2=dm(-5,i6);
	i4=dm(-3,i6);
	dm(4,i4)=r2;
.LN42:
// line 237
	r2=dm(-6,i6);
	i4=dm(-2,i6);
	dm(3,i4)=r2;
.LN43:
// line 238
	i4=dm(-2,i6);
	dm(2,i4)=m14;

.LN44:
// line 241
	r2=mode1;

	r1=-14738680;
	r2=r2 and r1;
	r1=16848120;
	r2=r2 or r1;
	i4=dm(-3,i6);
	dm(122,i4)=r2;
.LN45:
// line 244
	r2=dm(-4,i6);
	i4=dm(-3,i6);
	dm(58,i4)=r2;
.LN46:
// line 247
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.pxPortInitialiseStack..end:
.pxPortInitialiseStack..end:
	.global pxPortInitialiseStack.;
	.type pxPortInitialiseStack.,STT_FUNC;

prvTaskExitError.:
.LNprvTaskExitError.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r4,r8}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------

.LN47:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c":259
	r8=259;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:

.LN48:
// line 260
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:

.P42L4:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c" line 261 col 2
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 3 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used   1 out of    3 ( 33.3%)
//     multifunction alu               used   1 out of    3 ( 33.3%)
//     multifunction float multiply    used   1 out of    3 ( 33.3%)
//     multifunction integer add sub   used   1 out of    3 ( 33.3%)
//     multifunction integer multiply  used   1 out of    3 ( 33.3%)
//     multifunction mult              used   1 out of    3 ( 33.3%)
//     pm dag                          used   1 out of    3 ( 33.3%)
//     shift immediate                 used   1 out of    3 ( 33.3%)
//     memory access                   used   1 out of    6 ( 16.7%)
//-------------------------------------------------------------------
	// -- 2 stalls --
	jump (pc,.P42L4);
//-------------------------------------------------------------------
//   End Loop L4
//-------------------------------------------------------------------
.LN.prvTaskExitError..end:
.prvTaskExitError..end:
	.type prvTaskExitError.,STT_FUNC;

vPortEndScheduler.:
.LNvPortEndScheduler.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r4,r8,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------

.LN49:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c":337
	r8=337;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:

.LN50:
// line 338
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vPortEndScheduler..end:
.vPortEndScheduler..end:
	.global vPortEndScheduler.;
	.type vPortEndScheduler.,STT_FUNC;

vPortEnterCritical.:
.LNvPortEnterCritical.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN51:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c":345
	cjump adi_rtl_disable_interrupts. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
.LN52:
// line 346
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vPortEnterCritical..end:
.vPortEnterCritical..end:
	.global vPortEnterCritical.;
	.type vPortEnterCritical.,STT_FUNC;

vPortExitCritical.:
.LNvPortExitCritical.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN53:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c":351
	cjump adi_rtl_reenable_interrupts. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
.LN54:
// line 352
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vPortExitCritical..end:
.vPortExitCritical..end:
	.global vPortExitCritical.;
	.type vPortExitCritical.,STT_FUNC;

xPortSysTickHandler.:
.LNxPortSysTickHandler.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 536 bytes
//  Scratch registers used: {r0-r2,r4,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//  Call preserved registers used: {r3,r5-r7,r9-r11,r13-r15,i0-i3,i5,i8-i11,i14-i15,b0-b3,b5,b8-b11,b14-b15,l0-l5,l8-l15,mode1stk,pcstk,curlcntr,laddr}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
	bit tst mode1stk 65536;
	if not tf jump (pc,.P49L5);

// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c":378
	dm(i7,m7)=0;
	dm(i7,m7)=r0;
	r0=i6;
	i6=i7;
	dm(i7,m7)=r0;
	modify(i7,-134) (nw);
	dm(-5,i6)=mode1stk;
	dm(-4,i6)=pcstk;
	mode1stk=mode1;
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
	jump (pc,.P49L6);

.P49L5:
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

.P49L6:
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

.P49L7:
//-------------------------------------------------------------------
//   Part of Loop 7, depth 1
//-------------------------------------------------------------------
	bit tst stky 67108864;
	dm(i4,m7)=laddr;
	dm(i4,m7)=curlcntr;
	if tf jump (pc,.P49L9);

	pop loop;
	r0=r0+1;
	jump (pc,.P49L7);

.P49L9:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
	dm(m6,i7)=r0;
	r0=i4;
	dm(2,i7)=r0;
	dm(m7,i6)=r12;
	dm(-2,i6)=r8;
	dm(-3,i6)=r4;
.LN55:
// line 380
	cjump xTaskIncrementTick. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
	r12=pass r0;
.LN56:
	if eq jump (pc,.P49L2);

.LN57:
// line 383
	r12=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r12;
.LN58:
// line 384
	jump (pc,.P49L3);

.P49L2:

.P49L3:
.LN59:
// line 385
	i4=dm(2,i7);
	modify(i4,m6) (nw);
	r0=dm(m6,i7);
	r0=pass r0;

.P49L10:
//-------------------------------------------------------------------
//   Part of Loop 10, depth 1
//-------------------------------------------------------------------
	curlcntr=dm(i4,m6);
	laddr=dm(i4,m6);
	if eq jump (pc,.P49L12);

	push loop;
	r0=r0-1;
	jump (pc,.P49L10);

.P49L12:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
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
	if sz jump (pc,.P49L14);

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
	jump (pc,.P49L15);

.P49L14:
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
	jump (pc,.P49L15);

.P49L15:
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
.LN.xPortSysTickHandler..end:
.xPortSysTickHandler..end:
	.global xPortSysTickHandler.;
	.type xPortSysTickHandler.,STT_FUNC;

vPortSetupTimerInterrupt.:
.LNvPortSetupTimerInterrupt.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,r4,r8,r12,i12}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c":444
	modify(i7,-2) (nw);
	dm(-3,i6)=r15;
.LN60:
// line 446
	i12=1000000;
	dm(-2,i6)=i12;

.LN61:
// line 456
	bit clr mode2 32;

.LN62:
// line 457
	r2=dm(-2,i6);

	// ASM STATEMENT
	TPERIOD=r2;
TCOUNT=r2;
	// END ASM STATEMENT

.LN63:
// line 460
	r12=m5;
	r8=xPortSysTickHandler.;
	r15=369098765;
	r4=r15;
	cjump adi_rtl_register_dispatched_handler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
.LN64:
// line 461
	r4=r15;
	cjump adi_rtl_activate_dispatched_handler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ9-1;
.LCJ9:

.LN65:
// line 463
	bit set mode2 32;

.LN66:
// line 464
	r15=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vPortSetupTimerInterrupt..end:
.vPortSetupTimerInterrupt..end:
	.weak .vPortSetupTimerInterrupt..end;
	.weak vPortSetupTimerInterrupt.;
	.type vPortSetupTimerInterrupt.,STT_FUNC;

xPortStartScheduler.:
.LNxPortStartScheduler.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,r4,r8,r12,i4,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//Inlined in xPortStartScheduler.:
//  D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c:303:75'adi_core_id.
//-------------------------------------------------------------------

.LN67:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\port.c":277
	bit set mmask 1272;

.LN68:
// line 289
	i4=35;
	dm(_adi_OSRescheduleIntID.)=i4;
.LN69:
// line 302
	r8=_adi_SoftIntTaskSw.;
	r4=35;
	r12=m5;
	cjump adi_rtl_register_dispatched_handler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ10-1;
.LCJ10:
.LN70:
// line 303
	r4=dm(_adi_OSRescheduleIntID.);
.LN71:
	r8=m5;
	cjump adi_sec_SetCoreID. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ11-1;
.LCJ11:
.LN72:
// line 304
	r4=dm(_adi_OSRescheduleIntID.);
.LN73:
	r8=m6;
	cjump adi_sec_EnableSource. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ12-1;
.LCJ12:
.LN74:
// line 305
	r4=dm(_adi_OSRescheduleIntID.);
.LN75:
	r8=m6;
	cjump adi_sec_EnableInterrupt. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ13-1;
.LCJ13:
.LN76:
// line 306
	r4=dm(_adi_OSRescheduleIntID.);
.LN77:
	cjump adi_rtl_activate_dispatched_handler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ14-1;
.LCJ14:
.LN78:
// line 317
	cjump vPortSetupTimerInterrupt. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ15-1;
.LCJ15:
.LN79:
// line 320
	cjump prvPortStartFirstTask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ16-1;
.LCJ16:
.LN80:
// line 326
	cjump prvTaskExitError. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ17-1;
.LCJ17:
.LN81:
// line 329
	r0=m5;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xPortStartScheduler..end:
.xPortStartScheduler..end:
	.global xPortStartScheduler.;
	.type xPortStartScheduler.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="vPortValidateInterruptPriority.";
	.file_attr FuncName="vPortFixupStack.";
	.file_attr FuncName="vPortClearInterruptMask.";
	.file_attr FuncName="ulPortSetInterruptMask.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="adi_core_id.";
	.file_attr FuncName="pxPortInitialiseStack.";
	.file_attr FuncName="prvTaskExitError.";
	.file_attr FuncName="vPortEndScheduler.";
	.file_attr FuncName="vPortEnterCritical.";
	.file_attr FuncName="vPortExitCritical.";
	.file_attr FuncName="xPortSysTickHandler.";
	.file_attr FuncName="vPortSetupTimerInterrupt.";
	.file_attr FuncName="xPortStartScheduler.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern __simd_memsetD.;
	.type __simd_memsetD.,STT_FUNC;
	.extern vAssertCalled.;
	.type vAssertCalled.,STT_FUNC;
	.extern adi_rtl_disable_interrupts.;
	.type adi_rtl_disable_interrupts.,STT_FUNC;
	.extern adi_rtl_reenable_interrupts.;
	.type adi_rtl_reenable_interrupts.,STT_FUNC;
	.extern xTaskIncrementTick.;
	.type xTaskIncrementTick.,STT_FUNC;
	.extern adi_rtl_register_dispatched_handler.;
	.type adi_rtl_register_dispatched_handler.,STT_FUNC;
	.extern adi_rtl_activate_dispatched_handler.;
	.type adi_rtl_activate_dispatched_handler.,STT_FUNC;
	.extern _adi_SoftIntTaskSw.;
	.type _adi_SoftIntTaskSw.,STT_FUNC;
	.extern adi_sec_SetCoreID.;
	.type adi_sec_SetCoreID.,STT_FUNC;
	.extern adi_sec_EnableSource.;
	.type adi_sec_EnableSource.,STT_FUNC;
	.extern adi_sec_EnableInterrupt.;
	.type adi_sec_EnableInterrupt.,STT_FUNC;
	.extern prvPortStartFirstTask.;
	.type prvPortStartFirstTask.,STT_FUNC;

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type .epcdata,STT_OBJECT;
.epc.disable.ipa:
	.type .epc.disable.ipa,STT_OBJECT;
	.byte .epcdata[1];

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\FreeRTOS\portable\port.sbn", 0, 324;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0xD0,0x2B,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x70,0x6F,0x72,0x74,0x61,0x62,0x6C,0x65,0x5C,0x43,
		0x43,0x45,0x53,0x5C,0x53,0x48,0x41,0x52,0x43,0x5F,0x32,0x31,
		0x35,0x78,0x78,0x5C,0x70,0x6F,0x72,0x74,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\FreeRTOS\portable\port.sbn", 324, 10008;
	.var = .LNvPortValidateInterruptPriority.;
	.var = .LN.vPortValidateInterruptPriority..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.vPortValidateInterruptPriority..end;
	.byte =
		0x00,0x00,0x13,0x45,0x28,0x00,0x00,0x76,0x50,0x6F,0x72,0x74,
		0x46,0x69,0x78,0x75,0x70,0x53,0x74,0x61,0x63,0x6B,0x00,0x01;
	.var = .LNvPortFixupStack.;
	.var = .LN.vPortFixupStack..end;
	.byte =
		0x01,0x01,0x00,0x15,0x73,0x74,0x61,0x63,0x6B,0x54,0x6F,0x70,
		0x00,0x56,0x28,0x00,0x00,0x02,0x86,0x64,0x00,0x15,0x73,0x74,
		0x61,0x63,0x6B,0x42,0x61,0x73,0x65,0x00,0xAC,0x25,0x00,0x00,
		0x02,0x86,0x68,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN1;
	.var = .LN.vPortFixupStack..end;
	.byte =
		0x16,0x70,0x53,0x74,0x6B,0x00,0x01,0x4B,0x28,0x00,0x00,0x02,
		0x86,0x6C,0x00,0x00,0x00,0x00,0x00,0x16,0x70,0x52,0x65,0x63,
		0x00,0x01,0x45,0x28,0x00,0x00,0x02,0x86,0x70;
	.var = .LN4-.LNvPortFixupStack.;
	.byte =
		0x00,0x16,0x70,0x78,0x54,0x6F,0x70,0x4F,0x66,0x53,0x74,0x61,
		0x63,0x6B,0x00,0x01,0xAC,0x25,0x00,0x00,0x02,0x86,0x74;
	.var = .LN4-.LNvPortFixupStack.;
	.byte =
		0x00,0x16,0x75,0x6C,0x53,0x74,0x61,0x63,0x6B,0x44,0x65,0x70,
		0x74,0x68,0x00,0x01,0x22,0x06,0x00,0x00,0x02,0x86,0x78;
	.var = .LN4-.LNvPortFixupStack.;
	.byte =
		0x00,0x00,0x00,0x07,0x00,0x7D,0x19,0x00,0x00,0x07,0x00,0xEE,
		0x19,0x00,0x00,0x0F,0x38,0x1A,0x00,0x00,0x07,0x00,0x51,0x28,
		0x00,0x00,0x13,0xAC,0x28,0x00,0x00,0x76,0x50,0x6F,0x72,0x74,
		0x43,0x6C,0x65,0x61,0x72,0x49,0x6E,0x74,0x65,0x72,0x72,0x75,
		0x70,0x74,0x4D,0x61,0x73,0x6B,0x00,0x01;
	.var = .LNvPortClearInterruptMask.;
	.var = .LN.vPortClearInterruptMask..end;
	.byte =
		0x01,0x01,0x00,0x15,0x75,0x6C,0x4E,0x65,0x77,0x4D,0x61,0x73,
		0x6B,0x56,0x61,0x6C,0x75,0x65,0x00,0x22,0x06,0x00,0x00,0x02,
		0x86,0x78,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN15;
	.var = .LN.vPortClearInterruptMask..end;
	.byte =
		0x00,0x00,0x17,0xFB,0x28,0x00,0x00,0x75,0x6C,0x50,0x6F,0x72,
		0x74,0x53,0x65,0x74,0x49,0x6E,0x74,0x65,0x72,0x72,0x75,0x70,
		0x74,0x4D,0x61,0x73,0x6B,0x00,0x01;
	.var = .LNulPortSetInterruptMask.;
	.var = .LN.ulPortSetInterruptMask..end;
	.byte =
		0x01,0x22,0x06,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN19;
	.var = .LN.ulPortSetInterruptMask..end;
	.byte =
		0x16,0x73,0x74,0x61,0x74,0x65,0x00,0x01,0x22,0x06,0x00,0x00,
		0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x17,0xAB,
		0x29,0x00,0x00,0x70,0x78,0x50,0x6F,0x72,0x74,0x49,0x6E,0x69,
		0x74,0x69,0x61,0x6C,0x69,0x73,0x65,0x53,0x74,0x61,0x63,0x6B,
		0x00,0x01;
	.var = .LNpxPortInitialiseStack.;
	.var = .LN.pxPortInitialiseStack..end;
	.byte =
		0x01,0xAC,0x25,0x00,0x00,0x01,0x00,0x15,0x70,0x78,0x54,0x6F,
		0x70,0x4F,0x66,0x53,0x74,0x61,0x63,0x6B,0x00,0xAC,0x25,0x00,
		0x00,0x02,0x86,0x64,0x00,0x15,0x70,0x78,0x43,0x6F,0x64,0x65,
		0x00,0x23,0x1A,0x00,0x00,0x02,0x86,0x68,0x00,0x15,0x70,0x76,
		0x50,0x61,0x72,0x61,0x6D,0x65,0x74,0x65,0x72,0x73,0x00,0xDD,
		0x03,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN22;
	.var = .LN.pxPortInitialiseStack..end;
	.byte =
		0x16,0x73,0x74,0x6B,0x49,0x36,0x00,0x01,0xAC,0x25,0x00,0x00,
		0x02,0x86,0x70;
	.var = .LN22-.LNpxPortInitialiseStack.;
	.byte =
		0x00,0x16,0x70,0x52,0x65,0x63,0x00,0x01,0x45,0x28,0x00,0x00,
		0x02,0x86,0x74;
	.var = .LN23-.LNpxPortInitialiseStack.;
	.byte =
		0x00,0x16,0x70,0x53,0x74,0x6B,0x00,0x01,0x4B,0x28,0x00,0x00,
		0x02,0x86,0x78;
	.var = .LN24-.LNpxPortInitialiseStack.;
	.byte =
		0x00,0x00,0x00,0x13,0xDC,0x29,0x00,0x00,0x70,0x72,0x76,0x54,
		0x61,0x73,0x6B,0x45,0x78,0x69,0x74,0x45,0x72,0x72,0x6F,0x72,
		0x00,0x01;
	.var = .LNprvTaskExitError.;
	.var = .LN.prvTaskExitError..end;
	.byte =
		0x01,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN47;
	.var = .LN.prvTaskExitError..end;
	.byte =
		0x00,0x00,0x13,0x0E,0x2A,0x00,0x00,0x76,0x50,0x6F,0x72,0x74,
		0x45,0x6E,0x64,0x53,0x63,0x68,0x65,0x64,0x75,0x6C,0x65,0x72,
		0x00,0x01;
	.var = .LNvPortEndScheduler.;
	.var = .LN.vPortEndScheduler..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN49;
	.var = .LN.vPortEndScheduler..end;
	.byte =
		0x00,0x00,0x13,0x41,0x2A,0x00,0x00,0x76,0x50,0x6F,0x72,0x74,
		0x45,0x6E,0x74,0x65,0x72,0x43,0x72,0x69,0x74,0x69,0x63,0x61,
		0x6C,0x00,0x01;
	.var = .LNvPortEnterCritical.;
	.var = .LN.vPortEnterCritical..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN51;
	.var = .LN.vPortEnterCritical..end;
	.byte =
		0x00,0x00,0x13,0x73,0x2A,0x00,0x00,0x76,0x50,0x6F,0x72,0x74,
		0x45,0x78,0x69,0x74,0x43,0x72,0x69,0x74,0x69,0x63,0x61,0x6C,
		0x00,0x01;
	.var = .LNvPortExitCritical.;
	.var = .LN.vPortExitCritical..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN53;
	.var = .LN.vPortExitCritical..end;
	.byte =
		0x00,0x00,0x13,0xC8,0x2A,0x00,0x00,0x78,0x50,0x6F,0x72,0x74,
		0x53,0x79,0x73,0x54,0x69,0x63,0x6B,0x48,0x61,0x6E,0x64,0x6C,
		0x65,0x72,0x00,0x01;
	.var = .LNxPortSysTickHandler.;
	.var = .LN.xPortSysTickHandler..end;
	.byte =
		0x01,0x01,0x00,0x15,0x61,0x00,0x22,0x06,0x00,0x00,0x02,0x86,
		0x74,0x00,0x15,0x62,0x00,0xF7,0x05,0x00,0x00,0x02,0x86,0x78,
		0x00,0x15,0x63,0x00,0x49,0x0C,0x00,0x00,0x02,0x86,0x7C,0x00,
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN55;
	.var = .LN.xPortSysTickHandler..end;
	.byte =
		0x00,0x00,0x13,0x27,0x2B,0x00,0x00,0x76,0x50,0x6F,0x72,0x74,
		0x53,0x65,0x74,0x75,0x70,0x54,0x69,0x6D,0x65,0x72,0x49,0x6E,
		0x74,0x65,0x72,0x72,0x75,0x70,0x74,0x00,0x01;
	.var = .LNvPortSetupTimerInterrupt.;
	.var = .LN.vPortSetupTimerInterrupt..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN60;
	.var = .LN.vPortSetupTimerInterrupt..end;
	.byte =
		0x16,0x75,0x6C,0x54,0x69,0x6D,0x65,0x72,0x43,0x6F,0x75,0x6E,
		0x74,0x73,0x46,0x6F,0x72,0x4F,0x6E,0x65,0x54,0x69,0x63,0x6B,
		0x00,0x01,0x27,0x2B,0x00,0x00,0x02,0x86,0x78;
	.var = .LN60-.LNvPortSetupTimerInterrupt.;
	.byte =
		0x00,0x00,0x00,0x12,0x22,0x06,0x00,0x00,0x17,0x64,0x2B,0x00,
		0x00,0x78,0x50,0x6F,0x72,0x74,0x53,0x74,0x61,0x72,0x74,0x53,
		0x63,0x68,0x65,0x64,0x75,0x6C,0x65,0x72,0x00,0x01;
	.var = .LNxPortStartScheduler.;
	.var = .LN.xPortStartScheduler..end;
	.byte =
		0x01,0x4A,0x1A,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN67;
	.var = .LN.xPortStartScheduler..end;
	.byte =
		0x00,0x00,0x16,0x5F,0x61,0x64,0x69,0x5F,0x4F,0x53,0x52,0x65,
		0x73,0x63,0x68,0x65,0x64,0x75,0x6C,0x65,0x49,0x6E,0x74,0x49,
		0x44,0x00,0x01,0x22,0x06,0x00,0x00,0x05,0x03;
	.var = _adi_OSRescheduleIntID.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x5F,0x61,0x64,0x69,0x5F,0x4F,
		0x53,0x57,0x61,0x69,0x74,0x69,0x6E,0x67,0x46,0x6F,0x72,0x53,
		0x63,0x68,0x65,0x64,0x00,0x01,0xCE,0x2B,0x00,0x00,0x05,0x03;
	.var = _adi_OSWaitingForSched.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x18,0x73,0x5F,0x53,0x61,0x76,0x65,
		0x64,0x49,0x6E,0x74,0x4D,0x61,0x73,0x6B,0x00,0x01,0x22,0x06,
		0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x0F,0x22,0x06,0x00,0x00,
		0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\FreeRTOS\portable\port.sbn", 10332, 2198;
	.var = .LNvPortValidateInterruptPriority.;
	.byte =
		0x04,0x01,0x05,0x02,0x03,0xD6,0x03,0x01,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN.vPortValidateInterruptPriority..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvPortFixupStack.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x84,0x03,0x01,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x14,0x0B,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x12,0x0A,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x0E,0x0A,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x17,0x03,0x7D,0x01,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x02,0x0E,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x11,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x10,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vPortFixupStack..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvPortClearInterruptMask.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xF0,0x02,0x01,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x08,0x0A,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x0E,0x0B,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x08,0x0A,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vPortClearInterruptMask..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNulPortSetInterruptMask.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xE3,0x02,0x01,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x17,0x0A,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x08,0x0B,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN.ulPortSetInterruptMask..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNpxPortInitialiseStack.;
	.byte =
		0x04,0x01,0x05,0x01,0xD0,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x0F,0x0D,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x0F,0x0A,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN46;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN.pxPortInitialiseStack..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvTaskExitError.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xFB,0x01,0x01,0x00,0x05,0x02;
	.var = .LN47;
	.byte =
		0x05,0x02,0x10,0x00,0x05,0x02;
	.var = .LN48;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN.prvTaskExitError..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvPortEndScheduler.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xCD,0x02,0x01,0x00,0x05,0x02;
	.var = .LN49;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN50;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vPortEndScheduler..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvPortEnterCritical.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xD7,0x02,0x01,0x00,0x05,0x02;
	.var = .LN51;
	.byte =
		0x05,0x1C,0x0A,0x00,0x05,0x02;
	.var = .LN52;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vPortEnterCritical..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvPortExitCritical.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xDD,0x02,0x01,0x00,0x05,0x02;
	.var = .LN53;
	.byte =
		0x05,0x1D,0x0A,0x00,0x05,0x02;
	.var = .LN54;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vPortExitCritical..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxPortSysTickHandler.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xF9,0x02,0x01,0x00,0x05,0x02;
	.var = .LN55;
	.byte =
		0x05,0x18,0x0B,0x00,0x05,0x02;
	.var = .LN56;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN57;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN58;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN59;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.xPortSysTickHandler..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvPortSetupTimerInterrupt.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xBB,0x03,0x01,0x00,0x05,0x02;
	.var = .LN60;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN61;
	.byte =
		0x05,0x02,0x13,0x00,0x05,0x02;
	.var = .LN62;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN63;
	.byte =
		0x05,0x25,0x0C,0x00,0x05,0x02;
	.var = .LN64;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN65;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN66;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vPortSetupTimerInterrupt..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxPortStartScheduler.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x90,0x02,0x01,0x00,0x05,0x02;
	.var = .LN67;
	.byte =
		0x05,0x02,0x0D,0x00,0x05,0x02;
	.var = .LN68;
	.byte =
		0x05,0x05,0x15,0x00,0x05,0x02;
	.var = .LN69;
	.byte =
		0x05,0x29,0x16,0x00,0x05,0x02;
	.var = .LN70;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN71;
	.byte =
		0x05,0x16,0x01,0x00,0x05,0x02;
	.var = .LN72;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN73;
	.byte =
		0x05,0x19,0x01,0x00,0x05,0x02;
	.var = .LN74;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN75;
	.byte =
		0x05,0x1C,0x01,0x00,0x05,0x02;
	.var = .LN76;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN77;
	.byte =
		0x05,0x29,0x01,0x00,0x05,0x02;
	.var = .LN78;
	.byte =
		0x05,0x1A,0x14,0x00,0x05,0x02;
	.var = .LN79;
	.byte =
		0x05,0x17,0x0C,0x00,0x05,0x02;
	.var = .LN80;
	.byte =
		0x05,0x12,0x0F,0x00,0x05,0x02;
	.var = .LN81;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN.xPortStartScheduler..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x5C,0x01,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.inc/binary ".\system\FreeRTOS\portable\port.sbn", 12530, 342;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x74,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNvPortValidateInterruptPriority.;
	.var = .LN.vPortValidateInterruptPriority..end-.LNvPortValidateInterruptPriority.;
	.var = .LNvPortFixupStack.;
	.var = .LN.vPortFixupStack..end-.LNvPortFixupStack.;
	.var = .LNvPortClearInterruptMask.;
	.var = .LN.vPortClearInterruptMask..end-.LNvPortClearInterruptMask.;
	.var = .LNulPortSetInterruptMask.;
	.var = .LN.ulPortSetInterruptMask..end-.LNulPortSetInterruptMask.;
	.var = .LNpxPortInitialiseStack.;
	.var = .LN.pxPortInitialiseStack..end-.LNpxPortInitialiseStack.;
	.var = .LNprvTaskExitError.;
	.var = .LN.prvTaskExitError..end-.LNprvTaskExitError.;
	.var = .LNvPortEndScheduler.;
	.var = .LN.vPortEndScheduler..end-.LNvPortEndScheduler.;
	.var = .LNvPortEnterCritical.;
	.var = .LN.vPortEnterCritical..end-.LNvPortEnterCritical.;
	.var = .LNvPortExitCritical.;
	.var = .LN.vPortExitCritical..end-.LNvPortExitCritical.;
	.var = .LNxPortSysTickHandler.;
	.var = .LN.xPortSysTickHandler..end-.LNxPortSysTickHandler.;
	.var = .LNvPortSetupTimerInterrupt.;
	.var = .LN.vPortSetupTimerInterrupt..end-.LNvPortSetupTimerInterrupt.;
	.var = .LNxPortStartScheduler.;
	.var = .LN.xPortStartScheduler..end-.LNxPortStartScheduler.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 8;
	.type .sDRTOSF.0,STT_OBJECT;
	.byte .sDRTOSF.0[] =
		0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,0x65,0x65,
		0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,0x73,0x65,
		0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,0x31,0x30,
		0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,0x65,0x5C,
		0x70,0x6F,0x72,0x74,0x61,0x62,0x6C,0x65,0x5C,0x43,0x43,0x45,
		0x53,0x5C,0x53,0x48,0x41,0x52,0x43,0x5F,0x32,0x31,0x35,0x78,
		0x78,0x5C,0x70,0x6F,0x72,0x74,0x2E,0x63,0x00;

	.align 4;
	.byte _adi_OSRescheduleIntID.[4];
	.weak _adi_OSRescheduleIntID.;
	.align 4;
	.byte _adi_OSWaitingForSched.[4];
	.weak _adi_OSWaitingForSched.;
