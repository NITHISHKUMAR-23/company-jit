	.file "..\src\main.c";
//  Compilation time: Mon Oct 21 17:02:16 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\src -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo src\main.d -o src\main.doj
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

vApplicationGetTimerTaskMemory.:
.LNvApplicationGetTimerTaskMemory.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {i4,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "..\src\main.c":286
	modify(i7,-4) (nw);
	i4=r4;
	dm(-2,i6)=r12;
	dm(-3,i6)=r8;
	dm(-4,i6)=r4;
.LN0:
// line 295
	i12=xTimerTaskTCB.0.;
	dm(m5,i4)=i12;
.LN1:
// line 298
	i4=dm(-3,i6);
	i12=uxTimerTaskStack.1.;
	dm(m5,i4)=i12;
.LN2:
// line 303
	i4=dm(-2,i6);
	i12=400;
	dm(m5,i4)=i12;
.LN3:
// line 304
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vApplicationGetTimerTaskMemory..end:
.vApplicationGetTimerTaskMemory..end:
	.global vApplicationGetTimerTaskMemory.;
	.type vApplicationGetTimerTaskMemory.,STT_FUNC;

vApplicationGetIdleTaskMemory.:
.LNvApplicationGetIdleTaskMemory.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {i4,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "..\src\main.c":270
	modify(i7,-4) (nw);
	i4=r4;
	dm(-2,i6)=r12;
	dm(-3,i6)=r8;
	dm(-4,i6)=r4;
.LN4:
// line 271
	i12=xIdleTaskTCB.;
	dm(m5,i4)=i12;
.LN5:
// line 272
	i4=dm(-3,i6);
	i12=uxIdleTaskStack.;
	dm(m5,i4)=i12;
.LN6:
// line 273
	i4=dm(-2,i6);
	i12=200;
	dm(m5,i4)=i12;
.LN7:
// line 274
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vApplicationGetIdleTaskMemory..end:
.vApplicationGetIdleTaskMemory..end:
	.global vApplicationGetIdleTaskMemory.;
	.type vApplicationGetIdleTaskMemory.,STT_FUNC;

Task1.:
.LNTask1.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,i4,i12,acc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "..\src\main.c":128
	modify(i7,-2) (nw);
	dm(-3,i6)=r15;
	dm(-2,i6)=r4;

.P46L1:
//-------------------------------------------------------------------
//   Loop at "..\src\main.c" line 129 col 5
//-------------------------------------------------------------------
.LN8:
// line 129
	r2=dm(task1BurstTime.);                 // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if le jump (pc,.P46L2);

.LN9:
// line 130
	r2=dm(task1BurstTime.);                 // Use of volatile in loops precludes optimizations. 
	r15=2;
	comp(r2,r15);
	if le jump (pc,.P46L5);

.LN10:
// line 131
	r2=.sTask1i.2;
	dm(i7,m7)=r15;
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
	modify(i7,2) (nw);
.LN11:
// line 132
	i4=dm(task1BurstTime.);                 // Use of volatile in loops precludes optimizations. 
	i4=modify(i4,-2);
	dm(task1BurstTime.)=i4;                 // Use of volatile in loops precludes optimizations. 
.LN12:
// line 133
	jump (pc,.P46L6);

.P46L5:
.LN13:
// line 134
	r2=dm(task1BurstTime.);                 // Use of volatile in loops precludes optimizations. 
.LN14:
	r1=.sTask1i.3;
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
	modify(i7,2) (nw);
.LN15:
// line 135
	dm(task1BurstTime.)=m5;                 // Use of volatile in loops precludes optimizations. 

.P46L6:
.LN16:
// line 138
	r4=2;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
	jump (pc,.P46L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P46L2:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN17:
// line 140
	r15=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.Task1..end:
.Task1..end:
	.global Task1.;
	.type Task1.,STT_FUNC;

Task2.:
.LNTask2.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,i4,i12,acc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "..\src\main.c":143
	modify(i7,-2) (nw);
	dm(-3,i6)=r15;
	dm(-2,i6)=r4;

.P51L1:
//-------------------------------------------------------------------
//   Loop at "..\src\main.c" line 144 col 5
//-------------------------------------------------------------------
.LN18:
// line 144
	r2=dm(task2BurstTime.);                 // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if le jump (pc,.P51L2);

.LN19:
// line 145
	r2=dm(task2BurstTime.);                 // Use of volatile in loops precludes optimizations. 
	r15=2;
	comp(r2,r15);
	if le jump (pc,.P51L5);

.LN20:
// line 146
	r2=.sTask2i.4;
	dm(i7,m7)=r15;
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
	modify(i7,2) (nw);
.LN21:
// line 147
	i4=dm(task2BurstTime.);                 // Use of volatile in loops precludes optimizations. 
	i4=modify(i4,-2);
	dm(task2BurstTime.)=i4;                 // Use of volatile in loops precludes optimizations. 
.LN22:
// line 148
	jump (pc,.P51L6);

.P51L5:
.LN23:
// line 149
	r2=dm(task2BurstTime.);                 // Use of volatile in loops precludes optimizations. 
.LN24:
	r1=.sTask2i.5;
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
	modify(i7,2) (nw);
.LN25:
// line 150
	dm(task2BurstTime.)=m5;                 // Use of volatile in loops precludes optimizations. 

.P51L6:
.LN26:
// line 153
	r4=2;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
	jump (pc,.P51L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P51L2:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN27:
// line 155
	r15=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.Task2..end:
.Task2..end:
	.global Task2.;
	.type Task2.,STT_FUNC;

accessSharedResource.:
.LNaccessSharedResource.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,acc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "..\src\main.c":159
	modify(i7,-4) (nw);
	dm(-4,i6)=r15;
	dm(-3,i6)=r4;
.LN28:
// line 160
	dm(-2,i6)=r4;

.P58L1:
//-------------------------------------------------------------------
//   Loop at "..\src\main.c" line 162 col 5
//-------------------------------------------------------------------
.LN29:
// line 164
	r2=dm(-2,i6);
.LN30:
	r1=.sTaskld.6;
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
	modify(i7,2) (nw);
.LN31:
// line 165
	r4=dm(mutex.);
.LN32:
	r8=m7;
	cjump xQueueSemaphoreTake. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
	r15=m5;
	r2=btgl r0 by r15;
.LN33:
	if not sz jump (pc,.P58L5);

.LN34:
// line 167
	r2=dm(-2,i6);
.LN35:
	r1=.sTaskld.7;
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
	modify(i7,2) (nw);
.LN36:
// line 170
	r2=dm(-2,i6);
.LN37:
	r1=.sTaskld.8;
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ9-1;
.LCJ9:
	modify(i7,2) (nw);
.LN38:
// line 171
	r2=dm(sharedResource.);                 // Use of volatile in loops precludes optimizations. 
	r2=r2+1;
	dm(sharedResource.)=r2;                 // Use of volatile in loops precludes optimizations. 
.LN39:
// line 172
	r2=dm(sharedResource.);                 // Use of volatile in loops precludes optimizations. 
.LN40:
	r1=.sShared.9;
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ10-1;
.LCJ10:
	modify(i7,2) (nw);
.LN41:
// line 175
	r4=dm(mutex.);
.LN42:
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	r12=m5;
	r8=m5;
	cjump xQueueGenericSend. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ11-1;
.LCJ11:
	modify(i7,2) (nw);
.LN43:
// line 176
	r2=dm(-2,i6);
.LN44:
	r1=.sTaskld.10;
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ12-1;
.LCJ12:
	modify(i7,2) (nw);
.LN45:
// line 177
	jump (pc,.P58L6);

.P58L5:
.LN46:
// line 179
	r2=dm(-2,i6);
.LN47:
	r1=.sTaskld.11;
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ13-1;
.LCJ13:
	modify(i7,2) (nw);

.P58L6:
.LN48:
// line 183
	r4=100;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ14-1;
.LCJ14:
	jump (pc,.P58L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.accessSharedResource..end:
.accessSharedResource..end:
	.global accessSharedResource.;
	.type accessSharedResource.,STT_FUNC;

prvSetupHardware.:
.LNprvSetupHardware.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN49:
// line "..\src\main.c":313
	cjump vParTestInitialise. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ15-1;
.LCJ15:
.LN50:
// line 314
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvSetupHardware..end:
.prvSetupHardware..end:
	.type prvSetupHardware.,STT_FUNC;

main.:
.LNmain.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r2,r4,r8,r12}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
//  Original Loop at "..\src\main.c" line 239 col 25 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
//  Original Loop at "..\src\main.c" line 254 col 25 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
// line "..\src\main.c":191
	modify(i7,-2) (nw);
	dm(-2,i6)=r8;
	dm(-3,i6)=r4;
.LN51:
// line 193
	cjump adi_initComponents. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ16-1;
.LCJ16:
.LN52:
// line 196
	cjump prvSetupHardware. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ17-1;
.LCJ17:
.LN53:
// line 199
	r4=m6;
	cjump vStartLEDFlashTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ18-1;
.LCJ18:
.LN54:
// line 200
	r15=2;
	r4=2;
	cjump vStartPolledQueueTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ19-1;
.LCJ19:
.LN55:
// line 201
	cjump vStartRecursiveMutexTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ20-1;
.LCJ20:
.LN56:
// line 202
	r4=3;
	cjump vStartBlockingQueueTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ21-1;
.LCJ21:
.LN57:
// line 203
	cjump vStartStaticallyAllocatedTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ22-1;
.LCJ22:
.LN58:
// line 208
	r2=4;
	r12=250;
	r8=.sCheck.12;
	r4=vCheckTask.;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=r2;
	dm(i7,m7)=m13;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ23-1;
.LCJ23:
	modify(i7,4) (nw);
.LN59:
// line 212
	r4=3;
	cjump vCreateSuicidalTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ24-1;
.LCJ24:
.LN60:
// line 215
	r8=.sTask1.13;
	r4=Task1.;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=m14;
	dm(i7,m7)=m13;
	r12=256;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ25-1;
.LCJ25:
	modify(i7,4) (nw);
.LN61:
// line 216
	r8=.sTask2.14;
	r4=Task2.;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=r15;
	dm(i7,m7)=m13;
	r12=256;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ26-1;
.LCJ26:
	modify(i7,4) (nw);
.LN62:
// line 221
	cjump vTaskStartScheduler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ27-1;
.LCJ27:

.P67L1:
//-------------------------------------------------------------------
//   Loop at "..\src\main.c" line 227 col 5
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
	jump (pc,.P67L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.main..end:
.main..end:
	.global main.;
	.type main.,STT_FUNC;

prvCheckOtherTasksAreStillRunning.:
.LNprvCheckOtherTasksAreStillRunning.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r1-r2,i12,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "..\src\main.c":319
	modify(i7,-2) (nw);
	dm(-2,i6)=r15;
.LN63:
// line 320
	cjump xAreBlockingQueuesStillRunning. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ28-1;
.LCJ28:
	r15=m5;
	r2=btgl r0 by r15;
.LN64:
	if sz jump (pc,.P78L2);

.LN65:
// line 322
	r2=dm(ulErrorFlags.);
	r2=bset r2 by r15;
	dm(ulErrorFlags.)=r2;
.LN66:
// line 323
	jump (pc,.P78L3);

.P78L2:

.P78L3:
.LN67:
// line 325
	cjump xArePollingQueuesStillRunning. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ29-1;
.LCJ29:
	r2=btgl r0 by r15;
.LN68:
	if sz jump (pc,.P78L5);

.LN69:
// line 327
	r2=dm(ulErrorFlags.);
	r1=m6;
	r2=bset r2 by r1;
	dm(ulErrorFlags.)=r2;
.LN70:
// line 328
	jump (pc,.P78L6);

.P78L5:

.P78L6:
.LN71:
// line 330
	cjump xIsCreateTaskStillRunning. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ30-1;
.LCJ30:
	r2=btgl r0 by r15;
.LN72:
	if sz jump (pc,.P78L8);

.LN73:
// line 332
	r2=dm(ulErrorFlags.);
	r1=2;
	r2=bset r2 by r1;
	dm(ulErrorFlags.)=r2;
.LN74:
// line 333
	jump (pc,.P78L9);

.P78L8:

.P78L9:
.LN75:
// line 335
	cjump xAreRecursiveMutexTasksStillRunning. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ31-1;
.LCJ31:
	r2=btgl r0 by r15;
.LN76:
	if sz jump (pc,.P78L11);

.LN77:
// line 337
	r2=dm(ulErrorFlags.);
	r1=3;
	r2=bset r2 by r1;
	dm(ulErrorFlags.)=r2;
.LN78:
// line 338
	jump (pc,.P78L12);

.P78L11:

.P78L12:
.LN79:
// line 340
	cjump xAreStaticAllocationTasksStillRunning. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ32-1;
.LCJ32:
	r2=btgl r0 by r15;
.LN80:
	if sz jump (pc,.P78L14);

.LN81:
// line 342
	r2=dm(ulErrorFlags.);
	r1=4;
	r2=bset r2 by r1;
	dm(ulErrorFlags.)=r2;
.LN82:
// line 343
	jump (pc,.P78L15);

.P78L14:

.P78L15:
.LN83:
// line 344
	r15=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvCheckOtherTasksAreStillRunning..end:
.prvCheckOtherTasksAreStillRunning..end:
	.type prvCheckOtherTasksAreStillRunning.,STT_FUNC;

vApplicationStackOverflowHook.:
.LNvApplicationStackOverflowHook.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  No scratch registers used.
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "..\src\main.c":349
	modify(i7,-2) (nw);
	dm(-2,i6)=r8;
	dm(-3,i6)=r4;
.LN84:
// line 356
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ33-1;
.LCJ33:

.P84L1:
//-------------------------------------------------------------------
//   Loop at "..\src\main.c" line 357 col 2
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
	jump (pc,.P84L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.vApplicationStackOverflowHook..end:
.vApplicationStackOverflowHook..end:
	.global vApplicationStackOverflowHook.;
	.type vApplicationStackOverflowHook.,STT_FUNC;

vAssertCalled.:
.LNvAssertCalled.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  No scratch registers used.
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "..\src\main.c":366
	modify(i7,-2) (nw);
	dm(-2,i6)=r8;
	dm(-3,i6)=r4;
.LN85:
// line 370
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ34-1;
.LCJ34:

.P86L1:
//-------------------------------------------------------------------
//   Loop at "..\src\main.c" line 371 col 5
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 4 
//   cycles (includes 2 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used   2 out of    4 ( 50.0%)
//     multifunction alu               used   2 out of    4 ( 50.0%)
//     multifunction float multiply    used   2 out of    4 ( 50.0%)
//     multifunction integer add sub   used   2 out of    4 ( 50.0%)
//     multifunction integer multiply  used   2 out of    4 ( 50.0%)
//     multifunction mult              used   2 out of    4 ( 50.0%)
//     pm dag                          used   2 out of    4 ( 50.0%)
//     shift immediate                 used   2 out of    4 ( 50.0%)
//     memory access                   used   2 out of    8 ( 25.0%)
//-------------------------------------------------------------------

	// -- 2 stalls --
.LN86:
// line 373
	nop;
	jump (pc,.P86L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.vAssertCalled..end:
.vAssertCalled..end:
	.global vAssertCalled.;
	.type vAssertCalled.,STT_FUNC;

prvPrintInformation.:
.LNprvPrintInformation.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN87:
// line "..\src\main.c":382
	r2=dm(ulErrorFlags.);
	r2=pass r2;
	if eq jump (pc,.P89L2);

.LN88:
// line 384
	r2=.sTestfa.16;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ35-1;
.LCJ35:
	modify(i7,2) (nw);
.LN89:
// line 385
	dm(ulErrorFlags.)=m5;
.LN90:
// line 386
	jump (pc,.P89L3);

.P89L2:
.LN91:
// line 389
	r2=.sTestpa.17;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ36-1;
.LCJ36:
	modify(i7,2) (nw);

.P89L3:
.LN92:
// line 391
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvPrintInformation..end:
.prvPrintInformation..end:
	.type prvPrintInformation.,STT_FUNC;

vCheckTask.:
.LNvCheckTask.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r4,r8,i4}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
//  Original Loop at "..\src\main.c" line 404 col 9 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
// line "..\src\main.c":396
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN93:
// line 399
	cjump xTaskGetTickCount. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ37-1;
.LCJ37:
.LN94:
	dm(-2,i6)=r0;

.P74L1:
//-------------------------------------------------------------------
//   Loop at "..\src\main.c" line 401 col 5
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 15 
//   cycles (includes 2 stalls but excludes the cost of function calls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used   7 out of   15 ( 46.7%)
//     pm dag                          used   7 out of   15 ( 46.7%)
//     shift immediate                 used   7 out of   15 ( 46.7%)
//     multifunction alu               used   6 out of   15 ( 40.0%)
//     multifunction float multiply    used   6 out of   15 ( 40.0%)
//     multifunction integer add sub   used   6 out of   15 ( 40.0%)
//     multifunction integer multiply  used   6 out of   15 ( 40.0%)
//     multifunction mult              used   6 out of   15 ( 40.0%)
//     memory access                   used   7 out of   30 ( 23.3%)
//-------------------------------------------------------------------

	// -- 2 stalls --
.LN95:
// line 404
	i4=modify(i6,-2) (nw);
	r8=5000;
	r4=i4;
	cjump xTaskDelayUntil. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ38-1;
.LCJ38:

.LN96:
// line 407
	cjump prvCheckOtherTasksAreStillRunning. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ39-1;
.LCJ39:
.LN97:
// line 410
	cjump prvPrintInformation. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ40-1;
.LCJ40:
	jump (pc,.P74L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.vCheckTask..end:
.vCheckTask..end:
	.type vCheckTask.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="vApplicationGetTimerTaskMemory.";
	.file_attr FuncName="vApplicationGetIdleTaskMemory.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="Task1.";
	.file_attr FuncName="Task2.";
	.file_attr FuncName="accessSharedResource.";
	.file_attr FuncName="prvSetupHardware.";
	.file_attr FuncName="main.";
	.file_attr FuncName="prvCheckOtherTasksAreStillRunning.";
	.file_attr FuncName="vApplicationStackOverflowHook.";
	.file_attr FuncName="vAssertCalled.";
	.file_attr FuncName="prvPrintInformation.";
	.file_attr FuncName="vCheckTask.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern _printf32.;
	.type _printf32.,STT_FUNC;
	.extern vTaskDelay.;
	.type vTaskDelay.,STT_FUNC;
	.extern xQueueSemaphoreTake.;
	.type xQueueSemaphoreTake.,STT_FUNC;
	.extern xQueueGenericSend.;
	.type xQueueGenericSend.,STT_FUNC;
	.extern vParTestInitialise.;
	.type vParTestInitialise.,STT_FUNC;
	.extern adi_initComponents.;
	.type adi_initComponents.,STT_FUNC;
	.extern vStartLEDFlashTasks.;
	.type vStartLEDFlashTasks.,STT_FUNC;
	.extern vStartPolledQueueTasks.;
	.type vStartPolledQueueTasks.,STT_FUNC;
	.extern vStartRecursiveMutexTasks.;
	.type vStartRecursiveMutexTasks.,STT_FUNC;
	.extern vStartBlockingQueueTasks.;
	.type vStartBlockingQueueTasks.,STT_FUNC;
	.extern vStartStaticallyAllocatedTasks.;
	.type vStartStaticallyAllocatedTasks.,STT_FUNC;
	.extern xTaskCreate.;
	.type xTaskCreate.,STT_FUNC;
	.extern vCreateSuicidalTasks.;
	.type vCreateSuicidalTasks.,STT_FUNC;
	.extern vTaskStartScheduler.;
	.type vTaskStartScheduler.,STT_FUNC;
	.extern xAreBlockingQueuesStillRunning.;
	.type xAreBlockingQueuesStillRunning.,STT_FUNC;
	.extern xArePollingQueuesStillRunning.;
	.type xArePollingQueuesStillRunning.,STT_FUNC;
	.extern xIsCreateTaskStillRunning.;
	.type xIsCreateTaskStillRunning.,STT_FUNC;
	.extern xAreRecursiveMutexTasksStillRunning.;
	.type xAreRecursiveMutexTasksStillRunning.,STT_FUNC;
	.extern xAreStaticAllocationTasksStillRunning.;
	.type xAreStaticAllocationTasksStillRunning.,STT_FUNC;
	.extern ulPortSetInterruptMask.;
	.type ulPortSetInterruptMask.,STT_FUNC;
	.extern xTaskGetTickCount.;
	.type xTaskGetTickCount.,STT_FUNC;
	.extern xTaskDelayUntil.;
	.type xTaskDelayUntil.,STT_FUNC;

	.section/DOUBLE32 seg_dmda;

	.align 8;
	.type .epcbss,STT_OBJECT;
.epcbss:
	.byte mutex.[4];
	.type mutex.,STT_OBJECT;
	.byte xIdleTaskTCB.[96];
	.type xIdleTaskTCB.,STT_OBJECT;
	.align 8;
	.byte uxIdleTaskStack.[800];
	.type uxIdleTaskStack.,STT_OBJECT;
	.byte xTimerTaskTCB.0.[96];
	.type xTimerTaskTCB.0.,STT_OBJECT;
	.byte uxTimerTaskStack.1.[1600];
	.type uxTimerTaskStack.1.,STT_OBJECT;
.epcbss.end:

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\src\main.sbn", 0, 309;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0xB9,0x1F,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x2E,0x2E,0x5C,0x73,0x72,0x63,0x5C,0x6D,0x61,0x69,
		0x6E,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\src\main.sbn", 309, 6742;
	.var = .LNvApplicationGetTimerTaskMemory.;
	.var = .LN.vApplicationGetTimerTaskMemory..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x70,0x78,0x54,0x69,0x6D,0x65,0x72,
		0x54,0x61,0x73,0x6B,0x54,0x43,0x42,0x42,0x75,0x66,0x66,0x65,
		0x72,0x00,0x51,0x1B,0x00,0x00,0x02,0x86,0x70,0x00,0x14,0x70,
		0x70,0x78,0x54,0x69,0x6D,0x65,0x72,0x54,0x61,0x73,0x6B,0x53,
		0x74,0x61,0x63,0x6B,0x42,0x75,0x66,0x66,0x65,0x72,0x00,0x45,
		0x1B,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x70,0x75,0x6C,0x54,
		0x69,0x6D,0x65,0x72,0x54,0x61,0x73,0x6B,0x53,0x74,0x61,0x63,
		0x6B,0x53,0x69,0x7A,0x65,0x00,0x3F,0x1B,0x00,0x00,0x02,0x86,
		0x78,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.vApplicationGetTimerTaskMemory..end;
	.byte =
		0x16,0x78,0x54,0x69,0x6D,0x65,0x72,0x54,0x61,0x73,0x6B,0x54,
		0x43,0x42,0x00,0x01,0x1E,0x11,0x00,0x00,0x05,0x03;
	.var = xTimerTaskTCB.0.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x75,0x78,0x54,0x69,0x6D,0x65,
		0x72,0x54,0x61,0x73,0x6B,0x53,0x74,0x61,0x63,0x6B,0x00,0x01,
		0x2F,0x1B,0x00,0x00,0x05,0x03;
	.var = uxTimerTaskStack.1.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x08,0x3F,0x1B,0x00,0x00,
		0xBA,0x0C,0x00,0x00,0x09,0x90,0x03,0x00,0x8F,0x03,0x00,0x07,
		0x00,0x3D,0x06,0x00,0x00,0x07,0x00,0x2E,0x18,0x00,0x00,0x07,
		0x00,0x1E,0x11,0x00,0x00,0x07,0x00,0x4B,0x1B,0x00,0x00,0x13,
		0xF1,0x1B,0x00,0x00,0x76,0x41,0x70,0x70,0x6C,0x69,0x63,0x61,
		0x74,0x69,0x6F,0x6E,0x47,0x65,0x74,0x49,0x64,0x6C,0x65,0x54,
		0x61,0x73,0x6B,0x4D,0x65,0x6D,0x6F,0x72,0x79,0x00,0x01;
	.var = .LNvApplicationGetIdleTaskMemory.;
	.var = .LN.vApplicationGetIdleTaskMemory..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x70,0x78,0x49,0x64,0x6C,0x65,0x54,
		0x61,0x73,0x6B,0x54,0x43,0x42,0x42,0x75,0x66,0x66,0x65,0x72,
		0x00,0x51,0x1B,0x00,0x00,0x02,0x86,0x70,0x00,0x14,0x70,0x70,
		0x78,0x49,0x64,0x6C,0x65,0x54,0x61,0x73,0x6B,0x53,0x74,0x61,
		0x63,0x6B,0x42,0x75,0x66,0x66,0x65,0x72,0x00,0x45,0x1B,0x00,
		0x00,0x02,0x86,0x74,0x00,0x14,0x70,0x75,0x6C,0x49,0x64,0x6C,
		0x65,0x54,0x61,0x73,0x6B,0x53,0x74,0x61,0x63,0x6B,0x53,0x69,
		0x7A,0x65,0x00,0x3F,0x1B,0x00,0x00,0x02,0x86,0x78,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN4;
	.var = .LN.vApplicationGetIdleTaskMemory..end;
	.byte =
		0x00,0x00,0x13,0x2D,0x1C,0x00,0x00,0x54,0x61,0x73,0x6B,0x31,
		0x00,0x01;
	.var = .LNTask1.;
	.var = .LN.Task1..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0x9A,0x03,0x00,0x00,0x02,0x86,0x78,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN8;
	.var = .LN.Task1..end;
	.byte =
		0x00,0x00,0x13,0x69,0x1C,0x00,0x00,0x54,0x61,0x73,0x6B,0x32,
		0x00,0x01;
	.var = .LNTask2.;
	.var = .LN.Task2..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0x9A,0x03,0x00,0x00,0x02,0x86,0x78,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN18;
	.var = .LN.Task2..end;
	.byte =
		0x00,0x00,0x13,0xC2,0x1C,0x00,0x00,0x61,0x63,0x63,0x65,0x73,
		0x73,0x53,0x68,0x61,0x72,0x65,0x64,0x52,0x65,0x73,0x6F,0x75,
		0x72,0x63,0x65,0x00,0x01;
	.var = .LNaccessSharedResource.;
	.var = .LN.accessSharedResource..end;
	.byte =
		0x01,0x01,0x00,0x14,0x61,0x72,0x67,0x00,0x9A,0x03,0x00,0x00,
		0x02,0x86,0x74,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN28;
	.var = .LN.accessSharedResource..end;
	.byte =
		0x16,0x74,0x68,0x72,0x65,0x61,0x64,0x49,0x44,0x00,0x01,0x39,
		0x02,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,
		0x00,0x13,0xF3,0x1C,0x00,0x00,0x70,0x72,0x76,0x53,0x65,0x74,
		0x75,0x70,0x48,0x61,0x72,0x64,0x77,0x61,0x72,0x65,0x00,0x01;
	.var = .LNprvSetupHardware.;
	.var = .LN.prvSetupHardware..end;
	.byte =
		0x01,0x00,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN49;
	.var = .LN.prvSetupHardware..end;
	.byte =
		0x00,0x00,0x17,0x46,0x1D,0x00,0x00,0x6D,0x61,0x69,0x6E,0x00,
		0x01;
	.var = .LNmain.;
	.var = .LN.main..end;
	.byte =
		0x01,0x11,0x02,0x00,0x00,0x01,0x00,0x14,0x61,0x72,0x67,0x63,
		0x00,0x11,0x02,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x61,0x72,
		0x67,0x76,0x00,0x46,0x1D,0x00,0x00,0x02,0x86,0x78,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN51;
	.var = .LN.main..end;
	.byte =
		0x15,0x00,0x00,0x00,0x00;
	.var = .LNmain.;
	.var = .LN.main..end;
	.byte =
		0x00,0x00,0x00,0x07,0x00,0x82,0x05,0x00,0x00,0x13,0x8E,0x1D,
		0x00,0x00,0x70,0x72,0x76,0x43,0x68,0x65,0x63,0x6B,0x4F,0x74,
		0x68,0x65,0x72,0x54,0x61,0x73,0x6B,0x73,0x41,0x72,0x65,0x53,
		0x74,0x69,0x6C,0x6C,0x52,0x75,0x6E,0x6E,0x69,0x6E,0x67,0x00,
		0x01;
	.var = .LNprvCheckOtherTasksAreStillRunning.;
	.var = .LN.prvCheckOtherTasksAreStillRunning..end;
	.byte =
		0x01,0x00,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN63;
	.var = .LN.prvCheckOtherTasksAreStillRunning..end;
	.byte =
		0x00,0x00,0x13,0xEF,0x1D,0x00,0x00,0x76,0x41,0x70,0x70,0x6C,
		0x69,0x63,0x61,0x74,0x69,0x6F,0x6E,0x53,0x74,0x61,0x63,0x6B,
		0x4F,0x76,0x65,0x72,0x66,0x6C,0x6F,0x77,0x48,0x6F,0x6F,0x6B,
		0x00,0x01;
	.var = .LNvApplicationStackOverflowHook.;
	.var = .LN.vApplicationStackOverflowHook..end;
	.byte =
		0x01,0x01,0x00,0x14,0x78,0x54,0x61,0x73,0x6B,0x00,0xC6,0x15,
		0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x70,0x63,0x54,0x61,0x73,
		0x6B,0x4E,0x61,0x6D,0x65,0x00,0x82,0x05,0x00,0x00,0x02,0x86,
		0x78,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN84;
	.var = .LN.vApplicationStackOverflowHook..end;
	.byte =
		0x00,0x00,0x13,0x3D,0x1E,0x00,0x00,0x76,0x41,0x73,0x73,0x65,
		0x72,0x74,0x43,0x61,0x6C,0x6C,0x65,0x64,0x00,0x01;
	.var = .LNvAssertCalled.;
	.var = .LN.vAssertCalled..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x63,0x46,0x69,0x6C,0x65,0x00,0xD8,
		0x17,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x75,0x6C,0x4C,0x69,
		0x6E,0x65,0x00,0x52,0x02,0x00,0x00,0x02,0x86,0x78,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN85;
	.var = .LN.vAssertCalled..end;
	.byte =
		0x00,0x00,0x13,0x71,0x1E,0x00,0x00,0x70,0x72,0x76,0x50,0x72,
		0x69,0x6E,0x74,0x49,0x6E,0x66,0x6F,0x72,0x6D,0x61,0x74,0x69,
		0x6F,0x6E,0x00,0x01;
	.var = .LNprvPrintInformation.;
	.var = .LN.prvPrintInformation..end;
	.byte =
		0x01,0x00,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN87;
	.var = .LN.prvPrintInformation..end;
	.byte =
		0x00,0x00,0x13,0xD3,0x1E,0x00,0x00,0x76,0x43,0x68,0x65,0x63,
		0x6B,0x54,0x61,0x73,0x6B,0x00,0x01;
	.var = .LNvCheckTask.;
	.var = .LN.vCheckTask..end;
	.byte =
		0x01,0x00,0x00,0x14,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0x9A,0x03,0x00,0x00,0x02,0x86,0x74,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN93;
	.var = .LN.vCheckTask..end;
	.byte =
		0x16,0x78,0x4C,0x61,0x73,0x74,0x45,0x78,0x65,0x63,0x75,0x74,
		0x69,0x6F,0x6E,0x54,0x69,0x6D,0x65,0x00,0x01,0xEF,0x0C,0x00,
		0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,
		0x75,0x6C,0x45,0x72,0x72,0x6F,0x72,0x46,0x6C,0x61,0x67,0x73,
		0x00,0x01,0x28,0x02,0x00,0x00,0x05,0x03;
	.var = ulErrorFlags.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x74,0x61,0x73,0x6B,0x31,0x42,
		0x75,0x72,0x73,0x74,0x54,0x69,0x6D,0x65,0x00,0x01,0xB7,0x1F,
		0x00,0x00,0x05,0x03;
	.var = task1BurstTime.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x74,0x61,0x73,0x6B,0x32,0x42,
		0x75,0x72,0x73,0x74,0x54,0x69,0x6D,0x65,0x00,0x01,0xB7,0x1F,
		0x00,0x00,0x05,0x03;
	.var = task2BurstTime.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x73,0x68,0x61,0x72,0x65,0x64,
		0x52,0x65,0x73,0x6F,0x75,0x72,0x63,0x65,0x00,0x01,0xB7,0x1F,
		0x00,0x00,0x05,0x03;
	.var = sharedResource.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x6D,0x75,0x74,0x65,0x78,0x00,
		0x01,0x38,0x1A,0x00,0x00,0x05,0x03;
	.var = mutex.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x78,0x49,0x64,0x6C,0x65,0x54,
		0x61,0x73,0x6B,0x54,0x43,0x42,0x00,0x01,0x1E,0x11,0x00,0x00,
		0x05,0x03;
	.var = xIdleTaskTCB.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x75,0x78,0x49,0x64,0x6C,0x65,
		0x54,0x61,0x73,0x6B,0x53,0x74,0x61,0x63,0x6B,0x00,0x01,0xA7,
		0x1F,0x00,0x00,0x05,0x03;
	.var = uxIdleTaskStack.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x08,0xB7,0x1F,0x00,0x00,0xBA,0x0C,
		0x00,0x00,0x09,0xC8,0x01,0x00,0xC7,0x01,0x00,0x0F,0x11,0x02,
		0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\src\main.sbn", 7051, 2123;
	.var = .LNvApplicationGetTimerTaskMemory.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x9D,0x02,0x01,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x02,0x12,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vApplicationGetTimerTaskMemory..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvApplicationGetIdleTaskMemory.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x8D,0x02,0x01,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vApplicationGetIdleTaskMemory..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNTask1.;
	.byte =
		0x04,0x01,0x05,0x20,0x88,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x13,0x0A,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x13,0x01,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x13,0x0C,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN.Task1..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNTask2.;
	.byte =
		0x04,0x01,0x05,0x20,0x97,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x13,0x0A,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x13,0x01,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x13,0x0C,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN.Task2..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNaccessSharedResource.;
	.byte =
		0x04,0x01,0x05,0x01,0xA7,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x05,0x13,0x0A,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x13,0x01,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x05,0x13,0x01,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x05,0x13,0x01,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x05,0x13,0x01,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN46;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN47;
	.byte =
		0x05,0x13,0x01,0x00,0x05,0x02;
	.var = .LN48;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN.accessSharedResource..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvSetupHardware.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xB6,0x02,0x01,0x00,0x05,0x02;
	.var = .LN49;
	.byte =
		0x05,0x17,0x0B,0x00,0x05,0x02;
	.var = .LN50;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvSetupHardware..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNmain.;
	.byte =
		0x04,0x01,0x05,0x01,0xC7,0x00,0x05,0x02;
	.var = .LN51;
	.byte =
		0x05,0x14,0x0B,0x00,0x05,0x02;
	.var = .LN52;
	.byte =
		0x05,0x15,0x0C,0x00,0x05,0x02;
	.var = .LN53;
	.byte =
		0x05,0x18,0x0C,0x00,0x05,0x02;
	.var = .LN54;
	.byte =
		0x05,0x1B,0x0A,0x00,0x05,0x02;
	.var = .LN55;
	.byte =
		0x05,0x1E,0x0A,0x00,0x05,0x02;
	.var = .LN56;
	.byte =
		0x05,0x1D,0x0A,0x00,0x05,0x02;
	.var = .LN57;
	.byte =
		0x05,0x23,0x0A,0x00,0x05,0x02;
	.var = .LN58;
	.byte =
		0x05,0x10,0x0E,0x00,0x05,0x02;
	.var = .LN59;
	.byte =
		0x05,0x19,0x0D,0x00,0x05,0x02;
	.var = .LN60;
	.byte =
		0x05,0x17,0x0C,0x00,0x05,0x02;
	.var = .LN61;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN62;
	.byte =
		0x05,0x18,0x0E,0x00,0x05,0x02;
	.var = .LN.main..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvCheckOtherTasksAreStillRunning.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xBE,0x02,0x01,0x00,0x05,0x02;
	.var = .LN63;
	.byte =
		0x05,0x27,0x0A,0x00,0x05,0x02;
	.var = .LN64;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN65;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN66;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN67;
	.byte =
		0x05,0x27,0x0B,0x00,0x05,0x02;
	.var = .LN68;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN69;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN70;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN71;
	.byte =
		0x05,0x22,0x0B,0x00,0x05,0x02;
	.var = .LN72;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN73;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN74;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN75;
	.byte =
		0x05,0x2C,0x0B,0x00,0x05,0x02;
	.var = .LN76;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN77;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN78;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN79;
	.byte =
		0x05,0x2E,0x0B,0x00,0x05,0x02;
	.var = .LN80;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN81;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN82;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN83;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvCheckOtherTasksAreStillRunning..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvApplicationStackOverflowHook.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xDC,0x02,0x01,0x00,0x05,0x02;
	.var = .LN84;
	.byte =
		0x05,0x02,0x10,0x00,0x05,0x02;
	.var = .LN.vApplicationStackOverflowHook..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvAssertCalled.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xED,0x02,0x01,0x00,0x05,0x02;
	.var = .LN85;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN86;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN.vAssertCalled..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvPrintInformation.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xFC,0x02,0x01,0x00,0x05,0x02;
	.var = .LN87;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN88;
	.byte =
		0x05,0x0F,0x0B,0x00,0x05,0x02;
	.var = .LN89;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN90;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN91;
	.byte =
		0x05,0x0F,0x0C,0x00,0x05,0x02;
	.var = .LN92;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN.prvPrintInformation..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvCheckTask.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x8B,0x03,0x01,0x00,0x05,0x02;
	.var = .LN93;
	.byte =
		0x05,0x2B,0x0C,0x00,0x05,0x02;
	.var = .LN94;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN95;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN96;
	.byte =
		0x05,0x2A,0x0C,0x00,0x05,0x02;
	.var = .LN97;
	.byte =
		0x05,0x1C,0x0C,0x00,0x05,0x02;
	.var = .LN.vCheckTask..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0xE3,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.inc/binary ".\src\main.sbn", 9174, 221;
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
	.var = .LNvApplicationGetTimerTaskMemory.;
	.var = .LN.vApplicationGetTimerTaskMemory..end-.LNvApplicationGetTimerTaskMemory.;
	.var = .LNvApplicationGetIdleTaskMemory.;
	.var = .LN.vApplicationGetIdleTaskMemory..end-.LNvApplicationGetIdleTaskMemory.;
	.var = .LNTask1.;
	.var = .LN.Task1..end-.LNTask1.;
	.var = .LNTask2.;
	.var = .LN.Task2..end-.LNTask2.;
	.var = .LNaccessSharedResource.;
	.var = .LN.accessSharedResource..end-.LNaccessSharedResource.;
	.var = .LNprvSetupHardware.;
	.var = .LN.prvSetupHardware..end-.LNprvSetupHardware.;
	.var = .LNmain.;
	.var = .LN.main..end-.LNmain.;
	.var = .LNvCheckTask.;
	.var = .LN.vCheckTask..end-.LNvCheckTask.;
	.var = .LNprvCheckOtherTasksAreStillRunning.;
	.var = .LN.prvCheckOtherTasksAreStillRunning..end-.LNprvCheckOtherTasksAreStillRunning.;
	.var = .LNvApplicationStackOverflowHook.;
	.var = .LN.vApplicationStackOverflowHook..end-.LNvApplicationStackOverflowHook.;
	.var = .LNvAssertCalled.;
	.var = .LN.vAssertCalled..end-.LNvAssertCalled.;
	.var = .LNprvPrintInformation.;
	.var = .LN.prvPrintInformation..end-.LNprvPrintInformation.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type ulErrorFlags.,STT_OBJECT;
	.byte ulErrorFlags.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.global task1BurstTime.;
	.type task1BurstTime.,STT_OBJECT;
	.byte task1BurstTime.[] =
		0x0A,0x00,0x00,0x00;
	.align 4;
	.global task2BurstTime.;
	.type task2BurstTime.,STT_OBJECT;
	.byte task2BurstTime.[] =
		0x0C,0x00,0x00,0x00;
	.align 4;
	.type sharedResource.,STT_OBJECT;
	.byte sharedResource.[] =
		0x00,0x00,0x00,0x00;
	.align 8;
	.type .sTask1i.2,STT_OBJECT;
	.byte .sTask1i.2[] =
		0x54,0x61,0x73,0x6B,0x20,0x31,0x20,0x69,0x73,0x20,0x72,0x75,
		0x6E,0x6E,0x69,0x6E,0x67,0x20,0x66,0x6F,0x72,0x20,0x25,0x64,
		0x20,0x6D,0x73,0x2E,0x0A,0x00;
	.align 8;
	.type .sTask1i.3,STT_OBJECT;
	.byte .sTask1i.3[] =
		0x54,0x61,0x73,0x6B,0x20,0x31,0x20,0x69,0x73,0x20,0x72,0x75,
		0x6E,0x6E,0x69,0x6E,0x67,0x20,0x66,0x6F,0x72,0x20,0x25,0x64,
		0x20,0x6D,0x73,0x20,0x28,0x66,0x69,0x6E,0x61,0x6C,0x20,0x62,
		0x75,0x72,0x73,0x74,0x29,0x2E,0x0A,0x00;
	.align 8;
	.type .sTask2i.4,STT_OBJECT;
	.byte .sTask2i.4[] =
		0x54,0x61,0x73,0x6B,0x20,0x32,0x20,0x69,0x73,0x20,0x72,0x75,
		0x6E,0x6E,0x69,0x6E,0x67,0x20,0x66,0x6F,0x72,0x20,0x25,0x64,
		0x20,0x6D,0x73,0x2E,0x0A,0x00;
	.align 8;
	.type .sTask2i.5,STT_OBJECT;
	.byte .sTask2i.5[] =
		0x54,0x61,0x73,0x6B,0x20,0x32,0x20,0x69,0x73,0x20,0x72,0x75,
		0x6E,0x6E,0x69,0x6E,0x67,0x20,0x66,0x6F,0x72,0x20,0x25,0x64,
		0x20,0x6D,0x73,0x20,0x28,0x66,0x69,0x6E,0x61,0x6C,0x20,0x62,
		0x75,0x72,0x73,0x74,0x29,0x2E,0x0A,0x00;
	.align 8;
	.type .sTaskld.6,STT_OBJECT;
	.byte .sTaskld.6[] =
		0x54,0x61,0x73,0x6B,0x20,0x25,0x6C,0x64,0x20,0x61,0x74,0x74,
		0x65,0x6D,0x70,0x74,0x69,0x6E,0x67,0x20,0x74,0x6F,0x20,0x6C,
		0x6F,0x63,0x6B,0x20,0x6D,0x75,0x74,0x65,0x78,0x2E,0x0A,0x00;
	.align 8;
	.type .sTaskld.7,STT_OBJECT;
	.byte .sTaskld.7[] =
		0x54,0x61,0x73,0x6B,0x20,0x25,0x6C,0x64,0x20,0x6C,0x6F,0x63,
		0x6B,0x65,0x64,0x20,0x74,0x68,0x65,0x20,0x6D,0x75,0x74,0x65,
		0x78,0x2E,0x0A,0x00;
	.align 8;
	.type .sTaskld.8,STT_OBJECT;
	.byte .sTaskld.8[] =
		0x54,0x61,0x73,0x6B,0x20,0x25,0x6C,0x64,0x20,0x61,0x63,0x63,
		0x65,0x73,0x73,0x69,0x6E,0x67,0x20,0x73,0x68,0x61,0x72,0x65,
		0x64,0x20,0x72,0x65,0x73,0x6F,0x75,0x72,0x63,0x65,0x2E,0x0A,
		0x00;
	.align 8;
	.type .sShared.9,STT_OBJECT;
	.byte .sShared.9[] =
		0x53,0x68,0x61,0x72,0x65,0x64,0x20,0x72,0x65,0x73,0x6F,0x75,
		0x72,0x63,0x65,0x20,0x76,0x61,0x6C,0x75,0x65,0x3A,0x20,0x25,
		0x64,0x0A,0x00;
	.align 8;
	.type .sTaskld.10,STT_OBJECT;
	.byte .sTaskld.10[] =
		0x54,0x61,0x73,0x6B,0x20,0x25,0x6C,0x64,0x20,0x75,0x6E,0x6C,
		0x6F,0x63,0x6B,0x65,0x64,0x20,0x74,0x68,0x65,0x20,0x6D,0x75,
		0x74,0x65,0x78,0x2E,0x0A,0x00;
	.align 8;
	.type .sTaskld.11,STT_OBJECT;
	.byte .sTaskld.11[] =
		0x54,0x61,0x73,0x6B,0x20,0x25,0x6C,0x64,0x20,0x66,0x61,0x69,
		0x6C,0x65,0x64,0x20,0x74,0x6F,0x20,0x6C,0x6F,0x63,0x6B,0x20,
		0x74,0x68,0x65,0x20,0x6D,0x75,0x74,0x65,0x78,0x2E,0x0A,0x00;
	.align 4;
	.type .sCheck.12,STT_OBJECT;
	.byte .sCheck.12[] =
		0x43,0x68,0x65,0x63,0x6B,0x00;
	.align 4;
	.type .sTask1.13,STT_OBJECT;
	.byte .sTask1.13[] =
		0x54,0x61,0x73,0x6B,0x31,0x00;
	.align 4;
	.type .sTask2.14,STT_OBJECT;
	.byte .sTask2.14[] =
		0x54,0x61,0x73,0x6B,0x32,0x00;
	.align 4;
	.type .sTask.15,STT_OBJECT;
	.byte .sTask.15[] =
		0x54,0x61,0x73,0x6B,0x00;
	.align 8;
	.type .sTestfa.16,STT_OBJECT;
	.byte .sTestfa.16[] =
		0x54,0x65,0x73,0x74,0x20,0x66,0x61,0x69,0x6C,0x65,0x64,0x0A,
		0x00;
	.align 8;
	.type .sTestpa.17,STT_OBJECT;
	.byte .sTestpa.17[] =
		0x54,0x65,0x73,0x74,0x20,0x70,0x61,0x73,0x73,0x65,0x64,0x0A,
		0x00;
