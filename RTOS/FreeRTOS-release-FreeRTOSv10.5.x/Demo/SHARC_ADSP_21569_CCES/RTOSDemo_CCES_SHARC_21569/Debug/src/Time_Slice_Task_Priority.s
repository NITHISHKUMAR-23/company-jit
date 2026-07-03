	.file "..\src\Time_Slice_Task_Priority.c";
//  Compilation time: Wed Oct 23 14:45:04 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\src -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo src\Time_Slice_Task_Priority.d -o src\Time_Slice_Task_Priority.doj
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
// line "..\src\Time_Slice_Task_Priority.c":275
	modify(i7,-4) (nw);
	i4=r4;
	dm(-2,i6)=r12;
	dm(-3,i6)=r8;
	dm(-4,i6)=r4;
.LN0:
// line 284
	i12=xTimerTaskTCB.0.;
	dm(m5,i4)=i12;
.LN1:
// line 287
	i4=dm(-3,i6);
	i12=uxTimerTaskStack.1.;
	dm(m5,i4)=i12;
.LN2:
// line 292
	i4=dm(-2,i6);
	i12=400;
	dm(m5,i4)=i12;
.LN3:
// line 293
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
// line "..\src\Time_Slice_Task_Priority.c":259
	modify(i7,-4) (nw);
	i4=r4;
	dm(-2,i6)=r12;
	dm(-3,i6)=r8;
	dm(-4,i6)=r4;
.LN4:
// line 260
	i12=xIdleTaskTCB.;
	dm(m5,i4)=i12;
.LN5:
// line 261
	i4=dm(-3,i6);
	i12=uxIdleTaskStack.;
	dm(m5,i4)=i12;
.LN6:
// line 262
	i4=dm(-2,i6);
	i12=200;
	dm(m5,i4)=i12;
.LN7:
// line 263
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vApplicationGetIdleTaskMemory..end:
.vApplicationGetIdleTaskMemory..end:
	.global vApplicationGetIdleTaskMemory.;
	.type vApplicationGetIdleTaskMemory.,STT_FUNC;

timeSlicingTask1.:
.LNtimeSlicingTask1.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,i4,i12,acc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "..\src\Time_Slice_Task_Priority.c":129
	modify(i7,-2) (nw);
	dm(-3,i6)=r15;
	dm(-2,i6)=r4;

.P47L1:
//-------------------------------------------------------------------
//   Loop at "..\src\Time_Slice_Task_Priority.c" line 130 col 2
//-------------------------------------------------------------------
.LN8:
// line 130
	r2=dm(task1BurstTime.);                 // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P47L2);

.LN9:
// line 131
	r2=dm(task1BurstTime.);                 // Use of volatile in loops precludes optimizations. 
	r15=2;
	compu(r2,r15);
	if le jump (pc,.P47L5);

.LN10:
// line 132
	r2=.sTask1i.2;
	dm(i7,m7)=r15;
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
	modify(i7,2) (nw);
.LN11:
// line 133
	r2=.s.3;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
	modify(i7,2) (nw);
.LN12:
// line 134
	i4=dm(task1BurstTime.);                 // Use of volatile in loops precludes optimizations. 
	i4=modify(i4,-2);
	dm(task1BurstTime.)=i4;                 // Use of volatile in loops precludes optimizations. 
.LN13:
// line 135
	jump (pc,.P47L6);

.P47L5:
.LN14:
// line 136
	r2=dm(task1BurstTime.);                 // Use of volatile in loops precludes optimizations. 
.LN15:
	r1=.sTask1i.4;
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
	modify(i7,2) (nw);
.LN16:
// line 137
	r2=.s.3;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
	modify(i7,2) (nw);
.LN17:
// line 138
	dm(task1BurstTime.)=m5;                 // Use of volatile in loops precludes optimizations. 

.P47L6:
.LN18:
// line 141
	r4=2;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
	jump (pc,.P47L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P47L2:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN19:
// line 143
	r15=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.timeSlicingTask1..end:
.timeSlicingTask1..end:
	.global timeSlicingTask1.;
	.type timeSlicingTask1.,STT_FUNC;

timeSlicingTask2.:
.LNtimeSlicingTask2.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,i4,i12,acc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "..\src\Time_Slice_Task_Priority.c":147
	modify(i7,-2) (nw);
	dm(-3,i6)=r15;
	dm(-2,i6)=r4;

.P52L1:
//-------------------------------------------------------------------
//   Loop at "..\src\Time_Slice_Task_Priority.c" line 148 col 5
//-------------------------------------------------------------------
.LN20:
// line 148
	r2=dm(task2BurstTime.);                 // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P52L2);

.LN21:
// line 149
	r2=dm(task2BurstTime.);                 // Use of volatile in loops precludes optimizations. 
	r15=2;
	compu(r2,r15);
	if le jump (pc,.P52L5);

.LN22:
// line 150
	r2=.sTask2i.5;
	dm(i7,m7)=r15;
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
	modify(i7,2) (nw);
.LN23:
// line 151
	r2=.s.3;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
	modify(i7,2) (nw);
.LN24:
// line 152
	i4=dm(task2BurstTime.);                 // Use of volatile in loops precludes optimizations. 
	i4=modify(i4,-2);
	dm(task2BurstTime.)=i4;                 // Use of volatile in loops precludes optimizations. 
.LN25:
// line 153
	jump (pc,.P52L6);

.P52L5:
.LN26:
// line 154
	r2=dm(task2BurstTime.);                 // Use of volatile in loops precludes optimizations. 
.LN27:
	r1=.sTask2i.6;
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
	modify(i7,2) (nw);
.LN28:
// line 155
	r2=.s.3;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
	modify(i7,2) (nw);
.LN29:
// line 156
	dm(task2BurstTime.)=m5;                 // Use of volatile in loops precludes optimizations. 

.P52L6:
.LN30:
// line 159
	r4=2;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ9-1;
.LCJ9:
	jump (pc,.P52L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P52L2:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN31:
// line 163
	r15=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.timeSlicingTask2..end:
.timeSlicingTask2..end:
	.global timeSlicingTask2.;
	.type timeSlicingTask2.,STT_FUNC;

priorityTaskHigh.:
.LNpriorityTaskHigh.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,r4,i12,m4,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "..\src\Time_Slice_Task_Priority.c":166
	modify(i7,-4) (nw);
	dm(-4,i6)=r4;
.LN32:
// line 167
	m4=-9;
	dm(m4,i6)=m13 (bw);
.LN33:
// line 168
	i12=5;
	dm(-2,i6)=i12;

.P54L1:
//-------------------------------------------------------------------
//   Loop at "..\src\Time_Slice_Task_Priority.c" line 169 col 5
//-------------------------------------------------------------------
.LN34:
// line 169
	r2=dm(-2,i6);
	r2=pass r2;
	if eq jump (pc,.P54L2);

.LN35:
// line 171
	r2=.sHighpr.7;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ10-1;
.LCJ10:
	modify(i7,2) (nw);
.LN36:
// line 172
	r4=2;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ11-1;
.LCJ11:
.LN37:
// line 173
	r2=dm(-9,i6) (bw);
	r1=5;
	comp(r2,r1);
	if ne jump (pc,.P54L5);

.LN38:
// line 175
	r4=m5;
	cjump vTaskDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ12-1;
.LCJ12:
.LN39:
// line 176
	jump (pc,.P54L6);

.P54L5:

.P54L6:
.LN40:
// line 177
	r2=dm(-9,i6) (bw);
	r2=r2+1;
	dm(-9,i6)=r2 (bw);
.LN41:
// line 178
	r2=dm(-2,i6);
	r2=r2-1;
	dm(-2,i6)=r2;
	jump (pc,.P54L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P54L2:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN42:
// line 180
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.priorityTaskHigh..end:
.priorityTaskHigh..end:
	.global priorityTaskHigh.;
	.type priorityTaskHigh.,STT_FUNC;

priorityTaskLow.:
.LNpriorityTaskLow.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,r4,i12,m4,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "..\src\Time_Slice_Task_Priority.c":184
	modify(i7,-4) (nw);
	dm(-4,i6)=r4;
.LN43:
// line 185
	m4=-9;
	dm(m4,i6)=m13 (bw);
.LN44:
// line 186
	i12=5;
	dm(-2,i6)=i12;

.P57L1:
//-------------------------------------------------------------------
//   Loop at "..\src\Time_Slice_Task_Priority.c" line 187 col 5
//-------------------------------------------------------------------
.LN45:
// line 187
	r2=dm(-2,i6);
	r2=pass r2;
	if eq jump (pc,.P57L2);

.LN46:
// line 189
	r2=.sLowpri.8;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ13-1;
.LCJ13:
	modify(i7,2) (nw);
.LN47:
// line 190
	r4=m6;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ14-1;
.LCJ14:
.LN48:
// line 191
	r2=dm(-9,i6) (bw);
	r1=5;
	comp(r2,r1);
	if ne jump (pc,.P57L5);

.LN49:
// line 193
	r4=m5;
	cjump vTaskDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ15-1;
.LCJ15:
.LN50:
// line 194
	jump (pc,.P57L6);

.P57L5:

.P57L6:
.LN51:
// line 195
	r2=dm(-9,i6) (bw);
	r2=r2+1;
	dm(-9,i6)=r2 (bw);
.LN52:
// line 196
	r2=dm(-2,i6);
	r2=r2-1;
	dm(-2,i6)=r2;
	jump (pc,.P57L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P57L2:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN53:
// line 198
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.priorityTaskLow..end:
.priorityTaskLow..end:
	.global priorityTaskLow.;
	.type priorityTaskLow.,STT_FUNC;

prvSetupHardware.:
.LNprvSetupHardware.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN54:
// line "..\src\Time_Slice_Task_Priority.c":302
	cjump vParTestInitialise. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ16-1;
.LCJ16:
.LN55:
// line 303
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
//  Call preserved registers used: {r11,r14-r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "..\src\Time_Slice_Task_Priority.c":204
	modify(i7,-2) (nw);
	dm(-2,i6)=r8;
	dm(-3,i6)=r4;
.LN56:
// line 206
	cjump adi_initComponents. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ17-1;
.LCJ17:
.LN57:
// line 209
	cjump prvSetupHardware. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ18-1;
.LCJ18:
.LN58:
// line 212
	r4=m6;
	cjump vStartLEDFlashTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ19-1;
.LCJ19:
.LN59:
// line 213
	r15=2;
	r4=2;
	cjump vStartPolledQueueTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ20-1;
.LCJ20:
.LN60:
// line 214
	cjump vStartRecursiveMutexTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ21-1;
.LCJ21:
.LN61:
// line 215
	r14=3;
	r4=3;
	cjump vStartBlockingQueueTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ22-1;
.LCJ22:
.LN62:
// line 216
	cjump vStartStaticallyAllocatedTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ23-1;
.LCJ23:
.LN63:
// line 221
	r2=4;
	r12=250;
	r8=.sCheck.9;
	r4=vCheckTask.;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=r2;
	dm(i7,m7)=m13;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ24-1;
.LCJ24:
	modify(i7,4) (nw);
.LN64:
// line 225
	r4=3;
	cjump vCreateSuicidalTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ25-1;
.LCJ25:
.LN65:
// line 228
	r8=.sTimeSl.10;
	r4=timeSlicingTask1.;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=m14;
	dm(i7,m7)=m13;
	r12=200;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ26-1;
.LCJ26:
	modify(i7,4) (nw);
.LN66:
// line 229
	r8=.sTimeSl.11;
	r4=timeSlicingTask2.;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=m14;
	dm(i7,m7)=m13;
	r12=200;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ27-1;
.LCJ27:
	modify(i7,4) (nw);
.LN67:
// line 232
	r11=task.;
	r8=.sLowPri.12;
	r4=priorityTaskLow.;
	modify(i7,m7) (nw);
	dm(i7,m7)=r11;
	dm(i7,m7)=r15;
	dm(i7,m7)=m13;
	r12=200;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ28-1;
.LCJ28:
	modify(i7,4) (nw);
.LN68:
// line 233
	r8=.sHighPr.13;
	r4=priorityTaskHigh.;
	modify(i7,m7) (nw);
	dm(i7,m7)=r11;
	dm(i7,m7)=r14;
	dm(i7,m7)=m13;
	r12=200;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ29-1;
.LCJ29:
	modify(i7,4) (nw);
.LN69:
// line 236
	cjump vTaskStartScheduler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ30-1;
.LCJ30:

.P65L1:
//-------------------------------------------------------------------
//   Loop at "..\src\Time_Slice_Task_Priority.c" line 242 col 5
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
	jump (pc,.P65L1);
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
// line "..\src\Time_Slice_Task_Priority.c":308
	modify(i7,-2) (nw);
	dm(-2,i6)=r15;
.LN70:
// line 309
	cjump xAreBlockingQueuesStillRunning. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ31-1;
.LCJ31:
	r15=m5;
	r2=btgl r0 by r15;
.LN71:
	if sz jump (pc,.P76L2);

.LN72:
// line 311
	r2=dm(ulErrorFlags.);
	r2=bset r2 by r15;
	dm(ulErrorFlags.)=r2;
.LN73:
// line 312
	jump (pc,.P76L3);

.P76L2:

.P76L3:
.LN74:
// line 314
	cjump xArePollingQueuesStillRunning. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ32-1;
.LCJ32:
	r2=btgl r0 by r15;
.LN75:
	if sz jump (pc,.P76L5);

.LN76:
// line 316
	r2=dm(ulErrorFlags.);
	r1=m6;
	r2=bset r2 by r1;
	dm(ulErrorFlags.)=r2;
.LN77:
// line 317
	jump (pc,.P76L6);

.P76L5:

.P76L6:
.LN78:
// line 319
	cjump xIsCreateTaskStillRunning. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ33-1;
.LCJ33:
	r2=btgl r0 by r15;
.LN79:
	if sz jump (pc,.P76L8);

.LN80:
// line 321
	r2=dm(ulErrorFlags.);
	r1=2;
	r2=bset r2 by r1;
	dm(ulErrorFlags.)=r2;
.LN81:
// line 322
	jump (pc,.P76L9);

.P76L8:

.P76L9:
.LN82:
// line 324
	cjump xAreRecursiveMutexTasksStillRunning. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ34-1;
.LCJ34:
	r2=btgl r0 by r15;
.LN83:
	if sz jump (pc,.P76L11);

.LN84:
// line 326
	r2=dm(ulErrorFlags.);
	r1=3;
	r2=bset r2 by r1;
	dm(ulErrorFlags.)=r2;
.LN85:
// line 327
	jump (pc,.P76L12);

.P76L11:

.P76L12:
.LN86:
// line 329
	cjump xAreStaticAllocationTasksStillRunning. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ35-1;
.LCJ35:
	r2=btgl r0 by r15;
.LN87:
	if sz jump (pc,.P76L14);

.LN88:
// line 331
	r2=dm(ulErrorFlags.);
	r1=4;
	r2=bset r2 by r1;
	dm(ulErrorFlags.)=r2;
.LN89:
// line 332
	jump (pc,.P76L15);

.P76L14:

.P76L15:
.LN90:
// line 333
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
// line "..\src\Time_Slice_Task_Priority.c":338
	modify(i7,-2) (nw);
	dm(-2,i6)=r8;
	dm(-3,i6)=r4;
.LN91:
// line 345
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ36-1;
.LCJ36:

.P82L1:
//-------------------------------------------------------------------
//   Loop at "..\src\Time_Slice_Task_Priority.c" line 346 col 2
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
	jump (pc,.P82L1);
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
// line "..\src\Time_Slice_Task_Priority.c":355
	modify(i7,-2) (nw);
	dm(-2,i6)=r8;
	dm(-3,i6)=r4;
.LN92:
// line 359
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ37-1;
.LCJ37:

.P84L1:
//-------------------------------------------------------------------
//   Loop at "..\src\Time_Slice_Task_Priority.c" line 360 col 5
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
.LN93:
// line 362
	nop;
	jump (pc,.P84L1);
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
.LN94:
// line "..\src\Time_Slice_Task_Priority.c":371
	r2=dm(ulErrorFlags.);
	r2=pass r2;
	if eq jump (pc,.P87L2);

.LN95:
// line 373
	r2=.sTestfa.14;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ38-1;
.LCJ38:
	modify(i7,2) (nw);
.LN96:
// line 374
	dm(ulErrorFlags.)=m5;
.LN97:
// line 375
	jump (pc,.P87L3);

.P87L2:
.LN98:
// line 378
	r2=.sTestpa.15;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump _printf32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ39-1;
.LCJ39:
	modify(i7,2) (nw);

.P87L3:
.LN99:
// line 380
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
//  Original Loop at "..\src\Time_Slice_Task_Priority.c" line 393 col 9 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
// line "..\src\Time_Slice_Task_Priority.c":385
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN100:
// line 388
	cjump xTaskGetTickCount. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ40-1;
.LCJ40:
.LN101:
	dm(-2,i6)=r0;

.P72L1:
//-------------------------------------------------------------------
//   Loop at "..\src\Time_Slice_Task_Priority.c" line 390 col 5
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
.LN102:
// line 393
	i4=modify(i6,-2) (nw);
	r8=5000;
	r4=i4;
	cjump xTaskDelayUntil. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ41-1;
.LCJ41:

.LN103:
// line 396
	cjump prvCheckOtherTasksAreStillRunning. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ42-1;
.LCJ42:
.LN104:
// line 399
	cjump prvPrintInformation. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ43-1;
.LCJ43:
	jump (pc,.P72L1);
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
	.file_attr FuncName="timeSlicingTask1.";
	.file_attr FuncName="timeSlicingTask2.";
	.file_attr FuncName="priorityTaskHigh.";
	.file_attr FuncName="priorityTaskLow.";
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
	.extern vTaskDelete.;
	.type vTaskDelete.,STT_FUNC;
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
	.byte xIdleTaskTCB.[96];
	.type xIdleTaskTCB.,STT_OBJECT;
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
	.inc/binary ".\src\Time_Slice_Task_Priority.sbn", 0, 309;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x4F,0x20,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x2E,0x2E,0x5C,0x73,0x72,0x63,0x5C,0x54,0x69,0x6D,
		0x65,0x5F,0x53,0x6C,0x69,0x63,0x65,0x5F,0x54,0x61,0x73,0x6B,
		0x5F,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x2E,0x63,0x00,
		0x0C;
	.var = .epcline;
	.inc/binary ".\src\Time_Slice_Task_Priority.sbn", 309, 6742;
	.var = .LNvApplicationGetTimerTaskMemory.;
	.var = .LN.vApplicationGetTimerTaskMemory..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x70,0x78,0x54,0x69,0x6D,0x65,0x72,
		0x54,0x61,0x73,0x6B,0x54,0x43,0x42,0x42,0x75,0x66,0x66,0x65,
		0x72,0x00,0x65,0x1B,0x00,0x00,0x02,0x86,0x70,0x00,0x14,0x70,
		0x70,0x78,0x54,0x69,0x6D,0x65,0x72,0x54,0x61,0x73,0x6B,0x53,
		0x74,0x61,0x63,0x6B,0x42,0x75,0x66,0x66,0x65,0x72,0x00,0x59,
		0x1B,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x70,0x75,0x6C,0x54,
		0x69,0x6D,0x65,0x72,0x54,0x61,0x73,0x6B,0x53,0x74,0x61,0x63,
		0x6B,0x53,0x69,0x7A,0x65,0x00,0x53,0x1B,0x00,0x00,0x02,0x86,
		0x78,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.vApplicationGetTimerTaskMemory..end;
	.byte =
		0x16,0x78,0x54,0x69,0x6D,0x65,0x72,0x54,0x61,0x73,0x6B,0x54,
		0x43,0x42,0x00,0x01,0x32,0x11,0x00,0x00,0x05,0x03;
	.var = xTimerTaskTCB.0.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x75,0x78,0x54,0x69,0x6D,0x65,
		0x72,0x54,0x61,0x73,0x6B,0x53,0x74,0x61,0x63,0x6B,0x00,0x01,
		0x43,0x1B,0x00,0x00,0x05,0x03;
	.var = uxTimerTaskStack.1.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x08,0x53,0x1B,0x00,0x00,
		0xCE,0x0C,0x00,0x00,0x09,0x90,0x03,0x00,0x8F,0x03,0x00,0x07,
		0x00,0x51,0x06,0x00,0x00,0x07,0x00,0x42,0x18,0x00,0x00,0x07,
		0x00,0x32,0x11,0x00,0x00,0x07,0x00,0x5F,0x1B,0x00,0x00,0x13,
		0x05,0x1C,0x00,0x00,0x76,0x41,0x70,0x70,0x6C,0x69,0x63,0x61,
		0x74,0x69,0x6F,0x6E,0x47,0x65,0x74,0x49,0x64,0x6C,0x65,0x54,
		0x61,0x73,0x6B,0x4D,0x65,0x6D,0x6F,0x72,0x79,0x00,0x01;
	.var = .LNvApplicationGetIdleTaskMemory.;
	.var = .LN.vApplicationGetIdleTaskMemory..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x70,0x78,0x49,0x64,0x6C,0x65,0x54,
		0x61,0x73,0x6B,0x54,0x43,0x42,0x42,0x75,0x66,0x66,0x65,0x72,
		0x00,0x65,0x1B,0x00,0x00,0x02,0x86,0x70,0x00,0x14,0x70,0x70,
		0x78,0x49,0x64,0x6C,0x65,0x54,0x61,0x73,0x6B,0x53,0x74,0x61,
		0x63,0x6B,0x42,0x75,0x66,0x66,0x65,0x72,0x00,0x59,0x1B,0x00,
		0x00,0x02,0x86,0x74,0x00,0x14,0x70,0x75,0x6C,0x49,0x64,0x6C,
		0x65,0x54,0x61,0x73,0x6B,0x53,0x74,0x61,0x63,0x6B,0x53,0x69,
		0x7A,0x65,0x00,0x53,0x1B,0x00,0x00,0x02,0x86,0x78,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN4;
	.var = .LN.vApplicationGetIdleTaskMemory..end;
	.byte =
		0x00,0x00,0x13,0x4C,0x1C,0x00,0x00,0x74,0x69,0x6D,0x65,0x53,
		0x6C,0x69,0x63,0x69,0x6E,0x67,0x54,0x61,0x73,0x6B,0x31,0x00,
		0x01;
	.var = .LNtimeSlicingTask1.;
	.var = .LN.timeSlicingTask1..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xAE,0x03,0x00,0x00,0x02,0x86,0x78,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN8;
	.var = .LN.timeSlicingTask1..end;
	.byte =
		0x00,0x00,0x13,0x93,0x1C,0x00,0x00,0x74,0x69,0x6D,0x65,0x53,
		0x6C,0x69,0x63,0x69,0x6E,0x67,0x54,0x61,0x73,0x6B,0x32,0x00,
		0x01;
	.var = .LNtimeSlicingTask2.;
	.var = .LN.timeSlicingTask2..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xAE,0x03,0x00,0x00,0x02,0x86,0x78,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN20;
	.var = .LN.timeSlicingTask2..end;
	.byte =
		0x00,0x00,0x13,0x02,0x1D,0x00,0x00,0x70,0x72,0x69,0x6F,0x72,
		0x69,0x74,0x79,0x54,0x61,0x73,0x6B,0x48,0x69,0x67,0x68,0x00,
		0x01;
	.var = .LNpriorityTaskHigh.;
	.var = .LN.priorityTaskHigh..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xAE,0x03,0x00,0x00,0x02,0x86,0x70,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN32;
	.var = .LN.priorityTaskHigh..end;
	.byte =
		0x16,0x69,0x00,0x01,0x34,0x06,0x00,0x00,0x02,0x86,0x77;
	.var = .LN32-.LNpriorityTaskHigh.;
	.byte =
		0x00,0x16,0x65,0x78,0x65,0x63,0x75,0x74,0x69,0x6F,0x6E,0x00,
		0x01,0x25,0x02,0x00,0x00,0x02,0x86,0x78;
	.var = .LN33-.LNpriorityTaskHigh.;
	.byte =
		0x00,0x00,0x00,0x13,0x70,0x1D,0x00,0x00,0x70,0x72,0x69,0x6F,
		0x72,0x69,0x74,0x79,0x54,0x61,0x73,0x6B,0x4C,0x6F,0x77,0x00,
		0x01;
	.var = .LNpriorityTaskLow.;
	.var = .LN.priorityTaskLow..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xAE,0x03,0x00,0x00,0x02,0x86,0x70,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN43;
	.var = .LN.priorityTaskLow..end;
	.byte =
		0x16,0x69,0x00,0x01,0x34,0x06,0x00,0x00,0x02,0x86,0x77;
	.var = .LN43-.LNpriorityTaskLow.;
	.byte =
		0x00,0x16,0x65,0x78,0x65,0x63,0x75,0x74,0x69,0x6F,0x6E,0x00,
		0x01,0x25,0x02,0x00,0x00,0x02,0x86,0x78;
	.var = .LN44-.LNpriorityTaskLow.;
	.byte =
		0x00,0x00,0x00,0x13,0xA1,0x1D,0x00,0x00,0x70,0x72,0x76,0x53,
		0x65,0x74,0x75,0x70,0x48,0x61,0x72,0x64,0x77,0x61,0x72,0x65,
		0x00,0x01;
	.var = .LNprvSetupHardware.;
	.var = .LN.prvSetupHardware..end;
	.byte =
		0x01,0x00,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN54;
	.var = .LN.prvSetupHardware..end;
	.byte =
		0x00,0x00,0x17,0xE6,0x1D,0x00,0x00,0x6D,0x61,0x69,0x6E,0x00,
		0x01;
	.var = .LNmain.;
	.var = .LN.main..end;
	.byte =
		0x01,0x25,0x02,0x00,0x00,0x01,0x00,0x14,0x61,0x72,0x67,0x63,
		0x00,0x25,0x02,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x61,0x72,
		0x67,0x76,0x00,0xE6,0x1D,0x00,0x00,0x02,0x86,0x78,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN56;
	.var = .LN.main..end;
	.byte =
		0x00,0x00,0x07,0x00,0x96,0x05,0x00,0x00,0x13,0x2E,0x1E,0x00,
		0x00,0x70,0x72,0x76,0x43,0x68,0x65,0x63,0x6B,0x4F,0x74,0x68,
		0x65,0x72,0x54,0x61,0x73,0x6B,0x73,0x41,0x72,0x65,0x53,0x74,
		0x69,0x6C,0x6C,0x52,0x75,0x6E,0x6E,0x69,0x6E,0x67,0x00,0x01;
	.var = .LNprvCheckOtherTasksAreStillRunning.;
	.var = .LN.prvCheckOtherTasksAreStillRunning..end;
	.byte =
		0x01,0x00,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN70;
	.var = .LN.prvCheckOtherTasksAreStillRunning..end;
	.byte =
		0x00,0x00,0x13,0x8F,0x1E,0x00,0x00,0x76,0x41,0x70,0x70,0x6C,
		0x69,0x63,0x61,0x74,0x69,0x6F,0x6E,0x53,0x74,0x61,0x63,0x6B,
		0x4F,0x76,0x65,0x72,0x66,0x6C,0x6F,0x77,0x48,0x6F,0x6F,0x6B,
		0x00,0x01;
	.var = .LNvApplicationStackOverflowHook.;
	.var = .LN.vApplicationStackOverflowHook..end;
	.byte =
		0x01,0x01,0x00,0x14,0x78,0x54,0x61,0x73,0x6B,0x00,0xDA,0x15,
		0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x70,0x63,0x54,0x61,0x73,
		0x6B,0x4E,0x61,0x6D,0x65,0x00,0x96,0x05,0x00,0x00,0x02,0x86,
		0x78,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN91;
	.var = .LN.vApplicationStackOverflowHook..end;
	.byte =
		0x00,0x00,0x13,0xDD,0x1E,0x00,0x00,0x76,0x41,0x73,0x73,0x65,
		0x72,0x74,0x43,0x61,0x6C,0x6C,0x65,0x64,0x00,0x01;
	.var = .LNvAssertCalled.;
	.var = .LN.vAssertCalled..end;
	.byte =
		0x01,0x01,0x00,0x14,0x70,0x63,0x46,0x69,0x6C,0x65,0x00,0xEC,
		0x17,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x75,0x6C,0x4C,0x69,
		0x6E,0x65,0x00,0x66,0x02,0x00,0x00,0x02,0x86,0x78,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN92;
	.var = .LN.vAssertCalled..end;
	.byte =
		0x00,0x00,0x13,0x11,0x1F,0x00,0x00,0x70,0x72,0x76,0x50,0x72,
		0x69,0x6E,0x74,0x49,0x6E,0x66,0x6F,0x72,0x6D,0x61,0x74,0x69,
		0x6F,0x6E,0x00,0x01;
	.var = .LNprvPrintInformation.;
	.var = .LN.prvPrintInformation..end;
	.byte =
		0x01,0x00,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN94;
	.var = .LN.prvPrintInformation..end;
	.byte =
		0x00,0x00,0x13,0x73,0x1F,0x00,0x00,0x76,0x43,0x68,0x65,0x63,
		0x6B,0x54,0x61,0x73,0x6B,0x00,0x01;
	.var = .LNvCheckTask.;
	.var = .LN.vCheckTask..end;
	.byte =
		0x01,0x00,0x00,0x14,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xAE,0x03,0x00,0x00,0x02,0x86,0x74,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN100;
	.var = .LN.vCheckTask..end;
	.byte =
		0x16,0x78,0x4C,0x61,0x73,0x74,0x45,0x78,0x65,0x63,0x75,0x74,
		0x69,0x6F,0x6E,0x54,0x69,0x6D,0x65,0x00,0x01,0x03,0x0D,0x00,
		0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,
		0x74,0x61,0x73,0x6B,0x00,0x01,0xDA,0x15,0x00,0x00,0x05,0x03;
	.var = task.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x74,0x61,0x73,0x6B,0x32,0x00,
		0x01,0xDA,0x15,0x00,0x00,0x05,0x03;
	.var = task2.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x74,0x61,0x73,0x6B,0x31,0x42,
		0x75,0x72,0x73,0x74,0x54,0x69,0x6D,0x65,0x00,0x01,0x4D,0x20,
		0x00,0x00,0x05,0x03;
	.var = task1BurstTime.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x74,0x61,0x73,0x6B,0x32,0x42,
		0x75,0x72,0x73,0x74,0x54,0x69,0x6D,0x65,0x00,0x01,0x4D,0x20,
		0x00,0x00,0x05,0x03;
	.var = task2BurstTime.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x75,0x6C,0x45,0x72,0x72,0x6F,
		0x72,0x46,0x6C,0x61,0x67,0x73,0x00,0x01,0x3C,0x02,0x00,0x00,
		0x05,0x03;
	.var = ulErrorFlags.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x78,0x49,0x64,0x6C,0x65,0x54,
		0x61,0x73,0x6B,0x54,0x43,0x42,0x00,0x01,0x32,0x11,0x00,0x00,
		0x05,0x03;
	.var = xIdleTaskTCB.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x75,0x78,0x49,0x64,0x6C,0x65,
		0x54,0x61,0x73,0x6B,0x53,0x74,0x61,0x63,0x6B,0x00,0x01,0x3D,
		0x20,0x00,0x00,0x05,0x03;
	.var = uxIdleTaskStack.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x08,0x4D,0x20,0x00,0x00,0xCE,0x0C,
		0x00,0x00,0x09,0xC8,0x01,0x00,0xC7,0x01,0x00,0x0F,0x51,0x06,
		0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\src\Time_Slice_Task_Priority.sbn", 7051, 2143;
	.var = .LNvApplicationGetTimerTaskMemory.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x92,0x02,0x01,0x00,0x05,0x02;
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
		0x04,0x01,0x05,0x01,0x03,0x82,0x02,0x01,0x00,0x05,0x02;
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
	.var = .LNtimeSlicingTask1.;
	.byte =
		0x04,0x01,0x05,0x01,0x89,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x0A,0x0A,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x14,0x0A,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x0E,0x0A,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x0A,0x0A,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x0E,0x0A,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x14,0x01,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x0E,0x0A,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x14,0x0C,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN.timeSlicingTask1..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNtimeSlicingTask2.;
	.byte =
		0x04,0x01,0x05,0x01,0x9B,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x0A,0x0A,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x14,0x0A,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x0E,0x0A,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x05,0x0A,0x0A,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x0E,0x0A,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x05,0x14,0x01,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x0E,0x0A,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x05,0x14,0x0C,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x05,0x01,0x0D,0x00,0x05,0x02;
	.var = .LN.timeSlicingTask2..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNpriorityTaskHigh.;
	.byte =
		0x04,0x01,0x05,0x01,0xAE,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x0F,0x0B,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x13,0x0A,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x05,0x18,0x0B,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN.priorityTaskHigh..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNpriorityTaskLow.;
	.byte =
		0x04,0x01,0x05,0x01,0xC0,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN46;
	.byte =
		0x05,0x0F,0x0B,0x00,0x05,0x02;
	.var = .LN47;
	.byte =
		0x05,0x13,0x0A,0x00,0x05,0x02;
	.var = .LN48;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN49;
	.byte =
		0x05,0x18,0x0B,0x00,0x05,0x02;
	.var = .LN50;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN51;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN52;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN53;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN.priorityTaskLow..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvSetupHardware.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xAB,0x02,0x01,0x00,0x05,0x02;
	.var = .LN54;
	.byte =
		0x05,0x17,0x0B,0x00,0x05,0x02;
	.var = .LN55;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvSetupHardware..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNmain.;
	.byte =
		0x04,0x01,0x05,0x01,0xD4,0x00,0x05,0x02;
	.var = .LN56;
	.byte =
		0x05,0x14,0x0B,0x00,0x05,0x02;
	.var = .LN57;
	.byte =
		0x05,0x15,0x0C,0x00,0x05,0x02;
	.var = .LN58;
	.byte =
		0x05,0x18,0x0C,0x00,0x05,0x02;
	.var = .LN59;
	.byte =
		0x05,0x1B,0x0A,0x00,0x05,0x02;
	.var = .LN60;
	.byte =
		0x05,0x1E,0x0A,0x00,0x05,0x02;
	.var = .LN61;
	.byte =
		0x05,0x1D,0x0A,0x00,0x05,0x02;
	.var = .LN62;
	.byte =
		0x05,0x23,0x0A,0x00,0x05,0x02;
	.var = .LN63;
	.byte =
		0x05,0x10,0x0E,0x00,0x05,0x02;
	.var = .LN64;
	.byte =
		0x05,0x19,0x0D,0x00,0x05,0x02;
	.var = .LN65;
	.byte =
		0x05,0x14,0x0C,0x00,0x05,0x02;
	.var = .LN66;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN67;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN68;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN69;
	.byte =
		0x05,0x18,0x0C,0x00,0x05,0x02;
	.var = .LN.main..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvCheckOtherTasksAreStillRunning.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xB3,0x02,0x01,0x00,0x05,0x02;
	.var = .LN70;
	.byte =
		0x05,0x27,0x0A,0x00,0x05,0x02;
	.var = .LN71;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN72;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN73;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN74;
	.byte =
		0x05,0x27,0x0B,0x00,0x05,0x02;
	.var = .LN75;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN76;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN77;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN78;
	.byte =
		0x05,0x22,0x0B,0x00,0x05,0x02;
	.var = .LN79;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN80;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN81;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN82;
	.byte =
		0x05,0x2C,0x0B,0x00,0x05,0x02;
	.var = .LN83;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN84;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN85;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN86;
	.byte =
		0x05,0x2E,0x0B,0x00,0x05,0x02;
	.var = .LN87;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN88;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN89;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN90;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvCheckOtherTasksAreStillRunning..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvApplicationStackOverflowHook.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xD1,0x02,0x01,0x00,0x05,0x02;
	.var = .LN91;
	.byte =
		0x05,0x02,0x10,0x00,0x05,0x02;
	.var = .LN.vApplicationStackOverflowHook..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvAssertCalled.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xE2,0x02,0x01,0x00,0x05,0x02;
	.var = .LN92;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN93;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN.vAssertCalled..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvPrintInformation.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xF1,0x02,0x01,0x00,0x05,0x02;
	.var = .LN94;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN95;
	.byte =
		0x05,0x0F,0x0B,0x00,0x05,0x02;
	.var = .LN96;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN97;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN98;
	.byte =
		0x05,0x0F,0x0C,0x00,0x05,0x02;
	.var = .LN99;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN.prvPrintInformation..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvCheckTask.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x80,0x03,0x01,0x00,0x05,0x02;
	.var = .LN100;
	.byte =
		0x05,0x2B,0x0C,0x00,0x05,0x02;
	.var = .LN101;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN102;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN103;
	.byte =
		0x05,0x2A,0x0C,0x00,0x05,0x02;
	.var = .LN104;
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
		0x1C,0x01,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.inc/binary ".\src\Time_Slice_Task_Priority.sbn", 9194, 278;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x7C,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNvApplicationGetTimerTaskMemory.;
	.var = .LN.vApplicationGetTimerTaskMemory..end-.LNvApplicationGetTimerTaskMemory.;
	.var = .LNvApplicationGetIdleTaskMemory.;
	.var = .LN.vApplicationGetIdleTaskMemory..end-.LNvApplicationGetIdleTaskMemory.;
	.var = .LNtimeSlicingTask1.;
	.var = .LN.timeSlicingTask1..end-.LNtimeSlicingTask1.;
	.var = .LNtimeSlicingTask2.;
	.var = .LN.timeSlicingTask2..end-.LNtimeSlicingTask2.;
	.var = .LNpriorityTaskHigh.;
	.var = .LN.priorityTaskHigh..end-.LNpriorityTaskHigh.;
	.var = .LNpriorityTaskLow.;
	.var = .LN.priorityTaskLow..end-.LNpriorityTaskLow.;
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
	.global task.;
	.type task.,STT_OBJECT;
	.byte task.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.global task2.;
	.type task2.,STT_OBJECT;
	.byte task2.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.global task1BurstTime.;
	.type task1BurstTime.,STT_OBJECT;
	.byte task1BurstTime.[] =
		0x08,0x00,0x00,0x00;
	.align 4;
	.global task2BurstTime.;
	.type task2BurstTime.,STT_OBJECT;
	.byte task2BurstTime.[] =
		0x0A,0x00,0x00,0x00;
	.align 4;
	.type ulErrorFlags.,STT_OBJECT;
	.byte ulErrorFlags.[] =
		0x00,0x00,0x00,0x00;
	.align 8;
	.type .sTask1i.2,STT_OBJECT;
	.byte .sTask1i.2[] =
		0x54,0x61,0x73,0x6B,0x20,0x31,0x20,0x69,0x73,0x20,0x72,0x75,
		0x6E,0x6E,0x69,0x6E,0x67,0x20,0x66,0x6F,0x72,0x20,0x25,0x64,
		0x20,0x6D,0x73,0x2E,0x0A,0x00;
	.align 4;
	.type .s.3,STT_OBJECT;
	.byte .s.3[] =
		0x0A,0x00;
	.align 8;
	.type .sTask1i.4,STT_OBJECT;
	.byte .sTask1i.4[] =
		0x54,0x61,0x73,0x6B,0x20,0x31,0x20,0x69,0x73,0x20,0x72,0x75,
		0x6E,0x6E,0x69,0x6E,0x67,0x20,0x66,0x6F,0x72,0x20,0x25,0x64,
		0x20,0x6D,0x73,0x20,0x28,0x66,0x69,0x6E,0x61,0x6C,0x20,0x62,
		0x75,0x72,0x73,0x74,0x29,0x2E,0x0A,0x00;
	.align 8;
	.type .sTask2i.5,STT_OBJECT;
	.byte .sTask2i.5[] =
		0x54,0x61,0x73,0x6B,0x20,0x32,0x20,0x69,0x73,0x20,0x72,0x75,
		0x6E,0x6E,0x69,0x6E,0x67,0x20,0x66,0x6F,0x72,0x20,0x25,0x64,
		0x20,0x6D,0x73,0x2E,0x0A,0x00;
	.align 8;
	.type .sTask2i.6,STT_OBJECT;
	.byte .sTask2i.6[] =
		0x54,0x61,0x73,0x6B,0x20,0x32,0x20,0x69,0x73,0x20,0x72,0x75,
		0x6E,0x6E,0x69,0x6E,0x67,0x20,0x66,0x6F,0x72,0x20,0x25,0x64,
		0x20,0x6D,0x73,0x20,0x28,0x66,0x69,0x6E,0x61,0x6C,0x20,0x62,
		0x75,0x72,0x73,0x74,0x29,0x2E,0x0A,0x00;
	.align 8;
	.type .sHighpr.7,STT_OBJECT;
	.byte .sHighpr.7[] =
		0x48,0x69,0x67,0x68,0x20,0x70,0x72,0x69,0x6F,0x72,0x69,0x74,
		0x79,0x20,0x74,0x61,0x73,0x6B,0x20,0x72,0x75,0x6E,0x6E,0x69,
		0x6E,0x67,0x0A,0x00;
	.align 8;
	.type .sLowpri.8,STT_OBJECT;
	.byte .sLowpri.8[] =
		0x4C,0x6F,0x77,0x20,0x70,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,
		0x20,0x74,0x61,0x73,0x6B,0x20,0x72,0x75,0x6E,0x6E,0x69,0x6E,
		0x67,0x0A,0x00;
	.align 4;
	.type .sCheck.9,STT_OBJECT;
	.byte .sCheck.9[] =
		0x43,0x68,0x65,0x63,0x6B,0x00;
	.align 8;
	.type .sTimeSl.10,STT_OBJECT;
	.byte .sTimeSl.10[] =
		0x54,0x69,0x6D,0x65,0x53,0x6C,0x69,0x63,0x65,0x31,0x00;
	.align 8;
	.type .sTimeSl.11,STT_OBJECT;
	.byte .sTimeSl.11[] =
		0x54,0x69,0x6D,0x65,0x53,0x6C,0x69,0x63,0x65,0x32,0x00;
	.align 8;
	.type .sLowPri.12,STT_OBJECT;
	.byte .sLowPri.12[] =
		0x4C,0x6F,0x77,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x00;
	.align 8;
	.type .sHighPr.13,STT_OBJECT;
	.byte .sHighPr.13[] =
		0x48,0x69,0x67,0x68,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,
		0x00;
	.align 8;
	.type .sTestfa.14,STT_OBJECT;
	.byte .sTestfa.14[] =
		0x54,0x65,0x73,0x74,0x20,0x66,0x61,0x69,0x6C,0x65,0x64,0x0A,
		0x00;
	.align 8;
	.type .sTestpa.15,STT_OBJECT;
	.byte .sTestpa.15[] =
		0x54,0x65,0x73,0x74,0x20,0x70,0x61,0x73,0x73,0x65,0x64,0x0A,
		0x00;
