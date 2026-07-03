	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_tls.c";
//  Compilation time: Thu Oct 24 14:39:54 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\osal -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\osal\adi_osal_freertos_tls.d -o system\osal\adi_osal_freertos_tls.doj
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

adi_osal_ThreadSlotRelease.:
.LNadi_osal_ThreadSlotRelease.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0-r2,i12,acc,scc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_tls.c":252
	modify(i7,-4) (nw);
	dm(-5,i6)=r4;
.LN0:
// line 253
	r2=fext r4 by 0:8;
	dm(-4,i6)=r2;
.LN1:
// line 254
	r1=m6;
	r1=lshift r1 by r2;
	dm(-3,i6)=r1;
	r2=pass r2;
.LN2:
// line 258
	if eq jump (pc,.P35L2);

.LN3:
// line 261
	i12=11;
	dm(-2,i6)=i12;
	jump (pc,.P35L4);

.P35L2:
.LN4:
// line 266
	r2=not r1;
	r1=dm(_adi_osal_gTLSUsedSlots.);
	r2=r2 and r1;
	dm(_adi_osal_gTLSUsedSlots.)=r2;
.LN5:
// line 268
	dm(-2,i6)=m13;

.P35L4:
.LN6:
// line 269
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ThreadSlotRelease..end:
.adi_osal_ThreadSlotRelease..end:
	.global adi_osal_ThreadSlotRelease.;
	.type adi_osal_ThreadSlotRelease.,STT_FUNC;

adi_osal_ThreadSlotAcquire.:
.LNadi_osal_ThreadSlotAcquire.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r0-r2,r4,r12,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//Inlined in adi_osal_ThreadSlotAcquire.:
//  D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_tls.c:190:22'IsValidTLSKey.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_tls.c":165
	modify(i7,-8) (nw);
	r2=r4;
	r4=r8;
	dm(-8,i6)=r8;
	dm(-9,i6)=r2;
.LN7:
// line 166
	dm(-7,i6)=m14;
.LN8:
// line 170
	cjump adi_osal_RegisterLocalStorageCallback. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
.LN9:
// line 174
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN10:
	if eq jump (pc,.P36L2);

.LN11:
// line 176
	i12=19;
	dm(-6,i6)=i12;
	jump (pc,.P36L4);

.P36L2:
.LN12:
// line 183
	cjump vTaskSuspendAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
.LN13:
// line 190
	i4=dm(-9,i6);
	r2=dm(i4,m5);
.LN14:
	dm(-2,i6)=r2;
.LN15:
// line 138
	r1=-256;
	r2=r2 and r1;
	r1=1414288128;
	comp(r2,r1);
.LN16:
// line 190
	if ne jump (pc,.P36L7);

.LN17:
// line 194
	r2=dm(i4,m5);
	r2=fext r2 by 0:8;
	r1=m6;
	r2=lshift r1 by r2;
	dm(-5,i6)=r2;
.LN18:
// line 196
	r1=dm(_adi_osal_gTLSUsedSlots.);
	r2=r2 and r1;
	r2=pass r2;
	if eq jump (pc,.P36L10);

.LN19:
// line 198
	dm(-7,i6)=m13;
.LN20:
// line 199
	jump (pc,.P36L11);

.P36L10:
.LN21:
// line 202
	i12=32;
	dm(-7,i6)=i12;

.P36L11:
.LN22:
// line 204
	jump (pc,.P36L8);

.P36L7:
.LN23:
// line 210
	r2=dm(i4,m5);
	r0=-252645136;
	comp(r2,r0);
	if eq jump (pc,.P36L13);

.LN24:
// line 212
	dm(m5,i4)=m15;
.LN25:
// line 213
	jump (pc,.P36L14);

.P36L13:
.LN26:
// line 218
	dm(-4,i6)=m13;

.P36L15:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_tls.c" line 218 col 7
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 17 
//   cycles (includes 4 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   9 out of   17 ( 52.9%)
//     multifunction float multiply    used   9 out of   17 ( 52.9%)
//     multifunction integer add sub   used   9 out of   17 ( 52.9%)
//     multifunction integer multiply  used   9 out of   17 ( 52.9%)
//     multifunction mult              used   9 out of   17 ( 52.9%)
//     dm dag                          used   8 out of   17 ( 47.1%)
//     pm dag                          used   8 out of   17 ( 47.1%)
//     shift immediate                 used   8 out of   17 ( 47.1%)
//     memory access                   used   8 out of   34 ( 23.5%)
//-------------------------------------------------------------------
	// -- 2 stalls --
	r2=dm(-4,i6);
	r0=m6;
	comp(r2,r0);
	if ge jump (pc,.P36L17);

.LN27:
// line 220
	r0=lshift r0 by r2;
	dm(-3,i6)=r0;
.LN28:
// line 222
	r12=dm(_adi_osal_gTLSUsedSlots.);
	r0=r0 and r12;
	r0=pass r0;
	if ne jump (pc,.P36L19);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN29:
// line 225
	r2=dm(-3,i6);
	r0=dm(_adi_osal_gTLSUsedSlots.);
	r2=r2 or r0;
	dm(_adi_osal_gTLSUsedSlots.)=r2;
.LN30:
// line 226
	r2=dm(-4,i6);
	r2=r2 or r1;
	i4=dm(-9,i6);
	dm(i4,m5)=r2;
.LN31:
// line 227
	dm(-7,i6)=m13;
.LN32:
// line 228
	jump (pc,.P36L21);

.P36L19:
//-------------------------------------------------------------------
//   Part of Loop 15, depth 1
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN33:
// line 218
	r2=r2+1;
	dm(-4,i6)=r2;
	jump (pc,.P36L15);
//-------------------------------------------------------------------
//   End Loop L15
//-------------------------------------------------------------------

.P36L17:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------

.P36L21:

.P36L14:

.P36L8:
.LN34:
// line 234
	cjump xTaskResumeAll. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
.LN35:
// line 236
	r2=dm(-7,i6);
	dm(-6,i6)=r2;

.P36L4:
.LN36:
// line 237
	r0=dm(-6,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ThreadSlotAcquire..end:
.adi_osal_ThreadSlotAcquire..end:
	.global adi_osal_ThreadSlotAcquire.;
	.type adi_osal_ThreadSlotAcquire.,STT_FUNC;

adi_osal_ThreadSlotSetValue.:
.LNadi_osal_ThreadSlotSetValue.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,r8,r12,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_tls.c":285
	modify(i7,-4) (nw);
	r12=r8;
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
.LN37:
// line 286
	r8=fext r4 by 0:8;
	dm(-3,i6)=r8;
	r2=pass r8;
.LN38:
// line 290
	if eq jump (pc,.P41L2);

.LN39:
// line 293
	i12=11;
	dm(-2,i6)=i12;
	jump (pc,.P41L4);

.P41L2:
.LN40:
// line 297
	r4=m5;
	cjump vTaskSetThreadLocalStoragePointer. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
.LN41:
// line 299
	dm(-2,i6)=m13;

.P41L4:
.LN42:
// line 300
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ThreadSlotSetValue..end:
.adi_osal_ThreadSlotSetValue..end:
	.global adi_osal_ThreadSlotSetValue.;
	.type adi_osal_ThreadSlotSetValue.,STT_FUNC;

adi_osal_ThreadSlotGetValue.:
.LNadi_osal_ThreadSlotGetValue.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,r8,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_tls.c":320
	modify(i7,-4) (nw);
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
.LN43:
// line 321
	r8=fext r4 by 0:8;
	dm(-3,i6)=r8;
	r2=pass r8;
.LN44:
// line 325
	if eq jump (pc,.P43L2);

.LN45:
// line 328
	i12=11;
	dm(-2,i6)=i12;
	jump (pc,.P43L4);

.P43L2:
.LN46:
// line 332
	r4=m5;
	cjump pvTaskGetThreadLocalStoragePointer. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
.LN47:
	i4=dm(-4,i6);
	dm(i4,m5)=r0;
.LN48:
// line 334
	dm(-2,i6)=m13;

.P43L4:
.LN49:
// line 335
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ThreadSlotGetValue..end:
.adi_osal_ThreadSlotGetValue..end:
	.global adi_osal_ThreadSlotGetValue.;
	.type adi_osal_ThreadSlotGetValue.,STT_FUNC;

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

.LN50:
// line 122
	r2=imaskp;

.LN51:
	r2=pass r2;
	r0=m5;
	if ne r0=m6;
.LN52:
	dm(-2,i6)=r0;

.LN53:
// line 117
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN._adi_osal_IsCurrentLevelISR..end:
._adi_osal_IsCurrentLevelISR..end:
	.type _adi_osal_IsCurrentLevelISR.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="adi_osal_ThreadSlotRelease.";
	.file_attr FuncName="IsValidTLSKey.";
	.file_attr FuncName="_adi_osal_IsMemoryAligned.";
	.file_attr FuncName="_adi_osal_IsCurrentLevelISR.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr FuncName="adi_osal_ThreadSlotAcquire.";
	.file_attr FuncName="adi_osal_ThreadSlotSetValue.";
	.file_attr FuncName="adi_osal_ThreadSlotGetValue.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern adi_osal_RegisterLocalStorageCallback.;
	.type adi_osal_RegisterLocalStorageCallback.,STT_FUNC;
	.extern vTaskSuspendAll.;
	.type vTaskSuspendAll.,STT_FUNC;
	.extern xTaskResumeAll.;
	.type xTaskResumeAll.,STT_FUNC;
	.extern vTaskSetThreadLocalStoragePointer.;
	.type vTaskSetThreadLocalStoragePointer.,STT_FUNC;
	.extern pvTaskGetThreadLocalStoragePointer.;
	.type pvTaskGetThreadLocalStoragePointer.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\osal\adi_osal_freertos_tls.sbn", 0, 288;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x8E,0x29,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x70,0x6F,0x72,0x74,0x61,0x62,0x6C,0x65,0x5C,0x43,
		0x43,0x45,0x53,0x5C,0x6F,0x73,0x61,0x6C,0x5C,0x61,0x64,0x69,
		0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x66,0x72,0x65,0x65,0x72,0x74,
		0x6F,0x73,0x5F,0x74,0x6C,0x73,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\osal\adi_osal_freertos_tls.sbn", 288, 9753;
	.var = .LNadi_osal_ThreadSlotRelease.;
	.var = .LN.adi_osal_ThreadSlotRelease..end;
	.byte =
		0x01,0xA5,0x19,0x00,0x00,0x01,0x00,0x14,0x6E,0x54,0x68,0x72,
		0x65,0x61,0x64,0x53,0x6C,0x6F,0x74,0x4B,0x65,0x79,0x00,0xAA,
		0x1A,0x00,0x00,0x02,0x86,0x6C,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.adi_osal_ThreadSlotRelease..end;
	.byte =
		0x16,0x73,0x6C,0x6F,0x74,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,
		0xE9,0x26,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,
		0x16,0x73,0x6C,0x6F,0x74,0x42,0x69,0x74,0x00,0x01,0xE9,0x26,
		0x00,0x00,0x02,0x86,0x74;
	.var = .LN0-.LNadi_osal_ThreadSlotRelease.;
	.byte =
		0x00,0x00,0x00,0x11,0xD9,0x06,0x00,0x00,0x13,0xEF,0x27,0x00,
		0x00,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x54,0x68,
		0x72,0x65,0x61,0x64,0x53,0x6C,0x6F,0x74,0x41,0x63,0x71,0x75,
		0x69,0x72,0x65,0x00,0x01;
	.var = .LNadi_osal_ThreadSlotAcquire.;
	.var = .LN.adi_osal_ThreadSlotAcquire..end;
	.byte =
		0x01,0xA5,0x19,0x00,0x00,0x01,0x00,0x14,0x70,0x6E,0x54,0x68,
		0x72,0x65,0x61,0x64,0x53,0x6C,0x6F,0x74,0x4B,0x65,0x79,0x00,
		0xEF,0x27,0x00,0x00,0x02,0x86,0x5C,0x00,0x14,0x70,0x54,0x65,
		0x72,0x6D,0x69,0x6E,0x61,0x74,0x65,0x43,0x61,0x6C,0x6C,0x62,
		0x61,0x63,0x6B,0x46,0x75,0x6E,0x63,0x00,0x8A,0x1A,0x00,0x00,
		0x02,0x86,0x60,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN7;
	.var = .LN.adi_osal_ThreadSlotAcquire..end;
	.byte =
		0x16,0x65,0x52,0x65,0x74,0x53,0x74,0x61,0x74,0x75,0x73,0x00,
		0x01,0xA5,0x19,0x00,0x00,0x02,0x86,0x64;
	.var = .LN7-.LNadi_osal_ThreadSlotAcquire.;
	.byte =
		0x00,0x15,0xA2,0x27,0x00,0x00;
	.var = .LN17;
	.var = .LN23;
	.byte =
		0x16,0x6E,0x53,0x6C,0x6F,0x74,0x42,0x69,0x74,0x00,0x01,0xD9,
		0x06,0x00,0x00,0x02,0x86,0x6C,0x00,0x00,0x00,0x00,0x00,0x00,
		0x15,0x00,0x00,0x00,0x00;
	.var = .LN26;
	.var = .LN34;
	.byte =
		0x16,0x6E,0x53,0x6C,0x6F,0x74,0x49,0x6E,0x64,0x65,0x78,0x00,
		0x01,0xB9,0x0D,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN27;
	.var = .LN33;
	.byte =
		0x16,0x73,0x6C,0x6F,0x74,0x42,0x69,0x74,0x00,0x01,0xE9,0x26,
		0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x00,0x00,0x0A,0x00,0xAA,0x1A,0x00,0x00,0x13,0x78,0x28,0x00,
		0x00,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x54,0x68,
		0x72,0x65,0x61,0x64,0x53,0x6C,0x6F,0x74,0x53,0x65,0x74,0x56,
		0x61,0x6C,0x75,0x65,0x00,0x01;
	.var = .LNadi_osal_ThreadSlotSetValue.;
	.var = .LN.adi_osal_ThreadSlotSetValue..end;
	.byte =
		0x01,0xA5,0x19,0x00,0x00,0x01,0x00,0x14,0x6E,0x54,0x68,0x72,
		0x65,0x61,0x64,0x53,0x6C,0x6F,0x74,0x4B,0x65,0x79,0x00,0xAA,
		0x1A,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x73,0x6C,0x6F,0x74,
		0x56,0x61,0x6C,0x75,0x65,0x00,0x51,0x1A,0x00,0x00,0x02,0x86,
		0x70,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN37;
	.var = .LN.adi_osal_ThreadSlotSetValue..end;
	.byte =
		0x16,0x73,0x6C,0x6F,0x74,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,
		0xE9,0x26,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,
		0x00,0x00,0x13,0xFC,0x28,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x54,0x68,0x72,0x65,0x61,0x64,0x53,0x6C,
		0x6F,0x74,0x47,0x65,0x74,0x56,0x61,0x6C,0x75,0x65,0x00,0x01;
	.var = .LNadi_osal_ThreadSlotGetValue.;
	.var = .LN.adi_osal_ThreadSlotGetValue..end;
	.byte =
		0x01,0xA5,0x19,0x00,0x00,0x01,0x00,0x14,0x6E,0x54,0x68,0x72,
		0x65,0x61,0x64,0x53,0x6C,0x6F,0x74,0x4B,0x65,0x79,0x00,0xAA,
		0x1A,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x70,0x53,0x6C,0x6F,
		0x74,0x56,0x61,0x6C,0x75,0x65,0x00,0xFC,0x28,0x00,0x00,0x02,
		0x86,0x70,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN43;
	.var = .LN.adi_osal_ThreadSlotGetValue..end;
	.byte =
		0x16,0x73,0x6C,0x6F,0x74,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,
		0xE9,0x26,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,
		0x00,0x00,0x0A,0x00,0x51,0x1A,0x00,0x00,0x13,0x42,0x29,0x00,
		0x00,0x5F,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x49,
		0x73,0x43,0x75,0x72,0x72,0x65,0x6E,0x74,0x4C,0x65,0x76,0x65,
		0x6C,0x49,0x53,0x52,0x00,0x01;
	.var = .LN_adi_osal_IsCurrentLevelISR.;
	.var = .LN._adi_osal_IsCurrentLevelISR..end;
	.byte =
		0x01,0xF0,0x01,0x00,0x00,0x01,0x02,0x15,0x00,0x00,0x00,0x00;
	.var = .LN50;
	.var = .LN53;
	.byte =
		0x00,0x00,0x16,0x5F,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,
		0x5F,0x67,0x6E,0x4E,0x75,0x6D,0x53,0x6C,0x6F,0x74,0x73,0x00,
		0x01,0xD9,0x06,0x00,0x00,0x05,0x03;
	.var = _adi_osal_gnNumSlots.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x5F,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x67,0x54,0x4C,0x53,0x55,0x73,0x65,0x64,
		0x53,0x6C,0x6F,0x74,0x73,0x00,0x01,0xD9,0x06,0x00,0x00,0x05,
		0x03;
	.var = _adi_osal_gTLSUsedSlots.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\osal\adi_osal_freertos_tls.sbn", 10041, 2473;
	.var = .LNadi_osal_ThreadSlotRelease.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xFB,0x01,0x01,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x1B,0x0A,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x19,0x0A,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x02,0x0D,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x06,0x0C,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x02,0x0E,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_ThreadSlotRelease..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_ThreadSlotAcquire.;
	.byte =
		0x04,0x01,0x05,0x01,0xAD,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x16,0x0A,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x28,0x0D,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x14,0x10,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x16,0x01,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x05,0x03,0x4C,0x01,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x3D,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x1B,0x0D,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x0A,0x0C,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x05,0x03,0x0F,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x07,0x0E,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x05,0x1F,0x0B,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x05,0x08,0x0B,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x06,0x0C,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x52,0x03,0x76,0x01,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x05,0x13,0x19,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_ThreadSlotAcquire..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_ThreadSlotSetValue.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x9C,0x02,0x01,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x05,0x1B,0x0A,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x05,0x02,0x0D,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x05,0x06,0x0C,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x05,0x23,0x0D,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_ThreadSlotSetValue..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_ThreadSlotGetValue.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xBF,0x02,0x01,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x05,0x1B,0x0A,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x05,0x02,0x0D,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x05,0x06,0x0C,0x00,0x05,0x02;
	.var = .LN46;
	.byte =
		0x05,0x32,0x0D,0x00,0x05,0x02;
	.var = .LN47;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN48;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN49;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_ThreadSlotGetValue..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LN_adi_osal_IsCurrentLevelISR.;
	.byte =
		0x04,0x30,0x05,0x06,0x7D,0x00,0x05,0x02;
	.var = .LN50;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN51;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN52;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN53;
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
		0xC5,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.inc/binary ".\system\osal\adi_osal_freertos_tls.sbn", 12514, 191;
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
	.var = .LNadi_osal_ThreadSlotRelease.;
	.var = .LN.adi_osal_ThreadSlotRelease..end-.LNadi_osal_ThreadSlotRelease.;
	.var = .LNadi_osal_ThreadSlotAcquire.;
	.var = .LN.adi_osal_ThreadSlotAcquire..end-.LNadi_osal_ThreadSlotAcquire.;
	.var = .LN_adi_osal_IsCurrentLevelISR.;
	.var = .LN._adi_osal_IsCurrentLevelISR..end-.LN_adi_osal_IsCurrentLevelISR.;
	.var = .LNadi_osal_ThreadSlotSetValue.;
	.var = .LN.adi_osal_ThreadSlotSetValue..end-.LNadi_osal_ThreadSlotSetValue.;
	.var = .LNadi_osal_ThreadSlotGetValue.;
	.var = .LN.adi_osal_ThreadSlotGetValue..end-.LNadi_osal_ThreadSlotGetValue.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.global _adi_osal_gnNumSlots.;
	.type _adi_osal_gnNumSlots.,STT_OBJECT;
	.byte _adi_osal_gnNumSlots.[] =
		0x01,0x00,0x00,0x00;
	.align 4;
	.type _adi_osal_gTLSUsedSlots.,STT_OBJECT;
	.byte _adi_osal_gTLSUsedSlots.[] =
		0x00,0x00,0x00,0x00;
