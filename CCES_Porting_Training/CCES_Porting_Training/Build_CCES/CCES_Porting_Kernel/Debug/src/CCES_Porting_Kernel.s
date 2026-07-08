	.file "D:\CCES_Porting_Training\Statistical_Calculations\Files\CCES_Porting_Kernel.c";
//  Compilation time: Fri Feb 21 14:18:39 2025
//  Compiler options: -c -file-attr ProjectName=CCES_Porting_Kernel -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -save-temps -path-output .\src -DCORE0 -DMEAN -DRMS -DVARIANCE -DDEVIATION -D_DEBUG -I../../../CCES_Porting_Training/Statistical_Calculations/Files -I../../../CCES_Porting_Training/Porting_Library/Files -ID:/CCES_Porting_Training/Build_CCES/CCES_Porting_Kernel/system -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo src\CCES_Porting_Kernel.d -o src\CCES_Porting_Kernel.doj
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

main.:
.LNmain.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 48 bytes
//  Scratch registers used: {r0-r2,r4,r8,i4,acc}
//  Call preserved registers used: {r15,i5}
//  Registers that could be clobbered by function calls: {r0-r1,r4,r8,r12,s0-s15,i4,i6-i7,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\CCES_Porting_Training\Statistical_Calculations\Files\CCES_Porting_Kernel.c":11
	modify(i7,-8) (nw);
.LN0:
// line 13
	i5=.static0;
.LN1:
// line 17
	i4=modify(i6,-8) (nw);
.LN2:
// line 13
	r2=dm(i5,m6);
.LN3:
// line 17
	r15=i4;
.LN4:
// line 13
	r4=pass r15, r1=dm(i5,m6);
	dm(i4,m6)=r2;
	dm(i4,m6)=r1;
	r0=dm(i5,m6);
	r2=dm(i5,m6);
	dm(i4,m6)=r0;
	dm(i4,m6)=r2;
	r2=dm(i5,m6);
	dm(i4,m6)=r2;
.LN5:
// line 17
	r8=5;
	cjump calculateMean. (db);
	dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ0-1;
.LCJ0:

.LN6:
// line 18
	dm(i7,m7)=r0;
	r2=.sMeanf.0;
	dm(i7,m7)=r2;
	cjump _printf32. (db);
	dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ1-1;
.LCJ1:

	modify(i7,2) (nw);
.LN7:
// line 22
	r8=5;
	cjump calculateRMS. (db);
	r4=pass r15, dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ2-1;
.LCJ2:

.LN8:
// line 23
	dm(i7,m7)=r0;
	r2=.sRMSf.1;
	dm(i7,m7)=r2;
	cjump _printf32. (db);
	dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ3-1;
.LCJ3:

	modify(i7,2) (nw);
.LN9:
// line 27
	r8=5;
	cjump calculateVariance. (db);
	r4=pass r15, dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ4-1;
.LCJ4:

.LN10:
// line 28
	dm(i7,m7)=r0;
	r2=.sVarian.2;
	dm(i7,m7)=r2;
	cjump _printf32. (db);
	dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ5-1;
.LCJ5:

	modify(i7,2) (nw);
.LN11:
// line 32
	r8=5;
	cjump calculateStandardDeviation. (db);
	r4=pass r15, dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ6-1;
.LCJ6:

.LN12:
// line 33
	dm(i7,m7)=r0;
	r2=.sStanda.3;
	dm(i7,m7)=r2;
	cjump _printf32. (db);
	dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ7-1;
.LCJ7:

.LN13:
// line 37
	r4=m5;
	.extern exit.; jump (pc,exit.) (db); i7=modify(i6,-2) (nw); nop;
.LN.main..end:
.main..end:
	.global main.;
	.type main.,STT_FUNC;

	.file_attr ProjectName="CCES_Porting_Kernel";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr FuncName="main.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern calculateMean.;
	.type calculateMean.,STT_FUNC;
	.extern _printf32.;
	.type _printf32.,STT_FUNC;
	.extern calculateRMS.;
	.type calculateRMS.,STT_FUNC;
	.extern calculateVariance.;
	.type calculateVariance.,STT_FUNC;
	.extern calculateStandardDeviation.;
	.type calculateStandardDeviation.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\src\CCES_Porting_Kernel.sbn", 0, 241;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x5E,0x0C,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x43,0x43,0x45,0x53,0x5F,0x50,0x6F,
		0x72,0x74,0x69,0x6E,0x67,0x5F,0x54,0x72,0x61,0x69,0x6E,0x69,
		0x6E,0x67,0x5C,0x53,0x74,0x61,0x74,0x69,0x73,0x74,0x69,0x63,
		0x61,0x6C,0x5F,0x43,0x61,0x6C,0x63,0x75,0x6C,0x61,0x74,0x69,
		0x6F,0x6E,0x73,0x5C,0x46,0x69,0x6C,0x65,0x73,0x5C,0x43,0x43,
		0x45,0x53,0x5F,0x50,0x6F,0x72,0x74,0x69,0x6E,0x67,0x5F,0x4B,
		0x65,0x72,0x6E,0x65,0x6C,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\src\CCES_Porting_Kernel.sbn", 241, 3010;
	.var = .LNmain.;
	.var = .LN.main..end;
	.byte =
		0x01,0x2B,0x02,0x00,0x00,0x01,0x00,0x11,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.main..end;
	.byte =
		0x12,0x64,0x61,0x74,0x61,0x00,0x01,0x52,0x0C,0x00,0x00,0x02,
		0x86,0x60;
	.var = .LN4-.LNmain.;
	.byte =
		0x00,0x00,0x00,0x08,0x60,0x0C,0x00,0x00,0x4F,0x03,0x00,0x00,
		0x09,0x05,0x00,0x04,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\src\CCES_Porting_Kernel.sbn", 3251, 957;
	.var = .LNmain.;
	.byte =
		0x04,0x01,0x05,0x01,0x13,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x0B,0x0B,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x1F,0x0D,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x0B,0x03,0x7C,0x01,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x1F,0x0D,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x0B,0x03,0x7C,0x01,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x1F,0x0D,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x0B,0x0A,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x1D,0x0D,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x0B,0x0A,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x27,0x0D,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x0B,0x0A,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x2E,0x0D,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x0B,0x0A,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x02,0x0D,0x00,0x05,0x02;
	.var = .LN.main..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x17,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x62,0x0C,0x00,0x00,0x16,0x0C,0x00,0x00,0x6D,0x61,0x69,0x6E,
		0x00,0x00,0x00,0x00,0x00;
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
	.var = .LNmain.;
	.var = .LN.main..end-.LNmain.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 8;
	.type .static0,STT_OBJECT;
	.byte .static0[] =
		0x00,0x00,0x80,0x3F,0x00,0x00,0x00,0x40,0x00,0x00,0x40,0x40,
		0x00,0x00,0x80,0x40,0x00,0x00,0xA0,0x40;
	.align 8;
	.type .sMeanf.0,STT_OBJECT;
	.byte .sMeanf.0[] =
		0x4D,0x65,0x61,0x6E,0x3A,0x20,0x25,0x66,0x0A,0x00;
	.align 8;
	.type .sRMSf.1,STT_OBJECT;
	.byte .sRMSf.1[] =
		0x52,0x4D,0x53,0x3A,0x20,0x25,0x66,0x0A,0x00;
	.align 8;
	.type .sVarian.2,STT_OBJECT;
	.byte .sVarian.2[] =
		0x56,0x61,0x72,0x69,0x61,0x6E,0x63,0x65,0x3A,0x20,0x25,0x66,
		0x0A,0x00;
	.align 8;
	.type .sStanda.3,STT_OBJECT;
	.byte .sStanda.3[] =
		0x53,0x74,0x61,0x6E,0x64,0x61,0x72,0x64,0x20,0x44,0x65,0x76,
		0x69,0x61,0x74,0x69,0x6F,0x6E,0x3A,0x20,0x25,0x66,0x0A,0x00;
