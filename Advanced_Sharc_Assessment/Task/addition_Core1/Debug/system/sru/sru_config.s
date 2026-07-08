	.file "..\system\sru\sru_config.c";
//  Compilation time: Tue Jul  1 17:59:15 2025
//  Compiler options: -c -file-attr ProjectName=addition_Core1 -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\sru -DCORE1 -D_DEBUG -DADI_MCAPI -ID:/Advanced_Sharc_Assessment/Task/addition_Core1/system -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\sru\sru_config.d -o system\sru\sru_config.doj
//  Compiler version: 8.15.1.0 (61a2eff16741378b1ae40f6392a0806696679a50)
//  Architecture: ADSP-21593
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

adi_SRU_Init.:
.LNadi_SRU_Init.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,i4,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
.LN0:
// line "..\system\sru\sru_config.c":578
	i4=1048575;
	dm(822101648)=i4;
.LN1:
// line 581
	dm(822101652)=i4;
.LN2:
// line 583
	r0=m5;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_SRU_Init..end:
.adi_SRU_Init..end:
	.global adi_SRU_Init.;
	.type adi_SRU_Init.,STT_FUNC;

	.file_attr ProjectName="addition_Core1";
	.file_attr FuncName="adi_SRU_Init.";
	.file_attr Encoding="SW";
	.file_attr Content="Code";
.epctext.end:

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\sru\sru_config.sbn", 0, 160;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x72,0x09,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x2E,0x2E,0x5C,0x73,0x79,0x73,0x74,0x65,0x6D,0x5C,
		0x73,0x72,0x75,0x5C,0x73,0x72,0x75,0x5F,0x63,0x6F,0x6E,0x66,
		0x69,0x67,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\sru\sru_config.sbn", 160, 2346;
	.var = .LNadi_SRU_Init.;
	.var = .LN.adi_SRU_Init..end;
	.byte =
		0x01,0x8C,0x04,0x00,0x00,0x01,0x00,0x0B,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.adi_SRU_Init..end;
	.byte =
		0x00,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\sru\sru_config.sbn", 2506, 794;
	.var = .LNadi_SRU_Init.;
	.byte =
		0x04,0x01,0x05,0x01,0x23,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x05,0x03,0xA7,0x04,0x01,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.adi_SRU_Init..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x1F,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x76,0x09,0x00,0x00,0x43,0x09,0x00,0x00,0x61,0x64,0x69,0x5F,
		0x53,0x52,0x55,0x5F,0x49,0x6E,0x69,0x74,0x00,0x00,0x00,0x00,
		0x00;
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
	.var = .LNadi_SRU_Init.;
	.var = .LN.adi_SRU_Init..end-.LNadi_SRU_Init.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:
