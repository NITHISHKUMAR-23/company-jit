	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\recmutex.c";
//  Compilation time: Thu Oct 24 14:40:20 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\Standard_Demo -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo Standard_Demo\recmutex.d -o Standard_Demo\recmutex.doj
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

xAreRecursiveMutexTasksStillRunning.:
.LNxAreRecursiveMutexTasksStillRunning.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0-r2,i12,acc,scc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\recmutex.c":378
	modify(i7,-2) (nw);
.LN0:
// line 383
	r2=dm(uxLastControllingCycles.0.);
	r1=dm(uxControllingCycles.);
	comp(r2,r1);
	if ne jump (pc,.P45L2);

.LN1:
// line 385
	dm(xErrorOccurred.)=m6;
.LN2:
// line 386
	jump (pc,.P45L3);

.P45L2:
.LN3:
// line 389
	r2=dm(uxControllingCycles.);
	dm(uxLastControllingCycles.0.)=r2;

.P45L3:
.LN4:
// line 393
	r2=dm(uxLastBlockingCycles.1.);
	r1=dm(uxBlockingCycles.);
	comp(r2,r1);
	if ne jump (pc,.P45L5);

.LN5:
// line 395
	dm(xErrorOccurred.)=m6;
.LN6:
// line 396
	jump (pc,.P45L6);

.P45L5:
.LN7:
// line 399
	r2=dm(uxBlockingCycles.);
	dm(uxLastBlockingCycles.1.)=r2;

.P45L6:
.LN8:
// line 403
	r2=dm(uxLastPollingCycles.2.);
	r1=dm(uxPollingCycles.);
	comp(r2,r1);
	if ne jump (pc,.P45L8);

.LN9:
// line 405
	dm(xErrorOccurred.)=m6;
.LN10:
// line 406
	jump (pc,.P45L9);

.P45L8:
.LN11:
// line 409
	r2=dm(uxPollingCycles.);
	dm(uxLastPollingCycles.2.)=r2;

.P45L9:
.LN12:
// line 412
	r2=dm(xErrorOccurred.);
	r1=m5;
	r2=btgl r2 by r1;
	if not sz jump (pc,.P45L11);

.LN13:
// line 414
	dm(-2,i6)=m13;
.LN14:
// line 415
	jump (pc,.P45L12);

.P45L11:
.LN15:
// line 418
	dm(-2,i6)=m14;

.P45L12:
.LN16:
// line 421
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xAreRecursiveMutexTasksStillRunning..end:
.xAreRecursiveMutexTasksStillRunning..end:
	.global xAreRecursiveMutexTasksStillRunning.;
	.type xAreRecursiveMutexTasksStillRunning.,STT_FUNC;

vStartRecursiveMutexTasks.:
.LNvStartRecursiveMutexTasks.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN17:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\recmutex.c":124
	r4=4;
	cjump xQueueCreateMutex. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
	r4=r0;
.LN18:
	dm(xMutex.)=r0;
	r2=pass r0;
.LN19:
// line 126
	if eq jump (pc,.P50L2);

.LN20:
// line 134
	r8=.sRecurs.3;
	cjump vQueueAddToRegistry. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN21:
// line 136
	r2=xControllingTaskHandle.;
	r1=2;
	r8=.sRec1.4;
	r4=prvRecursiveMutexControllingTask.;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	dm(i7,m7)=m13;
	r12=200;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
	modify(i7,4) (nw);
.LN22:
// line 137
	r2=xBlockingTaskHandle.;
	r8=.sRec2.5;
	r4=prvRecursiveMutexBlockingTask.;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	dm(i7,m7)=m14;
	dm(i7,m7)=m13;
	r12=200;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
	modify(i7,4) (nw);
.LN23:
// line 138
	r8=.sRec3.6;
	r4=prvRecursiveMutexPollingTask.;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=m13;
	dm(i7,m7)=m13;
	r12=200;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
	modify(i7,4) (nw);
.LN24:
// line 139
	jump (pc,.P50L3);

.P50L2:

.P50L3:
.LN25:
// line 140
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vStartRecursiveMutexTasks..end:
.vStartRecursiveMutexTasks..end:
	.global vStartRecursiveMutexTasks.;
	.type vStartRecursiveMutexTasks.,STT_FUNC;

prvRecursiveMutexControllingTask.:
.LNprvRecursiveMutexControllingTask.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r2,r4,r8,acc,scc}
//  Call preserved registers used: {r14-r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\recmutex.c":144
	modify(i7,-4) (nw);
	dm(-5,i6)=r14;
	dm(-4,i6)=r15;
	dm(-3,i6)=r4;

.P53L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\recmutex.c" line 150 col 2
//-------------------------------------------------------------------
.LN26:
// line 156
	r4=dm(xMutex.);
.LN27:
	cjump xQueueGiveMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
	r15=m5;
	r2=btgl r0 by r15;
.LN28:
	if not sz jump (pc,.P53L5);

.LN29:
// line 158
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN30:
// line 159
	jump (pc,.P53L6);

.P53L5:

.P53L6:
.LN31:
// line 161
	dm(-2,i6)=m13;

.P53L7:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\recmutex.c" line 161 col 3
//-------------------------------------------------------------------
	r2=dm(-2,i6);
	r14=10;
	compu(r2,r14);
	if ge jump (pc,.P53L9);

.LN32:
// line 173
	r4=dm(xMutex.);
.LN33:
	r8=15;
	cjump xQueueTakeMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
	r2=btgl r0 by r15;
.LN34:
	if sz jump (pc,.P53L11);

.LN35:
// line 175
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN36:
// line 176
	jump (pc,.P53L12);

.P53L11:

.P53L12:
.LN37:
// line 182
	r4=20;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
.LN38:
// line 161
	r2=dm(-2,i6);
	r2=r2+1;
	dm(-2,i6)=r2;
	jump (pc,.P53L7);
//-------------------------------------------------------------------
//   End Loop L7
//-------------------------------------------------------------------

.P53L9:
//-------------------------------------------------------------------
//   Part of Loop 1, depth 1
//-------------------------------------------------------------------
.LN39:
// line 186
	dm(-2,i6)=m13;

.P53L13:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\recmutex.c" line 186 col 3
//-------------------------------------------------------------------
	r2=dm(-2,i6);
	compu(r2,r14);
	if ge jump (pc,.P53L15);

.LN40:
// line 190
	r4=20;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
.LN41:
// line 197
	r4=dm(xMutex.);
.LN42:
	cjump xQueueGiveMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ9-1;
.LCJ9:
	r2=btgl r0 by r15;
.LN43:
	if sz jump (pc,.P53L17);

.LN44:
// line 199
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN45:
// line 200
	jump (pc,.P53L18);

.P53L17:

.P53L18:
.LN46:
// line 186
	r2=dm(-2,i6);
	r2=r2+1;
	dm(-2,i6)=r2;
	jump (pc,.P53L13);
//-------------------------------------------------------------------
//   End Loop L13
//-------------------------------------------------------------------

.P53L15:
//-------------------------------------------------------------------
//   Part of Loop 1, depth 1
//-------------------------------------------------------------------
.LN47:
// line 209
	r4=dm(xMutex.);
.LN48:
	cjump xQueueGiveMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ10-1;
.LCJ10:
	r2=btgl r0 by r15;
.LN49:
	if not sz jump (pc,.P53L20);

.LN50:
// line 211
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN51:
// line 212
	jump (pc,.P53L21);

.P53L20:

.P53L21:
.LN52:
// line 216
	r2=dm(uxControllingCycles.);            // Use of volatile in loops precludes optimizations. 
	r2=r2+1;
	dm(uxControllingCycles.)=r2;            // Use of volatile in loops precludes optimizations. 
.LN53:
// line 219
	dm(xControllingIsSuspended.)=m6;        // Use of volatile in loops precludes optimizations. 
.LN54:
// line 220
	r4=m5;
	cjump vTaskSuspend. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ11-1;
