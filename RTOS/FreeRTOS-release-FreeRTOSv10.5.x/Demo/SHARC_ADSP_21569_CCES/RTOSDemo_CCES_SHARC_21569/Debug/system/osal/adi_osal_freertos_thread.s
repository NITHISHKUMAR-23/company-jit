	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_thread.c";
//  Compilation time: Thu Oct 24 14:39:52 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\osal -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\osal\adi_osal_freertos_thread.d -o system\osal\adi_osal_freertos_thread.doj
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

adi_osal_ThreadCreate.:
.LNadi_osal_ThreadCreate.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 56 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//Inlined in adi_osal_ThreadCreate.:
//  D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_thread.c:157:15'strlen.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_thread.c":120
	modify(i7,-8) (nw);
	dm(-8,i6)=r8;
	dm(-9,i6)=r4;
.LN0:
// line 121
	dm(-7,i6)=m13;
.LN1:
// line 122
	dm(-6,i6)=m13;
.LN2:
// line 123
	dm(-5,i6)=m13;
.LN3:
// line 124
	dm(-4,i6)=m13;
	r2=pass r4;
.LN4:
// line 127
	if ne jump (pc,.P34L2);

.LN5:
// line 129
	dm(-3,i6)=m14;
	jump (pc,.P34L4);

.P34L2:
	i4=r4;
.LN6:
// line 133
	dm(m5,i4)=m15;
.LN7:
// line 137
	r2=dm(-8,i6);
	r2=pass r2;
	if ne jump (pc,.P34L7);

.LN8:
// line 139
	dm(-3,i6)=m14;
	jump (pc,.P34L4);

.P34L7:
	i4=r2;
.LN9:
// line 142
	r2=dm(i4,m5);
	r2=pass r2;
	if ne jump (pc,.P34L11);

.LN10:
// line 144
	i12=14;
	dm(-3,i6)=i12;
	jump (pc,.P34L4);

.P34L11:
.LN11:
// line 147
	r2=dm(3,i4);
	r2=pass r2;
	if ne jump (pc,.P34L15);

.LN12:
// line 149
	i12=13;
	dm(-3,i6)=i12;
	jump (pc,.P34L4);

.P34L15:
.LN13:
// line 152
	r2=fext r2 by 0:2;
	r2=pass r2;
	if eq jump (pc,.P34L19);

.LN14:
// line 154
	i12=13;
	dm(-3,i6)=i12;
	jump (pc,.P34L4);

.P34L19:
.LN15:
// line 157
	r4=dm(5,i4);
.LN16:
	dm(-2,i6)=r4;
.LN17:
	cjump strlen. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
	r2=80;
	compu(r0,r2);
.LN18:
	if le jump (pc,.P34L23);

.LN19:
// line 159
	i12=15;
	dm(-3,i6)=i12;
	jump (pc,.P34L4);

.P34L23:
.LN20:
// line 162
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN21:
	if eq jump (pc,.P34L27);

.LN22:
// line 164
	i4=dm(-9,i6);
	dm(m5,i4)=m15;
.LN23:
// line 165
	i12=19;
	dm(-3,i6)=i12;
	jump (pc,.P34L4);

.P34L27:
.LN24:
// line 170
	i4=dm(-8,i6);
	r2=dm(3,i4);
	r2=lshift r2 by -2;
	r12=fext r2 by 0:16;
	dm(-7,i6)=r2;
.LN25:
// line 174
	r1=dm(m6,i4);
	dm(-6,i6)=r1;
.LN26:
// line 177
	r4=dm(i4,m5);
	r8=dm(5,i4);
	r0=dm(4,i4);
.LN27:
	i4=modify(i6,-5) (nw);
	r2=i4;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	dm(i7,m7)=r0;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
	modify(i7,4) (nw);
.LN28:
	dm(-4,i6)=r0;
.LN29:
// line 184
	r2=lshift r0 by 0;
	if sz jump (pc,.P34L31);

	r2=m5;
	r2=btgl r0 by r2;
	if sz jump (pc,.P34L33);

	r2=m7;
	comp(r0,r2);
	if eq jump (pc,.P34L32);

	jump (pc,.P34L31);

.P34L33:
.LN30:
// line 188
	r2=dm(-5,i6);
	i4=dm(-9,i6);
	dm(i4,m5)=r2;
.LN31:
// line 189
	dm(-3,i6)=m13;
	jump (pc,.P34L4);

.P34L32:
.LN32:
// line 193
	i12=23;
	dm(-3,i6)=i12;
	jump (pc,.P34L4);

.P34L31:
.LN33:
// line 196
	dm(-3,i6)=m14;

.P34L4:
.LN34:
// line 198
	r0=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ThreadCreate..end:
.adi_osal_ThreadCreate..end:
	.global adi_osal_ThreadCreate.;
	.type adi_osal_ThreadCreate.,STT_FUNC;

