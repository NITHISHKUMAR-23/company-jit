	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\PollQ.c";
//  Compilation time: Thu Oct 24 14:40:17 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\Standard_Demo -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo Standard_Demo\PollQ.d -o Standard_Demo\PollQ.doj
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

xArePollingQueuesStillRunning.:
.LNxArePollingQueuesStillRunning.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0,r2,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\PollQ.c":211
	modify(i7,-2) (nw);
.LN0:
// line 218
	r2=dm(xPollingConsumerCount.);
	r2=pass r2;
	if eq jump (pc,.P35L1);

	r2=dm(xPollingProducerCount.);
	r2=pass r2;
	if ne jump (pc,.P35L2);

.P35L1:
.LN1:
// line 222
	dm(-2,i6)=m13;
.LN2:
// line 223
	jump (pc,.P35L3);

.P35L2:
.LN3:
// line 226
	dm(-2,i6)=m14;

.P35L3:
.LN4:
// line 231
	dm(xPollingConsumerCount.)=m5;
.LN5:
// line 232
	dm(xPollingProducerCount.)=m5;
.LN6:
// line 234
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xArePollingQueuesStillRunning..end:
.xArePollingQueuesStillRunning..end:
	.global xArePollingQueuesStillRunning.;
	.type xArePollingQueuesStillRunning.,STT_FUNC;

vStartPolledQueueTasks.:
.LNvStartPolledQueueTasks.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r2,r4,r8,r12,i12,acc}
//  Call preserved registers used: {r14}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\PollQ.c":101
	modify(i7,-2) (nw);
	dm(-3,i6)=r14;
	dm(-2,i6)=r4;
.LN7:
// line 105
	r12=m5;
	r8=2;
	r4=10;
	cjump xQueueGenericCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
	r4=r0;
.LN8:
	dm(xPolledQueue.0.)=r0;
	r2=pass r0;
.LN9:
// line 107
	if eq jump (pc,.P40L2);

.LN10:
// line 115
	r8=.sPollTe.1;
	cjump vQueueAddToRegistry. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN11:
// line 118
	r2=dm(-2,i6);
.LN12:
	r14=xPolledQueue.0.;
	r8=.sQConsN.2;
	r4=vPolledQueueConsumer.;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=r2;
	dm(i7,m7)=r14;
	r12=200;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
	modify(i7,4) (nw);
.LN13:
// line 119
	r2=dm(-2,i6);
.LN14:
	r8=.sQProdN.3;
	r4=vPolledQueueProducer.;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=r2;
	dm(i7,m7)=r14;
	r12=200;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
	modify(i7,4) (nw);
.LN15:
// line 120
	jump (pc,.P40L3);

.P40L2:

.P40L3:
.LN16:
// line 121
	r14=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vStartPolledQueueTasks..end:
.vStartPolledQueueTasks..end:
	.global vStartPolledQueueTasks.;
	.type vStartPolledQueueTasks.,STT_FUNC;

vPolledQueueProducer.:
.LNvPolledQueueProducer.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,m4,acc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\PollQ.c":125
	modify(i7,-6) (nw);
	dm(-6,i6)=r15;
	dm(-5,i6)=r4;
.LN17:
// line 126
	m4=-7;
	dm(m4,i6)=m13 (sw);
.LN18:
// line 127
	dm(-3,i6)=m13;

.P45L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\PollQ.c" line 129 col 2
//-------------------------------------------------------------------
.LN19:
// line 131
	dm(-2,i6)=m13;

.P45L4:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\PollQ.c" line 131 col 3
//-------------------------------------------------------------------
	r2=dm(-2,i6);
	r1=3;
	comp(r2,r1);
	if ge jump (pc,.P45L6);

.LN20:
// line 134
	i4=dm(-5,i6);
	r4=dm(i4,m5);
.LN21:
	r8=i6;
	r12=-14;
	r8=r8+r12;
	r15=m5;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	r12=m5;
	cjump xQueueGenericSend. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
	modify(i7,2) (nw);
	r2=btgl r0 by r15;
.LN22:
	if sz jump (pc,.P45L8);

.LN23:
// line 138
	dm(-3,i6)=m14;
.LN24:
// line 139
	jump (pc,.P45L9);

.P45L8:
.LN25:
// line 142
	r2=dm(-3,i6);
	r2=pass r2;
	if ne jump (pc,.P45L11);

.LN26:
// line 146
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
.LN27:
// line 147
	r2=dm(xPollingProducerCount.);          // Use of volatile in loops precludes optimizations. 
	r2=r2+1;
	dm(xPollingProducerCount.)=r2;          // Use of volatile in loops precludes optimizations. 
.LN28:
// line 148
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
.LN29:
// line 149
	jump (pc,.P45L12);

.P45L11:

.P45L12:
.LN30:
// line 152
	r2=dm(-7,i6) (sw);
	r2=r2+1;
	dm(-7,i6)=r2 (sw);

.P45L9:
.LN31:
// line 131
	r2=dm(-2,i6);
	r2=r2+1;
	dm(-2,i6)=r2;
	jump (pc,.P45L4);
//-------------------------------------------------------------------
//   End Loop L4
//-------------------------------------------------------------------

.P45L6:
//-------------------------------------------------------------------
//   Part of Loop 1, depth 1
//-------------------------------------------------------------------
.LN32:
// line 158
	r4=200;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
	jump (pc,.P45L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.vPolledQueueProducer..end:
.vPolledQueueProducer..end:
	.type vPolledQueueProducer.,STT_FUNC;

vPolledQueueConsumer.:
.LNvPolledQueueConsumer.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,m4,acc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\PollQ.c":164
	modify(i7,-4) (nw);
	dm(-5,i6)=r15;
	dm(-4,i6)=r4;
.LN33:
// line 165
	m4=-5;
	dm(m4,i6)=m13 (sw);
.LN34:
// line 166
	dm(-2,i6)=m13;

.P43L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\PollQ.c" line 168 col 2
//-------------------------------------------------------------------

.P43L4:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\PollQ.c" line 171 col 3
//-------------------------------------------------------------------
.LN35:
// line 171
	i4=dm(-4,i6);
	r4=dm(i4,m5);
.LN36:
	cjump uxQueueMessagesWaiting. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
	r2=pass r0;
.LN37:
	if eq jump (pc,.P43L5);

.LN38:
// line 173
	i4=dm(-4,i6);
	r4=dm(i4,m5);
.LN39:
	r8=i6;
	r12=-12;
	r8=r8+r12;
	r15=m5;
	r12=m5;
	cjump xQueueReceive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ9-1;
.LCJ9:
	r2=btgl r0 by r15;
.LN40:
	if not sz jump (pc,.P43L8);

.LN41:
// line 175
	r2=dm(-6,i6) (sw);
	r1=dm(-5,i6) (sw);
	comp(r2,r1);
	if eq jump (pc,.P43L11);

.LN42:
// line 179
	dm(-2,i6)=m14;
.LN43:
// line 183
	dm(-5,i6)=r2 (sw);
.LN44:
// line 184
	jump (pc,.P43L12);

.P43L11:
.LN45:
// line 187
	r2=dm(-2,i6);
	r2=pass r2;
	if ne jump (pc,.P43L14);

.LN46:
// line 191
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ10-1;
.LCJ10:
.LN47:
// line 192
	r2=dm(xPollingConsumerCount.);          // Use of volatile in loops precludes optimizations. 
	r2=r2+1;
	dm(xPollingConsumerCount.)=r2;          // Use of volatile in loops precludes optimizations. 
.LN48:
// line 193
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ11-1;
.LCJ11:
.LN49:
// line 194
	jump (pc,.P43L15);

.P43L14:

.P43L15:

.P43L12:
.LN50:
// line 198
	r2=dm(-5,i6) (sw);
	r2=r2+1;
	dm(-5,i6)=r2 (sw);
.LN51:
// line 199
	jump (pc,.P43L9);

.P43L8:

.P43L9:
	jump (pc,.P43L4);
//-------------------------------------------------------------------
//   End Loop L4
//-------------------------------------------------------------------

.P43L5:
//-------------------------------------------------------------------
//   Part of Loop 1, depth 1
//-------------------------------------------------------------------
.LN52:
// line 204
	r4=180;
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ12-1;
.LCJ12:
	jump (pc,.P43L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.vPolledQueueConsumer..end:
.vPolledQueueConsumer..end:
	.type vPolledQueueConsumer.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="xArePollingQueuesStillRunning.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr FuncName="vStartPolledQueueTasks.";
	.file_attr FuncName="vPolledQueueProducer.";
	.file_attr FuncName="vPolledQueueConsumer.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern xQueueGenericCreate.;
	.type xQueueGenericCreate.,STT_FUNC;
	.extern vQueueAddToRegistry.;
	.type vQueueAddToRegistry.,STT_FUNC;
	.extern xTaskCreate.;
	.type xTaskCreate.,STT_FUNC;
	.extern xQueueGenericSend.;
	.type xQueueGenericSend.,STT_FUNC;
	.extern vPortEnterCritical.;
	.type vPortEnterCritical.,STT_FUNC;
	.extern vPortExitCritical.;
	.type vPortExitCritical.,STT_FUNC;
	.extern vTaskDelay.;
	.type vTaskDelay.,STT_FUNC;
	.extern uxQueueMessagesWaiting.;
	.type uxQueueMessagesWaiting.,STT_FUNC;
	.extern xQueueReceive.;
	.type xQueueReceive.,STT_FUNC;

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type .epcbss,STT_OBJECT;
.epcbss:
	.byte xPolledQueue.0.[4];
	.type xPolledQueue.0.,STT_OBJECT;
.epcbss.end:

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\Standard_Demo\PollQ.sbn", 0, 309;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x10,0x1D,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x44,0x65,0x6D,0x6F,0x5C,
		0x43,0x6F,0x6D,0x6D,0x6F,0x6E,0x5C,0x4D,0x69,0x6E,0x69,0x6D,
		0x61,0x6C,0x5C,0x50,0x6F,0x6C,0x6C,0x51,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\Standard_Demo\PollQ.sbn", 309, 6832;
	.var = .LNxArePollingQueuesStillRunning.;
	.var = .LN.xArePollingQueuesStillRunning..end;
	.byte =
		0x01,0x76,0x0D,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.xArePollingQueuesStillRunning..end;
	.byte =
		0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x00,0x01,0x76,0x0D,
		0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x16,0xA3,0x1B,0x00,0x00,0x76,0x53,0x74,0x61,0x72,0x74,0x50,
		0x6F,0x6C,0x6C,0x65,0x64,0x51,0x75,0x65,0x75,0x65,0x54,0x61,
		0x73,0x6B,0x73,0x00,0x01;
	.var = .LNvStartPolledQueueTasks.;
	.var = .LN.vStartPolledQueueTasks..end;
	.byte =
		0x01,0x01,0x00,0x17,0x75,0x78,0x50,0x72,0x69,0x6F,0x72,0x69,
		0x74,0x79,0x00,0x87,0x0D,0x00,0x00,0x02,0x86,0x78,0x00,0x14,
		0x00,0x00,0x00,0x00;
	.var = .LN7;
	.var = .LN.vStartPolledQueueTasks..end;
	.byte =
		0x15,0x78,0x50,0x6F,0x6C,0x6C,0x65,0x64,0x51,0x75,0x65,0x75,
		0x65,0x00,0x01,0x9A,0x1A,0x00,0x00,0x05,0x03;
	.var = xPolledQueue.0.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,0x2D,0x1C,0x00,0x00,
		0x76,0x50,0x6F,0x6C,0x6C,0x65,0x64,0x51,0x75,0x65,0x75,0x65,
		0x50,0x72,0x6F,0x64,0x75,0x63,0x65,0x72,0x00,0x01;
	.var = .LNvPolledQueueProducer.;
	.var = .LN.vPolledQueueProducer..end;
	.byte =
		0x01,0x00,0x00,0x17,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xD1,0x03,0x00,0x00,0x02,0x86,0x6C,
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN17;
	.var = .LN.vPolledQueueProducer..end;
	.byte =
		0x15,0x75,0x73,0x56,0x61,0x6C,0x75,0x65,0x00,0x01,0xB4,0x06,
		0x00,0x00,0x02,0x86,0x72;
	.var = .LN17-.LNvPolledQueueProducer.;
	.byte =
		0x00,0x15,0x78,0x45,0x72,0x72,0x6F,0x72,0x00,0x01,0x76,0x0D,
		0x00,0x00,0x02,0x86,0x74;
	.var = .LN18-.LNvPolledQueueProducer.;
	.byte =
		0x00,0x15,0x78,0x4C,0x6F,0x6F,0x70,0x00,0x01,0x76,0x0D,0x00,
		0x00,0x02,0x86,0x78;
	.var = .LN18-.LNvPolledQueueProducer.;
	.byte =
		0x00,0x00,0x00,0x16,0xC0,0x1C,0x00,0x00,0x76,0x50,0x6F,0x6C,
		0x6C,0x65,0x64,0x51,0x75,0x65,0x75,0x65,0x43,0x6F,0x6E,0x73,
		0x75,0x6D,0x65,0x72,0x00,0x01;
	.var = .LNvPolledQueueConsumer.;
	.var = .LN.vPolledQueueConsumer..end;
	.byte =
		0x01,0x00,0x00,0x17,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xD1,0x03,0x00,0x00,0x02,0x86,0x70,
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN33;
	.var = .LN.vPolledQueueConsumer..end;
	.byte =
		0x15,0x75,0x73,0x44,0x61,0x74,0x61,0x00,0x01,0xB4,0x06,0x00,
		0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x73,
		0x45,0x78,0x70,0x65,0x63,0x74,0x65,0x64,0x56,0x61,0x6C,0x75,
		0x65,0x00,0x01,0xB4,0x06,0x00,0x00,0x02,0x86,0x76;
	.var = .LN33-.LNvPolledQueueConsumer.;
	.byte =
		0x00,0x15,0x78,0x45,0x72,0x72,0x6F,0x72,0x00,0x01,0x76,0x0D,
		0x00,0x00,0x02,0x86,0x78;
	.var = .LN34-.LNvPolledQueueConsumer.;
	.byte =
		0x00,0x00,0x00,0x15,0x78,0x50,0x6F,0x6C,0x6C,0x69,0x6E,0x67,
		0x43,0x6F,0x6E,0x73,0x75,0x6D,0x65,0x72,0x43,0x6F,0x75,0x6E,
		0x74,0x00,0x01,0x0E,0x1D,0x00,0x00,0x05,0x03;
	.var = xPollingConsumerCount.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x50,0x6F,0x6C,0x6C,0x69,
		0x6E,0x67,0x50,0x72,0x6F,0x64,0x75,0x63,0x65,0x72,0x43,0x6F,
		0x75,0x6E,0x74,0x00,0x01,0x0E,0x1D,0x00,0x00,0x05,0x03;
	.var = xPollingProducerCount.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x10,0x76,0x0D,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\Standard_Demo\PollQ.sbn", 7141, 2078;
	.var = .LNxArePollingQueuesStillRunning.;
	.byte =
		0x04,0x01,0x05,0x01,0xDB,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x02,0x10,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x03,0x0D,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x02,0x0E,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.xArePollingQueuesStillRunning..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvStartPolledQueueTasks.;
	.byte =
		0x04,0x01,0x05,0x01,0x6D,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x11,0x0D,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x16,0x11,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.vStartPolledQueueTasks..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvPolledQueueProducer.;
	.byte =
		0x04,0x01,0x05,0x01,0x85,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x0A,0x0A,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x05,0x0C,0x0A,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x03,0x0D,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x04,0x0C,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x08,0x01,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x05,0x04,0x01,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x04,0x0A,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x05,0x05,0x0C,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x06,0x0D,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x05,0x07,0x0A,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x05,0x06,0x0A,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x05,0x33,0x03,0x6B,0x01,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x05,0x0D,0x24,0x00,0x05,0x02;
	.var = .LN.vPolledQueueProducer..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvPolledQueueConsumer.;
	.byte =
		0x04,0x01,0x05,0x01,0xAC,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x05,0x12,0x0A,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x05,0x0C,0x0A,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x03,0x0E,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x05,0x15,0x01,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x05,0x04,0x01,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x05,0x06,0x0D,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x05,0x05,0x0A,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x05,0x06,0x0C,0x00,0x05,0x02;
	.var = .LN46;
	.byte =
		0x05,0x07,0x0D,0x00,0x05,0x02;
	.var = .LN47;
	.byte =
		0x05,0x08,0x0A,0x00,0x05,0x02;
	.var = .LN48;
	.byte =
		0x05,0x07,0x0A,0x00,0x05,0x02;
	.var = .LN49;
	.byte =
		0x05,0x06,0x0A,0x00,0x05,0x02;
	.var = .LN50;
	.byte =
		0x05,0x05,0x0D,0x00,0x05,0x02;
	.var = .LN51;
	.byte =
		0x05,0x04,0x0A,0x00,0x05,0x02;
	.var = .LN52;
	.byte =
		0x05,0x0D,0x0E,0x00,0x05,0x02;
	.var = .LN.vPolledQueueConsumer..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x4B,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x14,0x1D,0x00,0x00,0xE2,0x1A,0x00,0x00,0x78,0x41,0x72,0x65,
		0x50,0x6F,0x6C,0x6C,0x69,0x6E,0x67,0x51,0x75,0x65,0x75,0x65,
		0x73,0x53,0x74,0x69,0x6C,0x6C,0x52,0x75,0x6E,0x6E,0x69,0x6E,
		0x67,0x00,0x3A,0x1B,0x00,0x00,0x76,0x53,0x74,0x61,0x72,0x74,
		0x50,0x6F,0x6C,0x6C,0x65,0x64,0x51,0x75,0x65,0x75,0x65,0x54,
		0x61,0x73,0x6B,0x73,0x00,0x00,0x00,0x00,0x00;
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
	.var = .LNxArePollingQueuesStillRunning.;
	.var = .LN.xArePollingQueuesStillRunning..end-.LNxArePollingQueuesStillRunning.;
	.var = .LNvStartPolledQueueTasks.;
	.var = .LN.vStartPolledQueueTasks..end-.LNvStartPolledQueueTasks.;
	.var = .LNvPolledQueueConsumer.;
	.var = .LN.vPolledQueueConsumer..end-.LNvPolledQueueConsumer.;
	.var = .LNvPolledQueueProducer.;
	.var = .LN.vPolledQueueProducer..end-.LNvPolledQueueProducer.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type xPollingConsumerCount.,STT_OBJECT;
	.byte xPollingConsumerCount.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xPollingProducerCount.,STT_OBJECT;
	.byte xPollingProducerCount.[] =
		0x00,0x00,0x00,0x00;
	.align 8;
	.type .sPollTe.1,STT_OBJECT;
	.byte .sPollTe.1[] =
		0x50,0x6F,0x6C,0x6C,0x5F,0x54,0x65,0x73,0x74,0x5F,0x51,0x75,
		0x65,0x75,0x65,0x00;
	.align 8;
	.type .sQConsN.2,STT_OBJECT;
	.byte .sQConsN.2[] =
		0x51,0x43,0x6F,0x6E,0x73,0x4E,0x42,0x00;
	.align 8;
	.type .sQProdN.3,STT_OBJECT;
	.byte .sQProdN.3[] =
		0x51,0x50,0x72,0x6F,0x64,0x4E,0x42,0x00;
