	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\flash.c";
//  Compilation time: Thu Oct 24 14:40:19 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\Standard_Demo -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo Standard_Demo\flash.d -o Standard_Demo\flash.doj
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

vStartLEDFlashTasks.:
.LNvStartLEDFlashTasks.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\flash.c":74
	modify(i7,-2) (nw);
	dm(-3,i6)=r4;
.LN0:
// line 78
	dm(-2,i6)=m13;

.P35L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\flash.c" line 78 col 2
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 22 
//   cycles (includes 2 stalls but excludes the cost of function calls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used  16 out of   22 ( 72.7%)
//     pm dag                          used  15 out of   22 ( 68.2%)
//     shift immediate                 used  15 out of   22 ( 68.2%)
//     multifunction alu               used  10 out of   22 ( 45.5%)
//     multifunction float multiply    used  10 out of   22 ( 45.5%)
//     multifunction integer add sub   used  10 out of   22 ( 45.5%)
//     multifunction integer multiply  used  10 out of   22 ( 45.5%)
//     multifunction mult              used  10 out of   22 ( 45.5%)
//     memory access                   used  16 out of   44 ( 36.4%)
//-------------------------------------------------------------------
	// -- 2 stalls --
	r2=dm(-2,i6);
	r1=3;
	compu(r2,r1);
	if ge jump (pc,.P35L3);

.LN1:
// line 81
	r2=dm(-3,i6);
.LN2:
	r12=200;
	r8=.sLEDx.0;
	r4=vLEDFlashTask.;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	dm(i7,m7)=r2;
	dm(i7,m7)=m13;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
	modify(i7,4) (nw);
.LN3:
// line 78
	r2=dm(-2,i6);
	r2=r2+1;
	dm(-2,i6)=r2;
	jump (pc,.P35L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P35L3:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN4:
// line 83
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vStartLEDFlashTasks..end:
.vStartLEDFlashTasks..end:
	.global vStartLEDFlashTasks.;
	.type vStartLEDFlashTasks.,STT_FUNC;

vLEDFlashTask.:
.LNvLEDFlashTask.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,acc,mcc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
//  Original Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\flash.c" line 119 col 3 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
//  Original Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\flash.c" line 123 col 3 - loop structure removed due to dead code elimination.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\flash.c":87
	modify(i7,-6) (nw);
	dm(-6,i6)=r15;
	dm(-5,i6)=r4;
.LN5:
// line 95
	cjump vPortEnterCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN6:
// line 98
	r2=dm(uxFlashTaskNumber.);
	dm(-2,i6)=r2;
.LN7:
// line 101
	r2=dm(uxFlashTaskNumber.);
	r2=r2+1;
	dm(uxFlashTaskNumber.)=r2;
.LN8:
// line 103
	cjump vPortExitCritical. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
.LN9:
// line 105
	r2=dm(-2,i6);
	r1=333;
	r8=r2*r1 (ssi);
	r12=333;
	r2=r8+r12;
	dm(-4,i6)=r2;
.LN10:
// line 110
	r2=lshift r2 by -1;
	dm(-4,i6)=r2;
.LN11:
// line 114
	cjump xTaskGetTickCount. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
.LN12:
	dm(-3,i6)=r0;

.P36L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\flash.c" line 116 col 2
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 23 
//   cycles (includes 2 stalls but excludes the cost of function calls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used  13 out of   23 ( 56.5%)
//     pm dag                          used  13 out of   23 ( 56.5%)
//     shift immediate                 used  13 out of   23 ( 56.5%)
//     memory access                   used  13 out of   46 ( 28.3%)
//     multifunction alu               used   6 out of   23 ( 26.1%)
//     multifunction float multiply    used   6 out of   23 ( 26.1%)
//     multifunction integer add sub   used   6 out of   23 ( 26.1%)
//     multifunction integer multiply  used   6 out of   23 ( 26.1%)
//     multifunction mult              used   6 out of   23 ( 26.1%)
//-------------------------------------------------------------------

	// -- 2 stalls --
.LN13:
// line 119
	r8=dm(-4,i6);
.LN14:
	i4=modify(i6,-3) (nw);
	r15=i4;
	r4=r15;
	cjump xTaskDelayUntil. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:

.LN15:
// line 120
	r4=dm(-2,i6);
.LN16:
	cjump vParTestToggleLED. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:

.LN17:
// line 123
	r8=dm(-4,i6);
.LN18:
	r4=r15;
	cjump xTaskDelayUntil. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:

.LN19:
// line 124
	r4=dm(-2,i6);
.LN20:
	cjump vParTestToggleLED. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
	jump (pc,.P36L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.vLEDFlashTask..end:
.vLEDFlashTask..end:
	.type vLEDFlashTask.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="llabs.";
	.file_attr FuncName="llmin.";
	.file_attr FuncName="llmax.";
	.file_attr FuncName="vStartLEDFlashTasks.";
	.file_attr FuncName="vLEDFlashTask.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern xTaskCreate.;
	.type xTaskCreate.,STT_FUNC;
	.extern vPortEnterCritical.;
	.type vPortEnterCritical.,STT_FUNC;
	.extern vPortExitCritical.;
	.type vPortExitCritical.,STT_FUNC;
	.extern xTaskGetTickCount.;
	.type xTaskGetTickCount.,STT_FUNC;
	.extern xTaskDelayUntil.;
	.type xTaskDelayUntil.,STT_FUNC;
	.extern vParTestToggleLED.;
	.type vParTestToggleLED.,STT_FUNC;

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\Standard_Demo\flash.sbn", 0, 286;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x8E,0x1B,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x44,0x65,0x6D,0x6F,0x5C,
		0x43,0x6F,0x6D,0x6D,0x6F,0x6E,0x5C,0x4D,0x69,0x6E,0x69,0x6D,
		0x61,0x6C,0x5C,0x66,0x6C,0x61,0x73,0x68,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\Standard_Demo\flash.sbn", 286, 6725;
	.var = .LNvStartLEDFlashTasks.;
	.var = .LN.vStartLEDFlashTasks..end;
	.byte =
		0x01,0x01,0x00,0x14,0x75,0x78,0x50,0x72,0x69,0x6F,0x72,0x69,
		0x74,0x79,0x00,0x87,0x0D,0x00,0x00,0x02,0x86,0x74,0x00,0x15,
		0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.vStartLEDFlashTasks..end;
	.byte =
		0x16,0x78,0x4C,0x45,0x44,0x54,0x61,0x73,0x6B,0x00,0x01,0x87,
		0x0D,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,0x00,
		0x00,0x13,0x6E,0x1B,0x00,0x00,0x76,0x4C,0x45,0x44,0x46,0x6C,
		0x61,0x73,0x68,0x54,0x61,0x73,0x6B,0x00,0x01;
	.var = .LNvLEDFlashTask.;
	.var = .LN.vLEDFlashTask..end;
	.byte =
		0x01,0x00,0x00,0x14,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xD1,0x03,0x00,0x00,0x02,0x86,0x6C,
		0x00,0x15,0x00,0x00,0x00,0x00;
	.var = .LN5;
	.var = .LN.vLEDFlashTask..end;
	.byte =
		0x16,0x78,0x46,0x6C,0x61,0x73,0x68,0x52,0x61,0x74,0x65,0x00,
		0x01,0x99,0x0D,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,
		0x00,0x16,0x78,0x4C,0x61,0x73,0x74,0x46,0x6C,0x61,0x73,0x68,
		0x54,0x69,0x6D,0x65,0x00,0x01,0x99,0x0D,0x00,0x00,0x02,0x86,
		0x74,0x00,0x00,0x00,0x00,0x00,0x16,0x75,0x78,0x4C,0x45,0x44,
		0x00,0x01,0x87,0x0D,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,
		0x00,0x00,0x00,0x00,0x16,0x75,0x78,0x46,0x6C,0x61,0x73,0x68,
		0x54,0x61,0x73,0x6B,0x4E,0x75,0x6D,0x62,0x65,0x72,0x00,0x01,
		0x6B,0x15,0x00,0x00,0x05,0x03;
	.var = uxFlashTaskNumber.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\Standard_Demo\flash.sbn", 7011, 2079;
	.var = .LNvStartLEDFlashTasks.;
	.byte =
		0x04,0x01,0x05,0x01,0x52,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x02,0x0D,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x34,0x03,0x7D,0x01,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x01,0x0E,0x00,0x05,0x02;
	.var = .LN.vStartLEDFlashTasks..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvLEDFlashTask.;
	.byte =
		0x04,0x01,0x05,0x01,0x5F,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x02,0x11,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x24,0x0D,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x03,0x0E,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x14,0x01,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x14,0x01,0x00,0x05,0x02;
	.var = .LN.vLEDFlashTask..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x26,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x92,0x1B,0x00,0x00,0x81,0x1A,0x00,0x00,0x76,0x53,0x74,0x61,
		0x72,0x74,0x4C,0x45,0x44,0x46,0x6C,0x61,0x73,0x68,0x54,0x61,
		0x73,0x6B,0x73,0x00,0x00,0x00,0x00,0x00;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0x24,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNvStartLEDFlashTasks.;
	.var = .LN.vStartLEDFlashTasks..end-.LNvStartLEDFlashTasks.;
	.var = .LNvLEDFlashTask.;
	.var = .LN.vLEDFlashTask..end-.LNvLEDFlashTask.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type uxFlashTaskNumber.,STT_OBJECT;
	.byte uxFlashTaskNumber.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type .sLEDx.0,STT_OBJECT;
	.byte .sLEDx.0[] =
		0x4C,0x45,0x44,0x78,0x00;
