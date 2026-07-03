	.file "..\system\adi_initialize.c";
//  Compilation time: Thu Oct 24 14:40:12 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\adi_initialize.d -o system\adi_initialize.doj
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

adi_initComponents.:
.LNadi_initComponents.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "..\system\adi_initialize.c":18
	modify(i7,-2) (nw);
.LN0:
// line 19
	dm(-2,i6)=m13;
.LN1:
// line 21
	cjump adi_sec_Init. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
.LN2:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN3:
// line 24
	if ne jump (pc,.P33L2);

.LN4:
// line 25
	cjump adi_SRU_Init. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN5:
	dm(-2,i6)=r0;
.LN6:
// line 26
	jump (pc,.P33L3);

.P33L2:

.P33L3:
.LN7:
// line 28
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_initComponents..end:
.adi_initComponents..end:
	.global adi_initComponents.;
	.type adi_initComponents.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="adi_initComponents.";
	.file_attr Encoding="SW";
	.file_attr Content="Code";
.epctext.end:

	.extern adi_sec_Init.;
	.type adi_sec_Init.,STT_FUNC;
	.extern adi_SRU_Init.;
	.type adi_SRU_Init.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\adi_initialize.sbn", 0, 199;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x85,0x11,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x2E,0x2E,0x5C,0x73,0x79,0x73,0x74,0x65,0x6D,0x5C,
		0x61,0x64,0x69,0x5F,0x69,0x6E,0x69,0x74,0x69,0x61,0x6C,0x69,
		0x7A,0x65,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\adi_initialize.sbn", 199, 4392;
	.var = .LNadi_initComponents.;
	.var = .LN.adi_initComponents..end;
	.byte =
		0x01,0xB8,0x04,0x00,0x00,0x01,0x00,0x0D,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.adi_initComponents..end;
	.byte =
		0x0E,0x72,0x65,0x73,0x75,0x6C,0x74,0x00,0x01,0xB8,0x04,0x00,
		0x00,0x02,0x86,0x78;
	.var = .LN0-.LNadi_initComponents.;
	.byte =
		0x00,0x00,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\adi_initialize.sbn", 4591, 1708;
	.var = .LNadi_initComponents.;
	.byte =
		0x04,0x01,0x05,0x01,0x1A,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x0A,0x0A,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x17,0x0B,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x18,0x0A,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.adi_initComponents..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x25,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x89,0x11,0x00,0x00,0x3B,0x11,0x00,0x00,0x61,0x64,0x69,0x5F,
		0x69,0x6E,0x69,0x74,0x43,0x6F,0x6D,0x70,0x6F,0x6E,0x65,0x6E,
		0x74,0x73,0x00,0x00,0x00,0x00,0x00;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x1C,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNadi_initComponents.;
	.var = .LN.adi_initComponents..end-.LNadi_initComponents.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:
