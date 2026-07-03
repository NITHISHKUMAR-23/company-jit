	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c";
//  Compilation time: Thu Oct 24 14:40:02 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\FreeRTOS -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\FreeRTOS\tasks.d -o system\FreeRTOS\tasks.doj
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

pvTaskIncrementMutexHeldCount.:
.LNpvTaskIncrementMutexHeldCount.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,r2,i4,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
.LN0:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":4738
	r2=dm(pxCurrentTCB.);
	r2=pass r2;
	if eq jump (pc,.P57L2);

.LN1:
// line 4740
	i4=dm(pxCurrentTCB.);
	r2=dm(19,i4);
	r2=r2+1;
	dm(19,i4)=r2;
.LN2:
// line 4741
	jump (pc,.P57L3);

.P57L2:

.P57L3:
.LN3:
// line 4743
	r0=dm(pxCurrentTCB.);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.pvTaskIncrementMutexHeldCount..end:
.pvTaskIncrementMutexHeldCount..end:
	.global pvTaskIncrementMutexHeldCount.;
	.type pvTaskIncrementMutexHeldCount.,STT_FUNC;

uxTaskResetEventItemValue.:
.LNuxTaskResetEventItemValue.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":4719
	modify(i7,-2) (nw);
.LN4:
// line 4722
	i4=dm(pxCurrentTCB.);
	r2=dm(6,i4);
	dm(-2,i6)=r2;
.LN5:
// line 4726
	i4=dm(pxCurrentTCB.);
	r12=dm(11,i4);
	r8=7;
	r2=r8-r12;
	i4=dm(pxCurrentTCB.);
	dm(6,i4)=r2;
.LN6:
// line 4728
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.uxTaskResetEventItemValue..end:
.uxTaskResetEventItemValue..end:
	.global uxTaskResetEventItemValue.;
	.type uxTaskResetEventItemValue.,STT_FUNC;

xTaskGetSchedulerState.:
.LNxTaskGetSchedulerState.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":4100
	modify(i7,-2) (nw);
.LN7:
// line 4103
	r2=dm(xSchedulerRunning.);
	r2=pass r2;
	if ne jump (pc,.P59L2);

.LN8:
// line 4105
	dm(-2,i6)=m14;
.LN9:
// line 4106
	jump (pc,.P59L3);

.P59L2:
.LN10:
// line 4109
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if ne jump (pc,.P59L5);

.LN11:
// line 4111
	i12=2;
	dm(-2,i6)=i12;
.LN12:
// line 4112
	jump (pc,.P59L6);

.P59L5:
.LN13:
// line 4115
	dm(-2,i6)=m13;

.P59L6:

.P59L3:
.LN14:
// line 4119
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskGetSchedulerState..end:
.xTaskGetSchedulerState..end:
	.global xTaskGetSchedulerState.;
	.type xTaskGetSchedulerState.,STT_FUNC;

xTaskGetCurrentTaskHandle.:
.LNxTaskGetCurrentTaskHandle.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":4083
	modify(i7,-2) (nw);
.LN15:
// line 4089
	r0=dm(pxCurrentTCB.);
	dm(-2,i6)=r0;
.LN16:
// line 4091
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskGetCurrentTaskHandle..end:
.xTaskGetCurrentTaskHandle..end:
	.global xTaskGetCurrentTaskHandle.;
	.type xTaskGetCurrentTaskHandle.,STT_FUNC;

prvResetNextTaskUnblockTime.:
.LNprvResetNextTaskUnblockTime.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,i4,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":4060
	modify(i7,-2) (nw);
.LN17:
// line 4061
	i4=dm(pxDelayedTaskList.);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P61L5);

	dm(-2,i6)=m14;
	jump (pc,.P61L6);

.P61L5:
	dm(-2,i6)=m13;

.P61L6:
	r2=dm(-2,i6);
	r2=pass r2;
	if eq jump (pc,.P61L2);

.LN18:
// line 4067
	dm(xNextTaskUnblockTime.)=m7;
.LN19:
// line 4068
	jump (pc,.P61L3);

.P61L2:
.LN20:
// line 4075
	i4=dm(pxDelayedTaskList.);
	i4=dm(3,i4);
	r2=dm(i4,m5);
	dm(xNextTaskUnblockTime.)=r2;

.P61L3:
.LN21:
// line 4077
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvResetNextTaskUnblockTime..end:
.prvResetNextTaskUnblockTime..end:
	.type prvResetNextTaskUnblockTime.,STT_FUNC;

prvTaskCheckFreeStackSpace.:
.LNprvTaskCheckFreeStackSpace.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0-r2,i4,i12,acc,scc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3919
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN22:
// line 3920
	dm(-2,i6)=m13;

.P62L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 3922 col 9
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 18 
//   cycles (includes 6 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used   9 out of   18 ( 50.0%)
//     pm dag                          used   9 out of   18 ( 50.0%)
//     shift immediate                 used   9 out of   18 ( 50.0%)
//     multifunction alu               used   8 out of   18 ( 44.4%)
//     multifunction float multiply    used   8 out of   18 ( 44.4%)
//     multifunction integer add sub   used   8 out of   18 ( 44.4%)
//     multifunction integer multiply  used   8 out of   18 ( 44.4%)
//     multifunction mult              used   8 out of   18 ( 44.4%)
//     memory access                   used   9 out of   36 ( 25.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN23:
// line 3922
	i4=dm(-3,i6);
	// -- 4 stalls --
	r2=dm(m5,i4) (bw);
	r1=165;
	comp(r2,r1);
	if ne jump (pc,.P62L2);

.LN24:
// line 3924
	r2=dm(-3,i6);
	r2=r2+1;
	dm(-3,i6)=r2;
.LN25:
// line 3925
	r2=dm(-2,i6);
	r2=r2+1;
	dm(-2,i6)=r2;
	jump (pc,.P62L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P62L2:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN26:
// line 3928
	r2=dm(-2,i6);
	r2=lshift r2 by -2;
	r0=fext r2 by 0:16;
	dm(-2,i6)=r2;
.LN27:
// line 3930
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvTaskCheckFreeStackSpace..end:
.prvTaskCheckFreeStackSpace..end:
	.type prvTaskCheckFreeStackSpace.,STT_FUNC;

pvTaskGetThreadLocalStoragePointer.:
.LNpvTaskGetThreadLocalStoragePointer.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0,r2,r4,i4,i12,m4,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3679
	modify(i7,-6) (nw);
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
.LN28:
// line 3680
	dm(-4,i6)=m13;
	r2=pass r8;
.LN29:
// line 3683
	if lt jump (pc,.P63L2);

	r2=m6;
	comp(r8,r2);
	if ge jump (pc,.P63L2);

	r2=pass r4;
.LN30:
// line 3686
	if ne jump (pc,.P63L6);

	r2=dm(pxCurrentTCB.);
	dm(-2,i6)=r2;
	jump (pc,.P63L7);

.P63L6:
	dm(-2,i6)=r4;

.P63L7:
	r2=dm(-2,i6);
	i4=r2;
	dm(-3,i6)=r2;
.LN31:
// line 3687
	i4=modify(i4,84);
	m4=dm(-5,i6);
	r2=dm(m4,i4);
	dm(-4,i6)=r2;
.LN32:
// line 3688
	jump (pc,.P63L3);

.P63L2:
.LN33:
// line 3691
	dm(-4,i6)=m13;

.P63L3:
.LN34:
// line 3694
	r0=dm(-4,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.pvTaskGetThreadLocalStoragePointer..end:
.pvTaskGetThreadLocalStoragePointer..end:
	.global pvTaskGetThreadLocalStoragePointer.;
	.type pvTaskGetThreadLocalStoragePointer.,STT_FUNC;

vTaskSetTaskNumber.:
.LNvTaskSetTaskNumber.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r2,r4,r8,i4,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3464
	modify(i7,-4) (nw);
	dm(-3,i6)=r8;
	dm(-4,i6)=r4;
	r2=pass r4;
.LN35:
// line 3467
	if eq jump (pc,.P64L2);

	i4=r4;
.LN36:
// line 3469
	dm(-2,i6)=r4;
.LN37:
// line 3470
	dm(17,i4)=r8;
.LN38:
// line 3471
	jump (pc,.P64L3);

.P64L2:

.P64L3:
.LN39:
// line 3472
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskSetTaskNumber..end:
.vTaskSetTaskNumber..end:
	.global vTaskSetTaskNumber.;
	.type vTaskSetTaskNumber.,STT_FUNC;

uxTaskGetTaskNumber.:
.LNuxTaskGetTaskNumber.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,i4,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3440
	modify(i7,-4) (nw);
	dm(-4,i6)=r4;
	r2=pass r4;
.LN40:
// line 3444
	if eq jump (pc,.P65L2);

	i4=r4;
.LN41:
// line 3446
	dm(-2,i6)=r4;
.LN42:
// line 3447
	r2=dm(17,i4);
	dm(-3,i6)=r2;
.LN43:
// line 3448
	jump (pc,.P65L3);

.P65L2:
.LN44:
// line 3451
	dm(-3,i6)=m13;

.P65L3:
.LN45:
// line 3454
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.uxTaskGetTaskNumber..end:
.uxTaskGetTaskNumber..end:
	.global uxTaskGetTaskNumber.;
	.type uxTaskGetTaskNumber.,STT_FUNC;

vTaskMissedYield.:
.LNvTaskMissedYield.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
.LN46:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3433
	dm(xYieldPending.)=m6;
.LN47:
// line 3434
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskMissedYield..end:
.vTaskMissedYield..end:
	.global vTaskMissedYield.;
	.type vTaskMissedYield.,STT_FUNC;

vTaskInternalSetTimeOutState.:
.LNvTaskInternalSetTimeOutState.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,i4,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3359
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;
.LN48:
// line 3361
	r2=dm(xNumOfOverflows.);
	i4=dm(-2,i6);
	dm(i4,m5)=r2;
.LN49:
// line 3362
	r2=dm(xTickCount.);
	i4=dm(-2,i6);
	dm(m6,i4)=r2;
.LN50:
// line 3363
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskInternalSetTimeOutState..end:
.vTaskInternalSetTimeOutState..end:
	.global vTaskInternalSetTimeOutState.;
	.type vTaskInternalSetTimeOutState.,STT_FUNC;

uxTaskGetNumberOfTasks.:
.LNuxTaskGetNumberOfTasks.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
.LN51:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":2396
	r0=dm(uxCurrentNumberOfTasks.);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.uxTaskGetNumberOfTasks..end:
.uxTaskGetNumberOfTasks..end:
	.global uxTaskGetNumberOfTasks.;
	.type uxTaskGetNumberOfTasks.,STT_FUNC;

xTaskGetTickCount.:
.LNxTaskGetTickCount.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":2347
	modify(i7,-2) (nw);
.LN52:
// line 2353
	r0=dm(xTickCount.);
	dm(-2,i6)=r0;
.LN53:
// line 2357
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskGetTickCount..end:
.xTaskGetTickCount..end:
	.global xTaskGetTickCount.;
	.type xTaskGetTickCount.,STT_FUNC;

vTaskSuspendAll.:
.LNvTaskSuspendAll.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r2,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
.LN54:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":2163
	r2=dm(uxSchedulerSuspended.);
	r2=r2+1;
	dm(uxSchedulerSuspended.)=r2;
.LN55:
// line 2168
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskSuspendAll..end:
.vTaskSuspendAll..end:
	.global vTaskSuspendAll.;
	.type vTaskSuspendAll.,STT_FUNC;

adi_osal_RegisterLocalStorageCallback.:
.LNadi_osal_RegisterLocalStorageCallback.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,r4,i4,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1152
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;
	r2=pass r4;
.LN56:
// line 1153
	if eq jump (pc,.P71L2);

.LN57:
// line 1155
	i4=dm(pxCurrentTCB.);
	dm(20,i4)=r4;
.LN58:
// line 1156
	jump (pc,.P71L3);

.P71L2:

.P71L3:
.LN59:
// line 1157
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_RegisterLocalStorageCallback..end:
.adi_osal_RegisterLocalStorageCallback..end:
	.global adi_osal_RegisterLocalStorageCallback.;
	.type adi_osal_RegisterLocalStorageCallback.,STT_FUNC;

prvInitialiseNewTask.:
.LNprvInitialiseNewTask.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,s0-s1,i4,i12,m4,acc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":856
	modify(i7,-6) (nw);
	dm(-7,i6)=r15;
	r1=dm(m6,i6);
	r0=dm(2,i6);
	s0=dm(3,i6);
	r2=dm(4,i6);
	i4=r2;
	s1=dm(5,i6);
	dm(5,i6)=s1;
	dm(4,i6)=r2;
	dm(3,i6)=s0;
	dm(2,i6)=r0;
	dm(m6,i6)=r1;
	dm(-4,i6)=r12;
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
.LN60:
// line 879
	r4=dm(12,i4);
	r12=lshift r12 by 2;
.LN61:
	r8=165;
	cjump __simd_memsetD. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
.LN62:
// line 889
	i4=dm(4,i6);
	r8=dm(12,i4);
	r2=dm(-4,i6);
	r2=r2-1;
	r12=lshift r2 by 2;
	r2=r8+r12;
	dm(-3,i6)=r2;
.LN63:
// line 890
	r1=-8;
	r2=r2 and r1;
	dm(-3,i6)=r2;
.LN64:
// line 893
	r2=fext r2 by 0:3;
	r2=pass r2;
	if eq jump (pc,.P73L2);

.LN65:
	r8=893;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN66:
	jump (pc,.P73L3);

.P73L2:

.P73L3:
.LN67:
// line 917
	r2=dm(-5,i6);
	r2=pass r2;
	if eq jump (pc,.P73L5);

.LN68:
// line 919
	dm(-2,i6)=m13;

.P73L7:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 919 col 9
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 35 
//   cycles (includes 16 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used  16 out of   35 ( 45.7%)
//     pm dag                          used  16 out of   35 ( 45.7%)
//     shift immediate                 used  16 out of   35 ( 45.7%)
//     multifunction alu               used  15 out of   35 ( 42.9%)
//     multifunction float multiply    used  15 out of   35 ( 42.9%)
//     multifunction integer add sub   used  15 out of   35 ( 42.9%)
//     multifunction integer multiply  used  15 out of   35 ( 42.9%)
//     multifunction mult              used  15 out of   35 ( 42.9%)
//     memory access                   used  16 out of   70 ( 22.9%)
//-------------------------------------------------------------------
	// -- 2 stalls --
	r2=dm(-2,i6);
	r1=10;
	compu(r2,r1);
	if ge jump (pc,.P73L9);

.LN69:
// line 921
	i4=dm(-5,i6);
	m4=r2;
	// -- 4 stalls --
	r2=dm(m4,i4) (bw);
	i4=dm(4,i6);
	// -- 4 stalls --
	i4=modify(i4,52);
	dm(m4,i4)=r2 (bw);
.LN70:
// line 926
	i4=dm(-5,i6);
	m4=dm(-2,i6);
	// -- 4 stalls --
	r2=dm(m4,i4) (bwse);
	r2=pass r2;
	if ne jump (pc,.P73L11);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN71:
// line 928
	jump (pc,.P73L13);

.P73L11:
//-------------------------------------------------------------------
//   Part of Loop 7, depth 1
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN72:
// line 919
	r2=dm(-2,i6);
	r2=r2+1;
	dm(-2,i6)=r2;
	jump (pc,.P73L7);
//-------------------------------------------------------------------
//   End Loop L7
//-------------------------------------------------------------------

.P73L9:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------

.P73L13:
.LN73:
// line 938
	i4=dm(4,i6);
	i4=modify(i4,52);
	i4=modify(i4,9);
	dm(m5,i4)=m13 (bw);
.LN74:
// line 939
	jump (pc,.P73L6);

.P73L5:

.P73L6:
.LN75:
// line 946
	r2=dm(2,i6);
	r15=7;
	compu(r2,r15);
	if lt jump (pc,.P73L16);

.LN76:
	r8=946;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
.LN77:
	jump (pc,.P73L17);

.P73L16:

.P73L17:
.LN78:
// line 948
	r2=dm(2,i6);
	compu(r2,r15);
	if lt jump (pc,.P73L19);

.LN79:
// line 950
	i12=6;
	dm(2,i6)=i12;
.LN80:
// line 951
	jump (pc,.P73L20);

.P73L19:

.P73L20:
.LN81:
// line 957
	r2=dm(2,i6);
	i4=dm(4,i6);
	dm(11,i4)=r2;
.LN82:
// line 960
	r2=dm(2,i6);
	i4=dm(4,i6);
	dm(18,i4)=r2;
.LN83:
// line 964
	r8=dm(4,i6);
	r12=4;
	r4=r8+r12;
.LN84:
	cjump vListInitialiseItem. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
.LN85:
// line 965
	r8=dm(4,i6);
	r12=24;
	r4=r8+r12;
.LN86:
	cjump vListInitialiseItem. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
.LN87:
// line 969
	r2=dm(4,i6);
	i4=r2;
	dm(4,i4)=r2;
.LN88:
// line 972
	r12=dm(2,i6);
	r8=7;
	r2=r8-r12;
	i4=dm(4,i6);
	dm(6,i4)=r2;
.LN89:
// line 973
	r2=dm(4,i6);
	i4=r2;
	dm(9,i4)=r2;
.LN90:
// line 1040
	r4=dm(-3,i6);
	r8=dm(-6,i6);
	r12=dm(m6,i6);
.LN91:
	cjump pxPortInitialiseStack. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
.LN92:
	i4=dm(4,i6);
	dm(i4,m5)=r0;
.LN93:
// line 1051
	r2=dm(3,i6);
	r2=pass r2;
	if eq jump (pc,.P73L22);

.LN94:
// line 1055
	r1=dm(4,i6);
	i4=r2;
	dm(i4,m5)=r1;
.LN95:
// line 1056
	jump (pc,.P73L23);

.P73L22:

.P73L23:
.LN96:
// line 1061
	r15=dm(-7,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvInitialiseNewTask..end:
.prvInitialiseNewTask..end:
	.type prvInitialiseNewTask.,STT_FUNC;

eTaskGetState.:
.LNeTaskGetState.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r0-r2,r4,r8,i4,i12,m4,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1407
	modify(i7,-8) (nw);
	dm(-8,i6)=r4;
.LN97:
// line 1412
	dm(-3,i6)=r4;
	r2=pass r4;
.LN98:
// line 1414
	if ne jump (pc,.P78L2);

.LN99:
	r8=1414;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
.LN100:
	jump (pc,.P78L3);

.P78L2:

.P78L3:
.LN101:
// line 1416
	r2=dm(-3,i6);
	r1=dm(pxCurrentTCB.);
	comp(r2,r1);
	if ne jump (pc,.P78L5);

.LN102:
// line 1419
	dm(-7,i6)=m13;
.LN103:
// line 1420
	jump (pc,.P78L6);

.P78L5:
.LN104:
// line 1423
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
.LN105:
// line 1425
	i4=dm(-3,i6);
	r2=dm(5,i4);
	dm(-6,i6)=r2;
.LN106:
// line 1426
	r2=dm(pxDelayedTaskList.);
	dm(-5,i6)=r2;
.LN107:
// line 1427
	r2=dm(pxOverflowDelayedTaskList.);
	dm(-4,i6)=r2;
.LN108:
// line 1429
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
.LN109:
// line 1431
	r2=dm(-6,i6);
	r1=dm(-5,i6);
	comp(r2,r1);
	if eq jump (pc,.P78L7);

	r1=dm(-4,i6);
	comp(r2,r1);
	if ne jump (pc,.P78L8);

.P78L7:
.LN110:
// line 1435
	i12=2;
	dm(-7,i6)=i12;
.LN111:
// line 1436
	jump (pc,.P78L9);

.P78L8:
	r1=xSuspendedTaskList.;
	comp(r2,r1);
.LN112:
// line 1439
	if ne jump (pc,.P78L12);

.LN113:
// line 1444
	i4=dm(-3,i6);
	r2=dm(10,i4);
	r2=pass r2;
	if ne jump (pc,.P78L15);

.LN114:
// line 1455
	i12=3;
	dm(-7,i6)=i12;
.LN115:
// line 1457
	dm(-2,i6)=m13;

.P78L17:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 1457 col 29
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 27 
//   cycles (includes 12 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used  12 out of   27 ( 44.4%)
//     pm dag                          used  12 out of   27 ( 44.4%)
//     shift immediate                 used  12 out of   27 ( 44.4%)
//     multifunction alu               used   9 out of   27 ( 33.3%)
//     multifunction float multiply    used   9 out of   27 ( 33.3%)
//     multifunction integer add sub   used   9 out of   27 ( 33.3%)
//     multifunction integer multiply  used   9 out of   27 ( 33.3%)
//     multifunction mult              used   9 out of   27 ( 33.3%)
//     memory access                   used  12 out of   54 ( 22.2%)
//-------------------------------------------------------------------
	// -- 2 stalls --
	r2=dm(-2,i6);
	r1=m6;
	comp(r2,r1);
	if ge jump (pc,.P78L19);

.LN116:
// line 1459
	i4=dm(-3,i6);
	// -- 4 stalls --
	i4=modify(i4,92);
	m4=r2;
	// -- 4 stalls --
	r2=dm(m4,i4) (bw);                      // Use of volatile in loops precludes optimizations. 
	r1=m5;
	r2=btgl r2 by r1;
	if not sz jump (pc,.P78L21);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN117:
// line 1461
	i12=2;
	dm(-7,i6)=i12;
.LN118:
// line 1462
	jump (pc,.P78L23);

.P78L21:
//-------------------------------------------------------------------
//   Part of Loop 17, depth 1
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN119:
// line 1457
	r2=dm(-2,i6);
	r2=r2+1;
	dm(-2,i6)=r2;
	jump (pc,.P78L17);
//-------------------------------------------------------------------
//   End Loop L17
//-------------------------------------------------------------------

.P78L19:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------

.P78L23:
.LN120:
// line 1471
	jump (pc,.P78L16);

.P78L15:
.LN121:
// line 1474
	i12=2;
	dm(-7,i6)=i12;

.P78L16:
.LN122:
// line 1476
	jump (pc,.P78L13);

.P78L12:
.LN123:
// line 1480
	r1=xTasksWaitingTermination.;
	comp(r2,r1);
	if eq jump (pc,.P78L25);

	r2=pass r2;
	if ne jump (pc,.P78L26);

.P78L25:
.LN124:
// line 1485
	i12=4;
	dm(-7,i6)=i12;
.LN125:
// line 1486
	jump (pc,.P78L27);

.P78L26:
.LN126:
// line 1493
	dm(-7,i6)=m14;

.P78L27:

.P78L13:

.P78L9:

.P78L6:
.LN127:
// line 1497
	r0=dm(-7,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.eTaskGetState..end:
.eTaskGetState..end:
	.global eTaskGetState.;
	.type eTaskGetState.,STT_FUNC;

uxTaskPriorityGet.:
.LNuxTaskPriorityGet.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1506
	modify(i7,-4) (nw);
	dm(-5,i6)=r4;
.LN128:
// line 1510
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ9-1;
.LCJ9:
.LN129:
// line 1514
	r2=dm(-5,i6);
	r2=pass r2;
	if ne jump (pc,.P81L2);

	r2=dm(pxCurrentTCB.);
	dm(-2,i6)=r2;
	jump (pc,.P81L3);

.P81L2:
	dm(-2,i6)=r2;

.P81L3:
	r2=dm(-2,i6);
	i4=r2;
	dm(-4,i6)=r2;
.LN130:
// line 1515
	r2=dm(11,i4);
	dm(-3,i6)=r2;
.LN131:
// line 1517
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ10-1;
.LCJ10:
.LN132:
// line 1519
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.uxTaskPriorityGet..end:
.uxTaskPriorityGet..end:
	.global uxTaskPriorityGet.;
	.type uxTaskPriorityGet.,STT_FUNC;

uxTaskPriorityGetFromISR.:
.LNuxTaskPriorityGetFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0,r2,r4,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1528
	modify(i7,-6) (nw);
	dm(-6,i6)=r4;
.LN133:
// line 1548
	cjump vPortValidateInterruptPriority. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ11-1;
.LCJ11:
.LN134:
// line 1550
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ12-1;
.LCJ12:
.LN135:
	dm(-3,i6)=r0;
.LN136:
// line 1554
	r2=dm(-6,i6);
	r2=pass r2;
	if ne jump (pc,.P82L2);

	r2=dm(pxCurrentTCB.);
	dm(-2,i6)=r2;
	jump (pc,.P82L3);

.P82L2:
	dm(-2,i6)=r2;

.P82L3:
	r2=dm(-2,i6);
	i4=r2;
	dm(-5,i6)=r2;
.LN137:
// line 1555
	r2=dm(11,i4);
	dm(-4,i6)=r2;
.LN138:
// line 1557
	r4=dm(-3,i6);
.LN139:
	cjump vPortClearInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ13-1;
.LCJ13:
.LN140:
// line 1559
	r0=dm(-4,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.uxTaskPriorityGetFromISR..end:
.uxTaskPriorityGetFromISR..end:
	.global uxTaskPriorityGetFromISR.;
	.type uxTaskPriorityGetFromISR.,STT_FUNC;

vTaskPrioritySet.:
.LNvTaskPrioritySet.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 56 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,mcc,scc,btf}
//  Call preserved registers used: {r11,r15,i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1569
	modify(i7,-12) (nw);
	dm(-13,i6)=r11;
	dm(-12,i6)=r15;
	r2=i5;
	dm(-11,i6)=r2;
	dm(-9,i6)=r8;
	dm(-10,i6)=r4;
.LN141:
// line 1572
	dm(-5,i6)=m13;
	r11=7;
	compu(r8,r11);
.LN142:
// line 1574
	if lt jump (pc,.P86L2);

.LN143:
	r8=1574;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ14-1;
.LCJ14:
.LN144:
	jump (pc,.P86L3);

.P86L2:

.P86L3:
.LN145:
// line 1577
	r2=dm(-9,i6);
	compu(r2,r11);
	if lt jump (pc,.P86L5);

.LN146:
// line 1579
	i12=6;
	dm(-9,i6)=i12;
.LN147:
// line 1580
	jump (pc,.P86L6);

.P86L5:

.P86L6:
.LN148:
// line 1586
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ15-1;
.LCJ15:
.LN149:
// line 1590
	r2=dm(-10,i6);
	r2=pass r2;
	if ne jump (pc,.P86L8);

	r2=dm(pxCurrentTCB.);
	dm(-4,i6)=r2;
	jump (pc,.P86L9);

.P86L8:
	dm(-4,i6)=r2;

.P86L9:
	r2=dm(-4,i6);
	i4=r2;
	dm(-8,i6)=r2;
.LN150:
// line 1596
	r2=dm(18,i4);
	dm(-7,i6)=r2;
.LN151:
// line 1604
	r1=dm(-9,i6);
	comp(r2,r1);
	if eq jump (pc,.P86L11);

	compu(r1,r2);
.LN152:
// line 1608
	if le jump (pc,.P86L14);

.LN153:
// line 1610
	r2=dm(-8,i6);
	r1=dm(pxCurrentTCB.);
	comp(r2,r1);
	if eq jump (pc,.P86L17);

.LN154:
// line 1615
	r2=dm(-9,i6);
	i4=dm(pxCurrentTCB.);
	r1=dm(11,i4);
	compu(r2,r1);
	if lt jump (pc,.P86L20);

.LN155:
// line 1617
	dm(-5,i6)=m14;
.LN156:
// line 1618
	jump (pc,.P86L21);

.P86L20:

.P86L21:
.LN157:
// line 1623
	jump (pc,.P86L18);

.P86L17:

.P86L18:
.LN158:
// line 1630
	jump (pc,.P86L15);

.P86L14:
.LN159:
// line 1631
	r2=dm(-8,i6);
	r1=dm(pxCurrentTCB.);
	comp(r2,r1);
	if ne jump (pc,.P86L23);

.LN160:
// line 1636
	dm(-5,i6)=m14;
.LN161:
// line 1637
	jump (pc,.P86L24);

.P86L23:

.P86L24:

.P86L15:
.LN162:
// line 1648
	i4=dm(-8,i6);
	r2=dm(11,i4);
	dm(-6,i6)=r2;
.LN163:
// line 1654
	r2=dm(18,i4);
	r1=dm(11,i4);
	comp(r2,r1);
	if ne jump (pc,.P86L26);

.LN164:
// line 1656
	r2=dm(-9,i6);
	dm(11,i4)=r2;
.LN165:
// line 1657
	jump (pc,.P86L27);

.P86L26:

.P86L27:
.LN166:
// line 1664
	r2=dm(-9,i6);
	i4=dm(-8,i6);
	dm(18,i4)=r2;
.LN167:
// line 1674
	i4=dm(-8,i6);
	r2=dm(6,i4);
	r1=31;
	btst r2 by r1;
	if not sz jump (pc,.P86L29);

.LN168:
// line 1676
	r12=dm(-9,i6);
	r8=7;
	r2=r8-r12;
	dm(6,i4)=r2;
.LN169:
// line 1677
	jump (pc,.P86L30);

.P86L29:

.P86L30:
.LN170:
// line 1687
	i4=dm(-8,i6);
	r2=dm(5,i4);
	r1=dm(-6,i6);
	r15=20;
	r12=r1*r15 (ssi);
	r11=pxReadyTasksLists.;
	r1=r11+r12;
	comp(r2,r1);
	if ne jump (pc,.P86L35);

	dm(-3,i6)=m14;
	jump (pc,.P86L36);

.P86L35:
	dm(-3,i6)=m13;

.P86L36:
	r2=dm(-3,i6);
	r2=pass r2;
	if eq jump (pc,.P86L32);

.LN171:
// line 1692
	r8=dm(-8,i6);
	r12=4;
	r4=r8+r12;
.LN172:
	cjump uxListRemove. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ16-1;
.LCJ16:
	dm(-3,i6)=r0;

.LN173:
// line 1704
	i4=dm(-8,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);
	compu(r2,r1);
	if le jump (pc,.P86L41);

.LN174:
	i4=dm(-8,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;
.LN175:
	jump (pc,.P86L42);

.P86L41:

.P86L42:
.LN176:
	i5=dm(-8,i6);
	r2=dm(11,i5);
	r2=r2*r15 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN177:
	dm(2,i5)=r2;
.LN178:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-8,i6);
	dm(3,i4)=r2;
.LN179:
	i12=dm(-8,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN180:
	i12=dm(-8,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN181:
	i4=dm(-8,i6);
	r2=dm(11,i4);
	r8=r2*r15 (ssi);
	r12=r11;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN182:
	i4=dm(-8,i6);
	r2=dm(11,i4);
	r2=r2*r15 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN183:
// line 1705
	jump (pc,.P86L33);

.P86L32:

.P86L33:
.LN184:
// line 1711
	r2=dm(-5,i6);
	r2=pass r2;
	if eq jump (pc,.P86L44);

.LN185:
// line 1713
	dm(_adi_OSWaitingForSched.)=m6;
.LN186:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN187:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P86L47);


.P86L51:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 1713 col 21
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
.LN188:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P86L52);

	jump (pc,.P86L51);
//-------------------------------------------------------------------
//   End Loop L51
//-------------------------------------------------------------------

.P86L52:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN189:
	jump (pc,.P86L48);

.P86L47:

.P86L48:
.LN190:
// line 1714
	jump (pc,.P86L45);

.P86L44:

.P86L45:
.LN191:
// line 1723
	jump (pc,.P86L12);

.P86L11:

.P86L12:
.LN192:
// line 1725
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ17-1;
.LCJ17:
.LN193:
// line 1726
	i5=dm(-11,i6);
	r11=dm(-13,i6);
	r15=dm(-12,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskPrioritySet..end:
.vTaskPrioritySet..end:
	.global vTaskPrioritySet.;
	.type vTaskPrioritySet.,STT_FUNC;

prvTaskIsTaskSuspended.:
.LNprvTaskIsTaskSuspended.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0-r2,r4,r8,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1840
	modify(i7,-4) (nw);
	dm(-5,i6)=r4;
.LN194:
// line 1841
	dm(-4,i6)=m13;
.LN195:
// line 1842
	dm(-3,i6)=r4;
	r2=pass r4;
.LN196:
// line 1848
	if ne jump (pc,.P88L2);

.LN197:
	r8=1848;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ18-1;
.LCJ18:
.LN198:
	jump (pc,.P88L3);

.P88L2:

.P88L3:
.LN199:
// line 1851
	i4=dm(-3,i6);
	r2=dm(5,i4);
	r1=xSuspendedTaskList.;
	comp(r2,r1);
	if ne jump (pc,.P88L8);

	dm(-2,i6)=m14;
	jump (pc,.P88L9);

.P88L8:
	dm(-2,i6)=m13;

.P88L9:
	r2=dm(-2,i6);
	r2=pass r2;
	if eq jump (pc,.P88L5);

.LN200:
// line 1854
	i4=dm(-3,i6);
	r2=dm(10,i4);
	r1=xPendingReadyList.;
	comp(r2,r1);
	if ne jump (pc,.P88L14);

	dm(-2,i6)=m14;
	jump (pc,.P88L15);

.P88L14:
	dm(-2,i6)=m13;

.P88L15:
	r2=dm(-2,i6);
	r2=pass r2;
	if ne jump (pc,.P88L11);

.LN201:
// line 1858
	i4=dm(-3,i6);
	r2=dm(10,i4);
	r2=pass r2;
	if ne jump (pc,.P88L20);

	dm(-2,i6)=m14;
	jump (pc,.P88L21);

.P88L20:
	dm(-2,i6)=m13;

.P88L21:
	r2=dm(-2,i6);
	r2=pass r2;
	if eq jump (pc,.P88L17);

.LN202:
// line 1860
	dm(-4,i6)=m14;
.LN203:
// line 1861
	jump (pc,.P88L18);

.P88L17:

.P88L18:
.LN204:
// line 1866
	jump (pc,.P88L12);

.P88L11:

.P88L12:
.LN205:
// line 1871
	jump (pc,.P88L6);

.P88L5:

.P88L6:
.LN206:
// line 1877
	r0=dm(-4,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvTaskIsTaskSuspended..end:
.prvTaskIsTaskSuspended..end:
	.type prvTaskIsTaskSuspended.,STT_FUNC;

vTaskResume.:
.LNvTaskResume.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,mcc,btf}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1886
	modify(i7,-4) (nw);
	r2=i5;
	dm(-5,i6)=r2;
	dm(-4,i6)=r4;
.LN207:
// line 1887
	dm(-3,i6)=r4;
	r2=pass r4;
.LN208:
// line 1890
	if ne jump (pc,.P89L2);

.LN209:
	r8=1890;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ19-1;
.LCJ19:
.LN210:
	jump (pc,.P89L3);

.P89L2:

.P89L3:
.LN211:
// line 1894
	r2=dm(-3,i6);
	r1=dm(pxCurrentTCB.);
	comp(r2,r1);
	if eq jump (pc,.P89L5);

	r2=dm(-3,i6);
	r2=pass r2;
	if eq jump (pc,.P89L5);

.LN212:
// line 1896
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ20-1;
.LCJ20:
.LN213:
// line 1898
	r4=dm(-3,i6);
.LN214:
	cjump prvTaskIsTaskSuspended. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ21-1;
.LCJ21:
	r2=pass r0;
.LN215:
	if eq jump (pc,.P89L9);

.LN216:
// line 1904
	r8=dm(-3,i6);
	r12=4;
	r4=r8+r12;
.LN217:
	cjump uxListRemove. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ22-1;
.LCJ22:
.LN218:
// line 1905
	i4=dm(-3,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);
	compu(r2,r1);
	if le jump (pc,.P89L12);

.LN219:
	i4=dm(-3,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;
.LN220:
	jump (pc,.P89L13);

.P89L12:

.P89L13:
.LN221:
	i5=dm(-3,i6);
	r2=dm(11,i5);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN222:
	dm(2,i5)=r2;
.LN223:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-3,i6);
	dm(3,i4)=r2;
.LN224:
	i12=dm(-3,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN225:
	i12=dm(-3,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN226:
	i4=dm(-3,i6);
	r2=dm(11,i4);
	r8=r2*r1 (ssi);
	r12=pxReadyTasksLists.;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN227:
	i4=dm(-3,i6);
	r2=dm(11,i4);
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN228:
// line 1908
	i4=dm(-3,i6);
	r2=dm(11,i4);
	i4=dm(pxCurrentTCB.);
	r1=dm(11,i4);
	compu(r2,r1);
	if lt jump (pc,.P89L15);

.LN229:
// line 1913
	dm(_adi_OSWaitingForSched.)=m6;
.LN230:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN231:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P89L18);


.P89L22:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 1913 col 25
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
.LN232:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P89L23);

	jump (pc,.P89L22);
//-------------------------------------------------------------------
//   End Loop L22
//-------------------------------------------------------------------

.P89L23:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN233:
	jump (pc,.P89L19);

.P89L18:

.P89L19:
.LN234:
// line 1914
	jump (pc,.P89L16);

.P89L15:

.P89L16:
.LN235:
// line 1919
	jump (pc,.P89L10);

.P89L9:

.P89L10:
.LN236:
// line 1925
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ23-1;
.LCJ23:
.LN237:
// line 1926
	jump (pc,.P89L6);

.P89L5:

.P89L6:
.LN238:
// line 1931
	i5=dm(-5,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskResume..end:
.vTaskResume..end:
	.global vTaskResume.;
	.type vTaskResume.,STT_FUNC;

xTaskResumeFromISR.:
.LNxTaskResumeFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,mcc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1940
	modify(i7,-6) (nw);
	r2=i5;
	dm(-7,i6)=r2;
	dm(-6,i6)=r4;
.LN239:
// line 1941
	dm(-5,i6)=m13;
.LN240:
// line 1942
	dm(-4,i6)=r4;
	r2=pass r4;
.LN241:
// line 1945
	if ne jump (pc,.P90L2);

.LN242:
	r8=1945;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ24-1;
.LCJ24:
.LN243:
	jump (pc,.P90L3);

.P90L2:

.P90L3:
.LN244:
// line 1963
	cjump vPortValidateInterruptPriority. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ25-1;
.LCJ25:
.LN245:
// line 1965
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ26-1;
.LCJ26:
.LN246:
	dm(-3,i6)=r0;
.LN247:
// line 1967
	r4=dm(-4,i6);
.LN248:
	cjump prvTaskIsTaskSuspended. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ27-1;
.LCJ27:
	r2=pass r0;
.LN249:
	if eq jump (pc,.P90L5);

.LN250:
// line 1972
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if ne jump (pc,.P90L8);

.LN251:
// line 1976
	i4=dm(-4,i6);
	r2=dm(11,i4);
	i4=dm(pxCurrentTCB.);
	r1=dm(11,i4);
	compu(r2,r1);
	if lt jump (pc,.P90L11);

.LN252:
// line 1978
	dm(-5,i6)=m14;
.LN253:
// line 1983
	dm(xYieldPending.)=m6;
.LN254:
// line 1984
	jump (pc,.P90L12);

.P90L11:

.P90L12:
.LN255:
// line 1990
	r8=dm(-4,i6);
	r12=4;
	r4=r8+r12;
.LN256:
	cjump uxListRemove. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ28-1;
.LCJ28:
.LN257:
// line 1991
	i4=dm(-4,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);
	compu(r2,r1);
	if le jump (pc,.P90L14);

.LN258:
	i4=dm(-4,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;
.LN259:
	jump (pc,.P90L15);

.P90L14:

.P90L15:
.LN260:
	i5=dm(-4,i6);
	r2=dm(11,i5);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN261:
	dm(2,i5)=r2;
.LN262:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-4,i6);
	dm(3,i4)=r2;
.LN263:
	i12=dm(-4,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN264:
	i12=dm(-4,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN265:
	i4=dm(-4,i6);
	r2=dm(11,i4);
	r8=r2*r1 (ssi);
	r12=pxReadyTasksLists.;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN266:
	i4=dm(-4,i6);
	r2=dm(11,i4);
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN267:
// line 1992
	jump (pc,.P90L9);

.P90L8:
.LN268:
// line 1998
	r8=dm(-4,i6);
	r12=24;
	r8=r8+r12;
.LN269:
	r4=xPendingReadyList.;
	cjump vListInsertEnd. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ29-1;
.LCJ29:

.P90L9:
.LN270:
// line 2000
	jump (pc,.P90L6);

.P90L5:

.P90L6:
.LN271:
// line 2006
	r4=dm(-3,i6);
.LN272:
	cjump vPortClearInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ30-1;
.LCJ30:
.LN273:
// line 2008
	r0=dm(-5,i6);
	i5=dm(-7,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskResumeFromISR..end:
.xTaskResumeFromISR..end:
	.global xTaskResumeFromISR.;
	.type xTaskResumeFromISR.,STT_FUNC;

vTaskEndScheduler.:
.LNvTaskEndScheduler.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN274:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":2144
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ31-1;
.LCJ31:
.LN275:
// line 2145
	dm(xSchedulerRunning.)=m5;
.LN276:
// line 2146
	cjump vPortEndScheduler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ32-1;
.LCJ32:
.LN277:
// line 2147
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskEndScheduler..end:
.vTaskEndScheduler..end:
	.global vTaskEndScheduler.;
	.type vTaskEndScheduler.,STT_FUNC;

xTaskGetTickCountFromISR.:
.LNxTaskGetTickCountFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":2362
	modify(i7,-2) (nw);
.LN278:
// line 2380
	cjump vPortValidateInterruptPriority. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ33-1;
.LCJ33:
.LN279:
// line 2382
	dm(-2,i6)=m13;
.LN280:
// line 2384
	r0=dm(xTickCount.);
	dm(-3,i6)=r0;
.LN281:
// line 2388
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskGetTickCountFromISR..end:
.xTaskGetTickCountFromISR..end:
	.global xTaskGetTickCountFromISR.;
	.type xTaskGetTickCountFromISR.,STT_FUNC;

pcTaskGetName.:
.LNpcTaskGetName.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,r8,r12,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":2401
	modify(i7,-4) (nw);
	dm(-4,i6)=r4;
	r2=pass r4;
.LN282:
// line 2406
	if ne jump (pc,.P95L2);

	r2=dm(pxCurrentTCB.);
	dm(-2,i6)=r2;
	jump (pc,.P95L3);

.P95L2:
	dm(-2,i6)=r4;

.P95L3:
	r2=dm(-2,i6);
	dm(-3,i6)=r2;
	r2=pass r2;
.LN283:
// line 2407
	if ne jump (pc,.P95L5);

.LN284:
	r8=2407;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ34-1;
.LCJ34:
.LN285:
	jump (pc,.P95L6);

.P95L5:

.P95L6:
.LN286:
// line 2408
	r8=dm(-3,i6);
	r12=52;
	r0=r8+r12;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.pcTaskGetName..end:
.pcTaskGetName..end:
	.global pcTaskGetName.;
	.type pcTaskGetName.,STT_FUNC;

xTaskIncrementTick.:
.LNxTaskIncrementTick.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 56 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,mcc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":2781
	modify(i7,-12) (nw);
	r2=i5;
	dm(-12,i6)=r2;
.LN287:
// line 2784
	dm(-9,i6)=m13;
.LN288:
// line 2791
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if ne jump (pc,.P96L2);

.LN289:
// line 2795
	r2=dm(xTickCount.);
	r2=r2+1;
	dm(-8,i6)=r2;
.LN290:
// line 2799
	dm(xTickCount.)=r2;
.LN291:
// line 2801
	r2=dm(-8,i6);
	r2=pass r2;
	if ne jump (pc,.P96L5);

.LN292:
// line 2803
	i4=dm(pxDelayedTaskList.);
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P96L11);

	dm(-6,i6)=m14;
	jump (pc,.P96L12);

.P96L11:
	dm(-6,i6)=m13;

.P96L12:
	r2=dm(-6,i6);
	r2=pass r2;
	if ne jump (pc,.P96L8);

.LN293:
	r8=2803;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ35-1;
.LCJ35:
.LN294:
	jump (pc,.P96L9);

.P96L8:

.P96L9:
.LN295:
	r2=dm(pxDelayedTaskList.);
	dm(-7,i6)=r2;
.LN296:
	r2=dm(pxOverflowDelayedTaskList.);
	dm(pxDelayedTaskList.)=r2;
.LN297:
	r2=dm(-7,i6);
	dm(pxOverflowDelayedTaskList.)=r2;
.LN298:
	r2=dm(xNumOfOverflows.);
	r2=r2+1;
	dm(xNumOfOverflows.)=r2;
.LN299:
	cjump prvResetNextTaskUnblockTime. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ36-1;
.LCJ36:
.LN300:
// line 2804
	jump (pc,.P96L6);

.P96L5:

.P96L6:
.LN301:
// line 2814
	r2=dm(-8,i6);
	r1=dm(xNextTaskUnblockTime.);
	compu(r2,r1);
	if lt jump (pc,.P96L14);


.P96L16:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 2816 col 13
//-------------------------------------------------------------------
.LN302:
// line 2818
	i4=dm(pxDelayedTaskList.);              // Use of volatile in loops precludes optimizations. 
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if ne jump (pc,.P96L23);

	dm(-5,i6)=m14;
	jump (pc,.P96L24);

.P96L23:
	dm(-5,i6)=m13;

.P96L24:
	r2=dm(-5,i6);
	r2=pass r2;
	if eq jump (pc,.P96L20);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN303:
// line 2825
	dm(xNextTaskUnblockTime.)=m7;
.LN304:
// line 2826
	jump (pc,.P96L25);

.P96L20:
//-------------------------------------------------------------------
//   Part of Loop 16, depth 1
//-------------------------------------------------------------------
.LN305:
// line 2834
	i4=dm(pxDelayedTaskList.);              // Use of volatile in loops precludes optimizations. 
	i4=dm(3,i4);
	r2=dm(3,i4);
	i4=r2;
	dm(-11,i6)=r2;
.LN306:
// line 2835
	r2=dm(m6,i4);
	dm(-10,i6)=r2;
.LN307:
// line 2837
	r1=dm(-8,i6);
	compu(r2,r1);
	if le jump (pc,.P96L28);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN308:
// line 2844
	r2=dm(-10,i6);
	dm(xNextTaskUnblockTime.)=r2;
.LN309:
// line 2845
	jump (pc,.P96L25);

.P96L28:
//-------------------------------------------------------------------
//   Part of Loop 16, depth 1
//-------------------------------------------------------------------
.LN310:
// line 2853
	r2=dm(5,i4);
	dm(-4,i6)=r2;
.LN311:
	r2=dm(3,i4);
	i4=dm(2,i4);
	dm(2,i4)=r2;
.LN312:
	i4=dm(-11,i6);
	r2=dm(2,i4);
	i4=dm(3,i4);
	dm(m6,i4)=r2;
.LN313:
	i5=dm(-4,i6);
	r2=dm(m6,i5);
	r8=dm(-11,i6);
	r12=4;
	r1=r8+r12;
	comp(r2,r1);
	if ne jump (pc,.P96L32);

	i4=r8;
.LN314:
	r2=dm(3,i4);
	dm(m6,i5)=r2;
.LN315:
	jump (pc,.P96L33);

.P96L32:

.P96L33:
.LN316:
	i4=dm(-11,i6);
	dm(5,i4)=m13;
.LN317:
	i4=dm(-4,i6);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	r2=r2-1;
	dm(i4,m5)=r2;                             // Use of volatile in loops precludes optimizations. 
.LN318:
// line 2857
	i4=dm(-11,i6);
	r2=dm(10,i4);
	r2=pass r2;
	if eq jump (pc,.P96L35);

.LN319:
// line 2859
	dm(-3,i6)=r2;
.LN320:
	r2=dm(8,i4);
	i4=dm(7,i4);
	dm(2,i4)=r2;
.LN321:
	i4=dm(-11,i6);
	r2=dm(7,i4);
	i4=dm(8,i4);
	dm(m6,i4)=r2;
.LN322:
	i5=dm(-3,i6);
	r2=dm(m6,i5);
	r8=dm(-11,i6);
	r12=24;
	r1=r8+r12;
	comp(r2,r1);
	if ne jump (pc,.P96L38);

	i4=r8;
.LN323:
	r2=dm(8,i4);
	dm(m6,i5)=r2;
.LN324:
	jump (pc,.P96L39);

.P96L38:

.P96L39:
.LN325:
	i4=dm(-11,i6);
	dm(10,i4)=m13;
.LN326:
	i4=dm(-3,i6);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	r2=r2-1;
	dm(i4,m5)=r2;                             // Use of volatile in loops precludes optimizations. 
.LN327:
// line 2860
	jump (pc,.P96L36);

.P96L35:

.P96L36:
.LN328:
// line 2868
	i4=dm(-11,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);             // Use of volatile in loops precludes optimizations. 
	compu(r2,r1);
	if le jump (pc,.P96L41);

.LN329:
	i4=dm(-11,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;             // Use of volatile in loops precludes optimizations. 
.LN330:
	jump (pc,.P96L42);

.P96L41:

.P96L42:
.LN331:
	i5=dm(-11,i6);
	r2=dm(11,i5);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN332:
	dm(2,i5)=r2;
.LN333:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-11,i6);
	dm(3,i4)=r2;
.LN334:
	i12=dm(-11,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN335:
	i12=dm(-11,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN336:
	i4=dm(-11,i6);
	r2=dm(11,i4);
	r8=r2*r1 (ssi);
	r12=pxReadyTasksLists.;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN337:
	i4=dm(-11,i6);
	r2=dm(11,i4);
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	r2=r2+1;
	dm(i4,m5)=r2;                             // Use of volatile in loops precludes optimizations. 
.LN338:
// line 2882
	i4=dm(-11,i6);
	r2=dm(11,i4);
	i4=dm(pxCurrentTCB.);                   // Use of volatile in loops precludes optimizations. 
	r1=dm(11,i4);
	compu(r2,r1);
	if le jump (pc,.P96L44);

.LN339:
// line 2884
	dm(-9,i6)=m14;
.LN340:
// line 2885
	jump (pc,.P96L45);

.P96L44:

.P96L45:
	jump (pc,.P96L16);
//-------------------------------------------------------------------
//   End Loop L16
//-------------------------------------------------------------------

.P96L25:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN341:
// line 2894
	jump (pc,.P96L15);

.P96L14:

.P96L15:
.LN342:
// line 2901
	i4=dm(pxCurrentTCB.);
	r2=dm(11,i4);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r1=m6;
	compu(r2,r1);
	if le jump (pc,.P96L47);

.LN343:
// line 2903
	dm(-9,i6)=m14;
.LN344:
// line 2904
	jump (pc,.P96L48);

.P96L47:

.P96L48:
.LN345:
// line 2929
	r2=dm(xYieldPending.);
	r2=pass r2;
	if eq jump (pc,.P96L50);

.LN346:
// line 2931
	dm(-9,i6)=m14;
.LN347:
// line 2932
	jump (pc,.P96L51);

.P96L50:

.P96L51:
.LN348:
// line 2939
	jump (pc,.P96L3);

.P96L2:
.LN349:
// line 2942
	r2=dm(xPendedTicks.);
	r2=r2+1;
	dm(xPendedTicks.)=r2;

.P96L3:
.LN350:
// line 2953
	r0=dm(-9,i6);
	i5=dm(-12,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskIncrementTick..end:
.xTaskIncrementTick..end:
	.global xTaskIncrementTick.;
	.type xTaskIncrementTick.,STT_FUNC;

xTaskResumeAll.:
.LNxTaskResumeAll.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,mcc,btf}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":2235
	modify(i7,-8) (nw);
	r2=i5;
	dm(-9,i6)=r2;
.LN351:
// line 2236
	dm(-8,i6)=m13;
.LN352:
// line 2237
	dm(-7,i6)=m13;
.LN353:
// line 2241
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if ne jump (pc,.P97L2);

.LN354:
	r8=2241;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ37-1;
.LCJ37:
.LN355:
	jump (pc,.P97L3);

.P97L2:

.P97L3:
.LN356:
// line 2248
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ38-1;
.LCJ38:
.LN357:
// line 2250
	r2=dm(uxSchedulerSuspended.);
	r2=r2-1;
	dm(uxSchedulerSuspended.)=r2;
.LN358:
// line 2252
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if ne jump (pc,.P97L5);

.LN359:
// line 2254
	r2=dm(uxCurrentNumberOfTasks.);
	r2=pass r2;
	if eq jump (pc,.P97L8);


.P97L10:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 2258 col 17
//-------------------------------------------------------------------
.LN360:
// line 2258
	r2=dm(xPendingReadyList.);              // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if ne jump (pc,.P97L14);

	dm(-6,i6)=m14;
	jump (pc,.P97L15);

.P97L14:
	dm(-6,i6)=m13;

.P97L15:
	r2=dm(-6,i6);
	r2=pass r2;
	if ne jump (pc,.P97L11);

.LN361:
// line 2260
	i4=dm(xPendingReadyList.+12);
	i4=dm(3,i4);
	r2=i4;
	dm(-8,i6)=r2;
.LN362:
// line 2261
	r2=dm(10,i4);
	dm(-5,i6)=r2;
.LN363:
	r2=dm(8,i4);
	i4=dm(7,i4);
	dm(2,i4)=r2;
.LN364:
	i4=dm(-8,i6);
	r2=dm(7,i4);
	i4=dm(8,i4);
	dm(m6,i4)=r2;
.LN365:
	i5=dm(-5,i6);
	r2=dm(m6,i5);
	r8=dm(-8,i6);
	r12=24;
	r1=r8+r12;
	comp(r2,r1);
	if ne jump (pc,.P97L17);

	i4=r8;
.LN366:
	r2=dm(8,i4);
	dm(m6,i5)=r2;
.LN367:
	jump (pc,.P97L18);

.P97L17:

.P97L18:
.LN368:
	i4=dm(-8,i6);
	dm(10,i4)=m13;
.LN369:
	i4=dm(-5,i6);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	r2=r2-1;
	dm(i4,m5)=r2;                             // Use of volatile in loops precludes optimizations. 
.LN370:
// line 2263
	i4=dm(-8,i6);
	r2=dm(5,i4);
	dm(-4,i6)=r2;
.LN371:
	r2=dm(3,i4);
	i4=dm(2,i4);
	dm(2,i4)=r2;
.LN372:
	i4=dm(-8,i6);
	r2=dm(2,i4);
	i4=dm(3,i4);
	dm(m6,i4)=r2;
.LN373:
	i5=dm(-4,i6);
	r2=dm(m6,i5);
	r8=dm(-8,i6);
	r12=4;
	r1=r8+r12;
	comp(r2,r1);
	if ne jump (pc,.P97L20);

	i4=r8;
.LN374:
	r2=dm(3,i4);
	dm(m6,i5)=r2;
.LN375:
	jump (pc,.P97L21);

.P97L20:

.P97L21:
.LN376:
	i4=dm(-8,i6);
	dm(5,i4)=m13;
.LN377:
	i4=dm(-4,i6);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	r2=r2-1;
	dm(i4,m5)=r2;                             // Use of volatile in loops precludes optimizations. 
.LN378:
// line 2264
	i4=dm(-8,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);             // Use of volatile in loops precludes optimizations. 
	compu(r2,r1);
	if le jump (pc,.P97L23);

.LN379:
	i4=dm(-8,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;             // Use of volatile in loops precludes optimizations. 
.LN380:
	jump (pc,.P97L24);

.P97L23:

.P97L24:
.LN381:
	i5=dm(-8,i6);
	r2=dm(11,i5);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-3,i6)=r2;
.LN382:
	dm(2,i5)=r2;
.LN383:
	i4=dm(-3,i6);
	r2=dm(2,i4);
	i4=dm(-8,i6);
	dm(3,i4)=r2;
.LN384:
	i12=dm(-8,i6);
	i12=modify(i12,4);
	i4=dm(-3,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN385:
	i12=dm(-8,i6);
	i12=modify(i12,4);
	i4=dm(-3,i6);
	dm(2,i4)=i12;
.LN386:
	i4=dm(-8,i6);
	r2=dm(11,i4);
	r8=r2*r1 (ssi);
	r12=pxReadyTasksLists.;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN387:
	i4=dm(-8,i6);
	r2=dm(11,i4);
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	r2=r2+1;
	dm(i4,m5)=r2;                             // Use of volatile in loops precludes optimizations. 
.LN388:
// line 2268
	i4=dm(-8,i6);
	r2=dm(11,i4);
	i4=dm(pxCurrentTCB.);                   // Use of volatile in loops precludes optimizations. 
	r1=dm(11,i4);
	compu(r2,r1);
	if lt jump (pc,.P97L26);

.LN389:
// line 2270
	dm(xYieldPending.)=m6;                  // Use of volatile in loops precludes optimizations. 
.LN390:
// line 2271
	jump (pc,.P97L27);

.P97L26:

.P97L27:
	jump (pc,.P97L10);
//-------------------------------------------------------------------
//   End Loop L10
//-------------------------------------------------------------------

.P97L11:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN391:
// line 2278
	r2=dm(-8,i6);
	r2=pass r2;
	if eq jump (pc,.P97L29);

.LN392:
// line 2286
	cjump prvResetNextTaskUnblockTime. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ39-1;
.LCJ39:
.LN393:
// line 2287
	jump (pc,.P97L30);

.P97L29:

.P97L30:
.LN394:
// line 2294
	r2=dm(xPendedTicks.);
	dm(-2,i6)=r2;
	r2=pass r2;
.LN395:
// line 2296
	if eq jump (pc,.P97L32);

.LN396:
// line 2298
	jump (pc,.P97L34);

.P97L51:
//-------------------------------------------------------------------
//   Part of Loop 34, depth 1
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//   End Loop L34
//-------------------------------------------------------------------

.P97L34:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 2298 col 25
//-------------------------------------------------------------------
.LN397:
// line 2300
	cjump xTaskIncrementTick. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ40-1;
.LCJ40:
	r2=pass r0;
.LN398:
	if eq jump (pc,.P97L36);

.LN399:
// line 2302
	dm(xYieldPending.)=m6;                  // Use of volatile in loops precludes optimizations. 
.LN400:
// line 2303
	jump (pc,.P97L37);

.P97L36:

.P97L37:
.LN401:
// line 2309
	r2=dm(-2,i6);
	r2=r2-1;
	dm(-2,i6)=r2;
.LN402:
// line 2310
	r2=pass r2;
	if ne jump (pc,.P97L51);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN403:
// line 2312
	dm(xPendedTicks.)=m5;
.LN404:
// line 2313
	jump (pc,.P97L33);

.P97L32:

.P97L33:
.LN405:
// line 2320
	r2=dm(xYieldPending.);
	r2=pass r2;
	if eq jump (pc,.P97L40);

.LN406:
// line 2324
	dm(-7,i6)=m14;
.LN407:
// line 2327
	dm(_adi_OSWaitingForSched.)=m6;
.LN408:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN409:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P97L43);


.P97L47:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 2327 col 21
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
.LN410:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P97L48);

	jump (pc,.P97L47);
//-------------------------------------------------------------------
//   End Loop L47
//-------------------------------------------------------------------

.P97L48:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN411:
	jump (pc,.P97L44);

.P97L43:

.P97L44:
.LN412:
// line 2328
	jump (pc,.P97L41);

.P97L40:

.P97L41:
.LN413:
// line 2333
	jump (pc,.P97L9);

.P97L8:

.P97L9:
.LN414:
// line 2334
	jump (pc,.P97L6);

.P97L5:

.P97L6:
.LN415:
// line 2340
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ41-1;
.LCJ41:
.LN416:
// line 2342
	r0=dm(-7,i6);
	i5=dm(-9,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskResumeAll..end:
.xTaskResumeAll..end:
	.global xTaskResumeAll.;
	.type xTaskResumeAll.,STT_FUNC;

xTaskCatchUpTicks.:
.LNxTaskCatchUpTicks.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,r4,r8,r12,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":2677
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN417:
// line 2682
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if eq jump (pc,.P98L2);

.LN418:
	r8=2682;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ42-1;
.LCJ42:
.LN419:
	jump (pc,.P98L3);

.P98L2:

.P98L3:
.LN420:
// line 2686
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ43-1;
.LCJ43:
.LN421:
// line 2689
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ44-1;
.LCJ44:
.LN422:
// line 2691
	r8=dm(-3,i6);
	r12=dm(xPendedTicks.);
	r2=r8+r12;
	dm(xPendedTicks.)=r2;
.LN423:
// line 2693
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ45-1;
.LCJ45:
.LN424:
// line 2694
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ46-1;
.LCJ46:
.LN425:
	dm(-2,i6)=r0;
.LN426:
// line 2696
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskCatchUpTicks..end:
.xTaskCatchUpTicks..end:
	.global xTaskCatchUpTicks.;
	.type xTaskCatchUpTicks.,STT_FUNC;

vTaskSwitchContext.:
.LNvTaskSwitchContext.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,mcc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3070
	modify(i7,-6) (nw);
	r2=i5;
	dm(-7,i6)=r2;
.LN427:
// line 3071
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if eq jump (pc,.P99L2);

.LN428:
// line 3075
	dm(xYieldPending.)=m6;
.LN429:
// line 3076
	jump (pc,.P99L3);

.P99L2:
.LN430:
// line 3079
	dm(xYieldPending.)=m5;
.LN431:
// line 3111
	i12=-1515870811;
	dm(-5,i6)=i12;
.LN432:
	i4=dm(pxCurrentTCB.);
	r2=dm(12,i4);
	i4=r2;
	dm(-6,i6)=r2;
.LN433:
	r2=dm(i4,m5);
	r1=dm(-5,i6);
	comp(r2,r1);
	if ne jump (pc,.P99L4);

	r2=dm(m6,i4);
	comp(r2,r1);
	if ne jump (pc,.P99L4);

	r2=dm(2,i4);
	comp(r2,r1);
	if ne jump (pc,.P99L4);

	r2=dm(3,i4);
	comp(r2,r1);
	if eq jump (pc,.P99L5);

.P99L4:
.LN434:
	r4=dm(pxCurrentTCB.);
	r8=dm(pxCurrentTCB.);
	r12=52;
	r8=r8+r12;
.LN435:
	cjump vApplicationStackOverflowHook. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ47-1;
.LCJ47:
.LN436:
	jump (pc,.P99L6);

.P99L5:

.P99L6:
.LN437:
// line 3122
	r2=dm(uxTopReadyPriority.);
	dm(-4,i6)=r2;

.P99L10:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 3122 col 9
//-------------------------------------------------------------------
.LN438:
	r2=dm(-4,i6);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if ne jump (pc,.P99L14);

	dm(-3,i6)=m14;
	jump (pc,.P99L15);

.P99L14:
	dm(-3,i6)=m13;

.P99L15:
	r2=dm(-3,i6);
	r2=pass r2;
	if eq jump (pc,.P99L11);

.LN439:
	r2=dm(-4,i6);
	r2=pass r2;
	if ne jump (pc,.P99L17);

.LN440:
	r8=3122;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ48-1;
.LCJ48:
.LN441:
	jump (pc,.P99L18);

.P99L17:

.P99L18:
.LN442:
	r2=dm(-4,i6);
	r2=r2-1;
	dm(-4,i6)=r2;
	jump (pc,.P99L10);
//-------------------------------------------------------------------
//   End Loop L10
//-------------------------------------------------------------------

.P99L11:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN443:
	r2=dm(-4,i6);
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=i4;
	dm(-2,i6)=r2;
.LN444:
	i5=dm(m6,i4);
	r2=dm(m6,i5);
	dm(m6,i4)=r2;
.LN445:
	i5=dm(-2,i6);
	r1=dm(m6,i5);
	i4=modify(i5,8);
	r2=i4;
	comp(r1,r2);
	if ne jump (pc,.P99L20);

	i4=r1;
.LN446:
	r2=dm(m6,i4);
	dm(m6,i5)=r2;
.LN447:
	jump (pc,.P99L21);

.P99L20:

.P99L21:
.LN448:
	i4=dm(-2,i6);
	i4=dm(m6,i4);
	r2=dm(3,i4);
	dm(pxCurrentTCB.)=r2;
.LN449:
	r2=dm(-4,i6);
	dm(uxTopReadyPriority.)=r2;

.P99L3:
.LN450:
// line 3140
	i5=dm(-7,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskSwitchContext..end:
.vTaskSwitchContext..end:
	.global vTaskSwitchContext.;
	.type vTaskSwitchContext.,STT_FUNC;

vTaskSuspend.:
.LNvTaskSuspend.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,m4,acc,scc,btf}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1734
	modify(i7,-6) (nw);
	dm(-6,i6)=r15;
	dm(-5,i6)=r4;
.LN451:
// line 1737
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ49-1;
.LCJ49:
.LN452:
// line 1741
	r2=dm(-5,i6);
	r2=pass r2;
	if ne jump (pc,.P101L2);

	r2=dm(pxCurrentTCB.);
	dm(-3,i6)=r2;
	jump (pc,.P101L3);

.P101L2:
	dm(-3,i6)=r2;

.P101L3:
	r8=dm(-3,i6);
	dm(-4,i6)=r8;
.LN453:
// line 1747
	r15=4;
	r4=r8+r15;
.LN454:
	cjump uxListRemove. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ50-1;
.LCJ50:

.LN455:
// line 1757
	i4=dm(-4,i6);
	r2=dm(10,i4);
	r2=pass r2;
	if eq jump (pc,.P101L8);

.LN456:
// line 1759
	r8=dm(-4,i6);
	r12=24;
	r4=r8+r12;
.LN457:
	cjump uxListRemove. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ51-1;
.LCJ51:
.LN458:
// line 1760
	jump (pc,.P101L9);

.P101L8:

.P101L9:
.LN459:
// line 1766
	r8=dm(-4,i6);
	r8=r8+r15;
.LN460:
	r4=xSuspendedTaskList.;
	cjump vListInsertEnd. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ52-1;
.LCJ52:
.LN461:
// line 1772
	dm(-2,i6)=m13;

.P101L10:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 1772 col 17
//-------------------------------------------------------------------
	r2=dm(-2,i6);
	r1=m6;
	comp(r2,r1);
	if ge jump (pc,.P101L12);

.LN462:
// line 1774
	i4=dm(-4,i6);
	i4=modify(i4,92);
	m4=r2;
	r2=dm(m4,i4) (bw);                      // Use of volatile in loops precludes optimizations. 
	r1=m5;
	r2=btgl r2 by r1;
	if not sz jump (pc,.P101L14);

.LN463:
// line 1778
	i4=dm(-4,i6);
	i4=modify(i4,92);
	m4=dm(-2,i6);
	dm(m4,i4)=m13 (bw);                     // Use of volatile in loops precludes optimizations. 
.LN464:
// line 1779
	jump (pc,.P101L15);

.P101L14:

.P101L15:
.LN465:
// line 1772
	r2=dm(-2,i6);
	r2=r2+1;
	dm(-2,i6)=r2;
	jump (pc,.P101L10);
//-------------------------------------------------------------------
//   End Loop L10
//-------------------------------------------------------------------

.P101L12:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN466:
// line 1784
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ53-1;
.LCJ53:
.LN467:
// line 1786
	r2=dm(xSchedulerRunning.);
	r2=pass r2;
	if eq jump (pc,.P101L17);

.LN468:
// line 1790
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ54-1;
.LCJ54:
.LN469:
// line 1792
	cjump prvResetNextTaskUnblockTime. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ55-1;
.LCJ55:
.LN470:
// line 1794
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ56-1;
.LCJ56:
.LN471:
// line 1795
	jump (pc,.P101L18);

.P101L17:

.P101L18:
.LN472:
// line 1801
	r2=dm(-4,i6);
	r1=dm(pxCurrentTCB.);
	comp(r2,r1);
	if ne jump (pc,.P101L20);

.LN473:
// line 1803
	r2=dm(xSchedulerRunning.);
	r2=pass r2;
	if eq jump (pc,.P101L23);

.LN474:
// line 1806
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if eq jump (pc,.P101L26);

.LN475:
	r8=1806;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ57-1;
.LCJ57:
.LN476:
	jump (pc,.P101L27);

.P101L26:

.P101L27:
.LN477:
// line 1807
	dm(_adi_OSWaitingForSched.)=m6;
.LN478:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN479:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P101L29);


.P101L33:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 1807 col 17
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
.LN480:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P101L34);

	jump (pc,.P101L33);
//-------------------------------------------------------------------
//   End Loop L33
//-------------------------------------------------------------------

.P101L34:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN481:
	jump (pc,.P101L30);

.P101L29:

.P101L30:
.LN482:
// line 1808
	jump (pc,.P101L24);

.P101L23:
.LN483:
// line 1814
	r2=dm(xSuspendedTaskList.);
	r1=dm(uxCurrentNumberOfTasks.);
	comp(r2,r1);
	if ne jump (pc,.P101L37);

.LN484:
// line 1820
	dm(pxCurrentTCB.)=m5;
.LN485:
// line 1821
	jump (pc,.P101L38);

.P101L37:
.LN486:
// line 1824
	cjump vTaskSwitchContext. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ58-1;
.LCJ58:

.P101L38:

.P101L24:
.LN487:
// line 1827
	jump (pc,.P101L21);

.P101L20:

.P101L21:
.LN488:
// line 1832
	r15=dm(-6,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskSuspend..end:
.vTaskSuspend..end:
	.global vTaskSuspend.;
	.type vTaskSuspend.,STT_FUNC;

xTaskRemoveFromEventList.:
.LNxTaskRemoveFromEventList.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,mcc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3230
	modify(i7,-8) (nw);
	r2=i5;
	dm(-9,i6)=r2;
	dm(-8,i6)=r4;
	i4=r4;
.LN489:
// line 3247
	i4=dm(3,i4);
	r2=dm(3,i4);
	dm(-7,i6)=r2;
	r2=pass r2;
.LN490:
// line 3248
	if ne jump (pc,.P102L2);

.LN491:
	r8=3248;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ59-1;
.LCJ59:
.LN492:
	jump (pc,.P102L3);

.P102L2:

.P102L3:
.LN493:
// line 3249
	i4=dm(-7,i6);
	r2=dm(10,i4);
	dm(-5,i6)=r2;
.LN494:
	r2=dm(8,i4);
	i4=dm(7,i4);
	dm(2,i4)=r2;
.LN495:
	i4=dm(-7,i6);
	r2=dm(7,i4);
	i4=dm(8,i4);
	dm(m6,i4)=r2;
.LN496:
	i5=dm(-5,i6);
	r2=dm(m6,i5);
	r8=dm(-7,i6);
	r12=24;
	r1=r8+r12;
	comp(r2,r1);
	if ne jump (pc,.P102L5);

	i4=r8;
.LN497:
	r2=dm(8,i4);
	dm(m6,i5)=r2;
.LN498:
	jump (pc,.P102L6);

.P102L5:

.P102L6:
.LN499:
	i4=dm(-7,i6);
	dm(10,i4)=m13;
.LN500:
	i4=dm(-5,i6);
	r2=dm(i4,m5);
	r2=r2-1;
	dm(i4,m5)=r2;
.LN501:
// line 3251
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if ne jump (pc,.P102L8);

.LN502:
// line 3253
	i4=dm(-7,i6);
	r2=dm(5,i4);
	dm(-4,i6)=r2;
.LN503:
	r2=dm(3,i4);
	i4=dm(2,i4);
	dm(2,i4)=r2;
.LN504:
	i4=dm(-7,i6);
	r2=dm(2,i4);
	i4=dm(3,i4);
	dm(m6,i4)=r2;
.LN505:
	i5=dm(-4,i6);
	r2=dm(m6,i5);
	r8=dm(-7,i6);
	r12=4;
	r1=r8+r12;
	comp(r2,r1);
	if ne jump (pc,.P102L11);

	i4=r8;
.LN506:
	r2=dm(3,i4);
	dm(m6,i5)=r2;
.LN507:
	jump (pc,.P102L12);

.P102L11:

.P102L12:
.LN508:
	i4=dm(-7,i6);
	dm(5,i4)=m13;
.LN509:
	i4=dm(-4,i6);
	r2=dm(i4,m5);
	r2=r2-1;
	dm(i4,m5)=r2;
.LN510:
// line 3254
	i4=dm(-7,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);
	compu(r2,r1);
	if le jump (pc,.P102L14);

.LN511:
	i4=dm(-7,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;
.LN512:
	jump (pc,.P102L15);

.P102L14:

.P102L15:
.LN513:
	i5=dm(-7,i6);
	r2=dm(11,i5);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-3,i6)=r2;
.LN514:
	dm(2,i5)=r2;
.LN515:
	i4=dm(-3,i6);
	r2=dm(2,i4);
	i4=dm(-7,i6);
	dm(3,i4)=r2;
.LN516:
	i12=dm(-7,i6);
	i12=modify(i12,4);
	i4=dm(-3,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN517:
	i12=dm(-7,i6);
	i12=modify(i12,4);
	i4=dm(-3,i6);
	dm(2,i4)=i12;
.LN518:
	i4=dm(-7,i6);
	r2=dm(11,i4);
	r8=r2*r1 (ssi);
	r12=pxReadyTasksLists.;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN519:
	i4=dm(-7,i6);
	r2=dm(11,i4);
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN520:
// line 3269
	jump (pc,.P102L9);

.P102L8:
.LN521:
// line 3274
	r2=dm(xPendingReadyList.+4);
	dm(-2,i6)=r2;
.LN522:
	i4=dm(-7,i6);
	dm(7,i4)=r2;
.LN523:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-7,i6);
	dm(8,i4)=r2;
.LN524:
	i12=dm(-7,i6);
	i12=modify(i12,24);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN525:
	i12=dm(-7,i6);
	i12=modify(i12,24);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN526:
	i4=dm(-7,i6);
	i12=xPendingReadyList.;
	dm(10,i4)=i12;
.LN527:
	r2=dm(xPendingReadyList.);
	r2=r2+1;
	dm(xPendingReadyList.)=r2;

.P102L9:
.LN528:
// line 3277
	i4=dm(-7,i6);
	r2=dm(11,i4);
	i4=dm(pxCurrentTCB.);
	r1=dm(11,i4);
	compu(r2,r1);
	if le jump (pc,.P102L17);

.LN529:
// line 3282
	dm(-6,i6)=m14;
.LN530:
// line 3286
	dm(xYieldPending.)=m6;
.LN531:
// line 3287
	jump (pc,.P102L18);

.P102L17:
.LN532:
// line 3290
	dm(-6,i6)=m13;

.P102L18:
.LN533:
// line 3293
	r0=dm(-6,i6);
	i5=dm(-9,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskRemoveFromEventList..end:
.xTaskRemoveFromEventList..end:
	.global xTaskRemoveFromEventList.;
	.type xTaskRemoveFromEventList.,STT_FUNC;

vTaskRemoveFromUnorderedEventList.:
.LNvTaskRemoveFromUnorderedEventList.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,mcc,scc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3299
	modify(i7,-8) (nw);
	r2=i5;
	dm(-8,i6)=r2;
	dm(-6,i6)=r8;
	dm(-7,i6)=r4;
.LN534:
// line 3304
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if ne jump (pc,.P103L2);

.LN535:
	r8=3304;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ60-1;
.LCJ60:
.LN536:
	jump (pc,.P103L3);

.P103L2:

.P103L3:
.LN537:
// line 3307
	r2=dm(-6,i6);
	r1=31;
	r2=bset r2 by r1;
	i4=dm(-7,i6);
	dm(i4,m5)=r2;
.LN538:
// line 3311
	i4=dm(-7,i6);
	r2=dm(3,i4);
	dm(-5,i6)=r2;
	r2=pass r2;
.LN539:
// line 3312
	if ne jump (pc,.P103L5);

.LN540:
	r8=3312;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ61-1;
.LCJ61:
.LN541:
	jump (pc,.P103L6);

.P103L5:

.P103L6:
.LN542:
// line 3313
	i4=dm(-7,i6);
	r2=dm(4,i4);
	dm(-4,i6)=r2;
.LN543:
	r2=dm(2,i4);
	i4=dm(m6,i4);
	dm(2,i4)=r2;
.LN544:
	i4=dm(-7,i6);
	r2=dm(m6,i4);
	i4=dm(2,i4);
	dm(m6,i4)=r2;
.LN545:
	i5=dm(-4,i6);
	r1=dm(m6,i5);
	r2=dm(-7,i6);
	comp(r1,r2);
	if ne jump (pc,.P103L8);

	i4=r2;
.LN546:
	r2=dm(2,i4);
	dm(m6,i5)=r2;
.LN547:
	jump (pc,.P103L9);

.P103L8:

.P103L9:
.LN548:
	i4=dm(-7,i6);
	dm(4,i4)=m13;
.LN549:
	i4=dm(-4,i6);
	r2=dm(i4,m5);
	r2=r2-1;
	dm(i4,m5)=r2;
.LN550:
// line 3332
	i4=dm(-5,i6);
	r2=dm(5,i4);
	dm(-3,i6)=r2;
.LN551:
	r2=dm(3,i4);
	i4=dm(2,i4);
	dm(2,i4)=r2;
.LN552:
	i4=dm(-5,i6);
	r2=dm(2,i4);
	i4=dm(3,i4);
	dm(m6,i4)=r2;
.LN553:
	i5=dm(-3,i6);
	r2=dm(m6,i5);
	r8=dm(-5,i6);
	r12=4;
	r1=r8+r12;
	comp(r2,r1);
	if ne jump (pc,.P103L11);

	i4=r8;
.LN554:
	r2=dm(3,i4);
	dm(m6,i5)=r2;
.LN555:
	jump (pc,.P103L12);

.P103L11:

.P103L12:
.LN556:
	i4=dm(-5,i6);
	dm(5,i4)=m13;
.LN557:
	i4=dm(-3,i6);
	r2=dm(i4,m5);
	r2=r2-1;
	dm(i4,m5)=r2;
.LN558:
// line 3333
	i4=dm(-5,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);
	compu(r2,r1);
	if le jump (pc,.P103L14);

.LN559:
	i4=dm(-5,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;
.LN560:
	jump (pc,.P103L15);

.P103L14:

.P103L15:
.LN561:
	i5=dm(-5,i6);
	r2=dm(11,i5);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN562:
	dm(2,i5)=r2;
.LN563:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-5,i6);
	dm(3,i4)=r2;
.LN564:
	i12=dm(-5,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN565:
	i12=dm(-5,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN566:
	i4=dm(-5,i6);
	r2=dm(11,i4);
	r8=r2*r1 (ssi);
	r12=pxReadyTasksLists.;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN567:
	i4=dm(-5,i6);
	r2=dm(11,i4);
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN568:
// line 3335
	i4=dm(-5,i6);
	r2=dm(11,i4);
	i4=dm(pxCurrentTCB.);
	r1=dm(11,i4);
	compu(r2,r1);
	if le jump (pc,.P103L17);

.LN569:
// line 3341
	dm(xYieldPending.)=m6;
.LN570:
// line 3342
	jump (pc,.P103L18);

.P103L17:

.P103L18:
.LN571:
// line 3343
	i5=dm(-8,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskRemoveFromUnorderedEventList..end:
.vTaskRemoveFromUnorderedEventList..end:
	.global vTaskRemoveFromUnorderedEventList.;
	.type vTaskRemoveFromUnorderedEventList.,STT_FUNC;

vTaskSetTimeOutState.:
.LNvTaskSetTimeOutState.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,r4,r8,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3347
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;
	r2=pass r4;
.LN572:
// line 3348
	if ne jump (pc,.P104L2);

.LN573:
	r8=3348;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ62-1;
.LCJ62:
.LN574:
	jump (pc,.P104L3);

.P104L2:

.P104L3:
.LN575:
// line 3349
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ63-1;
.LCJ63:
.LN576:
// line 3351
	r2=dm(xNumOfOverflows.);
	i4=dm(-2,i6);
	dm(i4,m5)=r2;
.LN577:
// line 3352
	r2=dm(xTickCount.);
	i4=dm(-2,i6);
	dm(m6,i4)=r2;
.LN578:
// line 3354
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ64-1;
.LCJ64:
.LN579:
// line 3355
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskSetTimeOutState..end:
.vTaskSetTimeOutState..end:
	.global vTaskSetTimeOutState.;
	.type vTaskSetTimeOutState.,STT_FUNC;

xTaskCheckForTimeOut.:
.LNxTaskCheckForTimeOut.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3368
	modify(i7,-6) (nw);
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
	r2=pass r4;
.LN580:
// line 3371
	if ne jump (pc,.P105L2);

.LN581:
	r8=3371;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ65-1;
.LCJ65:
.LN582:
	jump (pc,.P105L3);

.P105L2:

.P105L3:
.LN583:
// line 3372
	r2=dm(-5,i6);
	r2=pass r2;
	if ne jump (pc,.P105L5);

.LN584:
	r8=3372;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ66-1;
.LCJ66:
.LN585:
	jump (pc,.P105L6);

.P105L5:

.P105L6:
.LN586:
// line 3374
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ67-1;
.LCJ67:
.LN587:
// line 3377
	r8=dm(xTickCount.);
	dm(-3,i6)=r8;
.LN588:
// line 3378
	i4=dm(-6,i6);
	r12=dm(m6,i4);
	r2=r8-r12;
	dm(-2,i6)=r2;
.LN589:
// line 3392
	i4=dm(-5,i6);
	r2=dm(i4,m5);
	r1=m7;
	comp(r2,r1);
	if ne jump (pc,.P105L8);

.LN590:
// line 3397
	dm(-4,i6)=m13;
.LN591:
// line 3398
	jump (pc,.P105L9);

.P105L8:
.LN592:
// line 3402
	r2=dm(xNumOfOverflows.);
	i4=dm(-6,i6);
	r1=dm(i4,m5);
	comp(r2,r1);
	if eq jump (pc,.P105L11);

	r2=dm(-3,i6);
	r1=dm(m6,i4);
	compu(r2,r1);
	if lt jump (pc,.P105L11);

.LN593:
// line 3409
	dm(-4,i6)=m14;
.LN594:
// line 3410
	i4=dm(-5,i6);
	dm(m5,i4)=m13;
.LN595:
// line 3411
	jump (pc,.P105L12);

.P105L11:
.LN596:
// line 3412
	r2=dm(-2,i6);
	i4=dm(-5,i6);
	r1=dm(i4,m5);
	compu(r1,r2);
	if le jump (pc,.P105L15);

.LN597:
// line 3415
	r12=dm(-2,i6);
	r8=dm(i4,m5);
	r2=r8-r12;
	dm(i4,m5)=r2;
.LN598:
// line 3416
	r4=dm(-6,i6);
.LN599:
	cjump vTaskInternalSetTimeOutState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ68-1;
.LCJ68:
.LN600:
// line 3417
	dm(-4,i6)=m13;
.LN601:
// line 3418
	jump (pc,.P105L16);

.P105L15:
.LN602:
// line 3421
	dm(m5,i4)=m13;
.LN603:
// line 3422
	dm(-4,i6)=m14;

.P105L16:

.P105L12:

.P105L9:
.LN604:
// line 3425
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ69-1;
.LCJ69:
.LN605:
// line 3427
	r0=dm(-4,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskCheckForTimeOut..end:
.xTaskCheckForTimeOut..end:
	.global xTaskCheckForTimeOut.;
	.type xTaskCheckForTimeOut.,STT_FUNC;

vTaskSetThreadLocalStoragePointer.:
.LNvTaskSetThreadLocalStoragePointer.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r2,r4,r8,i4,i12,m4,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3660
	modify(i7,-6) (nw);
	dm(-4,i6)=r12;
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
	r2=pass r8;
.LN606:
// line 3663
	if lt jump (pc,.P106L2);

	r2=m6;
	comp(r8,r2);
	if ge jump (pc,.P106L2);

	r2=pass r4;
.LN607:
// line 3666
	if ne jump (pc,.P106L6);

	r2=dm(pxCurrentTCB.);
	dm(-2,i6)=r2;
	jump (pc,.P106L7);

.P106L6:
	dm(-2,i6)=r4;

.P106L7:
	r2=dm(-2,i6);
	dm(-3,i6)=r2;
	r2=pass r2;
.LN608:
// line 3667
	if ne jump (pc,.P106L9);

.LN609:
	r8=3667;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ70-1;
.LCJ70:
.LN610:
	jump (pc,.P106L10);

.P106L9:

.P106L10:
.LN611:
// line 3668
	r2=dm(-4,i6);
	i4=dm(-3,i6);
	i4=modify(i4,84);
	m4=dm(-5,i6);
	dm(m4,i4)=r2;
.LN612:
// line 3669
	jump (pc,.P106L3);

.P106L2:

.P106L3:
.LN613:
// line 3670
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskSetThreadLocalStoragePointer..end:
.vTaskSetThreadLocalStoragePointer..end:
	.global vTaskSetThreadLocalStoragePointer.;
	.type vTaskSetThreadLocalStoragePointer.,STT_FUNC;

prvInitialiseTaskLists.:
.LNprvInitialiseTaskLists.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,mcc}
//  Call preserved registers used: {r14-r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3718
	modify(i7,-4) (nw);
	dm(-4,i6)=r14;
	dm(-3,i6)=r15;
.LN614:
// line 3721
	dm(-2,i6)=m13;

.P107L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 3721 col 5
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 17 
//   cycles (includes 2 stalls but excludes the cost of function calls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used  10 out of   17 ( 58.8%)
//     multifunction float multiply    used  10 out of   17 ( 58.8%)
//     dm dag                          used   9 out of   17 ( 52.9%)
//     multifunction integer add sub   used   9 out of   17 ( 52.9%)
//     multifunction integer multiply  used   9 out of   17 ( 52.9%)
//     multifunction mult              used   9 out of   17 ( 52.9%)
//     pm dag                          used   9 out of   17 ( 52.9%)
//     shift immediate                 used   9 out of   17 ( 52.9%)
//     memory access                   used   9 out of   34 ( 26.5%)
//-------------------------------------------------------------------
	// -- 2 stalls --
	r2=dm(-2,i6);
	r1=7;
	compu(r2,r1);
	if ge jump (pc,.P107L3);

.LN615:
// line 3723
	r1=20;
	r12=r2*r1 (ssi);
	r8=pxReadyTasksLists.;
	r4=r8+r12;
.LN616:
	cjump vListInitialise. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ71-1;
.LCJ71:
.LN617:
// line 3721
	r2=dm(-2,i6);
	r2=r2+1;
	dm(-2,i6)=r2;
	jump (pc,.P107L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P107L3:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN618:
// line 3726
	r15=xDelayedTaskList1.;
	r4=r15;
	cjump vListInitialise. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ72-1;
.LCJ72:
.LN619:
// line 3727
	r14=xDelayedTaskList2.;
	r4=r14;
	cjump vListInitialise. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ73-1;
.LCJ73:
.LN620:
// line 3728
	r4=xPendingReadyList.;
	cjump vListInitialise. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ74-1;
.LCJ74:
.LN621:
// line 3732
	r4=xTasksWaitingTermination.;
	cjump vListInitialise. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ75-1;
.LCJ75:
.LN622:
// line 3738
	r4=xSuspendedTaskList.;
	cjump vListInitialise. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ76-1;
.LCJ76:
	i4=r15;
.LN623:
// line 3744
	dm(pxDelayedTaskList.)=i4;
	i4=r14;
.LN624:
// line 3745
	dm(pxOverflowDelayedTaskList.)=i4;
.LN625:
// line 3746
	r14=dm(-4,i6);
	r15=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvInitialiseTaskLists..end:
.prvInitialiseTaskLists..end:
	.type prvInitialiseTaskLists.,STT_FUNC;

prvAddNewTaskToReadyList.:
.LNprvAddNewTaskToReadyList.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,mcc,scc,btf}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1065
	modify(i7,-4) (nw);
	r2=i5;
	dm(-4,i6)=r2;
	dm(-3,i6)=r4;
.LN626:
// line 1068
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ77-1;
.LCJ77:
.LN627:
// line 1070
	r2=dm(uxCurrentNumberOfTasks.);
	r2=r2+1;
	dm(uxCurrentNumberOfTasks.)=r2;
.LN628:
// line 1072
	r2=dm(pxCurrentTCB.);
	r2=pass r2;
	if ne jump (pc,.P109L2);

.LN629:
// line 1076
	r2=dm(-3,i6);
	dm(pxCurrentTCB.)=r2;
.LN630:
// line 1078
	r2=dm(uxCurrentNumberOfTasks.);
	r1=m5;
	r2=btgl r2 by r1;
	if not sz jump (pc,.P109L5);

.LN631:
// line 1083
	cjump prvInitialiseTaskLists. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ78-1;
.LCJ78:
.LN632:
// line 1084
	jump (pc,.P109L6);

.P109L5:

.P109L6:
.LN633:
// line 1089
	jump (pc,.P109L3);

.P109L2:
.LN634:
// line 1095
	r2=dm(xSchedulerRunning.);
	r2=pass r2;
	if ne jump (pc,.P109L8);

.LN635:
// line 1097
	i4=dm(pxCurrentTCB.);
	r2=dm(11,i4);
	i4=dm(-3,i6);
	r1=dm(11,i4);
	compu(r1,r2);
	if lt jump (pc,.P109L11);

.LN636:
// line 1099
	r2=dm(-3,i6);
	dm(pxCurrentTCB.)=r2;
.LN637:
// line 1100
	jump (pc,.P109L12);

.P109L11:

.P109L12:
.LN638:
// line 1105
	jump (pc,.P109L9);

.P109L8:

.P109L9:

.P109L3:
.LN639:
// line 1112
	r2=dm(uxTaskNumber.);
	r2=r2+1;
	dm(uxTaskNumber.)=r2;
.LN640:
// line 1117
	i4=dm(-3,i6);
	dm(16,i4)=r2;
.LN641:
// line 1122
	i4=dm(-3,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);
	compu(r2,r1);
	if le jump (pc,.P109L14);

.LN642:
	i4=dm(-3,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;
.LN643:
	jump (pc,.P109L15);

.P109L14:

.P109L15:
.LN644:
	i5=dm(-3,i6);
	r2=dm(11,i5);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN645:
	dm(2,i5)=r2;
.LN646:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-3,i6);
	dm(3,i4)=r2;
.LN647:
	i12=dm(-3,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN648:
	i12=dm(-3,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN649:
	i4=dm(-3,i6);
	r2=dm(11,i4);
	r8=r2*r1 (ssi);
	r12=pxReadyTasksLists.;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN650:
	i4=dm(-3,i6);
	r2=dm(11,i4);
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN651:
// line 1124
	i4=dm(-3,i6);
	r4=dm(i4,m5);
	r8=dm(12,i4);
.LN652:
	cjump vPortFixupStack. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ79-1;
.LCJ79:
.LN653:
// line 1126
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ80-1;
.LCJ80:
.LN654:
// line 1128
	r2=dm(xSchedulerRunning.);
	r2=pass r2;
	if eq jump (pc,.P109L17);

.LN655:
// line 1132
	i4=dm(pxCurrentTCB.);
	r2=dm(11,i4);
	i4=dm(-3,i6);
	r1=dm(11,i4);
	compu(r1,r2);
	if le jump (pc,.P109L20);

.LN656:
// line 1134
	dm(_adi_OSWaitingForSched.)=m6;
.LN657:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN658:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P109L23);


.P109L27:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 1134 col 13
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
.LN659:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P109L28);

	jump (pc,.P109L27);
//-------------------------------------------------------------------
//   End Loop L27
//-------------------------------------------------------------------

.P109L28:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN660:
	jump (pc,.P109L24);

.P109L23:

.P109L24:
.LN661:
// line 1135
	jump (pc,.P109L21);

.P109L20:

.P109L21:
.LN662:
// line 1140
	jump (pc,.P109L18);

.P109L17:

.P109L18:
.LN663:
// line 1145
	i5=dm(-4,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvAddNewTaskToReadyList..end:
.prvAddNewTaskToReadyList..end:
	.type prvAddNewTaskToReadyList.,STT_FUNC;

xTaskCreateStatic.:
.LNxTaskCreateStatic.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 64 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc}
//  Call preserved registers used: {r15,i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":603
	modify(i7,-8) (nw);
	dm(-9,i6)=r15;
	r2=i5;
	dm(-8,i6)=r2;
	r2=dm(m6,i6);
	r1=dm(2,i6);
	r0=dm(3,i6);
	r15=dm(4,i6);
	dm(4,i6)=r15;
	dm(3,i6)=r0;
	dm(2,i6)=r1;
	dm(m6,i6)=r2;
	dm(-5,i6)=r12;
	dm(-6,i6)=r8;
	dm(-7,i6)=r4;
	r2=pass r0;
.LN664:
// line 607
	if ne jump (pc,.P111L2);

.LN665:
	r8=607;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ81-1;
.LCJ81:
.LN666:
	jump (pc,.P111L3);

.P111L2:

.P111L3:
.LN667:
// line 608
	r2=dm(4,i6);
	r2=pass r2;
	if ne jump (pc,.P111L5);

.LN668:
	r8=608;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ82-1;
.LCJ82:
.LN669:
	jump (pc,.P111L6);

.P111L5:

.P111L6:
.LN670:
// line 615
	i5=modify(i6,-2) (nw);
	i12=96;
	dm(m5,i5)=i12;
.LN671:
// line 616
	r2=dm(i5,m5);
	r15=96;
	comp(r2,r15);
	if eq jump (pc,.P111L8);

.LN672:
	r8=616;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ83-1;
.LCJ83:
.LN673:
	jump (pc,.P111L9);

.P111L8:

.P111L9:
.LN674:
// line 617
	r2=dm(i5,m5);
.LN675:
// line 621
	r4=dm(4,i6);
	r2=pass r4;
	if eq jump (pc,.P111L11);

	r2=dm(3,i6);
	r2=pass r2;
	if eq jump (pc,.P111L11);

.LN676:
// line 625
	dm(-4,i6)=r4;
.LN677:
// line 626
	r8=m5;
	r12=96;
	cjump __simd_memsetD. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ84-1;
.LCJ84:
.LN678:
// line 627
	r2=dm(3,i6);
	i4=dm(-4,i6);
	dm(12,i4)=r2;
.LN679:
// line 633
	i4=dm(-4,i6);
	i4=modify(i4,93);
	i12=2;
	dm(m5,i4)=i12 (bw);
.LN680:
// line 637
	r4=dm(-7,i6);
	r8=dm(-6,i6);
	r12=dm(-5,i6);
	r1=dm(m6,i6);
	r0=dm(2,i6);
	r15=dm(-4,i6);
.LN681:
	i4=modify(i6,-3) (nw);
	r2=i4;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=r15;
	dm(i7,m7)=r2;
	dm(i7,m7)=r0;
	dm(i7,m7)=r1;
	cjump prvInitialiseNewTask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ85-1;
.LCJ85:
	modify(i7,6) (nw);
.LN682:
// line 638
	r4=dm(-4,i6);
.LN683:
	cjump prvAddNewTaskToReadyList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ86-1;
.LCJ86:
.LN684:
// line 639
	jump (pc,.P111L12);

.P111L11:
.LN685:
// line 642
	dm(-3,i6)=m13;

.P111L12:
.LN686:
// line 645
	r0=dm(-3,i6);
	i5=dm(-8,i6);
	r15=dm(-9,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskCreateStatic..end:
.xTaskCreateStatic..end:
	.global xTaskCreateStatic.;
	.type xTaskCreateStatic.,STT_FUNC;

vTaskStartScheduler.:
.LNvTaskStartScheduler.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 56 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,scc}
//  Call preserved registers used: {r15,i3,i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":2015
	modify(i7,-8) (nw);
	dm(-8,i6)=r15;
	r2=i3;
	dm(-7,i6)=r2;
	r2=i5;
	dm(-6,i6)=r2;
.LN687:
// line 2021
	dm(-4,i6)=m13;
.LN688:
// line 2022
	dm(-3,i6)=m13;
.LN689:
// line 2027
	i3=modify(i6,-4) (nw);
	i5=modify(i6,-3) (nw);
	i4=modify(i6,-2) (nw);
	r12=i4;
	r8=i5;
	r4=i3;
	cjump vApplicationGetIdleTaskMemory. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ87-1;
.LCJ87:
.LN690:
// line 2028
	r12=dm(-2,i6);
	r2=dm(-3,i6);
	r1=dm(-4,i6);
.LN691:
	r8=.sIDLE.1;
	r4=prvIdleTask.;
	dm(i7,m7)=r1;
	dm(i7,m7)=r2;
	dm(i7,m7)=m13;
	dm(i7,m7)=m13;
	cjump xTaskCreateStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ88-1;
.LCJ88:
	modify(i7,4) (nw);
.LN692:
	dm(xIdleTaskHandle.)=r0;
	r2=pass r0;
.LN693:
// line 2036
	if eq jump (pc,.P113L2);

.LN694:
// line 2038
	dm(-5,i6)=m14;
.LN695:
// line 2039
	jump (pc,.P113L3);

.P113L2:
.LN696:
// line 2042
	dm(-5,i6)=m13;

.P113L3:
.LN697:
// line 2059
	r2=dm(-5,i6);
	r15=m5;
	r2=btgl r2 by r15;
	if not sz jump (pc,.P113L5);

.LN698:
// line 2061
	cjump xTimerCreateTimerTask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ89-1;
.LCJ89:
.LN699:
	dm(-5,i6)=r0;
.LN700:
// line 2062
	jump (pc,.P113L6);

.P113L5:

.P113L6:
.LN701:
// line 2070
	r2=dm(-5,i6);
	r1=btgl r2 by r15;
	if not sz jump (pc,.P113L8);

.LN702:
// line 2086
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ90-1;
.LCJ90:
.LN703:
// line 2096
	dm(xNextTaskUnblockTime.)=m7;
.LN704:
// line 2097
	dm(xSchedulerRunning.)=m6;
.LN705:
// line 2098
	dm(xTickCount.)=m5;
.LN706:
// line 2112
	cjump xPortStartScheduler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ91-1;
.LCJ91:
.LN707:
// line 2120
	jump (pc,.P113L9);

.P113L8:
	r1=m7;
	comp(r2,r1);
.LN708:
// line 2126
	if ne jump (pc,.P113L11);

.LN709:
	r8=2126;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ92-1;
.LCJ92:
.LN710:
	jump (pc,.P113L12);

.P113L11:

.P113L12:

.P113L9:
.LN711:
// line 2135
	r2=dm(uxTopUsedPriority.);
.LN712:
// line 2136
	i3=dm(-7,i6);
	i5=dm(-6,i6);
	r15=dm(-8,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskStartScheduler..end:
.vTaskStartScheduler..end:
	.global vTaskStartScheduler.;
	.type vTaskStartScheduler.,STT_FUNC;

xTaskCreate.:
.LNxTaskCreate.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 64 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":759
	modify(i7,-8) (nw);
	dm(-8,i6)=r15;
	r2=dm(m6,i6);
	r1=dm(2,i6);
	r0=dm(3,i6);
	dm(3,i6)=r0;
	dm(2,i6)=r1;
	dm(m6,i6)=r2;
	dm(-10,i6)=r12 (sw);
	dm(-6,i6)=r8;
	dm(-7,i6)=r4;
.LN713:
// line 795
	r4=lshift r12 by 2;
.LN714:
	cjump pvPortMalloc. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ93-1;
.LCJ93:
.LN715:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN716:
// line 797
	if eq jump (pc,.P118L2);

.LN717:
// line 800
	r4=96;
	cjump pvPortMalloc. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ94-1;
.LCJ94:
	r4=r0;
.LN718:
	dm(-4,i6)=r0;
	r2=pass r0;
.LN719:
// line 802
	if eq jump (pc,.P118L5);

.LN720:
// line 804
	r8=m5;
	r12=96;
	cjump __simd_memsetD. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ95-1;
.LCJ95:
.LN721:
// line 807
	r2=dm(-2,i6);
	i4=dm(-4,i6);
	dm(12,i4)=r2;
.LN722:
// line 808
	jump (pc,.P118L6);

.P118L5:
.LN723:
// line 813
	r4=dm(-2,i6);
.LN724:
	cjump vPortFree. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ96-1;
.LCJ96:

.P118L6:
.LN725:
// line 815
	jump (pc,.P118L3);

.P118L2:
.LN726:
// line 818
	dm(-4,i6)=m13;

.P118L3:
.LN727:
// line 823
	r2=dm(-4,i6);
	r2=pass r2;
	if eq jump (pc,.P118L8);

	i4=r2;
.LN728:
// line 829
	i4=modify(i4,93);
	dm(m5,i4)=m13 (bw);
.LN729:
// line 833
	r4=dm(-7,i6);
	r8=dm(-6,i6);
	r12=dm(-10,i6) (sw);
	r2=dm(m6,i6);
	r1=dm(2,i6);
	r0=dm(3,i6);
	r15=dm(-4,i6);
.LN730:
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=r15;
	dm(i7,m7)=r0;
	dm(i7,m7)=r1;
	dm(i7,m7)=r2;
	cjump prvInitialiseNewTask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ97-1;
.LCJ97:
	modify(i7,6) (nw);
.LN731:
// line 834
	r4=dm(-4,i6);
.LN732:
	cjump prvAddNewTaskToReadyList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ98-1;
.LCJ98:
.LN733:
// line 835
	dm(-3,i6)=m14;
.LN734:
// line 836
	jump (pc,.P118L9);

.P118L8:
.LN735:
// line 839
	dm(-3,i6)=m15;

.P118L9:
.LN736:
// line 842
	r0=dm(-3,i6);
	r15=dm(-8,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskCreate..end:
.xTaskCreate..end:
	.global xTaskCreate.;
	.type xTaskCreate.,STT_FUNC;

vTaskGetInfo.:
.LNvTaskGetInfo.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,r4,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3783
	modify(i7,-6) (nw);
	r2=dm(m6,i6);
	dm(m6,i6)=r2;
	dm(-4,i6)=r12;
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
	r2=pass r4;
.LN737:
// line 3787
	if ne jump (pc,.P121L2);

	r2=dm(pxCurrentTCB.);
	dm(-2,i6)=r2;
	jump (pc,.P121L3);

.P121L2:
	dm(-2,i6)=r4;

.P121L3:
	r2=dm(-2,i6);
	dm(-3,i6)=r2;
.LN738:
// line 3789
	i4=dm(-5,i6);
	dm(i4,m5)=r2;
.LN739:
// line 3790
	i12=dm(-3,i6);
	i12=modify(i12,52);
	i4=dm(-5,i6);
	dm(m6,i4)=i12;
.LN740:
// line 3791
	i4=dm(-3,i6);
	r2=dm(11,i4);
	i4=dm(-5,i6);
	dm(4,i4)=r2;
.LN741:
// line 3792
	i4=dm(-3,i6);
	r2=dm(12,i4);
	i4=dm(-5,i6);
	dm(7,i4)=r2;
.LN742:
// line 3797
	i4=dm(-3,i6);
	r2=dm(16,i4);
	i4=dm(-5,i6);
	dm(2,i4)=r2;
.LN743:
// line 3801
	i4=dm(-3,i6);
	r2=dm(18,i4);
	i4=dm(-5,i6);
	dm(5,i4)=r2;
.LN744:
// line 3815
	i4=dm(-5,i6);
	dm(6,i4)=m13;
.LN745:
// line 3822
	r2=dm(m6,i6);
	r1=5;
	comp(r2,r1);
	if eq jump (pc,.P121L5);

.LN746:
// line 3824
	r2=dm(-3,i6);
	r1=dm(pxCurrentTCB.);
	comp(r2,r1);
	if ne jump (pc,.P121L8);

.LN747:
// line 3826
	i4=dm(-5,i6);
	dm(3,i4)=m13;
.LN748:
// line 3827
	jump (pc,.P121L9);

.P121L8:
.LN749:
// line 3830
	r2=dm(m6,i6);
	i4=dm(-5,i6);
	dm(3,i4)=r2;
.LN750:
// line 3837
	r2=dm(m6,i6);
	r1=3;
	comp(r2,r1);
	if ne jump (pc,.P121L11);

.LN751:
// line 3839
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ99-1;
.LCJ99:
.LN752:
// line 3841
	i4=dm(-3,i6);
	r2=dm(10,i4);
	r2=pass r2;
	if eq jump (pc,.P121L14);

.LN753:
// line 3843
	i4=dm(-5,i6);
	i12=2;
	dm(3,i4)=i12;
.LN754:
// line 3844
	jump (pc,.P121L15);

.P121L14:

.P121L15:
.LN755:
// line 3846
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ100-1;
.LCJ100:
.LN756:
// line 3847
	jump (pc,.P121L12);

.P121L11:

.P121L12:

.P121L9:
.LN757:
// line 3851
	jump (pc,.P121L6);

.P121L5:
.LN758:
// line 3854
	r4=dm(-3,i6);
.LN759:
	cjump eTaskGetState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ101-1;
.LCJ101:
.LN760:
	i4=dm(-5,i6);
	dm(3,i4)=r0;

.P121L6:
.LN761:
// line 3859
	r2=dm(-4,i6);
	r2=pass r2;
	if eq jump (pc,.P121L17);

.LN762:
// line 3867
	i4=dm(-3,i6);
	r4=dm(12,i4);
.LN763:
	cjump prvTaskCheckFreeStackSpace. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ102-1;
.LCJ102:
.LN764:
	i4=dm(-5,i6);
	dm(16,i4)=r0 (sw);
.LN765:
// line 3870
	jump (pc,.P121L18);

.P121L17:
.LN766:
// line 3873
	i4=dm(-5,i6);
	i4=modify(i4,32);
	dm(m5,i4)=m13 (sw);

.P121L18:
.LN767:
// line 3875
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskGetInfo..end:
.vTaskGetInfo..end:
	.global vTaskGetInfo.;
	.type vTaskGetInfo.,STT_FUNC;

prvListTasksWithinSingleList.:
.LNprvListTasksWithinSingleList.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 56 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,mcc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3885
	modify(i7,-10) (nw);
	r2=i5;
	dm(-10,i6)=r2;
	i4=r8;
	dm(-7,i6)=r12;
	dm(-8,i6)=r8;
	dm(-9,i6)=r4;
.LN768:
// line 3888
	dm(-4,i6)=m13;
.LN769:
// line 3890
	r2=dm(i4,m5);
	r2=pass r2;
	if eq jump (pc,.P122L2);

.LN770:
// line 3892
	i4=dm(-8,i6);
	r2=i4;
	dm(-3,i6)=r2;
.LN771:
	i5=dm(m6,i4);
	r2=dm(m6,i5);
	dm(m6,i4)=r2;
.LN772:
	i5=dm(-3,i6);
	r1=dm(m6,i5);
	i4=modify(i5,8);
	r2=i4;
	comp(r1,r2);
	if ne jump (pc,.P122L5);

	i4=r1;
.LN773:
	r2=dm(m6,i4);
	dm(m6,i5)=r2;
.LN774:
	jump (pc,.P122L6);

.P122L5:

.P122L6:
.LN775:
	i4=dm(-3,i6);
	i4=dm(m6,i4);
	r2=dm(3,i4);
	dm(-5,i6)=r2;
.LN776:
// line 3898
	jump (pc,.P122L7);

.P122L12:
//-------------------------------------------------------------------
//   Part of Loop 7, depth 1
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//   End Loop L7
//-------------------------------------------------------------------

.P122L7:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 3898 col 13
//-------------------------------------------------------------------
.LN777:
// line 3900
	i4=dm(-8,i6);
	r2=i4;
	dm(-2,i6)=r2;
.LN778:
	i5=dm(m6,i4);
	r2=dm(m6,i5);
	dm(m6,i4)=r2;
.LN779:
	i5=dm(-2,i6);
	r1=dm(m6,i5);
	i4=modify(i5,8);
	r2=i4;
	comp(r1,r2);
	if ne jump (pc,.P122L9);

	i4=r1;
.LN780:
	r2=dm(m6,i4);
	dm(m6,i5)=r2;
.LN781:
	jump (pc,.P122L10);

.P122L9:

.P122L10:
.LN782:
	i4=dm(-2,i6);
	i4=dm(m6,i4);
	r4=dm(3,i4);
	dm(-6,i6)=r4;
.LN783:
// line 3901
	r2=dm(-9,i6);
	r1=dm(-4,i6);
	r0=36;
	r1=r1*r0 (ssi);
	r8=r2+r1;
	r2=dm(-7,i6);
.LN784:
	r12=m6;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	cjump vTaskGetInfo. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ103-1;
.LCJ103:
	modify(i7,2) (nw);
.LN785:
// line 3902
	r2=dm(-4,i6);
	r2=r2+1;
	dm(-4,i6)=r2;
.LN786:
// line 3903
	r2=dm(-6,i6);
	r1=dm(-5,i6);
	comp(r2,r1);
	if ne jump (pc,.P122L12);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN787:
// line 3904
	jump (pc,.P122L3);

.P122L2:

.P122L3:
.LN788:
// line 3910
	r0=dm(-4,i6);
	i5=dm(-10,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvListTasksWithinSingleList..end:
.prvListTasksWithinSingleList..end:
	.type prvListTasksWithinSingleList.,STT_FUNC;

uxTaskGetSystemState.:
.LNuxTaskGetSystemState.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,mcc}
//  Call preserved registers used: {r14}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":2552
	modify(i7,-6) (nw);
	dm(-7,i6)=r14;
	dm(-4,i6)=r12;
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
.LN789:
// line 2553
	dm(-3,i6)=m13;
.LN790:
	i12=7;
	dm(-2,i6)=i12;
.LN791:
// line 2555
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ104-1;
.LCJ104:
.LN792:
// line 2558
	r2=dm(-5,i6);
	r1=dm(uxCurrentNumberOfTasks.);
	compu(r2,r1);
	if lt jump (pc,.P123L2);

.LN793:
// line 2562
	jump (pc,.P123L4);

.P123L9:
//-------------------------------------------------------------------
//   Part of Loop 4, depth 1
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//   End Loop L4
//-------------------------------------------------------------------

.P123L4:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 2562 col 17
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 25 
//   cycles (includes 3 stalls but excludes the cost of function calls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used  13 out of   25 ( 52.0%)
//     pm dag                          used  13 out of   25 ( 52.0%)
//     shift immediate                 used  13 out of   25 ( 52.0%)
//     multifunction alu               used  12 out of   25 ( 48.0%)
//     multifunction float multiply    used  12 out of   25 ( 48.0%)
//     multifunction integer add sub   used  11 out of   25 ( 44.0%)
//     multifunction integer multiply  used  11 out of   25 ( 44.0%)
//     multifunction mult              used  11 out of   25 ( 44.0%)
//     memory access                   used  13 out of   50 ( 26.0%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN794:
// line 2564
	r2=dm(-2,i6);
	r2=r2-1;
	dm(-2,i6)=r2;
.LN795:
// line 2565
	r1=dm(-6,i6);
	r0=dm(-3,i6);
	r14=36;
	r0=r0*r14 (ssi);
	// -- stall --
	r4=r1+r0;
	r1=20;
	r8=r2*r1 (ssi);
	r12=pxReadyTasksLists.;
	r8=r8+r12;
.LN796:
	r12=m6;
	cjump prvListTasksWithinSingleList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ105-1;
.LCJ105:
.LN797:
	r2=dm(-3,i6);
	r2=r0+r2;
	dm(-3,i6)=r2;
.LN798:
// line 2566
	r2=dm(-2,i6);
	r2=pass r2;
	if ne jump (pc,.P123L9);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN799:
// line 2570
	r2=dm(-6,i6);
	r1=dm(-3,i6);
	r1=r1*r14 (ssi);
	r4=r2+r1;
	r8=dm(pxDelayedTaskList.);
.LN800:
	r12=2;
	cjump prvListTasksWithinSingleList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ106-1;
.LCJ106:
.LN801:
	r2=dm(-3,i6);
	r2=r0+r2;
	dm(-3,i6)=r2;
.LN802:
// line 2571
	r12=dm(-6,i6);
	r8=r2*r14 (ssi);
	r4=r8+r12;
	r8=dm(pxOverflowDelayedTaskList.);
.LN803:
	r12=2;
	cjump prvListTasksWithinSingleList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ107-1;
.LCJ107:
.LN804:
	r2=dm(-3,i6);
	r2=r0+r2;
	dm(-3,i6)=r2;
.LN805:
// line 2577
	r12=dm(-6,i6);
	r8=r2*r14 (ssi);
	r4=r8+r12;
.LN806:
	r12=4;
	r8=xTasksWaitingTermination.;
	cjump prvListTasksWithinSingleList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ108-1;
.LCJ108:
.LN807:
	r2=dm(-3,i6);
	r2=r0+r2;
	dm(-3,i6)=r2;
.LN808:
// line 2585
	r12=dm(-6,i6);
	r8=r2*r14 (ssi);
	r4=r8+r12;
.LN809:
	r12=3;
	r8=xSuspendedTaskList.;
	cjump prvListTasksWithinSingleList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ109-1;
.LCJ109:
.LN810:
	r2=dm(-3,i6);
	r2=r0+r2;
	dm(-3,i6)=r2;
.LN811:
// line 2602
	r2=dm(-4,i6);
	r2=pass r2;
	if eq jump (pc,.P123L7);

	i4=r2;
.LN812:
// line 2604
	dm(m5,i4)=m13;
.LN813:
// line 2605
	jump (pc,.P123L8);

.P123L7:

.P123L8:
.LN814:
// line 2608
	jump (pc,.P123L3);

.P123L2:

.P123L3:
.LN815:
// line 2614
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ110-1;
.LCJ110:
.LN816:
// line 2616
	r0=dm(-3,i6);
	r14=dm(-7,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.uxTaskGetSystemState..end:
.uxTaskGetSystemState..end:
	.global uxTaskGetSystemState.;
	.type uxTaskGetSystemState.,STT_FUNC;

prvDeleteTCB.:
.LNprvDeleteTCB.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r1-r2,r4,r8,i4,i12,acc,scc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":4007
	modify(i7,-2) (nw);
	r2=i5;
	dm(-3,i6)=r2;
	dm(-2,i6)=r4;
	i4=r4;
.LN817:
// line 4032
	i5=modify(i4,93);
	r2=dm(m5,i5) (bw);
	r2=pass r2;
	if ne jump (pc,.P124L2);

.LN818:
// line 4036
	r4=dm(12,i4);
.LN819:
	cjump vPortFree. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ111-1;
.LCJ111:
.LN820:
// line 4037
	r4=dm(-2,i6);
.LN821:
	cjump vPortFree. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ112-1;
.LCJ112:
.LN822:
// line 4038
	jump (pc,.P124L3);

.P124L2:
	r1=m5;
	r1=btgl r2 by r1;
.LN823:
// line 4039
	if not sz jump (pc,.P124L5);

.LN824:
// line 4043
	cjump vPortFree. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ113-1;
.LCJ113:
.LN825:
// line 4044
	jump (pc,.P124L6);

.P124L5:
	r1=m6;
	r2=btgl r2 by r1;
.LN826:
// line 4049
	if sz jump (pc,.P124L8);

.LN827:
	r8=4049;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ114-1;
.LCJ114:
.LN828:
	jump (pc,.P124L9);

.P124L8:

.P124L9:

.P124L6:

.P124L3:
.LN829:
// line 4054
	i5=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvDeleteTCB..end:
.prvDeleteTCB..end:
	.type prvDeleteTCB.,STT_FUNC;

vTaskDelete.:
.LNvTaskDelete.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,btf}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1162
	modify(i7,-4) (nw);
	dm(-5,i6)=r15;
	dm(-4,i6)=r4;
.LN830:
// line 1165
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ115-1;
.LCJ115:
.LN831:
// line 1169
	r2=dm(-4,i6);
	r2=pass r2;
	if ne jump (pc,.P125L2);

	r2=dm(pxCurrentTCB.);
	dm(-2,i6)=r2;
	jump (pc,.P125L3);

.P125L2:
	dm(-2,i6)=r2;

.P125L3:
	r8=dm(-2,i6);
	dm(-3,i6)=r8;
.LN832:
// line 1172
	r15=4;
	r4=r8+r15;
.LN833:
	cjump uxListRemove. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ116-1;
.LCJ116:

.LN834:
// line 1182
	i4=dm(-3,i6);
	r2=dm(10,i4);
	r2=pass r2;
	if eq jump (pc,.P125L8);

.LN835:
// line 1184
	r8=dm(-3,i6);
	r12=24;
	r4=r8+r12;
.LN836:
	cjump uxListRemove. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ117-1;
.LCJ117:
.LN837:
// line 1185
	jump (pc,.P125L9);

.P125L8:

.P125L9:
.LN838:
// line 1195
	r2=dm(uxTaskNumber.);
	r2=r2+1;
	dm(uxTaskNumber.)=r2;
.LN839:
// line 1202
	i4=dm(-3,i6);
	r2=dm(20,i4);
	r2=pass r2;
	if eq jump (pc,.P125L11);

.LN840:
// line 1204
	r4=dm(21,i4);
	i12=dm(20,i4);
.LN841:
	r2=i6; i6=i7; jump (m13,i12) (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ118-1;
.LCJ118:
.LN842:
// line 1205
	jump (pc,.P125L12);

.P125L11:

.P125L12:
.LN843:
// line 1208
	r2=dm(-3,i6);
	r1=dm(pxCurrentTCB.);
	comp(r2,r1);
	if ne jump (pc,.P125L14);

.LN844:
// line 1215
	r8=dm(-3,i6);
	r8=r8+r15;
.LN845:
	r4=xTasksWaitingTermination.;
	cjump vListInsertEnd. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ119-1;
.LCJ119:
.LN846:
// line 1220
	r2=dm(uxDeletedTasksWaitingCleanUp.);
	r2=r2+1;
	dm(uxDeletedTasksWaitingCleanUp.)=r2;
.LN847:
// line 1232
	jump (pc,.P125L15);

.P125L14:
.LN848:
// line 1235
	r2=dm(uxCurrentNumberOfTasks.);
	r2=r2-1;
	dm(uxCurrentNumberOfTasks.)=r2;
.LN849:
// line 1240
	cjump prvResetNextTaskUnblockTime. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ120-1;
.LCJ120:

.P125L15:
.LN850:
// line 1243
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ121-1;
.LCJ121:
.LN851:
// line 1248
	r2=dm(-3,i6);
	r1=dm(pxCurrentTCB.);
	comp(r2,r1);
	if eq jump (pc,.P125L17);

.LN852:
// line 1250
	r4=dm(-3,i6);
.LN853:
	cjump prvDeleteTCB. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ122-1;
.LCJ122:
.LN854:
// line 1251
	jump (pc,.P125L18);

.P125L17:

.P125L18:
.LN855:
// line 1255
	r2=dm(xSchedulerRunning.);
	r2=pass r2;
	if eq jump (pc,.P125L20);

.LN856:
// line 1257
	r2=dm(-3,i6);
	r1=dm(pxCurrentTCB.);
	comp(r2,r1);
	if ne jump (pc,.P125L23);

.LN857:
// line 1259
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if eq jump (pc,.P125L26);

.LN858:
	r8=1259;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ123-1;
.LCJ123:
.LN859:
	jump (pc,.P125L27);

.P125L26:

.P125L27:
.LN860:
// line 1260
	dm(_adi_OSWaitingForSched.)=m6;
.LN861:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN862:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P125L29);


.P125L33:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 1260 col 17
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
.LN863:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P125L34);

	jump (pc,.P125L33);
//-------------------------------------------------------------------
//   End Loop L33
//-------------------------------------------------------------------

.P125L34:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN864:
	jump (pc,.P125L30);

.P125L29:

.P125L30:
.LN865:
// line 1261
	jump (pc,.P125L24);

.P125L23:

.P125L24:
.LN866:
// line 1266
	jump (pc,.P125L21);

.P125L20:

.P125L21:
.LN867:
// line 1267
	r15=dm(-5,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskDelete..end:
.vTaskDelete..end:
	.global vTaskDelete.;
	.type vTaskDelete.,STT_FUNC;

prvCheckTasksWaitingTermination.:
.LNprvCheckTasksWaitingTermination.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,r4,r8,r12,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3750
	modify(i7,-2) (nw);

.P126L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 3759 col 9
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 34 
//   cycles (includes 6 stalls but excludes the cost of function calls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used  17 out of   34 ( 50.0%)
//     multifunction float multiply    used  17 out of   34 ( 50.0%)
//     dm dag                          used  16 out of   34 ( 47.1%)
//     multifunction integer add sub   used  16 out of   34 ( 47.1%)
//     multifunction integer multiply  used  16 out of   34 ( 47.1%)
//     multifunction mult              used  16 out of   34 ( 47.1%)
//     pm dag                          used  16 out of   34 ( 47.1%)
//     shift immediate                 used  16 out of   34 ( 47.1%)
//     memory access                   used  16 out of   68 ( 23.5%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN868:
// line 3759
	r2=dm(uxDeletedTasksWaitingCleanUp.);   // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P126L2);

.LN869:
// line 3761
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ124-1;
.LCJ124:
.LN870:
// line 3763
	i4=dm(xTasksWaitingTermination.+12);
	// -- 4 stalls --
	r8=dm(3,i4);
	dm(-2,i6)=r8;
.LN871:
// line 3764
	r12=4;
	r4=r8+r12;
.LN872:
	cjump uxListRemove. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ125-1;
.LCJ125:
.LN873:
// line 3765
	r2=dm(uxCurrentNumberOfTasks.);         // Use of volatile in loops precludes optimizations. 
	r2=r2-1;
	dm(uxCurrentNumberOfTasks.)=r2;         // Use of volatile in loops precludes optimizations. 
.LN874:
// line 3766
	r2=dm(uxDeletedTasksWaitingCleanUp.);   // Use of volatile in loops precludes optimizations. 
	r2=r2-1;
	dm(uxDeletedTasksWaitingCleanUp.)=r2;   // Use of volatile in loops precludes optimizations. 
.LN875:
// line 3768
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ126-1;
.LCJ126:
.LN876:
// line 3770
	r4=dm(-2,i6);
.LN877:
	cjump prvDeleteTCB. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ127-1;
.LCJ127:
	jump (pc,.P126L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P126L2:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN878:
// line 3774
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvCheckTasksWaitingTermination..end:
.prvCheckTasksWaitingTermination..end:
	.type prvCheckTasksWaitingTermination.,STT_FUNC;

prvIdleTask.:
.LNprvIdleTask.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r1-r2,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3488
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;

.P115L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 3500 col 5
//-------------------------------------------------------------------
.LN879:
// line 3504
	cjump prvCheckTasksWaitingTermination. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ128-1;
.LCJ128:
.LN880:
// line 3527
	r2=dm(pxReadyTasksLists.);              // Use of volatile in loops precludes optimizations. 
	r1=m6;
	compu(r2,r1);
	if le jump (pc,.P115L5);

.LN881:
// line 3529
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;                       // Use of volatile in loops precludes optimizations. 
.LN882:
// line 3530
	jump (pc,.P115L6);

.P115L5:

.P115L6:
	jump (pc,.P115L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.prvIdleTask..end:
.prvIdleTask..end:
	.type prvIdleTask.,STT_FUNC;

xTaskPriorityInherit.:
.LNxTaskPriorityInherit.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,mcc,scc}
//  Call preserved registers used: {r14-r15,i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":4128
	modify(i7,-8) (nw);
	dm(-9,i6)=r14;
	dm(-8,i6)=r15;
	r2=i5;
	dm(-7,i6)=r2;
	dm(-6,i6)=r4;
.LN883:
// line 4130
	dm(-4,i6)=m13;
.LN884:
// line 4129
	dm(-5,i6)=r4;
	r2=pass r4;
.LN885:
// line 4135
	if eq jump (pc,.P127L2);

	i4=r4;
.LN886:
// line 4140
	r2=dm(11,i4);
	i4=dm(pxCurrentTCB.);
	r1=dm(11,i4);
	compu(r1,r2);
	if le jump (pc,.P127L5);

.LN887:
// line 4145
	i4=dm(-5,i6);
	r2=dm(6,i4);
	r1=31;
	btst r2 by r1;
	if not sz jump (pc,.P127L8);

.LN888:
// line 4147
	i4=dm(pxCurrentTCB.);
	r12=dm(11,i4);
	r8=7;
	r2=r8-r12;
	i4=dm(-5,i6);
	dm(6,i4)=r2;
.LN889:
// line 4148
	jump (pc,.P127L9);

.P127L8:

.P127L9:
.LN890:
// line 4156
	i4=dm(-5,i6);
	r2=dm(5,i4);
	r1=dm(11,i4);
	r14=20;
	r8=r1*r14 (ssi);
	r15=pxReadyTasksLists.;
	r1=r8+r15;
	comp(r2,r1);
	if ne jump (pc,.P127L14);

	dm(-3,i6)=m14;
	jump (pc,.P127L15);

.P127L14:
	dm(-3,i6)=m13;

.P127L15:
	r2=dm(-3,i6);
	r2=pass r2;
	if eq jump (pc,.P127L11);

.LN891:
// line 4158
	r8=dm(-5,i6);
	r12=4;
	r4=r8+r12;
.LN892:
	cjump uxListRemove. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ129-1;
.LCJ129:
	dm(-3,i6)=r0;

.LN893:
// line 4171
	i4=dm(pxCurrentTCB.);
	r2=dm(11,i4);
	i4=dm(-5,i6);
	dm(11,i4)=r2;
.LN894:
// line 4172
	i4=dm(-5,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);
	compu(r2,r1);
	if le jump (pc,.P127L20);

.LN895:
	i4=dm(-5,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;
.LN896:
	jump (pc,.P127L21);

.P127L20:

.P127L21:
.LN897:
	i5=dm(-5,i6);
	r2=dm(11,i5);
	r2=r2*r14 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN898:
	dm(2,i5)=r2;
.LN899:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-5,i6);
	dm(3,i4)=r2;
.LN900:
	i12=dm(-5,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN901:
	i12=dm(-5,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN902:
	i4=dm(-5,i6);
	r2=dm(11,i4);
	r8=r2*r14 (ssi);
	r2=r8+r15;
	dm(5,i4)=r2;
.LN903:
	i4=dm(-5,i6);
	r2=dm(11,i4);
	r2=r2*r14 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN904:
// line 4173
	jump (pc,.P127L12);

.P127L11:
.LN905:
// line 4177
	i4=dm(pxCurrentTCB.);
	r2=dm(11,i4);
	i4=dm(-5,i6);
	dm(11,i4)=r2;

.P127L12:
.LN906:
// line 4183
	dm(-4,i6)=m14;
.LN907:
// line 4184
	jump (pc,.P127L6);

.P127L5:
.LN908:
// line 4187
	i4=dm(-5,i6);
	r2=dm(18,i4);
	i4=dm(pxCurrentTCB.);
	r1=dm(11,i4);
	compu(r1,r2);
	if le jump (pc,.P127L23);

.LN909:
// line 4196
	dm(-4,i6)=m14;
.LN910:
// line 4197
	jump (pc,.P127L24);

.P127L23:

.P127L24:

.P127L6:
.LN911:
// line 4203
	jump (pc,.P127L3);

.P127L2:

.P127L3:
.LN912:
// line 4209
	r0=dm(-4,i6);
	i5=dm(-7,i6);
	r14=dm(-9,i6);
	r15=dm(-8,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskPriorityInherit..end:
.xTaskPriorityInherit..end:
	.global xTaskPriorityInherit.;
	.type xTaskPriorityInherit.,STT_FUNC;

xTaskPriorityDisinherit.:
.LNxTaskPriorityDisinherit.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,mcc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":4218
	modify(i7,-6) (nw);
	r2=i5;
	dm(-6,i6)=r2;
	dm(-5,i6)=r4;
.LN913:
// line 4220
	dm(-3,i6)=m13;
.LN914:
// line 4219
	dm(-4,i6)=r4;
	r2=pass r4;
.LN915:
// line 4222
	if eq jump (pc,.P128L2);

.LN916:
// line 4228
	r2=dm(pxCurrentTCB.);
	comp(r4,r2);
	if eq jump (pc,.P128L5);

.LN917:
	r8=4228;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ130-1;
.LCJ130:
.LN918:
	jump (pc,.P128L6);

.P128L5:

.P128L6:
.LN919:
// line 4229
	i4=dm(-4,i6);
	r2=dm(19,i4);
	r2=pass r2;
	if ne jump (pc,.P128L8);

.LN920:
	r8=4229;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ131-1;
.LCJ131:
.LN921:
	jump (pc,.P128L9);

.P128L8:

.P128L9:
.LN922:
// line 4230
	i4=dm(-4,i6);
	r2=dm(19,i4);
	r2=r2-1;
	dm(19,i4)=r2;
.LN923:
// line 4234
	i4=dm(-4,i6);
	r2=dm(11,i4);
	r1=dm(18,i4);
	comp(r2,r1);
	if eq jump (pc,.P128L11);

.LN924:
// line 4237
	r2=dm(19,i4);
	r2=pass r2;
	if ne jump (pc,.P128L14);

.LN925:
// line 4244
	r8=dm(-4,i6);
	r12=4;
	r4=r8+r12;
.LN926:
	cjump uxListRemove. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ132-1;
.LCJ132:

.LN927:
// line 4256
	i4=dm(-4,i6);
	r2=dm(18,i4);
	dm(11,i4)=r2;
.LN928:
// line 4261
	i4=dm(-4,i6);
	r12=dm(11,i4);
	r8=7;
	r2=r8-r12;
	dm(6,i4)=r2;
.LN929:
// line 4262
	i4=dm(-4,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);
	compu(r2,r1);
	if le jump (pc,.P128L20);

.LN930:
	i4=dm(-4,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;
.LN931:
	jump (pc,.P128L21);

.P128L20:

.P128L21:
.LN932:
	i5=dm(-4,i6);
	r2=dm(11,i5);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN933:
	dm(2,i5)=r2;
.LN934:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-4,i6);
	dm(3,i4)=r2;
.LN935:
	i12=dm(-4,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN936:
	i12=dm(-4,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN937:
	i4=dm(-4,i6);
	r2=dm(11,i4);
	r8=r2*r1 (ssi);
	r12=pxReadyTasksLists.;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN938:
	i4=dm(-4,i6);
	r2=dm(11,i4);
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN939:
// line 4272
	dm(-3,i6)=m14;
.LN940:
// line 4273
	jump (pc,.P128L15);

.P128L14:

.P128L15:
.LN941:
// line 4278
	jump (pc,.P128L12);

.P128L11:

.P128L12:
.LN942:
// line 4283
	jump (pc,.P128L3);

.P128L2:

.P128L3:
.LN943:
// line 4289
	r0=dm(-3,i6);
	i5=dm(-6,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskPriorityDisinherit..end:
.xTaskPriorityDisinherit..end:
	.global xTaskPriorityDisinherit.;
	.type xTaskPriorityDisinherit.,STT_FUNC;

vTaskPriorityDisinheritAfterTimeout.:
.LNvTaskPriorityDisinheritAfterTimeout.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 56 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,mcc,scc}
//  Call preserved registers used: {r11,r15,i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":4299
	modify(i7,-12) (nw);
	dm(-12,i6)=r11;
	dm(-11,i6)=r15;
	r2=i5;
	dm(-10,i6)=r2;
	dm(-8,i6)=r8;
	dm(-9,i6)=r4;
.LN944:
// line 4302
	dm(-4,i6)=m14;
.LN945:
// line 4300
	dm(-7,i6)=r4;
	r2=pass r4;
.LN946:
// line 4304
	if eq jump (pc,.P129L2);

	i4=r4;
.LN947:
// line 4308
	r2=dm(19,i4);
	r2=pass r2;
	if ne jump (pc,.P129L5);

.LN948:
	r8=4308;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ133-1;
.LCJ133:
.LN949:
	jump (pc,.P129L6);

.P129L5:

.P129L6:
.LN950:
// line 4314
	i4=dm(-7,i6);
	r1=dm(18,i4);
	r2=dm(-8,i6);
	compu(r2,r1);
	if le jump (pc,.P129L8);

.LN951:
// line 4316
	dm(-5,i6)=r2;
.LN952:
// line 4317
	jump (pc,.P129L9);

.P129L8:
.LN953:
// line 4320
	dm(-5,i6)=r1;

.P129L9:
.LN954:
// line 4324
	i4=dm(-7,i6);
	r2=dm(11,i4);
	r1=dm(-5,i6);
	comp(r2,r1);
	if eq jump (pc,.P129L11);

.LN955:
// line 4330
	r2=dm(19,i4);
	r1=dm(-4,i6);
	comp(r2,r1);
	if ne jump (pc,.P129L14);

.LN956:
// line 4335
	r2=dm(-7,i6);
	r1=dm(pxCurrentTCB.);
	comp(r2,r1);
	if ne jump (pc,.P129L17);

.LN957:
	r8=4335;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ134-1;
.LCJ134:
.LN958:
	jump (pc,.P129L18);

.P129L17:

.P129L18:
.LN959:
// line 4341
	i4=dm(-7,i6);
	r2=dm(11,i4);
	dm(-6,i6)=r2;
.LN960:
// line 4342
	r2=dm(-5,i6);
	dm(11,i4)=r2;
.LN961:
// line 4346
	i4=dm(-7,i6);
	r2=dm(6,i4);
	r1=31;
	btst r2 by r1;
	if not sz jump (pc,.P129L20);

.LN962:
// line 4348
	r12=dm(-5,i6);
	r8=7;
	r2=r8-r12;
	dm(6,i4)=r2;
.LN963:
// line 4349
	jump (pc,.P129L21);

.P129L20:

.P129L21:
.LN964:
// line 4361
	i4=dm(-7,i6);
	r2=dm(5,i4);
	r1=dm(-6,i6);
	r15=20;
	r12=r1*r15 (ssi);
	r11=pxReadyTasksLists.;
	r1=r11+r12;
	comp(r2,r1);
	if ne jump (pc,.P129L26);

	dm(-3,i6)=m14;
	jump (pc,.P129L27);

.P129L26:
	dm(-3,i6)=m13;

.P129L27:
	r2=dm(-3,i6);
	r2=pass r2;
	if eq jump (pc,.P129L23);

.LN965:
// line 4363
	r8=dm(-7,i6);
	r12=4;
	r4=r8+r12;
.LN966:
	cjump uxListRemove. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ135-1;
.LCJ135:
	dm(-3,i6)=r0;

.LN967:
// line 4375
	i4=dm(-7,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);
	compu(r2,r1);
	if le jump (pc,.P129L32);

.LN968:
	i4=dm(-7,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;
.LN969:
	jump (pc,.P129L33);

.P129L32:

.P129L33:
.LN970:
	i5=dm(-7,i6);
	r2=dm(11,i5);
	r2=r2*r15 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN971:
	dm(2,i5)=r2;
.LN972:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-7,i6);
	dm(3,i4)=r2;
.LN973:
	i12=dm(-7,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN974:
	i12=dm(-7,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN975:
	i4=dm(-7,i6);
	r2=dm(11,i4);
	r8=r2*r15 (ssi);
	r12=r11;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN976:
	i4=dm(-7,i6);
	r2=dm(11,i4);
	r2=r2*r15 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN977:
// line 4376
	jump (pc,.P129L24);

.P129L23:

.P129L24:
.LN978:
// line 4381
	jump (pc,.P129L15);

.P129L14:

.P129L15:
.LN979:
// line 4386
	jump (pc,.P129L12);

.P129L11:

.P129L12:
.LN980:
// line 4391
	jump (pc,.P129L3);

.P129L2:

.P129L3:
.LN981:
// line 4396
	i5=dm(-10,i6);
	r11=dm(-12,i6);
	r15=dm(-11,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskPriorityDisinheritAfterTimeout..end:
.vTaskPriorityDisinheritAfterTimeout..end:
	.global vTaskPriorityDisinheritAfterTimeout.;
	.type vTaskPriorityDisinheritAfterTimeout.,STT_FUNC;

xTaskGenericNotify.:
.LNxTaskGenericNotify.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 48 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,m4,acc,mcc,scc,btf}
//  Call preserved registers used: {r15,i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":4914
	modify(i7,-10) (nw);
	dm(-11,i6)=r15;
	r2=i5;
	dm(-10,i6)=r2;
	r2=dm(m6,i6);
	r1=dm(2,i6);
	dm(2,i6)=r1;
	dm(m6,i6)=r2;
	dm(-7,i6)=r12;
	dm(-8,i6)=r8;
	dm(-9,i6)=r4;
.LN982:
// line 4916
	dm(-5,i6)=m14;
	r2=pass r8;
.LN983:
// line 4919
	if eq jump (pc,.P131L2);

.LN984:
	r8=4919;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ136-1;
.LCJ136:
.LN985:
	jump (pc,.P131L3);

.P131L2:

.P131L3:
.LN986:
// line 4920
	r2=dm(-9,i6);
	r2=pass r2;
	if ne jump (pc,.P131L5);

.LN987:
	r8=4920;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ137-1;
.LCJ137:
.LN988:
	jump (pc,.P131L6);

.P131L5:

.P131L6:
.LN989:
// line 4921
	r2=dm(-9,i6);
	dm(-6,i6)=r2;
.LN990:
// line 4923
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ138-1;
.LCJ138:
.LN991:
// line 4925
	r2=dm(2,i6);
	r2=pass r2;
	if eq jump (pc,.P131L8);

.LN992:
// line 4927
	i4=dm(-6,i6);
	i4=modify(i4,88);
	m4=dm(-8,i6);
	r2=dm(m4,i4);
	i4=dm(2,i6);
	dm(i4,m5)=r2;
.LN993:
// line 4928
	jump (pc,.P131L9);

.P131L8:

.P131L9:
.LN994:
// line 4930
	i4=dm(-6,i6);
	i4=modify(i4,92);
	m4=dm(-8,i6);
	r2=dm(m4,i4) (bw);
	dm(-13,i6)=r2 (bw);
.LN995:
// line 4932
	i4=dm(-6,i6);
	i4=modify(i4,92);
	m4=dm(-8,i6);
	i12=2;
	dm(m4,i4)=i12 (bw);
.LN996:
// line 4934
	r2=dm(m6,i6);
	r1=5;
	compu(r2,r1);
	if ge jump (pc,.P131L11);

	m4=r2;
	i4=.SWITCH.2;
	i12=dm(m4,i4);
	jump (m13,i12);

.P131L13:
.LN997:
// line 4937
	r2=dm(-7,i6);
	i4=dm(-6,i6);
	i4=modify(i4,88);
	m4=dm(-8,i6);
	r1=dm(m4,i4);
	r2=r2 or r1;
	dm(m4,i4)=r2;
.LN998:
// line 4938
	jump (pc,.P131L17);

.P131L14:
.LN999:
// line 4941
	i4=dm(-6,i6);
	i4=modify(i4,88);
	m4=dm(-8,i6);
	r2=dm(m4,i4);
	r2=r2+1;
	dm(m4,i4)=r2;
.LN1000:
// line 4942
	jump (pc,.P131L17);

.P131L15:
.LN1001:
// line 4945
	r2=dm(-7,i6);
	i4=dm(-6,i6);
	i4=modify(i4,88);
	m4=dm(-8,i6);
	dm(m4,i4)=r2;
.LN1002:
// line 4946
	jump (pc,.P131L17);

.P131L16:
.LN1003:
// line 4950
	r2=dm(-13,i6) (bw);
	r1=m6;
	r2=btgl r2 by r1;
	if sz jump (pc,.P131L19);

.LN1004:
// line 4952
	r2=dm(-7,i6);
	i4=dm(-6,i6);
	i4=modify(i4,88);
	m4=dm(-8,i6);
	dm(m4,i4)=r2;
.LN1005:
// line 4953
	jump (pc,.P131L20);

.P131L19:
.LN1006:
// line 4957
	dm(-5,i6)=m13;

.P131L20:
.LN1007:
// line 4960
	jump (pc,.P131L17);

.P131L12:
.LN1008:
// line 4966
	jump (pc,.P131L17);

.P131L11:
.LN1009:
// line 4973
	r2=dm(xTickCount.);
	r2=pass r2;
	if eq jump (pc,.P131L22);

.LN1010:
	r8=4973;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ139-1;
.LCJ139:
.LN1011:
	jump (pc,.P131L23);

.P131L22:

.P131L23:

.P131L17:
.LN1012:
// line 4982
	r2=dm(-13,i6) (bw);
	r15=m5;
	r2=btgl r2 by r15;
	if not sz jump (pc,.P131L25);

.LN1013:
// line 4984
	i4=dm(-6,i6);
	r2=dm(5,i4);
	dm(-3,i6)=r2;
.LN1014:
	r2=dm(3,i4);
	i4=dm(2,i4);
	dm(2,i4)=r2;
.LN1015:
	i4=dm(-6,i6);
	r2=dm(2,i4);
	i4=dm(3,i4);
	dm(m6,i4)=r2;
.LN1016:
	i5=dm(-3,i6);
	r2=dm(m6,i5);
	r8=dm(-6,i6);
	r12=4;
	r1=r8+r12;
	comp(r2,r1);
	if ne jump (pc,.P131L28);

	i4=r8;
.LN1017:
	r2=dm(3,i4);
	dm(m6,i5)=r2;
.LN1018:
	jump (pc,.P131L29);

.P131L28:

.P131L29:
.LN1019:
	i4=dm(-6,i6);
	dm(5,i4)=m13;
.LN1020:
	i4=dm(-3,i6);
	r2=dm(i4,m5);
	r2=r2-1;
	dm(i4,m5)=r2;
.LN1021:
// line 4985
	i4=dm(-6,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);
	compu(r2,r1);
	if le jump (pc,.P131L31);

.LN1022:
	i4=dm(-6,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;
.LN1023:
	jump (pc,.P131L32);

.P131L31:

.P131L32:
.LN1024:
	i5=dm(-6,i6);
	r2=dm(11,i5);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN1025:
	dm(2,i5)=r2;
.LN1026:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-6,i6);
	dm(3,i4)=r2;
.LN1027:
	i12=dm(-6,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN1028:
	i12=dm(-6,i6);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN1029:
	i4=dm(-6,i6);
	r2=dm(11,i4);
	r8=r2*r1 (ssi);
	r12=pxReadyTasksLists.;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN1030:
	i4=dm(-6,i6);
	r2=dm(11,i4);
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN1031:
// line 4988
	i4=dm(-6,i6);
	r2=dm(10,i4);
	r2=pass r2;
	if eq jump (pc,.P131L34);

.LN1032:
	r8=4988;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ140-1;
.LCJ140:
.LN1033:
	jump (pc,.P131L35);

.P131L34:

.P131L35:
.LN1034:
// line 5006
	i4=dm(-6,i6);
	r2=dm(11,i4);
	i4=dm(pxCurrentTCB.);
	r1=dm(11,i4);
	compu(r2,r1);
	if le jump (pc,.P131L37);

.LN1035:
// line 5010
	dm(_adi_OSWaitingForSched.)=m6;
.LN1036:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN1037:
	bit tst mode1 4096;
	if tf r15=r15+1;

	r2=pass r15;
	if eq jump (pc,.P131L40);


.P131L44:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 5010 col 21
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
.LN1038:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P131L45);

	jump (pc,.P131L44);
//-------------------------------------------------------------------
//   End Loop L44
//-------------------------------------------------------------------

.P131L45:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN1039:
	jump (pc,.P131L41);

.P131L40:

.P131L41:
.LN1040:
// line 5011
	jump (pc,.P131L38);

.P131L37:

.P131L38:
.LN1041:
// line 5016
	jump (pc,.P131L26);

.P131L25:

.P131L26:
.LN1042:
// line 5022
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ141-1;
.LCJ141:
.LN1043:
// line 5024
	r0=dm(-5,i6);
	i5=dm(-10,i6);
	r15=dm(-11,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskGenericNotify..end:
.xTaskGenericNotify..end:
	.global xTaskGenericNotify.;
	.type xTaskGenericNotify.,STT_FUNC;

xTaskGenericNotifyFromISR.:
.LNxTaskGenericNotifyFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 56 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,m4,acc,mcc,scc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":5038
	modify(i7,-12) (nw);
	r2=i5;
	dm(-12,i6)=r2;
	r2=dm(m6,i6);
	r1=dm(2,i6);
	r0=dm(3,i6);
	dm(3,i6)=r0;
	dm(2,i6)=r1;
	dm(m6,i6)=r2;
	dm(-9,i6)=r12;
	dm(-10,i6)=r8;
	dm(-11,i6)=r4;
.LN1044:
// line 5041
	dm(-6,i6)=m14;
	r2=pass r4;
.LN1045:
// line 5044
	if ne jump (pc,.P133L2);

.LN1046:
	r8=5044;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ142-1;
.LCJ142:
.LN1047:
	jump (pc,.P133L3);

.P133L2:

.P133L3:
.LN1048:
// line 5045
	r2=dm(-10,i6);
	r2=pass r2;
	if eq jump (pc,.P133L5);

.LN1049:
	r8=5045;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ143-1;
.LCJ143:
.LN1050:
	jump (pc,.P133L6);

.P133L5:

.P133L6:
.LN1051:
// line 5063
	cjump vPortValidateInterruptPriority. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ144-1;
.LCJ144:
.LN1052:
// line 5065
	r2=dm(-11,i6);
	dm(-8,i6)=r2;
.LN1053:
// line 5067
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ145-1;
.LCJ145:
.LN1054:
	dm(-5,i6)=r0;
.LN1055:
// line 5069
	r2=dm(2,i6);
	r2=pass r2;
	if eq jump (pc,.P133L8);

.LN1056:
// line 5071
	i4=dm(-8,i6);
	i4=modify(i4,88);
	m4=dm(-10,i6);
	r2=dm(m4,i4);
	i4=dm(2,i6);
	dm(i4,m5)=r2;
.LN1057:
// line 5072
	jump (pc,.P133L9);

.P133L8:

.P133L9:
.LN1058:
// line 5074
	i4=dm(-8,i6);
	i4=modify(i4,92);
	m4=dm(-10,i6);
	r2=dm(m4,i4) (bw);
	dm(-25,i6)=r2 (bw);
.LN1059:
// line 5075
	i4=dm(-8,i6);
	i4=modify(i4,92);
	m4=dm(-10,i6);
	i12=2;
	dm(m4,i4)=i12 (bw);
.LN1060:
// line 5077
	r2=dm(m6,i6);
	r1=5;
	compu(r2,r1);
	if ge jump (pc,.P133L11);

	m4=r2;
	i4=.SWITCH.3;
	i12=dm(m4,i4);
	jump (m13,i12);

.P133L13:
.LN1061:
// line 5080
	r2=dm(-9,i6);
	i4=dm(-8,i6);
	i4=modify(i4,88);
	m4=dm(-10,i6);
	r1=dm(m4,i4);
	r2=r2 or r1;
	dm(m4,i4)=r2;
.LN1062:
// line 5081
	jump (pc,.P133L17);

.P133L14:
.LN1063:
// line 5084
	i4=dm(-8,i6);
	i4=modify(i4,88);
	m4=dm(-10,i6);
	r2=dm(m4,i4);
	r2=r2+1;
	dm(m4,i4)=r2;
.LN1064:
// line 5085
	jump (pc,.P133L17);

.P133L15:
.LN1065:
// line 5088
	r2=dm(-9,i6);
	i4=dm(-8,i6);
	i4=modify(i4,88);
	m4=dm(-10,i6);
	dm(m4,i4)=r2;
.LN1066:
// line 5089
	jump (pc,.P133L17);

.P133L16:
.LN1067:
// line 5093
	r2=dm(-25,i6) (bw);
	r1=m6;
	r2=btgl r2 by r1;
	if sz jump (pc,.P133L19);

.LN1068:
// line 5095
	r2=dm(-9,i6);
	i4=dm(-8,i6);
	i4=modify(i4,88);
	m4=dm(-10,i6);
	dm(m4,i4)=r2;
.LN1069:
// line 5096
	jump (pc,.P133L20);

.P133L19:
.LN1070:
// line 5100
	dm(-6,i6)=m13;

.P133L20:
.LN1071:
// line 5103
	jump (pc,.P133L17);

.P133L12:
.LN1072:
// line 5109
	jump (pc,.P133L17);

.P133L11:
.LN1073:
// line 5116
	r2=dm(xTickCount.);
	r2=pass r2;
	if eq jump (pc,.P133L22);

.LN1074:
	r8=5116;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ146-1;
.LCJ146:
.LN1075:
	jump (pc,.P133L23);

.P133L22:

.P133L23:

.P133L17:
.LN1076:
// line 5124
	r2=dm(-25,i6) (bw);
	r1=m5;
	r2=btgl r2 by r1;
	if not sz jump (pc,.P133L25);

.LN1077:
// line 5127
	i4=dm(-8,i6);
	r2=dm(10,i4);
	r2=pass r2;
	if eq jump (pc,.P133L28);

.LN1078:
	r8=5127;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ147-1;
.LCJ147:
.LN1079:
	jump (pc,.P133L29);

.P133L28:

.P133L29:
.LN1080:
// line 5129
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if ne jump (pc,.P133L31);

.LN1081:
// line 5131
	i4=dm(-8,i6);
	r2=dm(5,i4);
	dm(-4,i6)=r2;
.LN1082:
	r2=dm(3,i4);
	i4=dm(2,i4);
	dm(2,i4)=r2;
.LN1083:
	i4=dm(-8,i6);
	r2=dm(2,i4);
	i4=dm(3,i4);
	dm(m6,i4)=r2;
.LN1084:
	i5=dm(-4,i6);
	r2=dm(m6,i5);
	r8=dm(-8,i6);
	r12=4;
	r1=r8+r12;
	comp(r2,r1);
	if ne jump (pc,.P133L34);

	i4=r8;
.LN1085:
	r2=dm(3,i4);
	dm(m6,i5)=r2;
.LN1086:
	jump (pc,.P133L35);

.P133L34:

.P133L35:
.LN1087:
	i4=dm(-8,i6);
	dm(5,i4)=m13;
.LN1088:
	i4=dm(-4,i6);
	r2=dm(i4,m5);
	r2=r2-1;
	dm(i4,m5)=r2;
.LN1089:
// line 5132
	i4=dm(-8,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);
	compu(r2,r1);
	if le jump (pc,.P133L37);

.LN1090:
	i4=dm(-8,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;
.LN1091:
	jump (pc,.P133L38);

.P133L37:

.P133L38:
.LN1092:
	i5=dm(-8,i6);
	r2=dm(11,i5);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-3,i6)=r2;
.LN1093:
	dm(2,i5)=r2;
.LN1094:
	i4=dm(-3,i6);
	r2=dm(2,i4);
	i4=dm(-8,i6);
	dm(3,i4)=r2;
.LN1095:
	i12=dm(-8,i6);
	i12=modify(i12,4);
	i4=dm(-3,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN1096:
	i12=dm(-8,i6);
	i12=modify(i12,4);
	i4=dm(-3,i6);
	dm(2,i4)=i12;
.LN1097:
	i4=dm(-8,i6);
	r2=dm(11,i4);
	r8=r2*r1 (ssi);
	r12=pxReadyTasksLists.;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN1098:
	i4=dm(-8,i6);
	r2=dm(11,i4);
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN1099:
// line 5133
	jump (pc,.P133L32);

.P133L31:
.LN1100:
// line 5138
	r2=dm(xPendingReadyList.+4);
	dm(-2,i6)=r2;
.LN1101:
	i4=dm(-8,i6);
	dm(7,i4)=r2;
.LN1102:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-8,i6);
	dm(8,i4)=r2;
.LN1103:
	i12=dm(-8,i6);
	i12=modify(i12,24);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN1104:
	i12=dm(-8,i6);
	i12=modify(i12,24);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN1105:
	i4=dm(-8,i6);
	i12=xPendingReadyList.;
	dm(10,i4)=i12;
.LN1106:
	r2=dm(xPendingReadyList.);
	r2=r2+1;
	dm(xPendingReadyList.)=r2;

.P133L32:
.LN1107:
// line 5141
	i4=dm(-8,i6);
	r2=dm(11,i4);
	i4=dm(pxCurrentTCB.);
	r1=dm(11,i4);
	compu(r2,r1);
	if le jump (pc,.P133L40);

.LN1108:
// line 5145
	r2=dm(3,i6);
	r2=pass r2;
	if eq jump (pc,.P133L43);

	i4=r2;
.LN1109:
// line 5147
	dm(m5,i4)=m14;
.LN1110:
// line 5148
	jump (pc,.P133L44);

.P133L43:

.P133L44:
.LN1111:
// line 5153
	dm(xYieldPending.)=m6;
.LN1112:
// line 5154
	jump (pc,.P133L41);

.P133L40:

.P133L41:
.LN1113:
// line 5159
	jump (pc,.P133L26);

.P133L25:

.P133L26:
.LN1114:
// line 5161
	r4=dm(-5,i6);
.LN1115:
	cjump vPortClearInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ148-1;
.LCJ148:
.LN1116:
// line 5163
	r0=dm(-6,i6);
	i5=dm(-12,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskGenericNotifyFromISR..end:
.xTaskGenericNotifyFromISR..end:
	.global xTaskGenericNotifyFromISR.;
	.type xTaskGenericNotifyFromISR.,STT_FUNC;

vTaskGenericNotifyGiveFromISR.:
.LNvTaskGenericNotifyGiveFromISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 48 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,m4,acc,mcc,scc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":5174
	modify(i7,-10) (nw);
	r2=i5;
	dm(-11,i6)=r2;
	dm(-8,i6)=r12;
	dm(-9,i6)=r8;
	dm(-10,i6)=r4;
	r2=pass r4;
.LN1117:
// line 5179
	if ne jump (pc,.P134L2);

.LN1118:
	r8=5179;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ149-1;
.LCJ149:
.LN1119:
	jump (pc,.P134L3);

.P134L2:

.P134L3:
.LN1120:
// line 5180
	r2=dm(-9,i6);
	r2=pass r2;
	if eq jump (pc,.P134L5);

.LN1121:
	r8=5180;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ150-1;
.LCJ150:
.LN1122:
	jump (pc,.P134L6);

.P134L5:

.P134L6:
.LN1123:
// line 5198
	cjump vPortValidateInterruptPriority. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ151-1;
.LCJ151:
.LN1124:
// line 5200
	r2=dm(-10,i6);
	dm(-7,i6)=r2;
.LN1125:
// line 5202
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ152-1;
.LCJ152:
.LN1126:
	dm(-5,i6)=r0;
.LN1127:
// line 5204
	i4=dm(-7,i6);
	i4=modify(i4,92);
	m4=dm(-9,i6);
	r2=dm(m4,i4) (bw);
	dm(-21,i6)=r2 (bw);
.LN1128:
// line 5205
	i4=dm(-7,i6);
	i4=modify(i4,92);
	m4=dm(-9,i6);
	i12=2;
	dm(m4,i4)=i12 (bw);
.LN1129:
// line 5209
	i4=dm(-7,i6);
	i4=modify(i4,88);
	m4=dm(-9,i6);
	r2=dm(m4,i4);
	r2=r2+1;
	dm(m4,i4)=r2;
.LN1130:
// line 5215
	r2=dm(-21,i6) (bw);
	r1=m5;
	r2=btgl r2 by r1;
	if not sz jump (pc,.P134L8);

.LN1131:
// line 5218
	i4=dm(-7,i6);
	r2=dm(10,i4);
	r2=pass r2;
	if eq jump (pc,.P134L11);

.LN1132:
	r8=5218;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ153-1;
.LCJ153:
.LN1133:
	jump (pc,.P134L12);

.P134L11:

.P134L12:
.LN1134:
// line 5220
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if ne jump (pc,.P134L14);

.LN1135:
// line 5222
	i4=dm(-7,i6);
	r2=dm(5,i4);
	dm(-4,i6)=r2;
.LN1136:
	r2=dm(3,i4);
	i4=dm(2,i4);
	dm(2,i4)=r2;
.LN1137:
	i4=dm(-7,i6);
	r2=dm(2,i4);
	i4=dm(3,i4);
	dm(m6,i4)=r2;
.LN1138:
	i5=dm(-4,i6);
	r2=dm(m6,i5);
	r8=dm(-7,i6);
	r12=4;
	r1=r8+r12;
	comp(r2,r1);
	if ne jump (pc,.P134L17);

	i4=r8;
.LN1139:
	r2=dm(3,i4);
	dm(m6,i5)=r2;
.LN1140:
	jump (pc,.P134L18);

.P134L17:

.P134L18:
.LN1141:
	i4=dm(-7,i6);
	dm(5,i4)=m13;
.LN1142:
	i4=dm(-4,i6);
	r2=dm(i4,m5);
	r2=r2-1;
	dm(i4,m5)=r2;
.LN1143:
// line 5223
	i4=dm(-7,i6);
	r2=dm(11,i4);
	r1=dm(uxTopReadyPriority.);
	compu(r2,r1);
	if le jump (pc,.P134L20);

.LN1144:
	i4=dm(-7,i6);
	r2=dm(11,i4);
	dm(uxTopReadyPriority.)=r2;
.LN1145:
	jump (pc,.P134L21);

.P134L20:

.P134L21:
.LN1146:
	i5=dm(-7,i6);
	r2=dm(11,i5);
	r1=20;
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(m6,i4);
	dm(-3,i6)=r2;
.LN1147:
	dm(2,i5)=r2;
.LN1148:
	i4=dm(-3,i6);
	r2=dm(2,i4);
	i4=dm(-7,i6);
	dm(3,i4)=r2;
.LN1149:
	i12=dm(-7,i6);
	i12=modify(i12,4);
	i4=dm(-3,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN1150:
	i12=dm(-7,i6);
	i12=modify(i12,4);
	i4=dm(-3,i6);
	dm(2,i4)=i12;
.LN1151:
	i4=dm(-7,i6);
	r2=dm(11,i4);
	r8=r2*r1 (ssi);
	r12=pxReadyTasksLists.;
	r2=r8+r12;
	dm(5,i4)=r2;
.LN1152:
	i4=dm(-7,i6);
	r2=dm(11,i4);
	r2=r2*r1 (ssi);
	i4=r2;
	i4=modify(i4,pxReadyTasksLists.);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN1153:
// line 5224
	jump (pc,.P134L15);

.P134L14:
.LN1154:
// line 5229
	r2=dm(xPendingReadyList.+4);
	dm(-2,i6)=r2;
.LN1155:
	i4=dm(-7,i6);
	dm(7,i4)=r2;
.LN1156:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-7,i6);
	dm(8,i4)=r2;
.LN1157:
	i12=dm(-7,i6);
	i12=modify(i12,24);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN1158:
	i12=dm(-7,i6);
	i12=modify(i12,24);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN1159:
	i4=dm(-7,i6);
	i12=xPendingReadyList.;
	dm(10,i4)=i12;
.LN1160:
	r2=dm(xPendingReadyList.);
	r2=r2+1;
	dm(xPendingReadyList.)=r2;

.P134L15:
.LN1161:
// line 5232
	i4=dm(-7,i6);
	r2=dm(11,i4);
	i4=dm(pxCurrentTCB.);
	r1=dm(11,i4);
	compu(r2,r1);
	if le jump (pc,.P134L23);

.LN1162:
// line 5236
	r2=dm(-8,i6);
	r2=pass r2;
	if eq jump (pc,.P134L26);

	i4=r2;
.LN1163:
// line 5238
	dm(m5,i4)=m14;
.LN1164:
// line 5239
	jump (pc,.P134L27);

.P134L26:

.P134L27:
.LN1165:
// line 5244
	dm(xYieldPending.)=m6;
.LN1166:
// line 5245
	jump (pc,.P134L24);

.P134L23:

.P134L24:
.LN1167:
// line 5250
	jump (pc,.P134L9);

.P134L8:

.P134L9:
.LN1168:
// line 5252
	r4=dm(-5,i6);
.LN1169:
	cjump vPortClearInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ154-1;
.LCJ154:
.LN1170:
// line 5253
	i5=dm(-11,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskGenericNotifyGiveFromISR..end:
.vTaskGenericNotifyGiveFromISR..end:
	.global vTaskGenericNotifyGiveFromISR.;
	.type vTaskGenericNotifyGiveFromISR.,STT_FUNC;

xTaskGenericNotifyStateClear.:
.LNxTaskGenericNotifyStateClear.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,i4,i12,m4,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":5262
	modify(i7,-6) (nw);
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
	r2=pass r8;
.LN1171:
// line 5266
	if eq jump (pc,.P135L2);

.LN1172:
	r8=5266;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ155-1;
.LCJ155:
.LN1173:
	jump (pc,.P135L3);

.P135L2:

.P135L3:
.LN1174:
// line 5270
	r2=dm(-6,i6);
	r2=pass r2;
	if ne jump (pc,.P135L5);

	r2=dm(pxCurrentTCB.);
	dm(-2,i6)=r2;
	jump (pc,.P135L6);

.P135L5:
	dm(-2,i6)=r2;

.P135L6:
	r2=dm(-2,i6);
	dm(-4,i6)=r2;
.LN1175:
// line 5272
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ156-1;
.LCJ156:
.LN1176:
// line 5274
	i4=dm(-4,i6);
	i4=modify(i4,92);
	m4=dm(-5,i6);
	r2=dm(m4,i4) (bw);
	r1=m6;
	r2=btgl r2 by r1;
	if not sz jump (pc,.P135L8);

.LN1177:
// line 5276
	i4=dm(-4,i6);
	i4=modify(i4,92);
	m4=dm(-5,i6);
	dm(m4,i4)=m13 (bw);
.LN1178:
// line 5277
	dm(-3,i6)=m14;
.LN1179:
// line 5278
	jump (pc,.P135L9);

.P135L8:
.LN1180:
// line 5281
	dm(-3,i6)=m13;

.P135L9:
.LN1181:
// line 5284
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ157-1;
.LCJ157:
.LN1182:
// line 5286
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskGenericNotifyStateClear..end:
.xTaskGenericNotifyStateClear..end:
	.global xTaskGenericNotifyStateClear.;
	.type xTaskGenericNotifyStateClear.,STT_FUNC;

ulTaskGenericNotifyValueClear.:
.LNulTaskGenericNotifyValueClear.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,i4,i12,m4,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":5297
	modify(i7,-6) (nw);
	dm(-5,i6)=r12;
	dm(-6,i6)=r8;
	dm(-7,i6)=r4;
	r2=pass r4;
.LN1183:
// line 5303
	if ne jump (pc,.P136L2);

	r2=dm(pxCurrentTCB.);
	dm(-2,i6)=r2;
	jump (pc,.P136L3);

.P136L2:
	dm(-2,i6)=r4;

.P136L3:
	r2=dm(-2,i6);
	dm(-4,i6)=r2;
.LN1184:
// line 5305
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ158-1;
.LCJ158:
.LN1185:
// line 5309
	i4=dm(-4,i6);
	i4=modify(i4,88);
	m4=dm(-6,i6);
	r2=dm(m4,i4);
	dm(-3,i6)=r2;
.LN1186:
// line 5310
	r2=dm(-5,i6);
	r2=not r2;
	i4=dm(-4,i6);
	i4=modify(i4,88);
	m4=dm(-6,i6);
	r1=dm(m4,i4);
	r2=r2 and r1;
	dm(m4,i4)=r2;
.LN1187:
// line 5312
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ159-1;
.LCJ159:
.LN1188:
// line 5314
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.ulTaskGenericNotifyValueClear..end:
.ulTaskGenericNotifyValueClear..end:
	.global ulTaskGenericNotifyValueClear.;
	.type ulTaskGenericNotifyValueClear.,STT_FUNC;

prvAddCurrentTaskToDelayedList.:
.LNprvAddCurrentTaskToDelayedList.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":5359
	modify(i7,-6) (nw);
	dm(-7,i6)=r15;
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
.LN1189:
// line 5361
	r2=dm(xTickCount.);
	dm(-3,i6)=r2;
.LN1190:
// line 5374
	r8=dm(pxCurrentTCB.);
	r15=4;
	r4=r8+r15;
.LN1191:
	cjump uxListRemove. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ160-1;
.LCJ160:

.LN1192:
// line 5387
	r2=dm(-6,i6);
	r1=m7;
	comp(r2,r1);
	if ne jump (pc,.P137L5);

	r2=dm(-5,i6);
	r2=pass r2;
	if eq jump (pc,.P137L5);

.LN1193:
// line 5392
	r2=dm(xSuspendedTaskList.+4);
	dm(-2,i6)=r2;
.LN1194:
	i4=dm(pxCurrentTCB.);
	dm(2,i4)=r2;
.LN1195:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(pxCurrentTCB.);
	dm(3,i4)=r2;
.LN1196:
	i12=dm(pxCurrentTCB.);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN1197:
	i12=dm(pxCurrentTCB.);
	i12=modify(i12,4);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN1198:
	i4=dm(pxCurrentTCB.);
	i12=xSuspendedTaskList.;
	dm(5,i4)=i12;
.LN1199:
	r2=dm(xSuspendedTaskList.);
	r2=r2+1;
	dm(xSuspendedTaskList.)=r2;
.LN1200:
// line 5393
	jump (pc,.P137L6);

.P137L5:
.LN1201:
// line 5399
	r8=dm(-3,i6);
	r12=dm(-6,i6);
	r2=r8+r12;
	dm(-4,i6)=r2;
.LN1202:
// line 5402
	i4=dm(pxCurrentTCB.);
	dm(m6,i4)=r2;
.LN1203:
// line 5404
	r2=dm(-4,i6);
	r1=dm(-3,i6);
	compu(r1,r2);
	if le jump (pc,.P137L9);

.LN1204:
// line 5408
	r4=dm(pxOverflowDelayedTaskList.);
	r8=dm(pxCurrentTCB.);
	r8=r8+r15;
.LN1205:
	cjump vListInsert. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ161-1;
.LCJ161:
.LN1206:
// line 5409
	jump (pc,.P137L10);

.P137L9:
.LN1207:
// line 5414
	r4=dm(pxDelayedTaskList.);
	r8=dm(pxCurrentTCB.);
	r8=r8+r15;
.LN1208:
	cjump vListInsert. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ162-1;
.LCJ162:
.LN1209:
// line 5419
	r2=dm(-4,i6);
	r1=dm(xNextTaskUnblockTime.);
	compu(r1,r2);
	if le jump (pc,.P137L12);

.LN1210:
// line 5421
	r2=dm(-4,i6);
	dm(xNextTaskUnblockTime.)=r2;
.LN1211:
// line 5422
	jump (pc,.P137L13);

.P137L12:

.P137L13:

.P137L10:

.P137L6:
.LN1212:
// line 5467
	r15=dm(-7,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvAddCurrentTaskToDelayedList..end:
.prvAddCurrentTaskToDelayedList..end:
	.type prvAddCurrentTaskToDelayedList.,STT_FUNC;

xTaskDelayUntil.:
.LNxTaskDelayUntil.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,btf}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1276
	modify(i7,-6) (nw);
	dm(-6,i6)=r8;
	dm(-7,i6)=r4;
.LN1213:
// line 1278
	dm(-3,i6)=m13;
	r2=pass r4;
.LN1214:
// line 1280
	if ne jump (pc,.P139L2);

.LN1215:
	r8=1280;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ163-1;
.LCJ163:
.LN1216:
	jump (pc,.P139L3);

.P139L2:

.P139L3:
.LN1217:
// line 1281
	r2=dm(-6,i6);
	r2=pass r2;
	if ne jump (pc,.P139L5);

.LN1218:
	r8=1281;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ164-1;
.LCJ164:
.LN1219:
	jump (pc,.P139L6);

.P139L5:

.P139L6:
.LN1220:
// line 1282
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if eq jump (pc,.P139L8);

.LN1221:
	r8=1282;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ165-1;
.LCJ165:
.LN1222:
	jump (pc,.P139L9);

.P139L8:

.P139L9:
.LN1223:
// line 1284
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ166-1;
.LCJ166:
.LN1224:
// line 1288
	r2=dm(xTickCount.);
	dm(-2,i6)=r2;
.LN1225:
// line 1291
	i4=dm(-7,i6);
	r8=dm(i4,m5);
	r12=dm(-6,i6);
	r1=r8+r12;
	dm(-5,i6)=r1;
.LN1226:
// line 1293
	r0=dm(i4,m5);
	compu(r0,r2);
	if le jump (pc,.P139L11);

	compu(r0,r1);
.LN1227:
// line 1300
	if le jump (pc,.P139L14);

	compu(r1,r2);
	if le jump (pc,.P139L14);

.LN1228:
// line 1302
	dm(-3,i6)=m14;
.LN1229:
// line 1303
	jump (pc,.P139L15);

.P139L14:

.P139L15:
.LN1230:
// line 1308
	jump (pc,.P139L12);

.P139L11:
.LN1231:
// line 1314
	compu(r1,r0);
	if lt jump (pc,.P139L17);

	compu(r1,r2);
	if le jump (pc,.P139L18);

.P139L17:
.LN1232:
// line 1316
	dm(-3,i6)=m14;
.LN1233:
// line 1317
	jump (pc,.P139L19);

.P139L18:

.P139L19:

.P139L12:
.LN1234:
// line 1325
	r2=dm(-5,i6);
	i4=dm(-7,i6);
	dm(i4,m5)=r2;
.LN1235:
// line 1327
	r2=dm(-3,i6);
	r2=pass r2;
	if eq jump (pc,.P139L22);

.LN1236:
// line 1333
	r8=dm(-5,i6);
	r12=dm(-2,i6);
	r4=r8-r12;
.LN1237:
	r8=m5;
	cjump prvAddCurrentTaskToDelayedList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ167-1;
.LCJ167:
.LN1238:
// line 1334
	jump (pc,.P139L23);

.P139L22:

.P139L23:
.LN1239:
// line 1340
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ168-1;
.LCJ168:
.LN1240:
	dm(-4,i6)=r0;
	r2=pass r0;
.LN1241:
// line 1344
	if ne jump (pc,.P139L25);

.LN1242:
// line 1346
	dm(_adi_OSWaitingForSched.)=m6;
.LN1243:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN1244:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P139L28);


.P139L32:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 1346 col 13
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
.LN1245:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P139L33);

	jump (pc,.P139L32);
//-------------------------------------------------------------------
//   End Loop L32
//-------------------------------------------------------------------

.P139L33:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN1246:
	jump (pc,.P139L29);

.P139L28:

.P139L29:
.LN1247:
// line 1347
	jump (pc,.P139L26);

.P139L25:

.P139L26:
.LN1248:
// line 1353
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskDelayUntil..end:
.xTaskDelayUntil..end:
	.global xTaskDelayUntil.;
	.type xTaskDelayUntil.,STT_FUNC;

vTaskDelay.:
.LNvTaskDelay.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,r4,r8,i12,acc,btf}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":1362
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN1249:
// line 1363
	dm(-2,i6)=m13;
	r2=pass r4;
.LN1250:
// line 1366
	if eq jump (pc,.P140L2);

.LN1251:
// line 1368
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if eq jump (pc,.P140L5);

.LN1252:
	r8=1368;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ169-1;
.LCJ169:
.LN1253:
	jump (pc,.P140L6);

.P140L5:

.P140L6:
.LN1254:
// line 1369
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ170-1;
.LCJ170:
.LN1255:
// line 1380
	r4=dm(-3,i6);
.LN1256:
	r8=m5;
	cjump prvAddCurrentTaskToDelayedList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ171-1;
.LCJ171:
.LN1257:
// line 1382
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ172-1;
.LCJ172:
.LN1258:
	dm(-2,i6)=r0;
.LN1259:
// line 1383
	jump (pc,.P140L3);

.P140L2:

.P140L3:
.LN1260:
// line 1391
	r2=dm(-2,i6);
	r2=pass r2;
	if ne jump (pc,.P140L8);

.LN1261:
// line 1393
	dm(_adi_OSWaitingForSched.)=m6;
.LN1262:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN1263:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P140L11);


.P140L15:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 1393 col 13
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
.LN1264:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P140L16);

	jump (pc,.P140L15);
//-------------------------------------------------------------------
//   End Loop L15
//-------------------------------------------------------------------

.P140L16:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN1265:
	jump (pc,.P140L12);

.P140L11:

.P140L12:
.LN1266:
// line 1394
	jump (pc,.P140L9);

.P140L8:

.P140L9:
.LN1267:
// line 1399
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskDelay..end:
.vTaskDelay..end:
	.global vTaskDelay.;
	.type vTaskDelay.,STT_FUNC;

vTaskPlaceOnEventList.:
.LNvTaskPlaceOnEventList.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,r4,r8,r12,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3145
	modify(i7,-2) (nw);
	dm(-2,i6)=r8;
	dm(-3,i6)=r4;
	r2=pass r4;
.LN1268:
// line 3146
	if ne jump (pc,.P141L2);

.LN1269:
	r8=3146;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ173-1;
.LCJ173:
.LN1270:
	jump (pc,.P141L3);

.P141L2:

.P141L3:
.LN1271:
// line 3162
	r4=dm(-3,i6);
	r8=dm(pxCurrentTCB.);
	r12=24;
	r8=r8+r12;
.LN1272:
	cjump vListInsert. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ174-1;
.LCJ174:
.LN1273:
// line 3164
	r4=dm(-2,i6);
.LN1274:
	r8=m6;
	cjump prvAddCurrentTaskToDelayedList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ175-1;
.LCJ175:
.LN1275:
// line 3165
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskPlaceOnEventList..end:
.vTaskPlaceOnEventList..end:
	.global vTaskPlaceOnEventList.;
	.type vTaskPlaceOnEventList.,STT_FUNC;

vTaskPlaceOnUnorderedEventList.:
.LNvTaskPlaceOnUnorderedEventList.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3171
	modify(i7,-4) (nw);
	dm(-3,i6)=r12;
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
	r2=pass r4;
.LN1276:
// line 3172
	if ne jump (pc,.P142L2);

.LN1277:
	r8=3172;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ176-1;
.LCJ176:
.LN1278:
	jump (pc,.P142L3);

.P142L2:

.P142L3:
.LN1279:
// line 3176
	r2=dm(uxSchedulerSuspended.);
	r2=pass r2;
	if ne jump (pc,.P142L5);

.LN1280:
	r8=3176;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ177-1;
.LCJ177:
.LN1281:
	jump (pc,.P142L6);

.P142L5:

.P142L6:
.LN1282:
// line 3181
	r2=dm(-4,i6);
	r1=31;
	r2=bset r2 by r1;
	i4=dm(pxCurrentTCB.);
	dm(6,i4)=r2;
.LN1283:
// line 3188
	i4=dm(-5,i6);
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN1284:
	i4=dm(pxCurrentTCB.);
	dm(7,i4)=r2;
.LN1285:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(pxCurrentTCB.);
	dm(8,i4)=r2;
.LN1286:
	i12=dm(pxCurrentTCB.);
	i12=modify(i12,24);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN1287:
	i12=dm(pxCurrentTCB.);
	i12=modify(i12,24);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN1288:
	r2=dm(-5,i6);
	i4=dm(pxCurrentTCB.);
	dm(10,i4)=r2;
.LN1289:
	i4=dm(-5,i6);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN1290:
// line 3190
	r4=dm(-3,i6);
.LN1291:
	r8=m6;
	cjump prvAddCurrentTaskToDelayedList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ178-1;
.LCJ178:
.LN1292:
// line 3191
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskPlaceOnUnorderedEventList..end:
.vTaskPlaceOnUnorderedEventList..end:
	.global vTaskPlaceOnUnorderedEventList.;
	.type vTaskPlaceOnUnorderedEventList.,STT_FUNC;

vTaskPlaceOnEventListRestricted.:
.LNvTaskPlaceOnEventListRestricted.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r2,r4,r8,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":3199
	modify(i7,-4) (nw);
	dm(-3,i6)=r12;
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
	r2=pass r4;
.LN1293:
// line 3200
	if ne jump (pc,.P143L2);

.LN1294:
	r8=3200;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ179-1;
.LCJ179:
.LN1295:
	jump (pc,.P143L3);

.P143L2:

.P143L3:
.LN1296:
// line 3212
	i4=dm(-5,i6);
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN1297:
	i4=dm(pxCurrentTCB.);
	dm(7,i4)=r2;
.LN1298:
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(pxCurrentTCB.);
	dm(8,i4)=r2;
.LN1299:
	i12=dm(pxCurrentTCB.);
	i12=modify(i12,24);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=i12;
.LN1300:
	i12=dm(pxCurrentTCB.);
	i12=modify(i12,24);
	i4=dm(-2,i6);
	dm(2,i4)=i12;
.LN1301:
	r2=dm(-5,i6);
	i4=dm(pxCurrentTCB.);
	dm(10,i4)=r2;
.LN1302:
	i4=dm(-5,i6);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN1303:
// line 3217
	r2=dm(-3,i6);
	r2=pass r2;
	if eq jump (pc,.P143L5);

.LN1304:
// line 3219
	dm(-4,i6)=m15;
.LN1305:
// line 3220
	jump (pc,.P143L6);

.P143L5:

.P143L6:
.LN1306:
// line 3223
	r4=dm(-4,i6);
	r8=dm(-3,i6);
.LN1307:
	cjump prvAddCurrentTaskToDelayedList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ180-1;
.LCJ180:
.LN1308:
// line 3224
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vTaskPlaceOnEventListRestricted..end:
.vTaskPlaceOnEventListRestricted..end:
	.global vTaskPlaceOnEventListRestricted.;
	.type vTaskPlaceOnEventListRestricted.,STT_FUNC;

ulTaskGenericNotifyTake.:
.LNulTaskGenericNotifyTake.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0-r2,r4,r8,i4,i12,m4,acc,btf}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":4754
	modify(i7,-4) (nw);
	dm(-3,i6)=r12;
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
	r2=pass r4;
.LN1309:
// line 4757
	if eq jump (pc,.P144L2);

.LN1310:
	r8=4757;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ181-1;
.LCJ181:
.LN1311:
	jump (pc,.P144L3);

.P144L2:

.P144L3:
.LN1312:
// line 4759
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ182-1;
.LCJ182:
.LN1313:
// line 4762
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,88);
	m4=dm(-5,i6);
	r2=dm(m4,i4);
	r2=pass r2;
	if ne jump (pc,.P144L5);

.LN1314:
// line 4765
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,92);
	m4=dm(-5,i6);
	dm(m4,i4)=m14 (bw);
.LN1315:
// line 4767
	r4=dm(-3,i6);
	r2=pass r4;
	if eq jump (pc,.P144L8);

.LN1316:
// line 4769
	r8=m6;
	cjump prvAddCurrentTaskToDelayedList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ183-1;
.LCJ183:
.LN1317:
// line 4776
	dm(_adi_OSWaitingForSched.)=m6;
.LN1318:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN1319:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P144L11);


.P144L15:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 4776 col 21
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
.LN1320:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P144L16);

	jump (pc,.P144L15);
//-------------------------------------------------------------------
//   End Loop L15
//-------------------------------------------------------------------

.P144L16:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN1321:
	jump (pc,.P144L12);

.P144L11:

.P144L12:
.LN1322:
// line 4777
	jump (pc,.P144L9);

.P144L8:

.P144L9:
.LN1323:
// line 4782
	jump (pc,.P144L6);

.P144L5:

.P144L6:
.LN1324:
// line 4788
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ184-1;
.LCJ184:
.LN1325:
// line 4790
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ185-1;
.LCJ185:
.LN1326:
// line 4793
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,88);
	m4=dm(-5,i6);
	r2=dm(m4,i4);
	dm(-2,i6)=r2;
	r2=pass r2;
.LN1327:
// line 4795
	if eq jump (pc,.P144L19);

.LN1328:
// line 4797
	r1=dm(-4,i6);
	r1=pass r1;
	if eq jump (pc,.P144L22);

.LN1329:
// line 4799
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,88);
	m4=dm(-5,i6);
	dm(m4,i4)=m13;
.LN1330:
// line 4800
	jump (pc,.P144L23);

.P144L22:
.LN1331:
// line 4803
	r2=r2-1;
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,88);
	m4=dm(-5,i6);
	dm(m4,i4)=r2;

.P144L23:
.LN1332:
// line 4805
	jump (pc,.P144L20);

.P144L19:

.P144L20:
.LN1333:
// line 4811
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,92);
	m4=dm(-5,i6);
	dm(m4,i4)=m13 (bw);
.LN1334:
// line 4813
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ186-1;
.LCJ186:
.LN1335:
// line 4815
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.ulTaskGenericNotifyTake..end:
.ulTaskGenericNotifyTake..end:
	.global ulTaskGenericNotifyTake.;
	.type ulTaskGenericNotifyTake.,STT_FUNC;

xTaskGenericNotifyWait.:
.LNxTaskGenericNotifyWait.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,i4,i12,m4,acc,scc,btf}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c":4828
	modify(i7,-6) (nw);
	dm(-6,i6)=r15;
	r2=dm(m6,i6);
	r1=dm(2,i6);
	dm(2,i6)=r1;
	dm(m6,i6)=r2;
	dm(-3,i6)=r12;
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
	r2=pass r4;
.LN1336:
// line 4831
	if eq jump (pc,.P145L2);

.LN1337:
	r8=4831;
	r4=.sDRTOSF.0;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ187-1;
.LCJ187:
.LN1338:
	jump (pc,.P145L3);

.P145L2:

.P145L3:
.LN1339:
// line 4833
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ188-1;
.LCJ188:
.LN1340:
// line 4836
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,92);
	m4=dm(-5,i6);
	r2=dm(m4,i4) (bw);
	r15=m6;
	r2=btgl r2 by r15;
	if sz jump (pc,.P145L5);

.LN1341:
// line 4841
	r2=dm(-4,i6);
	r2=not r2;
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,88);
	m4=dm(-5,i6);
	r1=dm(m4,i4);
	r2=r2 and r1;
	dm(m4,i4)=r2;
.LN1342:
// line 4844
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,92);
	m4=dm(-5,i6);
	dm(m4,i4)=m14 (bw);
.LN1343:
// line 4846
	r4=dm(2,i6);
	r2=pass r4;
	if eq jump (pc,.P145L8);

.LN1344:
// line 4848
	r8=m6;
	cjump prvAddCurrentTaskToDelayedList. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ189-1;
.LCJ189:
.LN1345:
// line 4855
	dm(_adi_OSWaitingForSched.)=m6;
.LN1346:
	r2=dm(_adi_OSRescheduleIntID.);
	dm(822644744)=r2;

.LN1347:
	r2=m5;
	bit tst mode1 4096;
	if tf r2=r2+1;

	r2=pass r2;
	if eq jump (pc,.P145L11);


.P145L15:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\tasks.c" line 4855 col 21
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
.LN1348:
	r2=dm(_adi_OSWaitingForSched.);         // Use of volatile in loops precludes optimizations. 
	r2=pass r2;
	if eq jump (pc,.P145L16);

	jump (pc,.P145L15);
//-------------------------------------------------------------------
//   End Loop L15
//-------------------------------------------------------------------

.P145L16:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN1349:
	jump (pc,.P145L12);

.P145L11:

.P145L12:
.LN1350:
// line 4856
	jump (pc,.P145L9);

.P145L8:

.P145L9:
.LN1351:
// line 4861
	jump (pc,.P145L6);

.P145L5:

.P145L6:
.LN1352:
// line 4867
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ190-1;
.LCJ190:
.LN1353:
// line 4869
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ191-1;
.LCJ191:
.LN1354:
// line 4873
	r2=dm(m6,i6);
	r2=pass r2;
	if eq jump (pc,.P145L19);

.LN1355:
// line 4877
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,88);
	m4=dm(-5,i6);
	r2=dm(m4,i4);
	i4=dm(m6,i6);
	dm(i4,m5)=r2;
.LN1356:
// line 4878
	jump (pc,.P145L20);

.P145L19:

.P145L20:
.LN1357:
// line 4884
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,92);
	m4=dm(-5,i6);
	r2=dm(m4,i4) (bw);
	r2=btgl r2 by r15;
	if sz jump (pc,.P145L22);

.LN1358:
// line 4887
	dm(-2,i6)=m13;
.LN1359:
// line 4888
	jump (pc,.P145L23);

.P145L22:
.LN1360:
// line 4893
	r2=dm(-3,i6);
	r2=not r2;
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,88);
	m4=dm(-5,i6);
	r1=dm(m4,i4);
	r2=r2 and r1;
	dm(m4,i4)=r2;
.LN1361:
// line 4894
	dm(-2,i6)=m14;

.P145L23:
.LN1362:
// line 4897
	i4=dm(pxCurrentTCB.);
	i4=modify(i4,92);
	m4=dm(-5,i6);
	dm(m4,i4)=m13 (bw);
.LN1363:
// line 4899
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ192-1;
.LCJ192:
.LN1364:
// line 4901
	r0=dm(-2,i6);
	r15=dm(-6,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xTaskGenericNotifyWait..end:
.xTaskGenericNotifyWait..end:
	.global xTaskGenericNotifyWait.;
	.type xTaskGenericNotifyWait.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="pvTaskIncrementMutexHeldCount.";
	.file_attr FuncName="uxTaskResetEventItemValue.";
	.file_attr FuncName="xTaskGetSchedulerState.";
	.file_attr FuncName="xTaskGetCurrentTaskHandle.";
	.file_attr FuncName="prvResetNextTaskUnblockTime.";
	.file_attr FuncName="prvTaskCheckFreeStackSpace.";
	.file_attr FuncName="pvTaskGetThreadLocalStoragePointer.";
	.file_attr FuncName="vTaskSetTaskNumber.";
	.file_attr FuncName="uxTaskGetTaskNumber.";
	.file_attr FuncName="vTaskMissedYield.";
	.file_attr FuncName="vTaskInternalSetTimeOutState.";
	.file_attr FuncName="uxTaskGetNumberOfTasks.";
	.file_attr FuncName="xTaskGetTickCount.";
	.file_attr FuncName="vTaskSuspendAll.";
	.file_attr FuncName="adi_osal_RegisterLocalStorageCallback.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr FuncName="prvInitialiseNewTask.";
	.file_attr FuncName="eTaskGetState.";
	.file_attr FuncName="uxTaskPriorityGet.";
	.file_attr FuncName="uxTaskPriorityGetFromISR.";
	.file_attr FuncName="vTaskPrioritySet.";
	.file_attr FuncName="prvTaskIsTaskSuspended.";
	.file_attr FuncName="vTaskResume.";
	.file_attr FuncName="xTaskResumeFromISR.";
	.file_attr FuncName="vTaskEndScheduler.";
	.file_attr FuncName="xTaskGetTickCountFromISR.";
	.file_attr FuncName="pcTaskGetName.";
	.file_attr FuncName="xTaskIncrementTick.";
	.file_attr FuncName="xTaskResumeAll.";
	.file_attr FuncName="xTaskCatchUpTicks.";
	.file_attr FuncName="vTaskSwitchContext.";
	.file_attr FuncName="vTaskSuspend.";
	.file_attr FuncName="xTaskRemoveFromEventList.";
	.file_attr FuncName="vTaskRemoveFromUnorderedEventList.";
	.file_attr FuncName="vTaskSetTimeOutState.";
	.file_attr FuncName="xTaskCheckForTimeOut.";
	.file_attr FuncName="vTaskSetThreadLocalStoragePointer.";
	.file_attr FuncName="prvInitialiseTaskLists.";
	.file_attr FuncName="prvAddNewTaskToReadyList.";
	.file_attr FuncName="xTaskCreateStatic.";
	.file_attr FuncName="vTaskStartScheduler.";
	.file_attr FuncName="xTaskCreate.";
	.file_attr FuncName="vTaskGetInfo.";
	.file_attr FuncName="prvListTasksWithinSingleList.";
	.file_attr FuncName="uxTaskGetSystemState.";
	.file_attr FuncName="prvDeleteTCB.";
	.file_attr FuncName="vTaskDelete.";
	.file_attr FuncName="prvCheckTasksWaitingTermination.";
	.file_attr FuncName="prvIdleTask.";
	.file_attr FuncName="xTaskPriorityInherit.";
	.file_attr FuncName="xTaskPriorityDisinherit.";
	.file_attr FuncName="vTaskPriorityDisinheritAfterTimeout.";
	.file_attr FuncName="xTaskGenericNotify.";
	.file_attr FuncName="xTaskGenericNotifyFromISR.";
	.file_attr FuncName="vTaskGenericNotifyGiveFromISR.";
	.file_attr FuncName="xTaskGenericNotifyStateClear.";
	.file_attr FuncName="ulTaskGenericNotifyValueClear.";
	.file_attr FuncName="prvAddCurrentTaskToDelayedList.";
	.file_attr FuncName="xTaskDelayUntil.";
	.file_attr FuncName="vTaskDelay.";
	.file_attr FuncName="vTaskPlaceOnEventList.";
	.file_attr FuncName="vTaskPlaceOnUnorderedEventList.";
	.file_attr FuncName="vTaskPlaceOnEventListRestricted.";
	.file_attr FuncName="ulTaskGenericNotifyTake.";
	.file_attr FuncName="xTaskGenericNotifyWait.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern __simd_memsetD.;
	.type __simd_memsetD.,STT_FUNC;
	.extern vAssertCalled.;
	.type vAssertCalled.,STT_FUNC;
	.extern vListInitialiseItem.;
	.type vListInitialiseItem.,STT_FUNC;
	.extern pxPortInitialiseStack.;
	.type pxPortInitialiseStack.,STT_FUNC;
	.extern vPortEnterCritical.;
	.type vPortEnterCritical.,STT_FUNC;
	.extern vPortExitCritical.;
	.type vPortExitCritical.,STT_FUNC;
	.extern vPortValidateInterruptPriority.;
	.type vPortValidateInterruptPriority.,STT_FUNC;
	.extern ulPortSetInterruptMask.;
	.type ulPortSetInterruptMask.,STT_FUNC;
	.extern vPortClearInterruptMask.;
	.type vPortClearInterruptMask.,STT_FUNC;
	.extern uxListRemove.;
	.type uxListRemove.,STT_FUNC;
	.extern vListInsertEnd.;
	.type vListInsertEnd.,STT_FUNC;
	.extern vPortEndScheduler.;
	.type vPortEndScheduler.,STT_FUNC;
	.extern vApplicationStackOverflowHook.;
	.type vApplicationStackOverflowHook.,STT_FUNC;
	.extern vListInitialise.;
	.type vListInitialise.,STT_FUNC;
	.extern vPortFixupStack.;
	.type vPortFixupStack.,STT_FUNC;
	.extern vApplicationGetIdleTaskMemory.;
	.type vApplicationGetIdleTaskMemory.,STT_FUNC;
	.extern xTimerCreateTimerTask.;
	.type xTimerCreateTimerTask.,STT_FUNC;
	.extern xPortStartScheduler.;
	.type xPortStartScheduler.,STT_FUNC;
	.extern pvPortMalloc.;
	.type pvPortMalloc.,STT_FUNC;
	.extern vPortFree.;
	.type vPortFree.,STT_FUNC;
	.extern vListInsert.;
	.type vListInsert.,STT_FUNC;

	.section/DOUBLE32 seg_dmda;

	.align 8;
	.type .epcbss,STT_OBJECT;
.epcbss:
	.byte pxReadyTasksLists.[140];
	.type pxReadyTasksLists.,STT_OBJECT;
	.byte xDelayedTaskList1.[20];
	.type xDelayedTaskList1.,STT_OBJECT;
	.byte xDelayedTaskList2.[20];
	.type xDelayedTaskList2.,STT_OBJECT;
	.byte pxDelayedTaskList.[4];
	.type pxDelayedTaskList.,STT_OBJECT;
	.byte pxOverflowDelayedTaskList.[4];
	.type pxOverflowDelayedTaskList.,STT_OBJECT;
	.byte xPendingReadyList.[20];
	.type xPendingReadyList.,STT_OBJECT;
	.byte xTasksWaitingTermination.[20];
	.type xTasksWaitingTermination.,STT_OBJECT;
	.byte xSuspendedTaskList.[20];
	.type xSuspendedTaskList.,STT_OBJECT;
.epcbss.end:

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\FreeRTOS\tasks.sbn", 0, 309;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x9A,0x49,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x74,0x61,0x73,0x6B,0x73,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\FreeRTOS\tasks.sbn", 309, 7626;
	.var = .LNpvTaskIncrementMutexHeldCount.;
	.var = .LN.pvTaskIncrementMutexHeldCount..end;
	.byte =
		0x01,0x33,0x19,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.pvTaskIncrementMutexHeldCount..end;
	.byte =
		0x00,0x00,0x13,0x86,0x1E,0x00,0x00,0x75,0x78,0x54,0x61,0x73,
		0x6B,0x52,0x65,0x73,0x65,0x74,0x45,0x76,0x65,0x6E,0x74,0x49,
		0x74,0x65,0x6D,0x56,0x61,0x6C,0x75,0x65,0x00,0x01;
	.var = .LNuxTaskResetEventItemValue.;
	.var = .LN.uxTaskResetEventItemValue..end;
	.byte =
		0x01,0x7A,0x0E,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN4;
	.var = .LN.uxTaskResetEventItemValue..end;
	.byte =
		0x15,0x75,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x7A,
		0x0E,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,
		0x00,0x13,0xD7,0x1E,0x00,0x00,0x78,0x54,0x61,0x73,0x6B,0x47,
		0x65,0x74,0x53,0x63,0x68,0x65,0x64,0x75,0x6C,0x65,0x72,0x53,
		0x74,0x61,0x74,0x65,0x00,0x01;
	.var = .LNxTaskGetSchedulerState.;
	.var = .LN.xTaskGetSchedulerState..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN7;
	.var = .LN.xTaskGetSchedulerState..end;
	.byte =
		0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x13,0x2B,0x1F,0x00,0x00,0x78,0x54,0x61,0x73,0x6B,0x47,0x65,
		0x74,0x43,0x75,0x72,0x72,0x65,0x6E,0x74,0x54,0x61,0x73,0x6B,
		0x48,0x61,0x6E,0x64,0x6C,0x65,0x00,0x01;
	.var = .LNxTaskGetCurrentTaskHandle.;
	.var = .LN.xTaskGetCurrentTaskHandle..end;
	.byte =
		0x01,0x33,0x19,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN15;
	.var = .LN.xTaskGetCurrentTaskHandle..end;
	.byte =
		0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x33,0x19,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x16,0x67,0x1F,0x00,0x00,0x70,0x72,0x76,0x52,0x65,0x73,0x65,
		0x74,0x4E,0x65,0x78,0x74,0x54,0x61,0x73,0x6B,0x55,0x6E,0x62,
		0x6C,0x6F,0x63,0x6B,0x54,0x69,0x6D,0x65,0x00,0x01;
	.var = .LNprvResetNextTaskUnblockTime.;
	.var = .LN.prvResetNextTaskUnblockTime..end;
	.byte =
		0x01,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN17;
	.var = .LN.prvResetNextTaskUnblockTime..end;
	.byte =
		0x00,0x00,0x13,0xD2,0x1F,0x00,0x00,0x70,0x72,0x76,0x54,0x61,
		0x73,0x6B,0x43,0x68,0x65,0x63,0x6B,0x46,0x72,0x65,0x65,0x53,
		0x74,0x61,0x63,0x6B,0x53,0x70,0x61,0x63,0x65,0x00,0x01;
	.var = .LNprvTaskCheckFreeStackSpace.;
	.var = .LN.prvTaskCheckFreeStackSpace..end;
	.byte =
		0x01,0x95,0x07,0x00,0x00,0x00,0x00,0x17,0x70,0x75,0x63,0x53,
		0x74,0x61,0x63,0x6B,0x42,0x79,0x74,0x65,0x00,0xD7,0x1F,0x00,
		0x00,0x02,0x86,0x74,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN22;
	.var = .LN.prvTaskCheckFreeStackSpace..end;
	.byte =
		0x15,0x75,0x6C,0x43,0x6F,0x75,0x6E,0x74,0x00,0x01,0xA4,0x07,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN22-.LNprvTaskCheckFreeStackSpace.;
	.byte =
		0x00,0x00,0x00,0x11,0x87,0x07,0x00,0x00,0x0A,0x00,0xD2,0x1F,
		0x00,0x00,0x13,0x75,0x20,0x00,0x00,0x70,0x76,0x54,0x61,0x73,
		0x6B,0x47,0x65,0x74,0x54,0x68,0x72,0x65,0x61,0x64,0x4C,0x6F,
		0x63,0x61,0x6C,0x53,0x74,0x6F,0x72,0x61,0x67,0x65,0x50,0x6F,
		0x69,0x6E,0x74,0x65,0x72,0x00,0x01;
	.var = .LNpvTaskGetThreadLocalStoragePointer.;
	.var = .LN.pvTaskGetThreadLocalStoragePointer..end;
	.byte =
		0x01,0xC4,0x03,0x00,0x00,0x01,0x00,0x17,0x78,0x54,0x61,0x73,
		0x6B,0x54,0x6F,0x51,0x75,0x65,0x72,0x79,0x00,0x33,0x19,0x00,
		0x00,0x02,0x86,0x68,0x00,0x17,0x78,0x49,0x6E,0x64,0x65,0x78,
		0x00,0x57,0x0E,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x00,0x00,
		0x00,0x00;
	.var = .LN28;
	.var = .LN.pvTaskGetThreadLocalStoragePointer..end;
	.byte =
		0x15,0x70,0x76,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0xC4,
		0x03,0x00,0x00,0x02,0x86,0x70;
	.var = .LN28-.LNpvTaskGetThreadLocalStoragePointer.;
	.byte =
		0x00,0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,
		0x00,0x02,0x86,0x74;
	.var = .LN28-.LNpvTaskGetThreadLocalStoragePointer.;
	.byte =
		0x00,0x00,0x00,0x0A,0x00,0xE3,0x1D,0x00,0x00,0x16,0xE3,0x20,
		0x00,0x00,0x76,0x54,0x61,0x73,0x6B,0x53,0x65,0x74,0x54,0x61,
		0x73,0x6B,0x4E,0x75,0x6D,0x62,0x65,0x72,0x00,0x01;
	.var = .LNvTaskSetTaskNumber.;
	.var = .LN.vTaskSetTaskNumber..end;
	.byte =
		0x01,0x01,0x00,0x17,0x78,0x54,0x61,0x73,0x6B,0x00,0x33,0x19,
		0x00,0x00,0x02,0x86,0x70,0x00,0x17,0x75,0x78,0x48,0x61,0x6E,
		0x64,0x6C,0x65,0x00,0xE3,0x20,0x00,0x00,0x02,0x86,0x74,0x00,
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN35;
	.var = .LN.vTaskSetTaskNumber..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x11,0x68,
		0x0E,0x00,0x00,0x13,0x5A,0x21,0x00,0x00,0x75,0x78,0x54,0x61,
		0x73,0x6B,0x47,0x65,0x74,0x54,0x61,0x73,0x6B,0x4E,0x75,0x6D,
		0x62,0x65,0x72,0x00,0x01;
	.var = .LNuxTaskGetTaskNumber.;
	.var = .LN.uxTaskGetTaskNumber..end;
	.byte =
		0x01,0x68,0x0E,0x00,0x00,0x01,0x00,0x17,0x78,0x54,0x61,0x73,
		0x6B,0x00,0x33,0x19,0x00,0x00,0x02,0x86,0x70,0x00,0x14,0x00,
		0x00,0x00,0x00;
	.var = .LN40;
	.var = .LN.uxTaskGetTaskNumber..end;
	.byte =
		0x15,0x75,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x68,
		0x0E,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x15,
		0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x5F,0x21,0x00,0x00,0x02,
		0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x11,0xE3,0x1D,
		0x00,0x00,0x0A,0x00,0x5A,0x21,0x00,0x00,0x16,0x96,0x21,0x00,
		0x00,0x76,0x54,0x61,0x73,0x6B,0x4D,0x69,0x73,0x73,0x65,0x64,
		0x59,0x69,0x65,0x6C,0x64,0x00,0x01;
	.var = .LNvTaskMissedYield.;
	.var = .LN.vTaskMissedYield..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN46;
	.var = .LN.vTaskMissedYield..end;
	.byte =
		0x00,0x00,0x16,0xE6,0x21,0x00,0x00,0x76,0x54,0x61,0x73,0x6B,
		0x49,0x6E,0x74,0x65,0x72,0x6E,0x61,0x6C,0x53,0x65,0x74,0x54,
		0x69,0x6D,0x65,0x4F,0x75,0x74,0x53,0x74,0x61,0x74,0x65,0x00,
		0x01;
	.var = .LNvTaskInternalSetTimeOutState.;
	.var = .LN.vTaskInternalSetTimeOutState..end;
	.byte =
		0x01,0x01,0x00,0x17,0x70,0x78,0x54,0x69,0x6D,0x65,0x4F,0x75,
		0x74,0x00,0xEC,0x21,0x00,0x00,0x02,0x86,0x78,0x00,0x14,0x00,
		0x00,0x00,0x00;
	.var = .LN48;
	.var = .LN.vTaskInternalSetTimeOutState..end;
	.byte =
		0x00,0x00,0x0A,0x00,0x90,0x1A,0x00,0x00,0x11,0xE6,0x21,0x00,
		0x00,0x13,0x2C,0x22,0x00,0x00,0x75,0x78,0x54,0x61,0x73,0x6B,
		0x47,0x65,0x74,0x4E,0x75,0x6D,0x62,0x65,0x72,0x4F,0x66,0x54,
		0x61,0x73,0x6B,0x73,0x00,0x01;
	.var = .LNuxTaskGetNumberOfTasks.;
	.var = .LN.uxTaskGetNumberOfTasks..end;
	.byte =
		0x01,0x68,0x0E,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN51;
	.var = .LN.uxTaskGetNumberOfTasks..end;
	.byte =
		0x00,0x00,0x13,0x77,0x22,0x00,0x00,0x78,0x54,0x61,0x73,0x6B,
		0x47,0x65,0x74,0x54,0x69,0x63,0x6B,0x43,0x6F,0x75,0x6E,0x74,
		0x00,0x01;
	.var = .LNxTaskGetTickCount.;
	.var = .LN.xTaskGetTickCount..end;
	.byte =
		0x01,0x7A,0x0E,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN52;
	.var = .LN.xTaskGetTickCount..end;
	.byte =
		0x15,0x78,0x54,0x69,0x63,0x6B,0x73,0x00,0x01,0x7A,0x0E,0x00,
		0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,
		0xA7,0x22,0x00,0x00,0x76,0x54,0x61,0x73,0x6B,0x53,0x75,0x73,
		0x70,0x65,0x6E,0x64,0x41,0x6C,0x6C,0x00,0x01;
	.var = .LNvTaskSuspendAll.;
	.var = .LN.vTaskSuspendAll..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN54;
	.var = .LN.vTaskSuspendAll..end;
	.byte =
		0x00,0x00,0x16,0x08,0x23,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x52,0x65,0x67,0x69,0x73,0x74,0x65,0x72,
		0x4C,0x6F,0x63,0x61,0x6C,0x53,0x74,0x6F,0x72,0x61,0x67,0x65,
		0x43,0x61,0x6C,0x6C,0x62,0x61,0x63,0x6B,0x00,0x01;
	.var = .LNadi_osal_RegisterLocalStorageCallback.;
	.var = .LN.adi_osal_RegisterLocalStorageCallback..end;
	.byte =
		0x01,0x01,0x00,0x17,0x78,0x43,0x61,0x6C,0x6C,0x62,0x61,0x63,
		0x6B,0x46,0x75,0x6E,0x63,0x74,0x69,0x6F,0x6E,0x00,0xC4,0x03,
		0x00,0x00,0x02,0x86,0x78,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN56;
	.var = .LN.adi_osal_RegisterLocalStorageCallback..end;
	.byte =
		0x00,0x00,0x16,0x07,0x24,0x00,0x00,0x70,0x72,0x76,0x49,0x6E,
		0x69,0x74,0x69,0x61,0x6C,0x69,0x73,0x65,0x4E,0x65,0x77,0x54,
		0x61,0x73,0x6B,0x00,0x01;
	.var = .LNprvInitialiseNewTask.;
	.var = .LN.prvInitialiseNewTask..end;
	.inc/binary ".\system\FreeRTOS\tasks.sbn", 7935, 167;
	.var = .LN60;
	.var = .LN.prvInitialiseNewTask..end;
	.byte =
		0x15,0x70,0x78,0x54,0x6F,0x70,0x4F,0x66,0x53,0x74,0x61,0x63,
		0x6B,0x00,0x01,0xB5,0x17,0x00,0x00,0x02,0x86,0x74,0x00,0x00,
		0x00,0x00,0x00,0x15,0x78,0x00,0x01,0x68,0x0E,0x00,0x00,0x02,
		0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x11,0xFE,0x1A,
		0x00,0x00,0x0A,0x00,0x07,0x24,0x00,0x00,0x11,0x0C,0x24,0x00,
		0x00,0x0A,0x00,0x33,0x19,0x00,0x00,0x11,0x17,0x24,0x00,0x00,
		0x11,0xC4,0x03,0x00,0x00,0x11,0xA4,0x07,0x00,0x00,0x11,0x45,
		0x1B,0x00,0x00,0x13,0x16,0x25,0x00,0x00,0x65,0x54,0x61,0x73,
		0x6B,0x47,0x65,0x74,0x53,0x74,0x61,0x74,0x65,0x00,0x01;
	.var = .LNeTaskGetState.;
	.var = .LN.eTaskGetState..end;
	.byte =
		0x01,0xC4,0x19,0x00,0x00,0x01,0x00,0x17,0x78,0x54,0x61,0x73,
		0x6B,0x00,0x33,0x19,0x00,0x00,0x02,0x86,0x60,0x00,0x14,0x00,
		0x00,0x00,0x00;
	.var = .LN97;
	.var = .LN.eTaskGetState..end;
	.inc/binary ".\system\FreeRTOS\tasks.sbn", 8102, 139;
	.var = .LN114;
	.var = .LN120;
	.byte =
		0x15,0x78,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,0x78,0x00,
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x11,0x5F,0x21,0x00,0x00,
		0x11,0x27,0x17,0x00,0x00,0x0A,0x00,0x1B,0x25,0x00,0x00,0x13,
		0x96,0x25,0x00,0x00,0x75,0x78,0x54,0x61,0x73,0x6B,0x50,0x72,
		0x69,0x6F,0x72,0x69,0x74,0x79,0x47,0x65,0x74,0x00,0x01;
	.var = .LNuxTaskPriorityGet.;
	.var = .LN.uxTaskPriorityGet..end;
	.byte =
		0x01,0x68,0x0E,0x00,0x00,0x01,0x00,0x17,0x78,0x54,0x61,0x73,
		0x6B,0x00,0x96,0x25,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x00,
		0x00,0x00,0x00;
	.var = .LN128;
	.var = .LN.uxTaskPriorityGet..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x5F,0x21,0x00,0x00,
		0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x52,
		0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x68,0x0E,0x00,0x00,0x02,
		0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x11,0x33,0x19,
		0x00,0x00,0x13,0x36,0x26,0x00,0x00,0x75,0x78,0x54,0x61,0x73,
		0x6B,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x47,0x65,0x74,
		0x46,0x72,0x6F,0x6D,0x49,0x53,0x52,0x00,0x01;
	.var = .LNuxTaskPriorityGetFromISR.;
	.var = .LN.uxTaskPriorityGetFromISR..end;
	.byte =
		0x01,0x68,0x0E,0x00,0x00,0x01,0x00,0x17,0x78,0x54,0x61,0x73,
		0x6B,0x00,0x96,0x25,0x00,0x00,0x02,0x86,0x68,0x00,0x14,0x00,
		0x00,0x00,0x00;
	.var = .LN133;
	.var = .LN.uxTaskPriorityGetFromISR..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x5F,0x21,0x00,0x00,
		0x02,0x86,0x6C,0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x52,
		0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x68,0x0E,0x00,0x00,0x02,
		0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x53,0x61,
		0x76,0x65,0x64,0x49,0x6E,0x74,0x65,0x72,0x72,0x75,0x70,0x74,
		0x53,0x74,0x61,0x74,0x65,0x00,0x01,0x68,0x0E,0x00,0x00,0x02,
		0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,0x2A,0x27,
		0x00,0x00,0x76,0x54,0x61,0x73,0x6B,0x50,0x72,0x69,0x6F,0x72,
		0x69,0x74,0x79,0x53,0x65,0x74,0x00,0x01;
	.var = .LNvTaskPrioritySet.;
	.var = .LN.vTaskPrioritySet..end;
	.byte =
		0x01,0x01,0x00,0x17,0x78,0x54,0x61,0x73,0x6B,0x00,0x33,0x19,
		0x00,0x00,0x02,0x86,0x58,0x00,0x17,0x75,0x78,0x4E,0x65,0x77,
		0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x00,0x68,0x0E,0x00,
		0x00,0x02,0x86,0x5C,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN141;
	.var = .LN.vTaskPrioritySet..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x60,0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x43,
		0x75,0x72,0x72,0x65,0x6E,0x74,0x42,0x61,0x73,0x65,0x50,0x72,
		0x69,0x6F,0x72,0x69,0x74,0x79,0x00,0x01,0x68,0x0E,0x00,0x00,
		0x02,0x86,0x64,0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x50,
		0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x55,0x73,0x65,0x64,0x4F,
		0x6E,0x45,0x6E,0x74,0x72,0x79,0x00,0x01,0x68,0x0E,0x00,0x00,
		0x02,0x86,0x68,0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x59,0x69,
		0x65,0x6C,0x64,0x52,0x65,0x71,0x75,0x69,0x72,0x65,0x64,0x00,
		0x01,0x57,0x0E,0x00,0x00,0x02,0x86,0x6C;
	.var = .LN141-.LNvTaskPrioritySet.;
	.byte =
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN173;
	.var = .LN183;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN182-.LN173;
	.byte =
		0x00,0x00,0x00,0x00,0x11,0x7B,0x16,0x00,0x00,0x13,0xA3,0x27,
		0x00,0x00,0x70,0x72,0x76,0x54,0x61,0x73,0x6B,0x49,0x73,0x54,
		0x61,0x73,0x6B,0x53,0x75,0x73,0x70,0x65,0x6E,0x64,0x65,0x64,
		0x00,0x01;
	.var = .LNprvTaskIsTaskSuspended.;
	.var = .LN.prvTaskIsTaskSuspended..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x00,0x00,0x17,0x78,0x54,0x61,0x73,
		0x6B,0x00,0x96,0x25,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x00,
		0x00,0x00,0x00;
	.var = .LN194;
	.var = .LN.prvTaskIsTaskSuspended..end;
	.byte =
		0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x70;
	.var = .LN194-.LNprvTaskIsTaskSuspended.;
	.byte =
		0x00,0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x16,0x25,0x00,
		0x00,0x02,0x86,0x74;
	.var = .LN194-.LNprvTaskIsTaskSuspended.;
	.byte =
		0x00,0x00,0x00,0x16,0x1E,0x28,0x00,0x00,0x76,0x54,0x61,0x73,
		0x6B,0x52,0x65,0x73,0x75,0x6D,0x65,0x00,0x01;
	.var = .LNvTaskResume.;
	.var = .LN.vTaskResume..end;
	.byte =
		0x01,0x01,0x00,0x17,0x78,0x54,0x61,0x73,0x6B,0x54,0x6F,0x52,
		0x65,0x73,0x75,0x6D,0x65,0x00,0x33,0x19,0x00,0x00,0x02,0x86,
		0x70,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN207;
	.var = .LN.vTaskResume..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x1E,0x28,0x00,0x00,
		0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x14,0x00,0x00,0x00,
		0x00;
	.var = .LN218;
	.var = .LN228;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN227-.LN218;
	.byte =
		0x00,0x00,0x00,0x00,0x11,0x75,0x20,0x00,0x00,0x13,0xEB,0x28,
		0x00,0x00,0x78,0x54,0x61,0x73,0x6B,0x52,0x65,0x73,0x75,0x6D,
		0x65,0x46,0x72,0x6F,0x6D,0x49,0x53,0x52,0x00,0x01;
	.var = .LNxTaskResumeFromISR.;
	.var = .LN.xTaskResumeFromISR..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x17,0x78,0x54,0x61,0x73,
		0x6B,0x54,0x6F,0x52,0x65,0x73,0x75,0x6D,0x65,0x00,0x33,0x19,
		0x00,0x00,0x02,0x86,0x68,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN239;
	.var = .LN.xTaskResumeFromISR..end;
	.byte =
		0x15,0x78,0x59,0x69,0x65,0x6C,0x64,0x52,0x65,0x71,0x75,0x69,
		0x72,0x65,0x64,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,0x6C;
	.var = .LN239-.LNxTaskResumeFromISR.;
	.byte =
		0x00,0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x1E,0x28,0x00,
		0x00,0x02,0x86,0x70;
	.var = .LN239-.LNxTaskResumeFromISR.;
	.byte =
		0x00,0x15,0x75,0x78,0x53,0x61,0x76,0x65,0x64,0x49,0x6E,0x74,
		0x65,0x72,0x72,0x75,0x70,0x74,0x53,0x74,0x61,0x74,0x75,0x73,
		0x00,0x01,0x68,0x0E,0x00,0x00,0x02,0x86,0x74;
	.var = .LN240-.LNxTaskResumeFromISR.;
	.byte =
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN257;
	.var = .LN267;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN266-.LN257;
	.byte =
		0x00,0x00,0x00,0x00,0x16,0x1D,0x29,0x00,0x00,0x76,0x54,0x61,
		0x73,0x6B,0x45,0x6E,0x64,0x53,0x63,0x68,0x65,0x64,0x75,0x6C,
		0x65,0x72,0x00,0x01;
	.var = .LNvTaskEndScheduler.;
	.var = .LN.vTaskEndScheduler..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN274;
	.var = .LN.vTaskEndScheduler..end;
	.byte =
		0x00,0x00,0x13,0x95,0x29,0x00,0x00,0x78,0x54,0x61,0x73,0x6B,
		0x47,0x65,0x74,0x54,0x69,0x63,0x6B,0x43,0x6F,0x75,0x6E,0x74,
		0x46,0x72,0x6F,0x6D,0x49,0x53,0x52,0x00,0x01;
	.var = .LNxTaskGetTickCountFromISR.;
	.var = .LN.xTaskGetTickCountFromISR..end;
	.byte =
		0x01,0x7A,0x0E,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN278;
	.var = .LN.xTaskGetTickCountFromISR..end;
	.byte =
		0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x7A,0x0E,
		0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x15,0x75,
		0x78,0x53,0x61,0x76,0x65,0x64,0x49,0x6E,0x74,0x65,0x72,0x72,
		0x75,0x70,0x74,0x53,0x74,0x61,0x74,0x75,0x73,0x00,0x01,0x68,
		0x0E,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,
		0x00,0x13,0xF1,0x29,0x00,0x00,0x70,0x63,0x54,0x61,0x73,0x6B,
		0x47,0x65,0x74,0x4E,0x61,0x6D,0x65,0x00,0x01;
	.var = .LNpcTaskGetName.;
	.var = .LN.pcTaskGetName..end;
	.byte =
		0x01,0xE9,0x06,0x00,0x00,0x01,0x00,0x17,0x78,0x54,0x61,0x73,
		0x6B,0x54,0x6F,0x51,0x75,0x65,0x72,0x79,0x00,0x33,0x19,0x00,
		0x00,0x02,0x86,0x70,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN282;
	.var = .LN.pcTaskGetName..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x13,0x2C,
		0x2B,0x00,0x00,0x78,0x54,0x61,0x73,0x6B,0x49,0x6E,0x63,0x72,
		0x65,0x6D,0x65,0x6E,0x74,0x54,0x69,0x63,0x6B,0x00,0x01;
	.var = .LNxTaskIncrementTick.;
	.var = .LN.xTaskIncrementTick..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN287;
	.var = .LN.xTaskIncrementTick..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x54,0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x49,0x74,
		0x65,0x6D,0x56,0x61,0x6C,0x75,0x65,0x00,0x01,0x7A,0x0E,0x00,
		0x00,0x02,0x86,0x58,0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x53,
		0x77,0x69,0x74,0x63,0x68,0x52,0x65,0x71,0x75,0x69,0x72,0x65,
		0x64,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,0x5C;
	.var = .LN287-.LNxTaskIncrementTick.;
	.byte =
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN289;
	.var = .LN349;
	.byte =
		0x15,0x78,0x43,0x6F,0x6E,0x73,0x74,0x54,0x69,0x63,0x6B,0x43,
		0x6F,0x75,0x6E,0x74,0x00,0x01,0x37,0x2B,0x00,0x00,0x02,0x86,
		0x60,0x00,0x00,0x00,0x00,0x00,0x14,0xBF,0x2A,0x00,0x00;
	.var = .LN292;
	.var = .LN300;
	.byte =
		0x15,0x70,0x78,0x54,0x65,0x6D,0x70,0x00,0x01,0x2C,0x2B,0x00,
		0x00,0x02,0x86,0x64;
	.var = .LN299-.LN292;
	.byte =
		0x00,0x00,0x14,0xE2,0x2A,0x00,0x00;
	.var = .LN310;
	.var = .LN318;
	.byte =
		0x15,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0x01,0x32,0x2B,0x00,
		0x00,0x02,0x86,0x70;
	.var = .LN317-.LN310;
	.byte =
		0x00,0x00,0x14,0x06,0x2B,0x00,0x00;
	.var = .LN328;
	.var = .LN338;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN337-.LN328;
	.byte =
		0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN319;
	.var = .LN327;
	.byte =
		0x15,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0x01,0x32,0x2B,0x00,
		0x00,0x02,0x86,0x74;
	.var = .LN326-.LN319;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x0A,0x00,0x27,0x17,0x00,0x00,0x11,
		0x2C,0x2B,0x00,0x00,0x11,0x7A,0x0E,0x00,0x00,0x13,0x35,0x2C,
		0x00,0x00,0x78,0x54,0x61,0x73,0x6B,0x52,0x65,0x73,0x75,0x6D,
		0x65,0x41,0x6C,0x6C,0x00,0x01;
	.var = .LNxTaskResumeAll.;
	.var = .LN.xTaskResumeAll..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN351;
	.var = .LN.xTaskResumeAll..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x60;
	.var = .LN351-.LNxTaskResumeAll.;
	.byte =
		0x00,0x15,0x78,0x41,0x6C,0x72,0x65,0x61,0x64,0x79,0x59,0x69,
		0x65,0x6C,0x64,0x65,0x64,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,
		0x86,0x64;
	.var = .LN352-.LNxTaskResumeAll.;
	.byte =
		0x00,0x14,0xC2,0x2B,0x00,0x00;
	.var = .LN362;
	.var = .LN370;
	.byte =
		0x15,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0x01,0x32,0x2B,0x00,
		0x00,0x02,0x86,0x6C;
	.var = .LN369-.LN362;
	.byte =
		0x00,0x00,0x14,0xE5,0x2B,0x00,0x00;
	.var = .LN370;
	.var = .LN378;
	.byte =
		0x15,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0x01,0x32,0x2B,0x00,
		0x00,0x02,0x86,0x70;
	.var = .LN377-.LN370;
	.byte =
		0x00,0x00,0x14,0x09,0x2C,0x00,0x00;
	.var = .LN378;
	.var = .LN388;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x74;
	.var = .LN387-.LN378;
	.byte =
		0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN394;
	.var = .LN405;
	.byte =
		0x15,0x78,0x50,0x65,0x6E,0x64,0x65,0x64,0x43,0x6F,0x75,0x6E,
		0x74,0x73,0x00,0x01,0x7A,0x0E,0x00,0x00,0x02,0x86,0x78,0x00,
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x13,0xA1,0x2C,0x00,0x00,
		0x78,0x54,0x61,0x73,0x6B,0x43,0x61,0x74,0x63,0x68,0x55,0x70,
		0x54,0x69,0x63,0x6B,0x73,0x00,0x01;
	.var = .LNxTaskCatchUpTicks.;
	.var = .LN.xTaskCatchUpTicks..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x17,0x78,0x54,0x69,0x63,
		0x6B,0x73,0x54,0x6F,0x43,0x61,0x74,0x63,0x68,0x55,0x70,0x00,
		0x7A,0x0E,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x00,0x00,0x00,
		0x00;
	.var = .LN417;
	.var = .LN.xTaskCatchUpTicks..end;
	.byte =
		0x15,0x78,0x59,0x69,0x65,0x6C,0x64,0x4F,0x63,0x63,0x75,0x72,
		0x72,0x65,0x64,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,0x78,
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,0x66,0x2D,0x00,0x00,
		0x76,0x54,0x61,0x73,0x6B,0x53,0x77,0x69,0x74,0x63,0x68,0x43,
		0x6F,0x6E,0x74,0x65,0x78,0x74,0x00,0x01;
	.var = .LNvTaskSwitchContext.;
	.var = .LN.vTaskSwitchContext..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN427;
	.var = .LN.vTaskSwitchContext..end;
	.byte =
		0x14,0x12,0x2D,0x00,0x00;
	.var = .LN431;
	.var = .LN437;
	.byte =
		0x15,0x70,0x75,0x6C,0x53,0x74,0x61,0x63,0x6B,0x00,0x01,0x6C,
		0x2D,0x00,0x00,0x02,0x86,0x68;
	.var = .LN436-.LN431;
	.byte =
		0x00,0x15,0x75,0x6C,0x43,0x68,0x65,0x63,0x6B,0x56,0x61,0x6C,
		0x75,0x65,0x00,0x01,0x27,0x24,0x00,0x00,0x02,0x86,0x6C;
	.var = .LN436-.LN431;
	.byte =
		0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN437;
	.var = .LN450;
	.byte =
		0x15,0x75,0x78,0x54,0x6F,0x70,0x50,0x72,0x69,0x6F,0x72,0x69,
		0x74,0x79,0x00,0x01,0x68,0x0E,0x00,0x00,0x02,0x86,0x70;
	.var = .LN449-.LN437;
	.byte =
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN437;
	.var = .LN450;
	.byte =
		0x15,0x70,0x78,0x43,0x6F,0x6E,0x73,0x74,0x4C,0x69,0x73,0x74,
		0x00,0x01,0x32,0x2B,0x00,0x00,0x02,0x86,0x78;
	.var = .LN449-.LN437;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x0A,0x00,0x27,0x24,0x00,0x00,0x11,
		0x66,0x2D,0x00,0x00,0x16,0xE8,0x2D,0x00,0x00,0x76,0x54,0x61,
		0x73,0x6B,0x53,0x75,0x73,0x70,0x65,0x6E,0x64,0x00,0x01;
	.var = .LNvTaskSuspend.;
	.var = .LN.vTaskSuspend..end;
	.byte =
		0x01,0x01,0x00,0x17,0x78,0x54,0x61,0x73,0x6B,0x54,0x6F,0x53,
		0x75,0x73,0x70,0x65,0x6E,0x64,0x00,0x33,0x19,0x00,0x00,0x02,
		0x86,0x6C,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN451;
	.var = .LN.vTaskSuspend..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x14,0x00,0x00,0x00,
		0x00;
	.var = .LN461;
	.var = .LN466;
	.byte =
		0x15,0x78,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,0x78,0x00,
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x13,0xFB,0x2E,0x00,0x00,
		0x78,0x54,0x61,0x73,0x6B,0x52,0x65,0x6D,0x6F,0x76,0x65,0x46,
		0x72,0x6F,0x6D,0x45,0x76,0x65,0x6E,0x74,0x4C,0x69,0x73,0x74,
		0x00,0x01;
	.var = .LNxTaskRemoveFromEventList.;
	.var = .LN.xTaskRemoveFromEventList..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x17,0x70,0x78,0x45,0x76,
		0x65,0x6E,0x74,0x4C,0x69,0x73,0x74,0x00,0xFB,0x2E,0x00,0x00,
		0x02,0x86,0x60,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN489;
	.var = .LN.xTaskRemoveFromEventList..end;
	.byte =
		0x15,0x70,0x78,0x55,0x6E,0x62,0x6C,0x6F,0x63,0x6B,0x65,0x64,
		0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,0x02,0x86,0x64,
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x52,0x65,0x74,0x75,0x72,
		0x6E,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,0x68,0x00,0x00,
		0x00,0x00,0x00,0x14,0x8E,0x2E,0x00,0x00;
	.var = .LN493;
	.var = .LN501;
	.byte =
		0x15,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0x01,0x32,0x2B,0x00,
		0x00,0x02,0x86,0x6C;
	.var = .LN500-.LN493;
	.byte =
		0x00,0x00,0x14,0xB1,0x2E,0x00,0x00;
	.var = .LN502;
	.var = .LN510;
	.byte =
		0x15,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0x01,0x32,0x2B,0x00,
		0x00,0x02,0x86,0x70;
	.var = .LN509-.LN502;
	.byte =
		0x00,0x00,0x14,0xD5,0x2E,0x00,0x00;
	.var = .LN510;
	.var = .LN520;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x74;
	.var = .LN519-.LN510;
	.byte =
		0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN521;
	.var = .LN528;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN527-.LN521;
	.byte =
		0x00,0x00,0x00,0x00,0x11,0x20,0x25,0x00,0x00,0x16,0xF6,0x2F,
		0x00,0x00,0x76,0x54,0x61,0x73,0x6B,0x52,0x65,0x6D,0x6F,0x76,
		0x65,0x46,0x72,0x6F,0x6D,0x55,0x6E,0x6F,0x72,0x64,0x65,0x72,
		0x65,0x64,0x45,0x76,0x65,0x6E,0x74,0x4C,0x69,0x73,0x74,0x00,
		0x01;
	.var = .LNvTaskRemoveFromUnorderedEventList.;
	.var = .LN.vTaskRemoveFromUnorderedEventList..end;
	.byte =
		0x01,0x01,0x00,0x17,0x70,0x78,0x45,0x76,0x65,0x6E,0x74,0x4C,
		0x69,0x73,0x74,0x49,0x74,0x65,0x6D,0x00,0x7B,0x16,0x00,0x00,
		0x02,0x86,0x64,0x00,0x17,0x78,0x49,0x74,0x65,0x6D,0x56,0x61,
		0x6C,0x75,0x65,0x00,0x37,0x2B,0x00,0x00,0x02,0x86,0x68,0x00,
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN534;
	.var = .LN.vTaskRemoveFromUnorderedEventList..end;
	.byte =
		0x15,0x70,0x78,0x55,0x6E,0x62,0x6C,0x6F,0x63,0x6B,0x65,0x64,
		0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,0x02,0x86,0x6C,
		0x00,0x00,0x00,0x00,0x00,0x14,0xAD,0x2F,0x00,0x00;
	.var = .LN542;
	.var = .LN550;
	.byte =
		0x15,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0x01,0x32,0x2B,0x00,
		0x00,0x02,0x86,0x70;
	.var = .LN549-.LN542;
	.byte =
		0x00,0x00,0x14,0xD0,0x2F,0x00,0x00;
	.var = .LN550;
	.var = .LN558;
	.byte =
		0x15,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0x01,0x32,0x2B,0x00,
		0x00,0x02,0x86,0x74;
	.var = .LN557-.LN550;
	.byte =
		0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN558;
	.var = .LN568;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN567-.LN558;
	.byte =
		0x00,0x00,0x00,0x00,0x16,0x3E,0x30,0x00,0x00,0x76,0x54,0x61,
		0x73,0x6B,0x53,0x65,0x74,0x54,0x69,0x6D,0x65,0x4F,0x75,0x74,
		0x53,0x74,0x61,0x74,0x65,0x00,0x01;
	.var = .LNvTaskSetTimeOutState.;
	.var = .LN.vTaskSetTimeOutState..end;
	.byte =
		0x01,0x01,0x00,0x17,0x70,0x78,0x54,0x69,0x6D,0x65,0x4F,0x75,
		0x74,0x00,0xEC,0x21,0x00,0x00,0x02,0x86,0x78,0x00,0x14,0x00,
		0x00,0x00,0x00;
	.var = .LN572;
	.var = .LN.vTaskSetTimeOutState..end;
	.byte =
		0x00,0x00,0x13,0xFE,0x30,0x00,0x00,0x78,0x54,0x61,0x73,0x6B,
		0x43,0x68,0x65,0x63,0x6B,0x46,0x6F,0x72,0x54,0x69,0x6D,0x65,
		0x4F,0x75,0x74,0x00,0x01;
	.var = .LNxTaskCheckForTimeOut.;
	.var = .LN.xTaskCheckForTimeOut..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x17,0x70,0x78,0x54,0x69,
		0x6D,0x65,0x4F,0x75,0x74,0x00,0xEC,0x21,0x00,0x00,0x02,0x86,
		0x68,0x00,0x17,0x70,0x78,0x54,0x69,0x63,0x6B,0x73,0x54,0x6F,
		0x57,0x61,0x69,0x74,0x00,0x04,0x31,0x00,0x00,0x02,0x86,0x6C,
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN580;
	.var = .LN.xTaskCheckForTimeOut..end;
	.byte =
		0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x14,0x00,
		0x00,0x00,0x00;
	.var = .LN587;
	.var = .LN604;
	.byte =
		0x15,0x78,0x43,0x6F,0x6E,0x73,0x74,0x54,0x69,0x63,0x6B,0x43,
		0x6F,0x75,0x6E,0x74,0x00,0x01,0x37,0x2B,0x00,0x00,0x02,0x86,
		0x74,0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x45,0x6C,0x61,0x70,
		0x73,0x65,0x64,0x54,0x69,0x6D,0x65,0x00,0x01,0x37,0x2B,0x00,
		0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x0A,0x00,0x7A,0x0E,0x00,0x00,0x11,0xFE,0x30,0x00,0x00,0x16,
		0x94,0x31,0x00,0x00,0x76,0x54,0x61,0x73,0x6B,0x53,0x65,0x74,
		0x54,0x68,0x72,0x65,0x61,0x64,0x4C,0x6F,0x63,0x61,0x6C,0x53,
		0x74,0x6F,0x72,0x61,0x67,0x65,0x50,0x6F,0x69,0x6E,0x74,0x65,
		0x72,0x00,0x01;
	.var = .LNvTaskSetThreadLocalStoragePointer.;
	.var = .LN.vTaskSetThreadLocalStoragePointer..end;
	.byte =
		0x01,0x01,0x00,0x17,0x78,0x54,0x61,0x73,0x6B,0x54,0x6F,0x53,
		0x65,0x74,0x00,0x33,0x19,0x00,0x00,0x02,0x86,0x68,0x00,0x17,
		0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x57,0x0E,0x00,0x00,0x02,
		0x86,0x6C,0x00,0x17,0x70,0x76,0x56,0x61,0x6C,0x75,0x65,0x00,
		0xC4,0x03,0x00,0x00,0x02,0x86,0x70,0x00,0x14,0x00,0x00,0x00,
		0x00;
	.var = .LN606;
	.var = .LN.vTaskSetThreadLocalStoragePointer..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,0xE4,
		0x31,0x00,0x00,0x70,0x72,0x76,0x49,0x6E,0x69,0x74,0x69,0x61,
		0x6C,0x69,0x73,0x65,0x54,0x61,0x73,0x6B,0x4C,0x69,0x73,0x74,
		0x73,0x00,0x01;
	.var = .LNprvInitialiseTaskLists.;
	.var = .LN.prvInitialiseTaskLists..end;
	.byte =
		0x01,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN614;
	.var = .LN.prvInitialiseTaskLists..end;
	.byte =
		0x15,0x75,0x78,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x00,
		0x01,0x68,0x0E,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,
		0x00,0x00,0x00,0x16,0x53,0x32,0x00,0x00,0x70,0x72,0x76,0x41,
		0x64,0x64,0x4E,0x65,0x77,0x54,0x61,0x73,0x6B,0x54,0x6F,0x52,
		0x65,0x61,0x64,0x79,0x4C,0x69,0x73,0x74,0x00,0x01;
	.var = .LNprvAddNewTaskToReadyList.;
	.var = .LN.prvAddNewTaskToReadyList..end;
	.byte =
		0x01,0x00,0x00,0x17,0x70,0x78,0x4E,0x65,0x77,0x54,0x43,0x42,
		0x00,0x75,0x20,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x00,0x00,
		0x00,0x00;
	.var = .LN626;
	.var = .LN.prvAddNewTaskToReadyList..end;
	.byte =
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN641;
	.var = .LN651;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN650-.LN641;
	.byte =
		0x00,0x00,0x00,0x00,0x13,0x6A,0x33,0x00,0x00,0x78,0x54,0x61,
		0x73,0x6B,0x43,0x72,0x65,0x61,0x74,0x65,0x53,0x74,0x61,0x74,
		0x69,0x63,0x00,0x01;
	.var = .LNxTaskCreateStatic.;
	.var = .LN.xTaskCreateStatic..end;
	.inc/binary ".\system\FreeRTOS\tasks.sbn", 8241, 158;
	.var = .LN664;
	.var = .LN.xTaskCreateStatic..end;
	.byte =
		0x15,0x70,0x78,0x4E,0x65,0x77,0x54,0x43,0x42,0x00,0x01,0x75,
		0x20,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x15,
		0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x33,0x19,0x00,
		0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x14,0x00,0x00,
		0x00,0x00;
	.var = .LN670;
	.var = .LN675;
	.byte =
		0x15,0x78,0x53,0x69,0x7A,0x65,0x00,0x01,0x6A,0x33,0x00,0x00,
		0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x10,
		0xCF,0x03,0x00,0x00,0x0A,0x00,0xA9,0x12,0x00,0x00,0x11,0x6F,
		0x33,0x00,0x00,0x11,0xB5,0x17,0x00,0x00,0x16,0x3F,0x34,0x00,
		0x00,0x76,0x54,0x61,0x73,0x6B,0x53,0x74,0x61,0x72,0x74,0x53,
		0x63,0x68,0x65,0x64,0x75,0x6C,0x65,0x72,0x00,0x01;
	.var = .LNvTaskStartScheduler.;
	.var = .LN.vTaskStartScheduler..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN687;
	.var = .LN.vTaskStartScheduler..end;
	.byte =
		0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x6C,0x00,0x00,0x00,0x00,0x00,0x14,0x00,
		0x00,0x00,0x00;
	.var = .LN687;
	.var = .LN697;
	.byte =
		0x15,0x70,0x78,0x49,0x64,0x6C,0x65,0x54,0x61,0x73,0x6B,0x54,
		0x43,0x42,0x42,0x75,0x66,0x66,0x65,0x72,0x00,0x01,0x6F,0x33,
		0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x15,0x70,
		0x78,0x49,0x64,0x6C,0x65,0x54,0x61,0x73,0x6B,0x53,0x74,0x61,
		0x63,0x6B,0x42,0x75,0x66,0x66,0x65,0x72,0x00,0x01,0xB5,0x17,
		0x00,0x00,0x02,0x86,0x74;
	.var = .LN688-.LN687;
	.byte =
		0x00,0x15,0x75,0x6C,0x49,0x64,0x6C,0x65,0x54,0x61,0x73,0x6B,
		0x53,0x74,0x61,0x63,0x6B,0x53,0x69,0x7A,0x65,0x00,0x01,0xA4,
		0x07,0x00,0x00,0x02,0x86,0x78;
	.var = .LN688-.LN687;
	.byte =
		0x00,0x00,0x00,0x00,0x13,0x3B,0x35,0x00,0x00,0x78,0x54,0x61,
		0x73,0x6B,0x43,0x72,0x65,0x61,0x74,0x65,0x00,0x01;
	.var = .LNxTaskCreate.;
	.var = .LN.xTaskCreate..end;
	.inc/binary ".\system\FreeRTOS\tasks.sbn", 8399, 135;
	.var = .LN713;
	.var = .LN.xTaskCreate..end;
	.byte =
		0x15,0x70,0x78,0x4E,0x65,0x77,0x54,0x43,0x42,0x00,0x01,0x75,
		0x20,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x15,
		0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,0x00,
		0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x14,0x00,0x00,
		0x00,0x00;
	.var = .LN713;
	.var = .LN727;
	.byte =
		0x15,0x70,0x78,0x53,0x74,0x61,0x63,0x6B,0x00,0x01,0xB5,0x17,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x00,0x11,0x95,0x07,0x00,0x00,0x16,0xD2,0x35,0x00,0x00,0x76,
		0x54,0x61,0x73,0x6B,0x47,0x65,0x74,0x49,0x6E,0x66,0x6F,0x00,
		0x01;
	.var = .LNvTaskGetInfo.;
	.var = .LN.vTaskGetInfo..end;
	.byte =
		0x01,0x01,0x00,0x17,0x78,0x54,0x61,0x73,0x6B,0x00,0x33,0x19,
		0x00,0x00,0x02,0x86,0x68,0x00,0x17,0x70,0x78,0x54,0x61,0x73,
		0x6B,0x53,0x74,0x61,0x74,0x75,0x73,0x00,0xD2,0x35,0x00,0x00,
		0x02,0x86,0x6C,0x00,0x17,0x78,0x47,0x65,0x74,0x46,0x72,0x65,
		0x65,0x53,0x74,0x61,0x63,0x6B,0x53,0x70,0x61,0x63,0x65,0x00,
		0x57,0x0E,0x00,0x00,0x02,0x86,0x70,0x00,0x17,0x65,0x53,0x74,
		0x61,0x74,0x65,0x00,0xC4,0x19,0x00,0x00,0x02,0x86,0x04,0x00,
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN737;
	.var = .LN.vTaskGetInfo..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x0A,0x00,
		0xD2,0x1C,0x00,0x00,0x13,0xEA,0x36,0x00,0x00,0x70,0x72,0x76,
		0x4C,0x69,0x73,0x74,0x54,0x61,0x73,0x6B,0x73,0x57,0x69,0x74,
		0x68,0x69,0x6E,0x53,0x69,0x6E,0x67,0x6C,0x65,0x4C,0x69,0x73,
		0x74,0x00,0x01;
	.var = .LNprvListTasksWithinSingleList.;
	.var = .LN.prvListTasksWithinSingleList..end;
	.byte =
		0x01,0x68,0x0E,0x00,0x00,0x00,0x00,0x17,0x70,0x78,0x54,0x61,
		0x73,0x6B,0x53,0x74,0x61,0x74,0x75,0x73,0x41,0x72,0x72,0x61,
		0x79,0x00,0xD2,0x35,0x00,0x00,0x02,0x86,0x5C,0x00,0x17,0x70,
		0x78,0x4C,0x69,0x73,0x74,0x00,0x2C,0x2B,0x00,0x00,0x02,0x86,
		0x60,0x00,0x17,0x65,0x53,0x74,0x61,0x74,0x65,0x00,0xC4,0x19,
		0x00,0x00,0x02,0x86,0x64,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN768;
	.var = .LN.prvListTasksWithinSingleList..end;
	.byte =
		0x15,0x70,0x78,0x4E,0x65,0x78,0x74,0x54,0x43,0x42,0x00,0x01,
		0x75,0x20,0x00,0x00,0x02,0x86,0x68,0x00,0x00,0x00,0x00,0x00,
		0x15,0x70,0x78,0x46,0x69,0x72,0x73,0x74,0x54,0x43,0x42,0x00,
		0x01,0x75,0x20,0x00,0x00,0x02,0x86,0x6C,0x00,0x00,0x00,0x00,
		0x00,0x15,0x75,0x78,0x54,0x61,0x73,0x6B,0x00,0x01,0x68,0x0E,
		0x00,0x00,0x02,0x86,0x70;
	.var = .LN768-.LNprvListTasksWithinSingleList.;
	.byte =
		0x00,0x14,0xC0,0x36,0x00,0x00;
	.var = .LN770;
	.var = .LN776;
	.byte =
		0x15,0x70,0x78,0x43,0x6F,0x6E,0x73,0x74,0x4C,0x69,0x73,0x74,
		0x00,0x01,0x32,0x2B,0x00,0x00,0x02,0x86,0x74;
	.var = .LN775-.LN770;
	.byte =
		0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN777;
	.var = .LN783;
	.byte =
		0x15,0x70,0x78,0x43,0x6F,0x6E,0x73,0x74,0x4C,0x69,0x73,0x74,
		0x00,0x01,0x32,0x2B,0x00,0x00,0x02,0x86,0x78;
	.var = .LN782-.LN777;
	.byte =
		0x00,0x00,0x00,0x00,0x13,0x97,0x37,0x00,0x00,0x75,0x78,0x54,
		0x61,0x73,0x6B,0x47,0x65,0x74,0x53,0x79,0x73,0x74,0x65,0x6D,
		0x53,0x74,0x61,0x74,0x65,0x00,0x01;
	.var = .LNuxTaskGetSystemState.;
	.var = .LN.uxTaskGetSystemState..end;
	.byte =
		0x01,0x68,0x0E,0x00,0x00,0x01,0x00,0x17,0x70,0x78,0x54,0x61,
		0x73,0x6B,0x53,0x74,0x61,0x74,0x75,0x73,0x41,0x72,0x72,0x61,
		0x79,0x00,0xA2,0x37,0x00,0x00,0x02,0x86,0x68,0x00,0x17,0x75,
		0x78,0x41,0x72,0x72,0x61,0x79,0x53,0x69,0x7A,0x65,0x00,0xE3,
		0x20,0x00,0x00,0x02,0x86,0x6C,0x00,0x17,0x70,0x75,0x6C,0x54,
		0x6F,0x74,0x61,0x6C,0x52,0x75,0x6E,0x54,0x69,0x6D,0x65,0x00,
		0x9D,0x37,0x00,0x00,0x02,0x86,0x70,0x00,0x14,0x00,0x00,0x00,
		0x00;
	.var = .LN789;
	.var = .LN.uxTaskGetSystemState..end;
	.byte =
		0x15,0x75,0x78,0x54,0x61,0x73,0x6B,0x00,0x01,0x68,0x0E,0x00,
		0x00,0x02,0x86,0x74;
	.var = .LN789-.LNuxTaskGetSystemState.;
	.byte =
		0x00,0x15,0x75,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x01,0x68,
		0x0E,0x00,0x00,0x02,0x86,0x78;
	.var = .LN790-.LNuxTaskGetSystemState.;
	.byte =
		0x00,0x00,0x00,0x0A,0x00,0xA4,0x07,0x00,0x00,0x11,0x97,0x37,
		0x00,0x00,0x11,0xD2,0x35,0x00,0x00,0x16,0xE3,0x37,0x00,0x00,
		0x70,0x72,0x76,0x44,0x65,0x6C,0x65,0x74,0x65,0x54,0x43,0x42,
		0x00,0x01;
	.var = .LNprvDeleteTCB.;
	.var = .LN.prvDeleteTCB..end;
	.byte =
		0x01,0x00,0x00,0x17,0x70,0x78,0x54,0x43,0x42,0x00,0x75,0x20,
		0x00,0x00,0x02,0x86,0x78,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN817;
	.var = .LN.prvDeleteTCB..end;
	.byte =
		0x00,0x00,0x16,0x3A,0x38,0x00,0x00,0x76,0x54,0x61,0x73,0x6B,
		0x44,0x65,0x6C,0x65,0x74,0x65,0x00,0x01;
	.var = .LNvTaskDelete.;
	.var = .LN.vTaskDelete..end;
	.byte =
		0x01,0x01,0x00,0x17,0x78,0x54,0x61,0x73,0x6B,0x54,0x6F,0x44,
		0x65,0x6C,0x65,0x74,0x65,0x00,0x33,0x19,0x00,0x00,0x02,0x86,
		0x70,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN830;
	.var = .LN.vTaskDelete..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,0x9C,
		0x38,0x00,0x00,0x70,0x72,0x76,0x43,0x68,0x65,0x63,0x6B,0x54,
		0x61,0x73,0x6B,0x73,0x57,0x61,0x69,0x74,0x69,0x6E,0x67,0x54,
		0x65,0x72,0x6D,0x69,0x6E,0x61,0x74,0x69,0x6F,0x6E,0x00,0x01;
	.var = .LNprvCheckTasksWaitingTermination.;
	.var = .LN.prvCheckTasksWaitingTermination..end;
	.byte =
		0x01,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN868;
	.var = .LN.prvCheckTasksWaitingTermination..end;
	.byte =
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN868;
	.var = .LN878;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,
		0xDE,0x38,0x00,0x00,0x70,0x72,0x76,0x49,0x64,0x6C,0x65,0x54,
		0x61,0x73,0x6B,0x00,0x01;
	.var = .LNprvIdleTask.;
	.var = .LN.prvIdleTask..end;
	.byte =
		0x01,0x00,0x00,0x17,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xC4,0x03,0x00,0x00,0x02,0x86,0x78,
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN879;
	.var = .LN.prvIdleTask..end;
	.byte =
		0x00,0x00,0x13,0x87,0x39,0x00,0x00,0x78,0x54,0x61,0x73,0x6B,
		0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x49,0x6E,0x68,0x65,
		0x72,0x69,0x74,0x00,0x01;
	.var = .LNxTaskPriorityInherit.;
	.var = .LN.xTaskPriorityInherit..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x17,0x70,0x78,0x4D,0x75,
		0x74,0x65,0x78,0x48,0x6F,0x6C,0x64,0x65,0x72,0x00,0x96,0x25,
		0x00,0x00,0x02,0x86,0x68,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN883;
	.var = .LN.xTaskPriorityInherit..end;
	.byte =
		0x15,0x70,0x78,0x4D,0x75,0x74,0x65,0x78,0x48,0x6F,0x6C,0x64,
		0x65,0x72,0x54,0x43,0x42,0x00,0x01,0x1E,0x28,0x00,0x00,0x02,
		0x86,0x6C,0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x52,0x65,0x74,
		0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,0x70;
	.var = .LN884-.LNxTaskPriorityInherit.;
	.byte =
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN894;
	.var = .LN904;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN903-.LN894;
	.byte =
		0x00,0x00,0x00,0x00,0x13,0x28,0x3A,0x00,0x00,0x78,0x54,0x61,
		0x73,0x6B,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x44,0x69,
		0x73,0x69,0x6E,0x68,0x65,0x72,0x69,0x74,0x00,0x01;
	.var = .LNxTaskPriorityDisinherit.;
	.var = .LN.xTaskPriorityDisinherit..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x17,0x70,0x78,0x4D,0x75,
		0x74,0x65,0x78,0x48,0x6F,0x6C,0x64,0x65,0x72,0x00,0x96,0x25,
		0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN913;
	.var = .LN.xTaskPriorityDisinherit..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x1E,0x28,0x00,0x00,
		0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x52,0x65,
		0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,
		0x74;
	.var = .LN914-.LNxTaskPriorityDisinherit.;
	.byte =
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN929;
	.var = .LN939;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN938-.LN929;
	.byte =
		0x00,0x00,0x00,0x00,0x16,0x44,0x3B,0x00,0x00,0x76,0x54,0x61,
		0x73,0x6B,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x44,0x69,
		0x73,0x69,0x6E,0x68,0x65,0x72,0x69,0x74,0x41,0x66,0x74,0x65,
		0x72,0x54,0x69,0x6D,0x65,0x6F,0x75,0x74,0x00,0x01;
	.var = .LNvTaskPriorityDisinheritAfterTimeout.;
	.var = .LN.vTaskPriorityDisinheritAfterTimeout..end;
	.byte =
		0x01,0x01,0x00,0x17,0x70,0x78,0x4D,0x75,0x74,0x65,0x78,0x48,
		0x6F,0x6C,0x64,0x65,0x72,0x00,0x96,0x25,0x00,0x00,0x02,0x86,
		0x5C,0x00,0x17,0x75,0x78,0x48,0x69,0x67,0x68,0x65,0x73,0x74,
		0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x57,0x61,0x69,0x74,
		0x69,0x6E,0x67,0x54,0x61,0x73,0x6B,0x00,0x68,0x0E,0x00,0x00,
		0x02,0x86,0x60,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN944;
	.var = .LN.vTaskPriorityDisinheritAfterTimeout..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x1E,0x28,0x00,0x00,
		0x02,0x86,0x64,0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x50,
		0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x55,0x73,0x65,0x64,0x4F,
		0x6E,0x45,0x6E,0x74,0x72,0x79,0x00,0x01,0x68,0x0E,0x00,0x00,
		0x02,0x86,0x68;
	.var = .LN945-.LNvTaskPriorityDisinheritAfterTimeout.;
	.byte =
		0x00,0x15,0x75,0x78,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,
		0x54,0x6F,0x55,0x73,0x65,0x00,0x01,0x68,0x0E,0x00,0x00,0x02,
		0x86,0x6C;
	.var = .LN945-.LNvTaskPriorityDisinheritAfterTimeout.;
	.byte =
		0x00,0x15,0x75,0x78,0x4F,0x6E,0x6C,0x79,0x4F,0x6E,0x65,0x4D,
		0x75,0x74,0x65,0x78,0x48,0x65,0x6C,0x64,0x00,0x01,0xE3,0x20,
		0x00,0x00,0x02,0x86,0x70;
	.var = .LN945-.LNvTaskPriorityDisinheritAfterTimeout.;
	.byte =
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN967;
	.var = .LN977;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN976-.LN967;
	.byte =
		0x00,0x00,0x00,0x00,0x13,0x88,0x3C,0x00,0x00,0x78,0x54,0x61,
		0x73,0x6B,0x47,0x65,0x6E,0x65,0x72,0x69,0x63,0x4E,0x6F,0x74,
		0x69,0x66,0x79,0x00,0x01;
	.var = .LNxTaskGenericNotify.;
	.var = .LN.xTaskGenericNotify..end;
	.inc/binary ".\system\FreeRTOS\tasks.sbn", 8534, 132;
	.var = .LN982;
	.var = .LN.xTaskGenericNotify..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x68,0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x52,0x65,
		0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,
		0x6C;
	.var = .LN982-.LNxTaskGenericNotify.;
	.byte =
		0x00,0x15,0x75,0x63,0x4F,0x72,0x69,0x67,0x69,0x6E,0x61,0x6C,
		0x4E,0x6F,0x74,0x69,0x66,0x79,0x53,0x74,0x61,0x74,0x65,0x00,
		0x01,0x87,0x07,0x00,0x00,0x02,0x86,0x73;
	.var = .LN982-.LNxTaskGenericNotify.;
	.byte =
		0x00,0x14,0x62,0x3C,0x00,0x00;
	.var = .LN1013;
	.var = .LN1021;
	.byte =
		0x15,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0x01,0x32,0x2B,0x00,
		0x00,0x02,0x86,0x74;
	.var = .LN1020-.LN1013;
	.byte =
		0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN1021;
	.var = .LN1031;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN1030-.LN1021;
	.byte =
		0x00,0x00,0x00,0x00,0x13,0x3F,0x3E,0x00,0x00,0x78,0x54,0x61,
		0x73,0x6B,0x47,0x65,0x6E,0x65,0x72,0x69,0x63,0x4E,0x6F,0x74,
		0x69,0x66,0x79,0x46,0x72,0x6F,0x6D,0x49,0x53,0x52,0x00,0x01;
	.var = .LNxTaskGenericNotifyFromISR.;
	.var = .LN.xTaskGenericNotifyFromISR..end;
	.inc/binary ".\system\FreeRTOS\tasks.sbn", 8666, 167;
	.var = .LN1044;
	.var = .LN.xTaskGenericNotifyFromISR..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x60,0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x63,0x4F,
		0x72,0x69,0x67,0x69,0x6E,0x61,0x6C,0x4E,0x6F,0x74,0x69,0x66,
		0x79,0x53,0x74,0x61,0x74,0x65,0x00,0x01,0x87,0x07,0x00,0x00,
		0x02,0x86,0x67,0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x52,0x65,
		0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,
		0x68;
	.var = .LN1044-.LNxTaskGenericNotifyFromISR.;
	.byte =
		0x00,0x15,0x75,0x78,0x53,0x61,0x76,0x65,0x64,0x49,0x6E,0x74,
		0x65,0x72,0x72,0x75,0x70,0x74,0x53,0x74,0x61,0x74,0x75,0x73,
		0x00,0x01,0x68,0x0E,0x00,0x00,0x02,0x86,0x6C;
	.var = .LN1044-.LNxTaskGenericNotifyFromISR.;
	.byte =
		0x00,0x14,0xF5,0x3D,0x00,0x00;
	.var = .LN1081;
	.var = .LN1089;
	.byte =
		0x15,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0x01,0x32,0x2B,0x00,
		0x00,0x02,0x86,0x70;
	.var = .LN1088-.LN1081;
	.byte =
		0x00,0x00,0x14,0x19,0x3E,0x00,0x00;
	.var = .LN1089;
	.var = .LN1099;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x74;
	.var = .LN1098-.LN1089;
	.byte =
		0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN1100;
	.var = .LN1107;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN1106-.LN1100;
	.byte =
		0x00,0x00,0x00,0x00,0x0A,0x00,0x57,0x0E,0x00,0x00,0x16,0x9E,
		0x3F,0x00,0x00,0x76,0x54,0x61,0x73,0x6B,0x47,0x65,0x6E,0x65,
		0x72,0x69,0x63,0x4E,0x6F,0x74,0x69,0x66,0x79,0x47,0x69,0x76,
		0x65,0x46,0x72,0x6F,0x6D,0x49,0x53,0x52,0x00,0x01;
	.var = .LNvTaskGenericNotifyGiveFromISR.;
	.var = .LN.vTaskGenericNotifyGiveFromISR..end;
	.byte =
		0x01,0x01,0x00,0x17,0x78,0x54,0x61,0x73,0x6B,0x54,0x6F,0x4E,
		0x6F,0x74,0x69,0x66,0x79,0x00,0x33,0x19,0x00,0x00,0x02,0x86,
		0x58,0x00,0x17,0x75,0x78,0x49,0x6E,0x64,0x65,0x78,0x54,0x6F,
		0x4E,0x6F,0x74,0x69,0x66,0x79,0x00,0x68,0x0E,0x00,0x00,0x02,
		0x86,0x5C,0x00,0x17,0x70,0x78,0x48,0x69,0x67,0x68,0x65,0x72,
		0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x54,0x61,0x73,0x6B,
		0x57,0x6F,0x6B,0x65,0x6E,0x00,0x3F,0x3E,0x00,0x00,0x02,0x86,
		0x60,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN1117;
	.var = .LN.vTaskGenericNotifyGiveFromISR..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x64,0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x63,0x4F,
		0x72,0x69,0x67,0x69,0x6E,0x61,0x6C,0x4E,0x6F,0x74,0x69,0x66,
		0x79,0x53,0x74,0x61,0x74,0x65,0x00,0x01,0x87,0x07,0x00,0x00,
		0x02,0x86,0x6B,0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x53,
		0x61,0x76,0x65,0x64,0x49,0x6E,0x74,0x65,0x72,0x72,0x75,0x70,
		0x74,0x53,0x74,0x61,0x74,0x75,0x73,0x00,0x01,0x68,0x0E,0x00,
		0x00,0x02,0x86,0x6C,0x00,0x00,0x00,0x00,0x00,0x14,0x54,0x3F,
		0x00,0x00;
	.var = .LN1135;
	.var = .LN1143;
	.byte =
		0x15,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0x01,0x32,0x2B,0x00,
		0x00,0x02,0x86,0x70;
	.var = .LN1142-.LN1135;
	.byte =
		0x00,0x00,0x14,0x78,0x3F,0x00,0x00;
	.var = .LN1143;
	.var = .LN1153;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x74;
	.var = .LN1152-.LN1143;
	.byte =
		0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN1154;
	.var = .LN1161;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN1160-.LN1154;
	.byte =
		0x00,0x00,0x00,0x00,0x13,0x30,0x40,0x00,0x00,0x78,0x54,0x61,
		0x73,0x6B,0x47,0x65,0x6E,0x65,0x72,0x69,0x63,0x4E,0x6F,0x74,
		0x69,0x66,0x79,0x53,0x74,0x61,0x74,0x65,0x43,0x6C,0x65,0x61,
		0x72,0x00,0x01;
	.var = .LNxTaskGenericNotifyStateClear.;
	.var = .LN.xTaskGenericNotifyStateClear..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x17,0x78,0x54,0x61,0x73,
		0x6B,0x00,0x33,0x19,0x00,0x00,0x02,0x86,0x68,0x00,0x17,0x75,
		0x78,0x49,0x6E,0x64,0x65,0x78,0x54,0x6F,0x43,0x6C,0x65,0x61,
		0x72,0x00,0x68,0x0E,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x00,
		0x00,0x00,0x00;
	.var = .LN1171;
	.var = .LN.xTaskGenericNotifyStateClear..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x52,0x65,
		0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,
		0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x13,0xDB,0x40,0x00,
		0x00,0x75,0x6C,0x54,0x61,0x73,0x6B,0x47,0x65,0x6E,0x65,0x72,
		0x69,0x63,0x4E,0x6F,0x74,0x69,0x66,0x79,0x56,0x61,0x6C,0x75,
		0x65,0x43,0x6C,0x65,0x61,0x72,0x00,0x01;
	.var = .LNulTaskGenericNotifyValueClear.;
	.var = .LN.ulTaskGenericNotifyValueClear..end;
	.byte =
		0x01,0xA4,0x07,0x00,0x00,0x01,0x00,0x17,0x78,0x54,0x61,0x73,
		0x6B,0x00,0x33,0x19,0x00,0x00,0x02,0x86,0x64,0x00,0x17,0x75,
		0x78,0x49,0x6E,0x64,0x65,0x78,0x54,0x6F,0x43,0x6C,0x65,0x61,
		0x72,0x00,0x68,0x0E,0x00,0x00,0x02,0x86,0x68,0x00,0x17,0x75,
		0x6C,0x42,0x69,0x74,0x73,0x54,0x6F,0x43,0x6C,0x65,0x61,0x72,
		0x00,0xA4,0x07,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x00,0x00,
		0x00,0x00;
	.var = .LN1183;
	.var = .LN.ulTaskGenericNotifyValueClear..end;
	.byte =
		0x15,0x70,0x78,0x54,0x43,0x42,0x00,0x01,0x75,0x20,0x00,0x00,
		0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x6C,0x52,
		0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0xA4,0x07,0x00,0x00,0x02,
		0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,0xAB,0x41,
		0x00,0x00,0x70,0x72,0x76,0x41,0x64,0x64,0x43,0x75,0x72,0x72,
		0x65,0x6E,0x74,0x54,0x61,0x73,0x6B,0x54,0x6F,0x44,0x65,0x6C,
		0x61,0x79,0x65,0x64,0x4C,0x69,0x73,0x74,0x00,0x01;
	.var = .LNprvAddCurrentTaskToDelayedList.;
	.var = .LN.prvAddCurrentTaskToDelayedList..end;
	.byte =
		0x01,0x00,0x00,0x17,0x78,0x54,0x69,0x63,0x6B,0x73,0x54,0x6F,
		0x57,0x61,0x69,0x74,0x00,0x7A,0x0E,0x00,0x00,0x02,0x86,0x68,
		0x00,0x17,0x78,0x43,0x61,0x6E,0x42,0x6C,0x6F,0x63,0x6B,0x49,
		0x6E,0x64,0x65,0x66,0x69,0x6E,0x69,0x74,0x65,0x6C,0x79,0x00,
		0xAB,0x41,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x00,0x00,0x00,
		0x00;
	.var = .LN1189;
	.var = .LN.prvAddCurrentTaskToDelayedList..end;
	.byte =
		0x15,0x78,0x54,0x69,0x6D,0x65,0x54,0x6F,0x57,0x61,0x6B,0x65,
		0x00,0x01,0x7A,0x0E,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,
		0x00,0x00,0x15,0x78,0x43,0x6F,0x6E,0x73,0x74,0x54,0x69,0x63,
		0x6B,0x43,0x6F,0x75,0x6E,0x74,0x00,0x01,0x37,0x2B,0x00,0x00,
		0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x14,0x00,0x00,0x00,
		0x00;
	.var = .LN1193;
	.var = .LN1200;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN1199-.LN1193;
	.byte =
		0x00,0x00,0x00,0x00,0x11,0x57,0x0E,0x00,0x00,0x13,0x97,0x42,
		0x00,0x00,0x78,0x54,0x61,0x73,0x6B,0x44,0x65,0x6C,0x61,0x79,
		0x55,0x6E,0x74,0x69,0x6C,0x00,0x01;
	.var = .LNxTaskDelayUntil.;
	.var = .LN.xTaskDelayUntil..end;
	.byte =
		0x01,0x57,0x0E,0x00,0x00,0x01,0x00,0x17,0x70,0x78,0x50,0x72,
		0x65,0x76,0x69,0x6F,0x75,0x73,0x57,0x61,0x6B,0x65,0x54,0x69,
		0x6D,0x65,0x00,0x04,0x31,0x00,0x00,0x02,0x86,0x64,0x00,0x17,
		0x78,0x54,0x69,0x6D,0x65,0x49,0x6E,0x63,0x72,0x65,0x6D,0x65,
		0x6E,0x74,0x00,0x37,0x2B,0x00,0x00,0x02,0x86,0x68,0x00,0x14,
		0x00,0x00,0x00,0x00;
	.var = .LN1213;
	.var = .LN.xTaskDelayUntil..end;
	.byte =
		0x15,0x78,0x54,0x69,0x6D,0x65,0x54,0x6F,0x57,0x61,0x6B,0x65,
		0x00,0x01,0x7A,0x0E,0x00,0x00,0x02,0x86,0x6C,0x00,0x00,0x00,
		0x00,0x00,0x15,0x78,0x41,0x6C,0x72,0x65,0x61,0x64,0x79,0x59,
		0x69,0x65,0x6C,0x64,0x65,0x64,0x00,0x01,0x57,0x0E,0x00,0x00,
		0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x53,0x68,
		0x6F,0x75,0x6C,0x64,0x44,0x65,0x6C,0x61,0x79,0x00,0x01,0x57,
		0x0E,0x00,0x00,0x02,0x86,0x74;
	.var = .LN1213-.LNxTaskDelayUntil.;
	.byte =
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN1224;
	.var = .LN1239;
	.byte =
		0x15,0x78,0x43,0x6F,0x6E,0x73,0x74,0x54,0x69,0x63,0x6B,0x43,
		0x6F,0x75,0x6E,0x74,0x00,0x01,0x37,0x2B,0x00,0x00,0x02,0x86,
		0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,0xF7,0x42,
		0x00,0x00,0x76,0x54,0x61,0x73,0x6B,0x44,0x65,0x6C,0x61,0x79,
		0x00,0x01;
	.var = .LNvTaskDelay.;
	.var = .LN.vTaskDelay..end;
	.byte =
		0x01,0x01,0x00,0x17,0x78,0x54,0x69,0x63,0x6B,0x73,0x54,0x6F,
		0x44,0x65,0x6C,0x61,0x79,0x00,0x37,0x2B,0x00,0x00,0x02,0x86,
		0x74,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN1249;
	.var = .LN.vTaskDelay..end;
	.byte =
		0x15,0x78,0x41,0x6C,0x72,0x65,0x61,0x64,0x79,0x59,0x69,0x65,
		0x6C,0x64,0x65,0x64,0x00,0x01,0x57,0x0E,0x00,0x00,0x02,0x86,
		0x78;
	.var = .LN1249-.LNvTaskDelay.;
	.byte =
		0x00,0x00,0x00,0x16,0x58,0x43,0x00,0x00,0x76,0x54,0x61,0x73,
		0x6B,0x50,0x6C,0x61,0x63,0x65,0x4F,0x6E,0x45,0x76,0x65,0x6E,
		0x74,0x4C,0x69,0x73,0x74,0x00,0x01;
	.var = .LNvTaskPlaceOnEventList.;
	.var = .LN.vTaskPlaceOnEventList..end;
	.byte =
		0x01,0x01,0x00,0x17,0x70,0x78,0x45,0x76,0x65,0x6E,0x74,0x4C,
		0x69,0x73,0x74,0x00,0x32,0x2B,0x00,0x00,0x02,0x86,0x74,0x00,
		0x17,0x78,0x54,0x69,0x63,0x6B,0x73,0x54,0x6F,0x57,0x61,0x69,
		0x74,0x00,0x37,0x2B,0x00,0x00,0x02,0x86,0x78,0x00,0x14,0x00,
		0x00,0x00,0x00;
	.var = .LN1268;
	.var = .LN.vTaskPlaceOnEventList..end;
	.byte =
		0x00,0x00,0x16,0xFA,0x43,0x00,0x00,0x76,0x54,0x61,0x73,0x6B,
		0x50,0x6C,0x61,0x63,0x65,0x4F,0x6E,0x55,0x6E,0x6F,0x72,0x64,
		0x65,0x72,0x65,0x64,0x45,0x76,0x65,0x6E,0x74,0x4C,0x69,0x73,
		0x74,0x00,0x01;
	.var = .LNvTaskPlaceOnUnorderedEventList.;
	.var = .LN.vTaskPlaceOnUnorderedEventList..end;
	.byte =
		0x01,0x01,0x00,0x17,0x70,0x78,0x45,0x76,0x65,0x6E,0x74,0x4C,
		0x69,0x73,0x74,0x00,0x2C,0x2B,0x00,0x00,0x02,0x86,0x6C,0x00,
		0x17,0x78,0x49,0x74,0x65,0x6D,0x56,0x61,0x6C,0x75,0x65,0x00,
		0x37,0x2B,0x00,0x00,0x02,0x86,0x70,0x00,0x17,0x78,0x54,0x69,
		0x63,0x6B,0x73,0x54,0x6F,0x57,0x61,0x69,0x74,0x00,0x37,0x2B,
		0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN1276;
	.var = .LN.vTaskPlaceOnUnorderedEventList..end;
	.byte =
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN1283;
	.var = .LN1290;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN1289-.LN1283;
	.byte =
		0x00,0x00,0x00,0x00,0x16,0xA4,0x44,0x00,0x00,0x76,0x54,0x61,
		0x73,0x6B,0x50,0x6C,0x61,0x63,0x65,0x4F,0x6E,0x45,0x76,0x65,
		0x6E,0x74,0x4C,0x69,0x73,0x74,0x52,0x65,0x73,0x74,0x72,0x69,
		0x63,0x74,0x65,0x64,0x00,0x01;
	.var = .LNvTaskPlaceOnEventListRestricted.;
	.var = .LN.vTaskPlaceOnEventListRestricted..end;
	.byte =
		0x01,0x01,0x00,0x17,0x70,0x78,0x45,0x76,0x65,0x6E,0x74,0x4C,
		0x69,0x73,0x74,0x00,0x32,0x2B,0x00,0x00,0x02,0x86,0x6C,0x00,
		0x17,0x78,0x54,0x69,0x63,0x6B,0x73,0x54,0x6F,0x57,0x61,0x69,
		0x74,0x00,0x7A,0x0E,0x00,0x00,0x02,0x86,0x70,0x00,0x17,0x78,
		0x57,0x61,0x69,0x74,0x49,0x6E,0x64,0x65,0x66,0x69,0x6E,0x69,
		0x74,0x65,0x6C,0x79,0x00,0xAB,0x41,0x00,0x00,0x02,0x86,0x74,
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN1293;
	.var = .LN.vTaskPlaceOnEventListRestricted..end;
	.byte =
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN1296;
	.var = .LN1303;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0x2A,0x27,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN1302-.LN1296;
	.byte =
		0x00,0x00,0x00,0x00,0x13,0x3F,0x45,0x00,0x00,0x75,0x6C,0x54,
		0x61,0x73,0x6B,0x47,0x65,0x6E,0x65,0x72,0x69,0x63,0x4E,0x6F,
		0x74,0x69,0x66,0x79,0x54,0x61,0x6B,0x65,0x00,0x01;
	.var = .LNulTaskGenericNotifyTake.;
	.var = .LN.ulTaskGenericNotifyTake..end;
	.byte =
		0x01,0xA4,0x07,0x00,0x00,0x01,0x00,0x17,0x75,0x78,0x49,0x6E,
		0x64,0x65,0x78,0x54,0x6F,0x57,0x61,0x69,0x74,0x00,0x68,0x0E,
		0x00,0x00,0x02,0x86,0x6C,0x00,0x17,0x78,0x43,0x6C,0x65,0x61,
		0x72,0x43,0x6F,0x75,0x6E,0x74,0x4F,0x6E,0x45,0x78,0x69,0x74,
		0x00,0x57,0x0E,0x00,0x00,0x02,0x86,0x70,0x00,0x17,0x78,0x54,
		0x69,0x63,0x6B,0x73,0x54,0x6F,0x57,0x61,0x69,0x74,0x00,0x7A,
		0x0E,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN1309;
	.var = .LN.ulTaskGenericNotifyTake..end;
	.byte =
		0x15,0x75,0x6C,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0xA4,
		0x07,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,
		0x00,0x13,0x16,0x46,0x00,0x00,0x78,0x54,0x61,0x73,0x6B,0x47,
		0x65,0x6E,0x65,0x72,0x69,0x63,0x4E,0x6F,0x74,0x69,0x66,0x79,
		0x57,0x61,0x69,0x74,0x00,0x01;
	.var = .LNxTaskGenericNotifyWait.;
	.var = .LN.xTaskGenericNotifyWait..end;
	.inc/binary ".\system\FreeRTOS\tasks.sbn", 8833, 146;
	.var = .LN1336;
	.var = .LN.xTaskGenericNotifyWait..end;
	.byte =
		0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x57,0x0E,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x15,0x5F,0x61,0x64,0x69,0x5F,0x4F,0x53,0x52,0x65,0x73,0x63,
		0x68,0x65,0x64,0x75,0x6C,0x65,0x49,0x6E,0x74,0x49,0x44,0x00,
		0x01,0xA4,0x07,0x00,0x00,0x05,0x03;
	.var = _adi_OSRescheduleIntID.;
	.byte =
		0x00,0x00,0x00,0x00,0x01,0x15,0x5F,0x61,0x64,0x69,0x5F,0x4F,
		0x53,0x57,0x61,0x69,0x74,0x69,0x6E,0x67,0x46,0x6F,0x72,0x53,
		0x63,0x68,0x65,0x64,0x00,0x01,0xB7,0x18,0x00,0x00,0x05,0x03;
	.var = _adi_OSWaitingForSched.;
	.byte =
		0x00,0x00,0x00,0x00,0x01,0x15,0x70,0x78,0x43,0x75,0x72,0x72,
		0x65,0x6E,0x74,0x54,0x43,0x42,0x00,0x01,0x98,0x49,0x00,0x00,
		0x05,0x03;
	.var = pxCurrentTCB.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x70,0x78,0x52,0x65,0x61,0x64,
		0x79,0x54,0x61,0x73,0x6B,0x73,0x4C,0x69,0x73,0x74,0x73,0x00,
		0x01,0x8A,0x49,0x00,0x00,0x05,0x03;
	.var = pxReadyTasksLists.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x44,0x65,0x6C,0x61,0x79,
		0x65,0x64,0x54,0x61,0x73,0x6B,0x4C,0x69,0x73,0x74,0x31,0x00,
		0x01,0x27,0x17,0x00,0x00,0x05,0x03;
	.var = xDelayedTaskList1.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x44,0x65,0x6C,0x61,0x79,
		0x65,0x64,0x54,0x61,0x73,0x6B,0x4C,0x69,0x73,0x74,0x32,0x00,
		0x01,0x27,0x17,0x00,0x00,0x05,0x03;
	.var = xDelayedTaskList2.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x70,0x78,0x44,0x65,0x6C,0x61,
		0x79,0x65,0x64,0x54,0x61,0x73,0x6B,0x4C,0x69,0x73,0x74,0x00,
		0x01,0x85,0x49,0x00,0x00,0x05,0x03;
	.var = pxDelayedTaskList.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x70,0x78,0x4F,0x76,0x65,0x72,
		0x66,0x6C,0x6F,0x77,0x44,0x65,0x6C,0x61,0x79,0x65,0x64,0x54,
		0x61,0x73,0x6B,0x4C,0x69,0x73,0x74,0x00,0x01,0x85,0x49,0x00,
		0x00,0x05,0x03;
	.var = pxOverflowDelayedTaskList.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x50,0x65,0x6E,0x64,0x69,
		0x6E,0x67,0x52,0x65,0x61,0x64,0x79,0x4C,0x69,0x73,0x74,0x00,
		0x01,0x27,0x17,0x00,0x00,0x05,0x03;
	.var = xPendingReadyList.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x54,0x61,0x73,0x6B,0x73,
		0x57,0x61,0x69,0x74,0x69,0x6E,0x67,0x54,0x65,0x72,0x6D,0x69,
		0x6E,0x61,0x74,0x69,0x6F,0x6E,0x00,0x01,0x27,0x17,0x00,0x00,
		0x05,0x03;
	.var = xTasksWaitingTermination.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x44,0x65,0x6C,0x65,
		0x74,0x65,0x64,0x54,0x61,0x73,0x6B,0x73,0x57,0x61,0x69,0x74,
		0x69,0x6E,0x67,0x43,0x6C,0x65,0x61,0x6E,0x55,0x70,0x00,0x01,
		0x4C,0x16,0x00,0x00,0x05,0x03;
	.var = uxDeletedTasksWaitingCleanUp.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x53,0x75,0x73,0x70,0x65,
		0x6E,0x64,0x65,0x64,0x54,0x61,0x73,0x6B,0x4C,0x69,0x73,0x74,
		0x00,0x01,0x27,0x17,0x00,0x00,0x05,0x03;
	.var = xSuspendedTaskList.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x43,0x75,0x72,0x72,
		0x65,0x6E,0x74,0x4E,0x75,0x6D,0x62,0x65,0x72,0x4F,0x66,0x54,
		0x61,0x73,0x6B,0x73,0x00,0x01,0x4C,0x16,0x00,0x00,0x05,0x03;
	.var = uxCurrentNumberOfTasks.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x54,0x69,0x63,0x6B,0x43,
		0x6F,0x75,0x6E,0x74,0x00,0x01,0x7B,0x49,0x00,0x00,0x05,0x03;
	.var = xTickCount.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x54,0x6F,0x70,0x52,
		0x65,0x61,0x64,0x79,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,
		0x00,0x01,0x4C,0x16,0x00,0x00,0x05,0x03;
	.var = uxTopReadyPriority.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x53,0x63,0x68,0x65,0x64,
		0x75,0x6C,0x65,0x72,0x52,0x75,0x6E,0x6E,0x69,0x6E,0x67,0x00,
		0x01,0x80,0x49,0x00,0x00,0x05,0x03;
	.var = xSchedulerRunning.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x50,0x65,0x6E,0x64,0x65,
		0x64,0x54,0x69,0x63,0x6B,0x73,0x00,0x01,0x7B,0x49,0x00,0x00,
		0x05,0x03;
	.var = xPendedTicks.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x59,0x69,0x65,0x6C,0x64,
		0x50,0x65,0x6E,0x64,0x69,0x6E,0x67,0x00,0x01,0x80,0x49,0x00,
		0x00,0x05,0x03;
	.var = xYieldPending.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x4E,0x75,0x6D,0x4F,0x66,
		0x4F,0x76,0x65,0x72,0x66,0x6C,0x6F,0x77,0x73,0x00,0x01,0x80,
		0x49,0x00,0x00,0x05,0x03;
	.var = xNumOfOverflows.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x54,0x61,0x73,0x6B,
		0x4E,0x75,0x6D,0x62,0x65,0x72,0x00,0x01,0x68,0x0E,0x00,0x00,
		0x05,0x03;
	.var = uxTaskNumber.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x4E,0x65,0x78,0x74,0x54,
		0x61,0x73,0x6B,0x55,0x6E,0x62,0x6C,0x6F,0x63,0x6B,0x54,0x69,
		0x6D,0x65,0x00,0x01,0x7B,0x49,0x00,0x00,0x05,0x03;
	.var = xNextTaskUnblockTime.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x49,0x64,0x6C,0x65,0x54,
		0x61,0x73,0x6B,0x48,0x61,0x6E,0x64,0x6C,0x65,0x00,0x01,0x33,
		0x19,0x00,0x00,0x05,0x03;
	.var = xIdleTaskHandle.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x54,0x6F,0x70,0x55,
		0x73,0x65,0x64,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,0x00,
		0x01,0x76,0x49,0x00,0x00,0x05,0x03;
	.var = uxTopUsedPriority.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x53,0x63,0x68,0x65,
		0x64,0x75,0x6C,0x65,0x72,0x53,0x75,0x73,0x70,0x65,0x6E,0x64,
		0x65,0x64,0x00,0x01,0x4C,0x16,0x00,0x00,0x05,0x03;
	.var = uxSchedulerSuspended.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x10,0x68,0x0E,0x00,0x00,0x11,0x71,
		0x49,0x00,0x00,0x10,0x7A,0x0E,0x00,0x00,0x10,0x57,0x0E,0x00,
		0x00,0x10,0x2C,0x2B,0x00,0x00,0x0D,0x98,0x49,0x00,0x00,0x27,
		0x17,0x00,0x00,0x0E,0x07,0x00,0x06,0x00,0x10,0x75,0x20,0x00,
		0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\FreeRTOS\tasks.sbn", 8979, 2078;
	.var = .LNpvTaskIncrementMutexHeldCount.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xFE,0x24,0x01,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.pvTaskIncrementMutexHeldCount..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNuxTaskResetEventItemValue.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xEE,0x24,0x01,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.uxTaskResetEventItemValue..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskGetSchedulerState.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0x83,0x20,0x01,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN.xTaskGetSchedulerState..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskGetCurrentTaskHandle.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xF2,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xTaskGetCurrentTaskHandle..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvResetNextTaskUnblockTime.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xDB,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x09,0x10,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN.prvResetNextTaskUnblockTime..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvTaskCheckFreeStackSpace.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xCE,0x1E,0x01,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x12,0x0A,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.prvTaskCheckFreeStackSpace..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNpvTaskGetThreadLocalStoragePointer.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xDE,0x1C,0x01,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x05,0x10,0x0A,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN.pvTaskGetThreadLocalStoragePointer..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskSetTaskNumber.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0x87,0x1B,0x01,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskSetTaskNumber..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNuxTaskGetTaskNumber.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xEF,0x1A,0x01,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN.uxTaskGetTaskNumber..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskMissedYield.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xE7,0x1A,0x01,0x00,0x05,0x02;
	.var = .LN46;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN47;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskMissedYield..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskInternalSetTimeOutState.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x9E,0x1A,0x01,0x00,0x05,0x02;
	.var = .LN48;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN49;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN50;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskInternalSetTimeOutState..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNuxTaskGetNumberOfTasks.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xD8,0x12,0x01,0x00,0x05,0x02;
	.var = .LN51;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN.uxTaskGetNumberOfTasks..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskGetTickCount.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xAA,0x12,0x01,0x00,0x05,0x02;
	.var = .LN52;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN53;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN.xTaskGetTickCount..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskSuspendAll.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xE6,0x10,0x01,0x00,0x05,0x02;
	.var = .LN54;
	.byte =
		0x05,0x05,0x15,0x00,0x05,0x02;
	.var = .LN55;
	.byte =
		0x05,0x01,0x0E,0x00,0x05,0x02;
	.var = .LN.vTaskSuspendAll..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_RegisterLocalStorageCallback.;
	.byte =
		0x04,0x01,0x05,0x02,0x03,0xFF,0x08,0x01,0x00,0x05,0x02;
	.var = .LN56;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN57;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN58;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN59;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_RegisterLocalStorageCallback..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvInitialiseNewTask.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xD7,0x06,0x01,0x00,0x05,0x02;
	.var = .LN60;
	.byte =
		0x05,0x09,0x20,0x00,0x05,0x02;
	.var = .LN61;
	.byte =
		0x05,0x12,0x01,0x00,0x05,0x02;
	.var = .LN62;
	.byte =
		0x05,0x09,0x13,0x00,0x05,0x02;
	.var = .LN63;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN64;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN65;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN66;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN67;
	.byte =
		0x05,0x05,0x21,0x00,0x05,0x02;
	.var = .LN68;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN69;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN70;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN71;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN72;
	.byte =
		0x05,0x52,0x03,0x77,0x01,0x00,0x05,0x02;
	.var = .LN73;
	.byte =
		0x05,0x09,0x1C,0x00,0x05,0x02;
	.var = .LN74;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN75;
	.byte =
		0x10,0x00,0x05,0x02;
	.var = .LN76;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN77;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN78;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN79;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN80;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN81;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN82;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN83;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN84;
	.byte =
		0x05,0x18,0x01,0x00,0x05,0x02;
	.var = .LN85;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN86;
	.byte =
		0x05,0x18,0x01,0x00,0x05,0x02;
	.var = .LN87;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN88;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN89;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN90;
	.byte =
		0x05,0x0D,0x4C,0x00,0x05,0x02;
	.var = .LN91;
	.byte =
		0x05,0x3B,0x01,0x00,0x05,0x02;
	.var = .LN92;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN93;
	.byte =
		0x05,0x05,0x14,0x00,0x05,0x02;
	.var = .LN94;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN95;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN96;
	.byte =
		0x05,0x01,0x0E,0x00,0x05,0x02;
	.var = .LN.prvInitialiseNewTask..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNeTaskGetState.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xFE,0x0A,0x01,0x00,0x05,0x02;
	.var = .LN97;
	.byte =
		0x05,0x23,0x0E,0x00,0x05,0x02;
	.var = .LN98;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN99;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN100;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN101;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN102;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN103;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN104;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN105;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN106;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN107;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN108;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN109;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN110;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN111;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN112;
	.byte =
		0x05,0x16,0x0C,0x00,0x05,0x02;
	.var = .LN113;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN114;
	.byte =
		0x05,0x1D,0x14,0x00,0x05,0x02;
	.var = .LN115;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN116;
	.byte =
		0x05,0x21,0x0B,0x00,0x05,0x02;
	.var = .LN117;
	.byte =
		0x05,0x25,0x0B,0x00,0x05,0x02;
	.var = .LN118;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN119;
	.byte =
		0x05,0x54,0x03,0x7B,0x01,0x00,0x05,0x02;
	.var = .LN120;
	.byte =
		0x05,0x15,0x17,0x00,0x05,0x02;
	.var = .LN121;
	.byte =
		0x05,0x19,0x0C,0x00,0x05,0x02;
	.var = .LN122;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN123;
	.byte =
		0x05,0x16,0x0D,0x00,0x05,0x02;
	.var = .LN124;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN125;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN126;
	.byte =
		0x10,0x00,0x05,0x02;
	.var = .LN127;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN.eTaskGetState..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNuxTaskPriorityGet.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xE1,0x0B,0x01,0x00,0x05,0x02;
	.var = .LN128;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN129;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN130;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN131;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN132;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.uxTaskPriorityGet..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNuxTaskPriorityGetFromISR.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xF7,0x0B,0x01,0x00,0x05,0x02;
	.var = .LN133;
	.byte =
		0x05,0x09,0x1D,0x00,0x05,0x02;
	.var = .LN134;
	.byte =
		0x05,0x21,0x0B,0x00,0x05,0x02;
	.var = .LN135;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN136;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN137;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN138;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN139;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN140;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.uxTaskPriorityGetFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskPrioritySet.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xA0,0x0C,0x01,0x00,0x05,0x02;
	.var = .LN141;
	.byte =
		0x05,0x14,0x0C,0x00,0x05,0x02;
	.var = .LN142;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN143;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN144;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN145;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN146;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN147;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN148;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN149;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN150;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN151;
	.byte =
		0x05,0x0D,0x11,0x00,0x05,0x02;
	.var = .LN152;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN153;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN154;
	.byte =
		0x05,0x19,0x0E,0x00,0x05,0x02;
	.var = .LN155;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN156;
	.byte =
		0x05,0x19,0x0A,0x00,0x05,0x02;
	.var = .LN157;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN158;
	.byte =
		0x05,0x11,0x10,0x00,0x05,0x02;
	.var = .LN159;
	.byte =
		0x05,0x16,0x0A,0x00,0x05,0x02;
	.var = .LN160;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN161;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN162;
	.byte =
		0x14,0x00,0x05,0x02;
	.var = .LN163;
	.byte =
		0x05,0x15,0x0F,0x00,0x05,0x02;
	.var = .LN164;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN165;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN166;
	.byte =
		0x10,0x00,0x05,0x02;
	.var = .LN167;
	.byte =
		0x05,0x11,0x13,0x00,0x05,0x02;
	.var = .LN168;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN169;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN170;
	.byte =
		0x13,0x00,0x05,0x02;
	.var = .LN171;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN172;
	.byte =
		0x05,0x25,0x01,0x00,0x05,0x02;
	.var = .LN173;
	.byte =
		0x05,0x15,0x15,0x00,0x05,0x02;
	.var = .LN174;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN175;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN176;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN177;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN178;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN179;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN180;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN181;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN182;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN183;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN184;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN185;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN186;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN187;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN188;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN189;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN190;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN191;
	.byte =
		0x05,0x0D,0x12,0x00,0x05,0x02;
	.var = .LN192;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN193;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskPrioritySet..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvTaskIsTaskSuspended.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xAF,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN194;
	.byte =
		0x05,0x14,0x0A,0x00,0x05,0x02;
	.var = .LN195;
	.byte =
		0x05,0x23,0x0A,0x00,0x05,0x02;
	.var = .LN196;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN197;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN198;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN199;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN200;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN201;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN202;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN203;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN204;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN205;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN206;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN.prvTaskIsTaskSuspended..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskResume.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xDD,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN207;
	.byte =
		0x05,0x1D,0x0A,0x00,0x05,0x02;
	.var = .LN208;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN209;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN210;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN211;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN212;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN213;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN214;
	.byte =
		0x05,0x2B,0x01,0x00,0x05,0x02;
	.var = .LN215;
	.byte =
		0x05,0x11,0x01,0x00,0x05,0x02;
	.var = .LN216;
	.byte =
		0x05,0x15,0x0F,0x00,0x05,0x02;
	.var = .LN217;
	.byte =
		0x05,0x2A,0x01,0x00,0x05,0x02;
	.var = .LN218;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN219;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN220;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN221;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN222;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN223;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN224;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN225;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN226;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN227;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN228;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN229;
	.byte =
		0x05,0x19,0x0E,0x00,0x05,0x02;
	.var = .LN230;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN231;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN232;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN233;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN234;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN235;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN236;
	.byte =
		0x05,0x0D,0x0F,0x00,0x05,0x02;
	.var = .LN237;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN238;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN.vTaskResume..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskResumeFromISR.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0x93,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN239;
	.byte =
		0x05,0x14,0x0A,0x00,0x05,0x02;
	.var = .LN240;
	.byte =
		0x05,0x1D,0x0A,0x00,0x05,0x02;
	.var = .LN241;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN242;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN243;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN244;
	.byte =
		0x1B,0x00,0x05,0x02;
	.var = .LN245;
	.byte =
		0x05,0x22,0x0B,0x00,0x05,0x02;
	.var = .LN246;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN247;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN248;
	.byte =
		0x05,0x27,0x01,0x00,0x05,0x02;
	.var = .LN249;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN250;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN251;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN252;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN253;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN254;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN255;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN256;
	.byte =
		0x05,0x2A,0x01,0x00,0x05,0x02;
	.var = .LN257;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN258;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN259;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN260;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN261;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN262;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN263;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN264;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN265;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN266;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN267;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN268;
	.byte =
		0x05,0x15,0x0F,0x00,0x05,0x02;
	.var = .LN269;
	.byte =
		0x05,0x23,0x01,0x00,0x05,0x02;
	.var = .LN270;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN271;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN272;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN273;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xTaskResumeFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskEndScheduler.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xDB,0x10,0x01,0x00,0x05,0x02;
	.var = .LN274;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN275;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN276;
	.byte =
		0x05,0x16,0x0A,0x00,0x05,0x02;
	.var = .LN277;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskEndScheduler..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskGetTickCountFromISR.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xB9,0x12,0x01,0x00,0x05,0x02;
	.var = .LN278;
	.byte =
		0x05,0x05,0x1B,0x00,0x05,0x02;
	.var = .LN279;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN280;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN281;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN.xTaskGetTickCountFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNpcTaskGetName.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xE0,0x12,0x01,0x00,0x05,0x02;
	.var = .LN282;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN283;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN284;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN285;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN286;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN.pcTaskGetName..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskIncrementTick.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xDC,0x15,0x01,0x00,0x05,0x02;
	.var = .LN287;
	.byte =
		0x05,0x10,0x0C,0x00,0x05,0x02;
	.var = .LN288;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN289;
	.byte =
		0x05,0x2A,0x0D,0x00,0x05,0x02;
	.var = .LN290;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN291;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN292;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN293;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN294;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN295;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN296;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN297;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN298;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN299;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN300;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN301;
	.byte =
		0x13,0x00,0x05,0x02;
	.var = .LN302;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN303;
	.byte =
		0x05,0x15,0x10,0x00,0x05,0x02;
	.var = .LN304;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN305;
	.byte =
		0x11,0x00,0x05,0x02;
	.var = .LN306;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN307;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN308;
	.byte =
		0x05,0x19,0x10,0x00,0x05,0x02;
	.var = .LN309;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN310;
	.byte =
		0x05,0x15,0x11,0x00,0x05,0x02;
	.var = .LN311;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN312;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN313;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN314;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN315;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN316;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN317;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN318;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN319;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN320;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN321;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN322;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN323;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN324;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN325;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN326;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN327;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN328;
	.byte =
		0x11,0x00,0x05,0x02;
	.var = .LN329;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN330;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN331;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN332;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN333;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN334;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN335;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN336;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN337;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN338;
	.byte =
		0x05,0x19,0x17,0x00,0x05,0x02;
	.var = .LN339;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN340;
	.byte =
		0x05,0x19,0x0A,0x00,0x05,0x02;
	.var = .LN341;
	.byte =
		0x05,0x09,0x12,0x00,0x05,0x02;
	.var = .LN342;
	.byte =
		0x05,0x0D,0x10,0x00,0x05,0x02;
	.var = .LN343;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN344;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN345;
	.byte =
		0x22,0x00,0x05,0x02;
	.var = .LN346;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN347;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN348;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN349;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN350;
	.byte =
		0x05,0x05,0x14,0x00,0x05,0x02;
	.var = .LN.xTaskIncrementTick..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskResumeAll.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xBA,0x11,0x01,0x00,0x05,0x02;
	.var = .LN351;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN352;
	.byte =
		0x05,0x10,0x0A,0x00,0x05,0x02;
	.var = .LN353;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN354;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN355;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN356;
	.byte =
		0x10,0x00,0x05,0x02;
	.var = .LN357;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN358;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN359;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN360;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN361;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN362;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN363;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN364;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN365;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN366;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN367;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN368;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN369;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN370;
	.byte =
		0x0B,0x00,0x05,0x02;
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
		0x0A,0x00,0x05,0x02;
	.var = .LN379;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN380;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN381;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN382;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN383;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN384;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN385;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN386;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN387;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN388;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN389;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN390;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN391;
	.byte =
		0x05,0x11,0x10,0x00,0x05,0x02;
	.var = .LN392;
	.byte =
		0x05,0x30,0x11,0x00,0x05,0x02;
	.var = .LN393;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN394;
	.byte =
		0x05,0x2E,0x10,0x00,0x05,0x02;
	.var = .LN395;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN396;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN397;
	.byte =
		0x05,0x33,0x0B,0x00,0x05,0x02;
	.var = .LN398;
	.byte =
		0x05,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN399;
	.byte =
		0x05,0x21,0x0B,0x00,0x05,0x02;
	.var = .LN400;
	.byte =
		0x05,0x1D,0x0A,0x00,0x05,0x02;
	.var = .LN401;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN402;
	.byte =
		0x05,0x19,0x0A,0x00,0x05,0x02;
	.var = .LN403;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN404;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN405;
	.byte =
		0x05,0x11,0x10,0x00,0x05,0x02;
	.var = .LN406;
	.byte =
		0x05,0x19,0x0D,0x00,0x05,0x02;
	.var = .LN407;
	.byte =
		0x05,0x15,0x0C,0x00,0x05,0x02;
	.var = .LN408;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN409;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN410;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN411;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN412;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN413;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN414;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN415;
	.byte =
		0x05,0x05,0x0F,0x00,0x05,0x02;
	.var = .LN416;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xTaskResumeAll..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskCatchUpTicks.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xF4,0x14,0x01,0x00,0x05,0x02;
	.var = .LN417;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN418;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN419;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN420;
	.byte =
		0x05,0x14,0x0D,0x00,0x05,0x02;
	.var = .LN421;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN422;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN423;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN424;
	.byte =
		0x05,0x24,0x0A,0x00,0x05,0x02;
	.var = .LN425;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN426;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xTaskCatchUpTicks..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskSwitchContext.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xFD,0x17,0x01,0x00,0x05,0x02;
	.var = .LN427;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN428;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN429;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN430;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN431;
	.byte =
		0x29,0x00,0x05,0x02;
	.var = .LN432;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN433;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN434;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN435;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN436;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN437;
	.byte =
		0x14,0x00,0x05,0x02;
	.var = .LN438;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN439;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN440;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN441;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN442;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN443;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN444;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN445;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN446;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN447;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN448;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN449;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN450;
	.byte =
		0x05,0x01,0x1B,0x00,0x05,0x02;
	.var = .LN.vTaskSwitchContext..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskSuspend.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xC5,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN451;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN452;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN453;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN454;
	.byte =
		0x05,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN455;
	.byte =
		0x05,0x0D,0x13,0x00,0x05,0x02;
	.var = .LN456;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN457;
	.byte =
		0x05,0x26,0x01,0x00,0x05,0x02;
	.var = .LN458;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN459;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN460;
	.byte =
		0x05,0x1B,0x01,0x00,0x05,0x02;
	.var = .LN461;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN462;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN463;
	.byte =
		0x05,0x19,0x0D,0x00,0x05,0x02;
	.var = .LN464;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN465;
	.byte =
		0x05,0x48,0x03,0x79,0x01,0x00,0x05,0x02;
	.var = .LN466;
	.byte =
		0x05,0x09,0x15,0x00,0x05,0x02;
	.var = .LN467;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN468;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN469;
	.byte =
		0x05,0x2C,0x0B,0x00,0x05,0x02;
	.var = .LN470;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN471;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN472;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN473;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN474;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN475;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN476;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN477;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN478;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN479;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN480;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN481;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN482;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN483;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN484;
	.byte =
		0x05,0x15,0x0F,0x00,0x05,0x02;
	.var = .LN485;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN486;
	.byte =
		0x05,0x27,0x0C,0x00,0x05,0x02;
	.var = .LN487;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN488;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN.vTaskSuspend..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskRemoveFromEventList.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x9D,0x19,0x01,0x00,0x05,0x02;
	.var = .LN489;
	.byte =
		0x05,0x05,0x1A,0x00,0x05,0x02;
	.var = .LN490;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN491;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN492;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN493;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN494;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN495;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN496;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN497;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN498;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN499;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN500;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN501;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN502;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN503;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN504;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN505;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN506;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN507;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN508;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN509;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN510;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN511;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN512;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN513;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN514;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN515;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN516;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN517;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN518;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN519;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN520;
	.byte =
		0x05,0x05,0x18,0x00,0x05,0x02;
	.var = .LN521;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN522;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN523;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN524;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN525;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN526;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN527;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN528;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN529;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN530;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN531;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN532;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN533;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN.xTaskRemoveFromEventList..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskRemoveFromUnorderedEventList.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xE2,0x19,0x01,0x00,0x05,0x02;
	.var = .LN534;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN535;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN536;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN537;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN538;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN539;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN540;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN541;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN542;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN543;
	.byte =
		0x01,0x00,0x05,0x02;
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
		0x01,0x00,0x05,0x02;
	.var = .LN549;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN550;
	.byte =
		0x1C,0x00,0x05,0x02;
	.var = .LN551;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN552;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN553;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN554;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN555;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN556;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN557;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN558;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN559;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN560;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN561;
	.byte =
		0x01,0x00,0x05,0x02;
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
		0x0B,0x00,0x05,0x02;
	.var = .LN569;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN570;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN571;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskRemoveFromUnorderedEventList..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskSetTimeOutState.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x92,0x1A,0x01,0x00,0x05,0x02;
	.var = .LN572;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN573;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN574;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN575;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN576;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN577;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN578;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN579;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskSetTimeOutState..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskCheckForTimeOut.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xA7,0x1A,0x01,0x00,0x05,0x02;
	.var = .LN580;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN581;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN582;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN583;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN584;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN585;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN586;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN587;
	.byte =
		0x05,0x2A,0x0C,0x00,0x05,0x02;
	.var = .LN588;
	.byte =
		0x05,0x27,0x0A,0x00,0x05,0x02;
	.var = .LN589;
	.byte =
		0x05,0x0D,0x17,0x00,0x05,0x02;
	.var = .LN590;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN591;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN592;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN593;
	.byte =
		0x05,0x0D,0x10,0x00,0x05,0x02;
	.var = .LN594;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN595;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN596;
	.byte =
		0x05,0x0E,0x0A,0x00,0x05,0x02;
	.var = .LN597;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN598;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN599;
	.byte =
		0x05,0x29,0x01,0x00,0x05,0x02;
	.var = .LN600;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN601;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN602;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN603;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN604;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN605;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xTaskCheckForTimeOut..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskSetThreadLocalStoragePointer.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xCB,0x1C,0x01,0x00,0x05,0x02;
	.var = .LN606;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN607;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN608;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN609;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN610;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN611;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN612;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN613;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskSetThreadLocalStoragePointer..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvInitialiseTaskLists.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x85,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN614;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN615;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN616;
	.byte =
		0x05,0x18,0x01,0x00,0x05,0x02;
	.var = .LN617;
	.byte =
		0x05,0x5E,0x03,0x7E,0x01,0x00,0x05,0x02;
	.var = .LN618;
	.byte =
		0x05,0x14,0x0E,0x00,0x05,0x02;
	.var = .LN619;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN620;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN621;
	.byte =
		0x05,0x18,0x0D,0x00,0x05,0x02;
	.var = .LN622;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN623;
	.byte =
		0x05,0x05,0x0F,0x00,0x05,0x02;
	.var = .LN624;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN625;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvInitialiseTaskLists..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvAddNewTaskToReadyList.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xA8,0x08,0x01,0x00,0x05,0x02;
	.var = .LN626;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN627;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN628;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN629;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN630;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN631;
	.byte =
		0x05,0x27,0x0E,0x00,0x05,0x02;
	.var = .LN632;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN633;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN634;
	.byte =
		0x05,0x0D,0x0F,0x00,0x05,0x02;
	.var = .LN635;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN636;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN637;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN638;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN639;
	.byte =
		0x05,0x09,0x10,0x00,0x05,0x02;
	.var = .LN640;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN641;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN642;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN643;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN644;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN645;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN646;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN647;
	.byte =
		0x01,0x00,0x05,0x02;
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
		0x0B,0x00,0x05,0x02;
	.var = .LN652;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN653;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN654;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN655;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN656;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN657;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN658;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN659;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN660;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN661;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN662;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN663;
	.byte =
		0x05,0x01,0x0E,0x00,0x05,0x02;
	.var = .LN.prvAddNewTaskToReadyList..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskCreateStatic.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xDA,0x04,0x01,0x00,0x05,0x02;
	.var = .LN664;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN665;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN666;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN667;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN668;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN669;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN670;
	.byte =
		0x05,0x1D,0x10,0x00,0x05,0x02;
	.var = .LN671;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN672;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN673;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN674;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN675;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN676;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN677;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN678;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN679;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN680;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN681;
	.byte =
		0x05,0x21,0x01,0x00,0x05,0x02;
	.var = .LN682;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN683;
	.byte =
		0x05,0x25,0x01,0x00,0x05,0x02;
	.var = .LN684;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN685;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN686;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN.xTaskCreateStatic..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskStartScheduler.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xDE,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN687;
	.byte =
		0x05,0x18,0x0F,0x00,0x05,0x02;
	.var = .LN688;
	.byte =
		0x05,0x17,0x0A,0x00,0x05,0x02;
	.var = .LN689;
	.byte =
		0x05,0x26,0x0E,0x00,0x05,0x02;
	.var = .LN690;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN691;
	.byte =
		0x05,0x2C,0x01,0x00,0x05,0x02;
	.var = .LN692;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN693;
	.byte =
		0x11,0x00,0x05,0x02;
	.var = .LN694;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN695;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN696;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN697;
	.byte =
		0x05,0x09,0x1A,0x00,0x05,0x02;
	.var = .LN698;
	.byte =
		0x05,0x2C,0x0B,0x00,0x05,0x02;
	.var = .LN699;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN700;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN701;
	.byte =
		0x05,0x05,0x11,0x00,0x05,0x02;
	.var = .LN702;
	.byte =
		0x05,0x09,0x19,0x00,0x05,0x02;
	.var = .LN703;
	.byte =
		0x13,0x00,0x05,0x02;
	.var = .LN704;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN705;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN706;
	.byte =
		0x05,0x1C,0x17,0x00,0x05,0x02;
	.var = .LN707;
	.byte =
		0x05,0x05,0x11,0x00,0x05,0x02;
	.var = .LN708;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN709;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN710;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN711;
	.byte =
		0x05,0x05,0x12,0x00,0x05,0x02;
	.var = .LN712;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskStartScheduler..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskCreate.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xF6,0x05,0x01,0x00,0x05,0x02;
	.var = .LN713;
	.byte =
		0x05,0x0D,0x2D,0x00,0x05,0x02;
	.var = .LN714;
	.byte =
		0x05,0x28,0x01,0x00,0x05,0x02;
	.var = .LN715;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN716;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN717;
	.byte =
		0x05,0x34,0x0C,0x00,0x05,0x02;
	.var = .LN718;
	.byte =
		0x05,0x11,0x01,0x00,0x05,0x02;
	.var = .LN719;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN720;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN721;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN722;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN723;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN724;
	.byte =
		0x05,0x23,0x01,0x00,0x05,0x02;
	.var = .LN725;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN726;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN727;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN728;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN729;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN730;
	.byte =
		0x05,0x21,0x01,0x00,0x05,0x02;
	.var = .LN731;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN732;
	.byte =
		0x05,0x25,0x01,0x00,0x05,0x02;
	.var = .LN733;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN734;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN735;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN736;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN.xTaskCreate..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskGetInfo.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xC6,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN737;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN738;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN739;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN740;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN741;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN742;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN743;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN744;
	.byte =
		0x17,0x00,0x05,0x02;
	.var = .LN745;
	.byte =
		0x05,0x09,0x10,0x00,0x05,0x02;
	.var = .LN746;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN747;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN748;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN749;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN750;
	.byte =
		0x05,0x15,0x10,0x00,0x05,0x02;
	.var = .LN751;
	.byte =
		0x05,0x28,0x0B,0x00,0x05,0x02;
	.var = .LN752;
	.byte =
		0x05,0x1D,0x0B,0x00,0x05,0x02;
	.var = .LN753;
	.byte =
		0x05,0x21,0x0B,0x00,0x05,0x02;
	.var = .LN754;
	.byte =
		0x05,0x1D,0x0A,0x00,0x05,0x02;
	.var = .LN755;
	.byte =
		0x05,0x30,0x0B,0x00,0x05,0x02;
	.var = .LN756;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN757;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN758;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN759;
	.byte =
		0x05,0x38,0x01,0x00,0x05,0x02;
	.var = .LN760;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN761;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN762;
	.byte =
		0x05,0x11,0x11,0x00,0x05,0x02;
	.var = .LN763;
	.byte =
		0x05,0x50,0x01,0x00,0x05,0x02;
	.var = .LN764;
	.byte =
		0x05,0x11,0x01,0x00,0x05,0x02;
	.var = .LN765;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN766;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN767;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN.vTaskGetInfo..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvListTasksWithinSingleList.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xAC,0x1E,0x01,0x00,0x05,0x02;
	.var = .LN768;
	.byte =
		0x05,0x15,0x0C,0x00,0x05,0x02;
	.var = .LN769;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN770;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN771;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN772;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN773;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN774;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN775;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN776;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN777;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN778;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN779;
	.byte =
		0x01,0x00,0x05,0x02;
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
		0x0A,0x00,0x05,0x02;
	.var = .LN784;
	.byte =
		0x05,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN785;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN786;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN787;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN788;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN.prvListTasksWithinSingleList..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNuxTaskGetSystemState.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xF7,0x13,0x01,0x00,0x05,0x02;
	.var = .LN789;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN790;
	.byte =
		0x05,0x21,0x01,0x00,0x05,0x02;
	.var = .LN791;
	.byte =
		0x05,0x18,0x0B,0x00,0x05,0x02;
	.var = .LN792;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN793;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN794;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN795;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN796;
	.byte =
		0x05,0x3B,0x01,0x00,0x05,0x02;
	.var = .LN797;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN798;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN799;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN800;
	.byte =
		0x05,0x37,0x01,0x00,0x05,0x02;
	.var = .LN801;
	.byte =
		0x05,0x11,0x01,0x00,0x05,0x02;
	.var = .LN802;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN803;
	.byte =
		0x05,0x37,0x01,0x00,0x05,0x02;
	.var = .LN804;
	.byte =
		0x05,0x11,0x01,0x00,0x05,0x02;
	.var = .LN805;
	.byte =
		0x05,0x15,0x0F,0x00,0x05,0x02;
	.var = .LN806;
	.byte =
		0x05,0x3B,0x01,0x00,0x05,0x02;
	.var = .LN807;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN808;
	.byte =
		0x11,0x00,0x05,0x02;
	.var = .LN809;
	.byte =
		0x05,0x3B,0x01,0x00,0x05,0x02;
	.var = .LN810;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN811;
	.byte =
		0x1A,0x00,0x05,0x02;
	.var = .LN812;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN813;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN814;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN815;
	.byte =
		0x05,0x20,0x0F,0x00,0x05,0x02;
	.var = .LN816;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN.uxTaskGetSystemState..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvDeleteTCB.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xA6,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN817;
	.byte =
		0x05,0x0D,0x22,0x00,0x05,0x02;
	.var = .LN818;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN819;
	.byte =
		0x05,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN820;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN821;
	.byte =
		0x05,0x1A,0x01,0x00,0x05,0x02;
	.var = .LN822;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN823;
	.byte =
		0x05,0x12,0x0A,0x00,0x05,0x02;
	.var = .LN824;
	.byte =
		0x05,0x1A,0x0D,0x00,0x05,0x02;
	.var = .LN825;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN826;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN827;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN828;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN829;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN.prvDeleteTCB..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskDelete.;
	.byte =
		0x04,0x01,0x05,0x02,0x03,0x89,0x09,0x01,0x00,0x05,0x02;
	.var = .LN830;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN831;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN832;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN833;
	.byte =
		0x05,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN834;
	.byte =
		0x05,0x0D,0x13,0x00,0x05,0x02;
	.var = .LN835;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN836;
	.byte =
		0x05,0x26,0x01,0x00,0x05,0x02;
	.var = .LN837;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN838;
	.byte =
		0x13,0x00,0x05,0x02;
	.var = .LN839;
	.byte =
		0x10,0x00,0x05,0x02;
	.var = .LN840;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN841;
	.byte =
		0x05,0x37,0x01,0x00,0x05,0x02;
	.var = .LN842;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN843;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN844;
	.byte =
		0x05,0x11,0x10,0x00,0x05,0x02;
	.var = .LN845;
	.byte =
		0x05,0x1F,0x01,0x00,0x05,0x02;
	.var = .LN846;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN847;
	.byte =
		0x05,0x0D,0x15,0x00,0x05,0x02;
	.var = .LN848;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN849;
	.byte =
		0x05,0x2C,0x0E,0x00,0x05,0x02;
	.var = .LN850;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN851;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN852;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN853;
	.byte =
		0x05,0x19,0x01,0x00,0x05,0x02;
	.var = .LN854;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN855;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN856;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN857;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN858;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN859;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN860;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN861;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN862;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN863;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN864;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN865;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN866;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN867;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskDelete..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvCheckTasksWaitingTermination.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xA5,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN868;
	.byte =
		0x05,0x09,0x12,0x00,0x05,0x02;
	.var = .LN869;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN870;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN871;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN872;
	.byte =
		0x05,0x26,0x01,0x00,0x05,0x02;
	.var = .LN873;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN874;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN875;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN876;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN877;
	.byte =
		0x05,0x19,0x01,0x00,0x05,0x02;
	.var = .LN878;
	.byte =
		0x05,0x01,0x0D,0x00,0x05,0x02;
	.var = .LN.prvCheckTasksWaitingTermination..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvIdleTask.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x9F,0x1B,0x01,0x00,0x05,0x02;
	.var = .LN879;
	.byte =
		0x05,0x28,0x19,0x00,0x05,0x02;
	.var = .LN880;
	.byte =
		0x05,0x0D,0x20,0x00,0x05,0x02;
	.var = .LN881;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN882;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN.prvIdleTask..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskPriorityInherit.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0x9F,0x20,0x01,0x00,0x05,0x02;
	.var = .LN883;
	.byte =
		0x05,0x14,0x0B,0x00,0x05,0x02;
	.var = .LN884;
	.byte =
		0x05,0x28,0x03,0x7F,0x01,0x00,0x05,0x02;
	.var = .LN885;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN886;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN887;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN888;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN889;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN890;
	.byte =
		0x11,0x00,0x05,0x02;
	.var = .LN891;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN892;
	.byte =
		0x05,0x25,0x01,0x00,0x05,0x02;
	.var = .LN893;
	.byte =
		0x05,0x15,0x16,0x00,0x05,0x02;
	.var = .LN894;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN895;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN896;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN897;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN898;
	.byte =
		0x01,0x00,0x05,0x02;
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
		0x01,0x00,0x05,0x02;
	.var = .LN904;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN905;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN906;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN907;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN908;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN909;
	.byte =
		0x05,0x15,0x12,0x00,0x05,0x02;
	.var = .LN910;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN911;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN912;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN.xTaskPriorityInherit..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskPriorityDisinherit.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xF9,0x20,0x01,0x00,0x05,0x02;
	.var = .LN913;
	.byte =
		0x05,0x14,0x0B,0x00,0x05,0x02;
	.var = .LN914;
	.byte =
		0x05,0x1D,0x03,0x7F,0x01,0x00,0x05,0x02;
	.var = .LN915;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN916;
	.byte =
		0x05,0x0D,0x0F,0x00,0x05,0x02;
	.var = .LN917;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN918;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN919;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN920;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN921;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN922;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN923;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN924;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN925;
	.byte =
		0x05,0x15,0x10,0x00,0x05,0x02;
	.var = .LN926;
	.byte =
		0x05,0x25,0x01,0x00,0x05,0x02;
	.var = .LN927;
	.byte =
		0x05,0x15,0x15,0x00,0x05,0x02;
	.var = .LN928;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN929;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN930;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN931;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN932;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN933;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN934;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN935;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN936;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN937;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN938;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN939;
	.byte =
		0x13,0x00,0x05,0x02;
	.var = .LN940;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN941;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN942;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN943;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN.xTaskPriorityDisinherit..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskPriorityDisinheritAfterTimeout.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xCA,0x21,0x01,0x00,0x05,0x02;
	.var = .LN944;
	.byte =
		0x05,0x1B,0x0C,0x00,0x05,0x02;
	.var = .LN945;
	.byte =
		0x05,0x1D,0x03,0x7E,0x01,0x00,0x05,0x02;
	.var = .LN946;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN947;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN948;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN949;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN950;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN951;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN952;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN953;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN954;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN955;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN956;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN957;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN958;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN959;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN960;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN961;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN962;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN963;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN964;
	.byte =
		0x15,0x00,0x05,0x02;
	.var = .LN965;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN966;
	.byte =
		0x05,0x29,0x01,0x00,0x05,0x02;
	.var = .LN967;
	.byte =
		0x05,0x19,0x15,0x00,0x05,0x02;
	.var = .LN968;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN969;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN970;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN971;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN972;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN973;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN974;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN975;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN976;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN977;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN978;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN979;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN980;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN981;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN.vTaskPriorityDisinheritAfterTimeout..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskGenericNotify.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xB1,0x26,0x01,0x00,0x05,0x02;
	.var = .LN982;
	.byte =
		0x05,0x14,0x0B,0x00,0x05,0x02;
	.var = .LN983;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN984;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN985;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN986;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN987;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN988;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN989;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN990;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN991;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN992;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN993;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN994;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN995;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN996;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN997;
	.byte =
		0x05,0x15,0x0C,0x00,0x05,0x02;
	.var = .LN998;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN999;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN1000;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1001;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN1002;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1003;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN1004;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN1005;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN1006;
	.byte =
		0x05,0x19,0x0D,0x00,0x05,0x02;
	.var = .LN1007;
	.byte =
		0x05,0x15,0x0C,0x00,0x05,0x02;
	.var = .LN1008;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN1009;
	.byte =
		0x10,0x00,0x05,0x02;
	.var = .LN1010;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1011;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1012;
	.byte =
		0x05,0x0D,0x12,0x00,0x05,0x02;
	.var = .LN1013;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN1014;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1015;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1016;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1017;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1018;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1019;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1020;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1021;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1022;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1023;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1024;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1025;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1026;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1027;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1028;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1029;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1030;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1031;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN1032;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1033;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1034;
	.byte =
		0x1B,0x00,0x05,0x02;
	.var = .LN1035;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN1036;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1037;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1038;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1039;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1040;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN1041;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN1042;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN1043;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xTaskGenericNotify..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskGenericNotifyFromISR.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xAD,0x27,0x01,0x00,0x05,0x02;
	.var = .LN1044;
	.byte =
		0x05,0x14,0x0C,0x00,0x05,0x02;
	.var = .LN1045;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN1046;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1047;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1048;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1049;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1050;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1051;
	.byte =
		0x1B,0x00,0x05,0x02;
	.var = .LN1052;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1053;
	.byte =
		0x05,0x22,0x0B,0x00,0x05,0x02;
	.var = .LN1054;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN1055;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN1056;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN1057;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN1058;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1059;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1060;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1061;
	.byte =
		0x05,0x15,0x0C,0x00,0x05,0x02;
	.var = .LN1062;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1063;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN1064;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1065;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN1066;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1067;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN1068;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN1069;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN1070;
	.byte =
		0x05,0x19,0x0D,0x00,0x05,0x02;
	.var = .LN1071;
	.byte =
		0x05,0x15,0x0C,0x00,0x05,0x02;
	.var = .LN1072;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN1073;
	.byte =
		0x10,0x00,0x05,0x02;
	.var = .LN1074;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1075;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1076;
	.byte =
		0x05,0x0D,0x11,0x00,0x05,0x02;
	.var = .LN1077;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN1078;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1079;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1080;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1081;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN1082;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1083;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1084;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1085;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1086;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1087;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1088;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1089;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1090;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1091;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1092;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1093;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1094;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1095;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1096;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1097;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1098;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1099;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN1100;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN1101;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1102;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1103;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1104;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1105;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1106;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1107;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN1108;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN1109;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN1110;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN1111;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN1112;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN1113;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN1114;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN1115;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1116;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xTaskGenericNotifyFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskGenericNotifyGiveFromISR.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xB5,0x28,0x01,0x00,0x05,0x02;
	.var = .LN1117;
	.byte =
		0x05,0x09,0x0E,0x00,0x05,0x02;
	.var = .LN1118;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1119;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1120;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1121;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1122;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1123;
	.byte =
		0x1B,0x00,0x05,0x02;
	.var = .LN1124;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1125;
	.byte =
		0x05,0x22,0x0B,0x00,0x05,0x02;
	.var = .LN1126;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN1127;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN1128;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1129;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN1130;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN1131;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN1132;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1133;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1134;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1135;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN1136;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1137;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1138;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1139;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1140;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1141;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1142;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1143;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1144;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1145;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1146;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1147;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1148;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1149;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1150;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1151;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1152;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1153;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN1154;
	.byte =
		0x05,0x15,0x0E,0x00,0x05,0x02;
	.var = .LN1155;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1156;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1157;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1158;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1159;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1160;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1161;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN1162;
	.byte =
		0x05,0x15,0x0D,0x00,0x05,0x02;
	.var = .LN1163;
	.byte =
		0x05,0x19,0x0B,0x00,0x05,0x02;
	.var = .LN1164;
	.byte =
		0x05,0x15,0x0A,0x00,0x05,0x02;
	.var = .LN1165;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN1166;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN1167;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN1168;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN1169;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1170;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskGenericNotifyGiveFromISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskGenericNotifyStateClear.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0x8D,0x29,0x01,0x00,0x05,0x02;
	.var = .LN1171;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN1172;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1173;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1174;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN1175;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1176;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN1177;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN1178;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1179;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN1180;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN1181;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN1182;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xTaskGenericNotifyStateClear..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNulTaskGenericNotifyValueClear.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xB0,0x29,0x01,0x00,0x05,0x02;
	.var = .LN1183;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN1184;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1185;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN1186;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1187;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN1188;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.ulTaskGenericNotifyValueClear..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvAddCurrentTaskToDelayedList.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xEE,0x29,0x01,0x00,0x05,0x02;
	.var = .LN1189;
	.byte =
		0x05,0x26,0x0B,0x00,0x05,0x02;
	.var = .LN1190;
	.byte =
		0x05,0x05,0x16,0x00,0x05,0x02;
	.var = .LN1191;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN1192;
	.byte =
		0x05,0x09,0x16,0x00,0x05,0x02;
	.var = .LN1193;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN1194;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1195;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1196;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1197;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1198;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1199;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1200;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN1201;
	.byte =
		0x05,0x0D,0x0F,0x00,0x05,0x02;
	.var = .LN1202;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN1203;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1204;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN1205;
	.byte =
		0x05,0x1C,0x01,0x00,0x05,0x02;
	.var = .LN1206;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN1207;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN1208;
	.byte =
		0x05,0x1C,0x01,0x00,0x05,0x02;
	.var = .LN1209;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN1210;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN1211;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN1212;
	.byte =
		0x05,0x01,0x36,0x00,0x05,0x02;
	.var = .LN.prvAddCurrentTaskToDelayedList..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskDelayUntil.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xFB,0x09,0x01,0x00,0x05,0x02;
	.var = .LN1213;
	.byte =
		0x05,0x25,0x0B,0x00,0x05,0x02;
	.var = .LN1214;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN1215;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1216;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1217;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1218;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1219;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1220;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1221;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1222;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1223;
	.byte =
		0x05,0x18,0x0B,0x00,0x05,0x02;
	.var = .LN1224;
	.byte =
		0x05,0x2E,0x0D,0x00,0x05,0x02;
	.var = .LN1225;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN1226;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1227;
	.byte =
		0x05,0x11,0x10,0x00,0x05,0x02;
	.var = .LN1228;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN1229;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN1230;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN1231;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN1232;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN1233;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN1234;
	.byte =
		0x05,0x0D,0x11,0x00,0x05,0x02;
	.var = .LN1235;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1236;
	.byte =
		0x05,0x11,0x0F,0x00,0x05,0x02;
	.var = .LN1237;
	.byte =
		0x05,0x2F,0x01,0x00,0x05,0x02;
	.var = .LN1238;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN1239;
	.byte =
		0x05,0x29,0x0F,0x00,0x05,0x02;
	.var = .LN1240;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN1241;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN1242;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN1243;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1244;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1245;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1246;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1247;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN1248;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN.xTaskDelayUntil..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskDelay.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xD1,0x0A,0x01,0x00,0x05,0x02;
	.var = .LN1249;
	.byte =
		0x05,0x14,0x0A,0x00,0x05,0x02;
	.var = .LN1250;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN1251;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN1252;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1253;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1254;
	.byte =
		0x05,0x1C,0x0A,0x00,0x05,0x02;
	.var = .LN1255;
	.byte =
		0x05,0x11,0x14,0x00,0x05,0x02;
	.var = .LN1256;
	.byte =
		0x05,0x2F,0x01,0x00,0x05,0x02;
	.var = .LN1257;
	.byte =
		0x05,0x2D,0x0B,0x00,0x05,0x02;
	.var = .LN1258;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN1259;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN1260;
	.byte =
		0x11,0x00,0x05,0x02;
	.var = .LN1261;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN1262;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1263;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1264;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1265;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1266;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN1267;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN.vTaskDelay..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskPlaceOnEventList.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xC8,0x18,0x01,0x00,0x05,0x02;
	.var = .LN1268;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN1269;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1270;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1271;
	.byte =
		0x19,0x00,0x05,0x02;
	.var = .LN1272;
	.byte =
		0x05,0x10,0x01,0x00,0x05,0x02;
	.var = .LN1273;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN1274;
	.byte =
		0x05,0x23,0x01,0x00,0x05,0x02;
	.var = .LN1275;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskPlaceOnEventList..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskPlaceOnUnorderedEventList.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xE2,0x18,0x01,0x00,0x05,0x02;
	.var = .LN1276;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN1277;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1278;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1279;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN1280;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1281;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1282;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN1283;
	.byte =
		0x10,0x00,0x05,0x02;
	.var = .LN1284;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1285;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1286;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1287;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1288;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1289;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1290;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1291;
	.byte =
		0x05,0x23,0x01,0x00,0x05,0x02;
	.var = .LN1292;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskPlaceOnUnorderedEventList..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvTaskPlaceOnEventListRestricted.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xFE,0x18,0x01,0x00,0x05,0x02;
	.var = .LN1293;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN1294;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1295;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1296;
	.byte =
		0x15,0x00,0x05,0x02;
	.var = .LN1297;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1298;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1299;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1300;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1301;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1302;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1303;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN1304;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN1305;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN1306;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN1307;
	.byte =
		0x05,0x27,0x01,0x00,0x05,0x02;
	.var = .LN1308;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN.vTaskPlaceOnEventListRestricted..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNulTaskGenericNotifyTake.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0x91,0x25,0x01,0x00,0x05,0x02;
	.var = .LN1309;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN1310;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1311;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1312;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1313;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN1314;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN1315;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1316;
	.byte =
		0x05,0x33,0x0B,0x00,0x05,0x02;
	.var = .LN1317;
	.byte =
		0x05,0x15,0x10,0x00,0x05,0x02;
	.var = .LN1318;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1319;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1320;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1321;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1322;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN1323;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN1324;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN1325;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1326;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN1327;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1328;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN1329;
	.byte =
		0x05,0x15,0x0B,0x00,0x05,0x02;
	.var = .LN1330;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN1331;
	.byte =
		0x05,0x15,0x0C,0x00,0x05,0x02;
	.var = .LN1332;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN1333;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN1334;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN1335;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.ulTaskGenericNotifyTake..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxTaskGenericNotifyWait.;
	.byte =
		0x04,0x01,0x05,0x05,0x03,0xDB,0x25,0x01,0x00,0x05,0x02;
	.var = .LN1336;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN1337;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1338;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1339;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1340;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN1341;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN1342;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN1343;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1344;
	.byte =
		0x05,0x33,0x0B,0x00,0x05,0x02;
	.var = .LN1345;
	.byte =
		0x05,0x15,0x10,0x00,0x05,0x02;
	.var = .LN1346;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1347;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1348;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1349;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN1350;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN1351;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN1352;
	.byte =
		0x05,0x09,0x0F,0x00,0x05,0x02;
	.var = .LN1353;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN1354;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN1355;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN1356;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN1357;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN1358;
	.byte =
		0x05,0x11,0x0C,0x00,0x05,0x02;
	.var = .LN1359;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN1360;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN1361;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN1362;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN1363;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN1364;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xTaskGenericNotifyWait..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x9C,0x05,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.inc/binary ".\system\FreeRTOS\tasks.sbn", 11057, 1430;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x14,0x02,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNpvTaskIncrementMutexHeldCount.;
	.var = .LN.pvTaskIncrementMutexHeldCount..end-.LNpvTaskIncrementMutexHeldCount.;
	.var = .LNuxTaskResetEventItemValue.;
	.var = .LN.uxTaskResetEventItemValue..end-.LNuxTaskResetEventItemValue.;
	.var = .LNxTaskGetSchedulerState.;
	.var = .LN.xTaskGetSchedulerState..end-.LNxTaskGetSchedulerState.;
	.var = .LNxTaskGetCurrentTaskHandle.;
	.var = .LN.xTaskGetCurrentTaskHandle..end-.LNxTaskGetCurrentTaskHandle.;
	.var = .LNprvResetNextTaskUnblockTime.;
	.var = .LN.prvResetNextTaskUnblockTime..end-.LNprvResetNextTaskUnblockTime.;
	.var = .LNprvTaskCheckFreeStackSpace.;
	.var = .LN.prvTaskCheckFreeStackSpace..end-.LNprvTaskCheckFreeStackSpace.;
	.var = .LNpvTaskGetThreadLocalStoragePointer.;
	.var = .LN.pvTaskGetThreadLocalStoragePointer..end-.LNpvTaskGetThreadLocalStoragePointer.;
	.var = .LNvTaskSetTaskNumber.;
	.var = .LN.vTaskSetTaskNumber..end-.LNvTaskSetTaskNumber.;
	.var = .LNuxTaskGetTaskNumber.;
	.var = .LN.uxTaskGetTaskNumber..end-.LNuxTaskGetTaskNumber.;
	.var = .LNvTaskMissedYield.;
	.var = .LN.vTaskMissedYield..end-.LNvTaskMissedYield.;
	.var = .LNvTaskInternalSetTimeOutState.;
	.var = .LN.vTaskInternalSetTimeOutState..end-.LNvTaskInternalSetTimeOutState.;
	.var = .LNuxTaskGetNumberOfTasks.;
	.var = .LN.uxTaskGetNumberOfTasks..end-.LNuxTaskGetNumberOfTasks.;
	.var = .LNxTaskGetTickCount.;
	.var = .LN.xTaskGetTickCount..end-.LNxTaskGetTickCount.;
	.var = .LNvTaskSuspendAll.;
	.var = .LN.vTaskSuspendAll..end-.LNvTaskSuspendAll.;
	.var = .LNadi_osal_RegisterLocalStorageCallback.;
	.var = .LN.adi_osal_RegisterLocalStorageCallback..end-.LNadi_osal_RegisterLocalStorageCallback.;
	.var = .LNprvInitialiseNewTask.;
	.var = .LN.prvInitialiseNewTask..end-.LNprvInitialiseNewTask.;
	.var = .LNeTaskGetState.;
	.var = .LN.eTaskGetState..end-.LNeTaskGetState.;
	.var = .LNuxTaskPriorityGet.;
	.var = .LN.uxTaskPriorityGet..end-.LNuxTaskPriorityGet.;
	.var = .LNuxTaskPriorityGetFromISR.;
	.var = .LN.uxTaskPriorityGetFromISR..end-.LNuxTaskPriorityGetFromISR.;
	.var = .LNvTaskPrioritySet.;
	.var = .LN.vTaskPrioritySet..end-.LNvTaskPrioritySet.;
	.var = .LNprvTaskIsTaskSuspended.;
	.var = .LN.prvTaskIsTaskSuspended..end-.LNprvTaskIsTaskSuspended.;
	.var = .LNvTaskResume.;
	.var = .LN.vTaskResume..end-.LNvTaskResume.;
	.var = .LNxTaskResumeFromISR.;
	.var = .LN.xTaskResumeFromISR..end-.LNxTaskResumeFromISR.;
	.var = .LNvTaskEndScheduler.;
	.var = .LN.vTaskEndScheduler..end-.LNvTaskEndScheduler.;
	.var = .LNxTaskGetTickCountFromISR.;
	.var = .LN.xTaskGetTickCountFromISR..end-.LNxTaskGetTickCountFromISR.;
	.var = .LNpcTaskGetName.;
	.var = .LN.pcTaskGetName..end-.LNpcTaskGetName.;
	.var = .LNxTaskIncrementTick.;
	.var = .LN.xTaskIncrementTick..end-.LNxTaskIncrementTick.;
	.var = .LNxTaskResumeAll.;
	.var = .LN.xTaskResumeAll..end-.LNxTaskResumeAll.;
	.var = .LNxTaskCatchUpTicks.;
	.var = .LN.xTaskCatchUpTicks..end-.LNxTaskCatchUpTicks.;
	.var = .LNvTaskSwitchContext.;
	.var = .LN.vTaskSwitchContext..end-.LNvTaskSwitchContext.;
	.var = .LNvTaskSuspend.;
	.var = .LN.vTaskSuspend..end-.LNvTaskSuspend.;
	.var = .LNxTaskRemoveFromEventList.;
	.var = .LN.xTaskRemoveFromEventList..end-.LNxTaskRemoveFromEventList.;
	.var = .LNvTaskRemoveFromUnorderedEventList.;
	.var = .LN.vTaskRemoveFromUnorderedEventList..end-.LNvTaskRemoveFromUnorderedEventList.;
	.var = .LNvTaskSetTimeOutState.;
	.var = .LN.vTaskSetTimeOutState..end-.LNvTaskSetTimeOutState.;
	.var = .LNxTaskCheckForTimeOut.;
	.var = .LN.xTaskCheckForTimeOut..end-.LNxTaskCheckForTimeOut.;
	.var = .LNvTaskSetThreadLocalStoragePointer.;
	.var = .LN.vTaskSetThreadLocalStoragePointer..end-.LNvTaskSetThreadLocalStoragePointer.;
	.var = .LNprvInitialiseTaskLists.;
	.var = .LN.prvInitialiseTaskLists..end-.LNprvInitialiseTaskLists.;
	.var = .LNprvAddNewTaskToReadyList.;
	.var = .LN.prvAddNewTaskToReadyList..end-.LNprvAddNewTaskToReadyList.;
	.var = .LNxTaskCreateStatic.;
	.var = .LN.xTaskCreateStatic..end-.LNxTaskCreateStatic.;
	.var = .LNvTaskStartScheduler.;
	.var = .LN.vTaskStartScheduler..end-.LNvTaskStartScheduler.;
	.var = .LNprvIdleTask.;
	.var = .LN.prvIdleTask..end-.LNprvIdleTask.;
	.var = .LNxTaskCreate.;
	.var = .LN.xTaskCreate..end-.LNxTaskCreate.;
	.var = .LNvTaskGetInfo.;
	.var = .LN.vTaskGetInfo..end-.LNvTaskGetInfo.;
	.var = .LNprvListTasksWithinSingleList.;
	.var = .LN.prvListTasksWithinSingleList..end-.LNprvListTasksWithinSingleList.;
	.var = .LNuxTaskGetSystemState.;
	.var = .LN.uxTaskGetSystemState..end-.LNuxTaskGetSystemState.;
	.var = .LNprvDeleteTCB.;
	.var = .LN.prvDeleteTCB..end-.LNprvDeleteTCB.;
	.var = .LNvTaskDelete.;
	.var = .LN.vTaskDelete..end-.LNvTaskDelete.;
	.var = .LNprvCheckTasksWaitingTermination.;
	.var = .LN.prvCheckTasksWaitingTermination..end-.LNprvCheckTasksWaitingTermination.;
	.var = .LNxTaskPriorityInherit.;
	.var = .LN.xTaskPriorityInherit..end-.LNxTaskPriorityInherit.;
	.var = .LNxTaskPriorityDisinherit.;
	.var = .LN.xTaskPriorityDisinherit..end-.LNxTaskPriorityDisinherit.;
	.var = .LNvTaskPriorityDisinheritAfterTimeout.;
	.var = .LN.vTaskPriorityDisinheritAfterTimeout..end-.LNvTaskPriorityDisinheritAfterTimeout.;
	.var = .LNxTaskGenericNotify.;
	.var = .LN.xTaskGenericNotify..end-.LNxTaskGenericNotify.;
	.var = .LNxTaskGenericNotifyFromISR.;
	.var = .LN.xTaskGenericNotifyFromISR..end-.LNxTaskGenericNotifyFromISR.;
	.var = .LNvTaskGenericNotifyGiveFromISR.;
	.var = .LN.vTaskGenericNotifyGiveFromISR..end-.LNvTaskGenericNotifyGiveFromISR.;
	.var = .LNxTaskGenericNotifyStateClear.;
	.var = .LN.xTaskGenericNotifyStateClear..end-.LNxTaskGenericNotifyStateClear.;
	.var = .LNulTaskGenericNotifyValueClear.;
	.var = .LN.ulTaskGenericNotifyValueClear..end-.LNulTaskGenericNotifyValueClear.;
	.var = .LNprvAddCurrentTaskToDelayedList.;
	.var = .LN.prvAddCurrentTaskToDelayedList..end-.LNprvAddCurrentTaskToDelayedList.;
	.var = .LNxTaskDelayUntil.;
	.var = .LN.xTaskDelayUntil..end-.LNxTaskDelayUntil.;
	.var = .LNvTaskDelay.;
	.var = .LN.vTaskDelay..end-.LNvTaskDelay.;
	.var = .LNvTaskPlaceOnEventList.;
	.var = .LN.vTaskPlaceOnEventList..end-.LNvTaskPlaceOnEventList.;
	.var = .LNvTaskPlaceOnUnorderedEventList.;
	.var = .LN.vTaskPlaceOnUnorderedEventList..end-.LNvTaskPlaceOnUnorderedEventList.;
	.var = .LNvTaskPlaceOnEventListRestricted.;
	.var = .LN.vTaskPlaceOnEventListRestricted..end-.LNvTaskPlaceOnEventListRestricted.;
	.var = .LNulTaskGenericNotifyTake.;
	.var = .LN.ulTaskGenericNotifyTake..end-.LNulTaskGenericNotifyTake.;
	.var = .LNxTaskGenericNotifyWait.;
	.var = .LN.xTaskGenericNotifyWait..end-.LNxTaskGenericNotifyWait.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.global pxCurrentTCB.;
	.type pxCurrentTCB.,STT_OBJECT;
	.byte pxCurrentTCB.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxDeletedTasksWaitingCleanUp.,STT_OBJECT;
	.byte uxDeletedTasksWaitingCleanUp.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxCurrentNumberOfTasks.,STT_OBJECT;
	.byte uxCurrentNumberOfTasks.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xTickCount.,STT_OBJECT;
	.byte xTickCount.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxTopReadyPriority.,STT_OBJECT;
	.byte uxTopReadyPriority.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xSchedulerRunning.,STT_OBJECT;
	.byte xSchedulerRunning.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xPendedTicks.,STT_OBJECT;
	.byte xPendedTicks.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xYieldPending.,STT_OBJECT;
	.byte xYieldPending.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xNumOfOverflows.,STT_OBJECT;
	.byte xNumOfOverflows.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxTaskNumber.,STT_OBJECT;
	.byte uxTaskNumber.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xNextTaskUnblockTime.,STT_OBJECT;
	.byte xNextTaskUnblockTime.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xIdleTaskHandle.,STT_OBJECT;
	.byte xIdleTaskHandle.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.global uxTopUsedPriority.;
	.type uxTopUsedPriority.,STT_OBJECT;
	.byte uxTopUsedPriority.[] =
		0x06,0x00,0x00,0x00;
	.align 4;
	.type uxSchedulerSuspended.,STT_OBJECT;
	.byte uxSchedulerSuspended.[] =
		0x00,0x00,0x00,0x00;
	.align 8;
	.type .sDRTOSF.0,STT_OBJECT;
	.byte .sDRTOSF.0[] =
		0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,0x65,0x65,
		0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,0x73,0x65,
		0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,0x31,0x30,
		0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,0x65,0x5C,
		0x74,0x61,0x73,0x6B,0x73,0x2E,0x63,0x00;
	.align 4;
	.type .sIDLE.1,STT_OBJECT;
	.byte .sIDLE.1[] =
		0x49,0x44,0x4C,0x45,0x00;
	.align 4;
	.type .SWITCH.2,STT_OBJECT;
.SWITCH.2:
	.var = .P131L12;
	.var = .P131L13;
	.var = .P131L14;
	.var = .P131L15;
	.var = .P131L16;
.SWITCH.2.end:
	.align 4;
	.type .SWITCH.3,STT_OBJECT;
.SWITCH.3:
	.var = .P133L12;
	.var = .P133L13;
	.var = .P133L14;
	.var = .P133L15;
	.var = .P133L16;
.SWITCH.3.end:

	.extern _adi_OSRescheduleIntID.;
	.type _adi_OSRescheduleIntID.,STT_OBJECT;
	.extern _adi_OSWaitingForSched.;
	.type _adi_OSWaitingForSched.,STT_OBJECT;