adi_osal_ThreadDestroy.:
.LNadi_osal_ThreadDestroy.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,r4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_thread.c":217
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
	r2=m7;
	comp(r4,r2);
.LN35:
// line 220
	if ne jump (pc,.P38L2);

.LN36:
// line 222
	i12=4;
	dm(-2,i6)=i12;
	jump (pc,.P38L4);

.P38L2:
.LN37:
// line 225
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN38:
	if eq jump (pc,.P38L7);

.LN39:
// line 227
	i12=19;
	dm(-2,i6)=i12;
	jump (pc,.P38L4);

.P38L7:
.LN40:
// line 231
	r4=dm(-3,i6);
.LN41:
	cjump vTaskDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
.LN42:
// line 233
	dm(-2,i6)=m13;

.P38L4:
.LN43:
// line 234
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ThreadDestroy..end:
.adi_osal_ThreadDestroy..end:
	.global adi_osal_ThreadDestroy.;
	.type adi_osal_ThreadDestroy.,STT_FUNC;

adi_osal_ThreadGetNativeHandle.:
.LNadi_osal_ThreadGetNativeHandle.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_thread.c":255
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
	r2=pass r4;
.LN44:
// line 257
	if ne jump (pc,.P40L2);

.LN45:
// line 259
	dm(-2,i6)=m14;
	jump (pc,.P40L4);

.P40L2:
.LN46:
// line 262
	cjump _adi_osal_OsNotStarted. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN47:
	if eq jump (pc,.P40L7);

.LN48:
// line 264
	i4=dm(-3,i6);
	dm(m5,i4)=m15;
.LN49:
// line 265
	dm(-2,i6)=m14;
	jump (pc,.P40L4);

.P40L7:
.LN50:
// line 270
	cjump xTaskGetCurrentTaskHandle. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
.LN51:
	i4=dm(-3,i6);
	dm(i4,m5)=r0;
.LN52:
// line 272
	dm(-2,i6)=m13;

.P40L4:
.LN53:
// line 273
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ThreadGetNativeHandle..end:
.adi_osal_ThreadGetNativeHandle..end:
	.global adi_osal_ThreadGetNativeHandle.;
	.type adi_osal_ThreadGetNativeHandle.,STT_FUNC;

adi_osal_ThreadGetHandle.:
.LNadi_osal_ThreadGetHandle.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_thread.c":296
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN54:
// line 298
	cjump _adi_osal_OsNotStarted. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN55:
	if eq jump (pc,.P43L2);

.LN56:
// line 300
	i4=dm(-3,i6);
	i12=_adi_osal_oStartupVirtualThread.;
	dm(m5,i4)=i12;
.LN57:
// line 301
	dm(-2,i6)=m13;
	jump (pc,.P43L4);

.P43L2:
.LN58:
// line 313
	cjump xTaskGetCurrentTaskHandle. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
.LN59:
	i4=dm(-3,i6);
	dm(i4,m5)=r0;
.LN60:
// line 315
	dm(-2,i6)=m13;

.P43L4:
.LN61:
// line 316
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ThreadGetHandle..end:
.adi_osal_ThreadGetHandle..end:
	.global adi_osal_ThreadGetHandle.;
	.type adi_osal_ThreadGetHandle.,STT_FUNC;

adi_osal_ThreadGetName.:
.LNadi_osal_ThreadGetName.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,i4,i12,m4,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_thread.c":337
	modify(i7,-6) (nw);
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
.LN62:
// line 339
	dm(-4,i6)=m13;
.LN63:
// line 340
	dm(-3,i6)=m13;
	r2=pass r4;
.LN64:
// line 343
	if ne jump (pc,.P44L2);

.LN65:
// line 345
	i12=4;
	dm(-2,i6)=i12;
	jump (pc,.P44L4);

.P44L2:
.LN66:
// line 349
	r4=m5;
	cjump pcTaskGetName. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ9-1;
.LCJ9:
.LN67:
	dm(-3,i6)=r0;

.P44L6:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_thread.c" line 351 col 2
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 27 
//   cycles (includes 12 stalls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used  12 out of   27 ( 44.4%)
//     multifunction alu               used  12 out of   27 ( 44.4%)
//     multifunction float multiply    used  12 out of   27 ( 44.4%)
//     multifunction integer add sub   used  12 out of   27 ( 44.4%)
//     multifunction integer multiply  used  12 out of   27 ( 44.4%)
//     multifunction mult              used  12 out of   27 ( 44.4%)
//     pm dag                          used  12 out of   27 ( 44.4%)
//     shift immediate                 used  12 out of   27 ( 44.4%)
//     memory access                   used  12 out of   54 ( 22.2%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN68:
// line 351
	i4=dm(-3,i6);
	m4=dm(-4,i6);
	// -- 4 stalls --
	r2=dm(m4,i4) (bwse);
	r2=pass r2;
	if eq jump (pc,.P44L7);

.LN69:
// line 353
	r2=dm(m4,i4) (bw);
	i4=dm(-6,i6);
	// -- 4 stalls --
	dm(m4,i4)=r2 (bw);
.LN70:
// line 354
	r2=dm(-4,i6);
	r2=r2+1;
	dm(-4,i6)=r2;
.LN71:
// line 356
	r1=dm(-5,i6);
	compu(r2,r1);
	if lt jump (pc,.P44L10);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN72:
// line 358
	dm(-2,i6)=m14;
	jump (pc,.P44L4);

.P44L10:
//-------------------------------------------------------------------
//   Part of Loop 6, depth 1
//-------------------------------------------------------------------
	// -- 2 stalls --
	jump (pc,.P44L6);
//-------------------------------------------------------------------
//   End Loop L6
//-------------------------------------------------------------------

.P44L7:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN73:
// line 362
	i4=dm(-6,i6);
	m4=dm(-4,i6);
	dm(m4,i4)=m13 (bw);
.LN74:
// line 364
	dm(-2,i6)=m13;

.P44L4:
.LN75:
// line 365
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ThreadGetName..end:
.adi_osal_ThreadGetName..end:
	.global adi_osal_ThreadGetName.;
	.type adi_osal_ThreadGetName.,STT_FUNC;

adi_osal_ThreadGetPrio.:
.LNadi_osal_ThreadGetPrio.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_thread.c":390
	modify(i7,-4) (nw);
	dm(-3,i6)=r8;
	dm(-4,i6)=r4;
.LN76:
// line 393
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ10-1;
.LCJ10:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN77:
	if eq jump (pc,.P46L2);

.LN78:
// line 395
	i4=dm(-3,i6);
	dm(m5,i4)=m15;
.LN79:
// line 396
	i12=19;
	dm(-2,i6)=i12;
	jump (pc,.P46L4);

.P46L2:
.LN80:
// line 400
	r4=dm(-4,i6);
	r2=m7;
	comp(r4,r2);
	if ne jump (pc,.P46L7);

.LN81:
// line 402
	i12=4;
	dm(-2,i6)=i12;
	jump (pc,.P46L4);

.P46L7:
.LN82:
// line 412
	cjump uxTaskPriorityGet. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ11-1;
.LCJ11:
.LN83:
	i4=dm(-3,i6);
	dm(i4,m5)=r0;
.LN84:
// line 414
	dm(-2,i6)=m13;

.P46L4:
.LN85:
// line 415
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ThreadGetPrio..end:
.adi_osal_ThreadGetPrio..end:
	.global adi_osal_ThreadGetPrio.;
	.type adi_osal_ThreadGetPrio.,STT_FUNC;

adi_osal_ThreadSetPrio.:
.LNadi_osal_ThreadSetPrio.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,r8,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_thread.c":439
	modify(i7,-4) (nw);
	dm(-4,i6)=r8;
	dm(-5,i6)=r4;
.LN86:
// line 441
	dm(-3,i6)=m13;
	r2=m7;
	comp(r4,r2);
.LN87:
// line 445
	if ne jump (pc,.P48L2);

.LN88:
// line 447
	i12=4;
	dm(-2,i6)=i12;
	jump (pc,.P48L4);

.P48L2:
.LN89:
// line 452
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ12-1;
.LCJ12:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN90:
	if eq jump (pc,.P48L7);

.LN91:
// line 454
	i12=19;
	dm(-2,i6)=i12;
	jump (pc,.P48L4);

.P48L7:
.LN92:
// line 459
	r8=dm(-4,i6);
	r2=7;
	compu(r8,r2);
	if lt jump (pc,.P48L11);

.LN93:
// line 461
	i12=10;
	dm(-2,i6)=i12;
	jump (pc,.P48L4);

.P48L11:
.LN94:
// line 465
	dm(-3,i6)=r8;
.LN95:
// line 467
	r4=dm(-5,i6);
.LN96:
	cjump vTaskPrioritySet. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ13-1;
.LCJ13:
.LN97:
// line 469
	dm(-2,i6)=m13;

.P48L4:
.LN98:
// line 470
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ThreadSetPrio..end:
.adi_osal_ThreadSetPrio..end:
	.global adi_osal_ThreadSetPrio.;
	.type adi_osal_ThreadSetPrio.,STT_FUNC;

adi_osal_ThreadSleep.:
.LNadi_osal_ThreadSleep.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,r4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_thread.c":487
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN99:
// line 489
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ14-1;
.LCJ14:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN100:
	if eq jump (pc,.P50L2);

.LN101:
// line 491
	i12=19;
	dm(-2,i6)=i12;
	jump (pc,.P50L4);

.P50L2:
.LN102:
// line 494
	cjump _adi_osal_IsSchedLocked. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ15-1;
.LCJ15:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN103:
	if eq jump (pc,.P50L7);

.LN104:
// line 496
	i12=19;
	dm(-2,i6)=i12;
	jump (pc,.P50L4);

.P50L7:
.LN105:
// line 499
	r4=dm(-3,i6);
	r2=65535;
	compu(r4,r2);
	if le jump (pc,.P50L11);

.LN106:
// line 501
	i12=16;
	dm(-2,i6)=i12;
	jump (pc,.P50L4);

.P50L11:
	r2=pass r4;
.LN107:
// line 506
	if eq jump (pc,.P50L15);

.LN108:
// line 509
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ16-1;
.LCJ16:
.LN109:
// line 510
	jump (pc,.P50L16);

.P50L15:

.P50L16:
.LN110:
// line 512
	dm(-2,i6)=m13;

.P50L4:
.LN111:
// line 513
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_ThreadSleep..end:
.adi_osal_ThreadSleep..end:
	.global adi_osal_ThreadSleep.;
	.type adi_osal_ThreadSleep.,STT_FUNC;

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

.LN112:
// line 122
	r2=imaskp;

.LN113:
	r2=pass r2;
	r0=m5;
	if ne r0=m6;
.LN114:
	dm(-2,i6)=r0;

.LN115:
// line 117
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN._adi_osal_IsCurrentLevelISR..end:
._adi_osal_IsCurrentLevelISR..end:
	.type _adi_osal_IsCurrentLevelISR.,STT_FUNC;

_adi_osal_IsSchedLocked.:
.LN_adi_osal_IsSchedLocked.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,r2,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN116:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\osal_freertos.h":293
	cjump xTaskGetSchedulerState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ17-1;
.LCJ17:
.LN117:
	r2=pass r0;
	r0=m5;
	if eq r0=m6;
.LN118:
// line 291
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN._adi_osal_IsSchedLocked..end:
._adi_osal_IsSchedLocked..end:
	.type _adi_osal_IsSchedLocked.,STT_FUNC;

_adi_osal_OsNotStarted.:
.LN_adi_osal_OsNotStarted.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,r2,i12,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN119:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\osal_freertos.h":300
	cjump xTaskGetSchedulerState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ18-1;
.LCJ18:
.LN120:
	r2=m6;
	r2=btgl r0 by r2;
	r0=m5;
	if not sz r0=m6;
.LN121:
// line 298
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN._adi_osal_OsNotStarted..end:
._adi_osal_OsNotStarted..end:
	.type _adi_osal_OsNotStarted.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="_adi_osal_IsMemoryAligned.";
	.file_attr FuncName="_adi_osal_IsCurrentLevelISR.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="strlen.";
	.file_attr FuncName="_adi_osal_IsSchedLocked.";
	.file_attr FuncName="_adi_osal_OsNotStarted.";
	.file_attr FuncName="adi_osal_ThreadCreate.";
	.file_attr FuncName="adi_osal_ThreadDestroy.";
	.file_attr FuncName="adi_osal_ThreadGetNativeHandle.";
	.file_attr FuncName="adi_osal_ThreadGetHandle.";
	.file_attr FuncName="adi_osal_ThreadGetName.";
	.file_attr FuncName="adi_osal_ThreadGetPrio.";
	.file_attr FuncName="adi_osal_ThreadSetPrio.";
	.file_attr FuncName="adi_osal_ThreadSleep.";
	.file_attr Encoding="SW";
	.file_attr Content="Code";
.epctext.end:

	.extern strlen.;
	.type strlen.,STT_FUNC;
	.extern xTaskCreate.;
	.type xTaskCreate.,STT_FUNC;
	.extern vTaskDelete.;
	.type vTaskDelete.,STT_FUNC;
	.extern xTaskGetCurrentTaskHandle.;
	.type xTaskGetCurrentTaskHandle.,STT_FUNC;
	.extern pcTaskGetName.;
	.type pcTaskGetName.,STT_FUNC;
	.extern uxTaskPriorityGet.;
	.type uxTaskPriorityGet.,STT_FUNC;
	.extern vTaskPrioritySet.;
	.type vTaskPrioritySet.,STT_FUNC;
	.extern vTaskDelay.;
	.type vTaskDelay.,STT_FUNC;
	.extern xTaskGetSchedulerState.;
	.type xTaskGetSchedulerState.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\osal\adi_osal_freertos_thread.sbn", 0, 288;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x5E,0x2A,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x70,0x6F,0x72,0x74,0x61,0x62,0x6C,0x65,0x5C,0x43,
		0x43,0x45,0x53,0x5C,0x6F,0x73,0x61,0x6C,0x5C,0x61,0x64,0x69,
		0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x66,0x72,0x65,0x65,0x72,0x74,
		0x6F,0x73,0x5F,0x74,0x68,0x72,0x65,0x61,0x64,0x2E,0x63,0x00,
		0x0C;
	.var = .epcline;
	.inc/binary ".\system\osal\adi_osal_freertos_thread.sbn", 288, 9605;
	.var = .LNadi_osal_ThreadCreate.;
	.var = .LN.adi_osal_ThreadCreate..end;
	.byte =
		0x01,0x19,0x19,0x00,0x00,0x01,0x00,0x14,0x70,0x68,0x54,0x68,
		0x72,0x65,0x61,0x64,0x00,0xAA,0x26,0x00,0x00,0x02,0x86,0x5C,
		0x00,0x14,0x70,0x54,0x68,0x72,0x65,0x61,0x64,0x41,0x74,0x74,
		0x72,0x00,0xA4,0x26,0x00,0x00,0x02,0x86,0x60,0x00,0x15,0x00,
		0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.adi_osal_ThreadCreate..end;
	.byte =
		0x16,0x6E,0x53,0x74,0x6B,0x53,0x69,0x7A,0x65,0x00,0x01,0x4D,
		0x06,0x00,0x00,0x02,0x86,0x64;
	.var = .LN0-.LNadi_osal_ThreadCreate.;
	.byte =
		0x00,0x16,0x6E,0x41,0x73,0x73,0x69,0x67,0x6E,0x65,0x64,0x50,
		0x72,0x69,0x6F,0x00,0x01,0x3E,0x0D,0x00,0x00,0x02,0x86,0x68;
	.var = .LN1-.LNadi_osal_ThreadCreate.;
	.byte =
		0x00,0x16,0x6E,0x61,0x74,0x69,0x76,0x65,0x54,0x68,0x72,0x65,
		0x61,0x64,0x00,0x01,0x57,0x20,0x00,0x00,0x02,0x86,0x6C;
	.var = .LN2-.LNadi_osal_ThreadCreate.;
	.byte =
		0x00,0x16,0x6E,0x52,0x65,0x74,0x56,0x61,0x6C,0x75,0x65,0x00,
		0x01,0x2D,0x0D,0x00,0x00,0x02,0x86,0x70;
	.var = .LN3-.LNadi_osal_ThreadCreate.;
	.byte =
		0x00,0x00,0x00,0x11,0x69,0x1D,0x00,0x00,0x07,0x00,0x9F,0x26,
		0x00,0x00,0x07,0x00,0xCE,0x14,0x00,0x00,0x13,0xFC,0x26,0x00,
		0x00,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x54,0x68,
		0x72,0x65,0x61,0x64,0x44,0x65,0x73,0x74,0x72,0x6F,0x79,0x00,
		0x01;
	.var = .LNadi_osal_ThreadDestroy.;
	.var = .LN.adi_osal_ThreadDestroy..end;
	.byte =
		0x01,0x19,0x19,0x00,0x00,0x01,0x00,0x14,0x68,0x54,0x68,0x72,
		0x65,0x61,0x64,0x00,0xFC,0x26,0x00,0x00,0x02,0x86,0x74,0x00,
		0x15,0x00,0x00,0x00,0x00;
	.var = .LN35;
	.var = .LN.adi_osal_ThreadDestroy..end;
	.byte =
		0x00,0x00,0x11,0xCE,0x14,0x00,0x00,0x13,0x56,0x27,0x00,0x00,
		0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x54,0x68,0x72,
		0x65,0x61,0x64,0x47,0x65,0x74,0x4E,0x61,0x74,0x69,0x76,0x65,
		0x48,0x61,0x6E,0x64,0x6C,0x65,0x00,0x01;
	.var = .LNadi_osal_ThreadGetNativeHandle.;
	.var = .LN.adi_osal_ThreadGetNativeHandle..end;
	.byte =
		0x01,0x19,0x19,0x00,0x00,0x01,0x00,0x14,0x70,0x68,0x54,0x68,
		0x72,0x65,0x61,0x64,0x00,0x56,0x27,0x00,0x00,0x02,0x86,0x74,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN44;
	.var = .LN.adi_osal_ThreadGetNativeHandle..end;
	.byte =
		0x00,0x00,0x07,0x00,0xEA,0x03,0x00,0x00,0x13,0xAB,0x27,0x00,
		0x00,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x54,0x68,
		0x72,0x65,0x61,0x64,0x47,0x65,0x74,0x48,0x61,0x6E,0x64,0x6C,
		0x65,0x00,0x01;
	.var = .LNadi_osal_ThreadGetHandle.;
	.var = .LN.adi_osal_ThreadGetHandle..end;
	.byte =
		0x01,0x19,0x19,0x00,0x00,0x01,0x00,0x14,0x70,0x68,0x54,0x68,
		0x72,0x65,0x61,0x64,0x00,0xAA,0x26,0x00,0x00,0x02,0x86,0x74,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN54;
	.var = .LN.adi_osal_ThreadGetHandle..end;
	.byte =
		0x00,0x00,0x13,0x43,0x28,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x54,0x68,0x72,0x65,0x61,0x64,0x47,0x65,
		0x74,0x4E,0x61,0x6D,0x65,0x00,0x01;
	.var = .LNadi_osal_ThreadGetName.;
	.var = .LN.adi_osal_ThreadGetName..end;
	.byte =
		0x01,0x19,0x19,0x00,0x00,0x01,0x00,0x14,0x70,0x73,0x7A,0x54,
		0x61,0x73,0x6B,0x4E,0x61,0x6D,0x65,0x00,0x43,0x28,0x00,0x00,
		0x02,0x86,0x68,0x00,0x14,0x6E,0x4E,0x75,0x6D,0x42,0x79,0x74,
		0x65,0x73,0x54,0x6F,0x43,0x6F,0x70,0x79,0x00,0x4D,0x06,0x00,
		0x00,0x02,0x86,0x6C,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN62;
	.var = .LN.adi_osal_ThreadGetName..end;
	.byte =
		0x16,0x69,0x6E,0x64,0x65,0x78,0x00,0x01,0x78,0x02,0x00,0x00,
		0x02,0x86,0x70;
	.var = .LN62-.LNadi_osal_ThreadGetName.;
	.byte =
		0x00,0x16,0x70,0x63,0x4E,0x61,0x74,0x69,0x76,0x65,0x4E,0x61,
		0x6D,0x65,0x00,0x01,0x43,0x28,0x00,0x00,0x02,0x86,0x74;
	.var = .LN63-.LNadi_osal_ThreadGetName.;
	.byte =
		0x00,0x00,0x00,0x07,0x00,0xF3,0x07,0x00,0x00,0x13,0xAB,0x28,
		0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x54,
		0x68,0x72,0x65,0x61,0x64,0x47,0x65,0x74,0x50,0x72,0x69,0x6F,
		0x00,0x01;
	.var = .LNadi_osal_ThreadGetPrio.;
	.var = .LN.adi_osal_ThreadGetPrio..end;
	.byte =
		0x01,0x19,0x19,0x00,0x00,0x01,0x00,0x14,0x68,0x54,0x68,0x72,
		0x65,0x61,0x64,0x00,0xFC,0x26,0x00,0x00,0x02,0x86,0x70,0x00,
		0x14,0x70,0x6E,0x54,0x68,0x72,0x65,0x61,0x64,0x50,0x72,0x69,
		0x6F,0x00,0xAB,0x28,0x00,0x00,0x02,0x86,0x74,0x00,0x15,0x00,
		0x00,0x00,0x00;
	.var = .LN76;
	.var = .LN.adi_osal_ThreadGetPrio..end;
	.byte =
		0x00,0x00,0x07,0x00,0x3A,0x1A,0x00,0x00,0x13,0x2A,0x29,0x00,
		0x00,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x54,0x68,
		0x72,0x65,0x61,0x64,0x53,0x65,0x74,0x50,0x72,0x69,0x6F,0x00,
		0x01;
	.var = .LNadi_osal_ThreadSetPrio.;
	.var = .LN.adi_osal_ThreadSetPrio..end;
	.byte =
		0x01,0x19,0x19,0x00,0x00,0x01,0x00,0x14,0x68,0x54,0x68,0x72,
		0x65,0x61,0x64,0x00,0xFC,0x26,0x00,0x00,0x02,0x86,0x6C,0x00,
		0x14,0x6E,0x4E,0x65,0x77,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,
		0x79,0x00,0x3A,0x1A,0x00,0x00,0x02,0x86,0x70,0x00,0x15,0x00,
		0x00,0x00,0x00;
	.var = .LN86;
	.var = .LN.adi_osal_ThreadSetPrio..end;
	.byte =
		0x16,0x6E,0x4E,0x65,0x77,0x50,0x72,0x69,0x6F,0x00,0x01,0x3E,
		0x0D,0x00,0x00,0x02,0x86,0x74;
	.var = .LN86-.LNadi_osal_ThreadSetPrio.;
	.byte =
		0x00,0x00,0x00,0x13,0x79,0x29,0x00,0x00,0x61,0x64,0x69,0x5F,
		0x6F,0x73,0x61,0x6C,0x5F,0x54,0x68,0x72,0x65,0x61,0x64,0x53,
		0x6C,0x65,0x65,0x70,0x00,0x01;
	.var = .LNadi_osal_ThreadSleep.;
	.var = .LN.adi_osal_ThreadSleep..end;
	.byte =
		0x01,0x19,0x19,0x00,0x00,0x01,0x00,0x14,0x6E,0x54,0x69,0x6D,
		0x65,0x49,0x6E,0x54,0x69,0x63,0x6B,0x73,0x00,0x52,0x1A,0x00,
		0x00,0x02,0x86,0x74,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN99;
	.var = .LN.adi_osal_ThreadSleep..end;
	.byte =
		0x00,0x00,0x13,0xB9,0x29,0x00,0x00,0x5F,0x61,0x64,0x69,0x5F,
		0x6F,0x73,0x61,0x6C,0x5F,0x49,0x73,0x43,0x75,0x72,0x72,0x65,
		0x6E,0x74,0x4C,0x65,0x76,0x65,0x6C,0x49,0x53,0x52,0x00,0x01;
	.var = .LN_adi_osal_IsCurrentLevelISR.;
	.var = .LN._adi_osal_IsCurrentLevelISR..end;
	.byte =
		0x01,0xF3,0x01,0x00,0x00,0x01,0x02,0x15,0x00,0x00,0x00,0x00;
	.var = .LN112;
	.var = .LN115;
	.byte =
		0x00,0x00,0x13,0xF5,0x29,0x00,0x00,0x5F,0x61,0x64,0x69,0x5F,
		0x6F,0x73,0x61,0x6C,0x5F,0x49,0x73,0x53,0x63,0x68,0x65,0x64,
		0x4C,0x6F,0x63,0x6B,0x65,0x64,0x00,0x01;
	.var = .LN_adi_osal_IsSchedLocked.;
	.var = .LN._adi_osal_IsSchedLocked..end;
	.byte =
		0x01,0xF3,0x01,0x00,0x00,0x00,0x02,0x15,0x00,0x00,0x00,0x00;
	.var = .LN116;
	.var = .LN118;
	.byte =
		0x00,0x00,0x13,0x30,0x2A,0x00,0x00,0x5F,0x61,0x64,0x69,0x5F,
		0x6F,0x73,0x61,0x6C,0x5F,0x4F,0x73,0x4E,0x6F,0x74,0x53,0x74,
		0x61,0x72,0x74,0x65,0x64,0x00,0x01;
	.var = .LN_adi_osal_OsNotStarted.;
	.var = .LN._adi_osal_OsNotStarted..end;
	.byte =
		0x01,0xF3,0x01,0x00,0x00,0x00,0x02,0x15,0x00,0x00,0x00,0x00;
	.var = .LN119;
	.var = .LN121;
	.byte =
		0x00,0x00,0x16,0x5F,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,
		0x5F,0x6F,0x53,0x74,0x61,0x72,0x74,0x75,0x70,0x56,0x69,0x72,
		0x74,0x75,0x61,0x6C,0x54,0x68,0x72,0x65,0x61,0x64,0x00,0x01,
		0xBD,0x25,0x00,0x00,0x05,0x03;
	.var = _adi_osal_oStartupVirtualThread.;
	.byte =
		0x00,0x00,0x00,0x00,0x01,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\osal\adi_osal_freertos_thread.sbn", 9893, 2324;
	.var = .LNadi_osal_ThreadCreate.;
	.byte =
		0x04,0x01,0x05,0x01,0x80,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x0E,0x0A,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x11,0x0A,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x12,0x0A,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x10,0x0A,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x05,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x10,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x05,0x06,0x0D,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x05,0x01,0x0B,0x00,0x05,0x02;
	.var = .LN.adi_osal_ThreadCreate..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_ThreadDestroy.;
	.byte =
		0x04,0x01,0x05,0x01,0xE1,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x05,0x10,0x01,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_ThreadDestroy..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_ThreadGetNativeHandle.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xFE,0x01,0x01,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN46;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN47;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN48;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN49;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN50;
	.byte =
		0x05,0x3A,0x0E,0x00,0x05,0x02;
	.var = .LN51;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN52;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN53;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_ThreadGetNativeHandle..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_ThreadGetHandle.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xA7,0x02,0x01,0x00,0x05,0x02;
	.var = .LN54;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN55;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN56;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN57;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN58;
	.byte =
		0x05,0x42,0x15,0x00,0x05,0x02;
	.var = .LN59;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN60;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN61;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_ThreadGetHandle..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_ThreadGetName.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xD0,0x02,0x01,0x00,0x05,0x02;
	.var = .LN62;
	.byte =
		0x05,0x12,0x0B,0x00,0x05,0x02;
	.var = .LN63;
	.byte =
		0x05,0x0A,0x0A,0x00,0x05,0x02;
	.var = .LN64;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN65;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN66;
	.byte =
		0x05,0x25,0x0D,0x00,0x05,0x02;
	.var = .LN67;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN68;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN69;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN70;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN71;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN72;
	.byte =
		0x05,0x0A,0x0B,0x00,0x05,0x02;
	.var = .LN73;
	.byte =
		0x05,0x02,0x0D,0x00,0x05,0x02;
	.var = .LN74;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN75;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_ThreadGetName..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_ThreadGetPrio.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x85,0x03,0x01,0x00,0x05,0x02;
	.var = .LN76;
	.byte =
		0x05,0x06,0x0C,0x00,0x05,0x02;
	.var = .LN77;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN78;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN79;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN80;
	.byte =
		0x05,0x02,0x0D,0x00,0x05,0x02;
	.var = .LN81;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN82;
	.byte =
		0x05,0x37,0x13,0x00,0x05,0x02;
	.var = .LN83;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN84;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN85;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_ThreadGetPrio..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_ThreadSetPrio.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xB6,0x03,0x01,0x00,0x05,0x02;
	.var = .LN86;
	.byte =
		0x05,0x0E,0x0B,0x00,0x05,0x02;
	.var = .LN87;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN88;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN89;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN90;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN91;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN92;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN93;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN94;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN95;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN96;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN97;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN98;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_ThreadSetPrio..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_ThreadSleep.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xE6,0x03,0x01,0x00,0x05,0x02;
	.var = .LN99;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN100;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN101;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN102;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN103;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN104;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN105;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN106;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN107;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN108;
	.byte =
		0x05,0x13,0x0C,0x00,0x05,0x02;
	.var = .LN109;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN110;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN111;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_ThreadSleep..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LN_adi_osal_IsCurrentLevelISR.;
	.byte =
		0x04,0x2F,0x05,0x06,0x7D,0x00,0x05,0x02;
	.var = .LN112;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN113;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN114;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN115;
	.byte =
		0x05,0x06,0x03,0x7B,0x01,0x00,0x05,0x02;
	.var = .LN._adi_osal_IsCurrentLevelISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LN_adi_osal_IsSchedLocked.;
	.byte =
		0x04,0x27,0x05,0x14,0x03,0xA2,0x02,0x01,0x00,0x05,0x02;
	.var = .LN116;
	.byte =
		0x05,0x3E,0x0B,0x00,0x05,0x02;
	.var = .LN117;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN118;
	.byte =
		0x05,0x14,0x03,0x7E,0x01,0x00,0x05,0x02;
	.var = .LN._adi_osal_IsSchedLocked..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LN_adi_osal_OsNotStarted.;
	.byte =
		0x04,0x27,0x05,0x14,0x03,0xA9,0x02,0x01,0x00,0x05,0x02;
	.var = .LN119;
	.byte =
		0x05,0x3C,0x0B,0x00,0x05,0x02;
	.var = .LN120;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN121;
	.byte =
		0x05,0x14,0x03,0x7E,0x01,0x00,0x05,0x02;
	.var = .LN._adi_osal_OsNotStarted..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x0D,0x01,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.inc/binary ".\system\osal\adi_osal_freertos_thread.sbn", 12217, 263;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x6C,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNadi_osal_ThreadCreate.;
	.var = .LN.adi_osal_ThreadCreate..end-.LNadi_osal_ThreadCreate.;
	.var = .LN_adi_osal_IsCurrentLevelISR.;
	.var = .LN._adi_osal_IsCurrentLevelISR..end-.LN_adi_osal_IsCurrentLevelISR.;
	.var = .LNadi_osal_ThreadDestroy.;
	.var = .LN.adi_osal_ThreadDestroy..end-.LNadi_osal_ThreadDestroy.;
	.var = .LNadi_osal_ThreadGetNativeHandle.;
	.var = .LN.adi_osal_ThreadGetNativeHandle..end-.LNadi_osal_ThreadGetNativeHandle.;
	.var = .LN_adi_osal_OsNotStarted.;
	.var = .LN._adi_osal_OsNotStarted..end-.LN_adi_osal_OsNotStarted.;
	.var = .LNadi_osal_ThreadGetHandle.;
	.var = .LN.adi_osal_ThreadGetHandle..end-.LNadi_osal_ThreadGetHandle.;
	.var = .LNadi_osal_ThreadGetName.;
	.var = .LN.adi_osal_ThreadGetName..end-.LNadi_osal_ThreadGetName.;
	.var = .LNadi_osal_ThreadGetPrio.;
	.var = .LN.adi_osal_ThreadGetPrio..end-.LNadi_osal_ThreadGetPrio.;
	.var = .LNadi_osal_ThreadSetPrio.;
	.var = .LN.adi_osal_ThreadSetPrio..end-.LNadi_osal_ThreadSetPrio.;
	.var = .LNadi_osal_ThreadSleep.;
	.var = .LN.adi_osal_ThreadSleep..end-.LNadi_osal_ThreadSleep.;
	.var = .LN_adi_osal_IsSchedLocked.;
	.var = .LN._adi_osal_IsSchedLocked..end-.LN_adi_osal_IsSchedLocked.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;


	.extern _adi_osal_oStartupVirtualThread.;
	.type _adi_osal_oStartupVirtualThread.,STT_OBJECT;