.LCJ11:
.LN55:
// line 221
	dm(xControllingIsSuspended.)=m5;        // Use of volatile in loops precludes optimizations. 
	jump (pc,.P53L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.prvRecursiveMutexControllingTask..end:
.prvRecursiveMutexControllingTask..end:
	.type prvRecursiveMutexControllingTask.,STT_FUNC;

prvRecursiveMutexBlockingTask.:
.LNprvRecursiveMutexBlockingTask.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r1-r2,r4,r8,acc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\recmutex.c":227
	modify(i7,-2) (nw);
	dm(-3,i6)=r15;
	dm(-2,i6)=r4;

.P55L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\recmutex.c" line 231 col 2
//-------------------------------------------------------------------
.LN56:
// line 240
	r4=dm(xMutex.);
.LN57:
	r8=-2;
	cjump xQueueTakeMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ12-1;
.LCJ12:
	r15=m5;
	r2=btgl r0 by r15;
.LN58:
	if not sz jump (pc,.P55L5);

.LN59:
// line 242
	r2=dm(xControllingIsSuspended.);        // Use of volatile in loops precludes optimizations. 
	r2=btgl r2 by r15;
	if sz jump (pc,.P55L8);

.LN60:
// line 246
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN61:
// line 247
	jump (pc,.P55L9);

.P55L8:
.LN62:
// line 252
	r4=dm(xMutex.);
.LN63:
	cjump xQueueGiveMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ13-1;
.LCJ13:
	r2=btgl r0 by r15;
.LN64:
	if sz jump (pc,.P55L11);

.LN65:
// line 254
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN66:
// line 255
	jump (pc,.P55L12);

.P55L11:

.P55L12:
.LN67:
// line 257
	dm(xBlockingIsSuspended.)=m6;           // Use of volatile in loops precludes optimizations. 
.LN68:
// line 258
	r4=m5;
	cjump vTaskSuspend. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ14-1;
.LCJ14:
.LN69:
// line 259
	dm(xBlockingIsSuspended.)=m5;           // Use of volatile in loops precludes optimizations. 

.P55L9:
.LN70:
// line 261
	jump (pc,.P55L6);

.P55L5:
.LN71:
// line 266
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 

.P55L6:
.LN72:
// line 270
	r2=dm(uxControllingCycles.);            // Use of volatile in loops precludes optimizations. 
	r1=dm(uxBlockingCycles.);               // Use of volatile in loops precludes optimizations. 
	r1=r1+1;
	comp(r2,r1);
	if eq jump (pc,.P55L14);

.LN73:
// line 272
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN74:
// line 273
	jump (pc,.P55L15);

.P55L14:

.P55L15:
.LN75:
// line 277
	r2=dm(uxBlockingCycles.);               // Use of volatile in loops precludes optimizations. 
	r2=r2+1;
	dm(uxBlockingCycles.)=r2;               // Use of volatile in loops precludes optimizations. 
	jump (pc,.P55L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.prvRecursiveMutexBlockingTask..end:
.prvRecursiveMutexBlockingTask..end:
	.type prvRecursiveMutexBlockingTask.,STT_FUNC;

prvRecursiveMutexPollingTask.:
.LNprvRecursiveMutexPollingTask.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r2,r4,r8,acc,scc}
//  Call preserved registers used: {r14-r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\recmutex.c":283
	modify(i7,-4) (nw);
	dm(-4,i6)=r14;
	dm(-3,i6)=r15;
	dm(-2,i6)=r4;

.P56L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\recmutex.c" line 287 col 2
//-------------------------------------------------------------------
.LN76:
// line 292
	r4=dm(xMutex.);
.LN77:
	r15=m5;
	r8=m5;
	cjump xQueueTakeMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ15-1;
.LCJ15:
	r2=btgl r0 by r15;
.LN78:
	if not sz jump (pc,.P56L5);

.LN79:
// line 296
	r4=dm(xControllingTaskHandle.);
.LN80:
	cjump eTaskGetState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ16-1;
.LCJ16:
	r14=3;
	comp(r0,r14);
.LN81:
	if eq jump (pc,.P56L8);

.LN82:
	r8=296;
	r4=.sDRTOSF.7;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ17-1;
.LCJ17:
.LN83:
	jump (pc,.P56L9);

.P56L8:

.P56L9:
.LN84:
// line 297
	r4=dm(xBlockingTaskHandle.);
.LN85:
	cjump eTaskGetState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ18-1;
.LCJ18:
	comp(r0,r14);
.LN86:
	if eq jump (pc,.P56L11);

.LN87:
	r8=297;
	r4=.sDRTOSF.7;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ19-1;
.LCJ19:
.LN88:
	jump (pc,.P56L12);

.P56L11:

.P56L12:
.LN89:
// line 302
	r2=dm(xBlockingIsSuspended.);           // Use of volatile in loops precludes optimizations. 
	r2=btgl r2 by r15;
	if not sz jump (pc,.P56L13);

	r2=dm(xControllingIsSuspended.);        // Use of volatile in loops precludes optimizations. 
	r2=btgl r2 by r15;
	if sz jump (pc,.P56L14);

.P56L13:
.LN90:
// line 304
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN91:
// line 305
	jump (pc,.P56L15);

.P56L14:
.LN92:
// line 310
	r2=dm(uxPollingCycles.);                // Use of volatile in loops precludes optimizations. 
	r2=r2+1;
	dm(uxPollingCycles.)=r2;                // Use of volatile in loops precludes optimizations. 
.LN93:
// line 321
	r4=dm(xBlockingTaskHandle.);
.LN94:
	cjump vTaskResume. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ20-1;
.LCJ20:
.LN95:
// line 326
	r4=dm(xControllingTaskHandle.);
.LN96:
	cjump vTaskResume. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ21-1;
.LCJ21:
.LN97:
// line 333
	r2=dm(xBlockingIsSuspended.);           // Use of volatile in loops precludes optimizations. 
	r2=btgl r2 by r15;
	if sz jump (pc,.P56L17);

	r2=dm(xControllingIsSuspended.);        // Use of volatile in loops precludes optimizations. 
	r2=btgl r2 by r15;
	if not sz jump (pc,.P56L18);

.P56L17:
.LN98:
// line 335
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN99:
// line 336
	jump (pc,.P56L19);

.P56L18:

.P56L19:
.LN100:
// line 341
	r4=m5;
	cjump uxTaskPriorityGet. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ22-1;
.LCJ22:
	r14=m6;
	r2=btgl r0 by r14;
.LN101:
	if sz jump (pc,.P56L22);

.LN102:
	r8=341;
	r4=.sDRTOSF.7;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ23-1;
.LCJ23:
.LN103:
	jump (pc,.P56L23);

.P56L22:

.P56L23:
.LN104:
// line 347
	r4=dm(xControllingTaskHandle.);
.LN105:
	cjump eTaskGetState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ24-1;
.LCJ24:
	r2=btgl r0 by r14;
.LN106:
	if sz jump (pc,.P56L25);

.LN107:
	r8=347;
	r4=.sDRTOSF.7;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ25-1;
.LCJ25:
.LN108:
	jump (pc,.P56L26);

.P56L25:

.P56L26:
.LN109:
// line 348
	r4=dm(xBlockingTaskHandle.);
.LN110:
	cjump eTaskGetState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ26-1;
.LCJ26:
	r2=btgl r0 by r14;
.LN111:
	if sz jump (pc,.P56L28);

.LN112:
	r8=348;
	r4=.sDRTOSF.7;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ27-1;
.LCJ27:
.LN113:
	jump (pc,.P56L29);

.P56L28:

.P56L29:
.LN114:
// line 353
	r4=dm(xMutex.);
.LN115:
	cjump xQueueGiveMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ28-1;
.LCJ28:
	r2=btgl r0 by r15;
.LN116:
	if sz jump (pc,.P56L31);

.LN117:
// line 355
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN118:
// line 356
	jump (pc,.P56L32);

.P56L31:

.P56L32:
.LN119:
// line 361
	r4=m5;
	cjump uxTaskPriorityGet. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ29-1;
.LCJ29:
	r2=pass r0;
.LN120:
	if eq jump (pc,.P56L34);

.LN121:
	r8=361;
	r4=.sDRTOSF.7;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ30-1;
.LCJ30:
.LN122:
	jump (pc,.P56L35);

.P56L34:

.P56L35:

.P56L15:
.LN123:
// line 365
	jump (pc,.P56L6);

.P56L5:

.P56L6:
	jump (pc,.P56L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.prvRecursiveMutexPollingTask..end:
.prvRecursiveMutexPollingTask..end:
	.type prvRecursiveMutexPollingTask.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="xAreRecursiveMutexTasksStillRunning.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="vStartRecursiveMutexTasks.";
	.file_attr FuncName="prvRecursiveMutexControllingTask.";
	.file_attr FuncName="prvRecursiveMutexBlockingTask.";
	.file_attr FuncName="prvRecursiveMutexPollingTask.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern xQueueCreateMutex.;
	.type xQueueCreateMutex.,STT_FUNC;
	.extern vQueueAddToRegistry.;
	.type vQueueAddToRegistry.,STT_FUNC;
	.extern xTaskCreate.;
	.type xTaskCreate.,STT_FUNC;
	.extern xQueueGiveMutexRecursive.;
	.type xQueueGiveMutexRecursive.,STT_FUNC;
	.extern xQueueTakeMutexRecursive.;
	.type xQueueTakeMutexRecursive.,STT_FUNC;
	.extern vTaskDelay.;
	.type vTaskDelay.,STT_FUNC;
	.extern vTaskSuspend.;
	.type vTaskSuspend.,STT_FUNC;
	.extern eTaskGetState.;
	.type eTaskGetState.,STT_FUNC;
	.extern vAssertCalled.;
	.type vAssertCalled.,STT_FUNC;
	.extern vTaskResume.;
	.type vTaskResume.,STT_FUNC;
	.extern uxTaskPriorityGet.;
	.type uxTaskPriorityGet.,STT_FUNC;

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type .epcbss,STT_OBJECT;
.epcbss:
	.byte xMutex.[4];
	.type xMutex.,STT_OBJECT;
	.byte xControllingTaskHandle.[4];
	.type xControllingTaskHandle.,STT_OBJECT;
	.byte xBlockingTaskHandle.[4];
	.type xBlockingTaskHandle.,STT_OBJECT;
.epcbss.end:

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\Standard_Demo\recmutex.sbn", 0, 309;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0xCB,0x1C,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x44,0x65,0x6D,0x6F,0x5C,
		0x43,0x6F,0x6D,0x6D,0x6F,0x6E,0x5C,0x4D,0x69,0x6E,0x69,0x6D,
		0x61,0x6C,0x5C,0x72,0x65,0x63,0x6D,0x75,0x74,0x65,0x78,0x2E,
		0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\Standard_Demo\recmutex.sbn", 309, 6467;
	.var = .LNxAreRecursiveMutexTasksStillRunning.;
	.var = .LN.xAreRecursiveMutexTasksStillRunning..end;
	.byte =
		0x01,0xEE,0x0B,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.xAreRecursiveMutexTasksStillRunning..end;
	.byte =
		0x15,0x75,0x78,0x4C,0x61,0x73,0x74,0x43,0x6F,0x6E,0x74,0x72,
		0x6F,0x6C,0x6C,0x69,0x6E,0x67,0x43,0x79,0x63,0x6C,0x65,0x73,
		0x00,0x01,0xFF,0x0B,0x00,0x00,0x05,0x03;
	.var = uxLastControllingCycles.0.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x4C,0x61,0x73,0x74,
		0x42,0x6C,0x6F,0x63,0x6B,0x69,0x6E,0x67,0x43,0x79,0x63,0x6C,
		0x65,0x73,0x00,0x01,0xFF,0x0B,0x00,0x00,0x05,0x03;
	.var = uxLastBlockingCycles.1.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x4C,0x61,0x73,0x74,
		0x50,0x6F,0x6C,0x6C,0x69,0x6E,0x67,0x43,0x79,0x63,0x6C,0x65,
		0x73,0x00,0x01,0xFF,0x0B,0x00,0x00,0x05,0x03;
	.var = uxLastPollingCycles.2.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x52,0x65,0x74,0x75,0x72,
		0x6E,0x00,0x01,0xEE,0x0B,0x00,0x00,0x02,0x86,0x78,0x00,0x00,
		0x00,0x00,0x00,0x00,0x00,0x16,0x7E,0x1A,0x00,0x00,0x76,0x53,
		0x74,0x61,0x72,0x74,0x52,0x65,0x63,0x75,0x72,0x73,0x69,0x76,
		0x65,0x4D,0x75,0x74,0x65,0x78,0x54,0x61,0x73,0x6B,0x73,0x00,
		0x01;
	.var = .LNvStartRecursiveMutexTasks.;
	.var = .LN.vStartRecursiveMutexTasks..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN17;
	.var = .LN.vStartRecursiveMutexTasks..end;
	.byte =
		0x00,0x00,0x16,0xE6,0x1A,0x00,0x00,0x70,0x72,0x76,0x52,0x65,
		0x63,0x75,0x72,0x73,0x69,0x76,0x65,0x4D,0x75,0x74,0x65,0x78,
		0x43,0x6F,0x6E,0x74,0x72,0x6F,0x6C,0x6C,0x69,0x6E,0x67,0x54,
		0x61,0x73,0x6B,0x00,0x01;
	.var = .LNprvRecursiveMutexControllingTask.;
	.var = .LN.prvRecursiveMutexControllingTask..end;
	.byte =
		0x01,0x00,0x00,0x17,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xD4,0x03,0x00,0x00,0x02,0x86,0x74,
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN26;
	.var = .LN.prvRecursiveMutexControllingTask..end;
	.byte =
		0x15,0x75,0x78,0x00,0x01,0xFF,0x0B,0x00,0x00,0x02,0x86,0x78,
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,0x3A,0x1B,0x00,0x00,
		0x70,0x72,0x76,0x52,0x65,0x63,0x75,0x72,0x73,0x69,0x76,0x65,
		0x4D,0x75,0x74,0x65,0x78,0x42,0x6C,0x6F,0x63,0x6B,0x69,0x6E,
		0x67,0x54,0x61,0x73,0x6B,0x00,0x01;
	.var = .LNprvRecursiveMutexBlockingTask.;
	.var = .LN.prvRecursiveMutexBlockingTask..end;
	.byte =
		0x01,0x00,0x00,0x17,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xD4,0x03,0x00,0x00,0x02,0x86,0x78,
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN56;
	.var = .LN.prvRecursiveMutexBlockingTask..end;
	.byte =
		0x00,0x00,0x16,0x8D,0x1B,0x00,0x00,0x70,0x72,0x76,0x52,0x65,
		0x63,0x75,0x72,0x73,0x69,0x76,0x65,0x4D,0x75,0x74,0x65,0x78,
		0x50,0x6F,0x6C,0x6C,0x69,0x6E,0x67,0x54,0x61,0x73,0x6B,0x00,
		0x01;
	.var = .LNprvRecursiveMutexPollingTask.;
	.var = .LN.prvRecursiveMutexPollingTask..end;
	.byte =
		0x01,0x00,0x00,0x17,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xD4,0x03,0x00,0x00,0x02,0x86,0x78,
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN76;
	.var = .LN.prvRecursiveMutexPollingTask..end;
	.byte =
		0x00,0x00,0x15,0x78,0x4D,0x75,0x74,0x65,0x78,0x00,0x01,0x5A,
		0x19,0x00,0x00,0x05,0x03;
	.var = xMutex.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x45,0x72,0x72,0x6F,0x72,
		0x4F,0x63,0x63,0x75,0x72,0x72,0x65,0x64,0x00,0x01,0xC9,0x1C,
		0x00,0x00,0x05,0x03;
	.var = xErrorOccurred.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x43,0x6F,0x6E,0x74,0x72,
		0x6F,0x6C,0x6C,0x69,0x6E,0x67,0x49,0x73,0x53,0x75,0x73,0x70,
		0x65,0x6E,0x64,0x65,0x64,0x00,0x01,0xC9,0x1C,0x00,0x00,0x05,
		0x03;
	.var = xControllingIsSuspended.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x42,0x6C,0x6F,0x63,0x6B,
		0x69,0x6E,0x67,0x49,0x73,0x53,0x75,0x73,0x70,0x65,0x6E,0x64,
		0x65,0x64,0x00,0x01,0xC9,0x1C,0x00,0x00,0x05,0x03;
	.var = xBlockingIsSuspended.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x43,0x6F,0x6E,0x74,
		0x72,0x6F,0x6C,0x6C,0x69,0x6E,0x67,0x43,0x79,0x63,0x6C,0x65,
		0x73,0x00,0x01,0xE3,0x13,0x00,0x00,0x05,0x03;
	.var = uxControllingCycles.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x42,0x6C,0x6F,0x63,
		0x6B,0x69,0x6E,0x67,0x43,0x79,0x63,0x6C,0x65,0x73,0x00,0x01,
		0xE3,0x13,0x00,0x00,0x05,0x03;
	.var = uxBlockingCycles.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x50,0x6F,0x6C,0x6C,
		0x69,0x6E,0x67,0x43,0x79,0x63,0x6C,0x65,0x73,0x00,0x01,0xE3,
		0x13,0x00,0x00,0x05,0x03;
	.var = uxPollingCycles.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x43,0x6F,0x6E,0x74,0x72,
		0x6F,0x6C,0x6C,0x69,0x6E,0x67,0x54,0x61,0x73,0x6B,0x48,0x61,
		0x6E,0x64,0x6C,0x65,0x00,0x01,0xE8,0x14,0x00,0x00,0x05,0x03;
	.var = xControllingTaskHandle.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x42,0x6C,0x6F,0x63,0x6B,
		0x69,0x6E,0x67,0x54,0x61,0x73,0x6B,0x48,0x61,0x6E,0x64,0x6C,
		0x65,0x00,0x01,0xE8,0x14,0x00,0x00,0x05,0x03;
	.var = xBlockingTaskHandle.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x0F,0xEE,0x0B,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\Standard_Demo\recmutex.sbn", 6776, 2062;
	.var = .LNxAreRecursiveMutexTasksStillRunning.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xF9,0x02,0x01,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x02,0x0E,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x02,0x0D,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x02,0x0D,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN.xAreRecursiveMutexTasksStillRunning..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvStartRecursiveMutexTasks.;
	.byte =
		0x04,0x01,0x05,0x01,0x81,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x0B,0x0C,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x16,0x11,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x0E,0x0B,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vStartRecursiveMutexTasks..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvRecursiveMutexControllingTask.;
	.byte =
		0x04,0x01,0x05,0x01,0x98,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x03,0x15,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x05,0x07,0x01,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x04,0x15,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x08,0x01,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x05,0x04,0x01,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x04,0x0A,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x05,0x0E,0x0F,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x05,0x25,0x03,0x6B,0x01,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x05,0x03,0x22,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x05,0x0E,0x0D,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x05,0x04,0x10,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x05,0x08,0x01,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x05,0x04,0x01,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x05,0x04,0x0A,0x00,0x05,0x02;
	.var = .LN46;
	.byte =
		0x05,0x25,0x03,0x72,0x01,0x00,0x05,0x02;
	.var = .LN47;
	.byte =
		0x05,0x03,0x20,0x00,0x05,0x02;
	.var = .LN48;
	.byte =
		0x05,0x07,0x01,0x00,0x05,0x02;
	.var = .LN49;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN50;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN51;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN52;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN53;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN54;
	.byte =
		0x05,0x0F,0x0A,0x00,0x05,0x02;
	.var = .LN55;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN.prvRecursiveMutexControllingTask..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvRecursiveMutexBlockingTask.;
	.byte =
		0x04,0x01,0x05,0x01,0xEB,0x00,0x05,0x02;
	.var = .LN56;
	.byte =
		0x05,0x03,0x16,0x00,0x05,0x02;
	.var = .LN57;
	.byte =
		0x05,0x07,0x01,0x00,0x05,0x02;
	.var = .LN58;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN59;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN60;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN61;
	.byte =
		0x05,0x04,0x0A,0x00,0x05,0x02;
	.var = .LN62;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN63;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN64;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN65;
	.byte =
		0x05,0x06,0x0B,0x00,0x05,0x02;
	.var = .LN66;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN67;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN68;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN69;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN70;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN71;
	.byte =
		0x05,0x04,0x0E,0x00,0x05,0x02;
	.var = .LN72;
	.byte =
		0x05,0x03,0x0D,0x00,0x05,0x02;
	.var = .LN73;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN74;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN75;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN.prvRecursiveMutexBlockingTask..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvRecursiveMutexPollingTask.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x9A,0x02,0x01,0x00,0x05,0x02;
	.var = .LN76;
	.byte =
		0x05,0x03,0x12,0x00,0x05,0x02;
	.var = .LN77;
	.byte =
		0x05,0x07,0x01,0x00,0x05,0x02;
	.var = .LN78;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN79;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN80;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN81;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN82;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN83;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN84;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN85;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN86;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN87;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN88;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN89;
	.byte =
		0x05,0x04,0x0E,0x00,0x05,0x02;
	.var = .LN90;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN91;
	.byte =
		0x05,0x04,0x0A,0x00,0x05,0x02;
	.var = .LN92;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN93;
	.byte =
		0x14,0x00,0x05,0x02;
	.var = .LN94;
	.byte =
		0x05,0x10,0x01,0x00,0x05,0x02;
	.var = .LN95;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN96;
	.byte =
		0x05,0x10,0x01,0x00,0x05,0x02;
	.var = .LN97;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN98;
	.byte =
		0x05,0x06,0x0B,0x00,0x05,0x02;
	.var = .LN99;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN100;
	.byte =
		0x05,0x06,0x0E,0x00,0x05,0x02;
	.var = .LN101;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN102;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN103;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN104;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN105;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN106;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN107;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN108;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN109;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN110;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN111;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN112;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN113;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN114;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN115;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN116;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN117;
	.byte =
		0x05,0x06,0x0B,0x00,0x05,0x02;
	.var = .LN118;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN119;
	.byte =
		0x05,0x06,0x0E,0x00,0x05,0x02;
	.var = .LN120;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN121;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN122;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN123;
	.byte =
		0x05,0x03,0x0D,0x00,0x05,0x02;
	.var = .LN.prvRecursiveMutexPollingTask..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x54,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0xCF,0x1C,0x00,0x00,0x72,0x19,0x00,0x00,0x78,0x41,0x72,0x65,
		0x52,0x65,0x63,0x75,0x72,0x73,0x69,0x76,0x65,0x4D,0x75,0x74,
		0x65,0x78,0x54,0x61,0x73,0x6B,0x73,0x53,0x74,0x69,0x6C,0x6C,
		0x52,0x75,0x6E,0x6E,0x69,0x6E,0x67,0x00,0x44,0x1A,0x00,0x00,
		0x76,0x53,0x74,0x61,0x72,0x74,0x52,0x65,0x63,0x75,0x72,0x73,
		0x69,0x76,0x65,0x4D,0x75,0x74,0x65,0x78,0x54,0x61,0x73,0x6B,
		0x73,0x00,0x00,0x00,0x00,0x00;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x3C,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNxAreRecursiveMutexTasksStillRunning.;
	.var = .LN.xAreRecursiveMutexTasksStillRunning..end-.LNxAreRecursiveMutexTasksStillRunning.;
	.var = .LNvStartRecursiveMutexTasks.;
	.var = .LN.vStartRecursiveMutexTasks..end-.LNvStartRecursiveMutexTasks.;
	.var = .LNprvRecursiveMutexControllingTask.;
	.var = .LN.prvRecursiveMutexControllingTask..end-.LNprvRecursiveMutexControllingTask.;
	.var = .LNprvRecursiveMutexBlockingTask.;
	.var = .LN.prvRecursiveMutexBlockingTask..end-.LNprvRecursiveMutexBlockingTask.;
	.var = .LNprvRecursiveMutexPollingTask.;
	.var = .LN.prvRecursiveMutexPollingTask..end-.LNprvRecursiveMutexPollingTask.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type xErrorOccurred.,STT_OBJECT;
	.byte xErrorOccurred.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xControllingIsSuspended.,STT_OBJECT;
	.byte xControllingIsSuspended.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xBlockingIsSuspended.,STT_OBJECT;
	.byte xBlockingIsSuspended.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxControllingCycles.,STT_OBJECT;
	.byte uxControllingCycles.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxBlockingCycles.,STT_OBJECT;
	.byte uxBlockingCycles.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxPollingCycles.,STT_OBJECT;
	.byte uxPollingCycles.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxLastControllingCycles.0.,STT_OBJECT;
	.byte uxLastControllingCycles.0.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxLastBlockingCycles.1.,STT_OBJECT;
	.byte uxLastBlockingCycles.1.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxLastPollingCycles.2.,STT_OBJECT;
	.byte uxLastPollingCycles.2.[] =
		0x00,0x00,0x00,0x00;
	.align 8;
	.type .sRecurs.3,STT_OBJECT;
	.byte .sRecurs.3[] =
		0x52,0x65,0x63,0x75,0x72,0x73,0x69,0x76,0x65,0x5F,0x4D,0x75,
		0x74,0x65,0x78,0x00;
	.align 4;
	.type .sRec1.4,STT_OBJECT;
	.byte .sRec1.4[] =
		0x52,0x65,0x63,0x31,0x00;
	.align 4;
	.type .sRec2.5,STT_OBJECT;
	.byte .sRec2.5[] =
		0x52,0x65,0x63,0x32,0x00;
	.align 4;
	.type .sRec3.6,STT_OBJECT;
	.byte .sRec3.6[] =
		0x52,0x65,0x63,0x33,0x00;
	.align 8;
	.type .sDRTOSF.7,STT_OBJECT;
	.byte .sDRTOSF.7[] =
		0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,0x65,0x65,
		0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,0x73,0x65,
		0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,0x31,0x30,
		0x2E,0x35,0x2E,0x78,0x5C,0x44,0x65,0x6D,0x6F,0x5C,0x43,0x6F,
		0x6D,0x6D,0x6F,0x6E,0x5C,0x4D,0x69,0x6E,0x69,0x6D,0x61,0x6C,
		0x5C,0x72,0x65,0x63,0x6D,0x75,0x74,0x65,0x78,0x2E,0x63,0x00;
