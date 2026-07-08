	.file "D:\CCES_Porting_Training\Porting_Library\Files\CCES_Porting_Library.c";
//  Compilation time: Fri Feb 21 14:03:31 2025
//  Compiler options: -c -file-attr ProjectName=CCES_Porting_Library -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -save-temps -path-output .\src -DCORE0 -D_DEBUG -I../../../CCES_Porting_Training/Porting_Library/Files -ID:/CCES_Porting_Training/Build_CCES/CCES_Porting_Library/system -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo src\CCES_Porting_Library.d -o src\CCES_Porting_Library.doj
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


	.section/SW/DOUBLE32 seg_lib_code_l3;

.epctext:

calculateMean.:
.LNcalculateMean.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,s0-s2,s11-s12,i4,i12,m4,acc,scc,sacc,sscc,lcntr}
//  Call preserved registers used: {r11}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf}
//-------------------------------------------------------------------
// line "D:\CCES_Porting_Training\Porting_Library\Files\CCES_Porting_Library.c":22
	modify(i7,-2) (nw);
.LN0:
// line 24
	r2=pass r8, i4=r4;
	if le jump (pc,.P34L3) (db);
.LN1:
// line 22
	r2=r2-r2, dm(-2,i6)=r11;
	r4=m5;

	r1=r8-1;
	if eq jump (pc,.P34L9);

	r2=lshift r8 by -1;
	s2=r2;

	bit set mode1 0x200000;

	nop;                                    // Inserted to fix anomaly enter_simd. 
	r1=r2-1, r11=m5;
	if eq jump (pc,.P34L20);

.LN2:
// line 25
	m4=4;
	r12=lshift r2 by -1, r1=dm(i4,m4);
	r0=dm(-2,i4);
	r12=r12-1;
	if eq jump (pc,.P34L28);

	lcntr=r12, do (pc,.P34L30_end) until lce;

.P34L30:
//-------------------------------------------------------------------
//   Loop at "D:\CCES_Porting_Training\Porting_Library\Files\CCES_Porting_Library.c" line 24 col 5
//-------------------------------------------------------------------
//   This loop executes 4 iterations of the original loop in estimated 2 
//   cycles.
//-------------------------------------------------------------------
//   Unknown Trip Count
//   Successfully found modulo schedule with:
//     Initiation Interval (II)                                  = 2
//     Stage Count (SC)                                          = 2
//     MVE Unroll Factor                                         = 1
//     Minimum initiation interval due to recurrences (rec MII)  = 2
//     Minimum initiation interval due to resources (res MII)    = 2.00
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used   2 out of    2 (100.0%)
//     multifunction alu               used   2 out of    2 (100.0%)
//     multifunction float multiply    used   2 out of    2 (100.0%)
//     multifunction integer add sub   used   2 out of    2 (100.0%)
//     multifunction integer multiply  used   2 out of    2 (100.0%)
//     multifunction mult              used   2 out of    2 (100.0%)
//     pm dag                          used   2 out of    2 (100.0%)
//     shift immediate                 used   2 out of    2 (100.0%)
//     memory access                   used   2 out of    4 ( 50.0%)
//-------------------------------------------------------------------
//   Loop was vectorized by a factor of 4.
//-------------------------------------------------------------------
//   Vectorization peeled 3 conditional iterations from the back of the loop 
//   because of an unknown trip count, possibly not a multiple of 4.
//   
//   Consider using pragma loop_count to specify the trip count or trip modulo 
//   in order to avoid conditional peeling.
//-------------------------------------------------------------------
	f11=f11+f0, r0=dm(i4,4);
.P34L30_end:
	f1=f1+f0, r0=dm(-2,i4);
	// end loop .P34L30;
//-------------------------------------------------------------------
//   End Kernel for Loop L30
//-------------------------------------------------------------------

.P34L28:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
	f0=f11+f0;
	btst r2 by 0;
	f11=f1+f0;
	if sz jump (pc,.P34L17);

.P34L20:
	r2=dm(i4,2);
	f11=f11+f2;

.P34L17:

	bit clr mode1 0x200000;

	nop;                                    // Inserted to fix anomaly exit_simd. 
	btst r8 by r4, r2=s11;
	f2=f2+f11;
	if sz jump (pc,.P34L7);

.P34L9:
	r1=dm(i4,m5);
	f2=f2+f1;

.P34L7:
	r4=pass r2;

.P34L3:
.LN3:
// line 27
	call (pc,__lib_fdiv.) (db);             // floating-point division is implemented as a library call. 
	f8=float r8, i12=dm(m7,i6);
	r11=dm(-2,i6);

	// -- 5 stalls --
	jump (m14,i12) (db);
	rframe;
	nop;
.LN.calculateMean..end:
.calculateMean..end:
	.global calculateMean.;
	.type calculateMean.,STT_FUNC;

calculateRMS.:
.LNcalculateRMS.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,s0-s2,s11-s12,i4,i12,acc,mcc,scc,sacc,smcc,lcntr}
//  Call preserved registers used: {r11}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i6-i7,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\CCES_Porting_Training\Porting_Library\Files\CCES_Porting_Library.c":13
	modify(i7,-2) (nw);
.LN4:
// line 15
	r2=pass r8, i4=r4;
	if le jump (pc,.P36L3) (db);
.LN5:
// line 13
	r2=r2-r2, dm(-2,i6)=r11;
	r4=m5;

	r1=r8-1;
	if eq jump (pc,.P36L9);

	r2=lshift r8 by -1;
	s2=r2;

	bit set mode1 0x200000;

	nop;                                    // Inserted to fix anomaly enter_simd. 
	r1=r2-1, r2=dm(i4,2);
	f2=f2*f2, r0=m5;
	if eq jump (pc,.P36L21);

.LN6:
// line 16
	r12=r1-1, r1=dm(i4,2);
	f1=f1*f1;
	if eq jump (pc,.P36L23);

	lcntr=r12, do (pc,.P36L25_end) until lce;

.P36L25:
//-------------------------------------------------------------------
//   Loop at "D:\CCES_Porting_Training\Porting_Library\Files\CCES_Porting_Library.c" line 15 col 5
//-------------------------------------------------------------------
//   This loop executes 2 iterations of the original loop in estimated 2 
//   cycles.
//-------------------------------------------------------------------
//   Unknown Trip Count
//   Successfully found modulo schedule with:
//     Initiation Interval (II)                                  = 2
//     Stage Count (SC)                                          = 3
//     MVE Unroll Factor                                         = 1
//     Minimum initiation interval due to recurrences (rec MII)  = 2
//     Minimum initiation interval due to resources (res MII)    = 2.00
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used   2 out of    2 (100.0%)
//     multifunction alu               used   2 out of    2 (100.0%)
//     multifunction float multiply    used   2 out of    2 (100.0%)
//     multifunction integer add sub   used   2 out of    2 (100.0%)
//     multifunction integer multiply  used   2 out of    2 (100.0%)
//     multifunction mult              used   2 out of    2 (100.0%)
//     pm dag                          used   2 out of    2 (100.0%)
//     shift immediate                 used   2 out of    2 (100.0%)
//     memory access                   used   2 out of    4 ( 50.0%)
//-------------------------------------------------------------------
//   Loop was vectorized by a factor of 2.
//-------------------------------------------------------------------
//   Vectorization peeled 1 conditional iteration from the back of the loop 
//   because of an unknown trip count, possibly not a multiple of 2.
//   
//   Consider using pragma loop_count to specify the trip count or trip modulo 
//   in order to avoid conditional peeling.
//-------------------------------------------------------------------
	f0=f0+f2, r2=dm(i4,2);
.P36L25_end:
	f1=f2*f2, r2=r1;
	// end loop .P36L25;
//-------------------------------------------------------------------
//   End Kernel for Loop L25
//-------------------------------------------------------------------

.P36L23:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
	f0=f0+f2, r2=r1;

.P36L21:
	f11=f0+f2;

	bit clr mode1 0x200000;

	nop;                                    // Inserted to fix anomaly exit_simd. 
	btst r8 by r4, r2=s11;
	f2=f2+f11;
	if sz jump (pc,.P36L7);

.P36L9:
	r1=dm(i4,m5);
	f1=f1*f1;
	// -- stall --
	f2=f2+f1;

.P36L7:
	r4=pass r2;

.P36L3:
	// -- stall --
