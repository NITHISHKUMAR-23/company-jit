	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\list.c";
//  Compilation time: Thu Oct 24 14:39:58 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\FreeRTOS -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\FreeRTOS\list.d -o system\FreeRTOS\list.doj
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

uxListRemove.:
.LNuxListRemove.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0-r2,i4,i12,acc}
//  Call preserved registers used: {i5}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\list.c":212
	modify(i7,-4) (nw);
	r2=i5;
	dm(-4,i6)=r2;
	dm(-3,i6)=r4;
	i4=r4;
.LN0:
// line 215
	r2=dm(4,i4);
	dm(-2,i6)=r2;
.LN1:
// line 217
	r2=dm(2,i4);
	i4=dm(m6,i4);
	dm(2,i4)=r2;
.LN2:
// line 218
	i4=dm(-3,i6);
	r2=dm(m6,i4);
	i4=dm(2,i4);
	dm(m6,i4)=r2;
.LN3:
// line 224
	i5=dm(-2,i6);
	r1=dm(m6,i5);
	r2=dm(-3,i6);
	comp(r1,r2);
	if ne jump (pc,.P33L2);

	i4=r2;
.LN4:
// line 226
	r2=dm(2,i4);
	dm(m6,i5)=r2;
.LN5:
// line 227
	jump (pc,.P33L3);

.P33L2:

.P33L3:
.LN6:
// line 233
	i4=dm(-3,i6);
	dm(4,i4)=m13;
.LN7:
// line 234
	i4=dm(-2,i6);
	r2=dm(i4,m5);
	r2=r2-1;
	dm(i4,m5)=r2;
.LN8:
// line 236
	i4=dm(-2,i6);
	r0=dm(i4,m5);
	i5=dm(-4,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.uxListRemove..end:
.uxListRemove..end:
	.global uxListRemove.;
	.type uxListRemove.,STT_FUNC;

vListInsert.:
.LNvListInsert.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,i4,i12,acc}
//  Call preserved registers used: {i5}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\list.c":142
	modify(i7,-6) (nw);
	r2=i5;
	dm(-6,i6)=r2;
	dm(-4,i6)=r8;
	i4=r8;
	dm(-5,i6)=r4;
.LN9:
// line 144
	r2=dm(i4,m5);
	dm(-2,i6)=r2;
	r1=m7;
	comp(r2,r1);
.LN10:
// line 160
	if ne jump (pc,.P34L2);

	i4=r4;
.LN11:
// line 162
	r2=dm(4,i4);
	dm(-3,i6)=r2;
.LN12:
// line 163
	jump (pc,.P34L3);

.P34L2:
	i12=r4;
.LN13:
// line 191
	i12=modify(i12,8);
	dm(-3,i6)=i12;

.P34L4:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\list.c" line 191 col 9
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 19 
//   cycles (includes 10 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used   8 out of   19 ( 42.1%)
//     pm dag                          used   7 out of   19 ( 36.8%)
//     shift immediate                 used   7 out of   19 ( 36.8%)
//     memory access                   used   8 out of   38 ( 21.1%)
//     multifunction alu               used   4 out of   19 ( 21.1%)
//     multifunction float multiply    used   4 out of   19 ( 21.1%)
//     multifunction integer add sub   used   4 out of   19 ( 21.1%)
//     multifunction integer multiply  used   4 out of   19 ( 21.1%)
//     multifunction mult              used   4 out of   19 ( 21.1%)
//-------------------------------------------------------------------
	// -- 2 stalls --
	i4=dm(-3,i6);
	// -- 4 stalls --
	i5=dm(m6,i4);
	// -- 4 stalls --
	r2=dm(i5,m5);
	r1=dm(-2,i6);
	compu(r1,r2);
	if lt jump (pc,.P34L6);

.LN14:
	r2=dm(m6,i4);
	dm(-3,i6)=r2;
	jump (pc,.P34L4);
//-------------------------------------------------------------------
//   End Loop L4
//-------------------------------------------------------------------

.P34L6:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------

.P34L3:
.LN15:
// line 198
	i4=dm(-3,i6);
	r2=dm(m6,i4);
	i4=dm(-4,i6);
	dm(m6,i4)=r2;
.LN16:
// line 199
	r2=dm(-4,i6);
	i4=r2;
	i4=dm(m6,i4);
	dm(2,i4)=r2;
.LN17:
// line 200
	r2=dm(-3,i6);
	i4=dm(-4,i6);
	dm(2,i4)=r2;
.LN18:
// line 201
	r2=dm(-4,i6);
	i4=dm(-3,i6);
	dm(m6,i4)=r2;
.LN19:
// line 205
	r2=dm(-5,i6);
	i4=dm(-4,i6);
	dm(4,i4)=r2;
.LN20:
// line 207
	i4=dm(-5,i6);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN21:
// line 208
	i5=dm(-6,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vListInsert..end:
.vListInsert..end:
	.global vListInsert.;
	.type vListInsert.,STT_FUNC;

vListInsertEnd.:
.LNvListInsertEnd.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r2,i4,i12,acc}
//  Call preserved registers used: {i5}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\list.c":112
	modify(i7,-4) (nw);
	r2=i5;
	dm(-5,i6)=r2;
	i4=r4;
	dm(-3,i6)=r8;
	i5=r8;
	dm(-4,i6)=r4;
.LN22:
// line 113
	r2=dm(m6,i4);
	dm(-2,i6)=r2;
.LN23:
// line 124
	dm(m6,i5)=r2;
.LN24:
// line 125
	i4=dm(-2,i6);
	r2=dm(2,i4);
	i4=dm(-3,i6);
	dm(2,i4)=r2;
.LN25:
// line 130
	r2=dm(-3,i6);
	i4=dm(-2,i6);
	i4=dm(2,i4);
	dm(m6,i4)=r2;
.LN26:
// line 131
	r2=dm(-3,i6);
	i4=dm(-2,i6);
	dm(2,i4)=r2;
.LN27:
// line 134
	r2=dm(-4,i6);
	i4=dm(-3,i6);
	dm(4,i4)=r2;
.LN28:
// line 136
	i4=dm(-4,i6);
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN29:
// line 137
	i5=dm(-5,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vListInsertEnd..end:
.vListInsertEnd..end:
	.global vListInsertEnd.;
	.type vListInsertEnd.,STT_FUNC;

vListInitialiseItem.:
.LNvListInitialiseItem.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {i4,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\list.c":99
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;
	i4=r4;
.LN30:
// line 101
	dm(4,i4)=m13;
.LN31:
// line 107
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vListInitialiseItem..end:
.vListInitialiseItem..end:
	.global vListInitialiseItem.;
	.type vListInitialiseItem.,STT_FUNC;

vListInitialise.:
.LNvListInitialise.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,i4,i12,acc}
//  Call preserved registers used: {i5}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\list.c":63
	modify(i7,-2) (nw);
	r2=i5;
	dm(-3,i6)=r2;
	dm(-2,i6)=r4;
	i4=r4;
.LN32:
// line 67
	r2=8;
	r2=r4+r2;
	dm(m6,i4)=r2;
.LN33:
// line 73
	i4=dm(-2,i6);
	dm(2,i4)=m15;
.LN34:
// line 77
	i5=dm(-2,i6);
	i4=modify(i5,8);
	r2=i4;
	dm(3,i5)=r2;
.LN35:
// line 78
	i5=dm(-2,i6);
	i4=modify(i5,8);
	r2=i4;
	dm(4,i5)=r2;
.LN36:
// line 89
	i4=dm(-2,i6);
	dm(m5,i4)=m13;
.LN37:
// line 95
	i5=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vListInitialise..end:
.vListInitialise..end:
	.global vListInitialise.;
	.type vListInitialise.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="uxListRemove.";
	.file_attr FuncName="vListInsert.";
	.file_attr FuncName="vListInsertEnd.";
	.file_attr FuncName="vListInitialiseItem.";
	.file_attr FuncName="vListInitialise.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr Encoding="SW";
	.file_attr Content="Code";
.epctext.end:

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\FreeRTOS\list.sbn", 0, 298;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x3D,0x18,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x6C,0x69,0x73,0x74,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\FreeRTOS\list.sbn", 298, 5659;
	.var = .LNuxListRemove.;
	.var = .LN.uxListRemove..end;
	.byte =
		0x01,0x79,0x0D,0x00,0x00,0x01,0x00,0x13,0x70,0x78,0x49,0x74,
		0x65,0x6D,0x54,0x6F,0x52,0x65,0x6D,0x6F,0x76,0x65,0x00,0xB9,
		0x16,0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.uxListRemove..end;
	.byte =
		0x15,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0x01,0xB4,0x16,0x00,
		0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x0A,
		0x00,0x38,0x16,0x00,0x00,0x11,0xAE,0x16,0x00,0x00,0x11,0x8C,
		0x15,0x00,0x00,0x16,0x4A,0x17,0x00,0x00,0x76,0x4C,0x69,0x73,
		0x74,0x49,0x6E,0x73,0x65,0x72,0x74,0x00,0x01;
	.var = .LNvListInsert.;
	.var = .LN.vListInsert..end;
	.byte =
		0x01,0x01,0x00,0x13,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0xB4,
		0x16,0x00,0x00,0x02,0x86,0x6C,0x00,0x13,0x70,0x78,0x4E,0x65,
		0x77,0x4C,0x69,0x73,0x74,0x49,0x74,0x65,0x6D,0x00,0xB9,0x16,
		0x00,0x00,0x02,0x86,0x70,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN9;
	.var = .LN.vListInsert..end;
	.byte =
		0x15,0x70,0x78,0x49,0x74,0x65,0x72,0x61,0x74,0x6F,0x72,0x00,
		0x01,0x8C,0x15,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,
		0x00,0x15,0x78,0x56,0x61,0x6C,0x75,0x65,0x4F,0x66,0x49,0x6E,
		0x73,0x65,0x72,0x74,0x69,0x6F,0x6E,0x00,0x01,0x4A,0x17,0x00,
		0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x11,
		0x8B,0x0D,0x00,0x00,0x16,0xBB,0x17,0x00,0x00,0x76,0x4C,0x69,
		0x73,0x74,0x49,0x6E,0x73,0x65,0x72,0x74,0x45,0x6E,0x64,0x00,
		0x01;
	.var = .LNvListInsertEnd.;
	.var = .LN.vListInsertEnd..end;
	.byte =
		0x01,0x01,0x00,0x13,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0xB4,
		0x16,0x00,0x00,0x02,0x86,0x70,0x00,0x13,0x70,0x78,0x4E,0x65,
		0x77,0x4C,0x69,0x73,0x74,0x49,0x74,0x65,0x6D,0x00,0xB9,0x16,
		0x00,0x00,0x02,0x86,0x74,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN22;
	.var = .LN.vListInsertEnd..end;
	.byte =
		0x15,0x70,0x78,0x49,0x6E,0x64,0x65,0x78,0x00,0x01,0xB9,0x16,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x16,0xFF,0x17,0x00,0x00,0x76,0x4C,0x69,0x73,0x74,0x49,0x6E,
		0x69,0x74,0x69,0x61,0x6C,0x69,0x73,0x65,0x49,0x74,0x65,0x6D,
		0x00,0x01;
	.var = .LNvListInitialiseItem.;
	.var = .LN.vListInitialiseItem..end;
	.byte =
		0x01,0x01,0x00,0x13,0x70,0x78,0x49,0x74,0x65,0x6D,0x00,0xB9,
		0x16,0x00,0x00,0x02,0x86,0x78,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN30;
	.var = .LN.vListInitialiseItem..end;
	.byte =
		0x00,0x00,0x16,0x3F,0x18,0x00,0x00,0x76,0x4C,0x69,0x73,0x74,
		0x49,0x6E,0x69,0x74,0x69,0x61,0x6C,0x69,0x73,0x65,0x00,0x01;
	.var = .LNvListInitialise.;
	.var = .LN.vListInitialise..end;
	.byte =
		0x01,0x01,0x00,0x13,0x70,0x78,0x4C,0x69,0x73,0x74,0x00,0xB4,
		0x16,0x00,0x00,0x02,0x86,0x78,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN32;
	.var = .LN.vListInitialise..end;
	.byte =
		0x00,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\FreeRTOS\list.sbn", 5957, 2002;
	.var = .LNuxListRemove.;
	.byte =
		0x04,0x01,0x05,0x01,0xDC,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x1B,0x0C,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.uxListRemove..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvListInsert.;
	.byte =
		0x04,0x01,0x05,0x01,0x96,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x28,0x0B,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x05,0x19,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x09,0x25,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x78,0x01,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x05,0x10,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vListInsert..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvListInsertEnd.;
	.byte =
		0x04,0x01,0x05,0x01,0x78,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x20,0x0A,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x05,0x05,0x14,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vListInsertEnd..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvListInitialiseItem.;
	.byte =
		0x04,0x01,0x05,0x01,0x6B,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x05,0x01,0x0F,0x00,0x05,0x02;
	.var = .LN.vListInitialiseItem..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvListInitialise.;
	.byte =
		0x04,0x01,0x05,0x01,0x47,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x14,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x05,0x01,0x0F,0x00,0x05,0x02;
	.var = .LN.vListInitialise..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x6E,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x41,0x18,0x00,0x00,0x50,0x16,0x00,0x00,0x75,0x78,0x4C,0x69,
		0x73,0x74,0x52,0x65,0x6D,0x6F,0x76,0x65,0x00,0xBE,0x16,0x00,
		0x00,0x76,0x4C,0x69,0x73,0x74,0x49,0x6E,0x73,0x65,0x72,0x74,
		0x00,0x4F,0x17,0x00,0x00,0x76,0x4C,0x69,0x73,0x74,0x49,0x6E,
		0x73,0x65,0x72,0x74,0x45,0x6E,0x64,0x00,0xBB,0x17,0x00,0x00,
		0x76,0x4C,0x69,0x73,0x74,0x49,0x6E,0x69,0x74,0x69,0x61,0x6C,
		0x69,0x73,0x65,0x49,0x74,0x65,0x6D,0x00,0xFF,0x17,0x00,0x00,
		0x76,0x4C,0x69,0x73,0x74,0x49,0x6E,0x69,0x74,0x69,0x61,0x6C,
		0x69,0x73,0x65,0x00,0x00,0x00,0x00,0x00;
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
	.var = .LNuxListRemove.;
	.var = .LN.uxListRemove..end-.LNuxListRemove.;
	.var = .LNvListInsert.;
	.var = .LN.vListInsert..end-.LNvListInsert.;
	.var = .LNvListInsertEnd.;
	.var = .LN.vListInsertEnd..end-.LNvListInsertEnd.;
	.var = .LNvListInitialiseItem.;
	.var = .LN.vListInitialiseItem..end-.LNvListInitialiseItem.;
	.var = .LNvListInitialise.;
	.var = .LN.vListInitialise..end-.LNvListInitialise.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:
