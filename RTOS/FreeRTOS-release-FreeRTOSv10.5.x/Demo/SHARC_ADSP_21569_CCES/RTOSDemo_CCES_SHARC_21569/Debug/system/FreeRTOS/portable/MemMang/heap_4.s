	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c";
//  Compilation time: Thu Oct 24 14:39:54 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\FreeRTOS\portable\MemMang -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\FreeRTOS\portable\MemMang\heap_4.d -o system\FreeRTOS\portable\MemMang\heap_4.doj
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

prvInsertBlockIntoFreeList.:
.LNprvInsertBlockIntoFreeList.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r8,r12,i4,i12,acc}
//  Call preserved registers used: {i5}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c":443
	modify(i7,-4) (nw);
	r2=i5;
	dm(-5,i6)=r2;
	dm(-4,i6)=r4;
.LN0:
// line 449
	i12=xStart.;
	dm(-3,i6)=i12;

.P41L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c" line 449 col 5
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 13 
//   cycles (includes 6 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used   6 out of   13 ( 46.2%)
//     pm dag                          used   5 out of   13 ( 38.5%)
//     shift immediate                 used   5 out of   13 ( 38.5%)
//     multifunction alu               used   4 out of   13 ( 30.8%)
//     multifunction float multiply    used   4 out of   13 ( 30.8%)
//     multifunction integer add sub   used   4 out of   13 ( 30.8%)
//     multifunction integer multiply  used   4 out of   13 ( 30.8%)
//     multifunction mult              used   4 out of   13 ( 30.8%)
//     memory access                   used   6 out of   26 ( 23.1%)
//-------------------------------------------------------------------
	// -- 2 stalls --
	i4=dm(-3,i6);
	// -- 4 stalls --
	r2=dm(i4,m5);
	r1=dm(-4,i6);
	compu(r1,r2);
	if le jump (pc,.P41L3);