.LN7:
// line 18
	call (pc,__lib_fdiv.) (db);             // floating-point division is implemented as a library call. 
	f8=float r8, r11=dm(-2,i6);
	nop;

.LN8:
	cjump sqrtf. (db);
	r4=pass r0, dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ0-1;
.LCJ0:

.LN9:
	i12=dm(m7,i6);
	// -- 7 stalls --
	jump (m14,i12) (db);
	rframe;
	nop;
.LN.calculateRMS..end:
.calculateRMS..end:
	.global calculateRMS.;
	.type calculateRMS.,STT_FUNC;

calculateVariance.:
.LNcalculateVariance.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,s0-s2,s8,s12,i12,acc,mcc,scc,sacc,smcc,lcntr}
//  Call preserved registers used: {r14-r15,i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s2,s11-s12,i4,i6-i7,i12,m4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,lcntr}
//-------------------------------------------------------------------
// line "D:\CCES_Porting_Training\Porting_Library\Files\CCES_Porting_Library.c":31
	modify(i7,-4) (nw);
	r2=i5;
	r14=r14-r14, dm(-4,i6)=r14;
	dm(-3,i6)=r15;
	dm(-2,i6)=r2;
	i5=r4;
.LN10:
// line 32
	cjump calculateMean. (db);
	r15=pass r8, dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ1-1;
.LCJ1:

.LN11:
// line 34
	r2=pass r15, r12=r0;
	if le jump (pc,.P38L3);

	r2=r2-r2;
	r1=r15-1;
	if eq jump (pc,.P38L9);

	r2=m7;
	r2=lshift r15 by r2, s12=r12;
	s2=r2;

	bit set mode1 0x200000;

.LN12:
// line 35
	nop;                                    // Inserted to fix anomaly enter_simd. 
	r2=r2-1;
	if eq jump (pc,.P38L21) (db);
	r1=r1-r1, r0=dm(i5,2);
	f0=f0-f12;

	lcntr=r2, do (pc,.P38L23_end) until lce;

.P38L23:
//-------------------------------------------------------------------
//   Loop at "D:\CCES_Porting_Training\Porting_Library\Files\CCES_Porting_Library.c" line 34 col 5
//-------------------------------------------------------------------
//   This loop executes 2 iterations of the original loop in estimated 3 
//   cycles.
//-------------------------------------------------------------------
//   Unknown Trip Count
//   Successfully found modulo schedule with:
//     Initiation Interval (II)                                  = 3
//     Stage Count (SC)                                          = 2
//     MVE Unroll Factor                                         = 1
//     Minimum initiation interval due to recurrences (rec MII)  = 2
//     Minimum initiation interval due to resources (res MII)    = 3.00
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     multifunction alu               used   3 out of    3 (100.0%)
//     multifunction float multiply    used   3 out of    3 (100.0%)
//     multifunction integer add sub   used   3 out of    3 (100.0%)
//     multifunction integer multiply  used   3 out of    3 (100.0%)
//     multifunction mult              used   3 out of    3 (100.0%)
//     dm dag                          used   1 out of    3 ( 33.3%)
//     pm dag                          used   1 out of    3 ( 33.3%)
//     shift immediate                 used   1 out of    3 ( 33.3%)
//     memory access                   used   1 out of    6 ( 16.7%)
//-------------------------------------------------------------------
//   Loop was vectorized by a factor of 2.
//-------------------------------------------------------------------
//   Vectorization peeled 1 conditional iteration from the back of the loop 
//   because of an unknown trip count, possibly not a multiple of 2.
//   
//   Consider using pragma loop_count to specify the trip count or trip modulo 
//   in order to avoid conditional peeling.
//-------------------------------------------------------------------
	f2=f0*f0, r0=dm(i5,2);
	f0=f0-f12;
.P38L23_end:
	f1=f1+f2;
	// end loop .P38L23;
//-------------------------------------------------------------------
//   End Kernel for Loop L23
//-------------------------------------------------------------------

.P38L21:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
	f2=f0*f0;
	// -- stall --
	f8=f1+f2;

	bit clr mode1 0x200000;

	nop;                                    // Inserted to fix anomaly exit_simd. 
	btst r15 by r14, r2=s8;
	f2=f2+f8;
	if sz jump (pc,.P38L7);

.P38L9:
	r1=dm(i5,m5);
	f1=f1-f12;
	// -- stall --
	f1=f1*f1;
	// -- stall --
	f2=f2+f1;

.P38L7:
	r14=pass r2;

.P38L3:
.LN13:
// line 37
	f8=float r15, i12=dm(m7,i6);
	r4=pass r14;
	i5=dm(-2,i6);
	call (pc,__lib_fdiv.) (db);             // floating-point division is implemented as a library call. 
	r15=dm(-3,i6);
	r14=dm(-4,i6);

	// -- 2 stalls --
	jump (m14,i12) (db);
	rframe;
	nop;
.LN.calculateVariance..end:
.calculateVariance..end:
	.global calculateVariance.;
	.type calculateVariance.,STT_FUNC;

calculateStandardDeviation.:
.LNcalculateStandardDeviation.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r2,r4,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r1,r4,r8,r12,s0-s15,i4,i6-i7,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN14:
// line "D:\CCES_Porting_Training\Porting_Library\Files\CCES_Porting_Library.c":42
	cjump calculateVariance. (db);
	dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ2-1;
.LCJ2:

.LN15:
	cjump sqrtf. (db);
	r4=pass r0, dm(i7,m7)=r2;
	dm(i7,m7)=.LCJ3-1;
.LCJ3:

.LN16:
	i12=dm(m7,i6);
	// -- 7 stalls --
	jump (m14,i12) (db);
	rframe;
	nop;
.LN.calculateStandardDeviation..end:
.calculateStandardDeviation..end:
	.global calculateStandardDeviation.;
	.type calculateStandardDeviation.,STT_FUNC;

	.file_attr ProjectName="CCES_Porting_Library";
	.file_attr FuncName="calculateMean.";
	.file_attr FuncName="fabs.";
	.file_attr FuncName="fabsf.";
	.file_attr FuncName="fclipf.";
	.file_attr FuncName="fsignf.";
	.file_attr FuncName="copysignf.";
	.file_attr FuncName="favgf.";
	.file_attr FuncName="fmaxf.";
	.file_attr FuncName="fminf.";
	.file_attr FuncName="favg.";
	.file_attr FuncName="fclip.";
	.file_attr FuncName="fmax.";
	.file_attr FuncName="fmin.";
	.file_attr FuncName="copysign.";
	.file_attr FuncName="fsign.";
	.file_attr FuncName="calculateRMS.";
	.file_attr FuncName="calculateVariance.";
	.file_attr FuncName="calculateStandardDeviation.";
	.file_attr Encoding="SW";
	.file_attr Content="Code";

	.section/SW/DOUBLE32 seg_swco;

.epctext.end:

	.extern __lib_fdiv.;
	.type __lib_fdiv.,STT_FUNC;
	.extern sqrtf.;
	.type sqrtf.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\src\CCES_Porting_Library.sbn", 0, 160;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x63,0x0A,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x43,0x43,0x45,0x53,0x5F,0x50,0x6F,
		0x72,0x74,0x69,0x6E,0x67,0x5F,0x54,0x72,0x61,0x69,0x6E,0x69,
		0x6E,0x67,0x5C,0x50,0x6F,0x72,0x74,0x69,0x6E,0x67,0x5F,0x4C,
		0x69,0x62,0x72,0x61,0x72,0x79,0x5C,0x46,0x69,0x6C,0x65,0x73,
		0x5C,0x43,0x43,0x45,0x53,0x5F,0x50,0x6F,0x72,0x74,0x69,0x6E,
		0x67,0x5F,0x4C,0x69,0x62,0x72,0x61,0x72,0x79,0x2E,0x63,0x00,
		0x0C;
	.var = .epcline;
	.inc/binary ".\src\CCES_Porting_Library.sbn", 160, 2336;
	.var = .LNcalculateMean.;
	.var = .LN.calculateMean..end;
	.byte =
		0x01,0x48,0x03,0x00,0x00,0x01,0x00,0x0B,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.calculateMean..end;
	.byte =
		0x0B,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN3;
	.byte =
		0x00,0x00,0x00,0x0A,0xE2,0x09,0x00,0x00,0x63,0x61,0x6C,0x63,
		0x75,0x6C,0x61,0x74,0x65,0x52,0x4D,0x53,0x00,0x01;
	.var = .LNcalculateRMS.;
	.var = .LN.calculateRMS..end;
	.byte =
		0x01,0x48,0x03,0x00,0x00,0x01,0x00,0x0B,0x00,0x00,0x00,0x00;
	.var = .LN4;
	.var = .LN.calculateRMS..end;
	.byte =
		0x0B,0x00,0x00,0x00,0x00;
	.var = .LN4;
	.var = .LN7;
	.byte =
		0x00,0x00,0x00,0x0A,0x26,0x0A,0x00,0x00,0x63,0x61,0x6C,0x63,
		0x75,0x6C,0x61,0x74,0x65,0x56,0x61,0x72,0x69,0x61,0x6E,0x63,
		0x65,0x00,0x01;
	.var = .LNcalculateVariance.;
	.var = .LN.calculateVariance..end;
	.byte =
		0x01,0x48,0x03,0x00,0x00,0x01,0x00,0x0B,0x00,0x00,0x00,0x00;
	.var = .LN10;
	.var = .LN.calculateVariance..end;
	.byte =
		0x0B,0x00,0x00,0x00,0x00;
	.var = .LN11;
	.var = .LN13;
	.byte =
		0x00,0x00,0x00,0x0A,0x65,0x0A,0x00,0x00,0x63,0x61,0x6C,0x63,
		0x75,0x6C,0x61,0x74,0x65,0x53,0x74,0x61,0x6E,0x64,0x61,0x72,
		0x64,0x44,0x65,0x76,0x69,0x61,0x74,0x69,0x6F,0x6E,0x00,0x01;
	.var = .LNcalculateStandardDeviation.;
	.var = .LN.calculateStandardDeviation..end;
	.byte =
		0x01,0x48,0x03,0x00,0x00,0x01,0x00,0x0B,0x00,0x00,0x00,0x00;
	.var = .LN14;
	.var = .LN.calculateStandardDeviation..end;
	.byte =
		0x00,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\src\CCES_Porting_Library.sbn", 2496, 922;
	.var = .LNcalculateMean.;
	.byte =
		0x04,0x01,0x05,0x33,0x1E,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x33,0x03,0x7E,0x01,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN.calculateMean..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNcalculateRMS.;
	.byte =
		0x04,0x01,0x05,0x32,0x15,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x32,0x03,0x7E,0x01,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x10,0x01,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN.calculateRMS..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNcalculateVariance.;
	.byte =
		0x04,0x01,0x05,0x37,0x27,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x1F,0x0A,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN.calculateVariance..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNcalculateStandardDeviation.;
	.byte =
		0x04,0x01,0x05,0x40,0x31,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x22,0x0A,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x10,0x01,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN.calculateStandardDeviation..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x66,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x67,0x0A,0x00,0x00,0x63,0x09,0x00,0x00,0x63,0x61,0x6C,0x63,
		0x75,0x6C,0x61,0x74,0x65,0x4D,0x65,0x61,0x6E,0x00,0xA3,0x09,
		0x00,0x00,0x63,0x61,0x6C,0x63,0x75,0x6C,0x61,0x74,0x65,0x52,
		0x4D,0x53,0x00,0xE2,0x09,0x00,0x00,0x63,0x61,0x6C,0x63,0x75,
		0x6C,0x61,0x74,0x65,0x56,0x61,0x72,0x69,0x61,0x6E,0x63,0x65,
		0x00,0x26,0x0A,0x00,0x00,0x63,0x61,0x6C,0x63,0x75,0x6C,0x61,
		0x74,0x65,0x53,0x74,0x61,0x6E,0x64,0x61,0x72,0x64,0x44,0x65,
		0x76,0x69,0x61,0x74,0x69,0x6F,0x6E,0x00,0x00,0x00,0x00,0x00;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x34,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNcalculateMean.;
	.var = .LN.calculateMean..end-.LNcalculateMean.;
	.var = .LNcalculateRMS.;
	.var = .LN.calculateRMS..end-.LNcalculateRMS.;
	.var = .LNcalculateVariance.;
	.var = .LN.calculateVariance..end-.LNcalculateVariance.;
	.var = .LNcalculateStandardDeviation.;
	.var = .LN.calculateStandardDeviation..end-.LNcalculateStandardDeviation.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:
