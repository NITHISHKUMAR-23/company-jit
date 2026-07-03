	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_mutex.c";
//  Compilation time: Thu Oct 24 14:39:50 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\system\osal -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo system\osal\adi_osal_freertos_mutex.d -o system\osal\adi_osal_freertos_mutex.doj
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

adi_osal_MutexGetObjSize.:
.LNadi_osal_MutexGetObjSize.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
.LN0:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_mutex.c":313
	r0=84;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_MutexGetObjSize..end:
.adi_osal_MutexGetObjSize..end:
	.global adi_osal_MutexGetObjSize.;
	.type adi_osal_MutexGetObjSize.,STT_FUNC;

adi_osal_MutexCreate.:
.LNadi_osal_MutexCreate.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,r4,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_mutex.c":112
	modify(i7,-4) (nw);
	dm(-5,i6)=r4;
	r2=pass r4;
.LN1:
// line 117
	if ne jump (pc,.P34L2);

.LN2:
// line 119
	dm(-2,i6)=m14;
	jump (pc,.P34L4);

.P34L2:
.LN3:
// line 124
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN4:
	if eq jump (pc,.P34L7);

.LN5:
// line 126
	i4=dm(-5,i6);
	dm(m5,i4)=m15;
.LN6:
// line 127
	i12=19;
	dm(-2,i6)=i12;
	jump (pc,.P34L4);

.P34L7:
.LN7:
// line 130
	r4=4;
	cjump xQueueCreateMutex. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN8:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN9:
// line 132
	if eq jump (pc,.P34L11);

.LN10:
// line 134
	dm(-4,i6)=m13;
.LN11:
// line 135
	i4=dm(-5,i6);
	dm(i4,m5)=r0;
.LN12:
// line 136
	jump (pc,.P34L12);

.P34L11:
.LN13:
// line 139
	i4=dm(-5,i6);
	dm(m5,i4)=m15;
.LN14:
// line 140
	dm(-4,i6)=m14;

.P34L12:
.LN15:
// line 143
	r2=dm(-4,i6);
	dm(-2,i6)=r2;

.P34L4:
.LN16:
// line 144
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_MutexCreate..end:
.adi_osal_MutexCreate..end:
	.global adi_osal_MutexCreate.;
	.type adi_osal_MutexCreate.,STT_FUNC;

adi_osal_MutexDestroy.:
.LNadi_osal_MutexDestroy.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,r4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_mutex.c":162
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN17:
// line 163
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN18:
	if eq jump (pc,.P37L2);

.LN19:
// line 165
	i12=19;
	dm(-2,i6)=i12;
	jump (pc,.P37L4);

.P37L2:
.LN20:
// line 168
	r4=dm(-3,i6);
	r2=m7;
	comp(r4,r2);
	if ne jump (pc,.P37L7);

.LN21:
// line 170
	i12=4;
	dm(-2,i6)=i12;
	jump (pc,.P37L4);

.P37L7:
.LN22:
// line 173
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
.LN23:
// line 175
	dm(-2,i6)=m13;

.P37L4:
.LN24:
// line 176
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_MutexDestroy..end:
.adi_osal_MutexDestroy..end:
	.global adi_osal_MutexDestroy.;
	.type adi_osal_MutexDestroy.,STT_FUNC;

adi_osal_MutexCreateStatic.:
.LNadi_osal_MutexCreateStatic.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,i4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_mutex.c":208
	modify(i7,-6) (nw);
	dm(-5,i6)=r12;
	dm(-6,i6)=r8;
	dm(-7,i6)=r4;
.LN25:
// line 213
	cjump _adi_osal_IsMemoryAligned. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
	r2=fext r0 by 0:8;
.LN26:
	r2=pass r2;
	if eq jump (pc,.P39L1);

	r2=dm(-7,i6);
	r2=pass r2;
	if eq jump (pc,.P39L1);

	r2=dm(-6,i6);
	r1=84;
	compu(r2,r1);
	if ge jump (pc,.P39L2);

.P39L1:
.LN27:
// line 215
	i4=dm(-5,i6);
	dm(m5,i4)=m15;
.LN28:
// line 216
	i12=7;
	dm(-2,i6)=i12;
	jump (pc,.P39L6);

.P39L2:
.LN29:
// line 219
	r2=dm(-5,i6);
	r2=pass r2;
	if ne jump (pc,.P39L9);

.LN30:
// line 221
	dm(-2,i6)=m14;
	jump (pc,.P39L6);

.P39L9:
.LN31:
// line 226
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN32:
	if eq jump (pc,.P39L13);

.LN33:
// line 228
	i4=dm(-5,i6);
	dm(m5,i4)=m15;
.LN34:
// line 229
	i12=19;
	dm(-2,i6)=i12;
	jump (pc,.P39L6);

.P39L13:
.LN35:
// line 232
	r8=dm(-7,i6);
.LN36:
	r4=4;
	cjump xQueueCreateMutexStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
.LN37:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN38:
// line 234
	if eq jump (pc,.P39L17);

.LN39:
// line 236
	dm(-4,i6)=m13;
.LN40:
// line 237
	i4=dm(-5,i6);
	dm(i4,m5)=r0;
.LN41:
// line 238
	jump (pc,.P39L18);

.P39L17:
.LN42:
// line 241
	i4=dm(-5,i6);
	dm(m5,i4)=m15;
.LN43:
// line 242
	dm(-4,i6)=m14;

.P39L18:
.LN44:
// line 245
	r2=dm(-4,i6);
	dm(-2,i6)=r2;

.P39L6:
.LN45:
// line 246
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_MutexCreateStatic..end:
.adi_osal_MutexCreateStatic..end:
	.global adi_osal_MutexCreateStatic.;
	.type adi_osal_MutexCreateStatic.,STT_FUNC;

adi_osal_MutexDestroyStatic.:
.LNadi_osal_MutexDestroyStatic.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,r4,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_mutex.c":276
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN46:
// line 277
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN47:
	if eq jump (pc,.P42L2);

.LN48:
// line 279
	i12=19;
	dm(-2,i6)=i12;
	jump (pc,.P42L4);

.P42L2:
.LN49:
// line 282
	r4=dm(-3,i6);
	r2=m7;
	comp(r4,r2);
	if ne jump (pc,.P42L7);

.LN50:
// line 284
	i12=4;
	dm(-2,i6)=i12;
	jump (pc,.P42L4);

.P42L7:
.LN51:
// line 287
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
.LN52:
// line 289
	dm(-2,i6)=m13;

.P42L4:
.LN53:
// line 290
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_MutexDestroyStatic..end:
.adi_osal_MutexDestroyStatic..end:
	.global adi_osal_MutexDestroyStatic.;
	.type adi_osal_MutexDestroyStatic.,STT_FUNC;

adi_osal_MutexPend.:
.LNadi_osal_MutexPend.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r0-r2,r4,r8,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_mutex.c":355
	modify(i7,-6) (nw);
	dm(-5,i6)=r8;
	dm(-6,i6)=r4;
.LN54:
// line 357
	dm(-3,i6)=m13;
	r2=65535;
	compu(r8,r2);
.LN55:
// line 361
	if le jump (pc,.P43L2);

	r2=m7;
	comp(r8,r2);
	if eq jump (pc,.P43L2);

.LN56:
// line 364
	i12=16;
	dm(-2,i6)=i12;
	jump (pc,.P43L5);

.P43L2:
.LN57:
// line 367
	cjump _adi_osal_OsNotStarted. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ9-1;
.LCJ9:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN58:
	if eq jump (pc,.P43L8);

.LN59:
// line 369
	i12=19;
	dm(-2,i6)=i12;
	jump (pc,.P43L5);

.P43L8:
.LN60:
// line 372
	cjump _adi_osal_IsCurrentLevelISR. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ10-1;
.LCJ10:
	r2=fext r0 by 0:8;
	r2=pass r2;
.LN61:
	if eq jump (pc,.P43L12);

.LN62:
// line 374
	i12=19;
	dm(-2,i6)=i12;
	jump (pc,.P43L5);

.P43L12:
.LN63:
// line 377
	r2=dm(-6,i6);
	r1=m7;
	comp(r2,r1);
	if ne jump (pc,.P43L16);

.LN64:
// line 379
	i12=4;
	dm(-2,i6)=i12;
	jump (pc,.P43L5);

.P43L16:
.LN65:
// line 384
	r2=dm(-5,i6);
	r2=pass r2;
	if eq jump (pc,.P43L21);

	comp(r2,r1);
	if eq jump (pc,.P43L22);

	jump (pc,.P43L20);

.P43L21:
.LN66:
// line 387
	dm(-3,i6)=m13;
.LN67:
// line 388
	jump (pc,.P43L23);

.P43L22:
.LN68:
// line 390
	dm(-3,i6)=m15;
.LN69:
// line 391
	jump (pc,.P43L23);

.P43L20:
.LN70:
// line 393
	dm(-3,i6)=r2;

.P43L23:
.LN71:
// line 397
	r4=dm(-6,i6);
	r8=dm(-3,i6);
.LN72:
	cjump xQueueTakeMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ11-1;
.LCJ11:
.LN73:
	r2=pass r0;
	if eq jump (pc,.P43L26);

	r2=m5;
	r2=btgl r0 by r2;
	if not sz jump (pc,.P43L25);

.LN74:
// line 400
	dm(-4,i6)=m13;
.LN75:
// line 401
	jump (pc,.P43L28);

.P43L26:
.LN76:
// line 404
	i12=31;
	dm(-4,i6)=i12;
.LN77:
// line 405
	jump (pc,.P43L28);

.P43L25:
.LN78:
// line 408
	dm(-4,i6)=m14;

.P43L28:
.LN79:
// line 412
	r2=dm(-4,i6);
	dm(-2,i6)=r2;

.P43L5:
.LN80:
// line 413
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_MutexPend..end:
.adi_osal_MutexPend..end:
	.global adi_osal_MutexPend.;
	.type adi_osal_MutexPend.,STT_FUNC;

adi_osal_MutexPost.:
.LNadi_osal_MutexPost.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0,r2,i12,acc,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\adi_osal_freertos_mutex.c":438
	modify(i7,-4) (nw);
	dm(-4,i6)=r4;
	r2=m7;
	comp(r4,r2);
.LN81:
// line 442
	if ne jump (pc,.P46L2);

.LN82:
// line 444
	i12=4;
	dm(-2,i6)=i12;
	jump (pc,.P46L4);

.P46L2:
.LN83:
// line 448
	cjump xQueueGiveMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ12-1;
.LCJ12:
.LN84:
	r2=pass r0;
	if eq jump (pc,.P46L8);

	r2=m5;
	r2=btgl r0 by r2;
	if not sz jump (pc,.P46L7);

.LN85:
// line 451
	dm(-3,i6)=m13;
.LN86:
// line 452
	jump (pc,.P46L10);

.P46L8:
.LN87:
// line 455
	i12=20;
	dm(-3,i6)=i12;
.LN88:
// line 456
	jump (pc,.P46L10);

.P46L7:
.LN89:
// line 459
	dm(-3,i6)=m14;

.P46L10:
.LN90:
// line 463
	r2=dm(-3,i6);
	dm(-2,i6)=r2;

.P46L4:
.LN91:
// line 464
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.adi_osal_MutexPost..end:
.adi_osal_MutexPost..end:
	.global adi_osal_MutexPost.;
	.type adi_osal_MutexPost.,STT_FUNC;

_adi_osal_IsMemoryAligned.:
.LN_adi_osal_IsMemoryAligned.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,i12}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\SHARC_ADSP_21569_CCES\RTOSDemo_CCES_SHARC_21569\..\..\..\Source\portable\CCES\SHARC_215xx\osal\adi_osal_arch_internal.h":145
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
	dm(-2,i6)=r4;
	r0=m6;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN._adi_osal_IsMemoryAligned..end:
._adi_osal_IsMemoryAligned..end:
	.type _adi_osal_IsMemoryAligned.,STT_FUNC;

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

.LN92:
// line 122
	r2=imaskp;

.LN93:
	r2=pass r2;
	r0=m5;
	if ne r0=m6;
.LN94:
	dm(-2,i6)=r0;

.LN95:
// line 117
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN._adi_osal_IsCurrentLevelISR..end:
._adi_osal_IsCurrentLevelISR..end:
	.type _adi_osal_IsCurrentLevelISR.,STT_FUNC;

_adi_osal_OsNotStarted.:
.LN_adi_osal_OsNotStarted.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 8 bytes
//  Scratch registers used: {r0,r2,i12,scc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN96:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Source\portable\CCES\osal\osal_freertos.h":300
	cjump xTaskGetSchedulerState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ13-1;
.LCJ13:
.LN97:
	r2=m6;
	r2=btgl r0 by r2;
	r0=m5;
	if not sz r0=m6;
.LN98:
// line 298
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN._adi_osal_OsNotStarted..end:
._adi_osal_OsNotStarted..end:
	.type _adi_osal_OsNotStarted.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="adi_osal_MutexGetObjSize.";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr FuncName="_adi_osal_IsMemoryAligned.";
	.file_attr FuncName="_adi_osal_IsCurrentLevelISR.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="_adi_osal_OsNotStarted.";
	.file_attr FuncName="adi_osal_MutexCreate.";
	.file_attr FuncName="adi_osal_MutexDestroy.";
	.file_attr FuncName="adi_osal_MutexCreateStatic.";
	.file_attr FuncName="adi_osal_MutexDestroyStatic.";
	.file_attr FuncName="adi_osal_MutexPend.";
	.file_attr FuncName="adi_osal_MutexPost.";
	.file_attr Encoding="SW";
	.file_attr Content="Code";
.epctext.end:

	.extern xQueueCreateMutex.;
	.type xQueueCreateMutex.,STT_FUNC;
	.extern vQueueDelete.;
	.type vQueueDelete.,STT_FUNC;
	.extern xQueueCreateMutexStatic.;
	.type xQueueCreateMutexStatic.,STT_FUNC;
	.extern xQueueTakeMutexRecursive.;
	.type xQueueTakeMutexRecursive.,STT_FUNC;
	.extern xQueueGiveMutexRecursive.;
	.type xQueueGiveMutexRecursive.,STT_FUNC;
	.extern xTaskGetSchedulerState.;
	.type xTaskGetSchedulerState.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\system\osal\adi_osal_freertos_mutex.sbn", 0, 288;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x2C,0x2A,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x53,0x6F,0x75,0x72,0x63,
		0x65,0x5C,0x70,0x6F,0x72,0x74,0x61,0x62,0x6C,0x65,0x5C,0x43,
		0x43,0x45,0x53,0x5C,0x6F,0x73,0x61,0x6C,0x5C,0x61,0x64,0x69,
		0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x66,0x72,0x65,0x65,0x72,0x74,
		0x6F,0x73,0x5F,0x6D,0x75,0x74,0x65,0x78,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\system\osal\adi_osal_freertos_mutex.sbn", 288, 9751;
	.var = .LNadi_osal_MutexGetObjSize.;
	.var = .LN.adi_osal_MutexGetObjSize..end;
	.byte =
		0x01,0x25,0x05,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.adi_osal_MutexGetObjSize..end;
	.byte =
		0x00,0x00,0x13,0x1F,0x27,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x4D,0x75,0x74,0x65,0x78,0x43,0x72,0x65,
		0x61,0x74,0x65,0x00,0x01;
	.var = .LNadi_osal_MutexCreate.;
	.var = .LN.adi_osal_MutexCreate..end;
	.byte =
		0x01,0x1C,0x18,0x00,0x00,0x01,0x00,0x15,0x70,0x68,0x4D,0x75,
		0x74,0x65,0x78,0x00,0x1F,0x27,0x00,0x00,0x02,0x86,0x6C,0x00,
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN1;
	.var = .LN.adi_osal_MutexCreate..end;
	.byte =
		0x16,0x65,0x52,0x65,0x74,0x53,0x74,0x61,0x74,0x75,0x73,0x00,
		0x01,0x1C,0x18,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,
		0x00,0x16,0x70,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,0x65,
		0x00,0x01,0xCC,0x23,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,
		0x00,0x00,0x00,0x00,0x05,0x00,0x3C,0x14,0x00,0x00,0x13,0x6F,
		0x27,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,
		0x4D,0x75,0x74,0x65,0x78,0x44,0x65,0x73,0x74,0x72,0x6F,0x79,
		0x00,0x01;
	.var = .LNadi_osal_MutexDestroy.;
	.var = .LN.adi_osal_MutexDestroy..end;
	.byte =
		0x01,0x1C,0x18,0x00,0x00,0x01,0x00,0x15,0x68,0x4D,0x75,0x74,
		0x65,0x78,0x00,0x6F,0x27,0x00,0x00,0x02,0x86,0x74,0x00,0x14,
		0x00,0x00,0x00,0x00;
	.var = .LN17;
	.var = .LN.adi_osal_MutexDestroy..end;
	.byte =
		0x00,0x00,0x11,0x3C,0x14,0x00,0x00,0x13,0x1F,0x28,0x00,0x00,
		0x61,0x64,0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x4D,0x75,0x74,
		0x65,0x78,0x43,0x72,0x65,0x61,0x74,0x65,0x53,0x74,0x61,0x74,
		0x69,0x63,0x00,0x01;
	.var = .LNadi_osal_MutexCreateStatic.;
	.var = .LN.adi_osal_MutexCreateStatic..end;
	.byte =
		0x01,0x1C,0x18,0x00,0x00,0x01,0x00,0x15,0x70,0x4D,0x75,0x74,
		0x65,0x78,0x4F,0x62,0x6A,0x65,0x63,0x74,0x00,0x1F,0x28,0x00,
		0x00,0x02,0x86,0x64,0x00,0x15,0x6E,0x4D,0x75,0x74,0x65,0x78,
		0x4F,0x62,0x6A,0x53,0x69,0x7A,0x65,0x00,0x25,0x05,0x00,0x00,
		0x02,0x86,0x68,0x00,0x15,0x70,0x68,0x4D,0x75,0x74,0x65,0x78,
		0x00,0x1F,0x27,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,0x00,0x00,
		0x00,0x00;
	.var = .LN25;
	.var = .LN.adi_osal_MutexCreateStatic..end;
	.byte =
		0x16,0x65,0x52,0x65,0x74,0x53,0x74,0x61,0x74,0x75,0x73,0x00,
		0x01,0x1C,0x18,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,
		0x00,0x16,0x70,0x4D,0x75,0x74,0x65,0x78,0x00,0x01,0xCC,0x23,
		0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x11,0xE9,0x03,0x00,0x00,0x13,0x74,0x28,0x00,0x00,0x61,0x64,
		0x69,0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x4D,0x75,0x74,0x65,0x78,
		0x44,0x65,0x73,0x74,0x72,0x6F,0x79,0x53,0x74,0x61,0x74,0x69,
		0x63,0x00,0x01;
	.var = .LNadi_osal_MutexDestroyStatic.;
	.var = .LN.adi_osal_MutexDestroyStatic..end;
	.byte =
		0x01,0x1C,0x18,0x00,0x00,0x01,0x00,0x15,0x68,0x4D,0x75,0x74,
		0x65,0x78,0x00,0x6F,0x27,0x00,0x00,0x02,0x86,0x74,0x00,0x14,
		0x00,0x00,0x00,0x00;
	.var = .LN46;
	.var = .LN.adi_osal_MutexDestroyStatic..end;
	.byte =
		0x00,0x00,0x13,0x04,0x29,0x00,0x00,0x61,0x64,0x69,0x5F,0x6F,
		0x73,0x61,0x6C,0x5F,0x4D,0x75,0x74,0x65,0x78,0x50,0x65,0x6E,
		0x64,0x00,0x01;
	.var = .LNadi_osal_MutexPend.;
	.var = .LN.adi_osal_MutexPend..end;
	.byte =
		0x01,0x1C,0x18,0x00,0x00,0x01,0x00,0x15,0x68,0x4D,0x75,0x74,
		0x65,0x78,0x00,0x6F,0x27,0x00,0x00,0x02,0x86,0x68,0x00,0x15,
		0x6E,0x54,0x69,0x6D,0x65,0x6F,0x75,0x74,0x49,0x6E,0x54,0x69,
		0x63,0x6B,0x73,0x00,0x55,0x19,0x00,0x00,0x02,0x86,0x6C,0x00,
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN54;
	.var = .LN.adi_osal_MutexPend..end;
	.byte =
		0x16,0x65,0x52,0x65,0x74,0x53,0x74,0x61,0x74,0x75,0x73,0x00,
		0x01,0x1C,0x18,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,
		0x00,0x16,0x6E,0x54,0x69,0x6D,0x65,0x6F,0x75,0x74,0x00,0x01,
		0x53,0x0C,0x00,0x00,0x02,0x86,0x74;
	.var = .LN54-.LNadi_osal_MutexPend.;
	.byte =
		0x00,0x00,0x00,0x13,0x64,0x29,0x00,0x00,0x61,0x64,0x69,0x5F,
		0x6F,0x73,0x61,0x6C,0x5F,0x4D,0x75,0x74,0x65,0x78,0x50,0x6F,
		0x73,0x74,0x00,0x01;
	.var = .LNadi_osal_MutexPost.;
	.var = .LN.adi_osal_MutexPost..end;
	.byte =
		0x01,0x1C,0x18,0x00,0x00,0x01,0x00,0x15,0x68,0x4D,0x75,0x74,
		0x65,0x78,0x00,0x6F,0x27,0x00,0x00,0x02,0x86,0x70,0x00,0x14,
		0x00,0x00,0x00,0x00;
	.var = .LN81;
	.var = .LN.adi_osal_MutexPost..end;
	.byte =
		0x16,0x65,0x52,0x65,0x74,0x53,0x74,0x61,0x74,0x75,0x73,0x00,
		0x01,0x1C,0x18,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,
		0x00,0x00,0x00,0x13,0xB3,0x29,0x00,0x00,0x5F,0x61,0x64,0x69,
		0x5F,0x6F,0x73,0x61,0x6C,0x5F,0x49,0x73,0x4D,0x65,0x6D,0x6F,
		0x72,0x79,0x41,0x6C,0x69,0x67,0x6E,0x65,0x64,0x00,0x01;
	.var = .LN_adi_osal_IsMemoryAligned.;
	.var = .LN._adi_osal_IsMemoryAligned..end;
	.byte =
		0x01,0xF2,0x01,0x00,0x00,0x01,0x02,0x15,0x70,0x4D,0x65,0x6D,
		0x6F,0x72,0x79,0x00,0xE9,0x03,0x00,0x00,0x02,0x86,0x78,0x00,
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN_adi_osal_IsMemoryAligned.;
	.var = .LN._adi_osal_IsMemoryAligned..end;
	.byte =
		0x00,0x00,0x13,0xF3,0x29,0x00,0x00,0x5F,0x61,0x64,0x69,0x5F,
		0x6F,0x73,0x61,0x6C,0x5F,0x49,0x73,0x43,0x75,0x72,0x72,0x65,
		0x6E,0x74,0x4C,0x65,0x76,0x65,0x6C,0x49,0x53,0x52,0x00,0x01;
	.var = .LN_adi_osal_IsCurrentLevelISR.;
	.var = .LN._adi_osal_IsCurrentLevelISR..end;
	.byte =
		0x01,0xF2,0x01,0x00,0x00,0x01,0x02,0x14,0x00,0x00,0x00,0x00;
	.var = .LN92;
	.var = .LN95;
	.byte =
		0x00,0x00,0x13,0x2E,0x2A,0x00,0x00,0x5F,0x61,0x64,0x69,0x5F,
		0x6F,0x73,0x61,0x6C,0x5F,0x4F,0x73,0x4E,0x6F,0x74,0x53,0x74,
		0x61,0x72,0x74,0x65,0x64,0x00,0x01;
	.var = .LN_adi_osal_OsNotStarted.;
	.var = .LN._adi_osal_OsNotStarted..end;
	.byte =
		0x01,0xF2,0x01,0x00,0x00,0x00,0x02,0x14,0x00,0x00,0x00,0x00;
	.var = .LN96;
	.var = .LN98;
	.byte =
		0x00,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\system\osal\adi_osal_freertos_mutex.sbn", 10039, 2362;
	.var = .LNadi_osal_MutexGetObjSize.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xB7,0x02,0x01,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_MutexGetObjSize..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_MutexCreate.;
	.byte =
		0x04,0x01,0x05,0x01,0x78,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x12,0x0C,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_MutexCreate..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_MutexDestroy.;
	.byte =
		0x04,0x01,0x05,0x01,0xAA,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_MutexDestroy..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_MutexCreateStatic.;
	.byte =
		0x04,0x01,0x05,0x01,0xD8,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x05,0x2C,0x0E,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_MutexCreateStatic..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_MutexDestroyStatic.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x93,0x02,0x01,0x00,0x05,0x02;
	.var = .LN46;
	.byte =
		0x05,0x09,0x0A,0x00,0x05,0x02;
	.var = .LN47;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN48;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN49;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN50;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN51;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN52;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN53;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_MutexDestroyStatic..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_MutexPend.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xE2,0x02,0x01,0x00,0x05,0x02;
	.var = .LN54;
	.byte =
		0x05,0x10,0x0B,0x00,0x05,0x02;
	.var = .LN55;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN56;
	.byte =
		0x05,0x09,0x0C,0x00,0x05,0x02;
	.var = .LN57;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN58;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN59;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN60;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN61;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN62;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN63;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN64;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN65;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN66;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN67;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN68;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN69;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN70;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN71;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN72;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN73;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN74;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN75;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN76;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN77;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN78;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN79;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN80;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_MutexPend..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNadi_osal_MutexPost.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xB5,0x03,0x01,0x00,0x05,0x02;
	.var = .LN81;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN82;
	.byte =
		0x05,0x09,0x0B,0x00,0x05,0x02;
	.var = .LN83;
	.byte =
		0x05,0x0D,0x0D,0x00,0x05,0x02;
	.var = .LN84;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN85;
	.byte =
		0x05,0x0D,0x0C,0x00,0x05,0x02;
	.var = .LN86;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN87;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN88;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN89;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN90;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN91;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.adi_osal_MutexPost..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LN_adi_osal_IsMemoryAligned.;
	.byte =
		0x04,0x2E,0x05,0x06,0x99,0x00,0x05,0x02;
	.var = .LN._adi_osal_IsMemoryAligned..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LN_adi_osal_IsCurrentLevelISR.;
	.byte =
		0x04,0x2E,0x05,0x06,0x7D,0x00,0x05,0x02;
	.var = .LN92;
	.byte =
		0x05,0x05,0x0E,0x00,0x05,0x02;
	.var = .LN93;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN94;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN95;
	.byte =
		0x05,0x06,0x03,0x7B,0x01,0x00,0x05,0x02;
	.var = .LN._adi_osal_IsCurrentLevelISR..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LN_adi_osal_OsNotStarted.;
	.byte =
		0x04,0x26,0x05,0x14,0x03,0xA9,0x02,0x01,0x00,0x05,0x02;
	.var = .LN96;
	.byte =
		0x05,0x3C,0x0B,0x00,0x05,0x02;
	.var = .LN97;
	.byte =
		0x05,0x05,0x01,0x00,0x05,0x02;
	.var = .LN98;
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
		0x09,0x01,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.inc/binary ".\system\osal\adi_osal_freertos_mutex.sbn", 12401, 259;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x64,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNadi_osal_MutexGetObjSize.;
	.var = .LN.adi_osal_MutexGetObjSize..end-.LNadi_osal_MutexGetObjSize.;
	.var = .LNadi_osal_MutexCreate.;
	.var = .LN.adi_osal_MutexCreate..end-.LNadi_osal_MutexCreate.;
	.var = .LN_adi_osal_IsCurrentLevelISR.;
	.var = .LN._adi_osal_IsCurrentLevelISR..end-.LN_adi_osal_IsCurrentLevelISR.;
	.var = .LNadi_osal_MutexDestroy.;
	.var = .LN.adi_osal_MutexDestroy..end-.LNadi_osal_MutexDestroy.;
	.var = .LNadi_osal_MutexCreateStatic.;
	.var = .LN.adi_osal_MutexCreateStatic..end-.LNadi_osal_MutexCreateStatic.;
	.var = .LN_adi_osal_IsMemoryAligned.;
	.var = .LN._adi_osal_IsMemoryAligned..end-.LN_adi_osal_IsMemoryAligned.;
	.var = .LNadi_osal_MutexDestroyStatic.;
	.var = .LN.adi_osal_MutexDestroyStatic..end-.LNadi_osal_MutexDestroyStatic.;
	.var = .LNadi_osal_MutexPend.;
	.var = .LN.adi_osal_MutexPend..end-.LNadi_osal_MutexPend.;
	.var = .LN_adi_osal_OsNotStarted.;
	.var = .LN._adi_osal_OsNotStarted..end-.LN_adi_osal_OsNotStarted.;
	.var = .LNadi_osal_MutexPost.;
	.var = .LN.adi_osal_MutexPost..end-.LNadi_osal_MutexPost.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:
