	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\osal\adi_osal_arch_c.c";
//  Compilation time: Thu Oct 24 14:39:46 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\osal\SHARC_215xx -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\osal\SHARC_215xx\adi_osal_arch_c.d -o system\osal\SHARC_215xx\adi_osal_arch_c.doj
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

_adi_osal_HeapInstall.:
.LN_adi_osal_HeapInstall.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\osal\adi_osal_arch_c.c":92
	modify(i7,-6) (nw);
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
.LN0:
// line 93
	i12=2147483647;
	dm(-4,i6)=i12;
	r2=pass r4;
.LN1:
// line 98
	if ne jump (pc,.P35L2);

.LN2:
// line 100
	dm(osal_snHeapIndex.)=m5;
.LN3:
// line 101
	dm(-3,i6)=m13;
	jump (pc,.P35L4);

.P35L2:
.LN4:
// line 111
	jump (pc,.P35L6);

.P35L14:
//-------------------------------------------------------------------
//   Part of Loop 6, depth 1
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//   End Loop L6
//-------------------------------------------------------------------

.P35L6:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\osal\adi_osal_arch_c.c" line 111 col 5
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 19 
//   cycles (includes 2 stalls but excludes the cost of function calls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used  12 out of   19 ( 63.2%)
//     pm dag                          used  12 out of   19 ( 63.2%)
//     shift immediate                 used  12 out of   19 ( 63.2%)
//     multifunction alu               used   9 out of   19 ( 47.4%)
//     multifunction float multiply    used   9 out of   19 ( 47.4%)
//     multifunction integer add sub   used   9 out of   19 ( 47.4%)
//     multifunction integer multiply  used   9 out of   19 ( 47.4%)
//     multifunction mult              used   9 out of   19 ( 47.4%)
//     memory access                   used  12 out of   38 ( 31.6%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN5:
// line 113
	dm(-2,i6)=m15;
.LN6:
// line 114
	r4=dm(-6,i6);
	r8=dm(-5,i6);
	r12=dm(-4,i6);
.LN7:
	cjump _heap_install. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
.LN8:
	dm(osal_snHeapIndex.)=r0;
.LN9:
// line 115
	r2=dm(-4,i6);
	r2=r2-1;
	dm(-4,i6)=r2;
	r1=m7;
	comp(r0,r1);
.LN10:
// line 116
	if ne jump (pc,.P35L7);

	r0=2147483637;
	comp(r2,r0);
	if gt jump (pc,.P35L14);

.P35L7:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN11:
// line 118
	r2=dm(osal_snHeapIndex.);
	comp(r2,r1);
	if ne jump (pc,.P35L10);

.LN12:
// line 119
	i12=23;
	dm(-3,i6)=i12;
	jump (pc,.P35L4);

.P35L10:
.LN13:
// line 121
	dm(-3,i6)=m13;

.P35L4:
.LN14:
// line 123
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN._adi_osal_HeapInstall..end:
._adi_osal_HeapInstall..end:
	.global _adi_osal_HeapInstall.;
	.type _adi_osal_HeapInstall.,STT_FUNC;

_adi_osal_MemAlloc.:
.LN_adi_osal_MemAlloc.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,i4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\osal\adi_osal_arch_c.c":142
	modify(i7,-4) (nw);
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
.LN15:
// line 147
	r4=dm(osal_snHeapIndex.);
	r2=m7;
	comp(r4,r2);
	if ne jump (pc,.P37L2);

.LN16:
// line 149
	dm(-2,i6)=m14;
	jump (pc,.P37L4);

.P37L2:
.LN17:
// line 152
	cjump _heap_malloc. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN18:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN19:
// line 154
	if eq jump (pc,.P37L7);

.LN20:
// line 156
	i4=dm(-5,i6);
	dm(i4,m5)=r0;
.LN21:
// line 157
	dm(-2,i6)=m13;
	jump (pc,.P37L4);

.P37L7:
.LN22:
// line 161
	i12=23;
	dm(-2,i6)=i12;

.P37L4:
.LN23:
// line 163
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN._adi_osal_MemAlloc..end:
._adi_osal_MemAlloc..end:
	.global _adi_osal_MemAlloc.;
	.type _adi_osal_MemAlloc.,STT_FUNC;

_adi_osal_MemFree.:
.LN_adi_osal_MemFree.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r4,r8,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\osal\adi_osal_arch_c.c":180
	modify(i7,-2) (nw);
	r8=r4;
	dm(-2,i6)=r4;
.LN24:
// line 181
	r4=dm(osal_snHeapIndex.);
.LN25:
	cjump _heap_free. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
.LN26:
// line 182
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN._adi_osal_MemFree..end:
._adi_osal_MemFree..end:
	.global _adi_osal_MemFree.;
	.type _adi_osal_MemFree.,STT_FUNC;

adi_osal_ActivateHandler.:
.LNadi_osal_ActivateHandler.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\osal\adi_osal_arch_c.c":198
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN27:
// line 199
	cjump adi_rtl_activate_dispatched_handler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
	r2=pass r0;
.LN28:
	if eq jump (pc,.P41L2);

.LN29:
// line 202
	dm(-2,i6)=m14;
	jump (pc,.P41L4);

.P41L2:
.LN30:
// line 204
	dm(-2,i6)=m13;

.P41L4:
.LN31:
// line 205
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ActivateHandler..end:
.adi_osal_ActivateHandler..end:
	.global adi_osal_ActivateHandler.;
	.type adi_osal_ActivateHandler.,STT_FUNC;

adi_osal_DeactivateHandler.:
.LNadi_osal_DeactivateHandler.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\osal\adi_osal_arch_c.c":220
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN32:
// line 221
	cjump adi_rtl_deactivate_dispatched_handler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
	r2=pass r0;
.LN33:
	if eq jump (pc,.P43L2);

.LN34:
// line 224
	dm(-2,i6)=m14;
	jump (pc,.P43L4);

.P43L2:
.LN35:
// line 226
	dm(-2,i6)=m13;

.P43L4:
.LN36:
// line 227
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_DeactivateHandler..end:
.adi_osal_DeactivateHandler..end:
	.global adi_osal_DeactivateHandler.;
	.type adi_osal_DeactivateHandler.,STT_FUNC;

adi_osal_UninstallHandler.:
.LNadi_osal_UninstallHandler.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,i4,i12,m4,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\SHARC_215xx\osal\adi_osal_arch_c.c":245
	modify(i7,-4) (nw);
	dm(-4,i6)=r4;
.LN37:
// line 255
	cjump adi_rtl_unregister_dispatched_handler. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
.LN38:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN39:
// line 257
	if ge jump (pc,.P45L2);

.LN40:
// line 260
	dm(-2,i6)=m14;
	jump (pc,.P45L4);

.P45L2:
	m4=r0;
.LN41:
// line 275
	i4=_adi_osal_gHandlerTable.;
	dm(m4,i4)=m13;
.LN42:
// line 276
	dm(-2,i6)=m13;

.P45L4:
.LN43:
// line 277
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_UninstallHandler..end:
.adi_osal_UninstallHandler..end:
	.global adi_osal_UninstallHandler.;
	.type adi_osal_UninstallHandler.,STT_FUNC;

	.file_attr libGroup="adi_osal.h";
	.file_attr libName="libosal";
	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="_adi_osal_IsMemoryAligned.";
	.file_attr FuncName="_adi_osal_IsCurrentLevelISR.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr FuncName="_adi_osal_HeapInstall.";
	.file_attr FuncName="_adi_osal_MemAlloc.";
	.file_attr FuncName="_adi_osal_MemFree.";
	.file_attr FuncName="adi_osal_ActivateHandler.";
	.file_attr FuncName="adi_osal_DeactivateHandler.";
	.file_attr FuncName="adi_osal_UninstallHandler.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern _heap_install.;
	.type _heap_install.,STT_FUNC;
	.extern _heap_malloc.;
	.type _heap_malloc.,STT_FUNC;
	.extern _heap_free.;
	.type _heap_free.,STT_FUNC;
	.extern adi_rtl_activate_dispatched_handler.;
	.type adi_rtl_activate_dispatched_handler.,STT_FUNC;
	.extern adi_rtl_deactivate_dispatched_handler.;
	.type adi_rtl_deactivate_dispatched_handler.,STT_FUNC;
	.extern adi_rtl_unregister_dispatched_handler.;
	.type adi_rtl_unregister_dispatched_handler.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\osal\SHARC_215xx\adi_osal_arch_c.sbn", 0, 302;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x2B,0x22,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x70,0x6F,0x72,0x74,0x61,0x62,0x6C,0x65,0x5C,0x43,
		0x43,0x45,0x53,0x5C,0x53,0x48,0x41,0x52,0x43,0x5F,0x32,0x31,
		0x35,0x78,0x78,0x5C,0x6F,0x73,0x61,0x6C,0x5C,0x61,0x64,0x69,
		0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x61,0x72,0x63,0x68,0x5F,0x63,
		0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\osal\SHARC_215xx\adi_osal_arch_c.sbn", 302, 7977;
	.var = .LN_adi_osal_HeapInstall.;
	.var = .LN._adi_osal_HeapInstall..end;
	.byte =
		0x01,0xAB,0x19,0x00,0x00,0x01,0x00,0x13,0x70,0x48,0x65,0x61,
		0x70,0x4D,0x65,0x6D,0x6F,0x72,0x79,0x00,0x22,0x20,0x00,0x00,
		0x02,0x86,0x68,0x00,0x13,0x6E,0x48,0x65,0x61,0x70,0x4D,0x65,
		0x6D,0x6F,0x72,0x79,0x53,0x69,0x7A,0x65,0x00,0xDF,0x06,0x00,
		0x00,0x02,0x86,0x6C,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN._adi_osal_HeapInstall..end;
	.byte =
		0x15,0x6E,0x48,0x65,0x61,0x70,0x55,0x73,0x65,0x72,0x49,0x64,
		0x00,0x01,0xB4,0x06,0x00,0x00,0x02,0x86,0x70;
	.var = .LN0-.LN_adi_osal_HeapInstall.;
	.byte =
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN5;
	.var = .LN11;
	.byte =
		0x15,0x70,0x6D,0x64,0x6D,0x00,0x01,0xB4,0x06,0x00,0x00,0x02,
		0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x0A,0x00,
		0xDF,0x06,0x00,0x00,0x12,0x94,0x20,0x00,0x00,0x5F,0x61,0x64,
		0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x4D,0x65,0x6D,0x41,0x6C,
		0x6C,0x6F,0x63,0x00,0x01;
	.var = .LN_adi_osal_MemAlloc.;
	.var = .LN._adi_osal_MemAlloc..end;
	.byte =
		0x01,0xAB,0x19,0x00,0x00,0x01,0x00,0x13,0x70,0x70,0x44,0x61,
		0x74,0x61,0x00,0x94,0x20,0x00,0x00,0x02,0x86,0x6C,0x00,0x13,
		0x6E,0x53,0x69,0x7A,0x65,0x00,0xDF,0x06,0x00,0x00,0x02,0x86,
		0x70,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN15;
	.var = .LN._adi_osal_MemAlloc..end;
	.byte =
		0x15,0x70,0x4D,0x65,0x6D,0x6F,0x72,0x79,0x00,0x01,0xED,0x03,
		0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x0A,0x00,0xED,0x03,0x00,0x00,0x16,0xDB,0x20,0x00,0x00,0x5F,
		0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x4D,0x65,0x6D,
		0x46,0x72,0x65,0x65,0x00,0x01;
	.var = .LN_adi_osal_MemFree.;
	.var = .LN._adi_osal_MemFree..end;
	.byte =
		0x01,0x01,0x00,0x13,0x70,0x44,0x61,0x74,0x61,0x00,0xED,0x03,
		0x00,0x00,0x02,0x86,0x78,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN24;
	.var = .LN._adi_osal_MemFree..end;
	.byte =
		0x00,0x00,0x12,0x25,0x21,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x41,0x63,0x74,0x69,0x76,0x61,0x74,0x65,
		0x48,0x61,0x6E,0x64,0x6C,0x65,0x72,0x00,0x01;
	.var = .LNadi_osal_ActivateHandler.;
	.var = .LN.adi_osal_ActivateHandler..end;
	.byte =
		0x01,0xAB,0x19,0x00,0x00,0x01,0x00,0x13,0x69,0x69,0x64,0x00,
		0xDF,0x06,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x00,0x00,0x00,
		0x00;
	.var = .LN27;
	.var = .LN.adi_osal_ActivateHandler..end;
	.byte =
		0x00,0x00,0x12,0x71,0x21,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x44,0x65,0x61,0x63,0x74,0x69,0x76,0x61,
		0x74,0x65,0x48,0x61,0x6E,0x64,0x6C,0x65,0x72,0x00,0x01;
	.var = .LNadi_osal_DeactivateHandler.;
	.var = .LN.adi_osal_DeactivateHandler..end;
	.byte =
		0x01,0xAB,0x19,0x00,0x00,0x01,0x00,0x13,0x69,0x69,0x64,0x00,
		0xDF,0x06,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x00,0x00,0x00,
		0x00;
	.var = .LN32;
	.var = .LN.adi_osal_DeactivateHandler..end;
	.byte =
		0x00,0x00,0x12,0xD0,0x21,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x55,0x6E,0x69,0x6E,0x73,0x74,0x61,0x6C,
		0x6C,0x48,0x61,0x6E,0x64,0x6C,0x65,0x72,0x00,0x01;
	.var = .LNadi_osal_UninstallHandler.;
	.var = .LN.adi_osal_UninstallHandler..end;
	.byte =
		0x01,0xAB,0x19,0x00,0x00,0x01,0x00,0x13,0x69,0x69,0x64,0x00,
		0xDF,0x06,0x00,0x00,0x02,0x86,0x70,0x00,0x14,0x00,0x00,0x00,
		0x00;
	.var = .LN37;
	.var = .LN.adi_osal_UninstallHandler..end;
	.byte =
		0x15,0x69,0x6E,0x64,0x65,0x78,0x00,0x01,0xB4,0x06,0x00,0x00,
		0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x15,0x5F,
		0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x67,0x48,0x61,
		0x6E,0x64,0x6C,0x65,0x72,0x54,0x61,0x62,0x6C,0x65,0x00,0x01,
		0x1B,0x22,0x00,0x00,0x05,0x03;
	.var = _adi_osal_gHandlerTable.;
	.byte =
		0x00,0x00,0x00,0x00,0x01,0x15,0x6F,0x73,0x61,0x6C,0x5F,0x73,
		0x6E,0x48,0x65,0x61,0x70,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,
		0xB4,0x06,0x00,0x00,0x05,0x03;
	.var = osal_snHeapIndex.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x0D,0x2D,0x22,0x00,0x00,0xF5,0x1E,
		0x00,0x00,0x0E,0x00,0x00,0xFF,0xFF,0xFF,0xFF,0x0F,0x00,0x00,
		0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\osal\SHARC_215xx\adi_osal_arch_c.sbn", 8279, 2375;
	.var = .LN_adi_osal_HeapInstall.;
	.byte =
		0x04,0x01,0x05,0x01,0x64,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x05,0x13,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x11,0x0B,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x28,0x01,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x09,0x01,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN._adi_osal_HeapInstall..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LN_adi_osal_MemAlloc.;
	.byte =
		0x04,0x01,0x05,0x01,0x96,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x1A,0x0C,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN._adi_osal_MemAlloc..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LN_adi_osal_MemFree.;
	.byte =
		0x04,0x01,0x05,0x01,0xBC,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN._adi_osal_MemFree..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_ActivateHandler.;
	.byte =
		0x04,0x01,0x05,0x01,0xCE,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x05,0x31,0x0A,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_ActivateHandler..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_DeactivateHandler.;
	.byte =
		0x04,0x01,0x05,0x01,0xE4,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x33,0x0A,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_DeactivateHandler..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_UninstallHandler.;
	.byte =
		0x04,0x01,0x05,0x01,0xFD,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x05,0x33,0x13,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x05,0x05,0x18,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_UninstallHandler..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0xAF,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.inc/binary ".\system\osal\SHARC_215xx\adi_osal_arch_c.sbn", 10654, 169;
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
	.var = .LN_adi_osal_HeapInstall.;
	.var = .LN._adi_osal_HeapInstall..end-.LN_adi_osal_HeapInstall.;
	.var = .LN_adi_osal_MemAlloc.;
	.var = .LN._adi_osal_MemAlloc..end-.LN_adi_osal_MemAlloc.;
	.var = .LN_adi_osal_MemFree.;
	.var = .LN._adi_osal_MemFree..end-.LN_adi_osal_MemFree.;
	.var = .LNadi_osal_ActivateHandler.;
	.var = .LN.adi_osal_ActivateHandler..end-.LNadi_osal_ActivateHandler.;
	.var = .LNadi_osal_DeactivateHandler.;
	.var = .LN.adi_osal_DeactivateHandler..end-.LNadi_osal_DeactivateHandler.;
	.var = .LNadi_osal_UninstallHandler.;
	.var = .LN.adi_osal_UninstallHandler..end-.LNadi_osal_UninstallHandler.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type osal_snHeapIndex.,STT_OBJECT;
	.byte osal_snHeapIndex.[] =
		0xFF,0xFF,0xFF,0xFF;

	.extern _adi_osal_gHandlerTable.;
	.type _adi_osal_gHandlerTable.,STT_OBJECT;
