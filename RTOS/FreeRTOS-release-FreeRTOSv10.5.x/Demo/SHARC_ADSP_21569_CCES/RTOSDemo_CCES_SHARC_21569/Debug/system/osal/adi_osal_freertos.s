	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos.c";
//  Compilation time: Thu Oct 24 14:39:47 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\osal -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\osal\adi_osal_freertos.d -o system\osal\adi_osal_freertos.doj
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

adi_osal_GetVersion.:
.LNadi_osal_GetVersion.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,i4,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos.c":116
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;
	i4=r4;
.LN0:
// line 117
	dm(m5,i4)=m14;
.LN1:
// line 118
	i4=dm(-2,i6);
	i12=2;
	dm(m6,i4)=i12;
.LN2:
// line 119
	i4=dm(-2,i6);
	dm(2,i4)=m13;
.LN3:
// line 120
	i4=dm(-2,i6);
	dm(3,i4)=m13;
.LN4:
// line 121
	r0=m5;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_GetVersion..end:
.adi_osal_GetVersion..end:
	.global adi_osal_GetVersion.;
	.type adi_osal_GetVersion.,STT_FUNC;

adi_osal_Config.:
.LNadi_osal_Config.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,i4,i12,acc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos.c":151
	modify(i7,-6) (nw);
	dm(-6,i6)=r15;
	dm(-5,i6)=r4;
.LN5:
// line 152
	dm(-4,i6)=m13;
.LN6:
// line 153
	dm(-3,i6)=m13;
.LN7:
// line 166
	cjump check_osversion. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
	r2=2066;
	compu(r0,r2);
.LN8:
	if ge jump (pc,.P37L2);

.LN9:
// line 168
	i12=25;
	dm(-2,i6)=i12;
	jump (pc,.P37L4);

.P37L2:
.LN10:
// line 176
	r2=dm(snOsalConfigurationState.0.);
	r15=44304;
	comp(r2,r15);
	if ne jump (pc,.P37L7);

.LN11:
// line 178
	r2=dm(-5,i6);
	r2=pass r2;
	if ne jump (pc,.P37L10);

.LN12:
// line 180
	dm(-2,i6)=m13;
	jump (pc,.P37L4);

.P37L10:
	i4=r2;
.LN13:
// line 184
	r2=dm(m6,i4);
	r1=dm(_adi_osal_gnNumSlots.);
	comp(r2,r1);
	if ne jump (pc,.P37L13);

	r2=dm(2,i4);
	r1=dm(_adi_osal_gnTickPeriod.);
	comp(r2,r1);
	if ne jump (pc,.P37L13);

	r2=dm(3,i4);
	r1=dm(-4,i6);
	comp(r2,r1);
	if ne jump (pc,.P37L13);

	r2=dm(4,i4);
	r1=dm(-3,i6);
	comp(r2,r1);
	if eq jump (pc,.P37L14);

.P37L13:
.LN14:
// line 189
	dm(-2,i6)=m14;
	jump (pc,.P37L4);

.P37L14:
.LN15:
// line 193
	dm(-2,i6)=m13;
	jump (pc,.P37L4);

.P37L7:
.LN16:
// line 200
	r2=dm(-5,i6);
	r2=pass r2;
	if eq jump (pc,.P37L22);

	i4=r2;
.LN17:
// line 203
	r2=dm(i4,m5);
	r2=pass r2;
	if eq jump (pc,.P37L25);

	r1=m6;
	r2=btgl r2 by r1;
	if sz jump (pc,.P37L25);

.LN18:
// line 207
	i12=9;
	dm(-2,i6)=i12;
	jump (pc,.P37L4);

.P37L25:
.LN19:
// line 210
	r2=dm(m6,i4);
	r1=m6;
	compu(r2,r1);
	if le jump (pc,.P37L30);

.LN20:
// line 212
	i12=11;
	dm(-2,i6)=i12;
	jump (pc,.P37L4);

.P37L30:
.LN21:
// line 216
	r2=dm(2,i4);
	r2=pass r2;
	if ne jump (pc,.P37L34);

.LN22:
// line 219
	i4=1000;
	dm(_adi_osal_gnTickPeriod.)=i4;
.LN23:
// line 220
	jump (pc,.P37L35);

.P37L34:
.LN24:
// line 223
	dm(_adi_osal_gnTickPeriod.)=r2;

.P37L35:
.LN25:
// line 225
	i4=dm(-5,i6);
	r2=dm(m6,i4);
	dm(_adi_osal_gnNumSlots.)=r2;
.LN26:
// line 227
	r2=dm(3,i4);
	dm(-4,i6)=r2;
.LN27:
// line 228
	r2=dm(4,i4);
	dm(-3,i6)=r2;
.LN28:
// line 230
	jump (pc,.P37L23);

.P37L22:

.P37L23:
.LN29:
// line 236
	r4=dm(-4,i6);
	r2=pass r4;
	if eq jump (pc,.P37L37);

	r2=dm(-3,i6);
	r2=pass r2;
	if ne jump (pc,.P37L37);

.LN30:
// line 238
	i12=34;
	dm(-2,i6)=i12;
	jump (pc,.P37L4);

.P37L37:
.LN31:
// line 241
	r8=dm(-3,i6);
.LN32:
	cjump _adi_osal_HeapInstall. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
	r2=pass r0;
.LN33:
	if eq jump (pc,.P37L42);

.LN34:
// line 243
	i12=23;
	dm(-2,i6)=i12;
	jump (pc,.P37L4);

.P37L42:
	i4=r15;
.LN35:
// line 248
	dm(snOsalConfigurationState.0.)=i4;
.LN36:
// line 251
	dm(-2,i6)=m13;

.P37L4:
.LN37:
// line 252
	r0=dm(-2,i6);
	r15=dm(-6,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_Config..end:
.adi_osal_Config..end:
	.global adi_osal_Config.;
	.type adi_osal_Config.,STT_FUNC;

check_osversion.:
.LNcheck_osversion.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\osal_freertos.h":254
	r0=2641;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.check_osversion..end:
.check_osversion..end:
	.type check_osversion.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="adi_osal_GetVersion.";
	.file_attr FuncName="check_osversion.";
	.file_attr FuncName="_adi_osal_IsMemoryAligned.";
	.file_attr FuncName="_adi_osal_IsCurrentLevelISR.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr FuncName="adi_osal_Config.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern _adi_osal_HeapInstall.;
	.type _adi_osal_HeapInstall.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\osal\adi_osal_freertos.sbn", 0, 288;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0xD5,0x28,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x70,0x6F,0x72,0x74,0x61,0x62,0x6C,0x65,0x5C,0x43,
		0x43,0x45,0x53,0x5C,0x6F,0x73,0x61,0x6C,0x5C,0x61,0x64,0x69,
		0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x66,0x72,0x65,0x65,0x72,0x74,
		0x6F,0x73,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\osal\adi_osal_freertos.sbn", 288, 9984;
	.var = .LNadi_osal_GetVersion.;
	.var = .LN.adi_osal_GetVersion..end;
	.byte =
		0x01,0x8F,0x1A,0x00,0x00,0x01,0x00,0x14,0x70,0x56,0x65,0x72,
		0x73,0x69,0x6F,0x6E,0x00,0x98,0x27,0x00,0x00,0x02,0x86,0x78,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.adi_osal_GetVersion..end;
	.byte =
		0x00,0x00,0x0C,0x00,0x79,0x1F,0x00,0x00,0x13,0x45,0x28,0x00,
		0x00,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x43,0x6F,
		0x6E,0x66,0x69,0x67,0x00,0x01;
	.var = .LNadi_osal_Config.;
	.var = .LN.adi_osal_Config..end;
	.byte =
		0x01,0x8F,0x1A,0x00,0x00,0x01,0x00,0x14,0x70,0x43,0x6F,0x6E,
		0x66,0x69,0x67,0x00,0x50,0x28,0x00,0x00,0x02,0x86,0x6C,0x00,
		0x15,0x00,0x00,0x00,0x00;
	.var = .LN5;
	.var = .LN.adi_osal_Config..end;
	.byte =
		0x16,0x73,0x6E,0x4F,0x73,0x61,0x6C,0x43,0x6F,0x6E,0x66,0x69,
		0x67,0x75,0x72,0x61,0x74,0x69,0x6F,0x6E,0x53,0x74,0x61,0x74,
		0x65,0x00,0x01,0xC3,0x07,0x00,0x00,0x05,0x03;
	.var = snOsalConfigurationState.0.;
	.var = .LN6-.LNadi_osal_Config.;
	.byte =
		0x00,0x16,0x70,0x48,0x65,0x61,0x70,0x4D,0x65,0x6D,0x6F,0x72,
		0x79,0x00,0x01,0x45,0x28,0x00,0x00,0x02,0x86,0x70;
	.var = .LN5-.LNadi_osal_Config.;
	.byte =
		0x00,0x16,0x6E,0x48,0x65,0x61,0x70,0x4D,0x65,0x6D,0x6F,0x72,
		0x79,0x53,0x69,0x7A,0x65,0x00,0x01,0xC3,0x07,0x00,0x00,0x02,
		0x86,0x74;
	.var = .LN6-.LNadi_osal_Config.;
	.byte =
		0x00,0x00,0x00,0x0C,0x00,0xC3,0x07,0x00,0x00,0x11,0x73,0x1D,
		0x00,0x00,0x0C,0x00,0x4B,0x28,0x00,0x00,0x13,0x8A,0x28,0x00,
		0x00,0x63,0x68,0x65,0x63,0x6B,0x5F,0x6F,0x73,0x76,0x65,0x72,
		0x73,0x69,0x6F,0x6E,0x00,0x01;
	.var = .LNcheck_osversion.;
	.var = .LN.check_osversion..end;
	.byte =
		0x01,0xC3,0x07,0x00,0x00,0x00,0x02,0x15,0x00,0x00,0x00,0x00;
	.var = .LNcheck_osversion.;
	.var = .LN.check_osversion..end;
	.byte =
		0x00,0x00,0x16,0x5F,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,
		0x5F,0x67,0x6E,0x4E,0x75,0x6D,0x53,0x6C,0x6F,0x74,0x73,0x00,
		0x01,0xC3,0x07,0x00,0x00,0x05,0x03;
	.var = _adi_osal_gnNumSlots.;
	.byte =
		0x00,0x00,0x00,0x00,0x01,0x16,0x5F,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x67,0x6E,0x54,0x69,0x63,0x6B,0x50,0x65,
		0x72,0x69,0x6F,0x64,0x00,0x01,0xC3,0x07,0x00,0x00,0x05,0x03;
	.var = _adi_osal_gnTickPeriod.;
	.byte =
		0x00,0x00,0x00,0x00,0x01,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\osal\adi_osal_freertos.sbn", 10272, 2374;
	.var = .LNadi_osal_GetVersion.;
	.byte =
		0x04,0x01,0x05,0x01,0x7C,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_GetVersion..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_Config.;
	.byte =
		0x04,0x01,0x05,0x01,0x9F,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x0F,0x0A,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x0E,0x0A,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x09,0x16,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x05,0x11,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x11,0x0E,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x0D,0x0B,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x09,0x0D,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x32,0x01,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x04,0x0E,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_Config..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNcheck_osversion.;
	.byte =
		0x04,0x29,0x05,0x18,0x03,0xFD,0x01,0x01,0x00,0x05,0x02;
	.var = .LN.check_osversion..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x3A,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0xD9,0x28,0x00,0x00,0x4E,0x27,0x00,0x00,0x61,0x64,0x69,0x5F,
		0x6F,0x73,0x61,0x6C,0x5F,0x47,0x65,0x74,0x56,0x65,0x72,0x73,
		0x69,0x6F,0x6E,0x00,0x9E,0x27,0x00,0x00,0x61,0x64,0x69,0x5F,
		0x6F,0x73,0x61,0x6C,0x5F,0x43,0x6F,0x6E,0x66,0x69,0x67,0x00,
		0x00,0x00,0x00,0x00;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x2C,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNadi_osal_GetVersion.;
	.var = .LN.adi_osal_GetVersion..end-.LNadi_osal_GetVersion.;
	.var = .LNadi_osal_Config.;
	.var = .LN.adi_osal_Config..end-.LNadi_osal_Config.;
	.var = .LNcheck_osversion.;
	.var = .LN.check_osversion..end-.LNcheck_osversion.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type snOsalConfigurationState.0.,STT_OBJECT;
	.byte snOsalConfigurationState.0.[] =
		0x00,0x00,0x00,0x00;

	.extern _adi_osal_gnNumSlots.;
	.type _adi_osal_gnNumSlots.,STT_OBJECT;
	.extern _adi_osal_gnTickPeriod.;
	.type _adi_osal_gnTickPeriod.,STT_OBJECT;
