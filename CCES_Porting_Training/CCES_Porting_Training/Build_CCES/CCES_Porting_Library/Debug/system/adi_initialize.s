	.file "..\system\adi_initialize.c";
//  Compilation time: Fri Feb 21 14:03:30 2025
//  Compiler options: -c -file-attr ProjectName=CCES_Porting_Library -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -save-temps -path-output .\system -DCORE0 -D_DEBUG -I../../../CCES_Porting_Training/Porting_Library/Files -ID:/CCES_Porting_Training/Build_CCES/CCES_Porting_Library/system -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\adi_initialize.d -o system\adi_initialize.doj
//  Compiler version: 9.0.2.0 (299b81854d4c0869dabfda91e6ab288ec8ec3f47)
//  Architecture: ADSP-21569
//  Silicon revision: 0.0
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
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,r2,i12,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r1,r4,r8,r12,s0-s15,i4,i6-i7,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN0:
// line "..\system\adi_initialize.c":22
	cjump adi_sec_Init. (db);
	dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ0-1;
.LCJ0:

	r2=leftz r0;
.LN1:
// line 25
	if sv jump (pc,.P33L1);

.P33L3:
	r2=leftz r0;
.LN2:
// line 29
	if sv jump (pc,.P33L4);

.LN3:
// line 33
	i12=dm(m7,i6);
	// -- 7 stalls --
	jump (m14,i12) (db);
	rframe;
	nop;

.P33L4:
.LN4:
// line 30
	cjump adi_SRU_Init. (db);
	dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ1-1;
.LCJ1:

.LN5:
// line 33
	i12=dm(m7,i6);
	// -- 7 stalls --
	jump (m14,i12) (db);
	rframe;
	nop;

.P33L1:
.LN6:
// line 26
	cjump adi_initpinmux. (db);
	dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ2-1;
.LCJ2:

	jump (pc,.P33L3);
.LN.adi_initComponents..end:
.adi_initComponents..end:
	.global adi_initComponents.;
	.type adi_initComponents.,STT_FUNC;

	.file_attr ProjectName="CCES_Porting_Library";
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
	.extern adi_initpinmux.;
	.type adi_initpinmux.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\adi_initialize.sbn", 0, 182;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x4B,0x11,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x2E,0x2E,0x5C,0x73,0x79,0x73,0x74,0x65,0x6D,0x5C,
		0x61,0x64,0x69,0x5F,0x69,0x6E,0x69,0x74,0x69,0x61,0x6C,0x69,
		0x7A,0x65,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\adi_initialize.sbn", 182, 4355;
	.var = .LNadi_initComponents.;
	.var = .LN.adi_initComponents..end;
	.byte =
		0x01,0x93,0x04,0x00,0x00,0x01,0x00,0x0D,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.adi_initComponents..end;
	.byte =
		0x00,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\adi_initialize.sbn", 4537, 922;
	.var = .LNadi_initComponents.;
	.byte =
		0x04,0x01,0x05,0x01,0x1B,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x17,0x0C,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x18,0x03,0x7D,0x01,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x1A,0x03,0x79,0x01,0x00,0x05,0x02;
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
		0x4F,0x11,0x00,0x00,0x16,0x11,0x00,0x00,0x61,0x64,0x69,0x5F,
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
