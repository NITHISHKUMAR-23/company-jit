	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_rtl_lock.c";
//  Compilation time: Thu Oct 24 14:39:51 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\osal -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\osal\adi_osal_freertos_rtl_lock.d -o system\osal\adi_osal_freertos_rtl_lock.doj
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

adi_osal_RTLGlobalsLock.:
.LNadi_osal_RTLGlobalsLock.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN0:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_rtl_lock.c":67
	cjump adi_osal_SchedulerLock. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
.LN1:
// line 69
	r0=m5;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_RTLGlobalsLock..end:
.adi_osal_RTLGlobalsLock..end:
	.global adi_osal_RTLGlobalsLock.;
	.type adi_osal_RTLGlobalsLock.,STT_FUNC;

adi_osal_RTLGlobalsUnlock.:
.LNadi_osal_RTLGlobalsUnlock.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN2:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_rtl_lock.c":94
	cjump adi_osal_SchedulerUnlock. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN3:
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_RTLGlobalsUnlock..end:
.adi_osal_RTLGlobalsUnlock..end:
	.global adi_osal_RTLGlobalsUnlock.;
	.type adi_osal_RTLGlobalsUnlock.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="_adi_osal_IsMemoryAligned.";
	.file_attr FuncName="_adi_osal_IsCurrentLevelISR.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="adi_osal_RTLGlobalsLock.";
	.file_attr FuncName="adi_osal_RTLGlobalsUnlock.";
	.file_attr Encoding="SW";
	.file_attr Content="Code";
.epctext.end:

	.extern adi_osal_SchedulerLock.;
	.type adi_osal_SchedulerLock.,STT_FUNC;
	.extern adi_osal_SchedulerUnlock.;
	.type adi_osal_SchedulerUnlock.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\osal\adi_osal_freertos_rtl_lock.sbn", 0, 258;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x56,0x25,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x70,0x6F,0x72,0x74,0x61,0x62,0x6C,0x65,0x5C,0x43,
		0x43,0x45,0x53,0x5C,0x6F,0x73,0x61,0x6C,0x5C,0x61,0x64,0x69,
		0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x66,0x72,0x65,0x65,0x72,0x74,
		0x6F,0x73,0x5F,0x72,0x74,0x6C,0x5F,0x6C,0x6F,0x63,0x6B,0x2E,
		0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\osal\adi_osal_freertos_rtl_lock.sbn", 258, 9355;
	.var = .LNadi_osal_RTLGlobalsLock.;
	.var = .LN.adi_osal_RTLGlobalsLock..end;
	.byte =
		0x01,0x1F,0x18,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.adi_osal_RTLGlobalsLock..end;
	.byte =
		0x00,0x00,0x13,0x58,0x25,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x52,0x54,0x4C,0x47,0x6C,0x6F,0x62,0x61,
		0x6C,0x73,0x55,0x6E,0x6C,0x6F,0x63,0x6B,0x00,0x01;
	.var = .LNadi_osal_RTLGlobalsUnlock.;
	.var = .LN.adi_osal_RTLGlobalsUnlock..end;
	.byte =
		0x01,0x1F,0x18,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN2;
	.var = .LN.adi_osal_RTLGlobalsUnlock..end;
	.byte =
		0x00,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\osal\adi_osal_freertos_rtl_lock.sbn", 9613, 2308;
	.var = .LNadi_osal_RTLGlobalsLock.;
	.byte =
		0x04,0x01,0x05,0x01,0x4A,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x1B,0x0A,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN.adi_osal_RTLGlobalsLock..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_RTLGlobalsUnlock.;
	.byte =
		0x04,0x01,0x05,0x01,0x65,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x25,0x0A,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN.adi_osal_RTLGlobalsUnlock..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x48,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x5A,0x25,0x00,0x00,0xDE,0x24,0x00,0x00,0x61,0x64,0x69,0x5F,
		0x6F,0x73,0x61,0x6C,0x5F,0x52,0x54,0x4C,0x47,0x6C,0x6F,0x62,
		0x61,0x6C,0x73,0x4C,0x6F,0x63,0x6B,0x00,0x1A,0x25,0x00,0x00,
		0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x52,0x54,0x4C,
		0x47,0x6C,0x6F,0x62,0x61,0x6C,0x73,0x55,0x6E,0x6C,0x6F,0x63,
		0x6B,0x00,0x00,0x00,0x00,0x00;
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
	.var = .LNadi_osal_RTLGlobalsLock.;
	.var = .LN.adi_osal_RTLGlobalsLock..end-.LNadi_osal_RTLGlobalsLock.;
	.var = .LNadi_osal_RTLGlobalsUnlock.;
	.var = .LN.adi_osal_RTLGlobalsUnlock..end-.LNadi_osal_RTLGlobalsUnlock.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:
