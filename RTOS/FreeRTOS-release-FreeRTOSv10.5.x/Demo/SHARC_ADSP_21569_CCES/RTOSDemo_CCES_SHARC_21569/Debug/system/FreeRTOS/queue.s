	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c";
//  Compilation time: Thu Oct 24 14:39:59 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\FreeRTOS -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\FreeRTOS\queue.d -o system\FreeRTOS\queue.doj
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

prvCopyDataFromQueue.:
.LNprvCopyDataFromQueue.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc}
//  Call preserved registers used: {i3,i5}
//  Registers that could be clobbered by function calls: {r0,r2,r8,i4,i12,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,lcntr}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2278
	modify(i7,-4) (nw);
	r2=i3;
	dm(-5,i6)=r2;
	r2=i5;
	dm(-4,i6)=r2;
	i4=r4;
	dm(-2,i6)=r8;
	dm(-3,i6)=r4;
.LN0:
// line 2279
	r2=dm(16,i4);
	r2=pass r2;
	if eq jump (pc,.P36L2);

.LN1:
// line 2281
	r12=dm(16,i4);
	i4=modify(i4,8);
	r8=dm(m6,i4);
	r2=r8+r12;
	dm(m6,i4)=r2;
.LN2:
// line 2283
	i4=dm(-3,i6);
	i5=modify(i4,8);
	r2=dm(m6,i5);
	r1=dm(2,i4);
	compu(r2,r1);
	if lt jump (pc,.P36L5);

.LN3:
// line 2285
	r2=dm(i4,m5);
	dm(m6,i5)=r2;
.LN4:
// line 2286
	jump (pc,.P36L6);

.P36L5:

.P36L6:
.LN5:
// line 2292
	i4=dm(-2,i6);
	i3=dm(-3,i6);
	i5=modify(i3,8);
	i5=dm(m6,i5);
	r12=dm(16,i3);
	r4=i4;
	r8=i5;
	cjump __memcpyDD. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
.LN6:
// line 2293
	jump (pc,.P36L3);

.P36L2:

.P36L3:
.LN7:
// line 2294
	i3=dm(-5,i6);
	i5=dm(-4,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvCopyDataFromQueue..end:
.prvCopyDataFromQueue..end:
	.type prvCopyDataFromQueue.,STT_FUNC;

prvGetDisinheritPriorityAfterTimeout.:
.LNprvGetDisinheritPriorityAfterTimeout.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2169
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
	i4=r4;
.LN8:
// line 2178
	i4=modify(i4,36);
	r2=dm(i4,m5);
	r2=pass r2;
	if eq jump (pc,.P38L2);

.LN9:
// line 2180
	i4=dm(-3,i6);
	i4=dm(12,i4);
	r12=dm(i4,m5);
	r8=7;
	r2=r8-r12;
	dm(-2,i6)=r2;
.LN10:
// line 2181
	jump (pc,.P38L3);

.P38L2:
.LN11:
// line 2184
	dm(-2,i6)=m13;

.P38L3:
.LN12:
// line 2187
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvGetDisinheritPriorityAfterTimeout..end:
.prvGetDisinheritPriorityAfterTimeout..end:
	.type prvGetDisinheritPriorityAfterTimeout.,STT_FUNC;

ucQueueGetQueueType.:
.LNucQueueGetQueueType.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,i4,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2159
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;
	i4=r4;
.LN13:
// line 2160
	i4=modify(i4,80);
	r0=dm(m5,i4) (bw);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.ucQueueGetQueueType..end:
.ucQueueGetQueueType..end:
	.global ucQueueGetQueueType.;
	.type ucQueueGetQueueType.,STT_FUNC;

vQueueSetQueueNumber.:
.LNvQueueSetQueueNumber.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {i4,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2149
	modify(i7,-2) (nw);
	i4=r4;
	dm(-2,i6)=r8;
	dm(-3,i6)=r4;
.LN14:
// line 2150
	dm(19,i4)=r8;
.LN15:
// line 2151
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vQueueSetQueueNumber..end:
.vQueueSetQueueNumber..end:
	.global vQueueSetQueueNumber.;
	.type vQueueSetQueueNumber.,STT_FUNC;

uxQueueGetQueueNumber.:
.LNuxQueueGetQueueNumber.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,i4,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2138
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;
	i4=r4;
.LN16:
// line 2139
	r0=dm(19,i4);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.uxQueueGetQueueNumber..end:
.uxQueueGetQueueNumber..end:
	.global uxQueueGetQueueNumber.;
	.type uxQueueGetQueueNumber.,STT_FUNC;

xQueueGenericReset.:
.LNxQueueGenericReset.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,mcc,btf}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":317
	modify(i7,-6) (nw);
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
.LN17:
// line 318
	dm(-4,i6)=m14;
.LN18:
// line 319
	dm(-3,i6)=r4;
	r2=pass r4;
.LN19:
// line 321
	if ne jump (pc,.P43L2);

.LN20:
	r8=321;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN21:
	jump (pc,.P43L3);

.P43L2:

.P43L3:
.LN22:
// line 323
	r2=dm(-3,i6);
	r2=pass r2;
	if eq jump (pc,.P43L5);

	i4=r2;
	r8=dm(15,i4);
	r2=pass r8;
	if eq jump (pc,.P43L5);

	r4=m7;
	cjump __divrem_u32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;// division is implemented as a library call. There is 1 more instruction related to this call. 
.LCJ2:
	r2=dm(16,i4);
	compu(r0,r2);
	if lt jump (pc,.P43L5);

.LN23:
// line 328
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
.LN24:
// line 330
	i4=dm(-3,i6);
	r2=dm(i4,m5);
	r1=dm(15,i4);
	r0=dm(16,i4);
	r1=r1*r0 (ssi);
	r2=r2+r1;
	dm(2,i4)=r2;
.LN25:
// line 331
	i4=dm(-3,i6);
	i4=modify(i4,56);
	dm(m5,i4)=m13;
.LN26:
// line 332
	i4=dm(-3,i6);
	r2=dm(i4,m5);
	dm(m6,i4)=r2;
.LN27:
// line 333
	i4=dm(-3,i6);
	r2=dm(i4,m5);
	r1=dm(15,i4);
	r1=r1-1;
	r0=dm(16,i4);
	r1=r1*r0 (ssi);
	r2=r2+r1;
	i4=modify(i4,8);
	dm(m6,i4)=r2;
.LN28:
// line 334
	i4=dm(-3,i6);
	i4=modify(i4,68);
	dm(m5,i4)=m15 (bw);
.LN29:
// line 335
	i4=dm(-3,i6);
	i4=modify(i4,69);
	dm(m5,i4)=m15 (bw);
.LN30:
// line 337
	r2=dm(-5,i6);
	r2=pass r2;
	if ne jump (pc,.P43L10);

.LN31:
// line 344
	i4=dm(-3,i6);
	i4=modify(i4,16);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P43L16);

	dm(-2,i6)=m14;
	jump (pc,.P43L17);

.P43L16:
	dm(-2,i6)=m13;

.P43L17:
	r2=dm(-2,i6);
	r2=pass r2;
	if ne jump (pc,.P43L13);

.LN32:
// line 346
	r8=dm(-3,i6);
	r12=16;
	r4=r8+r12;
.LN33:
	cjump xTaskRemoveFromEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN34:
	if eq jump (pc,.P43L19);

.LN35:
// line 348
	dm(_adi_OSWaitingForSched.)=m6;
.LN36:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN37:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	dm(-2,i6)=r2;
	r2=pass r2;
	if eq jump (pc,.P43L22);


.P43L26:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 348 col 25
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 6 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   4 out of    6 ( 66.7%)
//     multifunction float multiply    used   4 out of    6 ( 66.7%)
//     multifunction integer add sub   used   4 out of    6 ( 66.7%)
//     multifunction integer multiply  used   4 out of    6 ( 66.7%)
//     multifunction mult              used   4 out of    6 ( 66.7%)
//     dm dag                          used   3 out of    6 ( 50.0%)
//     pm dag                          used   3 out of    6 ( 50.0%)
//     shift immediate                 used   3 out of    6 ( 50.0%)
//     memory access                   used   3 out of   12 ( 25.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN38:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P43L27);

	jump (pc,.P43L26);
//-------------------------------------------------------------------
//   End Loop L26
//-------------------------------------------------------------------

.P43L27:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN39:
	jump (pc,.P43L23);

.P43L22:

.P43L23:
.LN40:
// line 349
	jump (pc,.P43L20);

.P43L19:

.P43L20:
.LN41:
// line 354
	jump (pc,.P43L14);

.P43L13:

.P43L14:
.LN42:
// line 359
	jump (pc,.P43L11);

.P43L10:
.LN43:
// line 363
	r8=dm(-3,i6);
	r12=16;
	r4=r8+r12;
.LN44:
	cjump vListInitialise. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
.LN45:
// line 364
	r8=dm(-3,i6);
	r12=36;
	r4=r8+r12;
.LN46:
	cjump vListInitialise. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:

.P43L11:
.LN47:
// line 367
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
.LN48:
// line 368
	jump (pc,.P43L6);

.P43L5:
.LN49:
// line 371
	dm(-4,i6)=m13;

.P43L6:
.LN50:
// line 374
	r2=dm(-4,i6);
	r2=pass r2;
	if ne jump (pc,.P43L30);

.LN51:
	r8=374;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
.LN52:
	jump (pc,.P43L31);

.P43L30:

.P43L31:
.LN53:
// line 378
	r0=dm(-4,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueGenericReset..end:
.xQueueGenericReset..end:
	.global xQueueGenericReset.;
	.type xQueueGenericReset.,STT_FUNC;

prvInitialiseNewQueue.:
.LNprvInitialiseNewQueue.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":517
	modify(i7,-4) (nw);
	r1=dm(m6,i6);
	r2=dm(2,i6);
	dm(2,i6)=r2;
	dm(4,i6)=r1 (bw);
	dm(-2,i6)=r12;
	dm(-3,i6)=r8;
	dm(-4,i6)=r4;
	r1=pass r8;
.LN54:
// line 522
	if ne jump (pc,.P50L2);

	i4=r2;
.LN55:
// line 528
	dm(i4,m5)=r2;
.LN56:
// line 529
	jump (pc,.P50L3);

.P50L2:
	i4=r2;
.LN57:
// line 533
	dm(i4,m5)=r12;

.P50L3:
.LN58:
// line 538
	r2=dm(-4,i6);
	i4=dm(2,i6);
	dm(15,i4)=r2;
.LN59:
// line 539
	r2=dm(-3,i6);
	i4=dm(2,i6);
	dm(16,i4)=r2;
.LN60:
// line 540
	r4=dm(2,i6);
.LN61:
	r8=m6;
	cjump xQueueGenericReset. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ9-1;
.LCJ9:
.LN62:
// line 544
	r2=dm(4,i6) (bw);
	i4=dm(2,i6);
	i4=modify(i4,80);
	dm(m5,i4)=r2 (bw);
.LN63:
// line 550
	i4=dm(2,i6);
	dm(18,i4)=m13;
.LN64:
// line 555
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvInitialiseNewQueue..end:
.prvInitialiseNewQueue..end:
	.type prvInitialiseNewQueue.,STT_FUNC;

xQueueGenericCreateStatic.:
.LNxQueueGenericCreateStatic.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":389
	modify(i7,-6) (nw);
	r2=dm(m6,i6);
	r1=dm(2,i6);
	dm(8,i6)=r1 (bw);
	dm(m6,i6)=r2;
	dm(-4,i6)=r12;
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
.LN65:
// line 390
	dm(-3,i6)=m13;
	r2=pass r2;
.LN66:
// line 394
	if ne jump (pc,.P51L2);

.LN67:
	r8=394;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ10-1;
.LCJ10:
.LN68:
	jump (pc,.P51L3);

.P51L2:

.P51L3:
.LN69:
// line 396
	r2=dm(-6,i6);
	r2=pass r2;
	if eq jump (pc,.P51L5);

	r2=dm(m6,i6);
	r2=pass r2;
	if eq jump (pc,.P51L5);

	r1=dm(-4,i6);
	r1=pass r1;
	if eq jump (pc,.P51L7);

	r0=dm(-5,i6);
	r0=pass r0;
	if eq jump (pc,.P51L5);

.P51L7:
	r1=pass r1;
	if ne jump (pc,.P51L4);

	r1=dm(-5,i6);
	r1=pass r1;
	if ne jump (pc,.P51L5);

.P51L4:
.LN70:
// line 409
	i12=84;
	dm(-2,i6)=i12;


	i4=r2;
.LN71:
// line 420
	dm(-3,i6)=r2;
.LN72:
// line 426
	i4=modify(i4,70);
	dm(m5,i4)=m14 (bw);
.LN73:
// line 430
	r4=dm(-6,i6);
	r8=dm(-5,i6);
	r12=dm(-4,i6);
	r2=dm(8,i6) (bw);
	r1=dm(-3,i6);
.LN74:
	dm(i7,m7)=r1;
	dm(i7,m7)=r2;
	cjump prvInitialiseNewQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ11-1;
.LCJ11:
	modify(i7,2) (nw);
.LN75:
// line 431
	jump (pc,.P51L6);

.P51L5:
.LN76:
// line 434
	r2=dm(-3,i6);
	r2=pass r2;
	if ne jump (pc,.P51L16);

.LN77:
	r8=434;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ12-1;
.LCJ12:
.LN78:
	jump (pc,.P51L17);

.P51L16:

.P51L17:

.P51L6:
.LN79:
// line 438
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueGenericCreateStatic..end:
.xQueueGenericCreateStatic..end:
	.global xQueueGenericCreateStatic.;
	.type xQueueGenericCreateStatic.,STT_FUNC;

xQueueGenericCreate.:
.LNxQueueGenericCreate.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12-i13,acc,mcc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":449
	modify(i7,-6) (nw);
	dm(-20,i6)=r12 (bw);
	dm(-6,i6)=r8;
	dm(-7,i6)=r4;
.LN80:
// line 450
	dm(-4,i6)=m13;
	r2=pass r4;
.LN81:
// line 454
	if eq jump (pc,.P52L2);

	r4=m7;
	r8=r2;
	cjump __divrem_u32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ13-1;// division is implemented as a library call. There is 1 more instruction related to this call. 
.LCJ13:
	r2=dm(-6,i6);
	compu(r0,r2);
	if lt jump (pc,.P52L2);

	r1=dm(-7,i6);
	r0=r1*r2 (ssi);
	r12=-85;
	compu(r0,r12);
	if gt jump (pc,.P52L2);

.LN82:
// line 463
	r8=r1*r2 (ssi);
	dm(-3,i6)=r8;
.LN83:
// line 474
	r12=84;
	r4=r8+r12;
.LN84:
	cjump pvPortMalloc. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ14-1;
.LCJ14:
.LN85:
	dm(-4,i6)=r0;
	r2=pass r0;
.LN86:
// line 476
	if eq jump (pc,.P52L7);

.LN87:
// line 480
	i12=dm(-4,i6);
	dm(-2,i6)=i12;
.LN88:
// line 481
	i13=modify(i12,84);
	dm(-2,i6)=i13;
.LN89:
// line 488
	i12=modify(i12,70);
	i4=i12;
	dm(m5,i4)=m13 (bw);
.LN90:
// line 492
	r4=dm(-7,i6);
	r8=dm(-6,i6);
	r12=dm(-2,i6);
	r2=dm(-20,i6) (bw);
	r1=dm(-4,i6);
.LN91:
	dm(i7,m7)=r1;
	dm(i7,m7)=r2;
	cjump prvInitialiseNewQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ15-1;
.LCJ15:
	modify(i7,2) (nw);
.LN92:
// line 493
	jump (pc,.P52L8);

.P52L7:

.P52L8:
.LN93:
// line 499
	jump (pc,.P52L3);

.P52L2:
.LN94:
// line 502
	r2=dm(-4,i6);
	r2=pass r2;
	if ne jump (pc,.P52L10);

.LN95:
	r8=502;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ16-1;
.LCJ16:
.LN96:
	jump (pc,.P52L11);

.P52L10:

.P52L11:

.P52L3:
.LN97:
// line 506
	r0=dm(-4,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueGenericCreate..end:
.xQueueGenericCreate..end:
	.global xQueueGenericCreate.;
	.type xQueueGenericCreate.,STT_FUNC;

xQueueCreateCountingSemaphoreStatic.:
.LNxQueueCreateCountingSemaphoreStatic.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0,r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":787
	modify(i7,-4) (nw);
	dm(-3,i6)=r12;
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
.LN98:
// line 788
	dm(-2,i6)=m13;
	r2=pass r4;
.LN99:
// line 790
	if eq jump (pc,.P54L2);

	compu(r4,r8);
	if lt jump (pc,.P54L2);

.LN100:
// line 793
	r2=2;
	r8=m5;
	dm(i7,m7)=r2;
	dm(i7,m7)=r12;
	r12=m5;
	cjump xQueueGenericCreateStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ17-1;
.LCJ17:
	modify(i7,2) (nw);
.LN101:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN102:
// line 795
	if eq jump (pc,.P54L6);

.LN103:
// line 797
	r2=dm(-4,i6);
	i4=r0;
	i4=modify(i4,56);
	dm(i4,m5)=r2;
.LN104:
// line 800
	jump (pc,.P54L7);

.P54L6:

.P54L7:
.LN105:
// line 805
	jump (pc,.P54L3);

.P54L2:
.LN106:
// line 808
	r2=dm(-2,i6);
	r2=pass r2;
	if ne jump (pc,.P54L9);

.LN107:
	r8=808;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ18-1;
.LCJ18:
.LN108:
	jump (pc,.P54L10);

.P54L9:

.P54L10:

.P54L3:
.LN109:
// line 812
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueCreateCountingSemaphoreStatic..end:
.xQueueCreateCountingSemaphoreStatic..end:
	.global xQueueCreateCountingSemaphoreStatic.;
	.type xQueueCreateCountingSemaphoreStatic.,STT_FUNC;

xQueueCreateCountingSemaphore.:
.LNxQueueCreateCountingSemaphore.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":822
	modify(i7,-4) (nw);
	dm(-3,i6)=r8;
	dm(-4,i6)=r4;
.LN110:
// line 823
	dm(-2,i6)=m13;
	r2=pass r4;
.LN111:
// line 825
	if eq jump (pc,.P55L2);

	compu(r4,r8);
	if lt jump (pc,.P55L2);

.LN112:
// line 828
	r12=2;
	r8=m5;
	cjump xQueueGenericCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ19-1;
.LCJ19:
.LN113:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN114:
// line 830
	if eq jump (pc,.P55L6);

.LN115:
// line 832
	r2=dm(-3,i6);
	i4=r0;
	i4=modify(i4,56);
	dm(i4,m5)=r2;
.LN116:
// line 835
	jump (pc,.P55L7);

.P55L6:

.P55L7:
.LN117:
// line 840
	jump (pc,.P55L3);

.P55L2:
.LN118:
// line 843
	r2=dm(-2,i6);
	r2=pass r2;
	if ne jump (pc,.P55L9);

.LN119:
	r8=843;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ20-1;
.LCJ20:
.LN120:
	jump (pc,.P55L10);

.P55L9:

.P55L10:

.P55L3:
.LN121:
// line 847
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueCreateCountingSemaphore..end:
.xQueueCreateCountingSemaphore..end:
	.global xQueueCreateCountingSemaphore.;
	.type xQueueCreateCountingSemaphore.,STT_FUNC;

xQueueReceiveFromISR.:
.LNxQueueReceiveFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 56 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":1903
	modify(i7,-12) (nw);
	dm(-10,i6)=r12;
	dm(-11,i6)=r8;
	dm(-12,i6)=r4;
.LN122:
// line 1906
	dm(-7,i6)=r4;
	r2=pass r4;
.LN123:
// line 1908
	if ne jump (pc,.P56L2);

.LN124:
	r8=1908;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ21-1;
.LCJ21:
.LN125:
	jump (pc,.P56L3);

.P56L2:

.P56L3:
.LN126:
// line 1909
	r2=dm(-11,i6);
	r2=pass r2;
	if eq jump (pc,.P56L8);

.P56L7:
	dm(-6,i6)=m13;
	jump (pc,.P56L10);

.P56L8:
	i4=dm(-7,i6);
	r2=dm(16,i4);
	r2=pass r2;
	if eq jump (pc,.P56L7);

	dm(-6,i6)=m14;

.P56L10:
	r2=dm(-6,i6);
	r2=pass r2;
	if eq jump (pc,.P56L5);

.LN127:
	r8=1909;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ22-1;
.LCJ22:
.LN128:
	jump (pc,.P56L6);

.P56L5:

.P56L6:
.LN129:
// line 1925
	cjump vPortValidateInterruptPriority. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ23-1;
.LCJ23:
.LN130:
// line 1927
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ24-1;
.LCJ24:
.LN131:
	dm(-8,i6)=r0;
.LN132:
// line 1929
	i4=dm(-7,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	dm(-5,i6)=r2;
	r2=pass r2;
.LN133:
// line 1932
	if eq jump (pc,.P56L12);

.LN134:
// line 1934
	i4=dm(-7,i6);
	i4=modify(i4,68);
	r2=dm(m5,i4) (bw);
	dm(-13,i6)=r2 (bw);
.LN135:
// line 1938
	r4=dm(-7,i6);
	r8=dm(-11,i6);
.LN136:
	cjump prvCopyDataFromQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ25-1;
.LCJ25:
.LN137:
// line 1939
	r2=dm(-5,i6);
	r2=r2-1;
	i4=dm(-7,i6);
	i4=modify(i4,56);
	dm(i4,m5)=r2;
.LN138:
// line 1945
	r2=dm(-13,i6) (bwse);
	r1=m7;
	comp(r2,r1);
	if ne jump (pc,.P56L15);

.LN139:
// line 1947
	i4=dm(-7,i6);
	i4=modify(i4,16);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P56L21);

	dm(-3,i6)=m14;
	jump (pc,.P56L22);

.P56L21:
	dm(-3,i6)=m13;

.P56L22:
	r2=dm(-3,i6);
	r2=pass r2;
	if ne jump (pc,.P56L18);

.LN140:
// line 1949
	r8=dm(-7,i6);
	r12=16;
	r4=r8+r12;
.LN141:
	cjump xTaskRemoveFromEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ26-1;
.LCJ26:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN142:
	if eq jump (pc,.P56L24);

.LN143:
// line 1953
	r2=dm(-10,i6);
	r2=pass r2;
	if eq jump (pc,.P56L27);

	i4=r2;
.LN144:
// line 1955
	dm(m5,i4)=m14;
.LN145:
// line 1956
	jump (pc,.P56L28);

.P56L27:

.P56L28:
.LN146:
// line 1961
	jump (pc,.P56L25);

.P56L24:

.P56L25:
.LN147:
// line 1966
	jump (pc,.P56L19);

.P56L18:

.P56L19:
.LN148:
// line 1971
	jump (pc,.P56L16);

.P56L15:
.LN149:
// line 1976
	cjump uxTaskGetNumberOfTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ27-1;
.LCJ27:
.LN150:
	dm(-2,i6)=r0;
.LN151:
	r2=dm(-13,i6) (bwse);
	compu(r0,r2);
	if le jump (pc,.P56L30);

	r1=127;
	comp(r2,r1);
.LN152:
	if ne jump (pc,.P56L33);

.LN153:
	r8=1976;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ28-1;
.LCJ28:
.LN154:
	jump (pc,.P56L34);

.P56L33:

.P56L34:
.LN155:
	r2=dm(-13,i6) (bwse);
	r2=r2+1;
	i4=dm(-7,i6);
	i4=modify(i4,68);
	dm(m5,i4)=r2 (bw);
.LN156:
	jump (pc,.P56L31);

.P56L30:

.P56L31:

.P56L16:
.LN157:
// line 1979
	dm(-9,i6)=m14;
.LN158:
// line 1980
	jump (pc,.P56L13);

.P56L12:
.LN159:
// line 1983
	dm(-9,i6)=m13;

.P56L13:
.LN160:
// line 1987
	r4=dm(-8,i6);
.LN161:
	cjump vPortClearInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ29-1;
.LCJ29:
.LN162:
// line 1989
	r0=dm(-9,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueReceiveFromISR..end:
.xQueueReceiveFromISR..end:
	.global xQueueReceiveFromISR.;
	.type xQueueReceiveFromISR.,STT_FUNC;

xQueuePeekFromISR.:
.LNxQueuePeekFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r0,r2,r4,r8,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":1995
	modify(i7,-8) (nw);
	dm(-7,i6)=r8;
	dm(-8,i6)=r4;
.LN163:
// line 1999
	dm(-3,i6)=r4;
	r2=pass r4;
.LN164:
// line 2001
	if ne jump (pc,.P61L2);

.LN165:
	r8=2001;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ30-1;
.LCJ30:
.LN166:
	jump (pc,.P61L3);

.P61L2:

.P61L3:
.LN167:
// line 2002
	r2=dm(-7,i6);
	r2=pass r2;
	if eq jump (pc,.P61L8);

.P61L7:
	dm(-2,i6)=m13;
	jump (pc,.P61L10);

.P61L8:
	i4=dm(-3,i6);
	r2=dm(16,i4);
	r2=pass r2;
	if eq jump (pc,.P61L7);

	dm(-2,i6)=m14;

.P61L10:
	r2=dm(-2,i6);
	r2=pass r2;
	if eq jump (pc,.P61L5);

.LN168:
	r8=2002;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ31-1;
.LCJ31:
.LN169:
	jump (pc,.P61L6);

.P61L5:

.P61L6:
.LN170:
// line 2003
	i4=dm(-3,i6);
	r2=dm(16,i4);
	r2=pass r2;
	if ne jump (pc,.P61L12);

.LN171:
	r8=2003;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ32-1;
.LCJ32:
.LN172:
	jump (pc,.P61L13);

.P61L12:

.P61L13:
.LN173:
// line 2019
	cjump vPortValidateInterruptPriority. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ33-1;
.LCJ33:
.LN174:
// line 2021
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ34-1;
.LCJ34:
.LN175:
	dm(-5,i6)=r0;
.LN176:
// line 2024
	i4=dm(-3,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	r2=pass r2;
	if eq jump (pc,.P61L15);

.LN177:
// line 2030
	r4=dm(-3,i6);
	i4=r4;
	i4=modify(i4,8);
	r2=dm(m6,i4);
	dm(-4,i6)=r2;
.LN178:
// line 2031
	r8=dm(-7,i6);
.LN179:
	cjump prvCopyDataFromQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ35-1;
.LCJ35:
.LN180:
// line 2032
	r2=dm(-4,i6);
	i4=dm(-3,i6);
	i4=modify(i4,8);
	dm(m6,i4)=r2;
.LN181:
// line 2034
	dm(-6,i6)=m14;
.LN182:
// line 2035
	jump (pc,.P61L16);

.P61L15:
.LN183:
// line 2038
	dm(-6,i6)=m13;

.P61L16:
.LN184:
// line 2042
	r4=dm(-5,i6);
.LN185:
	cjump vPortClearInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ36-1;
.LCJ36:
.LN186:
// line 2044
	r0=dm(-6,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueuePeekFromISR..end:
.xQueuePeekFromISR..end:
	.global xQueuePeekFromISR.;
	.type xQueuePeekFromISR.,STT_FUNC;

uxQueueMessagesWaiting.:
.LNuxQueueMessagesWaiting.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,r4,r8,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2049
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
	r2=pass r4;
.LN187:
// line 2052
	if ne jump (pc,.P62L2);

.LN188:
	r8=2052;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ37-1;
.LCJ37:
.LN189:
	jump (pc,.P62L3);

.P62L2:

.P62L3:
.LN190:
// line 2054
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ38-1;
.LCJ38:
.LN191:
// line 2056
	i4=dm(-3,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	dm(-2,i6)=r2;
.LN192:
// line 2058
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ39-1;
.LCJ39:
.LN193:
// line 2060
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.uxQueueMessagesWaiting..end:
.uxQueueMessagesWaiting..end:
	.global uxQueueMessagesWaiting.;
	.type uxQueueMessagesWaiting.,STT_FUNC;

uxQueueSpacesAvailable.:
.LNuxQueueSpacesAvailable.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2065
	modify(i7,-4) (nw);
	dm(-4,i6)=r4;
.LN194:
// line 2067
	dm(-2,i6)=r4;
	r2=pass r4;
.LN195:
// line 2069
	if ne jump (pc,.P63L2);

.LN196:
	r8=2069;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ40-1;
.LCJ40:
.LN197:
	jump (pc,.P63L3);

.P63L2:

.P63L3:
.LN198:
// line 2071
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ41-1;
.LCJ41:
.LN199:
// line 2073
	i4=dm(-2,i6);
	r8=dm(15,i4);
	i4=modify(i4,56);
	r12=dm(i4,m5);
	r2=r8-r12;
	dm(-3,i6)=r2;
.LN200:
// line 2075
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ42-1;
.LCJ42:
.LN201:
// line 2077
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.uxQueueSpacesAvailable..end:
.uxQueueSpacesAvailable..end:
	.global uxQueueSpacesAvailable.;
	.type uxQueueSpacesAvailable.,STT_FUNC;

uxQueueMessagesWaitingFromISR.:
.LNuxQueueMessagesWaitingFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,r8,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2082
	modify(i7,-4) (nw);
	dm(-4,i6)=r4;
.LN202:
// line 2084
	dm(-2,i6)=r4;
	r2=pass r4;
.LN203:
// line 2086
	if ne jump (pc,.P64L2);

.LN204:
	r8=2086;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ43-1;
.LCJ43:
.LN205:
	jump (pc,.P64L3);

.P64L2:

.P64L3:
.LN206:
// line 2087
	i4=dm(-2,i6);
	i4=modify(i4,56);
	r0=dm(i4,m5);
	dm(-3,i6)=r0;
.LN207:
// line 2089
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.uxQueueMessagesWaitingFromISR..end:
.uxQueueMessagesWaitingFromISR..end:
	.global uxQueueMessagesWaitingFromISR.;
	.type uxQueueMessagesWaitingFromISR.,STT_FUNC;

prvCopyDataToQueue.:
.LNprvCopyDataToQueue.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,scc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2196
	modify(i7,-6) (nw);
	r2=i5;
	dm(-7,i6)=r2;
	i4=r4;
	dm(-4,i6)=r12;
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
.LN208:
// line 2197
	dm(-3,i6)=m13;
.LN209:
// line 2202
	i4=modify(i4,56);
	r2=dm(i4,m5);
	dm(-2,i6)=r2;
.LN210:
// line 2204
	i4=dm(-6,i6);
	r12=dm(16,i4);
	r2=pass r12;
	if ne jump (pc,.P65L2);

.LN211:
// line 2208
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P65L5);

.LN212:
// line 2211
	r4=dm(2,i4);
.LN213:
	cjump xTaskPriorityDisinherit. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ44-1;
.LCJ44:
.LN214:
	dm(-3,i6)=r0;
.LN215:
// line 2212
	i4=dm(-6,i6);
	dm(2,i4)=m13;
.LN216:
// line 2213
	jump (pc,.P65L6);

.P65L5:

.P65L6:
.LN217:
// line 2220
	jump (pc,.P65L3);

.P65L2:
.LN218:
// line 2221
	r2=dm(-4,i6);
	r2=pass r2;
	if ne jump (pc,.P65L8);

.LN219:
// line 2223
	i4=dm(m6,i4);
	i5=dm(-5,i6);
	r4=i4;
	r8=i5;
	cjump __memcpyDD. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ45-1;
.LCJ45:
.LN220:
// line 2224
	i4=dm(-6,i6);
	r12=dm(16,i4);
	r8=dm(m6,i4);
	r2=r8+r12;
	dm(m6,i4)=r2;
.LN221:
// line 2226
	i4=dm(-6,i6);
	r2=dm(m6,i4);
	r1=dm(2,i4);
	compu(r2,r1);
	if lt jump (pc,.P65L11);

.LN222:
// line 2228
	r2=dm(i4,m5);
	dm(m6,i4)=r2;
.LN223:
// line 2229
	jump (pc,.P65L12);

.P65L11:

.P65L12:
.LN224:
// line 2234
	jump (pc,.P65L9);

.P65L8:
.LN225:
// line 2237
	i4=modify(i4,8);
	i4=dm(m6,i4);
	i5=dm(-5,i6);
	r4=i4;
	r8=i5;
	cjump __memcpyDD. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ46-1;
.LCJ46:
.LN226:
// line 2238
	i4=dm(-6,i6);
	r12=dm(16,i4);
	i4=modify(i4,8);
	r8=dm(m6,i4);
	r2=r8-r12;
	dm(m6,i4)=r2;
.LN227:
// line 2240
	i4=dm(-6,i6);
	i5=modify(i4,8);
	r2=dm(m6,i5);
	r1=dm(i4,m5);
	compu(r1,r2);
	if le jump (pc,.P65L14);

.LN228:
// line 2242
	r8=dm(2,i4);
	r12=dm(16,i4);
	r2=r8-r12;
	dm(m6,i5)=r2;
.LN229:
// line 2243
	jump (pc,.P65L15);

.P65L14:

.P65L15:
.LN230:
// line 2249
	r2=dm(-4,i6);
	r1=m6;
	r2=btgl r2 by r1;
	if not sz jump (pc,.P65L17);

.LN231:
// line 2251
	r2=dm(-2,i6);
	r2=pass r2;
	if eq jump (pc,.P65L20);

.LN232:
// line 2257
	r2=r2-1;
	dm(-2,i6)=r2;
.LN233:
// line 2258
	jump (pc,.P65L21);

.P65L20:

.P65L21:
.LN234:
// line 2263
	jump (pc,.P65L18);

.P65L17:

.P65L18:

.P65L9:

.P65L3:
.LN235:
// line 2270
	r2=dm(-2,i6);
	r2=r2+1;
	i4=dm(-6,i6);
	i4=modify(i4,56);
	dm(i4,m5)=r2;
.LN236:
// line 2272
	r0=dm(-3,i6);
	i5=dm(-7,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvCopyDataToQueue..end:
.prvCopyDataToQueue..end:
	.type prvCopyDataToQueue.,STT_FUNC;

prvIsQueueEmpty.:
.LNprvIsQueueEmpty.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2418
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN237:
// line 2421
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ47-1;
.LCJ47:
.LN238:
// line 2423
	i4=dm(-3,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P67L2);

.LN239:
// line 2425
	dm(-2,i6)=m14;
.LN240:
// line 2426
	jump (pc,.P67L3);

.P67L2:
.LN241:
// line 2429
	dm(-2,i6)=m13;

.P67L3:
.LN242:
// line 2432
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ48-1;
.LCJ48:
.LN243:
// line 2434
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvIsQueueEmpty..end:
.prvIsQueueEmpty..end:
	.type prvIsQueueEmpty.,STT_FUNC;

xQueueIsQueueEmptyFromISR.:
.LNxQueueIsQueueEmptyFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,r8,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2439
	modify(i7,-4) (nw);
	dm(-4,i6)=r4;
.LN244:
// line 2441
	dm(-2,i6)=r4;
	r2=pass r4;
.LN245:
// line 2443
	if ne jump (pc,.P68L2);

.LN246:
	r8=2443;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ49-1;
.LCJ49:
.LN247:
	jump (pc,.P68L3);

.P68L2:

.P68L3:
.LN248:
// line 2445
	i4=dm(-2,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P68L5);

.LN249:
// line 2447
	dm(-3,i6)=m14;
.LN250:
// line 2448
	jump (pc,.P68L6);

.P68L5:
.LN251:
// line 2451
	dm(-3,i6)=m13;

.P68L6:
.LN252:
// line 2454
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueIsQueueEmptyFromISR..end:
.xQueueIsQueueEmptyFromISR..end:
	.global xQueueIsQueueEmptyFromISR.;
	.type xQueueIsQueueEmptyFromISR.,STT_FUNC;

prvIsQueueFull.:
.LNprvIsQueueFull.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0-r2,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2459
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN253:
// line 2462
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ50-1;
.LCJ50:
.LN254:
// line 2464
	i4=dm(-3,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	i4=dm(-3,i6);
	r1=dm(15,i4);
	comp(r2,r1);
	if ne jump (pc,.P69L2);

.LN255:
// line 2466
	dm(-2,i6)=m14;
.LN256:
// line 2467
	jump (pc,.P69L3);

.P69L2:
.LN257:
// line 2470
	dm(-2,i6)=m13;

.P69L3:
.LN258:
// line 2473
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ51-1;
.LCJ51:
.LN259:
// line 2475
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvIsQueueFull..end:
.prvIsQueueFull..end:
	.type prvIsQueueFull.,STT_FUNC;

xQueueIsQueueFullFromISR.:
.LNxQueueIsQueueFullFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0-r2,r4,r8,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2480
	modify(i7,-4) (nw);
	dm(-4,i6)=r4;
.LN260:
// line 2482
	dm(-2,i6)=r4;
	r2=pass r4;
.LN261:
// line 2484
	if ne jump (pc,.P70L2);

.LN262:
	r8=2484;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ52-1;
.LCJ52:
.LN263:
	jump (pc,.P70L3);

.P70L2:

.P70L3:
.LN264:
// line 2486
	i4=dm(-2,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	i4=dm(-2,i6);
	r1=dm(15,i4);
	comp(r2,r1);
	if ne jump (pc,.P70L5);

.LN265:
// line 2488
	dm(-3,i6)=m14;
.LN266:
// line 2489
	jump (pc,.P70L6);

.P70L5:
.LN267:
// line 2492
	dm(-3,i6)=m13;

.P70L6:
.LN268:
// line 2495
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueIsQueueFullFromISR..end:
.xQueueIsQueueFullFromISR..end:
	.global xQueueIsQueueFullFromISR.;
	.type xQueueIsQueueFullFromISR.,STT_FUNC;

vQueueAddToRegistry.:
.LNvQueueAddToRegistry.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2790
	modify(i7,-4) (nw);
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
.LN269:
// line 2792
	dm(-2,i6)=m13;
	r2=pass r4;
.LN270:
// line 2794
	if ne jump (pc,.P71L2);

.LN271:
	r8=2794;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ53-1;
.LCJ53:
.LN272:
	jump (pc,.P71L3);

.P71L2:

.P71L3:
.LN273:
// line 2796
	r2=dm(-4,i6);
	r2=pass r2;
	if eq jump (pc,.P71L5);

.LN274:
// line 2800
	dm(-3,i6)=m13;

.P71L7:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 2800 col 13
//-------------------------------------------------------------------
	r2=dm(-3,i6);
	r1=lshift r2 by -3;
	if not sz jump (pc,.P71L9);

.LN275:
// line 2803
	r1=dm(-5,i6);
	r12=lshift r2 by 3;
	i4=r12;
	i4=modify(i4,xQueueRegistry.);
	r2=dm(m6,i4);
	comp(r1,r2);
	if ne jump (pc,.P71L11);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN276:
// line 2805
	r2=dm(-3,i6);
	r12=lshift r2 by 3;
	r8=xQueueRegistry.;
	r2=r8+r12;
	dm(-2,i6)=r2;
.LN277:
// line 2806
	jump (pc,.P71L13);

.P71L11:
//-------------------------------------------------------------------
//   Part of Loop 7, depth 1
//-------------------------------------------------------------------
.LN278:
// line 2809
	r2=dm(-2,i6);
	r2=pass r2;
	if ne jump (pc,.P71L16);

	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P71L16);

.LN279:
// line 2811
	r8=xQueueRegistry.;
	r2=r8+r12;
	dm(-2,i6)=r2;
.LN280:
// line 2812
	jump (pc,.P71L17);

.P71L16:

.P71L17:
.LN281:
// line 2800
	r2=dm(-3,i6);
	r2=r2+1;
	dm(-3,i6)=r2;
	jump (pc,.P71L7);
//-------------------------------------------------------------------
//   End Loop L7
//-------------------------------------------------------------------

.P71L9:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------

.P71L13:
.LN282:
// line 2818
	jump (pc,.P71L6);

.P71L5:

.P71L6:
.LN283:
// line 2820
	r2=dm(-2,i6);
	r2=pass r2;
	if eq jump (pc,.P71L20);

.LN284:
// line 2823
	r1=dm(-4,i6);
	i4=r2;
	dm(i4,m5)=r1;
.LN285:
// line 2824
	r2=dm(-5,i6);
	i4=dm(-2,i6);
	dm(m6,i4)=r2;
.LN286:
// line 2827
	jump (pc,.P71L21);

.P71L20:

.P71L21:
.LN287:
// line 2828
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vQueueAddToRegistry..end:
.vQueueAddToRegistry..end:
	.global vQueueAddToRegistry.;
	.type vQueueAddToRegistry.,STT_FUNC;

pcQueueGetName.:
.LNpcQueueGetName.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0-r2,r4,r8,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2836
	modify(i7,-4) (nw);
	dm(-4,i6)=r4;
.LN288:
// line 2838
	dm(-2,i6)=m13;
	r2=pass r4;
.LN289:
// line 2840
	if ne jump (pc,.P72L2);

.LN290:
	r8=2840;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ54-1;
.LCJ54:
.LN291:
	jump (pc,.P72L3);

.P72L2:

.P72L3:
.LN292:
// line 2845
	dm(-3,i6)=m13;

.P72L4:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 2845 col 9
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 21 
//   cycles (includes 8 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     shift immediate                 used  11 out of   21 ( 52.4%)
//     dm dag                          used   9 out of   21 ( 42.9%)
//     pm dag                          used   9 out of   21 ( 42.9%)
//     multifunction alu               used   8 out of   21 ( 38.1%)
//     multifunction float multiply    used   8 out of   21 ( 38.1%)
//     multifunction integer add sub   used   8 out of   21 ( 38.1%)
//     multifunction integer multiply  used   8 out of   21 ( 38.1%)
//     multifunction mult              used   8 out of   21 ( 38.1%)
//     memory access                   used  11 out of   42 ( 26.2%)
//-------------------------------------------------------------------
	// -- 2 stalls --
	r1=dm(-3,i6);
	r2=lshift r1 by -3;
	if not sz jump (pc,.P72L6);

.LN293:
// line 2847
	r2=lshift r1 by 3;
	i4=r2;
	// -- 4 stalls --
	i4=modify(i4,xQueueRegistry.);
	r2=dm(m6,i4);
	r0=dm(-4,i6);
	comp(r2,r0);
	if ne jump (pc,.P72L8);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN294:
// line 2849
	r2=dm(-3,i6);
	r2=lshift r2 by 3;
	i4=r2;
	i4=modify(i4,xQueueRegistry.);
	r2=dm(i4,m5);
	dm(-2,i6)=r2;
.LN295:
// line 2850
	jump (pc,.P72L10);

.P72L8:
//-------------------------------------------------------------------
//   Part of Loop 4, depth 1
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN296:
// line 2845
	r2=r1+1;
	dm(-3,i6)=r2;
	jump (pc,.P72L4);
//-------------------------------------------------------------------
//   End Loop L4
//-------------------------------------------------------------------

.P72L6:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------

.P72L10:
.LN297:
// line 2858
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.pcQueueGetName..end:
.pcQueueGetName..end:
	.global pcQueueGetName.;
	.type pcQueueGetName.,STT_FUNC;

vQueueUnregisterQueue.:
.LNvQueueUnregisterQueue.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0-r2,r4,r8,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2867
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
	r2=pass r4;
.LN298:
// line 2870
	if ne jump (pc,.P73L2);

.LN299:
	r8=2870;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ55-1;
.LCJ55:
.LN300:
	jump (pc,.P73L3);

.P73L2:

.P73L3:
.LN301:
// line 2874
	dm(-2,i6)=m13;

.P73L4:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 2874 col 9
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 21 
//   cycles (includes 8 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     shift immediate                 used  11 out of   21 ( 52.4%)
//     dm dag                          used   9 out of   21 ( 42.9%)
//     pm dag                          used   9 out of   21 ( 42.9%)
//     multifunction alu               used   8 out of   21 ( 38.1%)
//     multifunction float multiply    used   8 out of   21 ( 38.1%)
//     multifunction integer add sub   used   8 out of   21 ( 38.1%)
//     multifunction integer multiply  used   8 out of   21 ( 38.1%)
//     multifunction mult              used   8 out of   21 ( 38.1%)
//     memory access                   used  11 out of   42 ( 26.2%)
//-------------------------------------------------------------------
	// -- 2 stalls --
	r1=dm(-2,i6);
	r2=lshift r1 by -3;
	if not sz jump (pc,.P73L6);

.LN302:
// line 2876
	r2=lshift r1 by 3;
	i4=r2;
	// -- 4 stalls --
	i4=modify(i4,xQueueRegistry.);
	r2=dm(m6,i4);
	r0=dm(-3,i6);
	comp(r2,r0);
	if ne jump (pc,.P73L8);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN303:
// line 2879
	r2=dm(-2,i6);
	r2=lshift r2 by 3;
	i4=r2;
	i4=modify(i4,xQueueRegistry.);
	dm(m5,i4)=m13;
.LN304:
// line 2884
	r2=dm(-2,i6);
	r2=lshift r2 by 3;
	i4=r2;
	i4=modify(i4,xQueueRegistry.);
	dm(m6,i4)=m13;
.LN305:
// line 2885
	jump (pc,.P73L10);

.P73L8:
//-------------------------------------------------------------------
//   Part of Loop 4, depth 1
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN306:
// line 2874
	r2=r1+1;
	dm(-2,i6)=r2;
	jump (pc,.P73L4);
//-------------------------------------------------------------------
//   End Loop L4
//-------------------------------------------------------------------

.P73L6:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------

.P73L10:
.LN307:
// line 2892
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vQueueUnregisterQueue..end:
.vQueueUnregisterQueue..end:
	.global vQueueUnregisterQueue.;
	.type vQueueUnregisterQueue.,STT_FUNC;

vQueueDelete.:
.LNvQueueDelete.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,r4,r8,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2094
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN308:
// line 2095
	dm(-2,i6)=r4;
	r2=pass r4;
.LN309:
// line 2097
	if ne jump (pc,.P74L2);

.LN310:
	r8=2097;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ56-1;
.LCJ56:
.LN311:
	jump (pc,.P74L3);

.P74L2:

.P74L3:
.LN312:
// line 2102
	r4=dm(-2,i6);
.LN313:
	cjump vQueueUnregisterQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ57-1;
.LCJ57:
.LN314:
// line 2116
	i4=dm(-2,i6);
	i4=modify(i4,70);
	r2=dm(m5,i4) (bw);
	r2=pass r2;
	if ne jump (pc,.P74L5);

.LN315:
// line 2118
	r4=dm(-2,i6);
.LN316:
	cjump vPortFree. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ58-1;
.LCJ58:
.LN317:
// line 2119
	jump (pc,.P74L6);

.P74L5:

.P74L6:
.LN318:
// line 2132
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vQueueDelete..end:
.vQueueDelete..end:
	.global vQueueDelete.;
	.type vQueueDelete.,STT_FUNC;

xQueueCreateSet.:
.LNxQueueCreateSet.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r8,r12,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2940
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN319:
// line 2943
	r12=m5;
	r8=4;
	cjump xQueueGenericCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ59-1;
.LCJ59:
.LN320:
	dm(-2,i6)=r0;
.LN321:
// line 2945
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueCreateSet..end:
.xQueueCreateSet..end:
	.global xQueueCreateSet.;
	.type xQueueCreateSet.,STT_FUNC;

xQueueAddToSet.:
.LNxQueueAddToSet.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2955
	modify(i7,-4) (nw);
	dm(-3,i6)=r8;
	dm(-4,i6)=r4;
.LN322:
// line 2958
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ60-1;
.LCJ60:
.LN323:
// line 2960
	i4=dm(-4,i6);
	r2=dm(18,i4);
	r2=pass r2;
	if eq jump (pc,.P77L2);

.LN324:
// line 2963
	dm(-2,i6)=m13;
.LN325:
// line 2964
	jump (pc,.P77L3);

.P77L2:
.LN326:
// line 2965
	i4=modify(i4,56);
	r2=dm(i4,m5);
	r2=pass r2;
	if eq jump (pc,.P77L5);

.LN327:
// line 2969
	dm(-2,i6)=m13;
.LN328:
// line 2970
	jump (pc,.P77L6);

.P77L5:
.LN329:
// line 2973
	r2=dm(-3,i6);
	i4=dm(-4,i6);
	dm(18,i4)=r2;
.LN330:
// line 2974
	dm(-2,i6)=m14;

.P77L6:

.P77L3:
.LN331:
// line 2977
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ61-1;
.LCJ61:
.LN332:
// line 2979
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueAddToSet..end:
.xQueueAddToSet..end:
	.global xQueueAddToSet.;
	.type xQueueAddToSet.,STT_FUNC;

xQueueRemoveFromSet.:
.LNxQueueRemoveFromSet.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2989
	modify(i7,-4) (nw);
	i4=r4;
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
.LN333:
// line 2991
	dm(-2,i6)=r4;
.LN334:
// line 2993
	r2=dm(18,i4);
	comp(r8,r2);
	if eq jump (pc,.P78L2);

.LN335:
// line 2996
	dm(-3,i6)=m13;
.LN336:
// line 2997
	jump (pc,.P78L3);

.P78L2:
.LN337:
// line 2998
	i4=modify(i4,56);
	r2=dm(i4,m5);
	r2=pass r2;
	if eq jump (pc,.P78L5);

.LN338:
// line 3003
	dm(-3,i6)=m13;
.LN339:
// line 3004
	jump (pc,.P78L6);

.P78L5:
.LN340:
// line 3007
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ62-1;
.LCJ62:
.LN341:
// line 3010
	i4=dm(-2,i6);
	dm(18,i4)=m13;
.LN342:
// line 3012
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ63-1;
.LCJ63:
.LN343:
// line 3013
	dm(-3,i6)=m14;

.P78L6:

.P78L3:
.LN344:
// line 3016
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueRemoveFromSet..end:
.xQueueRemoveFromSet..end:
	.global xQueueRemoveFromSet.;
	.type xQueueRemoveFromSet.,STT_FUNC;

xQueueSelectFromSetFromISR.:
.LNxQueueSelectFromSetFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r8,r12,i4,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":3039
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN345:
// line 3040
	dm(-2,i6)=m13;
.LN346:
// line 3042
	i4=modify(i6,-2) (nw);
	r12=m5;
	r8=i4;
	cjump xQueueReceiveFromISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ64-1;
.LCJ64:
.LN347:
// line 3043
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueSelectFromSetFromISR..end:
.xQueueSelectFromSetFromISR..end:
	.global xQueueSelectFromSetFromISR.;
	.type xQueueSelectFromSetFromISR.,STT_FUNC;

prvNotifyQueueSetContainer.:
.LNprvNotifyQueueSetContainer.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":3052
	modify(i7,-6) (nw);
	dm(-7,i6)=r4;
	i4=r4;
.LN348:
// line 3054
	dm(-5,i6)=m13;
.LN349:
// line 3053
	r2=dm(18,i4);
	dm(-6,i6)=r2;
	r2=pass r2;
.LN350:
// line 3061
	if ne jump (pc,.P80L2);

.LN351:
	r8=3061;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ65-1;
.LCJ65:
.LN352:
	jump (pc,.P80L3);

.P80L2:

.P80L3:
.LN353:
// line 3062
	i4=dm(-6,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	i4=dm(-6,i6);
	r1=dm(15,i4);
	compu(r2,r1);
	if lt jump (pc,.P80L5);

.LN354:
	r8=3062;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ66-1;
.LCJ66:
.LN355:
	jump (pc,.P80L6);

.P80L5:

.P80L6:
.LN356:
// line 3064
	i4=dm(-6,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	i4=dm(-6,i6);
	r1=dm(15,i4);
	compu(r1,r2);
	if le jump (pc,.P80L8);

.LN357:
// line 3066
	i4=modify(i4,69);
	r2=dm(m5,i4) (bw);
	dm(-13,i6)=r2 (bw);
.LN358:
// line 3071
	r4=dm(-6,i6);
.LN359:
	i4=modify(i6,-7) (nw);
	r12=m5;
	r8=i4;
	cjump prvCopyDataToQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ67-1;
.LCJ67:
.LN360:
	dm(-5,i6)=r0;
.LN361:
// line 3073
	r2=dm(-13,i6) (bwse);
	r1=m7;
	comp(r2,r1);
	if ne jump (pc,.P80L11);

.LN362:
// line 3075
	i4=dm(-6,i6);
	i4=modify(i4,36);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P80L17);

	dm(-3,i6)=m14;
	jump (pc,.P80L18);

.P80L17:
	dm(-3,i6)=m13;

.P80L18:
	r2=dm(-3,i6);
	r2=pass r2;
	if ne jump (pc,.P80L14);

.LN363:
// line 3077
	r8=dm(-6,i6);
	r12=36;
	r4=r8+r12;
.LN364:
	cjump xTaskRemoveFromEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ68-1;
.LCJ68:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN365:
	if eq jump (pc,.P80L20);

.LN366:
// line 3080
	dm(-5,i6)=m14;
.LN367:
// line 3081
	jump (pc,.P80L21);

.P80L20:

.P80L21:
.LN368:
// line 3086
	jump (pc,.P80L15);

.P80L14:

.P80L15:
.LN369:
// line 3091
	jump (pc,.P80L12);

.P80L11:
.LN370:
// line 3094
	cjump uxTaskGetNumberOfTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ69-1;
.LCJ69:
.LN371:
	dm(-2,i6)=r0;
.LN372:
	r2=dm(-13,i6) (bwse);
	compu(r0,r2);
	if le jump (pc,.P80L23);

	r1=127;
	comp(r2,r1);
.LN373:
	if ne jump (pc,.P80L26);

.LN374:
	r8=3094;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ70-1;
.LCJ70:
.LN375:
	jump (pc,.P80L27);

.P80L26:

.P80L27:
.LN376:
	r2=dm(-13,i6) (bwse);
	r2=r2+1;
	i4=dm(-6,i6);
	i4=modify(i4,69);
	dm(m5,i4)=r2 (bw);
.LN377:
	jump (pc,.P80L24);

.P80L23:

.P80L24:

.P80L12:
.LN378:
// line 3096
	jump (pc,.P80L9);

.P80L8:

.P80L9:
.LN379:
// line 3102
	r0=dm(-5,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvNotifyQueueSetContainer..end:
.prvNotifyQueueSetContainer..end:
	.type prvNotifyQueueSetContainer.,STT_FUNC;

xQueueGiveFromISR.:
.LNxQueueGiveFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 48 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":1232
	modify(i7,-10) (nw);
	dm(-10,i6)=r8;
	dm(-11,i6)=r4;
.LN380:
// line 1235
	dm(-7,i6)=r4;
	r2=pass r4;
.LN381:
// line 1243
	if ne jump (pc,.P81L2);

.LN382:
	r8=1243;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ71-1;
.LCJ71:
.LN383:
	jump (pc,.P81L3);

.P81L2:

.P81L3:
.LN384:
// line 1247
	i4=dm(-7,i6);
	r2=dm(16,i4);
	r2=pass r2;
	if eq jump (pc,.P81L5);

.LN385:
	r8=1247;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ72-1;
.LCJ72:
.LN386:
	jump (pc,.P81L6);

.P81L5:

.P81L6:
.LN387:
// line 1252
	i4=dm(-7,i6);
	r2=dm(i4,m5);
	r2=pass r2;
	if eq jump (pc,.P81L11);

.P81L10:
	dm(-6,i6)=m13;
	jump (pc,.P81L13);

.P81L11:
	r2=dm(2,i4);
	r2=pass r2;
	if eq jump (pc,.P81L10);

	dm(-6,i6)=m14;

.P81L13:
	r2=dm(-6,i6);
	r2=pass r2;
	if eq jump (pc,.P81L8);

.LN388:
	r8=1252;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ73-1;
.LCJ73:
.LN389:
	jump (pc,.P81L9);

.P81L8:

.P81L9:
.LN390:
// line 1268
	cjump vPortValidateInterruptPriority. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ74-1;
.LCJ74:
.LN391:
// line 1270
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ75-1;
.LCJ75:
.LN392:
	dm(-8,i6)=r0;
.LN393:
// line 1272
	i4=dm(-7,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	dm(-5,i6)=r2;
.LN394:
// line 1277
	i4=dm(-7,i6);
	r1=dm(15,i4);
	compu(r1,r2);
	if le jump (pc,.P81L15);

.LN395:
// line 1279
	i4=modify(i4,69);
	r2=dm(m5,i4) (bw);
	dm(-13,i6)=r2 (bw);
.LN396:
// line 1289
	r2=dm(-5,i6);
	r2=r2+1;
	i4=dm(-7,i6);
	i4=modify(i4,56);
	dm(i4,m5)=r2;
.LN397:
// line 1293
	r2=dm(-13,i6) (bwse);
	r1=m7;
	comp(r2,r1);
	if ne jump (pc,.P81L18);

.LN398:
// line 1297
	i4=dm(-7,i6);
	r2=dm(18,i4);
	r2=pass r2;
	if eq jump (pc,.P81L21);

.LN399:
// line 1299
	r4=dm(-7,i6);
.LN400:
	cjump prvNotifyQueueSetContainer. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ76-1;
.LCJ76:
	r2=pass r0;
.LN401:
	if eq jump (pc,.P81L24);

.LN402:
// line 1304
	r2=dm(-10,i6);
	r2=pass r2;
	if eq jump (pc,.P81L27);

	i4=r2;
.LN403:
// line 1306
	dm(m5,i4)=m14;
.LN404:
// line 1307
	jump (pc,.P81L28);

.P81L27:

.P81L28:
.LN405:
// line 1312
	jump (pc,.P81L25);

.P81L24:

.P81L25:
.LN406:
// line 1317
	jump (pc,.P81L22);

.P81L21:
.LN407:
// line 1320
	i4=modify(i4,36);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P81L33);

	dm(-3,i6)=m14;
	jump (pc,.P81L34);

.P81L33:
	dm(-3,i6)=m13;

.P81L34:
	r2=dm(-3,i6);
	r2=pass r2;
	if ne jump (pc,.P81L30);

.LN408:
// line 1322
	r8=dm(-7,i6);
	r12=36;
	r4=r8+r12;
.LN409:
	cjump xTaskRemoveFromEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ77-1;
.LCJ77:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN410:
	if eq jump (pc,.P81L36);

.LN411:
// line 1326
	r2=dm(-10,i6);
	r2=pass r2;
	if eq jump (pc,.P81L39);

	i4=r2;
.LN412:
// line 1328
	dm(m5,i4)=m14;
.LN413:
// line 1329
	jump (pc,.P81L40);

.P81L39:

.P81L40:
.LN414:
// line 1334
	jump (pc,.P81L37);

.P81L36:

.P81L37:
.LN415:
// line 1339
	jump (pc,.P81L31);

.P81L30:

.P81L31:

.P81L22:
.LN416:
// line 1374
	jump (pc,.P81L19);

.P81L18:
.LN417:
// line 1379
	cjump uxTaskGetNumberOfTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ78-1;
.LCJ78:
.LN418:
	dm(-2,i6)=r0;
.LN419:
	r2=dm(-13,i6) (bwse);
	compu(r0,r2);
	if le jump (pc,.P81L42);

	r1=127;
	comp(r2,r1);
.LN420:
	if ne jump (pc,.P81L45);

.LN421:
	r8=1379;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ79-1;
.LCJ79:
.LN422:
	jump (pc,.P81L46);

.P81L45:

.P81L46:
.LN423:
	r2=dm(-13,i6) (bwse);
	r2=r2+1;
	i4=dm(-7,i6);
	i4=modify(i4,69);
	dm(m5,i4)=r2 (bw);
.LN424:
	jump (pc,.P81L43);

.P81L42:

.P81L43:

.P81L19:
.LN425:
// line 1382
	dm(-9,i6)=m14;
.LN426:
// line 1383
	jump (pc,.P81L16);

.P81L15:
.LN427:
// line 1387
	dm(-9,i6)=m13;

.P81L16:
.LN428:
// line 1390
	r4=dm(-8,i6);
.LN429:
	cjump vPortClearInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ80-1;
.LCJ80:
.LN430:
// line 1392
	r0=dm(-9,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueGiveFromISR..end:
.xQueueGiveFromISR..end:
	.global xQueueGiveFromISR.;
	.type xQueueGiveFromISR.,STT_FUNC;

xQueueGenericSendFromISR.:
.LNxQueueGenericSendFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 64 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":1069
	modify(i7,-14) (nw);
	dm(-14,i6)=r15;
	r2=dm(m6,i6);
	dm(m6,i6)=r2;
	dm(-11,i6)=r12;
	dm(-12,i6)=r8;
	dm(-13,i6)=r4;
.LN431:
// line 1072
	dm(-8,i6)=r4;
	r2=pass r4;
.LN432:
// line 1074
	if ne jump (pc,.P82L2);

.LN433:
	r8=1074;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ81-1;
.LCJ81:
.LN434:
	jump (pc,.P82L3);

.P82L2:

.P82L3:
.LN435:
// line 1075
	r2=dm(-12,i6);
	r2=pass r2;
	if eq jump (pc,.P82L8);

.P82L7:
	dm(-7,i6)=m13;
	jump (pc,.P82L10);

.P82L8:
	i4=dm(-8,i6);
	r2=dm(16,i4);
	r2=pass r2;
	if eq jump (pc,.P82L7);

	dm(-7,i6)=m14;

.P82L10:
	r2=dm(-7,i6);
	r2=pass r2;
	if eq jump (pc,.P82L5);

.LN436:
	r8=1075;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ82-1;
.LCJ82:
.LN437:
	jump (pc,.P82L6);

.P82L5:

.P82L6:
.LN438:
// line 1076
	r2=dm(m6,i6);
	r15=m6;
	r2=btgl r2 by r15;
	if sz jump (pc,.P82L15);

.P82L14:
	dm(-6,i6)=m13;
	jump (pc,.P82L17);

.P82L15:
	i4=dm(-8,i6);
	r2=dm(15,i4);
	r1=m5;
	r2=btgl r2 by r1;
	if sz jump (pc,.P82L14);

	dm(-6,i6)=m14;

.P82L17:
	r2=dm(-6,i6);
	r2=pass r2;
	if eq jump (pc,.P82L12);

.LN439:
	r8=1076;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ83-1;
.LCJ83:
.LN440:
	jump (pc,.P82L13);

.P82L12:

.P82L13:
.LN441:
// line 1092
	cjump vPortValidateInterruptPriority. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ84-1;
.LCJ84:
.LN442:
// line 1099
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ85-1;
.LCJ85:
.LN443:
	dm(-9,i6)=r0;
.LN444:
// line 1101
	i4=dm(-8,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	i4=dm(-8,i6);
	r1=dm(15,i4);
	compu(r2,r1);
	if lt jump (pc,.P82L18);

	r2=dm(m6,i6);
	r2=btgl r2 by r15;
	if not sz jump (pc,.P82L19);

.P82L18:
.LN445:
// line 1103
	i4=modify(i4,69);
	r2=dm(m5,i4) (bw);
	dm(-17,i6)=r2 (bw);
.LN446:
// line 1104
	i4=dm(-8,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	dm(-4,i6)=r2;
.LN447:
// line 1113
	r4=dm(-8,i6);
	r8=dm(-12,i6);
	r12=dm(m6,i6);
.LN448:
	cjump prvCopyDataToQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ86-1;
.LCJ86:
.LN449:
// line 1117
	r2=dm(-17,i6) (bwse);
	r1=m7;
	comp(r2,r1);
	if ne jump (pc,.P82L23);

.LN450:
// line 1121
	i4=dm(-8,i6);
	r2=dm(18,i4);
	r2=pass r2;
	if eq jump (pc,.P82L26);

.LN451:
// line 1123
	r2=dm(m6,i6);
	r2=btgl r2 by r15;
	if not sz jump (pc,.P82L29);

	r2=dm(-4,i6);
	r2=pass r2;
	if eq jump (pc,.P82L29);

.LN452:
// line 1129
	jump (pc,.P82L30);

.P82L29:
.LN453:
// line 1130
	r4=dm(-8,i6);
.LN454:
	cjump prvNotifyQueueSetContainer. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ87-1;
.LCJ87:
	r2=pass r0;
.LN455:
	if eq jump (pc,.P82L33);

.LN456:
// line 1135
	r2=dm(-11,i6);
	r2=pass r2;
	if eq jump (pc,.P82L36);

	i4=r2;
.LN457:
// line 1137
	dm(m5,i4)=m14;
.LN458:
// line 1138
	jump (pc,.P82L37);

.P82L36:

.P82L37:
.LN459:
// line 1143
	jump (pc,.P82L34);

.P82L33:

.P82L34:

.P82L30:
.LN460:
// line 1148
	jump (pc,.P82L27);

.P82L26:
.LN461:
// line 1151
	i4=modify(i4,36);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P82L42);

	dm(-3,i6)=m14;
	jump (pc,.P82L43);

.P82L42:
	dm(-3,i6)=m13;

.P82L43:
	r2=dm(-3,i6);
	r2=pass r2;
	if ne jump (pc,.P82L39);

.LN462:
// line 1153
	r8=dm(-8,i6);
	r12=36;
	r4=r8+r12;
.LN463:
	cjump xTaskRemoveFromEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ88-1;
.LCJ88:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN464:
	if eq jump (pc,.P82L45);

.LN465:
// line 1157
	r2=dm(-11,i6);
	r2=pass r2;
	if eq jump (pc,.P82L48);

	i4=r2;
.LN466:
// line 1159
	dm(m5,i4)=m14;
.LN467:
// line 1160
	jump (pc,.P82L49);

.P82L48:

.P82L49:
.LN468:
// line 1165
	jump (pc,.P82L46);

.P82L45:

.P82L46:
.LN469:
// line 1170
	jump (pc,.P82L40);

.P82L39:

.P82L40:

.P82L27:
.LN470:
// line 1208
	jump (pc,.P82L24);

.P82L23:
.LN471:
// line 1213
	cjump uxTaskGetNumberOfTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ89-1;
.LCJ89:
.LN472:
	dm(-2,i6)=r0;
.LN473:
	r2=dm(-17,i6) (bwse);
	compu(r0,r2);
	if le jump (pc,.P82L51);

	r1=127;
	comp(r2,r1);
.LN474:
	if ne jump (pc,.P82L54);

.LN475:
	r8=1213;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ90-1;
.LCJ90:
.LN476:
	jump (pc,.P82L55);

.P82L54:

.P82L55:
.LN477:
	r2=dm(-17,i6) (bwse);
	r2=r2+1;
	i4=dm(-8,i6);
	i4=modify(i4,69);
	dm(m5,i4)=r2 (bw);
.LN478:
	jump (pc,.P82L52);

.P82L51:

.P82L52:

.P82L24:
.LN479:
// line 1216
	dm(-10,i6)=m14;
.LN480:
// line 1217
	jump (pc,.P82L20);

.P82L19:
.LN481:
// line 1221
	dm(-10,i6)=m13;

.P82L20:
.LN482:
// line 1224
	r4=dm(-9,i6);
.LN483:
	cjump vPortClearInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ91-1;
.LCJ91:
.LN484:
// line 1226
	r0=dm(-10,i6);
	r15=dm(-14,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueGenericSendFromISR..end:
.xQueueGenericSendFromISR..end:
	.global xQueueGenericSendFromISR.;
	.type xQueueGenericSendFromISR.,STT_FUNC;

prvUnlockQueue.:
.LNprvUnlockQueue.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2298
	modify(i7,-6) (nw);
	dm(-6,i6)=r4;
.LN485:
// line 2305
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ92-1;
.LCJ92:
.LN486:
// line 2307
	i4=dm(-6,i6);
	i4=modify(i4,69);
	r2=dm(m5,i4) (bw);
	dm(-17,i6)=r2 (bw);

.P83L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 2310 col 9
//-------------------------------------------------------------------
.LN487:
// line 2310
	r2=dm(-17,i6) (bwse);
	r2=pass r2;
	if le jump (pc,.P83L2);

.LN488:
// line 2316
	i4=dm(-6,i6);
	r2=dm(18,i4);
	r2=pass r2;
	if eq jump (pc,.P83L5);

.LN489:
// line 2318
	r4=dm(-6,i6);
.LN490:
	cjump prvNotifyQueueSetContainer. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ93-1;
.LCJ93:
	r2=pass r0;
.LN491:
	if eq jump (pc,.P83L8);

.LN492:
// line 2323
	cjump vTaskMissedYield. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ94-1;
.LCJ94:
.LN493:
// line 2324
	jump (pc,.P83L9);

.P83L8:

.P83L9:
.LN494:
// line 2329
	jump (pc,.P83L6);

.P83L5:
.LN495:
// line 2335
	i4=modify(i4,36);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if ne jump (pc,.P83L14);

	dm(-4,i6)=m14;
	jump (pc,.P83L15);

.P83L14:
	dm(-4,i6)=m13;

.P83L15:
	r2=dm(-4,i6);
	r2=pass r2;
	if ne jump (pc,.P83L11);

.LN496:
// line 2337
	r8=dm(-6,i6);
	r12=36;
	r4=r8+r12;
.LN497:
	cjump xTaskRemoveFromEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ95-1;
.LCJ95:
	dm(-4,i6)=r0;
	r2=pass r0;
.LN498:
	if eq jump (pc,.P83L17);

.LN499:
// line 2341
	cjump vTaskMissedYield. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ96-1;
.LCJ96:
.LN500:
// line 2342
	jump (pc,.P83L18);

.P83L17:

.P83L18:
.LN501:
// line 2352
	jump (pc,.P83L6);

.P83L11:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN502:
// line 2350
	jump (pc,.P83L19);

.P83L6:
//-------------------------------------------------------------------
//   Part of Loop 1, depth 1
//-------------------------------------------------------------------
.LN503:
// line 2378
	r2=dm(-17,i6) (bwse);
	r2=r2-1;
	dm(-17,i6)=r2 (bw);
	jump (pc,.P83L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P83L2:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------

.P83L19:
.LN504:
// line 2381
	i4=dm(-6,i6);
	i4=modify(i4,69);
	dm(m5,i4)=m15 (bw);
.LN505:
// line 2383
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ97-1;
.LCJ97:
.LN506:
// line 2386
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ98-1;
.LCJ98:
.LN507:
// line 2388
	i4=dm(-6,i6);
	i4=modify(i4,68);
	r2=dm(m5,i4) (bw);
	dm(-9,i6)=r2 (bw);

.P83L21:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 2390 col 9
//-------------------------------------------------------------------
.LN508:
// line 2390
	r2=dm(-9,i6) (bwse);
	r2=pass r2;
	if le jump (pc,.P83L22);

.LN509:
// line 2392
	i4=dm(-6,i6);
	i4=modify(i4,16);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if ne jump (pc,.P83L28);

	dm(-2,i6)=m14;
	jump (pc,.P83L29);

.P83L28:
	dm(-2,i6)=m13;

.P83L29:
	r2=dm(-2,i6);
	r2=pass r2;
	if ne jump (pc,.P83L25);

.LN510:
// line 2394
	r8=dm(-6,i6);
	r12=16;
	r4=r8+r12;
.LN511:
	cjump xTaskRemoveFromEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ99-1;
.LCJ99:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN512:
	if eq jump (pc,.P83L31);

.LN513:
// line 2396
	cjump vTaskMissedYield. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ100-1;
.LCJ100:
.LN514:
// line 2397
	jump (pc,.P83L32);

.P83L31:

.P83L32:
.LN515:
// line 2403
	r2=dm(-9,i6) (bwse);
	r2=r2-1;
	dm(-9,i6)=r2 (bw);
	jump (pc,.P83L21);
//-------------------------------------------------------------------
//   End Loop L21
//-------------------------------------------------------------------

.P83L25:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN516:
// line 2407
	jump (pc,.P83L33);

.P83L22:

.P83L33:
.LN517:
// line 2411
	i4=dm(-6,i6);
	i4=modify(i4,68);
	dm(m5,i4)=m15 (bw);
.LN518:
// line 2413
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ101-1;
.LCJ101:
.LN519:
// line 2414
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvUnlockQueue..end:
.prvUnlockQueue..end:
	.type prvUnlockQueue.,STT_FUNC;

xQueueReceive.:
.LNxQueueReceive.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 64 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,btf}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":1399
	modify(i7,-14) (nw);
	r2=i5;
	dm(-14,i6)=r2;
	dm(-9,i6)=r12;
	dm(-10,i6)=r8;
	dm(-11,i6)=r4;
.LN520:
// line 1400
	dm(-8,i6)=m13;
.LN521:
// line 1402
	dm(-7,i6)=r4;
	r2=pass r4;
.LN522:
// line 1405
	if ne jump (pc,.P85L2);

.LN523:
	r8=1405;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ102-1;
.LCJ102:
.LN524:
	jump (pc,.P85L3);

.P85L2:

.P85L3:
.LN525:
// line 1409
	r2=dm(-10,i6);
	r2=pass r2;
	if eq jump (pc,.P85L8);

.P85L7:
	dm(-6,i6)=m13;
	jump (pc,.P85L10);

.P85L8:
	i4=dm(-7,i6);
	r2=dm(16,i4);
	r2=pass r2;
	if eq jump (pc,.P85L7);

	dm(-6,i6)=m14;

.P85L10:
	r2=dm(-6,i6);
	r2=pass r2;
	if eq jump (pc,.P85L5);

.LN526:
	r8=1409;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ103-1;
.LCJ103:
.LN527:
	jump (pc,.P85L6);

.P85L5:

.P85L6:
.LN528:
// line 1414
	cjump xTaskGetSchedulerState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ104-1;
.LCJ104:
	dm(-5,i6)=r0;
.LN529:
	r2=pass r0;
	if eq jump (pc,.P85L15);

.P85L14:
	dm(-5,i6)=m13;
	jump (pc,.P85L17);

.P85L15:
	r2=dm(-9,i6);
	r2=pass r2;
	if eq jump (pc,.P85L14);

	dm(-5,i6)=m14;

.P85L17:
	r2=dm(-5,i6);
	r2=pass r2;
	if eq jump (pc,.P85L12);

.LN530:
	r8=1414;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ105-1;
.LCJ105:
.LN531:
	jump (pc,.P85L13);

.P85L12:

.P85L13:
.LN532:
// line 1421
	jump (pc,.P85L18);

.P85L77:
//-------------------------------------------------------------------
//   Part of Loop 18, depth 1
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//   End Loop L18
//-------------------------------------------------------------------

.P85L18:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 1421 col 5
//-------------------------------------------------------------------
.LN533:
// line 1423
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ106-1;
.LCJ106:
.LN534:
// line 1425
	i4=dm(-7,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	dm(-4,i6)=r2;
	r2=pass r2;
.LN535:
// line 1429
	if eq jump (pc,.P85L22);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN536:
// line 1432
	r4=dm(-7,i6);
	r8=dm(-10,i6);
.LN537:
	cjump prvCopyDataFromQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ107-1;
.LCJ107:
.LN538:
// line 1434
	r2=dm(-4,i6);
	r2=r2-1;
	i4=dm(-7,i6);
	i4=modify(i4,56);
	dm(i4,m5)=r2;
.LN539:
// line 1439
	i4=dm(-7,i6);
	i4=modify(i4,16);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P85L28);

	dm(-3,i6)=m14;
	jump (pc,.P85L29);

.P85L28:
	dm(-3,i6)=m13;

.P85L29:
	r2=dm(-3,i6);
	r2=pass r2;
	if ne jump (pc,.P85L25);

.LN540:
// line 1441
	r8=dm(-7,i6);
	r12=16;
	r4=r8+r12;
.LN541:
	cjump xTaskRemoveFromEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ108-1;
.LCJ108:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN542:
	if eq jump (pc,.P85L31);

.LN543:
// line 1443
	dm(_adi_OSWaitingForSched.)=m6;
.LN544:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN545:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	dm(-3,i6)=r2;
	r2=pass r2;
	if eq jump (pc,.P85L34);


.P85L38:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 1443 col 25
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 6 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   4 out of    6 ( 66.7%)
//     multifunction float multiply    used   4 out of    6 ( 66.7%)
//     multifunction integer add sub   used   4 out of    6 ( 66.7%)
//     multifunction integer multiply  used   4 out of    6 ( 66.7%)
//     multifunction mult              used   4 out of    6 ( 66.7%)
//     dm dag                          used   3 out of    6 ( 50.0%)
//     pm dag                          used   3 out of    6 ( 50.0%)
//     shift immediate                 used   3 out of    6 ( 50.0%)
//     memory access                   used   3 out of   12 ( 25.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN546:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P85L39);

	jump (pc,.P85L38);
//-------------------------------------------------------------------
//   End Loop L38
//-------------------------------------------------------------------

.P85L39:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN547:
	jump (pc,.P85L35);

.P85L34:

.P85L35:
.LN548:
// line 1444
	jump (pc,.P85L32);

.P85L31:

.P85L32:
.LN549:
// line 1449
	jump (pc,.P85L26);

.P85L25:

.P85L26:
.LN550:
// line 1455
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ109-1;
.LCJ109:
.LN551:
// line 1456
	dm(-2,i6)=m14;
	jump (pc,.P85L41);

.P85L22:
//-------------------------------------------------------------------
//   Part of Loop 18, depth 1
//-------------------------------------------------------------------
.LN552:
// line 1460
	r2=dm(-9,i6);
	r2=pass r2;
	if ne jump (pc,.P85L44);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN553:
// line 1464
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ110-1;
.LCJ110:
.LN554:
// line 1466
	dm(-2,i6)=m13;
	jump (pc,.P85L41);

.P85L44:
//-------------------------------------------------------------------
//   Part of Loop 18, depth 1
//-------------------------------------------------------------------
.LN555:
// line 1468
	r2=dm(-8,i6);
	r2=pass r2;
	if ne jump (pc,.P85L48);

.LN556:
// line 1472
	i4=modify(i6,-13) (nw);
	r4=i4;
	cjump vTaskInternalSetTimeOutState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ111-1;
.LCJ111:
.LN557:
// line 1473
	dm(-8,i6)=m14;
.LN558:
// line 1474
	jump (pc,.P85L49);

.P85L48:

.P85L49:
.LN559:
// line 1482
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ112-1;
.LCJ112:
.LN560:
// line 1487
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ113-1;
.LCJ113:
.LN561:
// line 1488
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ114-1;
.LCJ114:
.LN562:
	i4=dm(-7,i6);
	i4=modify(i4,68);
	r2=dm(m5,i4) (bwse);                      // Use of volatile in loops precludes optimizations. 
	r1=m7;
	comp(r2,r1);
	if ne jump (pc,.P85L51);

.LN563:
	i4=dm(-7,i6);
	i4=modify(i4,68);
	dm(m5,i4)=m13 (bw);                       // Use of volatile in loops precludes optimizations. 
.LN564:
	jump (pc,.P85L52);

.P85L51:

.P85L52:
.LN565:
	i4=dm(-7,i6);
	i4=modify(i4,69);
	r2=dm(m5,i4) (bwse);                      // Use of volatile in loops precludes optimizations. 
	comp(r2,r1);
	if ne jump (pc,.P85L54);

.LN566:
	i4=dm(-7,i6);
	i4=modify(i4,69);
	dm(m5,i4)=m13 (bw);                       // Use of volatile in loops precludes optimizations. 
.LN567:
	jump (pc,.P85L55);

.P85L54:

.P85L55:
.LN568:
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ115-1;
.LCJ115:
.LN569:
// line 1491
	i5=modify(i6,-13) (nw);
	i4=modify(i6,-9) (nw);
	r8=i4;
	r4=i5;
	cjump xTaskCheckForTimeOut. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ116-1;
.LCJ116:
	r2=pass r0;
.LN570:
	if ne jump (pc,.P85L57);

.LN571:
// line 1495
	r4=dm(-7,i6);
.LN572:
	cjump prvIsQueueEmpty. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ117-1;
.LCJ117:
	r2=pass r0;
.LN573:
	if eq jump (pc,.P85L60);

.LN574:
// line 1498
	r8=dm(-7,i6);
	r12=36;
	r4=r8+r12;
	r8=dm(-9,i6);
.LN575:
	cjump vTaskPlaceOnEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ118-1;
.LCJ118:
.LN576:
// line 1499
	r4=dm(-7,i6);
.LN577:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ119-1;
.LCJ119:
.LN578:
// line 1501
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ120-1;
.LCJ120:
	r2=pass r0;
.LN579:
	if ne jump (pc,.P85L63);

.LN580:
// line 1503
	dm(_adi_OSWaitingForSched.)=m6;         // Use of volatile in loops precludes optimizations. 
.LN581:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;                       // Use of volatile in loops precludes optimizations. 

.LN582:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P85L66);


.P85L70:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 1503 col 21
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 6 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   4 out of    6 ( 66.7%)
//     multifunction float multiply    used   4 out of    6 ( 66.7%)
//     multifunction integer add sub   used   4 out of    6 ( 66.7%)
//     multifunction integer multiply  used   4 out of    6 ( 66.7%)
//     multifunction mult              used   4 out of    6 ( 66.7%)
//     dm dag                          used   3 out of    6 ( 50.0%)
//     pm dag                          used   3 out of    6 ( 50.0%)
//     shift immediate                 used   3 out of    6 ( 50.0%)
//     memory access                   used   3 out of   12 ( 25.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN583:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P85L71);

	jump (pc,.P85L70);
//-------------------------------------------------------------------
//   End Loop L70
//-------------------------------------------------------------------

.P85L71:
//-------------------------------------------------------------------
//   Part of Loop 18, depth 1
//-------------------------------------------------------------------
.LN584:
	jump (pc,.P85L67);

.P85L66:

.P85L67:
.LN585:
// line 1504
	jump (pc,.P85L64);

.P85L63:

.P85L64:
.LN586:
// line 1509
	jump (pc,.P85L61);

.P85L60:
.LN587:
// line 1514
	r4=dm(-7,i6);
.LN588:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ121-1;
.LCJ121:
.LN589:
// line 1515
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ122-1;
.LCJ122:

.P85L61:
.LN590:
// line 1517
	jump (pc,.P85L58);

.P85L57:
.LN591:
// line 1522
	r4=dm(-7,i6);
.LN592:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ123-1;
.LCJ123:
.LN593:
// line 1523
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ124-1;
.LCJ124:
.LN594:
// line 1525
	r4=dm(-7,i6);
.LN595:
	cjump prvIsQueueEmpty. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ125-1;
.LCJ125:
	r2=pass r0;
.LN596:
	if eq jump (pc,.P85L74);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN597:
// line 1528
	dm(-2,i6)=m13;
	jump (pc,.P85L41);

.P85L74:
//-------------------------------------------------------------------
//   Part of Loop 18, depth 1
//-------------------------------------------------------------------

.P85L58:
.LN598:
// line 1535
	jump (pc,.P85L77);

.P85L41:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN599:
// line 1536
	r0=dm(-2,i6);
	i5=dm(-14,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueReceive..end:
.xQueueReceive..end:
	.global xQueueReceive.;
	.type xQueueReceive.,STT_FUNC;

xQueueSelectFromSet.:
.LNxQueueSelectFromSet.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r8,r12,i4,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":3026
	modify(i7,-4) (nw);
	r12=r8;
	dm(-3,i6)=r8;
	dm(-4,i6)=r4;
.LN600:
// line 3027
	dm(-2,i6)=m13;
.LN601:
// line 3029
	i4=modify(i6,-2) (nw);
	r8=i4;
	cjump xQueueReceive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ126-1;
.LCJ126:
.LN602:
// line 3030
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueSelectFromSet..end:
.xQueueSelectFromSet..end:
	.global xQueueSelectFromSet.;
	.type xQueueSelectFromSet.,STT_FUNC;

xQueueSemaphoreTake.:
.LNxQueueSemaphoreTake.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 64 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,btf}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":1541
	modify(i7,-14) (nw);
	r2=i5;
	dm(-14,i6)=r2;
	dm(-10,i6)=r8;
	dm(-11,i6)=r4;
.LN603:
// line 1542
	dm(-9,i6)=m13;
.LN604:
// line 1547
	dm(-7,i6)=m13;
.LN605:
// line 1544
	dm(-8,i6)=r4;
	r2=pass r4;
.LN606:
// line 1551
	if ne jump (pc,.P93L2);

.LN607:
	r8=1551;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ127-1;
.LCJ127:
.LN608:
	jump (pc,.P93L3);

.P93L2:

.P93L3:
.LN609:
// line 1555
	i4=dm(-8,i6);
	r2=dm(16,i4);
	r2=pass r2;
	if eq jump (pc,.P93L5);

.LN610:
	r8=1555;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ128-1;
.LCJ128:
.LN611:
	jump (pc,.P93L6);

.P93L5:

.P93L6:
.LN612:
// line 1560
	cjump xTaskGetSchedulerState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ129-1;
.LCJ129:
	dm(-6,i6)=r0;
.LN613:
	r2=pass r0;
	if eq jump (pc,.P93L11);

.P93L10:
	dm(-6,i6)=m13;
	jump (pc,.P93L13);

.P93L11:
	r2=dm(-10,i6);
	r2=pass r2;
	if eq jump (pc,.P93L10);

	dm(-6,i6)=m14;

.P93L13:
	r2=dm(-6,i6);
	r2=pass r2;
	if eq jump (pc,.P93L8);

.LN614:
	r8=1560;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ130-1;
.LCJ130:
.LN615:
	jump (pc,.P93L9);

.P93L8:

.P93L9:
.LN616:
// line 1567
	jump (pc,.P93L14);

.P93L82:
//-------------------------------------------------------------------
//   Part of Loop 14, depth 1
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//   End Loop L14
//-------------------------------------------------------------------

.P93L14:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 1567 col 5
//-------------------------------------------------------------------
.LN617:
// line 1569
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ131-1;
.LCJ131:
.LN618:
// line 1573
	i4=dm(-8,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	dm(-5,i6)=r2;
	r2=pass r2;
.LN619:
// line 1577
	if eq jump (pc,.P93L18);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN620:
// line 1583
	r2=dm(-5,i6);
	r2=r2-1;
	i4=dm(-8,i6);
	i4=modify(i4,56);
	dm(i4,m5)=r2;
.LN621:
// line 1587
	i4=dm(-8,i6);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P93L21);

.LN622:
// line 1591
	cjump pvTaskIncrementMutexHeldCount. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ132-1;
.LCJ132:
.LN623:
	i4=dm(-8,i6);
	dm(2,i4)=r0;
.LN624:
// line 1592
	jump (pc,.P93L22);

.P93L21:

.P93L22:
.LN625:
// line 1602
	i4=dm(-8,i6);
	i4=modify(i4,16);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P93L27);

	dm(-4,i6)=m14;
	jump (pc,.P93L28);

.P93L27:
	dm(-4,i6)=m13;

.P93L28:
	r2=dm(-4,i6);
	r2=pass r2;
	if ne jump (pc,.P93L24);

.LN626:
// line 1604
	r8=dm(-8,i6);
	r12=16;
	r4=r8+r12;
.LN627:
	cjump xTaskRemoveFromEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ133-1;
.LCJ133:
	dm(-4,i6)=r0;
	r2=pass r0;
.LN628:
	if eq jump (pc,.P93L30);

.LN629:
// line 1606
	dm(_adi_OSWaitingForSched.)=m6;
.LN630:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN631:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	dm(-4,i6)=r2;
	r2=pass r2;
	if eq jump (pc,.P93L33);


.P93L37:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 1606 col 25
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 6 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   4 out of    6 ( 66.7%)
//     multifunction float multiply    used   4 out of    6 ( 66.7%)
//     multifunction integer add sub   used   4 out of    6 ( 66.7%)
//     multifunction integer multiply  used   4 out of    6 ( 66.7%)
//     multifunction mult              used   4 out of    6 ( 66.7%)
//     dm dag                          used   3 out of    6 ( 50.0%)
//     pm dag                          used   3 out of    6 ( 50.0%)
//     shift immediate                 used   3 out of    6 ( 50.0%)
//     memory access                   used   3 out of   12 ( 25.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN632:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P93L38);

	jump (pc,.P93L37);
//-------------------------------------------------------------------
//   End Loop L37
//-------------------------------------------------------------------

.P93L38:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN633:
	jump (pc,.P93L34);

.P93L33:

.P93L34:
.LN634:
// line 1607
	jump (pc,.P93L31);

.P93L30:

.P93L31:
.LN635:
// line 1612
	jump (pc,.P93L25);

.P93L24:

.P93L25:
.LN636:
// line 1618
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ134-1;
.LCJ134:
.LN637:
// line 1619
	dm(-3,i6)=m14;
	jump (pc,.P93L40);

.P93L18:
//-------------------------------------------------------------------
//   Part of Loop 14, depth 1
//-------------------------------------------------------------------
.LN638:
// line 1623
	r2=dm(-10,i6);
	r2=pass r2;
	if ne jump (pc,.P93L43);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN639:
// line 1627
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ135-1;
.LCJ135:
.LN640:
// line 1629
	dm(-3,i6)=m13;
	jump (pc,.P93L40);

.P93L43:
//-------------------------------------------------------------------
//   Part of Loop 14, depth 1
//-------------------------------------------------------------------
.LN641:
// line 1631
	r2=dm(-9,i6);
	r2=pass r2;
	if ne jump (pc,.P93L47);

.LN642:
// line 1635
	i4=modify(i6,-13) (nw);
	r4=i4;
	cjump vTaskInternalSetTimeOutState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ136-1;
.LCJ136:
.LN643:
// line 1636
	dm(-9,i6)=m14;
.LN644:
// line 1637
	jump (pc,.P93L48);

.P93L47:

.P93L48:
.LN645:
// line 1645
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ137-1;
.LCJ137:
.LN646:
// line 1650
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ138-1;
.LCJ138:
.LN647:
// line 1651
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ139-1;
.LCJ139:
.LN648:
	i4=dm(-8,i6);
	i4=modify(i4,68);
	r2=dm(m5,i4) (bwse);                      // Use of volatile in loops precludes optimizations. 
	r1=m7;
	comp(r2,r1);
	if ne jump (pc,.P93L50);

.LN649:
	i4=dm(-8,i6);
	i4=modify(i4,68);
	dm(m5,i4)=m13 (bw);                       // Use of volatile in loops precludes optimizations. 
.LN650:
	jump (pc,.P93L51);

.P93L50:

.P93L51:
.LN651:
	i4=dm(-8,i6);
	i4=modify(i4,69);
	r2=dm(m5,i4) (bwse);                      // Use of volatile in loops precludes optimizations. 
	comp(r2,r1);
	if ne jump (pc,.P93L53);

.LN652:
	i4=dm(-8,i6);
	i4=modify(i4,69);
	dm(m5,i4)=m13 (bw);                       // Use of volatile in loops precludes optimizations. 
.LN653:
	jump (pc,.P93L54);

.P93L53:

.P93L54:
.LN654:
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ140-1;
.LCJ140:
.LN655:
// line 1654
	i5=modify(i6,-13) (nw);
	i4=modify(i6,-10) (nw);
	r8=i4;
	r4=i5;
	cjump xTaskCheckForTimeOut. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ141-1;
.LCJ141:
	r2=pass r0;
.LN656:
	if ne jump (pc,.P93L56);

.LN657:
// line 1660
	r4=dm(-8,i6);
.LN658:
	cjump prvIsQueueEmpty. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ142-1;
.LCJ142:
	r2=pass r0;
.LN659:
	if eq jump (pc,.P93L59);

.LN660:
// line 1666
	i4=dm(-8,i6);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P93L62);

.LN661:
// line 1668
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ143-1;
.LCJ143:
.LN662:
// line 1670
	i4=dm(-8,i6);
	r4=dm(2,i4);
.LN663:
	cjump xTaskPriorityInherit. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ144-1;
.LCJ144:
.LN664:
	dm(-7,i6)=r0;
.LN665:
// line 1672
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ145-1;
.LCJ145:
.LN666:
// line 1673
	jump (pc,.P93L63);

.P93L62:

.P93L63:
.LN667:
// line 1681
	r8=dm(-8,i6);
	r12=36;
	r4=r8+r12;
	r8=dm(-10,i6);
.LN668:
	cjump vTaskPlaceOnEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ146-1;
.LCJ146:
.LN669:
// line 1682
	r4=dm(-8,i6);
.LN670:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ147-1;
.LCJ147:
.LN671:
// line 1684
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ148-1;
.LCJ148:
	r2=pass r0;
.LN672:
	if ne jump (pc,.P93L65);

.LN673:
// line 1686
	dm(_adi_OSWaitingForSched.)=m6;         // Use of volatile in loops precludes optimizations. 
.LN674:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;                       // Use of volatile in loops precludes optimizations. 

.LN675:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P93L68);


.P93L72:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 1686 col 21
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 6 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   4 out of    6 ( 66.7%)
//     multifunction float multiply    used   4 out of    6 ( 66.7%)
//     multifunction integer add sub   used   4 out of    6 ( 66.7%)
//     multifunction integer multiply  used   4 out of    6 ( 66.7%)
//     multifunction mult              used   4 out of    6 ( 66.7%)
//     dm dag                          used   3 out of    6 ( 50.0%)
//     pm dag                          used   3 out of    6 ( 50.0%)
//     shift immediate                 used   3 out of    6 ( 50.0%)
//     memory access                   used   3 out of   12 ( 25.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN676:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P93L73);

	jump (pc,.P93L72);
//-------------------------------------------------------------------
//   End Loop L72
//-------------------------------------------------------------------

.P93L73:
//-------------------------------------------------------------------
//   Part of Loop 14, depth 1
//-------------------------------------------------------------------
.LN677:
	jump (pc,.P93L69);

.P93L68:

.P93L69:
.LN678:
// line 1687
	jump (pc,.P93L66);

.P93L65:

.P93L66:
.LN679:
// line 1692
	jump (pc,.P93L60);

.P93L59:
.LN680:
// line 1697
	r4=dm(-8,i6);
.LN681:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ149-1;
.LCJ149:
.LN682:
// line 1698
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ150-1;
.LCJ150:

.P93L60:
.LN683:
// line 1700
	jump (pc,.P93L57);

.P93L56:
.LN684:
// line 1704
	r4=dm(-8,i6);
.LN685:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ151-1;
.LCJ151:
.LN686:
// line 1705
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ152-1;
.LCJ152:
.LN687:
// line 1711
	r4=dm(-8,i6);
.LN688:
	cjump prvIsQueueEmpty. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ153-1;
.LCJ153:
	r2=pass r0;
.LN689:
	if eq jump (pc,.P93L76);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN690:
// line 1718
	r2=dm(-7,i6);
	r2=pass r2;
	if eq jump (pc,.P93L79);

.LN691:
// line 1720
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ154-1;
.LCJ154:
.LN692:
// line 1729
	r4=dm(-8,i6);
.LN693:
	cjump prvGetDisinheritPriorityAfterTimeout. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ155-1;
.LCJ155:
	r8=r0;
.LN694:
	dm(-2,i6)=r0;
.LN695:
// line 1730
	i4=dm(-8,i6);
	r4=dm(2,i4);
.LN696:
	cjump vTaskPriorityDisinheritAfterTimeout. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ156-1;
.LCJ156:
.LN697:
// line 1732
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ157-1;
.LCJ157:
.LN698:
// line 1733
	jump (pc,.P93L80);

.P93L79:

.P93L80:
.LN699:
// line 1738
	dm(-3,i6)=m13;
	jump (pc,.P93L40);

.P93L76:
//-------------------------------------------------------------------
//   Part of Loop 14, depth 1
//-------------------------------------------------------------------

.P93L57:
.LN700:
// line 1745
	jump (pc,.P93L82);

.P93L40:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN701:
// line 1746
	r0=dm(-3,i6);
	i5=dm(-14,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueSemaphoreTake..end:
.xQueueSemaphoreTake..end:
	.global xQueueSemaphoreTake.;
	.type xQueueSemaphoreTake.,STT_FUNC;

xQueueTakeMutexRecursive.:
.LNxQueueTakeMutexRecursive.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,r8,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":743
	modify(i7,-4) (nw);
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
.LN702:
// line 745
	dm(-2,i6)=r4;
	r2=pass r4;
.LN703:
// line 747
	if ne jump (pc,.P97L2);

.LN704:
	r8=747;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ158-1;
.LCJ158:
.LN705:
	jump (pc,.P97L3);

.P97L2:

.P97L3:
.LN706:
// line 754
	cjump xTaskGetCurrentTaskHandle. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ159-1;
.LCJ159:
.LN707:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	comp(r0,r2);
	if ne jump (pc,.P97L5);

.LN708:
// line 756
	i4=modify(i4,8);
	r2=dm(m6,i4);
	r2=r2+1;
	dm(m6,i4)=r2;
.LN709:
// line 757
	dm(-3,i6)=m14;
.LN710:
// line 758
	jump (pc,.P97L6);

.P97L5:
.LN711:
// line 761
	r4=dm(-2,i6);
	r8=dm(-4,i6);
.LN712:
	cjump xQueueSemaphoreTake. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ160-1;
.LCJ160:
.LN713:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN714:
// line 766
	if eq jump (pc,.P97L8);

.LN715:
// line 768
	i4=dm(-2,i6);
	i4=modify(i4,8);
	r2=dm(m6,i4);
	r2=r2+1;
	dm(m6,i4)=r2;
.LN716:
// line 769
	jump (pc,.P97L9);

.P97L8:

.P97L9:

.P97L6:
.LN717:
// line 776
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueTakeMutexRecursive..end:
.xQueueTakeMutexRecursive..end:
	.global xQueueTakeMutexRecursive.;
	.type xQueueTakeMutexRecursive.,STT_FUNC;

xQueuePeek.:
.LNxQueuePeek.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 64 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,btf}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":1752
	modify(i7,-14) (nw);
	r2=i5;
	dm(-15,i6)=r2;
	dm(-10,i6)=r12;
	dm(-11,i6)=r8;
	dm(-12,i6)=r4;
.LN718:
// line 1753
	dm(-9,i6)=m13;
.LN719:
// line 1756
	dm(-7,i6)=r4;
	r2=pass r4;
.LN720:
// line 1759
	if ne jump (pc,.P99L2);

.LN721:
	r8=1759;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ161-1;
.LCJ161:
.LN722:
	jump (pc,.P99L3);

.P99L2:

.P99L3:
.LN723:
// line 1763
	r2=dm(-11,i6);
	r2=pass r2;
	if eq jump (pc,.P99L8);

.P99L7:
	dm(-6,i6)=m13;
	jump (pc,.P99L10);

.P99L8:
	i4=dm(-7,i6);
	r2=dm(16,i4);
	r2=pass r2;
	if eq jump (pc,.P99L7);

	dm(-6,i6)=m14;

.P99L10:
	r2=dm(-6,i6);
	r2=pass r2;
	if eq jump (pc,.P99L5);

.LN724:
	r8=1763;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ162-1;
.LCJ162:
.LN725:
	jump (pc,.P99L6);

.P99L5:

.P99L6:
.LN726:
// line 1768
	cjump xTaskGetSchedulerState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ163-1;
.LCJ163:
	dm(-5,i6)=r0;
.LN727:
	r2=pass r0;
	if eq jump (pc,.P99L15);

.P99L14:
	dm(-5,i6)=m13;
	jump (pc,.P99L17);

.P99L15:
	r2=dm(-10,i6);
	r2=pass r2;
	if eq jump (pc,.P99L14);

	dm(-5,i6)=m14;

.P99L17:
	r2=dm(-5,i6);
	r2=pass r2;
	if eq jump (pc,.P99L12);

.LN728:
	r8=1768;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ164-1;
.LCJ164:
.LN729:
	jump (pc,.P99L13);

.P99L12:

.P99L13:
.LN730:
// line 1775
	jump (pc,.P99L18);

.P99L77:
//-------------------------------------------------------------------
//   Part of Loop 18, depth 1
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//   End Loop L18
//-------------------------------------------------------------------

.P99L18:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 1775 col 5
//-------------------------------------------------------------------
.LN731:
// line 1777
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ165-1;
.LCJ165:
.LN732:
// line 1779
	i4=dm(-7,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	dm(-4,i6)=r2;
	r2=pass r2;
.LN733:
// line 1783
	if eq jump (pc,.P99L22);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN734:
// line 1788
	r4=dm(-7,i6);
	i4=r4;
	i4=modify(i4,8);
	r2=dm(m6,i4);
	dm(-8,i6)=r2;
.LN735:
// line 1790
	r8=dm(-11,i6);
.LN736:
	cjump prvCopyDataFromQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ166-1;
.LCJ166:
.LN737:
// line 1794
	r2=dm(-8,i6);
	i4=dm(-7,i6);
	i4=modify(i4,8);
	dm(m6,i4)=r2;
.LN738:
// line 1798
	i4=dm(-7,i6);
	i4=modify(i4,36);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P99L28);

	dm(-3,i6)=m14;
	jump (pc,.P99L29);

.P99L28:
	dm(-3,i6)=m13;

.P99L29:
	r2=dm(-3,i6);
	r2=pass r2;
	if ne jump (pc,.P99L25);

.LN739:
// line 1800
	r8=dm(-7,i6);
	r12=36;
	r4=r8+r12;
.LN740:
	cjump xTaskRemoveFromEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ167-1;
.LCJ167:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN741:
	if eq jump (pc,.P99L31);

.LN742:
// line 1803
	dm(_adi_OSWaitingForSched.)=m6;
.LN743:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN744:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	dm(-3,i6)=r2;
	r2=pass r2;
	if eq jump (pc,.P99L34);


.P99L38:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 1803 col 25
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 6 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   4 out of    6 ( 66.7%)
//     multifunction float multiply    used   4 out of    6 ( 66.7%)
//     multifunction integer add sub   used   4 out of    6 ( 66.7%)
//     multifunction integer multiply  used   4 out of    6 ( 66.7%)
//     multifunction mult              used   4 out of    6 ( 66.7%)
//     dm dag                          used   3 out of    6 ( 50.0%)
//     pm dag                          used   3 out of    6 ( 50.0%)
//     shift immediate                 used   3 out of    6 ( 50.0%)
//     memory access                   used   3 out of   12 ( 25.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN745:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P99L39);

	jump (pc,.P99L38);
//-------------------------------------------------------------------
//   End Loop L38
//-------------------------------------------------------------------

.P99L39:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN746:
	jump (pc,.P99L35);

.P99L34:

.P99L35:
.LN747:
// line 1804
	jump (pc,.P99L32);

.P99L31:

.P99L32:
.LN748:
// line 1809
	jump (pc,.P99L26);

.P99L25:

.P99L26:
.LN749:
// line 1815
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ168-1;
.LCJ168:
.LN750:
// line 1816
	dm(-2,i6)=m14;
	jump (pc,.P99L41);

.P99L22:
//-------------------------------------------------------------------
//   Part of Loop 18, depth 1
//-------------------------------------------------------------------
.LN751:
// line 1820
	r2=dm(-10,i6);
	r2=pass r2;
	if ne jump (pc,.P99L44);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN752:
// line 1824
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ169-1;
.LCJ169:
.LN753:
// line 1826
	dm(-2,i6)=m13;
	jump (pc,.P99L41);

.P99L44:
//-------------------------------------------------------------------
//   Part of Loop 18, depth 1
//-------------------------------------------------------------------
.LN754:
// line 1828
	r2=dm(-9,i6);
	r2=pass r2;
	if ne jump (pc,.P99L48);

.LN755:
// line 1833
	i4=modify(i6,-14) (nw);
	r4=i4;
	cjump vTaskInternalSetTimeOutState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ170-1;
.LCJ170:
.LN756:
// line 1834
	dm(-9,i6)=m14;
.LN757:
// line 1835
	jump (pc,.P99L49);

.P99L48:

.P99L49:
.LN758:
// line 1843
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ171-1;
.LCJ171:
.LN759:
// line 1848
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ172-1;
.LCJ172:
.LN760:
// line 1849
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ173-1;
.LCJ173:
.LN761:
	i4=dm(-7,i6);
	i4=modify(i4,68);
	r2=dm(m5,i4) (bwse);                      // Use of volatile in loops precludes optimizations. 
	r1=m7;
	comp(r2,r1);
	if ne jump (pc,.P99L51);

.LN762:
	i4=dm(-7,i6);
	i4=modify(i4,68);
	dm(m5,i4)=m13 (bw);                       // Use of volatile in loops precludes optimizations. 
.LN763:
	jump (pc,.P99L52);

.P99L51:

.P99L52:
.LN764:
	i4=dm(-7,i6);
	i4=modify(i4,69);
	r2=dm(m5,i4) (bwse);                      // Use of volatile in loops precludes optimizations. 
	comp(r2,r1);
	if ne jump (pc,.P99L54);

.LN765:
	i4=dm(-7,i6);
	i4=modify(i4,69);
	dm(m5,i4)=m13 (bw);                       // Use of volatile in loops precludes optimizations. 
.LN766:
	jump (pc,.P99L55);

.P99L54:

.P99L55:
.LN767:
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ174-1;
.LCJ174:
.LN768:
// line 1852
	i5=modify(i6,-14) (nw);
	i4=modify(i6,-10) (nw);
	r8=i4;
	r4=i5;
	cjump xTaskCheckForTimeOut. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ175-1;
.LCJ175:
	r2=pass r0;
.LN769:
	if ne jump (pc,.P99L57);

.LN770:
// line 1856
	r4=dm(-7,i6);
.LN771:
	cjump prvIsQueueEmpty. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ176-1;
.LCJ176:
	r2=pass r0;
.LN772:
	if eq jump (pc,.P99L60);

.LN773:
// line 1859
	r8=dm(-7,i6);
	r12=36;
	r4=r8+r12;
	r8=dm(-10,i6);
.LN774:
	cjump vTaskPlaceOnEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ177-1;
.LCJ177:
.LN775:
// line 1860
	r4=dm(-7,i6);
.LN776:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ178-1;
.LCJ178:
.LN777:
// line 1862
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ179-1;
.LCJ179:
	r2=pass r0;
.LN778:
	if ne jump (pc,.P99L63);

.LN779:
// line 1864
	dm(_adi_OSWaitingForSched.)=m6;         // Use of volatile in loops precludes optimizations. 
.LN780:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;                       // Use of volatile in loops precludes optimizations. 

.LN781:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P99L66);


.P99L70:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 1864 col 21
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 6 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   4 out of    6 ( 66.7%)
//     multifunction float multiply    used   4 out of    6 ( 66.7%)
//     multifunction integer add sub   used   4 out of    6 ( 66.7%)
//     multifunction integer multiply  used   4 out of    6 ( 66.7%)
//     multifunction mult              used   4 out of    6 ( 66.7%)
//     dm dag                          used   3 out of    6 ( 50.0%)
//     pm dag                          used   3 out of    6 ( 50.0%)
//     shift immediate                 used   3 out of    6 ( 50.0%)
//     memory access                   used   3 out of   12 ( 25.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN782:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P99L71);

	jump (pc,.P99L70);
//-------------------------------------------------------------------
//   End Loop L70
//-------------------------------------------------------------------

.P99L71:
//-------------------------------------------------------------------
//   Part of Loop 18, depth 1
//-------------------------------------------------------------------
.LN783:
	jump (pc,.P99L67);

.P99L66:

.P99L67:
.LN784:
// line 1865
	jump (pc,.P99L64);

.P99L63:

.P99L64:
.LN785:
// line 1870
	jump (pc,.P99L61);

.P99L60:
.LN786:
// line 1875
	r4=dm(-7,i6);
.LN787:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ180-1;
.LCJ180:
.LN788:
// line 1876
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ181-1;
.LCJ181:

.P99L61:
.LN789:
// line 1878
	jump (pc,.P99L58);

.P99L57:
.LN790:
// line 1883
	r4=dm(-7,i6);
.LN791:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ182-1;
.LCJ182:
.LN792:
// line 1884
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ183-1;
.LCJ183:
.LN793:
// line 1886
	r4=dm(-7,i6);
.LN794:
	cjump prvIsQueueEmpty. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ184-1;
.LCJ184:
	r2=pass r0;
.LN795:
	if eq jump (pc,.P99L74);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN796:
// line 1889
	dm(-2,i6)=m13;
	jump (pc,.P99L41);

.P99L74:
//-------------------------------------------------------------------
//   Part of Loop 18, depth 1
//-------------------------------------------------------------------

.P99L58:
.LN797:
// line 1896
	jump (pc,.P99L77);

.P99L41:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN798:
// line 1897
	r0=dm(-2,i6);
	i5=dm(-15,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueuePeek..end:
.xQueuePeek..end:
	.global xQueuePeek.;
	.type xQueuePeek.,STT_FUNC;

vQueueWaitForMessageRestricted.:
.LNvQueueWaitForMessageRestricted.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":2902
	modify(i7,-4) (nw);
	dm(-3,i6)=r12;
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
.LN799:
// line 2903
	dm(-2,i6)=r4;
.LN800:
// line 2919
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ185-1;
.LCJ185:
.LN801:
	i4=dm(-2,i6);
	i4=modify(i4,68);
	r2=dm(m5,i4) (bwse);
	r1=m7;
	comp(r2,r1);
	if ne jump (pc,.P100L2);

.LN802:
	i4=dm(-2,i6);
	i4=modify(i4,68);
	dm(m5,i4)=m13 (bw);
.LN803:
	jump (pc,.P100L3);

.P100L2:

.P100L3:
.LN804:
	i4=dm(-2,i6);
	i4=modify(i4,69);
	r2=dm(m5,i4) (bwse);
	comp(r2,r1);
	if ne jump (pc,.P100L5);

.LN805:
	i4=dm(-2,i6);
	i4=modify(i4,69);
	dm(m5,i4)=m13 (bw);
.LN806:
	jump (pc,.P100L6);

.P100L5:

.P100L6:
.LN807:
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ186-1;
.LCJ186:
.LN808:
// line 2921
	i4=dm(-2,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P100L8);

.LN809:
// line 2924
	r8=dm(-2,i6);
	r12=36;
	r4=r8+r12;
	r8=dm(-4,i6);
	r12=dm(-3,i6);
.LN810:
	cjump vTaskPlaceOnEventListRestricted. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ187-1;
.LCJ187:
.LN811:
// line 2925
	jump (pc,.P100L9);

.P100L8:

.P100L9:
.LN812:
// line 2931
	r4=dm(-2,i6);
.LN813:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ188-1;
.LCJ188:
.LN814:
// line 2932
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vQueueWaitForMessageRestricted..end:
.vQueueWaitForMessageRestricted..end:
	.global vQueueWaitForMessageRestricted.;
	.type vQueueWaitForMessageRestricted.,STT_FUNC;

xQueueGenericSend.:
.LNxQueueGenericSend.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 72 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,scc,btf}
//  Call preserved registers used: {r15,i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":857
	modify(i7,-16) (nw);
	dm(-17,i6)=r15;
	r2=i5;
	dm(-16,i6)=r2;
	r2=dm(m6,i6);
	dm(m6,i6)=r2;
	dm(-11,i6)=r12;
	dm(-12,i6)=r8;
	dm(-13,i6)=r4;
.LN815:
// line 858
	dm(-10,i6)=m13;
.LN816:
// line 860
	dm(-8,i6)=r4;
	r2=pass r4;
.LN817:
// line 862
	if ne jump (pc,.P102L2);

.LN818:
	r8=862;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ189-1;
.LCJ189:
.LN819:
	jump (pc,.P102L3);

.P102L2:

.P102L3:
.LN820:
// line 863
	r2=dm(-12,i6);
	r2=pass r2;
	if eq jump (pc,.P102L8);

.P102L7:
	dm(-7,i6)=m13;
	jump (pc,.P102L10);

.P102L8:
	i4=dm(-8,i6);
	r2=dm(16,i4);
	r2=pass r2;
	if eq jump (pc,.P102L7);

	dm(-7,i6)=m14;

.P102L10:
	r2=dm(-7,i6);
	r2=pass r2;
	if eq jump (pc,.P102L5);

.LN821:
	r8=863;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ190-1;
.LCJ190:
.LN822:
	jump (pc,.P102L6);

.P102L5:

.P102L6:
.LN823:
// line 864
	r2=dm(m6,i6);
	r15=m6;
	r2=btgl r2 by r15;
	if sz jump (pc,.P102L15);

.P102L14:
	dm(-6,i6)=m13;
	jump (pc,.P102L17);

.P102L15:
	i4=dm(-8,i6);
	r2=dm(15,i4);
	r1=m5;
	r2=btgl r2 by r1;
	if sz jump (pc,.P102L14);

	dm(-6,i6)=m14;

.P102L17:
	r2=dm(-6,i6);
	r2=pass r2;
	if eq jump (pc,.P102L12);

.LN824:
	r8=864;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ191-1;
.LCJ191:
.LN825:
	jump (pc,.P102L13);

.P102L12:

.P102L13:
.LN826:
// line 867
	cjump xTaskGetSchedulerState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ192-1;
.LCJ192:
	dm(-5,i6)=r0;
.LN827:
	r2=pass r0;
	if eq jump (pc,.P102L22);

.P102L21:
	dm(-5,i6)=m13;
	jump (pc,.P102L24);

.P102L22:
	r2=dm(-11,i6);
	r2=pass r2;
	if eq jump (pc,.P102L21);

	dm(-5,i6)=m14;

.P102L24:
	r2=dm(-5,i6);
	r2=pass r2;
	if eq jump (pc,.P102L19);

.LN828:
	r8=867;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ193-1;
.LCJ193:
.LN829:
	jump (pc,.P102L20);

.P102L19:

.P102L20:
.LN830:
// line 874
	jump (pc,.P102L25);

.P102L111:
//-------------------------------------------------------------------
//   Part of Loop 25, depth 1
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//   End Loop L25
//-------------------------------------------------------------------

.P102L25:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 874 col 5
//-------------------------------------------------------------------
.LN831:
// line 876
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ194-1;
.LCJ194:
.LN832:
// line 882
	i4=dm(-8,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	i4=dm(-8,i6);
	r1=dm(15,i4);
	compu(r2,r1);
	if lt jump (pc,.P102L28);

	r2=dm(m6,i6);
	r2=btgl r2 by r15;
	if not sz jump (pc,.P102L29);

.P102L28:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN833:
// line 888
	i4=dm(-8,i6);
	i4=modify(i4,56);
	r2=dm(i4,m5);
	dm(-4,i6)=r2;
.LN834:
// line 890
	r4=dm(-8,i6);
	r8=dm(-12,i6);
	r12=dm(m6,i6);
.LN835:
	cjump prvCopyDataToQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ195-1;
.LCJ195:
.LN836:
	dm(-9,i6)=r0;
.LN837:
// line 892
	i4=dm(-8,i6);
	r2=dm(18,i4);
	r2=pass r2;
	if eq jump (pc,.P102L33);

.LN838:
// line 894
	r2=dm(m6,i6);
	r2=btgl r2 by r15;
	if not sz jump (pc,.P102L36);

	r2=dm(-4,i6);
	r2=pass r2;
	if eq jump (pc,.P102L36);

.LN839:
// line 900
	jump (pc,.P102L37);

.P102L36:
.LN840:
// line 901
	r4=dm(-8,i6);
.LN841:
	cjump prvNotifyQueueSetContainer. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ196-1;
.LCJ196:
	r2=pass r0;
.LN842:
	if eq jump (pc,.P102L40);

.LN843:
// line 906
	dm(_adi_OSWaitingForSched.)=m6;
.LN844:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN845:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P102L43);


.P102L47:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 906 col 29
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 6 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   4 out of    6 ( 66.7%)
//     multifunction float multiply    used   4 out of    6 ( 66.7%)
//     multifunction integer add sub   used   4 out of    6 ( 66.7%)
//     multifunction integer multiply  used   4 out of    6 ( 66.7%)
//     multifunction mult              used   4 out of    6 ( 66.7%)
//     dm dag                          used   3 out of    6 ( 50.0%)
//     pm dag                          used   3 out of    6 ( 50.0%)
//     shift immediate                 used   3 out of    6 ( 50.0%)
//     memory access                   used   3 out of   12 ( 25.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN846:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P102L48);

	jump (pc,.P102L47);
//-------------------------------------------------------------------
//   End Loop L47
//-------------------------------------------------------------------

.P102L48:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN847:
	jump (pc,.P102L44);

.P102L43:

.P102L44:
.LN848:
// line 907
	jump (pc,.P102L41);

.P102L40:

.P102L41:

.P102L37:
.LN849:
// line 912
	jump (pc,.P102L34);

.P102L33:
.LN850:
// line 917
	i4=modify(i4,36);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P102L54);

	dm(-3,i6)=m14;
	jump (pc,.P102L55);

.P102L54:
	dm(-3,i6)=m13;

.P102L55:
	r2=dm(-3,i6);
	r2=pass r2;
	if ne jump (pc,.P102L51);

.LN851:
// line 919
	r8=dm(-8,i6);
	r12=36;
	r4=r8+r12;
.LN852:
	cjump xTaskRemoveFromEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ197-1;
.LCJ197:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN853:
	if eq jump (pc,.P102L57);

.LN854:
// line 925
	dm(_adi_OSWaitingForSched.)=m6;
.LN855:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN856:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	dm(-3,i6)=r2;
	r2=pass r2;
	if eq jump (pc,.P102L60);


.P102L64:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 925 col 33
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 6 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   4 out of    6 ( 66.7%)
//     multifunction float multiply    used   4 out of    6 ( 66.7%)
//     multifunction integer add sub   used   4 out of    6 ( 66.7%)
//     multifunction integer multiply  used   4 out of    6 ( 66.7%)
//     multifunction mult              used   4 out of    6 ( 66.7%)
//     dm dag                          used   3 out of    6 ( 50.0%)
//     pm dag                          used   3 out of    6 ( 50.0%)
//     shift immediate                 used   3 out of    6 ( 50.0%)
//     memory access                   used   3 out of   12 ( 25.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN857:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P102L65);

	jump (pc,.P102L64);
//-------------------------------------------------------------------
//   End Loop L64
//-------------------------------------------------------------------

.P102L65:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN858:
	jump (pc,.P102L61);

.P102L60:

.P102L61:
.LN859:
// line 926
	jump (pc,.P102L58);

.P102L57:

.P102L58:
.LN860:
// line 931
	jump (pc,.P102L52);

.P102L51:
.LN861:
// line 932
	r2=dm(-9,i6);
	r2=pass r2;
	if eq jump (pc,.P102L68);

.LN862:
// line 938
	dm(_adi_OSWaitingForSched.)=m6;
.LN863:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN864:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	dm(-3,i6)=r2;
	r2=pass r2;
	if eq jump (pc,.P102L71);


.P102L75:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 938 col 29
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 6 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   4 out of    6 ( 66.7%)
//     multifunction float multiply    used   4 out of    6 ( 66.7%)
//     multifunction integer add sub   used   4 out of    6 ( 66.7%)
//     multifunction integer multiply  used   4 out of    6 ( 66.7%)
//     multifunction mult              used   4 out of    6 ( 66.7%)
//     dm dag                          used   3 out of    6 ( 50.0%)
//     pm dag                          used   3 out of    6 ( 50.0%)
//     shift immediate                 used   3 out of    6 ( 50.0%)
//     memory access                   used   3 out of   12 ( 25.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN865:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P102L76);

	jump (pc,.P102L75);
//-------------------------------------------------------------------
//   End Loop L75
//-------------------------------------------------------------------

.P102L76:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN866:
	jump (pc,.P102L72);

.P102L71:

.P102L72:
.LN867:
// line 939
	jump (pc,.P102L69);

.P102L68:

.P102L69:

.P102L52:

.P102L34:
.LN868:
// line 982
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ198-1;
.LCJ198:
.LN869:
// line 983
	dm(-2,i6)=m14;
	jump (pc,.P102L78);

.P102L29:
//-------------------------------------------------------------------
//   Part of Loop 25, depth 1
//-------------------------------------------------------------------
.LN870:
// line 987
	r2=dm(-11,i6);
	r2=pass r2;
	if ne jump (pc,.P102L81);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN871:
// line 991
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ199-1;
.LCJ199:
.LN872:
// line 996
	dm(-2,i6)=m13;
	jump (pc,.P102L78);

.P102L81:
//-------------------------------------------------------------------
//   Part of Loop 25, depth 1
//-------------------------------------------------------------------
.LN873:
// line 998
	r2=dm(-10,i6);
	r2=pass r2;
	if ne jump (pc,.P102L85);

.LN874:
// line 1002
	i4=modify(i6,-15) (nw);
	r4=i4;
	cjump vTaskInternalSetTimeOutState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ200-1;
.LCJ200:
.LN875:
// line 1003
	dm(-10,i6)=m14;
.LN876:
// line 1004
	jump (pc,.P102L86);

.P102L85:

.P102L86:
.LN877:
// line 1012
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ201-1;
.LCJ201:
.LN878:
// line 1017
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ202-1;
.LCJ202:
.LN879:
// line 1018
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ203-1;
.LCJ203:
.LN880:
	i4=dm(-8,i6);
	i4=modify(i4,68);
	r2=dm(m5,i4) (bwse);                      // Use of volatile in loops precludes optimizations. 
	r1=m7;
	comp(r2,r1);
	if ne jump (pc,.P102L88);

.LN881:
	i4=dm(-8,i6);
	i4=modify(i4,68);
	dm(m5,i4)=m13 (bw);                       // Use of volatile in loops precludes optimizations. 
.LN882:
	jump (pc,.P102L89);

.P102L88:

.P102L89:
.LN883:
	i4=dm(-8,i6);
	i4=modify(i4,69);
	r2=dm(m5,i4) (bwse);                      // Use of volatile in loops precludes optimizations. 
	comp(r2,r1);
	if ne jump (pc,.P102L91);

.LN884:
	i4=dm(-8,i6);
	i4=modify(i4,69);
	dm(m5,i4)=m13 (bw);                       // Use of volatile in loops precludes optimizations. 
.LN885:
	jump (pc,.P102L92);

.P102L91:

.P102L92:
.LN886:
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ204-1;
.LCJ204:
.LN887:
// line 1021
	i5=modify(i6,-15) (nw);
	i4=modify(i6,-11) (nw);
	r8=i4;
	r4=i5;
	cjump xTaskCheckForTimeOut. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ205-1;
.LCJ205:
	r2=pass r0;
.LN888:
	if ne jump (pc,.P102L94);

.LN889:
// line 1023
	r4=dm(-8,i6);
.LN890:
	cjump prvIsQueueFull. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ206-1;
.LCJ206:
	r2=pass r0;
.LN891:
	if eq jump (pc,.P102L97);

.LN892:
// line 1026
	r8=dm(-8,i6);
	r12=16;
	r4=r8+r12;
	r8=dm(-11,i6);
.LN893:
	cjump vTaskPlaceOnEventList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ207-1;
.LCJ207:
.LN894:
// line 1033
	r4=dm(-8,i6);
.LN895:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ208-1;
.LCJ208:
.LN896:
// line 1040
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ209-1;
.LCJ209:
	r2=pass r0;
.LN897:
	if ne jump (pc,.P102L100);

.LN898:
// line 1042
	dm(_adi_OSWaitingForSched.)=m6;         // Use of volatile in loops precludes optimizations. 
.LN899:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;                       // Use of volatile in loops precludes optimizations. 

.LN900:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P102L103);


.P102L107:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c" line 1042 col 21
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 6 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   4 out of    6 ( 66.7%)
//     multifunction float multiply    used   4 out of    6 ( 66.7%)
//     multifunction integer add sub   used   4 out of    6 ( 66.7%)
//     multifunction integer multiply  used   4 out of    6 ( 66.7%)
//     multifunction mult              used   4 out of    6 ( 66.7%)
//     dm dag                          used   3 out of    6 ( 50.0%)
//     pm dag                          used   3 out of    6 ( 50.0%)
//     shift immediate                 used   3 out of    6 ( 50.0%)
//     memory access                   used   3 out of   12 ( 25.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN901:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P102L108);

	jump (pc,.P102L107);
//-------------------------------------------------------------------
//   End Loop L107
//-------------------------------------------------------------------

.P102L108:
//-------------------------------------------------------------------
//   Part of Loop 25, depth 1
//-------------------------------------------------------------------
.LN902:
	jump (pc,.P102L104);

.P102L103:

.P102L104:
.LN903:
// line 1043
	jump (pc,.P102L101);

.P102L100:

.P102L101:
.LN904:
// line 1044
	jump (pc,.P102L98);

.P102L97:
.LN905:
// line 1048
	r4=dm(-8,i6);
.LN906:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ210-1;
.LCJ210:
.LN907:
// line 1049
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ211-1;
.LCJ211:

.P102L98:
.LN908:
// line 1061
	jump (pc,.P102L111);

.P102L94:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN909:
// line 1055
	r4=dm(-8,i6);
.LN910:
	cjump prvUnlockQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ212-1;
.LCJ212:
.LN911:
// line 1056
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ213-1;
.LCJ213:
.LN912:
// line 1059
	dm(-2,i6)=m13;

.P102L78:
.LN913:
// line 1062
	r0=dm(-2,i6);
	i5=dm(-16,i6);
	r15=dm(-17,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueGenericSend..end:
.xQueueGenericSend..end:
	.global xQueueGenericSend.;
	.type xQueueGenericSend.,STT_FUNC;

prvInitialiseMutex.:
.LNprvInitialiseMutex.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":561
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;
	r2=pass r4;
.LN914:
// line 562
	if eq jump (pc,.P103L2);

	i4=r4;
.LN915:
// line 568
	dm(2,i4)=m13;
.LN916:
// line 569
	i4=dm(-2,i6);
	dm(m5,i4)=m13;
.LN917:
// line 572
	i4=dm(-2,i6);
	i4=modify(i4,8);
	dm(m6,i4)=m13;
.LN918:
// line 577
	r4=dm(-2,i6);
.LN919:
	r8=m5;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	r12=m5;
	cjump xQueueGenericSend. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ214-1;
.LCJ214:
	modify(i7,2) (nw);
.LN920:
// line 578
	jump (pc,.P103L3);

.P103L2:

.P103L3:
.LN921:
// line 583
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvInitialiseMutex..end:
.prvInitialiseMutex..end:
	.type prvInitialiseMutex.,STT_FUNC;

xQueueCreateMutex.:
.LNxQueueCreateMutex.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r4,r8,r12,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":591
	modify(i7,-4) (nw);
	r12=r4;
	dm(-20,i6)=r4 (bw);
.LN922:
// line 593
	dm(-3,i6)=m14;
.LN923:
	dm(-2,i6)=m13;
.LN924:
// line 595
	r8=m5;
	r4=m6;
	cjump xQueueGenericCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ215-1;
.LCJ215:
	r4=r0;
.LN925:
	dm(-4,i6)=r0;
.LN926:
// line 596
	cjump prvInitialiseMutex. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ216-1;
.LCJ216:
.LN927:
// line 598
	r0=dm(-4,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueCreateMutex..end:
.xQueueCreateMutex..end:
	.global xQueueCreateMutex.;
	.type xQueueCreateMutex.,STT_FUNC;

xQueueCreateMutexStatic.:
.LNxQueueCreateMutexStatic.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":608
	modify(i7,-6) (nw);
	r2=r4;
	r1=r8;
	dm(-5,i6)=r8;
	dm(-24,i6)=r4 (bw);
.LN928:
// line 610
	dm(-3,i6)=m14;
.LN929:
	dm(-2,i6)=m13;
.LN930:
// line 616
	r8=m5;
	r4=m6;
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	r12=m5;
	cjump xQueueGenericCreateStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ217-1;
.LCJ217:
	r4=r0;
	modify(i7,2) (nw);
.LN931:
	dm(-4,i6)=r0;
.LN932:
// line 617
	cjump prvInitialiseMutex. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ218-1;
.LCJ218:
.LN933:
// line 619
	r0=dm(-4,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueCreateMutexStatic..end:
.xQueueCreateMutexStatic..end:
	.global xQueueCreateMutexStatic.;
	.type xQueueCreateMutexStatic.,STT_FUNC;

xQueueGiveMutexRecursive.:
.LNxQueueGiveMutexRecursive.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0,r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\queue.c":687
	modify(i7,-4) (nw);
	dm(-4,i6)=r4;
.LN934:
// line 689
	dm(-2,i6)=r4;
	r2=pass r4;
.LN935:
// line 691
	if ne jump (pc,.P106L2);

.LN936:
	r8=691;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ219-1;
.LCJ219:
.LN937:
	jump (pc,.P106L3);

.P106L2:

.P106L3:
.LN938:
// line 699
	cjump xTaskGetCurrentTaskHandle. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ220-1;
.LCJ220:
.LN939:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	comp(r0,r2);
	if ne jump (pc,.P106L5);

.LN940:
// line 708
	i4=modify(i4,8);
	r2=dm(m6,i4);
	r2=r2-1;
	dm(m6,i4)=r2;
.LN941:
// line 711
	i4=dm(-2,i6);
	i4=modify(i4,8);
	r2=dm(m6,i4);
	r2=pass r2;
	if ne jump (pc,.P106L8);

.LN942:
// line 715
	r4=dm(-2,i6);
.LN943:
	r8=m5;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	r12=m5;
	cjump xQueueGenericSend. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ221-1;
.LCJ221:
	modify(i7,2) (nw);
.LN944:
// line 716
	jump (pc,.P106L9);

.P106L8:

.P106L9:
.LN945:
// line 722
	dm(-3,i6)=m14;
.LN946:
// line 723
	jump (pc,.P106L6);

.P106L5:
.LN947:
// line 728
	dm(-3,i6)=m13;

.P106L6:
.LN948:
// line 733
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xQueueGiveMutexRecursive..end:
.xQueueGiveMutexRecursive..end:
	.global xQueueGiveMutexRecursive.;
	.type xQueueGiveMutexRecursive.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="prvCopyDataFromQueue.";
	.file_attr FuncName="prvGetDisinheritPriorityAfterTimeout.";
	.file_attr FuncName="ucQueueGetQueueType.";
	.file_attr FuncName="vQueueSetQueueNumber.";
	.file_attr FuncName="uxQueueGetQueueNumber.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr FuncName="xQueueGenericReset.";
	.file_attr FuncName="prvInitialiseNewQueue.";
	.file_attr FuncName="xQueueGenericCreateStatic.";
	.file_attr FuncName="xQueueGenericCreate.";
	.file_attr FuncName="xQueueCreateCountingSemaphoreStatic.";
	.file_attr FuncName="xQueueCreateCountingSemaphore.";
	.file_attr FuncName="xQueueReceiveFromISR.";
	.file_attr FuncName="xQueuePeekFromISR.";
	.file_attr FuncName="uxQueueMessagesWaiting.";
	.file_attr FuncName="uxQueueSpacesAvailable.";
	.file_attr FuncName="uxQueueMessagesWaitingFromISR.";
	.file_attr FuncName="prvCopyDataToQueue.";
	.file_attr FuncName="prvIsQueueEmpty.";
	.file_attr FuncName="xQueueIsQueueEmptyFromISR.";
	.file_attr FuncName="prvIsQueueFull.";
	.file_attr FuncName="xQueueIsQueueFullFromISR.";
	.file_attr FuncName="vQueueAddToRegistry.";
	.file_attr FuncName="pcQueueGetName.";
	.file_attr FuncName="vQueueUnregisterQueue.";
	.file_attr FuncName="vQueueDelete.";
	.file_attr FuncName="xQueueCreateSet.";
	.file_attr FuncName="xQueueAddToSet.";
	.file_attr FuncName="xQueueRemoveFromSet.";
	.file_attr FuncName="xQueueSelectFromSetFromISR.";
	.file_attr FuncName="prvNotifyQueueSetContainer.";
	.file_attr FuncName="xQueueGiveFromISR.";
	.file_attr FuncName="xQueueGenericSendFromISR.";
	.file_attr FuncName="prvUnlockQueue.";
	.file_attr FuncName="xQueueReceive.";
	.file_attr FuncName="xQueueSelectFromSet.";
	.file_attr FuncName="xQueueSemaphoreTake.";
	.file_attr FuncName="xQueueTakeMutexRecursive.";
	.file_attr FuncName="xQueuePeek.";
	.file_attr FuncName="vQueueWaitForMessageRestricted.";
	.file_attr FuncName="xQueueGenericSend.";
	.file_attr FuncName="prvInitialiseMutex.";
	.file_attr FuncName="xQueueCreateMutex.";
	.file_attr FuncName="xQueueCreateMutexStatic.";
	.file_attr FuncName="xQueueGiveMutexRecursive.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern __memcpyDD.;
	.type __memcpyDD.,STT_FUNC;
	.extern vAssertCalled.;
	.type vAssertCalled.,STT_FUNC;
	.extern __divrem_u32.;
	.type __divrem_u32.,STT_FUNC;
	.extern vPortEnterCritical.;
	.type vPortEnterCritical.,STT_FUNC;
	.extern xTaskRemoveFromEventList.;
	.type xTaskRemoveFromEventList.,STT_FUNC;
	.extern vListInitialise.;
	.type vListInitialise.,STT_FUNC;
	.extern vPortExitCritical.;
	.type vPortExitCritical.,STT_FUNC;
	.extern pvPortMalloc.;
	.type pvPortMalloc.,STT_FUNC;
	.extern vPortValidateInterruptPriority.;
	.type vPortValidateInterruptPriority.,STT_FUNC;
	.extern ulPortSetInterruptMask.;
	.type ulPortSetInterruptMask.,STT_FUNC;
	.extern uxTaskGetNumberOfTasks.;
	.type uxTaskGetNumberOfTasks.,STT_FUNC;
	.extern vPortClearInterruptMask.;
	.type vPortClearInterruptMask.,STT_FUNC;
	.extern xTaskPriorityDisinherit.;
	.type xTaskPriorityDisinherit.,STT_FUNC;
	.extern vPortFree.;
	.type vPortFree.,STT_FUNC;
	.extern vTaskMissedYield.;
	.type vTaskMissedYield.,STT_FUNC;
	.extern xTaskGetSchedulerState.;
	.type xTaskGetSchedulerState.,STT_FUNC;
	.extern vTaskInternalSetTimeOutState.;
	.type vTaskInternalSetTimeOutState.,STT_FUNC;
	.extern vTaskSuspendAll.;
	.type vTaskSuspendAll.,STT_FUNC;
	.extern xTaskCheckForTimeOut.;
	.type xTaskCheckForTimeOut.,STT_FUNC;
	.extern vTaskPlaceOnEventList.;
	.type vTaskPlaceOnEventList.,STT_FUNC;
	.extern xTaskResumeAll.;
	.type xTaskResumeAll.,STT_FUNC;
	.extern pvTaskIncrementMutexHeldCount.;
	.type pvTaskIncrementMutexHeldCount.,STT_FUNC;
	.extern xTaskPriorityInherit.;
	.type xTaskPriorityInherit.,STT_FUNC;
	.extern vTaskPriorityDisinheritAfterTimeout.;
	.type vTaskPriorityDisinheritAfterTimeout.,STT_FUNC;
	.extern xTaskGetCurrentTaskHandle.;
	.type xTaskGetCurrentTaskHandle.,STT_FUNC;
	.extern vTaskPlaceOnEventListRestricted.;
	.type vTaskPlaceOnEventListRestricted.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\FreeRTOS\queue.sbn", 0, 309;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x51,0x3A,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x71,0x75,0x65,0x75,0x65,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\FreeRTOS\queue.sbn", 309, 7763;
	.var = .LNprvCopyDataFromQueue.;
	.var = .LN.prvCopyDataFromQueue..end;
	.byte =
		0x01,0x00,0x00,0x14,0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,
		0xE4,0x1E,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x70,0x76,0x42,
		0x75,0x66,0x66,0x65,0x72,0x00,0xD9,0x1E,0x00,0x00,0x02,0x86,
		0x78,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.prvCopyDataFromQueue..end;
	.byte =
		0x00,0x00,0x12,0xC4,0x03,0x00,0x00,0x0A,0x00,0xFD,0x1D,0x00,
		0x00,0x12,0xDE,0x1E,0x00,0x00,0x16,0x71,0x1F,0x00,0x00,0x70,
		0x72,0x76,0x47,0x65,0x74,0x44,0x69,0x73,0x69,0x6E,0x68,0x65,
		0x72,0x69,0x74,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x41,
		0x66,0x74,0x65,0x72,0x54,0x69,0x6D,0x65,0x6F,0x75,0x74,0x00,
		0x01;
	.var = .LNprvGetDisinheritPriorityAfterTimeout.;
	.var = .LN.prvGetDisinheritPriorityAfterTimeout..end;
	.byte =
		0x01,0x68,0x0E,0x00,0x00,0x00,0x00,0x14,0x70,0x78,0x51,0x75,
		0x65,0x75,0x65,0x00,0x7C,0x1F,0x00,0x00,0x02,0x86,0x74,0x00,
		0x15,0x00,0x00,0x00,0x00;
	.var = .LN8;
	.var = .LN.prvGetDisinheritPriorityAfterTimeout..end;
	.byte =
		0x17,0x75,0x78,0x48,0x69,0x67,0x68,0x65,0x73,0x74,0x50,0x72,
		0x69,0x6F,0x72,0x69,0x74,0x79,0x4F,0x66,0x57,0x61,0x69,0x74,
		0x69,0x6E,0x67,0x54,0x61,0x73,0x6B,0x73,0x00,0x01,0x68,0x0E,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x12,0xFD,0x1D,0x00,0x00,0x0A,0x00,0x71,0x1F,0x00,0x00,0x12,
		0x76,0x1F,0x00,0x00,0x16,0xC9,0x1F,0x00,0x00,0x75,0x63,0x51,
		0x75,0x65,0x75,0x65,0x47,0x65,0x74,0x51,0x75,0x65,0x75,0x65,
		0x54,0x79,0x70,0x65,0x00,0x01;
	.var = .LNucQueueGetQueueType.;
	.var = .LN.ucQueueGetQueueType..end;
	.byte =
		0x01,0x87,0x07,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x78,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN13;
	.var = .LN.ucQueueGetQueueType..end;
	.byte =
		0x00,0x00,0x13,0x25,0x20,0x00,0x00,0x76,0x51,0x75,0x65,0x75,
		0x65,0x53,0x65,0x74,0x51,0x75,0x65,0x75,0x65,0x4E,0x75,0x6D,
		0x62,0x65,0x72,0x00,0x01;
	.var = .LNvQueueSetQueueNumber.;
	.var = .LN.vQueueSetQueueNumber..end;
	.byte =
		0x01,0x01,0x00,0x14,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0xA8,
		0x1D,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x75,0x78,0x51,0x75,
		0x65,0x75,0x65,0x4E,0x75,0x6D,0x62,0x65,0x72,0x00,0x68,0x0E,
		0x00,0x00,0x02,0x86,0x78,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN14;
	.var = .LN.vQueueSetQueueNumber..end;
	.byte =
		0x00,0x00,0x16,0x6F,0x20,0x00,0x00,0x75,0x78,0x51,0x75,0x65,
		0x75,0x65,0x47,0x65,0x74,0x51,0x75,0x65,0x75,0x65,0x4E,0x75,
		0x6D,0x62,0x65,0x72,0x00,0x01;
	.var = .LNuxQueueGetQueueNumber.;
	.var = .LN.uxQueueGetQueueNumber..end;
	.byte =
		0x01,0x68,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x78,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN16;
	.var = .LN.uxQueueGetQueueNumber..end;
	.byte =
		0x00,0x00,0x16,0xF5,0x20,0x00,0x00,0x78,0x51,0x75,0x65,0x75,
		0x65,0x47,0x65,0x6E,0x65,0x72,0x69,0x63,0x52,0x65,0x73,0x65,
		0x74,0x00,0x01;
	.var = .LNxQueueGenericReset.;
	.var = .LN.xQueueGenericReset..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x68,0x00,0x14,
		0x78,0x4E,0x65,0x77,0x51,0x75,0x65,0x75,0x65,0x00,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x6C,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN17;
	.var = .LN.xQueueGenericReset..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x70;
	.var = .LN17-.LNxQueueGenericReset.;
	.byte =
		0x00,0x17,0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,
		0x1E,0x00,0x00,0x02,0x86,0x74;
	.var = .LN17-.LNxQueueGenericReset.;
	.byte =
		0x00,0x00,0x00,0x13,0x98,0x21,0x00,0x00,0x70,0x72,0x76,0x49,
		0x6E,0x69,0x74,0x69,0x61,0x6C,0x69,0x73,0x65,0x4E,0x65,0x77,
		0x51,0x75,0x65,0x75,0x65,0x00,0x01;
	.var = .LNprvInitialiseNewQueue.;
	.var = .LN.prvInitialiseNewQueue..end;
	.byte =
		0x01,0x00,0x00,0x14,0x75,0x78,0x51,0x75,0x65,0x75,0x65,0x4C,
		0x65,0x6E,0x67,0x74,0x68,0x00,0x9D,0x21,0x00,0x00,0x02,0x86,
		0x70,0x00,0x14,0x75,0x78,0x49,0x74,0x65,0x6D,0x53,0x69,0x7A,
		0x65,0x00,0x9D,0x21,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x70,
		0x75,0x63,0x51,0x75,0x65,0x75,0x65,0x53,0x74,0x6F,0x72,0x61,
		0x67,0x65,0x00,0x9E,0x0E,0x00,0x00,0x02,0x86,0x78,0x00,0x14,
		0x75,0x63,0x51,0x75,0x65,0x75,0x65,0x54,0x79,0x70,0x65,0x00,
		0x98,0x21,0x00,0x00,0x02,0x86,0x04,0x00,0x14,0x70,0x78,0x4E,
		0x65,0x77,0x51,0x75,0x65,0x75,0x65,0x00,0xDE,0x1E,0x00,0x00,
		0x02,0x86,0x08,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN54;
	.var = .LN.prvInitialiseNewQueue..end;
	.byte =
		0x00,0x00,0x12,0x87,0x07,0x00,0x00,0x12,0x68,0x0E,0x00,0x00,
		0x16,0x8B,0x22,0x00,0x00,0x78,0x51,0x75,0x65,0x75,0x65,0x47,
		0x65,0x6E,0x65,0x72,0x69,0x63,0x43,0x72,0x65,0x61,0x74,0x65,
		0x53,0x74,0x61,0x74,0x69,0x63,0x00,0x01;
	.var = .LNxQueueGenericCreateStatic.;
	.var = .LN.xQueueGenericCreateStatic..end;
	.byte =
		0x01,0xA8,0x1D,0x00,0x00,0x01,0x00,0x14,0x75,0x78,0x51,0x75,
		0x65,0x75,0x65,0x4C,0x65,0x6E,0x67,0x74,0x68,0x00,0x9D,0x21,
		0x00,0x00,0x02,0x86,0x68,0x00,0x14,0x75,0x78,0x49,0x74,0x65,
		0x6D,0x53,0x69,0x7A,0x65,0x00,0x9D,0x21,0x00,0x00,0x02,0x86,
		0x6C,0x00,0x14,0x70,0x75,0x63,0x51,0x75,0x65,0x75,0x65,0x53,
		0x74,0x6F,0x72,0x61,0x67,0x65,0x00,0x9E,0x0E,0x00,0x00,0x02,
		0x86,0x70,0x00,0x14,0x70,0x78,0x53,0x74,0x61,0x74,0x69,0x63,
		0x51,0x75,0x65,0x75,0x65,0x00,0x8B,0x22,0x00,0x00,0x02,0x86,
		0x04,0x00,0x14,0x75,0x63,0x51,0x75,0x65,0x75,0x65,0x54,0x79,
		0x70,0x65,0x00,0x98,0x21,0x00,0x00,0x02,0x86,0x08,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN65;
	.var = .LN.xQueueGenericCreateStatic..end;
	.byte =
		0x17,0x70,0x78,0x4E,0x65,0x77,0x51,0x75,0x65,0x75,0x65,0x00,
		0x01,0xDE,0x1E,0x00,0x00,0x02,0x86,0x74;
	.var = .LN65-.LNxQueueGenericCreateStatic.;
	.byte =
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN70;
	.var = .LN71;
	.byte =
		0x17,0x78,0x53,0x69,0x7A,0x65,0x00,0x01,0xCF,0x03,0x00,0x00,
		0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x0A,
		0x00,0xD3,0x13,0x00,0x00,0x16,0x60,0x23,0x00,0x00,0x78,0x51,
		0x75,0x65,0x75,0x65,0x47,0x65,0x6E,0x65,0x72,0x69,0x63,0x43,
		0x72,0x65,0x61,0x74,0x65,0x00,0x01;
	.var = .LNxQueueGenericCreate.;
	.var = .LN.xQueueGenericCreate..end;
	.byte =
		0x01,0xA8,0x1D,0x00,0x00,0x01,0x00,0x14,0x75,0x78,0x51,0x75,
		0x65,0x75,0x65,0x4C,0x65,0x6E,0x67,0x74,0x68,0x00,0x9D,0x21,
		0x00,0x00,0x02,0x86,0x64,0x00,0x14,0x75,0x78,0x49,0x74,0x65,
		0x6D,0x53,0x69,0x7A,0x65,0x00,0x9D,0x21,0x00,0x00,0x02,0x86,
		0x68,0x00,0x14,0x75,0x63,0x51,0x75,0x65,0x75,0x65,0x54,0x79,
		0x70,0x65,0x00,0x98,0x21,0x00,0x00,0x02,0x86,0x6C,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN80;
	.var = .LN.xQueueGenericCreate..end;
	.byte =
		0x17,0x70,0x78,0x4E,0x65,0x77,0x51,0x75,0x65,0x75,0x65,0x00,
		0x01,0xDE,0x1E,0x00,0x00,0x02,0x86,0x70;
	.var = .LN80-.LNxQueueGenericCreate.;
	.byte =
		0x00,0x17,0x78,0x51,0x75,0x65,0x75,0x65,0x53,0x69,0x7A,0x65,
		0x49,0x6E,0x42,0x79,0x74,0x65,0x73,0x00,0x01,0xCF,0x03,0x00,
		0x00,0x02,0x86,0x74;
	.var = .LN80-.LNxQueueGenericCreate.;
	.byte =
		0x00,0x17,0x70,0x75,0x63,0x51,0x75,0x65,0x75,0x65,0x53,0x74,
		0x6F,0x72,0x61,0x67,0x65,0x00,0x01,0x9E,0x0E,0x00,0x00,0x02,
		0x86,0x78;
	.var = .LN80-.LNxQueueGenericCreate.;
	.byte =
		0x00,0x00,0x00,0x16,0x01,0x24,0x00,0x00,0x78,0x51,0x75,0x65,
		0x75,0x65,0x43,0x72,0x65,0x61,0x74,0x65,0x43,0x6F,0x75,0x6E,
		0x74,0x69,0x6E,0x67,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,
		0x65,0x53,0x74,0x61,0x74,0x69,0x63,0x00,0x01;
	.var = .LNxQueueCreateCountingSemaphoreStatic.;
	.var = .LN.xQueueCreateCountingSemaphoreStatic..end;
	.byte =
		0x01,0xA8,0x1D,0x00,0x00,0x01,0x00,0x14,0x75,0x78,0x4D,0x61,
		0x78,0x43,0x6F,0x75,0x6E,0x74,0x00,0x9D,0x21,0x00,0x00,0x02,
		0x86,0x6C,0x00,0x14,0x75,0x78,0x49,0x6E,0x69,0x74,0x69,0x61,
		0x6C,0x43,0x6F,0x75,0x6E,0x74,0x00,0x9D,0x21,0x00,0x00,0x02,
		0x86,0x70,0x00,0x14,0x70,0x78,0x53,0x74,0x61,0x74,0x69,0x63,
		0x51,0x75,0x65,0x75,0x65,0x00,0x8B,0x22,0x00,0x00,0x02,0x86,
		0x74,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN98;
	.var = .LN.xQueueCreateCountingSemaphoreStatic..end;
	.byte =
		0x17,0x78,0x48,0x61,0x6E,0x64,0x6C,0x65,0x00,0x01,0xA8,0x1D,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN98-.LNxQueueCreateCountingSemaphoreStatic.;
	.byte =
		0x00,0x00,0x00,0x16,0x85,0x24,0x00,0x00,0x78,0x51,0x75,0x65,
		0x75,0x65,0x43,0x72,0x65,0x61,0x74,0x65,0x43,0x6F,0x75,0x6E,
		0x74,0x69,0x6E,0x67,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,
		0x65,0x00,0x01;
	.var = .LNxQueueCreateCountingSemaphore.;
	.var = .LN.xQueueCreateCountingSemaphore..end;
	.byte =
		0x01,0xA8,0x1D,0x00,0x00,0x01,0x00,0x14,0x75,0x78,0x4D,0x61,
		0x78,0x43,0x6F,0x75,0x6E,0x74,0x00,0x9D,0x21,0x00,0x00,0x02,
		0x86,0x70,0x00,0x14,0x75,0x78,0x49,0x6E,0x69,0x74,0x69,0x61,
		0x6C,0x43,0x6F,0x75,0x6E,0x74,0x00,0x9D,0x21,0x00,0x00,0x02,
		0x86,0x74,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN110;
	.var = .LN.xQueueCreateCountingSemaphore..end;
	.byte =
		0x17,0x78,0x48,0x61,0x6E,0x64,0x6C,0x65,0x00,0x01,0xA8,0x1D,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN110-.LNxQueueCreateCountingSemaphore.;
	.byte =
		0x00,0x00,0x00,0x16,0xD2,0x25,0x00,0x00,0x78,0x51,0x75,0x65,
		0x75,0x65,0x52,0x65,0x63,0x65,0x69,0x76,0x65,0x46,0x72,0x6F,
		0x6D,0x49,0x53,0x52,0x00,0x01;
	.var = .LNxQueueReceiveFromISR.;
	.var = .LN.xQueueReceiveFromISR..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x50,0x00,0x14,
		0x70,0x76,0x42,0x75,0x66,0x66,0x65,0x72,0x00,0xD9,0x1E,0x00,
		0x00,0x02,0x86,0x54,0x00,0x14,0x70,0x78,0x48,0x69,0x67,0x68,
		0x65,0x72,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x54,0x61,
		0x73,0x6B,0x57,0x6F,0x6B,0x65,0x6E,0x00,0xDD,0x25,0x00,0x00,
		0x02,0x86,0x58,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN122;
	.var = .LN.xQueueReceiveFromISR..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x5C,0x00,0x00,0x00,0x00,0x00,0x17,0x75,
		0x78,0x53,0x61,0x76,0x65,0x64,0x49,0x6E,0x74,0x65,0x72,0x72,
		0x75,0x70,0x74,0x53,0x74,0x61,0x74,0x75,0x73,0x00,0x01,0x68,
		0x0E,0x00,0x00,0x02,0x86,0x60,0x00,0x00,0x00,0x00,0x00,0x17,
		0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,0x1E,0x00,
		0x00,0x02,0x86,0x64,0x00,0x00,0x00,0x00,0x00,0x15,0x00,0x00,
		0x00,0x00;
	.var = .LN132;
	.var = .LN160;
	.byte =
		0x17,0x75,0x78,0x4D,0x65,0x73,0x73,0x61,0x67,0x65,0x73,0x57,
		0x61,0x69,0x74,0x69,0x6E,0x67,0x00,0x01,0x9D,0x21,0x00,0x00,
		0x02,0x86,0x6C,0x00,0x00,0x00,0x00,0x00,0x15,0x00,0x00,0x00,
		0x00;
	.var = .LN134;
	.var = .LN159;
	.byte =
		0x17,0x63,0x52,0x78,0x4C,0x6F,0x63,0x6B,0x00,0x01,0xD2,0x25,
		0x00,0x00,0x02,0x86,0x73,0x00,0x00,0x00,0x00,0x00,0x15,0x00,
		0x00,0x00,0x00;
	.var = .LN149;
	.var = .LN157;
	.byte =
		0x17,0x75,0x78,0x4E,0x75,0x6D,0x62,0x65,0x72,0x4F,0x66,0x54,
		0x61,0x73,0x6B,0x73,0x00,0x01,0x9D,0x21,0x00,0x00,0x02,0x86,
		0x78;
	.var = .LN156-.LN149;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x12,0x5E,0x07,0x00,0x00,0x0A,
		0x00,0x57,0x0E,0x00,0x00,0x12,0xD7,0x25,0x00,0x00,0x16,0xB0,
		0x26,0x00,0x00,0x78,0x51,0x75,0x65,0x75,0x65,0x50,0x65,0x65,
		0x6B,0x46,0x72,0x6F,0x6D,0x49,0x53,0x52,0x00,0x01;
	.var = .LNxQueuePeekFromISR.;
	.var = .LN.xQueuePeekFromISR..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x60,0x00,0x14,
		0x70,0x76,0x42,0x75,0x66,0x66,0x65,0x72,0x00,0xD9,0x1E,0x00,
		0x00,0x02,0x86,0x64,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN163;
	.var = .LN.xQueuePeekFromISR..end;
	.inc/binary ".\system\FreeRTOS\queue.sbn", 8072, 149;
	.var = .LNuxQueueMessagesWaiting.;
	.var = .LN.uxQueueMessagesWaiting..end;
	.byte =
		0x01,0x68,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0x12,0x27,0x00,0x00,0x02,0x86,0x74,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN187;
	.var = .LN.uxQueueMessagesWaiting..end;
	.byte =
		0x17,0x75,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x68,
		0x0E,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,
		0x00,0x12,0xA8,0x1D,0x00,0x00,0x16,0x8F,0x27,0x00,0x00,0x75,
		0x78,0x51,0x75,0x65,0x75,0x65,0x53,0x70,0x61,0x63,0x65,0x73,
		0x41,0x76,0x61,0x69,0x6C,0x61,0x62,0x6C,0x65,0x00,0x01;
	.var = .LNuxQueueSpacesAvailable.;
	.var = .LN.uxQueueSpacesAvailable..end;
	.byte =
		0x01,0x68,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0x12,0x27,0x00,0x00,0x02,0x86,0x70,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN194;
	.var = .LN.uxQueueSpacesAvailable..end;
	.byte =
		0x17,0x75,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x68,
		0x0E,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x17,
		0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,0x1E,0x00,
		0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,
		0x0E,0x28,0x00,0x00,0x75,0x78,0x51,0x75,0x65,0x75,0x65,0x4D,
		0x65,0x73,0x73,0x61,0x67,0x65,0x73,0x57,0x61,0x69,0x74,0x69,
		0x6E,0x67,0x46,0x72,0x6F,0x6D,0x49,0x53,0x52,0x00,0x01;
	.var = .LNuxQueueMessagesWaitingFromISR.;
	.var = .LN.uxQueueMessagesWaitingFromISR..end;
	.byte =
		0x01,0x68,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0x12,0x27,0x00,0x00,0x02,0x86,0x70,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN202;
	.var = .LN.uxQueueMessagesWaitingFromISR..end;
	.byte =
		0x17,0x75,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x68,
		0x0E,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x17,
		0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,0x1E,0x00,
		0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,
		0xB6,0x28,0x00,0x00,0x70,0x72,0x76,0x43,0x6F,0x70,0x79,0x44,
		0x61,0x74,0x61,0x54,0x6F,0x51,0x75,0x65,0x75,0x65,0x00,0x01;
	.var = .LNprvCopyDataToQueue.;
	.var = .LN.prvCopyDataToQueue..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x00,0x00,0x14,0x70,0x78,0x51,0x75,
		0x65,0x75,0x65,0x00,0xE4,0x1E,0x00,0x00,0x02,0x86,0x68,0x00,
		0x14,0x70,0x76,0x49,0x74,0x65,0x6D,0x54,0x6F,0x51,0x75,0x65,
		0x75,0x65,0x00,0xC4,0x03,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,
		0x78,0x50,0x6F,0x73,0x69,0x74,0x69,0x6F,0x6E,0x00,0xB6,0x28,
		0x00,0x00,0x02,0x86,0x70,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN208;
	.var = .LN.prvCopyDataToQueue..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x74;
	.var = .LN208-.LNprvCopyDataToQueue.;
	.byte =
		0x00,0x17,0x75,0x78,0x4D,0x65,0x73,0x73,0x61,0x67,0x65,0x73,
		0x57,0x61,0x69,0x74,0x69,0x6E,0x67,0x00,0x01,0x68,0x0E,0x00,
		0x00,0x02,0x86,0x78;
	.var = .LN208-.LNprvCopyDataToQueue.;
	.byte =
		0x00,0x00,0x00,0x12,0x57,0x0E,0x00,0x00,0x16,0x16,0x29,0x00,
		0x00,0x70,0x72,0x76,0x49,0x73,0x51,0x75,0x65,0x75,0x65,0x45,
		0x6D,0x70,0x74,0x79,0x00,0x01;
	.var = .LNprvIsQueueEmpty.;
	.var = .LN.prvIsQueueEmpty..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x00,0x00,0x14,0x70,0x78,0x51,0x75,
		0x65,0x75,0x65,0x00,0x76,0x1F,0x00,0x00,0x02,0x86,0x74,0x00,
		0x15,0x00,0x00,0x00,0x00;
	.var = .LN237;
	.var = .LN.prvIsQueueEmpty..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x16,0x90,0x29,0x00,0x00,0x78,0x51,0x75,0x65,0x75,0x65,0x49,
		0x73,0x51,0x75,0x65,0x75,0x65,0x45,0x6D,0x70,0x74,0x79,0x46,
		0x72,0x6F,0x6D,0x49,0x53,0x52,0x00,0x01;
	.var = .LNxQueueIsQueueEmptyFromISR.;
	.var = .LN.xQueueIsQueueEmptyFromISR..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0x12,0x27,0x00,0x00,0x02,0x86,0x70,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN244;
	.var = .LN.xQueueIsQueueEmptyFromISR..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x17,0x70,
		0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,0x1E,0x00,0x00,
		0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,0xEA,
		0x29,0x00,0x00,0x70,0x72,0x76,0x49,0x73,0x51,0x75,0x65,0x75,
		0x65,0x46,0x75,0x6C,0x6C,0x00,0x01;
	.var = .LNprvIsQueueFull.;
	.var = .LN.prvIsQueueFull..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x00,0x00,0x14,0x70,0x78,0x51,0x75,
		0x65,0x75,0x65,0x00,0x76,0x1F,0x00,0x00,0x02,0x86,0x74,0x00,
		0x15,0x00,0x00,0x00,0x00;
	.var = .LN253;
	.var = .LN.prvIsQueueFull..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x16,0x63,0x2A,0x00,0x00,0x78,0x51,0x75,0x65,0x75,0x65,0x49,
		0x73,0x51,0x75,0x65,0x75,0x65,0x46,0x75,0x6C,0x6C,0x46,0x72,
		0x6F,0x6D,0x49,0x53,0x52,0x00,0x01;
	.var = .LNxQueueIsQueueFullFromISR.;
	.var = .LN.xQueueIsQueueFullFromISR..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0x12,0x27,0x00,0x00,0x02,0x86,0x70,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN260;
	.var = .LN.xQueueIsQueueFullFromISR..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x17,0x70,
		0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,0x1E,0x00,0x00,
		0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x13,0xEA,
		0x2A,0x00,0x00,0x76,0x51,0x75,0x65,0x75,0x65,0x41,0x64,0x64,
		0x54,0x6F,0x52,0x65,0x67,0x69,0x73,0x74,0x72,0x79,0x00,0x01;
	.var = .LNvQueueAddToRegistry.;
	.var = .LN.vQueueAddToRegistry..end;
	.byte =
		0x01,0x01,0x00,0x14,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0xA8,
		0x1D,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x70,0x63,0x51,0x75,
		0x65,0x75,0x65,0x4E,0x61,0x6D,0x65,0x00,0x63,0x19,0x00,0x00,
		0x02,0x86,0x70,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN269;
	.var = .LN.vQueueAddToRegistry..end;
	.byte =
		0x17,0x75,0x78,0x00,0x01,0x68,0x0E,0x00,0x00,0x02,0x86,0x74,
		0x00,0x00,0x00,0x00,0x00,0x17,0x70,0x78,0x45,0x6E,0x74,0x72,
		0x79,0x54,0x6F,0x57,0x72,0x69,0x74,0x65,0x00,0x01,0xEA,0x2A,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN269-.LNvQueueAddToRegistry.;
	.byte =
		0x00,0x00,0x00,0x0A,0x00,0x67,0x1E,0x00,0x00,0x16,0x5B,0x2B,
		0x00,0x00,0x70,0x63,0x51,0x75,0x65,0x75,0x65,0x47,0x65,0x74,
		0x4E,0x61,0x6D,0x65,0x00,0x01;
	.var = .LNpcQueueGetName.;
	.var = .LN.pcQueueGetName..end;
	.byte =
		0x01,0x63,0x19,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x70,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN288;
	.var = .LN.pcQueueGetName..end;
	.byte =
		0x17,0x75,0x78,0x00,0x01,0x68,0x0E,0x00,0x00,0x02,0x86,0x74,
		0x00,0x00,0x00,0x00,0x00,0x17,0x70,0x63,0x52,0x65,0x74,0x75,
		0x72,0x6E,0x00,0x01,0x63,0x19,0x00,0x00,0x02,0x86,0x78;
	.var = .LN288-.LNpcQueueGetName.;
	.byte =
		0x00,0x00,0x00,0x13,0xB2,0x2B,0x00,0x00,0x76,0x51,0x75,0x65,
		0x75,0x65,0x55,0x6E,0x72,0x65,0x67,0x69,0x73,0x74,0x65,0x72,
		0x51,0x75,0x65,0x75,0x65,0x00,0x01;
	.var = .LNvQueueUnregisterQueue.;
	.var = .LN.vQueueUnregisterQueue..end;
	.byte =
		0x01,0x01,0x00,0x14,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0xA8,
		0x1D,0x00,0x00,0x02,0x86,0x74,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN298;
	.var = .LN.vQueueUnregisterQueue..end;
	.byte =
		0x17,0x75,0x78,0x00,0x01,0x68,0x0E,0x00,0x00,0x02,0x86,0x78,
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x13,0x05,0x2C,0x00,0x00,
		0x76,0x51,0x75,0x65,0x75,0x65,0x44,0x65,0x6C,0x65,0x74,0x65,
		0x00,0x01;
	.var = .LNvQueueDelete.;
	.var = .LN.vQueueDelete..end;
	.byte =
		0x01,0x01,0x00,0x14,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0xA8,
		0x1D,0x00,0x00,0x02,0x86,0x74,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN308;
	.var = .LN.vQueueDelete..end;
	.byte =
		0x17,0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,0x1E,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x16,0x6B,0x2C,0x00,0x00,0x78,0x51,0x75,0x65,0x75,0x65,0x43,
		0x72,0x65,0x61,0x74,0x65,0x53,0x65,0x74,0x00,0x01;
	.var = .LNxQueueCreateSet.;
	.var = .LN.xQueueCreateSet..end;
	.byte =
		0x01,0xBC,0x1D,0x00,0x00,0x01,0x00,0x14,0x75,0x78,0x45,0x76,
		0x65,0x6E,0x74,0x51,0x75,0x65,0x75,0x65,0x4C,0x65,0x6E,0x67,
		0x74,0x68,0x00,0x9D,0x21,0x00,0x00,0x02,0x86,0x74,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN319;
	.var = .LN.xQueueCreateSet..end;
	.byte =
		0x17,0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xBC,0x1D,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x16,0xE2,0x2C,0x00,0x00,0x78,0x51,0x75,0x65,0x75,0x65,0x41,
		0x64,0x64,0x54,0x6F,0x53,0x65,0x74,0x00,0x01;
	.var = .LNxQueueAddToSet.;
	.var = .LN.xQueueAddToSet..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x4F,0x72,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,
		0x65,0x00,0xD3,0x1D,0x00,0x00,0x02,0x86,0x70,0x00,0x14,0x78,
		0x51,0x75,0x65,0x75,0x65,0x53,0x65,0x74,0x00,0xBC,0x1D,0x00,
		0x00,0x02,0x86,0x74,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN322;
	.var = .LN.xQueueAddToSet..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x16,0x7F,0x2D,0x00,0x00,0x78,0x51,0x75,0x65,0x75,0x65,0x52,
		0x65,0x6D,0x6F,0x76,0x65,0x46,0x72,0x6F,0x6D,0x53,0x65,0x74,
		0x00,0x01;
	.var = .LNxQueueRemoveFromSet.;
	.var = .LN.xQueueRemoveFromSet..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x4F,0x72,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,
		0x65,0x00,0xD3,0x1D,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x78,
		0x51,0x75,0x65,0x75,0x65,0x53,0x65,0x74,0x00,0xBC,0x1D,0x00,
		0x00,0x02,0x86,0x70,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN333;
	.var = .LN.xQueueRemoveFromSet..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x17,0x70,
		0x78,0x51,0x75,0x65,0x75,0x65,0x4F,0x72,0x53,0x65,0x6D,0x61,
		0x70,0x68,0x6F,0x72,0x65,0x00,0x01,0xE4,0x1E,0x00,0x00,0x02,
		0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,0xE7,0x2D,
		0x00,0x00,0x78,0x51,0x75,0x65,0x75,0x65,0x53,0x65,0x6C,0x65,
		0x63,0x74,0x46,0x72,0x6F,0x6D,0x53,0x65,0x74,0x46,0x72,0x6F,
		0x6D,0x49,0x53,0x52,0x00,0x01;
	.var = .LNxQueueSelectFromSetFromISR.;
	.var = .LN.xQueueSelectFromSetFromISR..end;
	.byte =
		0x01,0xD3,0x1D,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x53,0x65,0x74,0x00,0xBC,0x1D,0x00,0x00,0x02,0x86,
		0x74,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN345;
	.var = .LN.xQueueSelectFromSetFromISR..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0xD3,0x1D,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN345-.LNxQueueSelectFromSetFromISR.;
	.byte =
		0x00,0x00,0x00,0x16,0xBF,0x2E,0x00,0x00,0x70,0x72,0x76,0x4E,
		0x6F,0x74,0x69,0x66,0x79,0x51,0x75,0x65,0x75,0x65,0x53,0x65,
		0x74,0x43,0x6F,0x6E,0x74,0x61,0x69,0x6E,0x65,0x72,0x00,0x01;
	.var = .LNprvNotifyQueueSetContainer.;
	.var = .LN.prvNotifyQueueSetContainer..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x00,0x00,0x14,0x70,0x78,0x51,0x75,
		0x65,0x75,0x65,0x00,0x7C,0x1F,0x00,0x00,0x02,0x86,0x64,0x00,
		0x15,0x00,0x00,0x00,0x00;
	.var = .LN348;
	.var = .LN.prvNotifyQueueSetContainer..end;
	.byte =
		0x17,0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x53,0x65,0x74,0x43,
		0x6F,0x6E,0x74,0x61,0x69,0x6E,0x65,0x72,0x00,0x01,0xDE,0x1E,
		0x00,0x00,0x02,0x86,0x68,0x00,0x00,0x00,0x00,0x00,0x17,0x78,
		0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,0x00,0x00,
		0x02,0x86,0x6C;
	.var = .LN349-.LNprvNotifyQueueSetContainer.;
	.byte =
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN357;
	.var = .LN379;
	.byte =
		0x17,0x63,0x54,0x78,0x4C,0x6F,0x63,0x6B,0x00,0x01,0xD2,0x25,
		0x00,0x00,0x02,0x86,0x73,0x00,0x00,0x00,0x00,0x00,0x15,0x00,
		0x00,0x00,0x00;
	.var = .LN370;
	.var = .LN378;
	.byte =
		0x17,0x75,0x78,0x4E,0x75,0x6D,0x62,0x65,0x72,0x4F,0x66,0x54,
		0x61,0x73,0x6B,0x73,0x00,0x01,0x9D,0x21,0x00,0x00,0x02,0x86,
		0x78;
	.var = .LN377-.LN370;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0xF7,0x2F,0x00,0x00,0x78,0x51,
		0x75,0x65,0x75,0x65,0x47,0x69,0x76,0x65,0x46,0x72,0x6F,0x6D,
		0x49,0x53,0x52,0x00,0x01;
	.var = .LNxQueueGiveFromISR.;
	.var = .LN.xQueueGiveFromISR..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x54,0x00,0x14,
		0x70,0x78,0x48,0x69,0x67,0x68,0x65,0x72,0x50,0x72,0x69,0x6F,
		0x72,0x69,0x74,0x79,0x54,0x61,0x73,0x6B,0x57,0x6F,0x6B,0x65,
		0x6E,0x00,0xDD,0x25,0x00,0x00,0x02,0x86,0x58,0x00,0x15,0x00,
		0x00,0x00,0x00;
	.var = .LN380;
	.var = .LN.xQueueGiveFromISR..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x5C,0x00,0x00,0x00,0x00,0x00,0x17,0x75,
		0x78,0x53,0x61,0x76,0x65,0x64,0x49,0x6E,0x74,0x65,0x72,0x72,
		0x75,0x70,0x74,0x53,0x74,0x61,0x74,0x75,0x73,0x00,0x01,0x68,
		0x0E,0x00,0x00,0x02,0x86,0x60,0x00,0x00,0x00,0x00,0x00,0x17,
		0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,0x1E,0x00,
		0x00,0x02,0x86,0x64,0x00,0x00,0x00,0x00,0x00,0x15,0x00,0x00,
		0x00,0x00;
	.var = .LN393;
	.var = .LN428;
	.byte =
		0x17,0x75,0x78,0x4D,0x65,0x73,0x73,0x61,0x67,0x65,0x73,0x57,
		0x61,0x69,0x74,0x69,0x6E,0x67,0x00,0x01,0x9D,0x21,0x00,0x00,
		0x02,0x86,0x6C,0x00,0x00,0x00,0x00,0x00,0x15,0x00,0x00,0x00,
		0x00;
	.var = .LN395;
	.var = .LN427;
	.byte =
		0x17,0x63,0x54,0x78,0x4C,0x6F,0x63,0x6B,0x00,0x01,0xD2,0x25,
		0x00,0x00,0x02,0x86,0x73,0x00,0x00,0x00,0x00,0x00,0x15,0x00,
		0x00,0x00,0x00;
	.var = .LN417;
	.var = .LN425;
	.byte =
		0x17,0x75,0x78,0x4E,0x75,0x6D,0x62,0x65,0x72,0x4F,0x66,0x54,
		0x61,0x73,0x6B,0x73,0x00,0x01,0x9D,0x21,0x00,0x00,0x02,0x86,
		0x78;
	.var = .LN424-.LN417;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x16,0x5E,0x31,0x00,0x00,0x78,
		0x51,0x75,0x65,0x75,0x65,0x47,0x65,0x6E,0x65,0x72,0x69,0x63,
		0x53,0x65,0x6E,0x64,0x46,0x72,0x6F,0x6D,0x49,0x53,0x52,0x00,
		0x01;
	.var = .LNxQueueGenericSendFromISR.;
	.var = .LN.xQueueGenericSendFromISR..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x4C,0x00,0x14,
		0x70,0x76,0x49,0x74,0x65,0x6D,0x54,0x6F,0x51,0x75,0x65,0x75,
		0x65,0x00,0x5E,0x31,0x00,0x00,0x02,0x86,0x50,0x00,0x14,0x70,
		0x78,0x48,0x69,0x67,0x68,0x65,0x72,0x50,0x72,0x69,0x6F,0x72,
		0x69,0x74,0x79,0x54,0x61,0x73,0x6B,0x57,0x6F,0x6B,0x65,0x6E,
		0x00,0xDD,0x25,0x00,0x00,0x02,0x86,0x54,0x00,0x14,0x78,0x43,
		0x6F,0x70,0x79,0x50,0x6F,0x73,0x69,0x74,0x69,0x6F,0x6E,0x00,
		0xB6,0x28,0x00,0x00,0x02,0x86,0x04,0x00,0x15,0x00,0x00,0x00,
		0x00;
	.var = .LN431;
	.var = .LN.xQueueGenericSendFromISR..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x58,0x00,0x00,0x00,0x00,0x00,0x17,0x75,
		0x78,0x53,0x61,0x76,0x65,0x64,0x49,0x6E,0x74,0x65,0x72,0x72,
		0x75,0x70,0x74,0x53,0x74,0x61,0x74,0x75,0x73,0x00,0x01,0x68,
		0x0E,0x00,0x00,0x02,0x86,0x5C,0x00,0x00,0x00,0x00,0x00,0x17,
		0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,0x1E,0x00,
		0x00,0x02,0x86,0x60,0x00,0x00,0x00,0x00,0x00,0x15,0x00,0x00,
		0x00,0x00;
	.var = .LN445;
	.var = .LN481;
	.byte =
		0x17,0x63,0x54,0x78,0x4C,0x6F,0x63,0x6B,0x00,0x01,0xD2,0x25,
		0x00,0x00,0x02,0x86,0x6F,0x00,0x00,0x00,0x00,0x00,0x17,0x75,
		0x78,0x50,0x72,0x65,0x76,0x69,0x6F,0x75,0x73,0x4D,0x65,0x73,
		0x73,0x61,0x67,0x65,0x73,0x57,0x61,0x69,0x74,0x69,0x6E,0x67,
		0x00,0x01,0x9D,0x21,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,
		0x00,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN471;
	.var = .LN479;
	.byte =
		0x17,0x75,0x78,0x4E,0x75,0x6D,0x62,0x65,0x72,0x4F,0x66,0x54,
		0x61,0x73,0x6B,0x73,0x00,0x01,0x9D,0x21,0x00,0x00,0x02,0x86,
		0x78;
	.var = .LN478-.LN471;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x12,0xC4,0x03,0x00,0x00,0x13,0xEB,
		0x31,0x00,0x00,0x70,0x72,0x76,0x55,0x6E,0x6C,0x6F,0x63,0x6B,
		0x51,0x75,0x65,0x75,0x65,0x00,0x01;
	.var = .LNprvUnlockQueue.;
	.var = .LN.prvUnlockQueue..end;
	.byte =
		0x01,0x00,0x00,0x14,0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,
		0xE4,0x1E,0x00,0x00,0x02,0x86,0x68,0x00,0x15,0x00,0x00,0x00,
		0x00;
	.var = .LN485;
	.var = .LN.prvUnlockQueue..end;
	.byte =
		0x15,0xC5,0x31,0x00,0x00;
	.var = .LN486;
	.var = .LN505;
	.byte =
		0x17,0x63,0x54,0x78,0x4C,0x6F,0x63,0x6B,0x00,0x01,0x5E,0x07,
		0x00,0x00,0x02,0x86,0x6F,0x00,0x00,0x00,0x00,0x00,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN507;
	.var = .LN518;
	.byte =
		0x17,0x63,0x52,0x78,0x4C,0x6F,0x63,0x6B,0x00,0x01,0x5E,0x07,
		0x00,0x00,0x02,0x86,0x77,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x00,0x16,0xCC,0x32,0x00,0x00,0x78,0x51,0x75,0x65,0x75,0x65,
		0x52,0x65,0x63,0x65,0x69,0x76,0x65,0x00,0x01;
	.var = .LNxQueueReceive.;
	.var = .LN.xQueueReceive..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x54,0x00,0x14,
		0x70,0x76,0x42,0x75,0x66,0x66,0x65,0x72,0x00,0xD9,0x1E,0x00,
		0x00,0x02,0x86,0x58,0x00,0x14,0x78,0x54,0x69,0x63,0x6B,0x73,
		0x54,0x6F,0x57,0x61,0x69,0x74,0x00,0x7A,0x0E,0x00,0x00,0x02,
		0x86,0x5C,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN520;
	.var = .LN.xQueueReceive..end;
	.byte =
		0x17,0x78,0x45,0x6E,0x74,0x72,0x79,0x54,0x69,0x6D,0x65,0x53,
		0x65,0x74,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,0x60;
	.var = .LN520-.LNxQueueReceive.;
	.byte =
		0x00,0x17,0x78,0x54,0x69,0x6D,0x65,0x4F,0x75,0x74,0x00,0x01,
		0xAE,0x18,0x00,0x00,0x02,0x86,0x4C;
	.var = .LN520-.LNxQueueReceive.;
	.byte =
		0x00,0x17,0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,
		0x1E,0x00,0x00,0x02,0x86,0x64;
	.var = .LN520-.LNxQueueReceive.;
	.byte =
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN534;
	.var = .LN559;
	.byte =
		0x17,0x75,0x78,0x4D,0x65,0x73,0x73,0x61,0x67,0x65,0x73,0x57,
		0x61,0x69,0x74,0x69,0x6E,0x67,0x00,0x01,0x9D,0x21,0x00,0x00,
		0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,
		0x43,0x33,0x00,0x00,0x78,0x51,0x75,0x65,0x75,0x65,0x53,0x65,
		0x6C,0x65,0x63,0x74,0x46,0x72,0x6F,0x6D,0x53,0x65,0x74,0x00,
		0x01;
	.var = .LNxQueueSelectFromSet.;
	.var = .LN.xQueueSelectFromSet..end;
	.byte =
		0x01,0xD3,0x1D,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x53,0x65,0x74,0x00,0xBC,0x1D,0x00,0x00,0x02,0x86,
		0x70,0x00,0x14,0x78,0x54,0x69,0x63,0x6B,0x73,0x54,0x6F,0x57,
		0x61,0x69,0x74,0x00,0x43,0x33,0x00,0x00,0x02,0x86,0x74,0x00,
		0x15,0x00,0x00,0x00,0x00;
	.var = .LN600;
	.var = .LN.xQueueSelectFromSet..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0xD3,0x1D,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN600-.LNxQueueSelectFromSet.;
	.byte =
		0x00,0x00,0x00,0x12,0x7A,0x0E,0x00,0x00,0x16,0x74,0x34,0x00,
		0x00,0x78,0x51,0x75,0x65,0x75,0x65,0x53,0x65,0x6D,0x61,0x70,
		0x68,0x6F,0x72,0x65,0x54,0x61,0x6B,0x65,0x00,0x01;
	.var = .LNxQueueSemaphoreTake.;
	.var = .LN.xQueueSemaphoreTake..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x54,0x00,0x14,
		0x78,0x54,0x69,0x63,0x6B,0x73,0x54,0x6F,0x57,0x61,0x69,0x74,
		0x00,0x7A,0x0E,0x00,0x00,0x02,0x86,0x58,0x00,0x15,0x00,0x00,
		0x00,0x00;
	.var = .LN603;
	.var = .LN.xQueueSemaphoreTake..end;
	.byte =
		0x17,0x78,0x45,0x6E,0x74,0x72,0x79,0x54,0x69,0x6D,0x65,0x53,
		0x65,0x74,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,0x5C;
	.var = .LN603-.LNxQueueSemaphoreTake.;
	.byte =
		0x00,0x17,0x78,0x54,0x69,0x6D,0x65,0x4F,0x75,0x74,0x00,0x01,
		0xAE,0x18,0x00,0x00,0x02,0x86,0x4C;
	.var = .LN603-.LNxQueueSemaphoreTake.;
	.byte =
		0x00,0x17,0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,
		0x1E,0x00,0x00,0x02,0x86,0x60;
	.var = .LN603-.LNxQueueSemaphoreTake.;
	.byte =
		0x00,0x17,0x78,0x49,0x6E,0x68,0x65,0x72,0x69,0x74,0x61,0x6E,
		0x63,0x65,0x4F,0x63,0x63,0x75,0x72,0x72,0x65,0x64,0x00,0x01,
		0x57,0x0E,0x00,0x00,0x02,0x86,0x64;
	.var = .LN605-.LNxQueueSemaphoreTake.;
	.byte =
		0x00,0x15,0x3D,0x34,0x00,0x00;
	.var = .LN618;
	.var = .LN645;
	.byte =
		0x17,0x75,0x78,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,0x65,
		0x43,0x6F,0x75,0x6E,0x74,0x00,0x01,0x9D,0x21,0x00,0x00,0x02,
		0x86,0x6C,0x00,0x00,0x00,0x00,0x00,0x00,0x15,0x00,0x00,0x00,
		0x00;
	.var = .LN692;
	.var = .LN697;
	.byte =
		0x17,0x75,0x78,0x48,0x69,0x67,0x68,0x65,0x73,0x74,0x57,0x61,
		0x69,0x74,0x69,0x6E,0x67,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,
		0x79,0x00,0x01,0x68,0x0E,0x00,0x00,0x02,0x86,0x78,0x00,0x00,
		0x00,0x00,0x00,0x00,0x00,0x00,0x16,0x03,0x35,0x00,0x00,0x78,
		0x51,0x75,0x65,0x75,0x65,0x54,0x61,0x6B,0x65,0x4D,0x75,0x74,
		0x65,0x78,0x52,0x65,0x63,0x75,0x72,0x73,0x69,0x76,0x65,0x00,
		0x01;
	.var = .LNxQueueTakeMutexRecursive.;
	.var = .LN.xQueueTakeMutexRecursive..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x4D,0x75,0x74,
		0x65,0x78,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,
		0x78,0x54,0x69,0x63,0x6B,0x73,0x54,0x6F,0x57,0x61,0x69,0x74,
		0x00,0x7A,0x0E,0x00,0x00,0x02,0x86,0x70,0x00,0x15,0x00,0x00,
		0x00,0x00;
	.var = .LN702;
	.var = .LN.xQueueTakeMutexRecursive..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x17,0x70,
		0x78,0x4D,0x75,0x74,0x65,0x78,0x00,0x01,0xE4,0x1E,0x00,0x00,
		0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,0x06,
		0x36,0x00,0x00,0x78,0x51,0x75,0x65,0x75,0x65,0x50,0x65,0x65,
		0x6B,0x00,0x01;
	.var = .LNxQueuePeek.;
	.var = .LN.xQueuePeek..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x50,0x00,0x14,
		0x70,0x76,0x42,0x75,0x66,0x66,0x65,0x72,0x00,0xD9,0x1E,0x00,
		0x00,0x02,0x86,0x54,0x00,0x14,0x78,0x54,0x69,0x63,0x6B,0x73,
		0x54,0x6F,0x57,0x61,0x69,0x74,0x00,0x7A,0x0E,0x00,0x00,0x02,
		0x86,0x58,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN718;
	.var = .LN.xQueuePeek..end;
	.byte =
		0x17,0x78,0x45,0x6E,0x74,0x72,0x79,0x54,0x69,0x6D,0x65,0x53,
		0x65,0x74,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,0x5C;
	.var = .LN718-.LNxQueuePeek.;
	.byte =
		0x00,0x17,0x78,0x54,0x69,0x6D,0x65,0x4F,0x75,0x74,0x00,0x01,
		0xAE,0x18,0x00,0x00,0x02,0x86,0x48;
	.var = .LN718-.LNxQueuePeek.;
	.byte =
		0x00,0x17,0x70,0x63,0x4F,0x72,0x69,0x67,0x69,0x6E,0x61,0x6C,
		0x52,0x65,0x61,0x64,0x50,0x6F,0x73,0x69,0x74,0x69,0x6F,0x6E,
		0x00,0x01,0x7A,0x1B,0x00,0x00,0x02,0x86,0x60;
	.var = .LN718-.LNxQueuePeek.;
	.byte =
		0x00,0x17,0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,
		0x1E,0x00,0x00,0x02,0x86,0x64;
	.var = .LN718-.LNxQueuePeek.;
	.byte =
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN732;
	.var = .LN758;
	.byte =
		0x17,0x75,0x78,0x4D,0x65,0x73,0x73,0x61,0x67,0x65,0x73,0x57,
		0x61,0x69,0x74,0x69,0x6E,0x67,0x00,0x01,0x9D,0x21,0x00,0x00,
		0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x13,
		0x9C,0x36,0x00,0x00,0x76,0x51,0x75,0x65,0x75,0x65,0x57,0x61,
		0x69,0x74,0x46,0x6F,0x72,0x4D,0x65,0x73,0x73,0x61,0x67,0x65,
		0x52,0x65,0x73,0x74,0x72,0x69,0x63,0x74,0x65,0x64,0x00,0x01;
	.var = .LNvQueueWaitForMessageRestricted.;
	.var = .LN.vQueueWaitForMessageRestricted..end;
	.byte =
		0x01,0x01,0x00,0x14,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0xA8,
		0x1D,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x78,0x54,0x69,0x63,
		0x6B,0x73,0x54,0x6F,0x57,0x61,0x69,0x74,0x00,0x7A,0x0E,0x00,
		0x00,0x02,0x86,0x70,0x00,0x14,0x78,0x57,0x61,0x69,0x74,0x49,
		0x6E,0x64,0x65,0x66,0x69,0x6E,0x69,0x74,0x65,0x6C,0x79,0x00,
		0xB6,0x28,0x00,0x00,0x02,0x86,0x74,0x00,0x15,0x00,0x00,0x00,
		0x00;
	.var = .LN799;
	.var = .LN.vQueueWaitForMessageRestricted..end;
	.byte =
		0x17,0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,0x1E,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x16,0xC2,0x37,0x00,0x00,0x78,0x51,0x75,0x65,0x75,0x65,0x47,
		0x65,0x6E,0x65,0x72,0x69,0x63,0x53,0x65,0x6E,0x64,0x00,0x01;
	.var = .LNxQueueGenericSend.;
	.var = .LN.xQueueGenericSend..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x51,0x75,0x65,
		0x75,0x65,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x4C,0x00,0x14,
		0x70,0x76,0x49,0x74,0x65,0x6D,0x54,0x6F,0x51,0x75,0x65,0x75,
		0x65,0x00,0x5E,0x31,0x00,0x00,0x02,0x86,0x50,0x00,0x14,0x78,
		0x54,0x69,0x63,0x6B,0x73,0x54,0x6F,0x57,0x61,0x69,0x74,0x00,
		0x7A,0x0E,0x00,0x00,0x02,0x86,0x54,0x00,0x14,0x78,0x43,0x6F,
		0x70,0x79,0x50,0x6F,0x73,0x69,0x74,0x69,0x6F,0x6E,0x00,0xB6,
		0x28,0x00,0x00,0x02,0x86,0x04,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN815;
	.var = .LN.xQueueGenericSend..end;
	.byte =
		0x17,0x78,0x45,0x6E,0x74,0x72,0x79,0x54,0x69,0x6D,0x65,0x53,
		0x65,0x74,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,0x58;
	.var = .LN815-.LNxQueueGenericSend.;
	.byte =
		0x00,0x17,0x78,0x59,0x69,0x65,0x6C,0x64,0x52,0x65,0x71,0x75,
		0x69,0x72,0x65,0x64,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,
		0x5C;
	.var = .LN815-.LNxQueueGenericSend.;
	.byte =
		0x00,0x17,0x78,0x54,0x69,0x6D,0x65,0x4F,0x75,0x74,0x00,0x01,
		0xAE,0x18,0x00,0x00,0x02,0x86,0x44;
	.var = .LN815-.LNxQueueGenericSend.;
	.byte =
		0x00,0x17,0x70,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0xE4,
		0x1E,0x00,0x00,0x02,0x86,0x60;
	.var = .LN815-.LNxQueueGenericSend.;
	.byte =
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN833;
	.var = .LN868;
	.byte =
		0x17,0x75,0x78,0x50,0x72,0x65,0x76,0x69,0x6F,0x75,0x73,0x4D,
		0x65,0x73,0x73,0x61,0x67,0x65,0x73,0x57,0x61,0x69,0x74,0x69,
		0x6E,0x67,0x00,0x01,0x9D,0x21,0x00,0x00,0x02,0x86,0x70,0x00,
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x13,0x09,0x38,0x00,0x00,
		0x70,0x72,0x76,0x49,0x6E,0x69,0x74,0x69,0x61,0x6C,0x69,0x73,
		0x65,0x4D,0x75,0x74,0x65,0x78,0x00,0x01;
	.var = .LNprvInitialiseMutex.;
	.var = .LN.prvInitialiseMutex..end;
	.byte =
		0x01,0x00,0x00,0x14,0x70,0x78,0x4E,0x65,0x77,0x51,0x75,0x65,
		0x75,0x65,0x00,0xDE,0x1E,0x00,0x00,0x02,0x86,0x78,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN914;
	.var = .LN.prvInitialiseMutex..end;
	.byte =
		0x00,0x00,0x16,0xA2,0x38,0x00,0x00,0x78,0x51,0x75,0x65,0x75,
		0x65,0x43,0x72,0x65,0x61,0x74,0x65,0x4D,0x75,0x74,0x65,0x78,
		0x00,0x01;
	.var = .LNxQueueCreateMutex.;
	.var = .LN.xQueueCreateMutex..end;
	.byte =
		0x01,0xA8,0x1D,0x00,0x00,0x01,0x00,0x14,0x75,0x63,0x51,0x75,
		0x65,0x75,0x65,0x54,0x79,0x70,0x65,0x00,0x98,0x21,0x00,0x00,
		0x02,0x86,0x6C,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN922;
	.var = .LN.xQueueCreateMutex..end;
	.byte =
		0x17,0x78,0x4E,0x65,0x77,0x51,0x75,0x65,0x75,0x65,0x00,0x01,
		0xA8,0x1D,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,
		0x17,0x75,0x78,0x4D,0x75,0x74,0x65,0x78,0x4C,0x65,0x6E,0x67,
		0x74,0x68,0x00,0x01,0x9D,0x21,0x00,0x00,0x02,0x86,0x74;
	.var = .LN922-.LNxQueueCreateMutex.;
	.byte =
		0x00,0x17,0x75,0x78,0x4D,0x75,0x74,0x65,0x78,0x53,0x69,0x7A,
		0x65,0x00,0x01,0x9D,0x21,0x00,0x00,0x02,0x86,0x78;
	.var = .LN923-.LNxQueueCreateMutex.;
	.byte =
		0x00,0x00,0x00,0x16,0x58,0x39,0x00,0x00,0x78,0x51,0x75,0x65,
		0x75,0x65,0x43,0x72,0x65,0x61,0x74,0x65,0x4D,0x75,0x74,0x65,
		0x78,0x53,0x74,0x61,0x74,0x69,0x63,0x00,0x01;
	.var = .LNxQueueCreateMutexStatic.;
	.var = .LN.xQueueCreateMutexStatic..end;
	.byte =
		0x01,0xA8,0x1D,0x00,0x00,0x01,0x00,0x14,0x75,0x63,0x51,0x75,
		0x65,0x75,0x65,0x54,0x79,0x70,0x65,0x00,0x98,0x21,0x00,0x00,
		0x02,0x86,0x68,0x00,0x14,0x70,0x78,0x53,0x74,0x61,0x74,0x69,
		0x63,0x51,0x75,0x65,0x75,0x65,0x00,0x8B,0x22,0x00,0x00,0x02,
		0x86,0x6C,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN928;
	.var = .LN.xQueueCreateMutexStatic..end;
	.byte =
		0x17,0x78,0x4E,0x65,0x77,0x51,0x75,0x65,0x75,0x65,0x00,0x01,
		0xA8,0x1D,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,
		0x17,0x75,0x78,0x4D,0x75,0x74,0x65,0x78,0x4C,0x65,0x6E,0x67,
		0x74,0x68,0x00,0x01,0x9D,0x21,0x00,0x00,0x02,0x86,0x74;
	.var = .LN928-.LNxQueueCreateMutexStatic.;
	.byte =
		0x00,0x17,0x75,0x78,0x4D,0x75,0x74,0x65,0x78,0x53,0x69,0x7A,
		0x65,0x00,0x01,0x9D,0x21,0x00,0x00,0x02,0x86,0x78;
	.var = .LN929-.LNxQueueCreateMutexStatic.;
	.byte =
		0x00,0x00,0x00,0x16,0xD1,0x39,0x00,0x00,0x78,0x51,0x75,0x65,
		0x75,0x65,0x47,0x69,0x76,0x65,0x4D,0x75,0x74,0x65,0x78,0x52,
		0x65,0x63,0x75,0x72,0x73,0x69,0x76,0x65,0x00,0x01;
	.var = .LNxQueueGiveMutexRecursive.;
	.var = .LN.xQueueGiveMutexRecursive..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x78,0x4D,0x75,0x74,
		0x65,0x78,0x00,0xA8,0x1D,0x00,0x00,0x02,0x86,0x70,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN934;
	.var = .LN.xQueueGiveMutexRecursive..end;
	.byte =
		0x17,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x17,0x70,
		0x78,0x4D,0x75,0x74,0x65,0x78,0x00,0x01,0xE4,0x1E,0x00,0x00,
		0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x17,0x5F,
		0x61,0x64,0x69,0x5F,0x4F,0x53,0x52,0x65,0x73,0x63,0x68,0x65,
		0x64,0x75,0x6C,0x65,0x49,0x6E,0x74,0x49,0x44,0x00,0x01,0xA4,
		0x07,0x00,0x00,0x05,0x03;
	.var = _adi_OSRescheduleIntID.;
	.byte =
		0x00,0x00,0x00,0x00,0x01,0x17,0x5F,0x61,0x64,0x69,0x5F,0x4F,
		0x53,0x57,0x61,0x69,0x74,0x69,0x6E,0x67,0x46,0x6F,0x72,0x53,
		0x63,0x68,0x65,0x64,0x00,0x01,0x4F,0x3A,0x00,0x00,0x05,0x03;
	.var = _adi_OSWaitingForSched.;
	.byte =
		0x00,0x00,0x00,0x00,0x01,0x17,0x78,0x51,0x75,0x65,0x75,0x65,
		0x52,0x65,0x67,0x69,0x73,0x74,0x72,0x79,0x00,0x01,0x41,0x3A,
		0x00,0x00,0x05,0x03;
	.var = xQueueRegistry.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x0D,0x4F,0x3A,0x00,0x00,0x67,0x1E,
		0x00,0x00,0x0E,0x08,0x00,0x07,0x00,0x10,0xA4,0x07,0x00,0x00,
		0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\FreeRTOS\queue.sbn", 8221, 2054;
	.var = .LNprvCopyDataFromQueue.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xE5,0x11,0x01,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvCopyDataFromQueue..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvGetDisinheritPriorityAfterTimeout.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xF8,0x10,0x01,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x09,0x12,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN.prvGetDisinheritPriorityAfterTimeout..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNucQueueGetQueueType.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xEE,0x10,0x01,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN.ucQueueGetQueueType..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvQueueSetQueueNumber.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xE4,0x10,0x01,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN.vQueueSetQueueNumber..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNuxQueueGetQueueNumber.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xD9,0x10,0x01,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN.uxQueueGetQueueNumber..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueGenericReset.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xBC,0x02,0x01,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x10,0x0A,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x1D,0x0A,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x05,0x11,0x10,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x31,0x01,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN46;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN47;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN48;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN49;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN50;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN51;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN52;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN53;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN.xQueueGenericReset..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvInitialiseNewQueue.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x84,0x04,0x01,0x00,0x05,0x02;
	.var = .LN54;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN55;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN56;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN57;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN58;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN59;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN60;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN61;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN62;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN63;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN64;
	.byte =
		0x05,0x01,0x0E,0x00,0x05,0x02;
	.var = .LN.prvInitialiseNewQueue..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueGenericCreateStatic.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0x84,0x03,0x01,0x00,0x05,0x02;
	.var = .LN65;
	.byte =
		0x05,0x13,0x0A,0x00,0x05,0x02;
	.var = .LN66;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN67;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN68;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN69;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN70;
	.byte =
		0x05,0x18,0x16,0x00,0x05,0x02;
	.var = .LN71;
	.byte =
		0x05,0x0D,0x14,0x00,0x05,0x02;
	.var = .LN72;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN73;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN74;
	.byte =
		0x05,0x22,0x01,0x00,0x05,0x02;
	.var = .LN75;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN76;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN77;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN78;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN79;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN.xQueueGenericCreateStatic..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueGenericCreate.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xC0,0x03,0x01,0x00,0x05,0x02;
	.var = .LN80;
	.byte =
		0x05,0x13,0x0A,0x00,0x05,0x02;
	.var = .LN81;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN82;
	.byte =
		0x05,0x0D,0x12,0x00,0x05,0x02;
	.var = .LN83;
	.byte =
		0x14,0x00,0x05,0x02;
	.var = .LN84;
	.byte =
		0x05,0x34,0x01,0x00,0x05,0x02;
	.var = .LN85;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN86;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN87;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN88;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN89;
	.byte =
		0x05,0x15,0x10,0x00,0x05,0x02;
	.var = .LN90;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN91;
	.byte =
		0x05,0x26,0x01,0x00,0x05,0x02;
	.var = .LN92;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN93;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN94;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN95;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN96;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN97;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN.xQueueGenericCreate..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueCreateCountingSemaphoreStatic.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0x92,0x06,0x01,0x00,0x05,0x02;
	.var = .LN98;
	.byte =
		0x05,0x17,0x0A,0x00,0x05,0x02;
	.var = .LN99;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN100;
	.byte =
		0x05,0x30,0x0C,0x00,0x05,0x02;
	.var = .LN101;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN102;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN103;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN104;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN105;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN106;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN107;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN108;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN109;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN.xQueueCreateCountingSemaphoreStatic..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueCreateCountingSemaphore.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xB5,0x06,0x01,0x00,0x05,0x02;
	.var = .LN110;
	.byte =
		0x05,0x17,0x0A,0x00,0x05,0x02;
	.var = .LN111;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN112;
	.byte =
		0x05,0x2A,0x0C,0x00,0x05,0x02;
	.var = .LN113;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN114;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN115;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN116;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN117;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN118;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN119;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN120;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN121;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN.xQueueCreateCountingSemaphore..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueReceiveFromISR.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xEE,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN122;
	.byte =
		0x05,0x1D,0x0C,0x00,0x05,0x02;
	.var = .LN123;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN124;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN125;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN126;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN127;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN128;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN129;
	.byte =
		0x19,0x00,0x05,0x02;
	.var = .LN130;
	.byte =
		0x05,0x1E,0x0B,0x00,0x05,0x02;
	.var = .LN131;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN132;
	.byte =
		0x05,0x2D,0x0B,0x00,0x05,0x02;
	.var = .LN133;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN134;
	.byte =
		0x05,0x22,0x0B,0x00,0x05,0x02;
	.var = .LN135;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN136;
	.byte =
		0x05,0x21,0x01,0x00,0x05,0x02;
	.var = .LN137;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN138;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN139;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN140;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN141;
	.byte =
		0x05,0x31,0x01,0x00,0x05,0x02;
	.var = .LN142;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN143;
	.byte =
		0x05,0x19,0x0D,0x00,0x05,0x02;
	.var = .LN144;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN145;
	.byte =
		0x05,0x19,0x0A,0x00,0x05,0x02;
	.var = .LN146;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN147;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN148;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN149;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN150;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN151;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN152;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN153;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN154;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN155;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN156;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN157;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN158;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN159;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN160;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN161;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN162;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xQueueReceiveFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueuePeekFromISR.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xCA,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN163;
	.byte =
		0x05,0x1D,0x0D,0x00,0x05,0x02;
	.var = .LN164;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN165;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN166;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN167;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN168;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN169;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN170;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN171;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN172;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN173;
	.byte =
		0x19,0x00,0x05,0x02;
	.var = .LN174;
	.byte =
		0x05,0x1E,0x0B,0x00,0x05,0x02;
	.var = .LN175;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN176;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN177;
	.byte =
		0x05,0x0D,0x0F,0x00,0x05,0x02;
	.var = .LN178;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN179;
	.byte =
		0x05,0x21,0x01,0x00,0x05,0x02;
	.var = .LN180;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN181;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN182;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN183;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN184;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN185;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN186;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xQueuePeekFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNuxQueueMessagesWaiting.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x80,0x10,0x01,0x00,0x05,0x02;
	.var = .LN187;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN188;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN189;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN190;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN191;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN192;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN193;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.uxQueueMessagesWaiting..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNuxQueueSpacesAvailable.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x90,0x10,0x01,0x00,0x05,0x02;
	.var = .LN194;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN195;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN196;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN197;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN198;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN199;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN200;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN201;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.uxQueueSpacesAvailable..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNuxQueueMessagesWaitingFromISR.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xA1,0x10,0x01,0x00,0x05,0x02;
	.var = .LN202;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN203;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN204;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN205;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN206;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN207;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.uxQueueMessagesWaitingFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvCopyDataToQueue.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x93,0x11,0x01,0x00,0x05,0x02;
	.var = .LN208;
	.byte =
		0x05,0x10,0x0A,0x00,0x05,0x02;
	.var = .LN209;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN210;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN211;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN212;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN213;
	.byte =
		0x05,0x32,0x01,0x00,0x05,0x02;
	.var = .LN214;
	.byte =
		0x05,0x11,0x01,0x00,0x05,0x02;
	.var = .LN215;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN216;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN217;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN218;
	.byte =
		0x05,0x0A,0x0A,0x00,0x05,0x02;
	.var = .LN219;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN220;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN221;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN222;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN223;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN224;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN225;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN226;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN227;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN228;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN229;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN230;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN231;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN232;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN233;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN234;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN235;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN236;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.prvCopyDataToQueue..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvIsQueueEmpty.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xF1,0x12,0x01,0x00,0x05,0x02;
	.var = .LN237;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN238;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN239;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN240;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN241;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN242;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN243;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.prvIsQueueEmpty..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueIsQueueEmptyFromISR.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x86,0x13,0x01,0x00,0x05,0x02;
	.var = .LN244;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN245;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN246;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN247;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN248;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN249;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN250;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN251;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN252;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN.xQueueIsQueueEmptyFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvIsQueueFull.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x9A,0x13,0x01,0x00,0x05,0x02;
	.var = .LN253;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN254;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN255;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN256;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN257;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN258;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN259;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.prvIsQueueFull..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueIsQueueFullFromISR.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xAF,0x13,0x01,0x00,0x05,0x02;
	.var = .LN260;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN261;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN262;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN263;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN264;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN265;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN266;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN267;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN268;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN.xQueueIsQueueFullFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvQueueAddToRegistry.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xE5,0x15,0x01,0x00,0x05,0x02;
	.var = .LN269;
	.byte =
		0x05,0x1F,0x0B,0x00,0x05,0x02;
	.var = .LN270;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN271;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN272;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN273;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN274;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN275;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN276;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN277;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN278;
	.byte =
		0x05,0x16,0x0C,0x00,0x05,0x02;
	.var = .LN279;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN280;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN281;
	.byte =
		0x05,0x5B,0x03,0x74,0x01,0x00,0x05,0x02;
	.var = .LN282;
	.byte =
		0x05,0x09,0x1B,0x00,0x05,0x02;
	.var = .LN283;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN284;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN285;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN286;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN287;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN.vQueueAddToRegistry..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNpcQueueGetName.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0x93,0x16,0x01,0x00,0x05,0x02;
	.var = .LN288;
	.byte =
		0x05,0x16,0x0B,0x00,0x05,0x02;
	.var = .LN289;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN290;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN291;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN292;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN293;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN294;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN295;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN296;
	.byte =
		0x05,0x57,0x03,0x7B,0x01,0x00,0x05,0x02;
	.var = .LN297;
	.byte =
		0x05,0x09,0x16,0x00,0x05,0x02;
	.var = .LN.pcQueueGetName..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvQueueUnregisterQueue.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xB2,0x16,0x01,0x00,0x05,0x02;
	.var = .LN298;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN299;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN300;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN301;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN302;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN303;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN304;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN305;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN306;
	.byte =
		0x05,0x57,0x03,0x75,0x01,0x00,0x05,0x02;
	.var = .LN307;
	.byte =
		0x05,0x05,0x1B,0x00,0x05,0x02;
	.var = .LN.vQueueUnregisterQueue..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvQueueDelete.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xAD,0x10,0x01,0x00,0x05,0x02;
	.var = .LN308;
	.byte =
		0x05,0x1D,0x0A,0x00,0x05,0x02;
	.var = .LN309;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN310;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN311;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN312;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN313;
	.byte =
		0x05,0x1E,0x01,0x00,0x05,0x02;
	.var = .LN314;
	.byte =
		0x05,0x09,0x17,0x00,0x05,0x02;
	.var = .LN315;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN316;
	.byte =
		0x05,0x16,0x01,0x00,0x05,0x02;
	.var = .LN317;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN318;
	.byte =
		0x05,0x01,0x16,0x00,0x05,0x02;
	.var = .LN.vQueueDelete..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueCreateSet.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xFB,0x16,0x01,0x00,0x05,0x02;
	.var = .LN319;
	.byte =
		0x05,0x26,0x0C,0x00,0x05,0x02;
	.var = .LN320;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN321;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xQueueCreateSet..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueAddToSet.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0x8A,0x17,0x01,0x00,0x05,0x02;
	.var = .LN322;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN323;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN324;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN325;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN326;
	.byte =
		0x05,0x12,0x0A,0x00,0x05,0x02;
	.var = .LN327;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN328;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN329;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN330;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN331;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN332;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xQueueAddToSet..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueRemoveFromSet.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xAC,0x17,0x01,0x00,0x05,0x02;
	.var = .LN333;
	.byte =
		0x05,0x2C,0x0B,0x00,0x05,0x02;
	.var = .LN334;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN335;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN336;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN337;
	.byte =
		0x05,0x0E,0x0A,0x00,0x05,0x02;
	.var = .LN338;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN339;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN340;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN341;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN342;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN343;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN344;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN.xQueueRemoveFromSet..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueSelectFromSetFromISR.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xDE,0x17,0x01,0x00,0x05,0x02;
	.var = .LN345;
	.byte =
		0x05,0x20,0x0A,0x00,0x05,0x02;
	.var = .LN346;
	.byte =
		0x05,0x26,0x0B,0x00,0x05,0x02;
	.var = .LN347;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN.xQueueSelectFromSetFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvNotifyQueueSetContainer.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xEB,0x17,0x01,0x00,0x05,0x02;
	.var = .LN348;
	.byte =
		0x05,0x14,0x0B,0x00,0x05,0x02;
	.var = .LN349;
	.byte =
		0x05,0x27,0x03,0x7F,0x01,0x00,0x05,0x02;
	.var = .LN350;
	.byte =
		0x05,0x09,0x11,0x00,0x05,0x02;
	.var = .LN351;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN352;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN353;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN354;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN355;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN356;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN357;
	.byte =
		0x05,0x22,0x0B,0x00,0x05,0x02;
	.var = .LN358;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN359;
	.byte =
		0x05,0x29,0x01,0x00,0x05,0x02;
	.var = .LN360;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN361;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN362;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN363;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN364;
	.byte =
		0x05,0x31,0x01,0x00,0x05,0x02;
	.var = .LN365;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN366;
	.byte =
		0x05,0x19,0x0C,0x00,0x05,0x02;
	.var = .LN367;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN368;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN369;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN370;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN371;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN372;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN373;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN374;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN375;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN376;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN377;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN378;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN379;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN.prvNotifyQueueSetContainer..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueGiveFromISR.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xCF,0x09,0x01,0x00,0x05,0x02;
	.var = .LN380;
	.byte =
		0x05,0x1D,0x0C,0x00,0x05,0x02;
	.var = .LN381;
	.byte =
		0x05,0x05,0x11,0x00,0x05,0x02;
	.var = .LN382;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN383;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN384;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN385;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN386;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN387;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN388;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN389;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN390;
	.byte =
		0x19,0x00,0x05,0x02;
	.var = .LN391;
	.byte =
		0x05,0x1E,0x0B,0x00,0x05,0x02;
	.var = .LN392;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN393;
	.byte =
		0x05,0x2D,0x0B,0x00,0x05,0x02;
	.var = .LN394;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN395;
	.byte =
		0x05,0x22,0x0B,0x00,0x05,0x02;
	.var = .LN396;
	.byte =
		0x05,0x0D,0x13,0x00,0x05,0x02;
	.var = .LN397;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN398;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN399;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN400;
	.byte =
		0x05,0x37,0x01,0x00,0x05,0x02;
	.var = .LN401;
	.byte =
		0x05,0x19,0x01,0x00,0x05,0x02;
	.var = .LN402;
	.byte =
		0x05,0x1D,0x0E,0x00,0x05,0x02;
	.var = .LN403;
	.byte =
		0x05,0x21,0x0B,0x00,0x05,0x02;
	.var = .LN404;
	.byte =
		0x05,0x1D,0x0A,0x00,0x05,0x02;
	.var = .LN405;
	.byte =
		0x05,0x19,0x0E,0x00,0x05,0x02;
	.var = .LN406;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN407;
	.byte =
		0x05,0x19,0x0C,0x00,0x05,0x02;
	.var = .LN408;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN409;
	.byte =
		0x05,0x39,0x01,0x00,0x05,0x02;
	.var = .LN410;
	.byte =
		0x05,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN411;
	.byte =
		0x05,0x21,0x0D,0x00,0x05,0x02;
	.var = .LN412;
	.byte =
		0x05,0x25,0x0B,0x00,0x05,0x02;
	.var = .LN413;
	.byte =
		0x05,0x21,0x0A,0x00,0x05,0x02;
	.var = .LN414;
	.byte =
		0x05,0x1D,0x0E,0x00,0x05,0x02;
	.var = .LN415;
	.byte =
		0x05,0x19,0x0E,0x00,0x05,0x02;
	.var = .LN416;
	.byte =
		0x05,0x0D,0x2C,0x00,0x05,0x02;
	.var = .LN417;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN418;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN419;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN420;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN421;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN422;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN423;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN424;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN425;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN426;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN427;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN428;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN429;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN430;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xQueueGiveFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueGenericSendFromISR.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xAC,0x08,0x01,0x00,0x05,0x02;
	.var = .LN431;
	.byte =
		0x05,0x1D,0x0C,0x00,0x05,0x02;
	.var = .LN432;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN433;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN434;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN435;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN436;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN437;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN438;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN439;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN440;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN441;
	.byte =
		0x19,0x00,0x05,0x02;
	.var = .LN442;
	.byte =
		0x05,0x1E,0x10,0x00,0x05,0x02;
	.var = .LN443;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN444;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN445;
	.byte =
		0x05,0x22,0x0B,0x00,0x05,0x02;
	.var = .LN446;
	.byte =
		0x05,0x39,0x0A,0x00,0x05,0x02;
	.var = .LN447;
	.byte =
		0x05,0x0D,0x12,0x00,0x05,0x02;
	.var = .LN448;
	.byte =
		0x05,0x28,0x01,0x00,0x05,0x02;
	.var = .LN449;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN450;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN451;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN452;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN453;
	.byte =
		0x05,0x1E,0x0A,0x00,0x05,0x02;
	.var = .LN454;
	.byte =
		0x05,0x3C,0x01,0x00,0x05,0x02;
	.var = .LN455;
	.byte =
		0x05,0x1E,0x01,0x00,0x05,0x02;
	.var = .LN456;
	.byte =
		0x05,0x1D,0x0E,0x00,0x05,0x02;
	.var = .LN457;
	.byte =
		0x05,0x21,0x0B,0x00,0x05,0x02;
	.var = .LN458;
	.byte =
		0x05,0x1D,0x0A,0x00,0x05,0x02;
	.var = .LN459;
	.byte =
		0x05,0x19,0x0E,0x00,0x05,0x02;
	.var = .LN460;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN461;
	.byte =
		0x05,0x19,0x0C,0x00,0x05,0x02;
	.var = .LN462;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN463;
	.byte =
		0x05,0x39,0x01,0x00,0x05,0x02;
	.var = .LN464;
	.byte =
		0x05,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN465;
	.byte =
		0x05,0x21,0x0D,0x00,0x05,0x02;
	.var = .LN466;
	.byte =
		0x05,0x25,0x0B,0x00,0x05,0x02;
	.var = .LN467;
	.byte =
		0x05,0x21,0x0A,0x00,0x05,0x02;
	.var = .LN468;
	.byte =
		0x05,0x1D,0x0E,0x00,0x05,0x02;
	.var = .LN469;
	.byte =
		0x05,0x19,0x0E,0x00,0x05,0x02;
	.var = .LN470;
	.byte =
		0x05,0x0D,0x2F,0x00,0x05,0x02;
	.var = .LN471;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN472;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN473;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN474;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN475;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN476;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN477;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN478;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN479;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN480;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN481;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN482;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN483;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN484;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xQueueGenericSendFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvUnlockQueue.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xF9,0x11,0x01,0x00,0x05,0x02;
	.var = .LN485;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN486;
	.byte =
		0x05,0x18,0x0B,0x00,0x05,0x02;
	.var = .LN487;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN488;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN489;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN490;
	.byte =
		0x05,0x33,0x01,0x00,0x05,0x02;
	.var = .LN491;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN492;
	.byte =
		0x05,0x29,0x0E,0x00,0x05,0x02;
	.var = .LN493;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN494;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN495;
	.byte =
		0x05,0x15,0x0F,0x00,0x05,0x02;
	.var = .LN496;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN497;
	.byte =
		0x05,0x35,0x01,0x00,0x05,0x02;
	.var = .LN498;
	.byte =
		0x05,0x19,0x01,0x00,0x05,0x02;
	.var = .LN499;
	.byte =
		0x05,0x2D,0x0D,0x00,0x05,0x02;
	.var = .LN500;
	.byte =
		0x05,0x19,0x0A,0x00,0x05,0x02;
	.var = .LN501;
	.byte =
		0x05,0x11,0x13,0x00,0x05,0x02;
	.var = .LN502;
	.byte =
		0x05,0x19,0x03,0x7E,0x01,0x00,0x05,0x02;
	.var = .LN503;
	.byte =
		0x05,0x0D,0x25,0x00,0x05,0x02;
	.var = .LN504;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN505;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN506;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN507;
	.byte =
		0x05,0x18,0x0B,0x00,0x05,0x02;
	.var = .LN508;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN509;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN510;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN511;
	.byte =
		0x05,0x2D,0x01,0x00,0x05,0x02;
	.var = .LN512;
	.byte =
		0x05,0x11,0x01,0x00,0x05,0x02;
	.var = .LN513;
	.byte =
		0x05,0x25,0x0B,0x00,0x05,0x02;
	.var = .LN514;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN515;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN516;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN517;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN518;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN519;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvUnlockQueue..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueReceive.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xF6,0x0A,0x01,0x00,0x05,0x02;
	.var = .LN520;
	.byte =
		0x05,0x10,0x0A,0x00,0x05,0x02;
	.var = .LN521;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN522;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN523;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN524;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN525;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN526;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN527;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN528;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN529;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN530;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN531;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN532;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN533;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN534;
	.byte =
		0x05,0x31,0x0B,0x00,0x05,0x02;
	.var = .LN535;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN536;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN537;
	.byte =
		0x05,0x25,0x01,0x00,0x05,0x02;
	.var = .LN538;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN539;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN540;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN541;
	.byte =
		0x05,0x31,0x01,0x00,0x05,0x02;
	.var = .LN542;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN543;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN544;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN545;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN546;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN547;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN548;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN549;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN550;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN551;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN552;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN553;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN554;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN555;
	.byte =
		0x05,0x16,0x0B,0x00,0x05,0x02;
	.var = .LN556;
	.byte =
		0x05,0x31,0x0D,0x00,0x05,0x02;
	.var = .LN557;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN558;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN559;
	.byte =
		0x05,0x09,0x11,0x00,0x05,0x02;
	.var = .LN560;
	.byte =
		0x05,0x18,0x0E,0x00,0x05,0x02;
	.var = .LN561;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN562;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN563;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN564;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN565;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN566;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN567;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN568;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN569;
	.byte =
		0x05,0x21,0x0C,0x00,0x05,0x02;
	.var = .LN570;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN571;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN572;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN573;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN574;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN575;
	.byte =
		0x05,0x26,0x01,0x00,0x05,0x02;
	.var = .LN576;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN577;
	.byte =
		0x05,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN578;
	.byte =
		0x05,0x23,0x0B,0x00,0x05,0x02;
	.var = .LN579;
	.byte =
		0x05,0x11,0x01,0x00,0x05,0x02;
	.var = .LN580;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN581;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN582;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN583;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN584;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN585;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN586;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN587;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN588;
	.byte =
		0x05,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN589;
	.byte =
		0x05,0x28,0x0A,0x00,0x05,0x02;
	.var = .LN590;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN591;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN592;
	.byte =
		0x05,0x1B,0x01,0x00,0x05,0x02;
	.var = .LN593;
	.byte =
		0x05,0x24,0x0A,0x00,0x05,0x02;
	.var = .LN594;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN595;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN596;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN597;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN598;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN599;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.xQueueReceive..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueSelectFromSet.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xD1,0x17,0x01,0x00,0x05,0x02;
	.var = .LN600;
	.byte =
		0x05,0x20,0x0A,0x00,0x05,0x02;
	.var = .LN601;
	.byte =
		0x05,0x1F,0x0B,0x00,0x05,0x02;
	.var = .LN602;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN.xQueueSelectFromSet..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueSemaphoreTake.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x84,0x0C,0x01,0x00,0x05,0x02;
	.var = .LN603;
	.byte =
		0x05,0x10,0x0A,0x00,0x05,0x02;
	.var = .LN604;
	.byte =
		0x05,0x14,0x0E,0x00,0x05,0x02;
	.var = .LN605;
	.byte =
		0x05,0x1D,0x03,0x7D,0x01,0x00,0x05,0x02;
	.var = .LN606;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN607;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN608;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN609;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN610;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN611;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN612;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN613;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN614;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN615;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN616;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN617;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN618;
	.byte =
		0x05,0x30,0x0D,0x00,0x05,0x02;
	.var = .LN619;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN620;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN621;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN622;
	.byte =
		0x05,0x5B,0x0D,0x00,0x05,0x02;
	.var = .LN623;
	.byte =
		0x05,0x19,0x01,0x00,0x05,0x02;
	.var = .LN624;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN625;
	.byte =
		0x05,0x11,0x13,0x00,0x05,0x02;
	.var = .LN626;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN627;
	.byte =
		0x05,0x31,0x01,0x00,0x05,0x02;
	.var = .LN628;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN629;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN630;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN631;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN632;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN633;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN634;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN635;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN636;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN637;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN638;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN639;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN640;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN641;
	.byte =
		0x05,0x16,0x0B,0x00,0x05,0x02;
	.var = .LN642;
	.byte =
		0x05,0x31,0x0D,0x00,0x05,0x02;
	.var = .LN643;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN644;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN645;
	.byte =
		0x05,0x09,0x11,0x00,0x05,0x02;
	.var = .LN646;
	.byte =
		0x05,0x18,0x0E,0x00,0x05,0x02;
	.var = .LN647;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN648;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN649;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN650;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN651;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN652;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN653;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN654;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN655;
	.byte =
		0x05,0x21,0x0C,0x00,0x05,0x02;
	.var = .LN656;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN657;
	.byte =
		0x05,0x0D,0x0F,0x00,0x05,0x02;
	.var = .LN658;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN659;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN660;
	.byte =
		0x05,0x15,0x0F,0x00,0x05,0x02;
	.var = .LN661;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN662;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN663;
	.byte =
		0x05,0x48,0x01,0x00,0x05,0x02;
	.var = .LN664;
	.byte =
		0x05,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN665;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN666;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN667;
	.byte =
		0x05,0x11,0x11,0x00,0x05,0x02;
	.var = .LN668;
	.byte =
		0x05,0x26,0x01,0x00,0x05,0x02;
	.var = .LN669;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN670;
	.byte =
		0x05,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN671;
	.byte =
		0x05,0x23,0x0B,0x00,0x05,0x02;
	.var = .LN672;
	.byte =
		0x05,0x11,0x01,0x00,0x05,0x02;
	.var = .LN673;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN674;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN675;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN676;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN677;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN678;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN679;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN680;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN681;
	.byte =
		0x05,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN682;
	.byte =
		0x05,0x28,0x0A,0x00,0x05,0x02;
	.var = .LN683;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN684;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN685;
	.byte =
		0x05,0x1B,0x01,0x00,0x05,0x02;
	.var = .LN686;
	.byte =
		0x05,0x24,0x0A,0x00,0x05,0x02;
	.var = .LN687;
	.byte =
		0x05,0x0D,0x0F,0x00,0x05,0x02;
	.var = .LN688;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN689;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN690;
	.byte =
		0x05,0x15,0x10,0x00,0x05,0x02;
	.var = .LN691;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN692;
	.byte =
		0x05,0x1D,0x12,0x00,0x05,0x02;
	.var = .LN693;
	.byte =
		0x05,0x5C,0x01,0x00,0x05,0x02;
	.var = .LN694;
	.byte =
		0x05,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN695;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN696;
	.byte =
		0x05,0x40,0x01,0x00,0x05,0x02;
	.var = .LN697;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN698;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN699;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN700;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN701;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.xQueueSemaphoreTake..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueTakeMutexRecursive.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xE6,0x05,0x01,0x00,0x05,0x02;
	.var = .LN702;
	.byte =
		0x05,0x21,0x0B,0x00,0x05,0x02;
	.var = .LN703;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN704;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN705;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN706;
	.byte =
		0x05,0x4C,0x10,0x00,0x05,0x02;
	.var = .LN707;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN708;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN709;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN710;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN711;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN712;
	.byte =
		0x05,0x2A,0x01,0x00,0x05,0x02;
	.var = .LN713;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN714;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN715;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN716;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN717;
	.byte =
		0x05,0x09,0x10,0x00,0x05,0x02;
	.var = .LN.xQueueTakeMutexRecursive..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueuePeek.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xD7,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN718;
	.byte =
		0x05,0x10,0x0A,0x00,0x05,0x02;
	.var = .LN719;
	.byte =
		0x05,0x1D,0x0C,0x00,0x05,0x02;
	.var = .LN720;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN721;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN722;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN723;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN724;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN725;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN726;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN727;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN728;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN729;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN730;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN731;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN732;
	.byte =
		0x05,0x31,0x0B,0x00,0x05,0x02;
	.var = .LN733;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN734;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN735;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN736;
	.byte =
		0x05,0x25,0x01,0x00,0x05,0x02;
	.var = .LN737;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN738;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN739;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN740;
	.byte =
		0x05,0x31,0x01,0x00,0x05,0x02;
	.var = .LN741;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN742;
	.byte =
		0x05,0x19,0x0C,0x00,0x05,0x02;
	.var = .LN743;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN744;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN745;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN746;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN747;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN748;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN749;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN750;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN751;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN752;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN753;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN754;
	.byte =
		0x05,0x16,0x0B,0x00,0x05,0x02;
	.var = .LN755;
	.byte =
		0x05,0x31,0x0E,0x00,0x05,0x02;
	.var = .LN756;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN757;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN758;
	.byte =
		0x05,0x09,0x11,0x00,0x05,0x02;
	.var = .LN759;
	.byte =
		0x05,0x18,0x0E,0x00,0x05,0x02;
	.var = .LN760;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN761;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN762;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN763;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN764;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN765;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN766;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN767;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN768;
	.byte =
		0x05,0x21,0x0C,0x00,0x05,0x02;
	.var = .LN769;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN770;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN771;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN772;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN773;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN774;
	.byte =
		0x05,0x26,0x01,0x00,0x05,0x02;
	.var = .LN775;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN776;
	.byte =
		0x05,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN777;
	.byte =
		0x05,0x23,0x0B,0x00,0x05,0x02;
	.var = .LN778;
	.byte =
		0x05,0x11,0x01,0x00,0x05,0x02;
	.var = .LN779;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN780;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN781;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN782;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN783;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN784;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN785;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN786;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN787;
	.byte =
		0x05,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN788;
	.byte =
		0x05,0x28,0x0A,0x00,0x05,0x02;
	.var = .LN789;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN790;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN791;
	.byte =
		0x05,0x1B,0x01,0x00,0x05,0x02;
	.var = .LN792;
	.byte =
		0x05,0x24,0x0A,0x00,0x05,0x02;
	.var = .LN793;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN794;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN795;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN796;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN797;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN798;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.xQueuePeek..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvQueueWaitForMessageRestricted.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xD5,0x16,0x01,0x00,0x05,0x02;
	.var = .LN799;
	.byte =
		0x05,0x21,0x0A,0x00,0x05,0x02;
	.var = .LN800;
	.byte =
		0x05,0x09,0x19,0x00,0x05,0x02;
	.var = .LN801;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN802;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN803;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN804;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN805;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN806;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN807;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN808;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN809;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN810;
	.byte =
		0x05,0x2C,0x01,0x00,0x05,0x02;
	.var = .LN811;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN812;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN813;
	.byte =
		0x05,0x17,0x01,0x00,0x05,0x02;
	.var = .LN814;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN.vQueueWaitForMessageRestricted..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueGenericSend.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xD8,0x06,0x01,0x00,0x05,0x02;
	.var = .LN815;
	.byte =
		0x05,0x10,0x0A,0x00,0x05,0x02;
	.var = .LN816;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN817;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN818;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN819;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN820;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN821;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN822;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN823;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN824;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN825;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN826;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN827;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN828;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN829;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN830;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN831;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN832;
	.byte =
		0x05,0x0D,0x0F,0x00,0x05,0x02;
	.var = .LN833;
	.byte =
		0x05,0x41,0x0F,0x00,0x05,0x02;
	.var = .LN834;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN835;
	.byte =
		0x05,0x38,0x01,0x00,0x05,0x02;
	.var = .LN836;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN837;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN838;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN839;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN840;
	.byte =
		0x05,0x1E,0x0A,0x00,0x05,0x02;
	.var = .LN841;
	.byte =
		0x05,0x3C,0x01,0x00,0x05,0x02;
	.var = .LN842;
	.byte =
		0x05,0x1E,0x01,0x00,0x05,0x02;
	.var = .LN843;
	.byte =
		0x05,0x1D,0x0E,0x00,0x05,0x02;
	.var = .LN844;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN845;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN846;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN847;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN848;
	.byte =
		0x05,0x19,0x0A,0x00,0x05,0x02;
	.var = .LN849;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN850;
	.byte =
		0x05,0x19,0x0E,0x00,0x05,0x02;
	.var = .LN851;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN852;
	.byte =
		0x05,0x39,0x01,0x00,0x05,0x02;
	.var = .LN853;
	.byte =
		0x05,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN854;
	.byte =
		0x05,0x21,0x0F,0x00,0x05,0x02;
	.var = .LN855;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN856;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN857;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN858;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN859;
	.byte =
		0x05,0x1D,0x0A,0x00,0x05,0x02;
	.var = .LN860;
	.byte =
		0x05,0x19,0x0E,0x00,0x05,0x02;
	.var = .LN861;
	.byte =
		0x05,0x1E,0x0A,0x00,0x05,0x02;
	.var = .LN862;
	.byte =
		0x05,0x1D,0x0F,0x00,0x05,0x02;
	.var = .LN863;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN864;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN865;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN866;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN867;
	.byte =
		0x05,0x19,0x0A,0x00,0x05,0x02;
	.var = .LN868;
	.byte =
		0x05,0x11,0x34,0x00,0x05,0x02;
	.var = .LN869;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN870;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN871;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN872;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN873;
	.byte =
		0x05,0x16,0x0B,0x00,0x05,0x02;
	.var = .LN874;
	.byte =
		0x05,0x31,0x0D,0x00,0x05,0x02;
	.var = .LN875;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN876;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN877;
	.byte =
		0x05,0x09,0x11,0x00,0x05,0x02;
	.var = .LN878;
	.byte =
		0x05,0x18,0x0E,0x00,0x05,0x02;
	.var = .LN879;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN880;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN881;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN882;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN883;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN884;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN885;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN886;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN887;
	.byte =
		0x05,0x21,0x0C,0x00,0x05,0x02;
	.var = .LN888;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN889;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN890;
	.byte =
		0x05,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN891;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN892;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN893;
	.byte =
		0x05,0x26,0x01,0x00,0x05,0x02;
	.var = .LN894;
	.byte =
		0x05,0x11,0x10,0x00,0x05,0x02;
	.var = .LN895;
	.byte =
		0x05,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN896;
	.byte =
		0x05,0x23,0x10,0x00,0x05,0x02;
	.var = .LN897;
	.byte =
		0x05,0x11,0x01,0x00,0x05,0x02;
	.var = .LN898;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN899;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN900;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN901;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN902;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN903;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN904;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN905;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN906;
	.byte =
		0x05,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN907;
	.byte =
		0x05,0x28,0x0A,0x00,0x05,0x02;
	.var = .LN908;
	.byte =
		0x05,0x05,0x15,0x00,0x05,0x02;
	.var = .LN909;
	.byte =
		0x05,0x0D,0x03,0x7A,0x01,0x00,0x05,0x02;
	.var = .LN910;
	.byte =
		0x05,0x1B,0x01,0x00,0x05,0x02;
	.var = .LN911;
	.byte =
		0x05,0x24,0x0A,0x00,0x05,0x02;
	.var = .LN912;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN913;
	.byte =
		0x05,0x01,0x0C,0x00,0x05,0x02;
	.var = .LN.xQueueGenericSend..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvInitialiseMutex.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xB0,0x04,0x01,0x00,0x05,0x02;
	.var = .LN914;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN915;
	.byte =
		0x05,0x0D,0x0F,0x00,0x05,0x02;
	.var = .LN916;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN917;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN918;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN919;
	.byte =
		0x05,0x27,0x01,0x00,0x05,0x02;
	.var = .LN920;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN921;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN.prvInitialiseMutex..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueCreateMutex.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xCE,0x04,0x01,0x00,0x05,0x02;
	.var = .LN922;
	.byte =
		0x05,0x1B,0x0B,0x00,0x05,0x02;
	.var = .LN923;
	.byte =
		0x05,0x3E,0x01,0x00,0x05,0x02;
	.var = .LN924;
	.byte =
		0x05,0x28,0x0B,0x00,0x05,0x02;
	.var = .LN925;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN926;
	.byte =
		0x05,0x1B,0x0A,0x00,0x05,0x02;
	.var = .LN927;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN.xQueueCreateMutex..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueCreateMutexStatic.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xDF,0x04,0x01,0x00,0x05,0x02;
	.var = .LN928;
	.byte =
		0x05,0x1B,0x0B,0x00,0x05,0x02;
	.var = .LN929;
	.byte =
		0x05,0x3E,0x01,0x00,0x05,0x02;
	.var = .LN930;
	.byte =
		0x05,0x2E,0x0F,0x00,0x05,0x02;
	.var = .LN931;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN932;
	.byte =
		0x05,0x1B,0x0A,0x00,0x05,0x02;
	.var = .LN933;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN.xQueueCreateMutexStatic..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxQueueGiveMutexRecursive.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xAE,0x05,0x01,0x00,0x05,0x02;
	.var = .LN934;
	.byte =
		0x05,0x21,0x0B,0x00,0x05,0x02;
	.var = .LN935;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN936;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN937;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN938;
	.byte =
		0x05,0x4C,0x11,0x00,0x05,0x02;
	.var = .LN939;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN940;
	.byte =
		0x05,0x0D,0x12,0x00,0x05,0x02;
	.var = .LN941;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN942;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN943;
	.byte =
		0x05,0x2B,0x01,0x00,0x05,0x02;
	.var = .LN944;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN945;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN946;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN947;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN948;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN.xQueueGiveMutexRecursive..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0xA2,0x03,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.inc/binary ".\system\FreeRTOS\queue.sbn", 10275, 924;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x74,0x01,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNprvCopyDataFromQueue.;
	.var = .LN.prvCopyDataFromQueue..end-.LNprvCopyDataFromQueue.;
	.var = .LNprvGetDisinheritPriorityAfterTimeout.;
	.var = .LN.prvGetDisinheritPriorityAfterTimeout..end-.LNprvGetDisinheritPriorityAfterTimeout.;
	.var = .LNucQueueGetQueueType.;
	.var = .LN.ucQueueGetQueueType..end-.LNucQueueGetQueueType.;
	.var = .LNvQueueSetQueueNumber.;
	.var = .LN.vQueueSetQueueNumber..end-.LNvQueueSetQueueNumber.;
	.var = .LNuxQueueGetQueueNumber.;
	.var = .LN.uxQueueGetQueueNumber..end-.LNuxQueueGetQueueNumber.;
	.var = .LNxQueueGenericReset.;
	.var = .LN.xQueueGenericReset..end-.LNxQueueGenericReset.;
	.var = .LNprvInitialiseNewQueue.;
	.var = .LN.prvInitialiseNewQueue..end-.LNprvInitialiseNewQueue.;
	.var = .LNxQueueGenericCreateStatic.;
	.var = .LN.xQueueGenericCreateStatic..end-.LNxQueueGenericCreateStatic.;
	.var = .LNxQueueGenericCreate.;
	.var = .LN.xQueueGenericCreate..end-.LNxQueueGenericCreate.;
	.var = .LNxQueueCreateCountingSemaphoreStatic.;
	.var = .LN.xQueueCreateCountingSemaphoreStatic..end-.LNxQueueCreateCountingSemaphoreStatic.;
	.var = .LNxQueueCreateCountingSemaphore.;
	.var = .LN.xQueueCreateCountingSemaphore..end-.LNxQueueCreateCountingSemaphore.;
	.var = .LNxQueueReceiveFromISR.;
	.var = .LN.xQueueReceiveFromISR..end-.LNxQueueReceiveFromISR.;
	.var = .LNxQueuePeekFromISR.;
	.var = .LN.xQueuePeekFromISR..end-.LNxQueuePeekFromISR.;
	.var = .LNuxQueueMessagesWaiting.;
	.var = .LN.uxQueueMessagesWaiting..end-.LNuxQueueMessagesWaiting.;
	.var = .LNuxQueueSpacesAvailable.;
	.var = .LN.uxQueueSpacesAvailable..end-.LNuxQueueSpacesAvailable.;
	.var = .LNuxQueueMessagesWaitingFromISR.;
	.var = .LN.uxQueueMessagesWaitingFromISR..end-.LNuxQueueMessagesWaitingFromISR.;
	.var = .LNprvCopyDataToQueue.;
	.var = .LN.prvCopyDataToQueue..end-.LNprvCopyDataToQueue.;
	.var = .LNprvIsQueueEmpty.;
	.var = .LN.prvIsQueueEmpty..end-.LNprvIsQueueEmpty.;
	.var = .LNxQueueIsQueueEmptyFromISR.;
	.var = .LN.xQueueIsQueueEmptyFromISR..end-.LNxQueueIsQueueEmptyFromISR.;
	.var = .LNprvIsQueueFull.;
	.var = .LN.prvIsQueueFull..end-.LNprvIsQueueFull.;
	.var = .LNxQueueIsQueueFullFromISR.;
	.var = .LN.xQueueIsQueueFullFromISR..end-.LNxQueueIsQueueFullFromISR.;
	.var = .LNvQueueAddToRegistry.;
	.var = .LN.vQueueAddToRegistry..end-.LNvQueueAddToRegistry.;
	.var = .LNpcQueueGetName.;
	.var = .LN.pcQueueGetName..end-.LNpcQueueGetName.;
	.var = .LNvQueueUnregisterQueue.;
	.var = .LN.vQueueUnregisterQueue..end-.LNvQueueUnregisterQueue.;
	.var = .LNvQueueDelete.;
	.var = .LN.vQueueDelete..end-.LNvQueueDelete.;
	.var = .LNxQueueCreateSet.;
	.var = .LN.xQueueCreateSet..end-.LNxQueueCreateSet.;
	.var = .LNxQueueAddToSet.;
	.var = .LN.xQueueAddToSet..end-.LNxQueueAddToSet.;
	.var = .LNxQueueRemoveFromSet.;
	.var = .LN.xQueueRemoveFromSet..end-.LNxQueueRemoveFromSet.;
	.var = .LNxQueueSelectFromSetFromISR.;
	.var = .LN.xQueueSelectFromSetFromISR..end-.LNxQueueSelectFromSetFromISR.;
	.var = .LNprvNotifyQueueSetContainer.;
	.var = .LN.prvNotifyQueueSetContainer..end-.LNprvNotifyQueueSetContainer.;
	.var = .LNxQueueGiveFromISR.;
	.var = .LN.xQueueGiveFromISR..end-.LNxQueueGiveFromISR.;
	.var = .LNxQueueGenericSendFromISR.;
	.var = .LN.xQueueGenericSendFromISR..end-.LNxQueueGenericSendFromISR.;
	.var = .LNprvUnlockQueue.;
	.var = .LN.prvUnlockQueue..end-.LNprvUnlockQueue.;
	.var = .LNxQueueReceive.;
	.var = .LN.xQueueReceive..end-.LNxQueueReceive.;
	.var = .LNxQueueSelectFromSet.;
	.var = .LN.xQueueSelectFromSet..end-.LNxQueueSelectFromSet.;
	.var = .LNxQueueSemaphoreTake.;
	.var = .LN.xQueueSemaphoreTake..end-.LNxQueueSemaphoreTake.;
	.var = .LNxQueueTakeMutexRecursive.;
	.var = .LN.xQueueTakeMutexRecursive..end-.LNxQueueTakeMutexRecursive.;
	.var = .LNxQueuePeek.;
	.var = .LN.xQueuePeek..end-.LNxQueuePeek.;
	.var = .LNvQueueWaitForMessageRestricted.;
	.var = .LN.vQueueWaitForMessageRestricted..end-.LNvQueueWaitForMessageRestricted.;
	.var = .LNxQueueGenericSend.;
	.var = .LN.xQueueGenericSend..end-.LNxQueueGenericSend.;
	.var = .LNprvInitialiseMutex.;
	.var = .LN.prvInitialiseMutex..end-.LNprvInitialiseMutex.;
	.var = .LNxQueueCreateMutex.;
	.var = .LN.xQueueCreateMutex..end-.LNxQueueCreateMutex.;
	.var = .LNxQueueCreateMutexStatic.;
	.var = .LN.xQueueCreateMutexStatic..end-.LNxQueueCreateMutexStatic.;
	.var = .LNxQueueGiveMutexRecursive.;
	.var = .LN.xQueueGiveMutexRecursive..end-.LNxQueueGiveMutexRecursive.;
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
		0x71,0x75,0x65,0x75,0x65,0x2E,0x63,0x00;

	.align 8;
	.byte xQueueRegistry.[64];
	.weak xQueueRegistry.;

	.extern _adi_OSRescheduleIntID.;
	.type _adi_OSRescheduleIntID.,STT_OBJECT;
	.extern _adi_OSWaitingForSched.;
	.type _adi_OSWaitingForSched.,STT_OBJECT;
