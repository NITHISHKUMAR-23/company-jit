	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\death.c";
//  Compilation time: Thu Oct 24 14:40:18 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\Standard_Demo -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo Standard_Demo\death.d -o Standard_Demo\death.doj
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

vCreateSuicidalTasks.:
.LNvCreateSuicidalTasks.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r2,r4,r8,r12,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\death.c":98
	modify(i7,-2) (nw);
	r2=r4;
	dm(-2,i6)=r4;
.LN0:
// line 99
	r12=260;
	r8=.sCREATO.0;
	r4=vCreateTasks.;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=r2;
	dm(i7,m7)=m13;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
	modify(i7,4) (nw);
.LN1:
// line 100
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vCreateSuicidalTasks..end:
.vCreateSuicidalTasks..end:
	.global vCreateSuicidalTasks.;
	.type vCreateSuicidalTasks.,STT_FUNC;

vSuicidalTask.:
.LNvSuicidalTask.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,r4,i4,i12,acc,mcc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\death.c":104
	modify(i7,-6) (nw);
	r2=i5;
	dm(-7,i6)=r2;
	dm(-6,i6)=r4;
.LN2:
// line 107
	i12=200;
	dm(-2,i6)=i12;
	r2=pass r4;
.LN3:
// line 109
	if eq jump (pc,.P41L2);

	i4=r4;
.LN4:
// line 114
	r2=dm(i4,m5);
	dm(-3,i6)=r2;
.LN5:
// line 115
	jump (pc,.P41L3);

.P41L2:
.LN6:
// line 118
	dm(-3,i6)=m13;

.P41L3:

.P41L4:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\death.c" line 121 col 2
//-------------------------------------------------------------------
.LN7:
// line 124
	i4=modify(i6,-5) (nw);
	i12=2;
	dm(m5,i4)=i12;                            // Use of volatile in loops precludes optimizations. 
.LN8:
// line 125
	i5=modify(i6,-4) (nw);
	i12=89;
	dm(m5,i5)=i12;                            // Use of volatile in loops precludes optimizations. 
.LN9:
// line 126
	r2=dm(i4,m5);                             // Use of volatile in loops precludes optimizations. 
	r1=dm(i5,m5);                             // Use of volatile in loops precludes optimizations. 
	r2=r2*r1 (ssi);
	dm(i5,m5)=r2;                             // Use of volatile in loops precludes optimizations. 
.LN10:
// line 127
	r4=dm(-2,i6);
.LN11:
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN12:
// line 129
	r2=dm(-3,i6);
	r2=pass r2;
	if eq jump (pc,.P41L8);

.LN13:
// line 132
	r4=m5;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
.LN14:
// line 135
	r4=dm(-3,i6);
.LN15:
	cjump vTaskDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
.LN16:
// line 138
	r4=m5;
	cjump vTaskDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
.LN17:
// line 139
	jump (pc,.P41L9);

.P41L8:

.P41L9:
	jump (pc,.P41L4);
//-------------------------------------------------------------------
//   End Loop L4
//-------------------------------------------------------------------
.LN.vSuicidalTask..end:
.vSuicidalTask..end:
	.type vSuicidalTask.,STT_FUNC;

vCreateTasks.:
.LNvCreateTasks.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 48 bytes
//  Scratch registers used: {r2,r4,r8,r12,i12,acc}
//  Call preserved registers used: {r13-r14}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\death.c":145
	modify(i7,-6) (nw);
	dm(-6,i6)=r13;
	dm(-5,i6)=r14;
	dm(-4,i6)=r4;
.LN18:
// line 146
	i12=1000;
	dm(-3,i6)=i12;
.LN19:
// line 154
	r4=1000;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
.LN20:
// line 155
	cjump uxTaskGetNumberOfTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
.LN21:
	dm(uxTasksRunningAtStart.)=r0;
.LN22:
// line 157
	r4=m5;
	cjump uxTaskPriorityGet. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
.LN23:
	dm(-2,i6)=r0;

.P39L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\death.c" line 159 col 2
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 37 
//   cycles (includes 2 stalls but excludes the cost of function calls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used  28 out of   37 ( 75.7%)
//     pm dag                          used  24 out of   37 ( 64.9%)
//     shift immediate                 used  24 out of   37 ( 64.9%)
//     multifunction alu               used  16 out of   37 ( 43.2%)
//     multifunction float multiply    used  16 out of   37 ( 43.2%)
//     multifunction integer add sub   used  16 out of   37 ( 43.2%)
//     multifunction integer multiply  used  16 out of   37 ( 43.2%)
//     multifunction mult              used  16 out of   37 ( 43.2%)
//     memory access                   used  28 out of   74 ( 37.8%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN24:
// line 162
	r4=dm(-3,i6);
.LN25:
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
.LN26:
// line 164
	dm(xCreatedTask.)=m5;
.LN27:
// line 166
	r2=dm(-2,i6);
.LN28:
	r13=xCreatedTask.;
	r8=.sSUICID.1;
	r14=vSuicidalTask.;
	modify(i7,m7) (nw);
	dm(i7,m7)=r13;
	dm(i7,m7)=r2;
	dm(i7,m7)=m13;
	r12=200;
	r4=r14;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ9-1;
.LCJ9:
	modify(i7,4) (nw);
.LN29:
// line 167
	r2=dm(-2,i6);
.LN30:
	r8=.sSUICID.2;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=r2;
	dm(i7,m7)=r13;
	r12=200;
	r4=r14;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ10-1;
.LCJ10:
	modify(i7,4) (nw);
.LN31:
// line 169
	r2=dm(usCreationCount.) (sw);           // Use of volatile in loops precludes optimizations. 
	r2=r2+1;
	dm(usCreationCount.)=r2 (sw);           // Use of volatile in loops precludes optimizations. 
	jump (pc,.P39L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.vCreateTasks..end:
.vCreateTasks..end:
	.type vCreateTasks.,STT_FUNC;

xIsCreateTaskStillRunning.:
.LNxIsCreateTaskStillRunning.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0-r2,r8,r12,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\death.c":177
	modify(i7,-2) (nw);
.LN32:
// line 179
	dm(-2,i6)=m14;
.LN33:
// line 182
	r2=dm(usLastCreationCount.3.) (sw);
	r1=dm(usCreationCount.) (sw);
	comp(r2,r1);
	if ne jump (pc,.P50L2);

.LN34:
// line 184
	dm(-2,i6)=m13;
.LN35:
// line 185
	jump (pc,.P50L3);

.P50L2:
.LN36:
// line 188
	r2=dm(usCreationCount.) (sw);
	dm(usLastCreationCount.3.)=r2 (sw);

.P50L3:
.LN37:
// line 191
	cjump uxTaskGetNumberOfTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ11-1;
.LCJ11:
.LN38:
	dm(uxTasksRunningNow.4.)=r0;
.LN39:
// line 193
	r2=dm(uxTasksRunningAtStart.);
	compu(r2,r0);
	if le jump (pc,.P50L5);

.LN40:
// line 195
	dm(-2,i6)=m13;
.LN41:
// line 196
	jump (pc,.P50L6);

.P50L5:
.LN42:
// line 197
	r8=dm(uxTasksRunningNow.4.);
	r12=dm(uxTasksRunningAtStart.);
	r2=r8-r12;
	r1=3;
	compu(r2,r1);
	if le jump (pc,.P50L8);

.LN43:
// line 199
	dm(-2,i6)=m13;
.LN44:
// line 200
	jump (pc,.P50L9);

.P50L8:

.P50L9:

.P50L6:
.LN45:
// line 206
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xIsCreateTaskStillRunning..end:
.xIsCreateTaskStillRunning..end:
	.global xIsCreateTaskStillRunning.;
	.type xIsCreateTaskStillRunning.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr FuncName="vCreateSuicidalTasks.";
	.file_attr FuncName="vSuicidalTask.";
	.file_attr FuncName="vCreateTasks.";
	.file_attr FuncName="xIsCreateTaskStillRunning.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern xTaskCreate.;
	.type xTaskCreate.,STT_FUNC;
	.extern vTaskDelay.;
	.type vTaskDelay.,STT_FUNC;
	.extern vTaskDelete.;
	.type vTaskDelete.,STT_FUNC;
	.extern uxTaskGetNumberOfTasks.;
	.type uxTaskGetNumberOfTasks.,STT_FUNC;
	.extern uxTaskPriorityGet.;
	.type uxTaskPriorityGet.,STT_FUNC;

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type .epcbss,STT_OBJECT;
.epcbss:
	.byte uxTasksRunningNow.4.[4];
	.type uxTasksRunningNow.4.,STT_OBJECT;
.epcbss.end:

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\Standard_Demo\death.sbn", 0, 309;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x13,0x1D,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x44,0x65,0x6D,0x6F,0x5C,
		0x43,0x6F,0x6D,0x6D,0x6F,0x6E,0x5C,0x4D,0x69,0x6E,0x69,0x6D,
		0x61,0x6C,0x5C,0x64,0x65,0x61,0x74,0x68,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\Standard_Demo\death.sbn", 309, 6726;
	.var = .LNvCreateSuicidalTasks.;
	.var = .LN.vCreateSuicidalTasks..end;
	.byte =
		0x01,0x01,0x00,0x14,0x75,0x78,0x50,0x72,0x69,0x6F,0x72,0x69,
		0x74,0x79,0x00,0x87,0x0D,0x00,0x00,0x02,0x86,0x78,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.vCreateSuicidalTasks..end;
	.byte =
		0x00,0x00,0x13,0x5F,0x1B,0x00,0x00,0x76,0x53,0x75,0x69,0x63,
		0x69,0x64,0x61,0x6C,0x54,0x61,0x73,0x6B,0x00,0x01;
	.var = .LNvSuicidalTask.;
	.var = .LN.vSuicidalTask..end;
	.byte =
		0x01,0x00,0x00,0x14,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xD1,0x03,0x00,0x00,0x02,0x86,0x68,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN2;
	.var = .LN.vSuicidalTask..end;
	.byte =
		0x16,0x6C,0x31,0x00,0x01,0x64,0x1B,0x00,0x00,0x02,0x86,0x6C,
		0x00,0x00,0x00,0x00,0x00,0x16,0x6C,0x32,0x00,0x01,0x64,0x1B,
		0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x16,0x78,
		0x54,0x61,0x73,0x6B,0x54,0x6F,0x4B,0x69,0x6C,0x6C,0x00,0x01,
		0x70,0x16,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,
		0x16,0x78,0x44,0x65,0x6C,0x61,0x79,0x00,0x01,0x5F,0x1B,0x00,
		0x00,0x02,0x86,0x78;
	.var = .LN2-.LNvSuicidalTask.;
	.byte =
		0x00,0x00,0x00,0x12,0x99,0x0D,0x00,0x00,0x10,0x70,0x02,0x00,
		0x00,0x13,0xDA,0x1B,0x00,0x00,0x76,0x43,0x72,0x65,0x61,0x74,
		0x65,0x54,0x61,0x73,0x6B,0x73,0x00,0x01;
	.var = .LNvCreateTasks.;
	.var = .LN.vCreateTasks..end;
	.byte =
		0x01,0x00,0x00,0x14,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xD1,0x03,0x00,0x00,0x02,0x86,0x70,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN18;
	.var = .LN.vCreateTasks..end;
	.byte =
		0x16,0x78,0x44,0x65,0x6C,0x61,0x79,0x00,0x01,0x5F,0x1B,0x00,
		0x00,0x02,0x86,0x74;
	.var = .LN18-.LNvCreateTasks.;
	.byte =
		0x00,0x16,0x75,0x78,0x50,0x72,0x69,0x6F,0x72,0x69,0x74,0x79,
		0x00,0x01,0x87,0x0D,0x00,0x00,0x02,0x86,0x78;
	.var = .LN18-.LNvCreateTasks.;
	.byte =
		0x00,0x00,0x00,0x17,0x76,0x1C,0x00,0x00,0x78,0x49,0x73,0x43,
		0x72,0x65,0x61,0x74,0x65,0x54,0x61,0x73,0x6B,0x53,0x74,0x69,
		0x6C,0x6C,0x52,0x75,0x6E,0x6E,0x69,0x6E,0x67,0x00,0x01;
	.var = .LNxIsCreateTaskStillRunning.;
	.var = .LN.xIsCreateTaskStillRunning..end;
	.byte =
		0x01,0x76,0x0D,0x00,0x00,0x01,0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN32;
	.var = .LN.xIsCreateTaskStillRunning..end;
	.byte =
		0x16,0x75,0x73,0x4C,0x61,0x73,0x74,0x43,0x72,0x65,0x61,0x74,
		0x69,0x6F,0x6E,0x43,0x6F,0x75,0x6E,0x74,0x00,0x01,0xB4,0x06,
		0x00,0x00,0x05,0x03;
	.var = usLastCreationCount.3.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x75,0x78,0x54,0x61,0x73,0x6B,
		0x73,0x52,0x75,0x6E,0x6E,0x69,0x6E,0x67,0x4E,0x6F,0x77,0x00,
		0x01,0x87,0x0D,0x00,0x00,0x05,0x03;
	.var = uxTasksRunningNow.4.;
	.var = .LN32-.LNxIsCreateTaskStillRunning.;
	.byte =
		0x00,0x16,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x76,
		0x0D,0x00,0x00,0x02,0x86,0x78;
	.var = .LN32-.LNxIsCreateTaskStillRunning.;
	.byte =
		0x00,0x00,0x00,0x16,0x75,0x73,0x43,0x72,0x65,0x61,0x74,0x69,
		0x6F,0x6E,0x43,0x6F,0x75,0x6E,0x74,0x00,0x01,0x11,0x1D,0x00,
		0x00,0x05,0x03;
	.var = usCreationCount.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x75,0x78,0x54,0x61,0x73,0x6B,
		0x73,0x52,0x75,0x6E,0x6E,0x69,0x6E,0x67,0x41,0x74,0x53,0x74,
		0x61,0x72,0x74,0x00,0x01,0x6B,0x15,0x00,0x00,0x05,0x03;
	.var = uxTasksRunningAtStart.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x75,0x78,0x4D,0x61,0x78,0x4E,
		0x75,0x6D,0x62,0x65,0x72,0x4F,0x66,0x45,0x78,0x74,0x72,0x61,
		0x54,0x61,0x73,0x6B,0x73,0x52,0x75,0x6E,0x6E,0x69,0x6E,0x67,
		0x00,0x01,0x0C,0x1D,0x00,0x00,0x05,0x03;
	.var = uxMaxNumberOfExtraTasksRunning.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x16,0x78,0x43,0x72,0x65,0x61,0x74,
		0x65,0x64,0x54,0x61,0x73,0x6B,0x00,0x01,0x70,0x16,0x00,0x00,
		0x05,0x03;
	.var = xCreatedTask.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x12,0x87,0x0D,0x00,0x00,0x10,0xB4,
		0x06,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\Standard_Demo\death.sbn", 7035, 2061;
	.var = .LNvCreateSuicidalTasks.;
	.byte =
		0x04,0x01,0x05,0x01,0x6A,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x0D,0x0A,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vCreateSuicidalTasks..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvSuicidalTask.;
	.byte =
		0x04,0x01,0x05,0x01,0x70,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x12,0x0C,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x03,0x0E,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x0E,0x0C,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x04,0x0C,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN.vSuicidalTask..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvCreateTasks.;
	.byte =
		0x04,0x01,0x05,0x01,0x99,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x12,0x0A,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x0C,0x11,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x40,0x0A,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x20,0x0B,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x03,0x0E,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN.vCreateTasks..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNxIsCreateTaskStillRunning.;
	.byte =
		0x04,0x01,0x05,0x01,0xB9,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x0C,0x0B,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x05,0x3C,0x0C,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x05,0x07,0x0A,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN.xIsCreateTaskStillRunning..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x56,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x17,0x1D,0x00,0x00,0x81,0x1A,0x00,0x00,0x76,0x43,0x72,0x65,
		0x61,0x74,0x65,0x53,0x75,0x69,0x63,0x69,0x64,0x61,0x6C,0x54,
		0x61,0x73,0x6B,0x73,0x00,0xDA,0x1B,0x00,0x00,0x78,0x49,0x73,
		0x43,0x72,0x65,0x61,0x74,0x65,0x54,0x61,0x73,0x6B,0x53,0x74,
		0x69,0x6C,0x6C,0x52,0x75,0x6E,0x6E,0x69,0x6E,0x67,0x00,0xEE,
		0x1C,0x00,0x00,0x78,0x43,0x72,0x65,0x61,0x74,0x65,0x64,0x54,
		0x61,0x73,0x6B,0x00,0x00,0x00,0x00,0x00;
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
	.var = .LNvCreateSuicidalTasks.;
	.var = .LN.vCreateSuicidalTasks..end-.LNvCreateSuicidalTasks.;
	.var = .LNvCreateTasks.;
	.var = .LN.vCreateTasks..end-.LNvCreateTasks.;
	.var = .LNvSuicidalTask.;
	.var = .LN.vSuicidalTask..end-.LNvSuicidalTask.;
	.var = .LNxIsCreateTaskStillRunning.;
	.var = .LN.xIsCreateTaskStillRunning..end-.LNxIsCreateTaskStillRunning.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 2;
	.type usCreationCount.,STT_OBJECT;
	.byte usCreationCount.[] =
		0x00,0x00;
	.align 4;
	.type uxTasksRunningAtStart.,STT_OBJECT;
	.byte uxTasksRunningAtStart.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxMaxNumberOfExtraTasksRunning.,STT_OBJECT;
	.byte uxMaxNumberOfExtraTasksRunning.[] =
		0x03,0x00,0x00,0x00;
	.align 8;
	.type .sCREATO.0,STT_OBJECT;
	.byte .sCREATO.0[] =
		0x43,0x52,0x45,0x41,0x54,0x4F,0x52,0x00;
	.align 8;
	.type .sSUICID.1,STT_OBJECT;
	.byte .sSUICID.1[] =
		0x53,0x55,0x49,0x43,0x49,0x44,0x31,0x00;
	.align 8;
	.type .sSUICID.2,STT_OBJECT;
	.byte .sSUICID.2[] =
		0x53,0x55,0x49,0x43,0x49,0x44,0x32,0x00;
	.align 2;
	.type usLastCreationCount.3.,STT_OBJECT;
	.byte usLastCreationCount.3.[] =
		0xFF,0x0F;

	.align 4;
	.byte xCreatedTask.[4];
	.weak xCreatedTask.;
