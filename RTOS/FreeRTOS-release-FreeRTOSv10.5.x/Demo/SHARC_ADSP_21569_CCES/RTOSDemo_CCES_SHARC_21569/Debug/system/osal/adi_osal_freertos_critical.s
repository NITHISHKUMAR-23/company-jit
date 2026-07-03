	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_critical.c";
//  Compilation time: Thu Oct 24 14:39:48 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\osal -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\osal\adi_osal_freertos_critical.d -o system\osal\adi_osal_freertos_critical.doj
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

adi_osal_IsSchedulerActive.:
.LNadi_osal_IsSchedulerActive.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,r2,i12,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN0:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_critical.c":124
	cjump xTaskGetSchedulerState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
	r2=r0;
.LN1:
	r0=m5;
	r2=btgl r2 by r0;
	if not sz r0=m6;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_IsSchedulerActive..end:
.adi_osal_IsSchedulerActive..end:
	.global adi_osal_IsSchedulerActive.;
	.type adi_osal_IsSchedulerActive.,STT_FUNC;

adi_osal_SchedulerLock.:
.LNadi_osal_SchedulerLock.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r2,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN2:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_critical.c":144
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN3:
// line 150
	r2=dm(_adi_osal_gnSchedulerLockCnt.);
	r2=r2+1;
	dm(_adi_osal_gnSchedulerLockCnt.)=r2;
.LN4:
// line 152
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_SchedulerLock..end:
.adi_osal_SchedulerLock..end:
	.global adi_osal_SchedulerLock.;
	.type adi_osal_SchedulerLock.,STT_FUNC;

adi_osal_SchedulerUnlock.:
.LNadi_osal_SchedulerUnlock.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_critical.c":171
	modify(i7,-2) (nw);
.LN5:
// line 176
	r2=dm(_adi_osal_gnSchedulerLockCnt.);
	r2=pass r2;
	if ne jump (pc,.P40L2);

.LN6:
// line 178
	dm(-2,i6)=m14;
	jump (pc,.P40L4);

.P40L2:
.LN7:
// line 180
	r2=r2-1;
	dm(_adi_osal_gnSchedulerLockCnt.)=r2;
.LN8:
// line 183
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
.LN9:
// line 185
	dm(-2,i6)=m13;

.P40L4:
.LN10:
// line 186
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_SchedulerUnlock..end:
.adi_osal_SchedulerUnlock..end:
	.global adi_osal_SchedulerUnlock.;
	.type adi_osal_SchedulerUnlock.,STT_FUNC;

adi_osal_EnterCriticalRegion.:
.LNadi_osal_EnterCriticalRegion.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_critical.c":201
	modify(i7,-2) (nw);
.LN11:
// line 202
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN12:
	if eq jump (pc,.P42L2);

.LN13:
// line 208
	cjump ulPortSetInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
.LN14:
	dm(-2,i6)=r0;
.LN15:
// line 210
	r2=dm(_adi_osal_gnCriticalRegionNestingCnt.);
	r2=pass r2;
	if ne jump (pc,.P42L5);

.LN16:
// line 213
	dm(snCriticalRegionState.)=r0;
.LN17:
// line 214
	jump (pc,.P42L6);

.P42L5:

.P42L6:
.LN18:
// line 215
	jump (pc,.P42L3);

.P42L2:
.LN19:
// line 218
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:

.P42L3:
.LN20:
// line 221
	r2=dm(_adi_osal_gnCriticalRegionNestingCnt.);
	r2=r2+1;
	dm(_adi_osal_gnCriticalRegionNestingCnt.)=r2;
.LN21:
// line 222
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_EnterCriticalRegion..end:
.adi_osal_EnterCriticalRegion..end:
	.global adi_osal_EnterCriticalRegion.;
	.type adi_osal_EnterCriticalRegion.,STT_FUNC;

adi_osal_ExitCriticalRegion.:
.LNadi_osal_ExitCriticalRegion.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r2,r4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN22:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_critical.c":237
	r2=dm(_adi_osal_gnCriticalRegionNestingCnt.);
	r2=r2-1;
	dm(_adi_osal_gnCriticalRegionNestingCnt.)=r2;
.LN23:
// line 239
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN24:
	if eq jump (pc,.P46L2);

.LN25:
// line 242
	r2=dm(_adi_osal_gnCriticalRegionNestingCnt.);
	r2=pass r2;
	if gt jump (pc,.P46L5);

.LN26:
// line 244
	dm(_adi_osal_gnCriticalRegionNestingCnt.)=m5;
.LN27:
// line 245
	r4=dm(snCriticalRegionState.);
.LN28:
	cjump vPortClearInterruptMask. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
.LN29:
// line 246
	jump (pc,.P46L6);

.P46L5:

.P46L6:
.LN30:
// line 247
	jump (pc,.P46L3);

.P46L2:
.LN31:
// line 250
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:

.P46L3:
.LN32:
// line 252
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ExitCriticalRegion..end:
.adi_osal_ExitCriticalRegion..end:
	.global adi_osal_ExitCriticalRegion.;
	.type adi_osal_ExitCriticalRegion.,STT_FUNC;

_adi_osal_IsCurrentLevelISR.:
.LN_adi_osal_IsCurrentLevelISR.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\SHARC_ADSP_21569_CCES\RTOSDemo_CCES_SHARC_21569\..\..\..\Source\portable\CCES\SHARC_215xx\osal\adi_osal_arch_internal.h":117
	modify(i7,-2) (nw);

.LN33:
// line 122
	r2=imaskp;

.LN34:
	r2=pass r2;
	r0=m5;
	if ne r0=m6;
.LN35:
	dm(-2,i6)=r0;

.LN36:
// line 117
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN._adi_osal_IsCurrentLevelISR..end:
._adi_osal_IsCurrentLevelISR..end:
	.type _adi_osal_IsCurrentLevelISR.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="_adi_osal_IsMemoryAligned.";
	.file_attr FuncName="_adi_osal_IsCurrentLevelISR.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="adi_osal_IsSchedulerActive.";
	.file_attr FuncName="adi_osal_SchedulerLock.";
	.file_attr FuncName="adi_osal_SchedulerUnlock.";
	.file_attr FuncName="adi_osal_EnterCriticalRegion.";
	.file_attr FuncName="adi_osal_ExitCriticalRegion.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern xTaskGetSchedulerState.;
	.type xTaskGetSchedulerState.,STT_FUNC;
	.extern vTaskSuspendAll.;
	.type vTaskSuspendAll.,STT_FUNC;
	.extern xTaskResumeAll.;
	.type xTaskResumeAll.,STT_FUNC;
	.extern ulPortSetInterruptMask.;
	.type ulPortSetInterruptMask.,STT_FUNC;
	.extern vPortEnterCritical.;
	.type vPortEnterCritical.,STT_FUNC;
	.extern vPortClearInterruptMask.;
	.type vPortClearInterruptMask.,STT_FUNC;
	.extern vPortExitCritical.;
	.type vPortExitCritical.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\osal\adi_osal_freertos_critical.sbn", 0, 296;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0xF5,0x26,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x70,0x6F,0x72,0x74,0x61,0x62,0x6C,0x65,0x5C,0x43,
		0x43,0x45,0x53,0x5C,0x6F,0x73,0x61,0x6C,0x5C,0x61,0x64,0x69,
		0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x66,0x72,0x65,0x65,0x72,0x74,
		0x6F,0x73,0x5F,0x63,0x72,0x69,0x74,0x69,0x63,0x61,0x6C,0x2E,
		0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\osal\adi_osal_freertos_critical.sbn", 296, 9358;
	.var = .LNadi_osal_IsSchedulerActive.;
	.var = .LN.adi_osal_IsSchedulerActive..end;
	.byte =
		0x01,0xF5,0x01,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.adi_osal_IsSchedulerActive..end;
	.byte =
		0x00,0x00,0x15,0x54,0x25,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x53,0x63,0x68,0x65,0x64,0x75,0x6C,0x65,
		0x72,0x4C,0x6F,0x63,0x6B,0x00,0x01;
	.var = .LNadi_osal_SchedulerLock.;
	.var = .LN.adi_osal_SchedulerLock..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN2;
	.var = .LN.adi_osal_SchedulerLock..end;
	.byte =
		0x00,0x00,0x13,0x91,0x25,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x53,0x63,0x68,0x65,0x64,0x75,0x6C,0x65,
		0x72,0x55,0x6E,0x6C,0x6F,0x63,0x6B,0x00,0x01;
	.var = .LNadi_osal_SchedulerUnlock.;
	.var = .LN.adi_osal_SchedulerUnlock..end;
	.byte =
		0x01,0x1F,0x18,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN5;
	.var = .LN.adi_osal_SchedulerUnlock..end;
	.byte =
		0x00,0x00,0x15,0xF1,0x25,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x45,0x6E,0x74,0x65,0x72,0x43,0x72,0x69,
		0x74,0x69,0x63,0x61,0x6C,0x52,0x65,0x67,0x69,0x6F,0x6E,0x00,
		0x01;
	.var = .LNadi_osal_EnterCriticalRegion.;
	.var = .LN.adi_osal_EnterCriticalRegion..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN11;
	.var = .LN.adi_osal_EnterCriticalRegion..end;
	.byte =
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN13;
	.var = .LN19;
	.byte =
		0x16,0x69,0x73,0x74,0x61,0x74,0x65,0x00,0x01,0x44,0x0C,0x00,
		0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x15,0x2D,0x26,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,
		0x6C,0x5F,0x45,0x78,0x69,0x74,0x43,0x72,0x69,0x74,0x69,0x63,
		0x61,0x6C,0x52,0x65,0x67,0x69,0x6F,0x6E,0x00,0x01;
	.var = .LNadi_osal_ExitCriticalRegion.;
	.var = .LN.adi_osal_ExitCriticalRegion..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN22;
	.var = .LN.adi_osal_ExitCriticalRegion..end;
	.byte =
		0x00,0x00,0x13,0x6D,0x26,0x00,0x00,0x5F,0x61,0x64,0x69,0x5F,
		0x6F,0x73,0x61,0x6C,0x5F,0x49,0x73,0x43,0x75,0x72,0x72,0x65,
		0x6E,0x74,0x4C,0x65,0x76,0x65,0x6C,0x49,0x53,0x52,0x00,0x01;
	.var = .LN_adi_osal_IsCurrentLevelISR.;
	.var = .LN._adi_osal_IsCurrentLevelISR..end;
	.byte =
		0x01,0xF5,0x01,0x00,0x00,0x01,0x02,0x14,0x00,0x00,0x00,0x00;
	.var = .LN33;
	.var = .LN36;
	.byte =
		0x00,0x00,0x16,0x5F,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,
		0x5F,0x67,0x6E,0x53,0x63,0x68,0x65,0x64,0x75,0x6C,0x65,0x72,
		0x4C,0x6F,0x63,0x6B,0x43,0x6E,0x74,0x00,0x01,0x28,0x05,0x00,
		0x00,0x05,0x03;
	.var = _adi_osal_gnSchedulerLockCnt.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x5F,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x67,0x6E,0x43,0x72,0x69,0x74,0x69,0x63,
		0x61,0x6C,0x52,0x65,0x67,0x69,0x6F,0x6E,0x4E,0x65,0x73,0x74,
		0x69,0x6E,0x67,0x43,0x6E,0x74,0x00,0x01,0xFD,0x04,0x00,0x00,
		0x05,0x03;
	.var = _adi_osal_gnCriticalRegionNestingCnt.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x73,0x6E,0x43,0x72,0x69,0x74,
		0x69,0x63,0x61,0x6C,0x52,0x65,0x67,0x69,0x6F,0x6E,0x53,0x74,
		0x61,0x74,0x65,0x00,0x01,0x44,0x0C,0x00,0x00,0x05,0x03;
	.var = snCriticalRegionState.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\osal\adi_osal_freertos_critical.sbn", 9654, 2308;
	.var = .LNadi_osal_IsSchedulerActive.;
	.byte =
		0x04,0x01,0x05,0x01,0x83,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x40,0x0A,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN.adi_osal_IsSchedulerActive..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_SchedulerLock.;
	.byte =
		0x04,0x01,0x05,0x01,0x97,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x14,0x0A,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x06,0x0F,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN.adi_osal_SchedulerLock..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_SchedulerUnlock.;
	.byte =
		0x04,0x01,0x05,0x01,0xB3,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x02,0x0E,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x10,0x0C,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_SchedulerUnlock..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_EnterCriticalRegion.;
	.byte =
		0x04,0x01,0x05,0x01,0xD1,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x06,0x0A,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x18,0x0F,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x16,0x01,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x04,0x0C,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_EnterCriticalRegion..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_ExitCriticalRegion.;
	.byte =
		0x04,0x01,0x05,0x01,0xF4,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x05,0x06,0x0B,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN.adi_osal_ExitCriticalRegion..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LN_adi_osal_IsCurrentLevelISR.;
	.byte =
		0x04,0x2E,0x05,0x06,0x7D,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x06,0x03,0x7B,0x01,0x00,0x05,0x02;
	.var = .LN._adi_osal_IsCurrentLevelISR..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x10,0x01,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.inc/binary ".\system\osal\adi_osal_freertos_critical.sbn", 11962, 266;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x44,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNadi_osal_IsSchedulerActive.;
	.var = .LN.adi_osal_IsSchedulerActive..end-.LNadi_osal_IsSchedulerActive.;
	.var = .LNadi_osal_SchedulerLock.;
	.var = .LN.adi_osal_SchedulerLock..end-.LNadi_osal_SchedulerLock.;
	.var = .LNadi_osal_SchedulerUnlock.;
	.var = .LN.adi_osal_SchedulerUnlock..end-.LNadi_osal_SchedulerUnlock.;
	.var = .LNadi_osal_EnterCriticalRegion.;
	.var = .LN.adi_osal_EnterCriticalRegion..end-.LNadi_osal_EnterCriticalRegion.;
	.var = .LN_adi_osal_IsCurrentLevelISR.;
	.var = .LN._adi_osal_IsCurrentLevelISR..end-.LN_adi_osal_IsCurrentLevelISR.;
	.var = .LNadi_osal_ExitCriticalRegion.;
	.var = .LN.adi_osal_ExitCriticalRegion..end-.LNadi_osal_ExitCriticalRegion.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.global _adi_osal_gnSchedulerLockCnt.;
	.type _adi_osal_gnSchedulerLockCnt.,STT_OBJECT;
	.byte _adi_osal_gnSchedulerLockCnt.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.global _adi_osal_gnCriticalRegionNestingCnt.;
	.type _adi_osal_gnCriticalRegionNestingCnt.,STT_OBJECT;
	.byte _adi_osal_gnCriticalRegionNestingCnt.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type snCriticalRegionState.,STT_OBJECT;
	.byte snCriticalRegionState.[] =
		0x00,0x00,0x00,0x00;