.LN1:
	dm(-3,i6)=r2;
	jump (pc,.P41L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P41L3:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN2:
// line 456
	r8=dm(-3,i6);
	i4=r8;
	dm(-2,i6)=r8;
.LN3:
// line 458
	r12=dm(m6,i4);
	r1=r8+r12;
	r2=dm(-4,i6);
	comp(r1,r2);
	if ne jump (pc,.P41L5);

	i5=r2;
.LN4:
// line 460
	r12=dm(m6,i5);
	r8=dm(m6,i4);
	r2=r8+r12;
	dm(m6,i4)=r2;
.LN5:
// line 461
	r2=dm(-3,i6);
	dm(-4,i6)=r2;
.LN6:
// line 462
	jump (pc,.P41L6);

.P41L5:

.P41L6:
.LN7:
// line 470
	r8=dm(-4,i6);
	i4=r8;
	dm(-2,i6)=r8;
.LN8:
// line 472
	r12=dm(m6,i4);
	r1=r8+r12;
	i5=dm(-3,i6);
	r2=dm(i5,m5);
	comp(r1,r2);
	if ne jump (pc,.P41L8);

.LN9:
// line 474
	r1=dm(pxEnd.);
	comp(r2,r1);
	if eq jump (pc,.P41L11);

	i5=r2;
.LN10:
// line 477
	r12=dm(m6,i5);
	r8=dm(m6,i4);
	r2=r8+r12;
	dm(m6,i4)=r2;
.LN11:
// line 478
	i4=dm(-3,i6);
	i4=dm(m5,i4);
	r2=dm(i4,m5);
	i4=dm(-4,i6);
	dm(i4,m5)=r2;
.LN12:
// line 479
	jump (pc,.P41L12);

.P41L11:
.LN13:
// line 482
	dm(i4,m5)=r1;

.P41L12:
.LN14:
// line 484
	jump (pc,.P41L9);

.P41L8:
.LN15:
// line 487
	dm(i4,m5)=r2;

.P41L9:
.LN16:
// line 494
	r2=dm(-3,i6);
	r1=dm(-4,i6);
	comp(r2,r1);
	if eq jump (pc,.P41L14);

	i4=r2;
.LN17:
// line 496
	dm(i4,m5)=r1;
.LN18:
// line 497
	jump (pc,.P41L15);

.P41L14:

.P41L15:
.LN19:
// line 502
	i5=dm(-5,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvInsertBlockIntoFreeList..end:
.prvInsertBlockIntoFreeList..end:
	.type prvInsertBlockIntoFreeList.,STT_FUNC;

prvHeapInit.:
.LNprvHeapInit.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r2,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c":398
	modify(i7,-4) (nw);
.LN20:
// line 402
	i12=51200;
	dm(-2,i6)=i12;
.LN21:
// line 405
	i12=ucHeap.;
	dm(-3,i6)=i12;


.LN22:
// line 414
	r8=dm(-3,i6);
	dm(-4,i6)=r8;
.LN23:
// line 418
	dm(xStart.)=r8;
.LN24:
// line 419
	dm(xStart.+4)=m5;
.LN25:
// line 423
	r12=dm(-2,i6);
	r8=r8+r12;
	dm(-3,i6)=r8;
.LN26:
// line 424
	r12=-8;
	r2=r8+r12;
	dm(-3,i6)=r2;
.LN27:
// line 425
	r2=r2 and r12;
	dm(-3,i6)=r2;
	i4=r2;
.LN28:
// line 426
	dm(pxEnd.)=r2;
.LN29:
// line 427
	dm(m6,i4)=m13;
.LN30:
// line 428
	i4=dm(pxEnd.);
	dm(m5,i4)=m13;
.LN31:
// line 432
	r12=dm(-4,i6);
	i4=r12;
	dm(-5,i6)=r12;
.LN32:
// line 433
	r8=dm(-3,i6);
	r2=r8-r12;
	dm(m6,i4)=r2;
.LN33:
// line 434
	r2=dm(pxEnd.);
	i4=dm(-5,i6);
	dm(i4,m5)=r2;
.LN34:
// line 437
	i4=dm(-5,i6);
	r2=dm(m6,i4);
	dm(xMinimumEverFreeBytesRemaining.)=r2;
.LN35:
// line 438
	r2=dm(m6,i4);
	dm(xFreeBytesRemaining.)=r2;
.LN36:
// line 439
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvHeapInit..end:
.prvHeapInit..end:
	.type prvHeapInit.,STT_FUNC;

vPortInitialiseBlocks.:
.LNvPortInitialiseBlocks.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
.LN37:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c":375
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vPortInitialiseBlocks..end:
.vPortInitialiseBlocks..end:
	.global vPortInitialiseBlocks.;
	.type vPortInitialiseBlocks.,STT_FUNC;

xPortGetMinimumEverFreeHeapSize.:
.LNxPortGetMinimumEverFreeHeapSize.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
.LN38:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c":368
	r0=dm(xMinimumEverFreeBytesRemaining.);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xPortGetMinimumEverFreeHeapSize..end:
.xPortGetMinimumEverFreeHeapSize..end:
	.global xPortGetMinimumEverFreeHeapSize.;
	.type xPortGetMinimumEverFreeHeapSize.,STT_FUNC;

xPortGetFreeHeapSize.:
.LNxPortGetFreeHeapSize.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
.LN39:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c":362
	r0=dm(xFreeBytesRemaining.);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xPortGetFreeHeapSize..end:
.xPortGetFreeHeapSize..end:
	.global xPortGetFreeHeapSize.;
	.type xPortGetFreeHeapSize.,STT_FUNC;

pvPortMalloc.:
.LNpvPortMalloc.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,scc}
//  Call preserved registers used: {r15,i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c":158
	modify(i7,-8) (nw);
	dm(-9,i6)=r15;
	r2=i5;
	dm(-8,i6)=r2;
	dm(-7,i6)=r4;
.LN40:
// line 162
	dm(-3,i6)=m13;
.LN41:
// line 165
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
.LN42:
// line 169
	r2=dm(pxEnd.);
	r2=pass r2;
	if ne jump (pc,.P47L2);

.LN43:
// line 171
	cjump prvHeapInit. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN44:
// line 172
	jump (pc,.P47L3);

.P47L2:

.P47L3:
.LN45:
// line 178
	r2=dm(-7,i6);
	r2=pass r2;
	if eq jump (pc,.P47L5);

.LN46:
// line 183
	r12=fext r2 by 0:3;
	r8=16;
	r12=r8-r12;
	dm(-2,i6)=r12;
.LN47:
// line 185
	r8=m7;
	r1=r8-r12;
	compu(r1,r2);
	if lt jump (pc,.P47L8);

.LN48:
// line 187
	r8=dm(-2,i6);
	r12=dm(-7,i6);
	r2=r8+r12;
	dm(-7,i6)=r2;
.LN49:
// line 188
	jump (pc,.P47L9);

.P47L8:
.LN50:
// line 191
	dm(-7,i6)=m13;

.P47L9:
.LN51:
// line 193
	jump (pc,.P47L6);

.P47L5:

.P47L6:
.LN52:
// line 203
	r2=dm(-7,i6);
	r15=31;
	btst r2 by r15;
	if not sz jump (pc,.P47L11);

	r2=pass r2;
.LN53:
// line 205
	if eq jump (pc,.P47L14);

	r1=dm(xFreeBytesRemaining.);
	compu(r1,r2);
	if lt jump (pc,.P47L14);

.LN54:
// line 209
	i12=xStart.;
	dm(-5,i6)=i12;
.LN55:
// line 210
	r2=dm(xStart.);
	dm(-6,i6)=r2;

.P47L17:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c" line 212 col 17
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 19 
//   cycles (includes 6 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used  11 out of   19 ( 57.9%)
//     pm dag                          used   9 out of   19 ( 47.4%)
//     shift immediate                 used   9 out of   19 ( 47.4%)
//     multifunction alu               used   6 out of   19 ( 31.6%)
//     multifunction float multiply    used   6 out of   19 ( 31.6%)
//     multifunction integer add sub   used   6 out of   19 ( 31.6%)
//     multifunction integer multiply  used   6 out of   19 ( 31.6%)
//     multifunction mult              used   6 out of   19 ( 31.6%)
//     memory access                   used  11 out of   38 ( 28.9%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN56:
// line 212
	i4=dm(-6,i6);
	// -- 4 stalls --
	r2=dm(m6,i4);
	r1=dm(-7,i6);
	compu(r1,r2);
	if le jump (pc,.P47L18);

	r2=dm(i4,m5);
	r2=pass r2;
	if eq jump (pc,.P47L18);

.LN57:
// line 214
	r2=dm(-6,i6);
	dm(-5,i6)=r2;
.LN58:
// line 215
	r2=dm(i4,m5);
	dm(-6,i6)=r2;
	jump (pc,.P47L17);
//-------------------------------------------------------------------
//   End Loop L17
//-------------------------------------------------------------------

.P47L18:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN59:
// line 220
	r2=dm(-6,i6);
	r1=dm(pxEnd.);
	comp(r2,r1);
	if eq jump (pc,.P47L22);

.LN60:
// line 224
	i5=dm(-5,i6);
	i12=dm(m5,i5);
	i12=modify(i12,8);
	dm(-3,i6)=i12;
	i4=r2;
.LN61:
// line 228
	r2=dm(i4,m5);
	dm(i5,m5)=r2;
.LN62:
// line 232
	i4=dm(-6,i6);
	r8=dm(m6,i4);
	r12=dm(-7,i6);
	r2=r8-r12;
	r1=16;
	compu(r2,r1);
	if le jump (pc,.P47L25);

.LN63:
// line 238
	r8=dm(-6,i6);
	r2=r8+r12;
	dm(-4,i6)=r2;
.LN64:
// line 239
	r2=fext r2 by 0:3;
	r2=pass r2;
	if eq jump (pc,.P47L28);

.LN65:
	r8=239;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
.LN66:
	jump (pc,.P47L29);

.P47L28:

.P47L29:
.LN67:
// line 243
	i4=dm(-6,i6);
	r8=dm(m6,i4);
	r12=dm(-7,i6);
	r2=r8-r12;
	i4=dm(-4,i6);
	dm(m6,i4)=r2;
.LN68:
// line 244
	r2=dm(-7,i6);
	i4=dm(-6,i6);
	dm(m6,i4)=r2;
.LN69:
// line 247
	r4=dm(-4,i6);
.LN70:
	cjump prvInsertBlockIntoFreeList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
.LN71:
// line 248
	jump (pc,.P47L26);

.P47L25:

.P47L26:
.LN72:
// line 254
	i4=dm(-6,i6);
	r12=dm(m6,i4);
	r8=dm(xFreeBytesRemaining.);
	r2=r8-r12;
	dm(xFreeBytesRemaining.)=r2;
.LN73:
// line 256
	r1=dm(xMinimumEverFreeBytesRemaining.);
	compu(r1,r2);
	if le jump (pc,.P47L31);

.LN74:
// line 258
	dm(xMinimumEverFreeBytesRemaining.)=r2;
.LN75:
// line 259
	jump (pc,.P47L32);

.P47L31:

.P47L32:
.LN76:
// line 267
	i4=dm(-6,i6);
	r2=dm(m6,i4);
	r2=bset r2 by r15;
	dm(m6,i4)=r2;
.LN77:
// line 268
	i4=dm(-6,i6);
	dm(m5,i4)=m13;
.LN78:
// line 269
	r2=dm(xNumberOfSuccessfulAllocations.);
	r2=r2+1;
	dm(xNumberOfSuccessfulAllocations.)=r2;
.LN79:
// line 270
	jump (pc,.P47L23);

.P47L22:

.P47L23:
.LN80:
// line 275
	jump (pc,.P47L15);

.P47L14:

.P47L15:
.LN81:
// line 280
	jump (pc,.P47L12);

.P47L11:

.P47L12:
.LN82:
// line 288
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
.LN83:
// line 303
	r2=dm(-3,i6);
	r2=fext r2 by 0:3;
	r2=pass r2;
	if eq jump (pc,.P47L34);

.LN84:
	r8=303;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
.LN85:
	jump (pc,.P47L35);

.P47L34:

.P47L35:
.LN86:
// line 304
	r0=dm(-3,i6);
	i5=dm(-8,i6);
	r15=dm(-9,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.pvPortMalloc..end:
.pvPortMalloc..end:
	.global pvPortMalloc.;
	.type pvPortMalloc.,STT_FUNC;

vPortFree.:
.LNvPortFree.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c":309
	modify(i7,-4) (nw);
	dm(-5,i6)=r15;
	dm(-4,i6)=r4;
.LN87:
// line 310
	dm(-3,i6)=r4;
	r2=pass r4;
.LN88:
// line 313
	if eq jump (pc,.P51L2);

	i12=r4;
.LN89:
// line 317
	i12=modify(i12,-8);
	i4=i12;
	dm(-3,i6)=i12;
.LN90:
// line 320
	dm(-2,i6)=i12;
.LN91:
// line 322
	r2=dm(m6,i4);
	r15=31;
	btst r2 by r15;
	if not sz jump (pc,.P51L5);

.LN92:
	r8=322;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
.LN93:
	jump (pc,.P51L6);

.P51L5:

.P51L6:
.LN94:
// line 323
	i4=dm(-2,i6);
	r2=dm(i4,m5);
	r2=pass r2;
	if eq jump (pc,.P51L8);

.LN95:
	r8=323;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
.LN96:
	jump (pc,.P51L9);

.P51L8:

.P51L9:
.LN97:
// line 325
	i4=dm(-2,i6);
	r2=dm(m6,i4);
	btst r2 by r15;
	if sz jump (pc,.P51L11);

.LN98:
// line 327
	r1=dm(i4,m5);
	r1=pass r1;
	if ne jump (pc,.P51L14);

.LN99:
// line 331
	r2=fext r2 by 0:31;
	dm(m6,i4)=r2;
.LN100:
// line 337
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
.LN101:
// line 340
	r4=dm(-2,i6);
	i4=r4;
	r8=dm(m6,i4);
	r12=dm(xFreeBytesRemaining.);
	r2=r8+r12;
	dm(xFreeBytesRemaining.)=r2;
.LN102:
// line 342
	cjump prvInsertBlockIntoFreeList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ9-1;
.LCJ9:
.LN103:
// line 343
	r2=dm(xNumberOfSuccessfulFrees.);
	r2=r2+1;
	dm(xNumberOfSuccessfulFrees.)=r2;
.LN104:
// line 345
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ10-1;
.LCJ10:
.LN105:
// line 346
	jump (pc,.P51L15);

.P51L14:

.P51L15:
.LN106:
// line 351
	jump (pc,.P51L12);

.P51L11:

.P51L12:
.LN107:
// line 356
	jump (pc,.P51L3);

.P51L2:

.P51L3:
.LN108:
// line 357
	r15=dm(-5,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vPortFree..end:
.vPortFree..end:
	.global vPortFree.;
	.type vPortFree.,STT_FUNC;

pvPortCalloc.:
.LNpvPortCalloc.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i12,acc,mcc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c":380
	modify(i7,-6) (nw);
	dm(-6,i6)=r15;
	r15=r8;
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
.LN109:
// line 381
	dm(-3,i6)=m13;
.LN110:
// line 383
	r2=pass r4;
	if ne jump (pc,.P52L5);

.P52L4:
	dm(-2,i6)=m13;
	jump (pc,.P52L7);

.P52L5:
	r4=m7;
	r8=r2;
	cjump __divrem_u32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ11-1;// division is implemented as a library call. There is 1 more instruction related to this call. 
.LCJ11:
	compu(r15,r0);
	if le jump (pc,.P52L4);

	dm(-2,i6)=m14;

.P52L7:
	r2=dm(-2,i6);
	r2=pass r2;
	if ne jump (pc,.P52L2);

.LN111:
// line 385
	r2=dm(-5,i6);
	r1=dm(-4,i6);
	r4=r2*r1 (ssi);
.LN112:
	cjump pvPortMalloc. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ12-1;
.LCJ12:
	r4=r0;
.LN113:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN114:
// line 387
	if eq jump (pc,.P52L9);

.LN115:
// line 389
	r2=dm(-5,i6);
	r1=dm(-4,i6);
	r12=r2*r1 (ssi);
.LN116:
	r8=m5;
	cjump __simd_memsetD. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ13-1;
.LCJ13:
.LN117:
// line 390
	jump (pc,.P52L10);

.P52L9:

.P52L10:
.LN118:
// line 391
	jump (pc,.P52L3);

.P52L2:

.P52L3:
.LN119:
// line 393
	r0=dm(-3,i6);
	r15=dm(-6,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.pvPortCalloc..end:
.pvPortCalloc..end:
	.global pvPortCalloc.;
	.type pvPortCalloc.,STT_FUNC;

vPortGetHeapStats.:
.LNvPortGetHeapStats.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c":506
	modify(i7,-6) (nw);
	dm(-6,i6)=r4;
.LN120:
// line 508
	dm(-4,i6)=m13;
.LN121:
	dm(-3,i6)=m13;
.LN122:
	dm(-2,i6)=m15;
.LN123:
// line 510
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ14-1;
.LCJ14:
.LN124:
// line 512
	r2=dm(xStart.);
	dm(-5,i6)=r2;
	r2=pass r2;
.LN125:
// line 516
	if eq jump (pc,.P55L2);


.P55L4:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\MemMang\heap_4.c" line 518 col 13
//-------------------------------------------------------------------
.LN126:
// line 518
	r2=dm(-5,i6);
	r1=dm(pxEnd.);
	comp(r2,r1);
	if eq jump (pc,.P55L5);

.LN127:
// line 522
	r1=dm(-4,i6);
	r1=r1+1;
	dm(-4,i6)=r1;
	i4=r2;
.LN128:
// line 524
	r2=dm(m6,i4);
	r1=dm(-3,i6);
	compu(r2,r1);
	if le jump (pc,.P55L8);

.LN129:
// line 526
	dm(-3,i6)=r2;
.LN130:
// line 527
	jump (pc,.P55L9);

.P55L8:

.P55L9:
.LN131:
// line 529
	i4=dm(-5,i6);
	r2=dm(m6,i4);
	r1=dm(-2,i6);
	compu(r1,r2);
	if le jump (pc,.P55L11);

.LN132:
// line 531
	dm(-2,i6)=r2;
.LN133:
// line 532
	jump (pc,.P55L12);

.P55L11:

.P55L12:
.LN134:
// line 536
	i4=dm(-5,i6);
	r2=dm(i4,m5);
	dm(-5,i6)=r2;
	jump (pc,.P55L4);
//-------------------------------------------------------------------
//   End Loop L4
//-------------------------------------------------------------------

.P55L5:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN135:
// line 538
	jump (pc,.P55L3);

.P55L2:

.P55L3:
.LN136:
// line 540
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ15-1;
.LCJ15:
.LN137:
// line 542
	r2=dm(-3,i6);
	i4=dm(-6,i6);
	dm(m6,i4)=r2;
.LN138:
// line 543
	r2=dm(-2,i6);
	i4=dm(-6,i6);
	dm(2,i4)=r2;
.LN139:
// line 544
	r2=dm(-4,i6);
	i4=dm(-6,i6);
	dm(3,i4)=r2;
.LN140:
// line 546
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ16-1;
.LCJ16:
.LN141:
// line 548
	r2=dm(xFreeBytesRemaining.);
	i4=dm(-6,i6);
	dm(i4,m5)=r2;
.LN142:
// line 549
	r2=dm(xNumberOfSuccessfulAllocations.);
	i4=dm(-6,i6);
	dm(5,i4)=r2;
.LN143:
// line 550
	r2=dm(xNumberOfSuccessfulFrees.);
	i4=dm(-6,i6);
	dm(6,i4)=r2;
.LN144:
// line 551
	r2=dm(xMinimumEverFreeBytesRemaining.);
	i4=dm(-6,i6);
	dm(4,i4)=r2;
.LN145:
// line 553
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ17-1;
.LCJ17:
.LN146:
// line 554
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vPortGetHeapStats..end:
.vPortGetHeapStats..end:
	.global vPortGetHeapStats.;
	.type vPortGetHeapStats.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="prvInsertBlockIntoFreeList.";
	.file_attr FuncName="prvHeapInit.";
	.file_attr FuncName="vPortInitialiseBlocks.";
	.file_attr FuncName="xPortGetMinimumEverFreeHeapSize.";
	.file_attr FuncName="xPortGetFreeHeapSize.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr FuncName="pvPortMalloc.";
	.file_attr FuncName="vPortFree.";
	.file_attr FuncName="pvPortCalloc.";
	.file_attr FuncName="vPortGetHeapStats.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern vTaskSuspendAll.;
	.type vTaskSuspendAll.,STT_FUNC;
	.extern vAssertCalled.;
	.type vAssertCalled.,STT_FUNC;
	.extern xTaskResumeAll.;
	.type xTaskResumeAll.,STT_FUNC;
	.extern __divrem_u32.;
	.type __divrem_u32.,STT_FUNC;
	.extern __simd_memsetD.;
	.type __simd_memsetD.,STT_FUNC;
	.extern vPortEnterCritical.;
	.type vPortEnterCritical.,STT_FUNC;
	.extern vPortExitCritical.;
	.type vPortExitCritical.,STT_FUNC;

	.section/DOUBLE32 seg_dmda;

	.align 8;
	.type .epcbss,STT_OBJECT;
.epcbss:
	.byte ucHeap.[51200];
	.type ucHeap.,STT_OBJECT;
	.byte xStart.[8];
	.type xStart.,STT_OBJECT;
.epcbss.end:

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\FreeRTOS\portable\MemMang\heap_4.sbn", 0, 309;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x07,0x21,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x70,0x6F,0x72,0x74,0x61,0x62,0x6C,0x65,0x5C,0x4D,
		0x65,0x6D,0x4D,0x61,0x6E,0x67,0x5C,0x68,0x65,0x61,0x70,0x5F,
		0x34,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\FreeRTOS\portable\MemMang\heap_4.sbn", 309, 7061;
	.var = .LNprvInsertBlockIntoFreeList.;
	.var = .LN.prvInsertBlockIntoFreeList..end;
	.byte =
		0x01,0x00,0x00,0x14,0x70,0x78,0x42,0x6C,0x6F,0x63,0x6B,0x54,
		0x6F,0x49,0x6E,0x73,0x65,0x72,0x74,0x00,0x4E,0x1C,0x00,0x00,
		0x02,0x86,0x70,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.prvInsertBlockIntoFreeList..end;
	.byte =
		0x16,0x70,0x78,0x49,0x74,0x65,0x72,0x61,0x74,0x6F,0x72,0x00,
		0x01,0x4E,0x1C,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,
		0x00,0x16,0x70,0x75,0x63,0x00,0x01,0xB0,0x0E,0x00,0x00,0x02,
		0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x0A,0x00,0xBD,
		0x1B,0x00,0x00,0x13,0xF1,0x1C,0x00,0x00,0x70,0x72,0x76,0x48,
		0x65,0x61,0x70,0x49,0x6E,0x69,0x74,0x00,0x01;
	.var = .LNprvHeapInit.;
	.var = .LN.prvHeapInit..end;
	.byte =
		0x01,0x00,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN20;
	.var = .LN.prvHeapInit..end;
	.byte =
		0x16,0x70,0x78,0x46,0x69,0x72,0x73,0x74,0x46,0x72,0x65,0x65,
		0x42,0x6C,0x6F,0x63,0x6B,0x00,0x01,0x4E,0x1C,0x00,0x00,0x02,
		0x86,0x6C,0x00,0x00,0x00,0x00,0x00,0x16,0x70,0x75,0x63,0x41,
		0x6C,0x69,0x67,0x6E,0x65,0x64,0x48,0x65,0x61,0x70,0x00,0x01,
		0xB0,0x0E,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,
		0x16,0x75,0x78,0x41,0x64,0x64,0x72,0x65,0x73,0x73,0x00,0x01,
		0xB6,0x07,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,
		0x16,0x78,0x54,0x6F,0x74,0x61,0x6C,0x48,0x65,0x61,0x70,0x53,
		0x69,0x7A,0x65,0x00,0x01,0xE1,0x03,0x00,0x00,0x02,0x86,0x78;
	.var = .LN20-.LNprvHeapInit.;
	.byte =
		0x00,0x00,0x00,0x13,0x27,0x1D,0x00,0x00,0x76,0x50,0x6F,0x72,
		0x74,0x49,0x6E,0x69,0x74,0x69,0x61,0x6C,0x69,0x73,0x65,0x42,
		0x6C,0x6F,0x63,0x6B,0x73,0x00,0x01;
	.var = .LNvPortInitialiseBlocks.;
	.var = .LN.vPortInitialiseBlocks..end;
	.byte =
		0x01,0x01,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN37;
	.var = .LN.vPortInitialiseBlocks..end;
	.byte =
		0x00,0x00,0x17,0x6B,0x1D,0x00,0x00,0x78,0x50,0x6F,0x72,0x74,
		0x47,0x65,0x74,0x4D,0x69,0x6E,0x69,0x6D,0x75,0x6D,0x45,0x76,
		0x65,0x72,0x46,0x72,0x65,0x65,0x48,0x65,0x61,0x70,0x53,0x69,
		0x7A,0x65,0x00,0x01;
	.var = .LNxPortGetMinimumEverFreeHeapSize.;
	.var = .LN.xPortGetMinimumEverFreeHeapSize..end;
	.byte =
		0x01,0xE1,0x03,0x00,0x00,0x01,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN38;
	.var = .LN.xPortGetMinimumEverFreeHeapSize..end;
	.byte =
		0x00,0x00,0x17,0xA4,0x1D,0x00,0x00,0x78,0x50,0x6F,0x72,0x74,
		0x47,0x65,0x74,0x46,0x72,0x65,0x65,0x48,0x65,0x61,0x70,0x53,
		0x69,0x7A,0x65,0x00,0x01;
	.var = .LNxPortGetFreeHeapSize.;
	.var = .LN.xPortGetFreeHeapSize..end;
	.byte =
		0x01,0xE1,0x03,0x00,0x00,0x01,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN39;
	.var = .LN.xPortGetFreeHeapSize..end;
	.byte =
		0x00,0x00,0x17,0x78,0x1E,0x00,0x00,0x70,0x76,0x50,0x6F,0x72,
		0x74,0x4D,0x61,0x6C,0x6C,0x6F,0x63,0x00,0x01;
	.var = .LNpvPortMalloc.;
	.var = .LN.pvPortMalloc..end;
	.byte =
		0x01,0xD6,0x03,0x00,0x00,0x01,0x00,0x14,0x78,0x57,0x61,0x6E,
		0x74,0x65,0x64,0x53,0x69,0x7A,0x65,0x00,0xE1,0x03,0x00,0x00,
		0x02,0x86,0x64,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN40;
	.var = .LN.pvPortMalloc..end;
	.byte =
		0x16,0x70,0x78,0x42,0x6C,0x6F,0x63,0x6B,0x00,0x01,0x4E,0x1C,
		0x00,0x00,0x02,0x86,0x68,0x00,0x00,0x00,0x00,0x00,0x16,0x70,
		0x78,0x50,0x72,0x65,0x76,0x69,0x6F,0x75,0x73,0x42,0x6C,0x6F,
		0x63,0x6B,0x00,0x01,0x4E,0x1C,0x00,0x00,0x02,0x86,0x6C,0x00,
		0x00,0x00,0x00,0x00,0x16,0x70,0x78,0x4E,0x65,0x77,0x42,0x6C,
		0x6F,0x63,0x6B,0x4C,0x69,0x6E,0x6B,0x00,0x01,0x4E,0x1C,0x00,
		0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x16,0x70,0x76,
		0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0xD6,0x03,0x00,0x00,
		0x02,0x86,0x74;
	.var = .LN40-.LNpvPortMalloc.;
	.byte =
		0x00,0x16,0x78,0x41,0x64,0x64,0x69,0x74,0x69,0x6F,0x6E,0x61,
		0x6C,0x52,0x65,0x71,0x75,0x69,0x72,0x65,0x64,0x53,0x69,0x7A,
		0x65,0x00,0x01,0xE1,0x03,0x00,0x00,0x02,0x86,0x78;
	.var = .LN40-.LNpvPortMalloc.;
	.byte =
		0x00,0x00,0x00,0x13,0xD5,0x1E,0x00,0x00,0x76,0x50,0x6F,0x72,
		0x74,0x46,0x72,0x65,0x65,0x00,0x01;
	.var = .LNvPortFree.;
	.var = .LN.vPortFree..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x76,0x00,0xD6,0x03,0x00,0x00,0x02,
		0x86,0x70,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN87;
	.var = .LN.vPortFree..end;
	.byte =
		0x16,0x70,0x75,0x63,0x00,0x01,0xB0,0x0E,0x00,0x00,0x02,0x86,
		0x74,0x00,0x00,0x00,0x00,0x00,0x16,0x70,0x78,0x4C,0x69,0x6E,
		0x6B,0x00,0x01,0x4E,0x1C,0x00,0x00,0x02,0x86,0x78;
	.var = .LN87-.LNvPortFree.;
	.byte =
		0x00,0x00,0x00,0x17,0x34,0x1F,0x00,0x00,0x70,0x76,0x50,0x6F,
		0x72,0x74,0x43,0x61,0x6C,0x6C,0x6F,0x63,0x00,0x01;
	.var = .LNpvPortCalloc.;
	.var = .LN.pvPortCalloc..end;
	.byte =
		0x01,0xD6,0x03,0x00,0x00,0x01,0x00,0x14,0x78,0x4E,0x75,0x6D,
		0x00,0xE1,0x03,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x78,0x53,
		0x69,0x7A,0x65,0x00,0xE1,0x03,0x00,0x00,0x02,0x86,0x70,0x00,
		0x15,0x00,0x00,0x00,0x00;
	.var = .LN109;
	.var = .LN.pvPortCalloc..end;
	.byte =
		0x16,0x70,0x76,0x00,0x01,0xD6,0x03,0x00,0x00,0x02,0x86,0x74;
	.var = .LN109-.LNpvPortCalloc.;
	.byte =
		0x00,0x00,0x00,0x13,0xD5,0x1F,0x00,0x00,0x76,0x50,0x6F,0x72,
		0x74,0x47,0x65,0x74,0x48,0x65,0x61,0x70,0x53,0x74,0x61,0x74,
		0x73,0x00,0x01;
	.var = .LNvPortGetHeapStats.;
	.var = .LN.vPortGetHeapStats..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x78,0x48,0x65,0x61,0x70,0x53,0x74,
		0x61,0x74,0x73,0x00,0xD5,0x1F,0x00,0x00,0x02,0x86,0x68,0x00,
		0x15,0x00,0x00,0x00,0x00;
	.var = .LN120;
	.var = .LN.vPortGetHeapStats..end;
	.byte =
		0x16,0x70,0x78,0x42,0x6C,0x6F,0x63,0x6B,0x00,0x01,0x4E,0x1C,
		0x00,0x00,0x02,0x86,0x6C,0x00,0x00,0x00,0x00,0x00,0x16,0x78,
		0x42,0x6C,0x6F,0x63,0x6B,0x73,0x00,0x01,0xE1,0x03,0x00,0x00,
		0x02,0x86,0x70;
	.var = .LN120-.LNvPortGetHeapStats.;
	.byte =
		0x00,0x16,0x78,0x4D,0x61,0x78,0x53,0x69,0x7A,0x65,0x00,0x01,
		0xE1,0x03,0x00,0x00,0x02,0x86,0x74;
	.var = .LN121-.LNvPortGetHeapStats.;
	.byte =
		0x00,0x16,0x78,0x4D,0x69,0x6E,0x53,0x69,0x7A,0x65,0x00,0x01,
		0xE1,0x03,0x00,0x00,0x02,0x86,0x78;
	.var = .LN122-.LNvPortGetHeapStats.;
	.byte =
		0x00,0x00,0x00,0x0A,0x00,0x11,0x10,0x00,0x00,0x16,0x75,0x63,
		0x48,0x65,0x61,0x70,0x00,0x01,0xF7,0x20,0x00,0x00,0x05,0x03;
	.var = ucHeap.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x78,0x48,0x65,0x61,0x70,0x53,
		0x74,0x72,0x75,0x63,0x74,0x53,0x69,0x7A,0x65,0x00,0x01,0xF2,
		0x20,0x00,0x00,0x05,0x03;
	.var = xHeapStructSize.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x78,0x53,0x74,0x61,0x72,0x74,
		0x00,0x01,0xBD,0x1B,0x00,0x00,0x05,0x03;
	.var = xStart.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x70,0x78,0x45,0x6E,0x64,0x00,
		0x01,0x4E,0x1C,0x00,0x00,0x05,0x03;
	.var = pxEnd.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x78,0x46,0x72,0x65,0x65,0x42,
		0x79,0x74,0x65,0x73,0x52,0x65,0x6D,0x61,0x69,0x6E,0x69,0x6E,
		0x67,0x00,0x01,0xE1,0x03,0x00,0x00,0x05,0x03;
	.var = xFreeBytesRemaining.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x78,0x4D,0x69,0x6E,0x69,0x6D,
		0x75,0x6D,0x45,0x76,0x65,0x72,0x46,0x72,0x65,0x65,0x42,0x79,
		0x74,0x65,0x73,0x52,0x65,0x6D,0x61,0x69,0x6E,0x69,0x6E,0x67,
		0x00,0x01,0xE1,0x03,0x00,0x00,0x05,0x03;
	.var = xMinimumEverFreeBytesRemaining.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x78,0x4E,0x75,0x6D,0x62,0x65,
		0x72,0x4F,0x66,0x53,0x75,0x63,0x63,0x65,0x73,0x73,0x66,0x75,
		0x6C,0x41,0x6C,0x6C,0x6F,0x63,0x61,0x74,0x69,0x6F,0x6E,0x73,
		0x00,0x01,0xE1,0x03,0x00,0x00,0x05,0x03;
	.var = xNumberOfSuccessfulAllocations.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x78,0x4E,0x75,0x6D,0x62,0x65,
		0x72,0x4F,0x66,0x53,0x75,0x63,0x63,0x65,0x73,0x73,0x66,0x75,
		0x6C,0x46,0x72,0x65,0x65,0x73,0x00,0x01,0xE1,0x03,0x00,0x00,
		0x05,0x03;
	.var = xNumberOfSuccessfulFrees.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x12,0xE1,0x03,0x00,0x00,0x0D,0x09,
		0x21,0x00,0x00,0x99,0x07,0x00,0x00,0x0E,0x80,0x90,0x03,0x00,
		0xFF,0x8F,0x03,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\FreeRTOS\portable\MemMang\heap_4.sbn", 7370, 2072;
	.var = .LNprvInsertBlockIntoFreeList.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xBA,0x03,0x01,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x05,0x0F,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x4F,0x01,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x11,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x01,0x0E,0x00,0x05,0x02;
	.var = .LN.prvInsertBlockIntoFreeList..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvHeapInit.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x8D,0x03,0x01,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x0C,0x0D,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x12,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x0D,0x00,0x05,0x02;
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
		0x0A,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvHeapInit..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvPortInitialiseBlocks.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xF4,0x02,0x01,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.vPortInitialiseBlocks..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxPortGetMinimumEverFreeHeapSize.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xEE,0x02,0x01,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN.xPortGetMinimumEverFreeHeapSize..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxPortGetFreeHeapSize.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xE8,0x02,0x01,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN.xPortGetFreeHeapSize..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNpvPortMalloc.;
	.byte =
		0x04,0x01,0x05,0x01,0xA6,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x05,0x0C,0x0D,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x05,0x14,0x0C,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x05,0x18,0x0B,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN46;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN47;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN48;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN49;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN50;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN51;
	.byte =
		0x05,0x08,0x0B,0x00,0x05,0x02;
	.var = .LN52;
	.byte =
		0x13,0x00,0x05,0x02;
	.var = .LN53;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN54;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN55;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN56;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN57;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN58;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN59;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN60;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN61;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN62;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN63;
	.byte =
		0x05,0x19,0x0F,0x00,0x05,0x02;
	.var = .LN64;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN65;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN66;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN67;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN68;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN69;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN70;
	.byte =
		0x05,0x33,0x01,0x00,0x05,0x02;
	.var = .LN71;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN72;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN73;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN74;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN75;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN76;
	.byte =
		0x11,0x00,0x05,0x02;
	.var = .LN77;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN78;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN79;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN80;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN81;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN82;
	.byte =
		0x05,0x1C,0x11,0x00,0x05,0x02;
	.var = .LN83;
	.byte =
		0x05,0x05,0x18,0x00,0x05,0x02;
	.var = .LN84;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN85;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN86;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN.pvPortMalloc..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvPortFree.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xB4,0x02,0x01,0x00,0x05,0x02;
	.var = .LN87;
	.byte =
		0x05,0x13,0x0A,0x00,0x05,0x02;
	.var = .LN88;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN89;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN90;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN91;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN92;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN93;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN94;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN95;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN96;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN97;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN98;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN99;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN100;
	.byte =
		0x05,0x20,0x0F,0x00,0x05,0x02;
	.var = .LN101;
	.byte =
		0x05,0x15,0x0C,0x00,0x05,0x02;
	.var = .LN102;
	.byte =
		0x05,0x2F,0x0B,0x00,0x05,0x02;
	.var = .LN103;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN104;
	.byte =
		0x05,0x28,0x0B,0x00,0x05,0x02;
	.var = .LN105;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN106;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN107;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN108;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vPortFree..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNpvPortCalloc.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xFB,0x02,0x01,0x00,0x05,0x02;
	.var = .LN109;
	.byte =
		0x05,0x0C,0x0A,0x00,0x05,0x02;
	.var = .LN110;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN111;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN112;
	.byte =
		0x05,0x1A,0x01,0x00,0x05,0x02;
	.var = .LN113;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN114;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN115;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN116;
	.byte =
		0x05,0x16,0x01,0x00,0x05,0x02;
	.var = .LN117;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN118;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN119;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.pvPortCalloc..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvPortGetHeapStats.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xF9,0x03,0x01,0x00,0x05,0x02;
	.var = .LN120;
	.byte =
		0x05,0x0C,0x0B,0x00,0x05,0x02;
	.var = .LN121;
	.byte =
		0x05,0x1A,0x01,0x00,0x05,0x02;
	.var = .LN122;
	.byte =
		0x05,0x29,0x01,0x00,0x05,0x02;
	.var = .LN123;
	.byte =
		0x05,0x14,0x0B,0x00,0x05,0x02;
	.var = .LN124;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN125;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN126;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN127;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN128;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN129;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN130;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN131;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN132;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN133;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN134;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN135;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN136;
	.byte =
		0x05,0x1C,0x0B,0x00,0x05,0x02;
	.var = .LN137;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN138;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN139;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN140;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN141;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN142;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN143;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN144;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN145;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN146;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vPortGetHeapStats..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0xAB,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.inc/binary ".\system\FreeRTOS\portable\MemMang\heap_4.sbn", 9442, 165;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x5C,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNprvInsertBlockIntoFreeList.;
	.var = .LN.prvInsertBlockIntoFreeList..end-.LNprvInsertBlockIntoFreeList.;
	.var = .LNprvHeapInit.;
	.var = .LN.prvHeapInit..end-.LNprvHeapInit.;
	.var = .LNvPortInitialiseBlocks.;
	.var = .LN.vPortInitialiseBlocks..end-.LNvPortInitialiseBlocks.;
	.var = .LNxPortGetMinimumEverFreeHeapSize.;
	.var = .LN.xPortGetMinimumEverFreeHeapSize..end-.LNxPortGetMinimumEverFreeHeapSize.;
	.var = .LNxPortGetFreeHeapSize.;
	.var = .LN.xPortGetFreeHeapSize..end-.LNxPortGetFreeHeapSize.;
	.var = .LNpvPortMalloc.;
	.var = .LN.pvPortMalloc..end-.LNpvPortMalloc.;
	.var = .LNvPortFree.;
	.var = .LN.vPortFree..end-.LNvPortFree.;
	.var = .LNpvPortCalloc.;
	.var = .LN.pvPortCalloc..end-.LNpvPortCalloc.;
	.var = .LNvPortGetHeapStats.;
	.var = .LN.vPortGetHeapStats..end-.LNvPortGetHeapStats.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type xHeapStructSize.,STT_OBJECT;
	.byte xHeapStructSize.[] =
		0x08,0x00,0x00,0x00;
	.align 4;
	.type pxEnd.,STT_OBJECT;
	.byte pxEnd.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xFreeBytesRemaining.,STT_OBJECT;
	.byte xFreeBytesRemaining.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xMinimumEverFreeBytesRemaining.,STT_OBJECT;
	.byte xMinimumEverFreeBytesRemaining.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xNumberOfSuccessfulAllocations.,STT_OBJECT;
	.byte xNumberOfSuccessfulAllocations.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xNumberOfSuccessfulFrees.,STT_OBJECT;
	.byte xNumberOfSuccessfulFrees.[] =
		0x00,0x00,0x00,0x00;
	.align 8;
	.type .sDRTOSF.0,STT_OBJECT;
	.byte .sDRTOSF.0[] =
		0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,0x65,0x65,
		0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,0x73,0x65,
		0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,0x31,0x30,
		0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,0x65,0x5C,
		0x70,0x6F,0x72,0x74,0x61,0x62,0x6C,0x65,0x5C,0x4D,0x65,0x6D,
		0x4D,0x61,0x6E,0x67,0x5C,0x68,0x65,0x61,0x70,0x5F,0x34,0x2E,
		0x63,0x00;
