	.file "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c";
//  Compilation time: Thu Oct 24 14:40:18 2024
//  Compiler options: -c -file-attr ProjectName=RTOSDemo_CCES_SHARC_21569 -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output .\Standard_Demo -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/osal -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/system -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/Include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Demo/Common/include -ID:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/SHARC_ADSP_21569_CCES/RTOSDemo_CCES_SHARC_21569/../../../Source/portable/CCES/SHARC_215xx -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo Standard_Demo\StaticAllocation.d -o Standard_Demo\StaticAllocation.doj
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

xAreStaticAllocationTasksStillRunning.:
.LNxAreStaticAllocationTasksStillRunning.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0-r2,i12,acc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":1093
	modify(i7,-2) (nw);
.LN0:
// line 1097
	r2=dm(uxCycleCounter.);
	r1=dm(uxLastCycleCounter.0.);
	comp(r2,r1);
	if ne jump (pc,.P39L2);

.LN1:
// line 1099
	dm(xErrorOccurred.)=m6;
.LN2:
// line 1100
	jump (pc,.P39L3);

.P39L2:
.LN3:
// line 1103
	r2=dm(uxCycleCounter.);
	dm(uxLastCycleCounter.0.)=r2;

.P39L3:
.LN4:
// line 1106
	r2=dm(xErrorOccurred.);
	r2=pass r2;
	if eq jump (pc,.P39L5);

.LN5:
// line 1108
	dm(-2,i6)=m13;
.LN6:
// line 1109
	jump (pc,.P39L6);

.P39L5:
.LN7:
// line 1112
	dm(-2,i6)=m14;

.P39L6:
.LN8:
// line 1115
	r0=dm(-2,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.xAreStaticAllocationTasksStillRunning..end:
.xAreStaticAllocationTasksStillRunning..end:
	.global xAreStaticAllocationTasksStillRunning.;
	.type xAreStaticAllocationTasksStillRunning.,STT_FUNC;

prvRand.:
.LNprvRand.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r0-r2,i12,acc,mcc,scc}
//  No call preserved registers used.
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":829
	modify(i7,-2) (nw);
.LN9:
// line 830
	i12=22695477;
	dm(-3,i6)=i12;
.LN10:
	dm(-2,i6)=m14;
.LN11:
// line 833
	r1=dm(ulNextRand.);
	r2=i12;
	r2=r1*r2 (ssi);
	r2=r2+1;
	dm(ulNextRand.)=r2;
.LN12:
// line 834
	r2=lshift r2 by -16;
	r0=fext r2 by 0:15;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvRand..end:
.prvRand..end:
	.type prvRand.,STT_FUNC;

vStartStaticallyAllocatedTasks.:
.LNvStartStaticallyAllocatedTasks.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
.LN13:
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":221
	r2=xCreatorTaskTCBBuffer.;
	r1=uxCreatorTaskStackBuffer.;
	r0=2;
	r12=400;
	r8=.sStatCr.1;
	r4=prvStaticallyAllocatedCreator.;
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	dm(i7,m7)=r0;
	dm(i7,m7)=m13;
	cjump xTaskCreateStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ0-1;
.LCJ0:
	modify(i7,4) (nw);
.LN14:
// line 228
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.vStartStaticallyAllocatedTasks..end:
.vStartStaticallyAllocatedTasks..end:
	.global vStartStaticallyAllocatedTasks.;
	.type vStartStaticallyAllocatedTasks.,STT_FUNC;

prvTimerCallback.:
.LNprvTimerCallback.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i4,i12,acc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":563
	modify(i7,-4) (nw);
	dm(-5,i6)=r15;
	dm(-4,i6)=r4;
.LN15:
// line 570
	cjump pvTimerGetTimerID. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ1-1;
.LCJ1:
.LN16:
	dm(-3,i6)=r0;
	i4=r0;
.LN17:
// line 573
	r2=dm(i4,m5);
	r2=r2+1;
	dm(i4,m5)=r2;
.LN18:
// line 577
	i4=dm(-3,i6);
	r2=dm(i4,m5);
	r1=5;
	comp(r2,r1);
	if ne jump (pc,.P45L2);

.LN19:
// line 581
	r4=dm(-4,i6);
.LN20:
	r15=m5;
	r8=3;
	dm(i7,m7)=m13;
	dm(i7,m7)=m13;
	r12=m5;
	cjump xTimerGenericCommand. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ2-1;
.LCJ2:
	modify(i7,2) (nw);
.LN21:
	dm(-2,i6)=r0;
	r2=btgl r0 by r15;
.LN22:
// line 583
	if sz jump (pc,.P45L5);

.LN23:
// line 585
	dm(xErrorOccurred.)=m6;
.LN24:
// line 586
	jump (pc,.P45L6);

.P45L5:

.P45L6:
.LN25:
// line 587
	jump (pc,.P45L3);

.P45L2:

.P45L3:
.LN26:
// line 588
	r15=dm(-5,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvTimerCallback..end:
.prvTimerCallback..end:
	.type prvTimerCallback.,STT_FUNC;

prvCreateAndDeleteStaticallyAllocatedTimers.:
.LNprvCreateAndDeleteStaticallyAllocatedTimers.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 112 bytes
//  Scratch registers used: {r2,r4,r8,r12,i4,i12,acc,mcc,scc}
//  Call preserved registers used: {r9-r11,r13,r15,i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":592
	modify(i7,-22) (nw);
	dm(-22,i6)=r9;
	dm(-21,i6)=r10;
	dm(-20,i6)=r11;
	dm(-19,i6)=r13;
	dm(-18,i6)=r15;
	r2=i5;
	dm(-17,i6)=r2;
.LN27:
// line 595
	i12=20;
	dm(-3,i6)=i12;
.LN28:
// line 612
	i4=modify(i6,-4) (nw);
	i5=modify(i6,-16) (nw);
	r2=i5;
	r11=prvTimerCallback.;
	r15=i4;
	r8=20;
	r13=.sT1.2;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	dm(i7,m7)=r11;
	dm(i7,m7)=r15;
	r12=m6;
	r4=r13;
	cjump xTimerCreateStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ3-1;
.LCJ3:
	modify(i7,4) (nw);
.LN29:
	dm(-5,i6)=r0;
	r2=i5;
	comp(r2,r0);
.LN30:
// line 621
	if eq jump (pc,.P50L2);

.LN31:
	r8=621;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ4-1;
.LCJ4:
.LN32:
	jump (pc,.P50L3);

.P50L2:

.P50L3:
.LN33:
// line 625
	dm(-4,i6)=m13;
.LN34:
// line 628
	cjump xTaskGetTickCount. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ5-1;
.LCJ5:
	r12=r0;
.LN35:
	r4=dm(-5,i6);
.LN36:
	dm(i7,m7)=m13;
	dm(i7,m7)=m13;
	r8=m6;
	cjump xTimerGenericCommand. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ6-1;
.LCJ6:
	modify(i7,2) (nw);
.LN37:
	dm(-2,i6)=r0;
	r10=m5;
	r2=btgl r0 by r10;
.LN38:
// line 630
	if sz jump (pc,.P50L5);

.LN39:
// line 632
	dm(xErrorOccurred.)=m6;
.LN40:
// line 633
	jump (pc,.P50L6);

.P50L5:

.P50L6:
.LN41:
// line 635
	r2=dm(-3,i6);
	r9=5;
	r4=r2*r9 (ssi);
.LN42:
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ7-1;
.LCJ7:
.LN43:
// line 639
	r2=dm(-4,i6);
	comp(r2,r9);
	if eq jump (pc,.P50L8);

.LN44:
// line 641
	dm(xErrorOccurred.)=m6;
.LN45:
// line 642
	jump (pc,.P50L9);

.P50L8:

.P50L9:
.LN46:
// line 645
	r4=dm(-5,i6);
.LN47:
	dm(i7,m7)=m13;
	dm(i7,m7)=m13;
	r12=m5;
	r8=5;
	cjump xTimerGenericCommand. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ8-1;
.LCJ8:
	modify(i7,2) (nw);
.LN48:
	dm(-2,i6)=r0;
	r2=btgl r0 by r10;
.LN49:
// line 649
	if sz jump (pc,.P50L11);

.LN50:
// line 651
	dm(xErrorOccurred.)=m6;
.LN51:
// line 652
	jump (pc,.P50L12);

.P50L11:

.P50L12:
.LN52:
// line 655
	r2=dm(uxCycleCounter.);
	r2=r2+1;
	dm(uxCycleCounter.)=r2;
.LN53:
// line 662
	r8=dm(-3,i6);
.LN54:
	dm(i7,m7)=r11;
	dm(i7,m7)=r15;
	r12=m6;
	r4=r13;
	cjump xTimerCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ9-1;
.LCJ9:
	modify(i7,2) (nw);
.LN55:
	dm(-5,i6)=r0;
	r2=pass r0;
.LN56:
// line 668
	if ne jump (pc,.P50L14);

.LN57:
	r8=668;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ10-1;
.LCJ10:
.LN58:
	jump (pc,.P50L15);

.P50L14:

.P50L15:
.LN59:
// line 670
	dm(-4,i6)=m13;
.LN60:
// line 671
	cjump xTaskGetTickCount. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ11-1;
.LCJ11:
	r12=r0;
.LN61:
	r4=dm(-5,i6);
.LN62:
	dm(i7,m7)=m13;
	dm(i7,m7)=m13;
	r8=m6;
	cjump xTimerGenericCommand. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ12-1;
.LCJ12:
	modify(i7,2) (nw);
.LN63:
	dm(-2,i6)=r0;
	r2=btgl r0 by r10;
.LN64:
// line 673
	if sz jump (pc,.P50L17);

.LN65:
// line 675
	dm(xErrorOccurred.)=m6;
.LN66:
// line 676
	jump (pc,.P50L18);

.P50L17:

.P50L18:
.LN67:
// line 678
	r2=dm(-3,i6);
	r4=r2*r9 (ssi);
.LN68:
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ13-1;
.LCJ13:
.LN69:
// line 680
	r2=dm(-4,i6);
	comp(r2,r9);
	if eq jump (pc,.P50L20);

.LN70:
// line 682
	dm(xErrorOccurred.)=m6;
.LN71:
// line 683
	jump (pc,.P50L21);

.P50L20:

.P50L21:
.LN72:
// line 685
	r4=dm(-5,i6);
.LN73:
	dm(i7,m7)=m13;
	dm(i7,m7)=m13;
	r12=m5;
	r8=5;
	cjump xTimerGenericCommand. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ14-1;
.LCJ14:
	modify(i7,2) (nw);
.LN74:
	dm(-2,i6)=r0;
	r2=btgl r0 by r10;
.LN75:
// line 687
	if sz jump (pc,.P50L23);

.LN76:
// line 689
	dm(xErrorOccurred.)=m6;
.LN77:
// line 690
	jump (pc,.P50L24);

.P50L23:

.P50L24:
.LN78:
// line 693
	i5=dm(-17,i6);
	r9=dm(-22,i6);
	r10=dm(-21,i6);
	r11=dm(-20,i6);
	r13=dm(-19,i6);
	r15=dm(-18,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvCreateAndDeleteStaticallyAllocatedTimers..end:
.prvCreateAndDeleteStaticallyAllocatedTimers..end:
	.type prvCreateAndDeleteStaticallyAllocatedTimers.,STT_FUNC;

prvCreateAndDeleteStaticallyAllocatedTasks.:
.LNprvCreateAndDeleteStaticallyAllocatedTasks.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 144 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,scc}
//  Call preserved registers used: {r11,r13,r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":742
	modify(i7,-30) (nw);
	dm(-30,i6)=r11;
	dm(-29,i6)=r13;
	dm(-28,i6)=r15;
.LN79:
// line 766
	r15=m5;
	r4=m5;
	cjump uxTaskPriorityGet. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ15-1;
.LCJ15:
.LN80:
// line 761
	r1=r0+1;
.LN81:
	i4=modify(i6,-27) (nw);
	r2=i4;
	r0=uxStackBuffer.4.;
	r13=.sStatic.5;
	r11=prvStaticallyAllocatedTask.;
	dm(i7,m7)=r2;
	dm(i7,m7)=r0;
	dm(i7,m7)=r1;
	dm(i7,m7)=m13;
	r12=200;
	r8=r13;
	r4=r11;
	cjump xTaskCreateStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ16-1;
.LCJ16:
	r4=r0;
	modify(i7,4) (nw);
.LN82:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN83:
// line 771
	if ne jump (pc,.P58L2);

.LN84:
// line 773
	dm(xErrorOccurred.)=m6;
.LN85:
// line 774
	jump (pc,.P58L3);

.P58L2:
.LN86:
// line 775
	cjump eTaskGetState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ17-1;
.LCJ17:
	r2=3;
	comp(r0,r2);
.LN87:
	if eq jump (pc,.P58L5);

.LN88:
// line 779
	dm(xErrorOccurred.)=m6;
.LN89:
// line 780
	jump (pc,.P58L6);

.P58L5:
.LN90:
// line 783
	r4=dm(-3,i6);
.LN91:
	cjump vTaskDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ18-1;
.LCJ18:

.P58L6:

.P58L3:
.LN92:
// line 798
	r4=m5;
	cjump uxTaskPriorityGet. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ19-1;
.LCJ19:
.LN93:
// line 793
	r1=r0+1;
.LN94:
	i4=modify(i6,-3) (nw);
	r2=i4;
	modify(i7,m7) (nw);
	dm(i7,m7)=r2;
	dm(i7,m7)=r1;
	dm(i7,m7)=m13;
	r12=200;
	r8=r13;
	r4=r11;
	cjump xTaskCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ20-1;
.LCJ20:
	modify(i7,4) (nw);
.LN95:
	dm(-2,i6)=r0;
.LN96:
// line 801
	r4=dm(-3,i6);
.LN97:
	cjump eTaskGetState. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ21-1;
.LCJ21:
	r2=3;
	comp(r0,r2);
.LN98:
	if eq jump (pc,.P58L8);

.LN99:
// line 803
	dm(xErrorOccurred.)=m6;
.LN100:
// line 804
	jump (pc,.P58L9);

.P58L8:

.P58L9:
.LN101:
// line 806
	r2=dm(-2,i6);
	r2=btgl r2 by r15;
	if sz jump (pc,.P58L11);

.LN102:
	r8=806;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ22-1;
.LCJ22:
.LN103:
	jump (pc,.P58L12);

.P58L11:

.P58L12:
.LN104:
// line 807
	r2=dm(-2,i6);
	r2=btgl r2 by r15;
	if sz jump (pc,.P58L14);

.LN105:
// line 809
	dm(xErrorOccurred.)=m6;
.LN106:
// line 810
	jump (pc,.P58L15);

.P58L14:

.P58L15:
.LN107:
// line 811
	r4=dm(-3,i6);
.LN108:
	cjump vTaskDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ23-1;
.LCJ23:
.LN109:
// line 814
	r11=dm(-30,i6);
	r13=dm(-29,i6);
	r15=dm(-28,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvCreateAndDeleteStaticallyAllocatedTasks..end:
.prvCreateAndDeleteStaticallyAllocatedTasks..end:
	.type prvCreateAndDeleteStaticallyAllocatedTasks.,STT_FUNC;

prvStaticallyAllocatedTask.:
.LNprvStaticallyAllocatedTask.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r4,i12}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":818
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;
.LN110:
// line 824
	r4=m5;
	cjump vTaskSuspend. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ24-1;
.LCJ24:
.LN111:
// line 825
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvStaticallyAllocatedTask..end:
.prvStaticallyAllocatedTask..end:
	.type prvStaticallyAllocatedTask.,STT_FUNC;

prvGetNextDelayTime.:
.LNprvGetNextDelayTime.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r0-r2,r4,r8,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":839
	modify(i7,-4) (nw);
.LN112:
// line 841
	i12=150;
	dm(-4,i6)=i12;
.LN113:
// line 842
	i12=75;
	dm(-3,i6)=i12;
.LN114:
// line 843
	i12=2;
	dm(-2,i6)=i12;
.LN115:
// line 848
	jump (pc,.P65L1);

.P65L3:
//-------------------------------------------------------------------
//   Part of Loop 1, depth 1
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P65L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c" line 848 col 2
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 19 
//   cycles (includes 2 stalls but excludes the cost of function calls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used  10 out of   19 ( 52.6%)
//     pm dag                          used  10 out of   19 ( 52.6%)
//     shift immediate                 used  10 out of   19 ( 52.6%)
//     memory access                   used  10 out of   38 ( 26.3%)
//     multifunction alu               used   5 out of   19 ( 26.3%)
//     multifunction float multiply    used   5 out of   19 ( 26.3%)
//     multifunction integer add sub   used   5 out of   19 ( 26.3%)
//     multifunction integer multiply  used   5 out of   19 ( 26.3%)
//     multifunction mult              used   5 out of   19 ( 26.3%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN116:
// line 850
	cjump prvRand. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ25-1;
.LCJ25:
	r4=r0;
.LN117:
	r8=dm(-4,i6);
	cjump __divrem_u32. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ26-1;// modulo is implemented as a library call. 
.LCJ26:
	dm(-5,i6)=r1;
.LN118:
// line 853
	r4=dm(-2,i6);
.LN119:
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ27-1;
.LCJ27:
.LN120:
// line 855
	r2=dm(-5,i6);
	r1=dm(-3,i6);
	compu(r2,r1);
	if lt jump (pc,.P65L3);

//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN121:
// line 857
	r0=dm(-5,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvGetNextDelayTime..end:
.prvGetNextDelayTime..end:
	.type prvGetNextDelayTime.,STT_FUNC;

prvSanityCheckCreatedEventGroup.:
.LNprvSanityCheckCreatedEventGroup.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r1-r2,r4,r8,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":862
	modify(i7,-4) (nw);
	dm(-5,i6)=r4;
.LN122:
// line 864
	i12=170;
	dm(-3,i6)=i12;
.LN123:
	i12=85;
	dm(-2,i6)=i12;
.LN124:
// line 867
	r8=m5;
	cjump xEventGroupClearBits. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ28-1;
.LCJ28:
.LN125:
	dm(-4,i6)=r0;
	r2=pass r0;
.LN126:
// line 869
	if eq jump (pc,.P67L2);

.LN127:
// line 871
	dm(xErrorOccurred.)=m6;
.LN128:
// line 872
	jump (pc,.P67L3);

.P67L2:

.P67L3:
.LN129:
// line 875
	r4=dm(-5,i6);
	r8=dm(-3,i6);
.LN130:
	cjump xEventGroupSetBits. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ29-1;
.LCJ29:
.LN131:
// line 877
	r4=dm(-5,i6);
.LN132:
	r8=m5;
	cjump xEventGroupClearBits. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ30-1;
.LCJ30:
.LN133:
	dm(-4,i6)=r0;
.LN134:
// line 879
	r2=dm(-3,i6);
	comp(r0,r2);
	if eq jump (pc,.P67L5);

.LN135:
// line 881
	dm(xErrorOccurred.)=m6;
.LN136:
// line 882
	jump (pc,.P67L6);

.P67L5:

.P67L6:
.LN137:
// line 884
	r4=dm(-5,i6);
	r8=dm(-2,i6);
.LN138:
	cjump xEventGroupSetBits. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ31-1;
.LCJ31:
.LN139:
// line 886
	r4=dm(-5,i6);
.LN140:
	r8=m5;
	cjump xEventGroupClearBits. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ32-1;
.LCJ32:
.LN141:
	dm(-4,i6)=r0;
.LN142:
// line 888
	r2=dm(-3,i6);
	r1=dm(-2,i6);
	r2=r2 or r1;
	comp(r0,r2);
	if eq jump (pc,.P67L8);

.LN143:
// line 890
	dm(xErrorOccurred.)=m6;
.LN144:
// line 891
	jump (pc,.P67L9);

.P67L8:

.P67L9:
.LN145:
// line 895
	r4=dm(-5,i6);
	r8=dm(-3,i6);
.LN146:
	cjump xEventGroupClearBits. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ33-1;
.LCJ33:
.LN147:
// line 897
	r4=dm(-5,i6);
.LN148:
	r8=m5;
	cjump xEventGroupClearBits. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ34-1;
.LCJ34:
.LN149:
	dm(-4,i6)=r0;
.LN150:
// line 899
	r2=dm(-2,i6);
	comp(r0,r2);
	if eq jump (pc,.P67L11);

.LN151:
// line 901
	dm(xErrorOccurred.)=m6;
.LN152:
// line 902
	jump (pc,.P67L12);

.P67L11:

.P67L12:
.LN153:
// line 903
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvSanityCheckCreatedEventGroup..end:
.prvSanityCheckCreatedEventGroup..end:
	.type prvSanityCheckCreatedEventGroup.,STT_FUNC;

prvCreateAndDeleteStaticallyAllocatedEventGroups.:
.LNprvCreateAndDeleteStaticallyAllocatedEventGroups.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 48 bytes
//  Scratch registers used: {r2,r4,r8,i4,i12,acc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":697
	modify(i7,-10) (nw);
	dm(-11,i6)=r15;
.LN154:
// line 714
	i4=modify(i6,-10) (nw);
	r15=i4;
	r4=r15;
	cjump xEventGroupCreateStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ35-1;
.LCJ35:
.LN155:
	dm(-2,i6)=r0;
	comp(r15,r0);
.LN156:
// line 718
	if eq jump (pc,.P70L2);

.LN157:
	r8=718;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ36-1;
.LCJ36:
.LN158:
	jump (pc,.P70L3);

.P70L2:

.P70L3:
.LN159:
// line 722
	r4=dm(-2,i6);
.LN160:
	cjump prvSanityCheckCreatedEventGroup. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ37-1;
.LCJ37:
.LN161:
// line 725
	r4=dm(-2,i6);
.LN162:
	cjump vEventGroupDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ38-1;
.LCJ38:
.LN163:
// line 732
	cjump xEventGroupCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ39-1;
.LCJ39:
.LN164:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN165:
// line 733
	if ne jump (pc,.P70L5);

.LN166:
	r8=733;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ40-1;
.LCJ40:
.LN167:
	jump (pc,.P70L6);

.P70L5:

.P70L6:
.LN168:
// line 734
	r4=dm(-2,i6);
.LN169:
	cjump prvSanityCheckCreatedEventGroup. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ41-1;
.LCJ41:
.LN170:
// line 735
	r4=dm(-2,i6);
.LN171:
	cjump vEventGroupDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ42-1;
.LCJ42:
.LN172:
// line 738
	r15=dm(-11,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvCreateAndDeleteStaticallyAllocatedEventGroups..end:
.prvCreateAndDeleteStaticallyAllocatedEventGroups..end:
	.type prvCreateAndDeleteStaticallyAllocatedEventGroups.,STT_FUNC;

prvSanityCheckCreatedSemaphore.:
.LNprvSanityCheckCreatedSemaphore.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 40 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i12,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":907
	modify(i7,-6) (nw);
	dm(-6,i6)=r8;
	dm(-7,i6)=r4;
.LN173:
// line 910
	i12=10;
	dm(-3,i6)=i12;
.LN174:
// line 915
	cjump xTaskGetTickCount. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ43-1;
.LCJ43:
.LN175:
	dm(-2,i6)=r0;
.LN176:
// line 916
	r4=dm(-7,i6);
	r8=dm(-3,i6);
.LN177:
	cjump xQueueSemaphoreTake. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ44-1;
.LCJ44:
.LN178:
	dm(-5,i6)=r0;
.LN179:
// line 918
	cjump xTaskGetTickCount. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ45-1;
.LCJ45:
.LN180:
	r2=dm(-2,i6);
	r2=r0-r2;
	r1=dm(-3,i6);
	compu(r1,r2);
	if le jump (pc,.P74L2);

.LN181:
// line 921
	dm(xErrorOccurred.)=m6;
.LN182:
// line 922
	jump (pc,.P74L3);

.P74L2:

.P74L3:
.LN183:
// line 924
	r2=dm(-5,i6);
	r2=pass r2;
	if eq jump (pc,.P74L5);

.LN184:
// line 926
	dm(xErrorOccurred.)=m6;
.LN185:
// line 927
	jump (pc,.P74L6);

.P74L5:

.P74L6:
.LN186:
// line 931
	dm(-4,i6)=m13;

.P74L7:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c" line 931 col 2
//-------------------------------------------------------------------
	r2=dm(-4,i6);
	r1=dm(-6,i6);
	compu(r1,r2);
	if le jump (pc,.P74L9);

.LN187:
// line 933
	r4=dm(-7,i6);
.LN188:
	r8=m5;
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	r12=m5;
	cjump xQueueGenericSend. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ46-1;
.LCJ46:
	modify(i7,2) (nw);
.LN189:
	dm(-5,i6)=r0;
	r2=pass r0;
.LN190:
// line 935
	if ne jump (pc,.P74L11);

.LN191:
// line 937
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN192:
// line 938
	jump (pc,.P74L12);

.P74L11:

.P74L12:
.LN193:
// line 931
	r2=dm(-4,i6);
	r2=r2+1;
	dm(-4,i6)=r2;
	jump (pc,.P74L7);
//-------------------------------------------------------------------
//   End Loop L7
//-------------------------------------------------------------------

.P74L9:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN194:
// line 942
	r4=dm(-7,i6);
.LN195:
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	r12=m5;
	r8=m5;
	cjump xQueueGenericSend. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ47-1;
.LCJ47:
	modify(i7,2) (nw);
.LN196:
	dm(-5,i6)=r0;
	r2=pass r0;
.LN197:
// line 944
	if eq jump (pc,.P74L14);

.LN198:
// line 946
	dm(xErrorOccurred.)=m6;
.LN199:
// line 947
	jump (pc,.P74L15);

.P74L14:

.P74L15:
.LN200:
// line 949
	r4=dm(-7,i6);
.LN201:
	cjump uxQueueMessagesWaiting. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ48-1;
.LCJ48:
.LN202:
	r2=dm(-6,i6);
	comp(r0,r2);
	if eq jump (pc,.P74L17);

.LN203:
	r8=949;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ49-1;
.LCJ49:
.LN204:
	jump (pc,.P74L18);

.P74L17:

.P74L18:
.LN205:
// line 953
	dm(-4,i6)=m13;

.P74L19:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c" line 953 col 2
//-------------------------------------------------------------------
	r2=dm(-4,i6);
	r1=dm(-6,i6);
	compu(r1,r2);
	if le jump (pc,.P74L21);

.LN206:
// line 955
	r4=dm(-7,i6);
.LN207:
	r8=m5;
	cjump xQueueSemaphoreTake. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ50-1;
.LCJ50:
.LN208:
	dm(-5,i6)=r0;
	r2=pass r0;
.LN209:
// line 957
	if ne jump (pc,.P74L23);

.LN210:
// line 959
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN211:
// line 960
	jump (pc,.P74L24);

.P74L23:

.P74L24:
.LN212:
// line 953
	r2=dm(-4,i6);
	r2=r2+1;
	dm(-4,i6)=r2;
	jump (pc,.P74L19);
//-------------------------------------------------------------------
//   End Loop L19
//-------------------------------------------------------------------

.P74L21:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN213:
// line 965
	cjump xTaskGetTickCount. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ51-1;
.LCJ51:
.LN214:
	dm(-2,i6)=r0;
.LN215:
// line 966
	r4=dm(-7,i6);
	r8=dm(-3,i6);
.LN216:
	cjump xQueueSemaphoreTake. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ52-1;
.LCJ52:
.LN217:
	dm(-5,i6)=r0;
.LN218:
// line 968
	cjump xTaskGetTickCount. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ53-1;
.LCJ53:
.LN219:
	r2=dm(-2,i6);
	r2=r0-r2;
	r1=dm(-3,i6);
	compu(r1,r2);
	if le jump (pc,.P74L26);

.LN220:
// line 971
	dm(xErrorOccurred.)=m6;
.LN221:
// line 972
	jump (pc,.P74L27);

.P74L26:

.P74L27:
.LN222:
// line 974
	r2=dm(-5,i6);
	r2=pass r2;
	if eq jump (pc,.P74L29);

.LN223:
// line 976
	dm(xErrorOccurred.)=m6;
.LN224:
// line 977
	jump (pc,.P74L30);

.P74L29:

.P74L30:
.LN225:
// line 979
	r4=dm(-7,i6);
.LN226:
	cjump uxQueueMessagesWaiting. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ54-1;
.LCJ54:
	r2=pass r0;
.LN227:
	if eq jump (pc,.P74L32);

.LN228:
	r8=979;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ55-1;
.LCJ55:
.LN229:
	jump (pc,.P74L33);

.P74L32:

.P74L33:
.LN230:
// line 980
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvSanityCheckCreatedSemaphore..end:
.prvSanityCheckCreatedSemaphore..end:
	.type prvSanityCheckCreatedSemaphore.,STT_FUNC;

prvCreateAndDeleteStaticallyAllocatedCountingSemaphores.:
.LNprvCreateAndDeleteStaticallyAllocatedCountingSemaphores.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 104 bytes
//  Scratch registers used: {r2,r4,r8,r12,i4,i12,acc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":269
	modify(i7,-24) (nw);
	dm(-25,i6)=r15;
.LN231:
// line 271
	i12=10;
	dm(-2,i6)=i12;
.LN232:
// line 290
	i4=modify(i6,-24) (nw);
	r15=i4;
	r4=10;
	r12=r15;
	r8=m5;
	cjump xQueueCreateCountingSemaphoreStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ56-1;
.LCJ56:
.LN233:
	dm(-3,i6)=r0;
	comp(r15,r0);
.LN234:
// line 294
	if eq jump (pc,.P78L2);

.LN235:
	r8=294;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ57-1;
.LCJ57:
.LN236:
	jump (pc,.P78L3);

.P78L2:

.P78L3:
.LN237:
// line 297
	r4=dm(-3,i6);
	r8=dm(-2,i6);
.LN238:
	cjump prvSanityCheckCreatedSemaphore. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ58-1;
.LCJ58:
.LN239:
// line 300
	r4=dm(-3,i6);
.LN240:
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ59-1;
.LCJ59:
.LN241:
// line 307
	r4=dm(-2,i6);
.LN242:
	r8=m5;
	cjump xQueueCreateCountingSemaphore. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ60-1;
.LCJ60:
.LN243:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN244:
// line 308
	if ne jump (pc,.P78L5);

.LN245:
	r8=308;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ61-1;
.LCJ61:
.LN246:
	jump (pc,.P78L6);

.P78L5:

.P78L6:
.LN247:
// line 309
	r4=dm(-3,i6);
	r8=dm(-2,i6);
.LN248:
	cjump prvSanityCheckCreatedSemaphore. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ62-1;
.LCJ62:
.LN249:
// line 310
	r4=dm(-3,i6);
.LN250:
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ63-1;
.LCJ63:
.LN251:
// line 313
	r15=dm(-25,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvCreateAndDeleteStaticallyAllocatedCountingSemaphores..end:
.prvCreateAndDeleteStaticallyAllocatedCountingSemaphores..end:
	.type prvCreateAndDeleteStaticallyAllocatedCountingSemaphores.,STT_FUNC;

prvCreateAndDeleteStaticallyAllocatedMutexes.:
.LNprvCreateAndDeleteStaticallyAllocatedMutexes.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 104 bytes
//  Scratch registers used: {r2,r4,r8,i4,i12,acc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":426
	modify(i7,-24) (nw);
	dm(-25,i6)=r15;
.LN252:
// line 445
	i4=modify(i6,-24) (nw);
	r15=i4;
	r8=r15;
	r4=m6;
	cjump xQueueCreateMutexStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ64-1;
.LCJ64:
.LN253:
	dm(-3,i6)=r0;
	comp(r15,r0);
.LN254:
// line 449
	if eq jump (pc,.P82L2);

.LN255:
	r8=449;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ65-1;
.LCJ65:
.LN256:
	jump (pc,.P82L3);

.P82L2:

.P82L3:
.LN257:
// line 453
	r4=dm(-3,i6);
.LN258:
	r15=m5;
	r8=m5;
	cjump xQueueSemaphoreTake. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ66-1;
.LCJ66:
.LN259:
	dm(-2,i6)=r0;
	r2=btgl r0 by r15;
.LN260:
// line 455
	if sz jump (pc,.P82L5);

.LN261:
// line 457
	dm(xErrorOccurred.)=m6;
.LN262:
// line 458
	jump (pc,.P82L6);

.P82L5:

.P82L6:
.LN263:
// line 461
	r4=dm(-3,i6);
.LN264:
	r8=m6;
	cjump prvSanityCheckCreatedSemaphore. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ67-1;
.LCJ67:
.LN265:
// line 464
	r4=dm(-3,i6);
.LN266:
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ68-1;
.LCJ68:
.LN267:
// line 471
	r4=m6;
	cjump xQueueCreateMutex. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ69-1;
.LCJ69:
.LN268:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN269:
// line 475
	if ne jump (pc,.P82L8);

.LN270:
	r8=475;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ70-1;
.LCJ70:
.LN271:
	jump (pc,.P82L9);

.P82L8:

.P82L9:
.LN272:
// line 479
	r4=dm(-3,i6);
.LN273:
	r8=m5;
	cjump xQueueSemaphoreTake. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ71-1;
.LCJ71:
.LN274:
	dm(-2,i6)=r0;
	r2=btgl r0 by r15;
.LN275:
// line 481
	if sz jump (pc,.P82L11);

.LN276:
// line 483
	dm(xErrorOccurred.)=m6;
.LN277:
// line 484
	jump (pc,.P82L12);

.P82L11:

.P82L12:
.LN278:
// line 487
	r4=dm(-3,i6);
.LN279:
	r8=m6;
	cjump prvSanityCheckCreatedSemaphore. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ72-1;
.LCJ72:
.LN280:
// line 490
	r4=dm(-3,i6);
.LN281:
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ73-1;
.LCJ73:
.LN282:
// line 493
	r15=dm(-25,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvCreateAndDeleteStaticallyAllocatedMutexes..end:
.prvCreateAndDeleteStaticallyAllocatedMutexes..end:
	.type prvCreateAndDeleteStaticallyAllocatedMutexes.,STT_FUNC;

prvCreateAndDeleteStaticallyAllocatedBinarySemaphores.:
.LNprvCreateAndDeleteStaticallyAllocatedBinarySemaphores.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 112 bytes
//  Scratch registers used: {r1-r2,r4,r8,r12,i12,acc}
//  Call preserved registers used: {i5}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":497
	modify(i7,-24) (nw);
	r2=i5;
	dm(-24,i6)=r2;
.LN283:
// line 517
	i5=modify(i6,-23) (nw);
	r1=3;
	r2=i5;
	dm(i7,m7)=r1;
	dm(i7,m7)=r2;
	r12=m5;
	r8=m5;
	r4=m6;
	cjump xQueueGenericCreateStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ74-1;
.LCJ74:
	modify(i7,2) (nw);
.LN284:
	dm(-2,i6)=r0;
	r2=i5;
	comp(r2,r0);
.LN285:
// line 521
	if eq jump (pc,.P85L2);

.LN286:
	r8=521;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ75-1;
.LCJ75:
.LN287:
	jump (pc,.P85L3);

.P85L2:

.P85L3:
.LN288:
// line 524
	r4=dm(-2,i6);
.LN289:
	r8=m6;
	cjump prvSanityCheckCreatedSemaphore. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ76-1;
.LCJ76:
.LN290:
// line 527
	r4=dm(-2,i6);
.LN291:
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ77-1;
.LCJ77:
.LN292:
// line 534
	r12=3;
	r8=m5;
	r4=m6;
	cjump xQueueGenericCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ78-1;
.LCJ78:
.LN293:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN294:
// line 535
	if ne jump (pc,.P85L5);

.LN295:
	r8=535;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ79-1;
.LCJ79:
.LN296:
	jump (pc,.P85L6);

.P85L5:

.P85L6:
.LN297:
// line 536
	r4=dm(-2,i6);
.LN298:
	r8=m6;
	cjump prvSanityCheckCreatedSemaphore. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ80-1;
.LCJ80:
.LN299:
// line 537
	r4=dm(-2,i6);
.LN300:
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ81-1;
.LCJ81:
.LN301:
// line 546
	r12=3;
	r8=m5;
	r4=m6;
	cjump xQueueGenericCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ82-1;
.LCJ82:
	r4=r0;
.LN302:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN303:
	if eq jump (pc,.P85L8);

.LN304:
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	r12=m5;
	r8=m5;
	cjump xQueueGenericSend. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ83-1;
.LCJ83:
	modify(i7,2) (nw);
.LN305:
	jump (pc,.P85L9);

.P85L8:

.P85L9:
.LN306:
// line 550
	r4=dm(-2,i6);
.LN307:
	r8=m5;
	cjump xQueueSemaphoreTake. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ84-1;
.LCJ84:
	r2=pass r0;
.LN308:
	if ne jump (pc,.P85L11);

.LN309:
// line 552
	dm(xErrorOccurred.)=m6;
.LN310:
// line 553
	jump (pc,.P85L12);

.P85L11:

.P85L12:
.LN311:
// line 555
	r4=dm(-2,i6);
.LN312:
	r8=m6;
	cjump prvSanityCheckCreatedSemaphore. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ85-1;
.LCJ85:
.LN313:
// line 556
	r4=dm(-2,i6);
.LN314:
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ86-1;
.LCJ86:
.LN315:
// line 559
	i5=dm(-24,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvCreateAndDeleteStaticallyAllocatedBinarySemaphores..end:
.prvCreateAndDeleteStaticallyAllocatedBinarySemaphores..end:
	.type prvCreateAndDeleteStaticallyAllocatedBinarySemaphores.,STT_FUNC;

prvSanityCheckCreatedQueue.:
.LNprvSanityCheckCreatedQueue.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 56 bytes
//  Scratch registers used: {r0-r2,r4,r8,r12,i4,i12,acc,scc}
//  Call preserved registers used: {r13-r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":984
	modify(i7,-10) (nw);
	dm(-11,i6)=r13;
	dm(-10,i6)=r14;
	dm(-9,i6)=r15;
	dm(-8,i6)=r4;
.LN316:
// line 989
	dm(-2,i6)=m13;

.P88L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c" line 989 col 2
//-------------------------------------------------------------------
	r2=dm(-2,i6);
	r1=2;
	comp(r2,r1);
	if ge jump (pc,.P88L3);

.LN317:
// line 993
	r4=dm(-8,i6);
.LN318:
	i4=modify(i6,-7) (nw);
	r14=m5;
	r15=i4;
	r12=m5;
	r8=r15;
	cjump xQueueReceive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ87-1;
.LCJ87:
.LN319:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN320:
// line 994
	if eq jump (pc,.P88L5);

.LN321:
// line 996
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN322:
// line 997
	jump (pc,.P88L6);

.P88L5:

.P88L6:
.LN323:
// line 1001
	dm(-7,i6)=m13;
	dm(-6,i6)=m13;

.P88L7:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c" line 1001 col 3
//-------------------------------------------------------------------
	r2=dm(-7,i6);
	r1=dm(-6,i6);
	r13=5;
	compu(r1,r14);
	if eq compu(r2,r13);
	if ge jump (pc,.P88L9);

.LN324:
// line 1003
	r4=dm(-8,i6);
.LN325:
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	r12=m5;
	r8=r15;
	cjump xQueueGenericSend. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ88-1;
.LCJ88:
	modify(i7,2) (nw);
.LN326:
	dm(-3,i6)=r0;
	r2=btgl r0 by r14;
.LN327:
// line 1004
	if sz jump (pc,.P88L11);

.LN328:
// line 1006
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN329:
// line 1007
	jump (pc,.P88L12);

.P88L11:

.P88L12:
.LN330:
// line 1001
	r2=dm(-7,i6);
	r1=dm(-6,i6);
	r0=m6;
	r2=r2+r0;
	r1=r1+r14+ci;
	dm(-7,i6)=r2;
	dm(-6,i6)=r1;
	jump (pc,.P88L7);
//-------------------------------------------------------------------
//   End Loop L7
//-------------------------------------------------------------------

.P88L9:
//-------------------------------------------------------------------
//   Part of Loop 1, depth 1
//-------------------------------------------------------------------
.LN331:
// line 1011
	r4=dm(-8,i6);
.LN332:
	modify(i7,m7) (nw);
	dm(i7,m7)=m13;
	r12=m5;
	r8=r15;
	cjump xQueueGenericSend. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ89-1;
.LCJ89:
	modify(i7,2) (nw);
.LN333:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN334:
// line 1012
	if eq jump (pc,.P88L14);

.LN335:
// line 1014
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN336:
// line 1015
	jump (pc,.P88L15);

.P88L14:

.P88L15:
.LN337:
// line 1019
	dm(-7,i6)=m13;
	dm(-6,i6)=m13;

.P88L16:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c" line 1019 col 3
//-------------------------------------------------------------------
	r2=dm(-7,i6);
	r1=dm(-6,i6);
	compu(r1,r14);
	if eq compu(r2,r13);
	if ge jump (pc,.P88L18);

.LN338:
// line 1021
	r4=dm(-8,i6);
.LN339:
	i4=modify(i6,-5) (nw);
	r8=i4;
	r12=m5;
	cjump xQueueReceive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ90-1;
.LCJ90:
.LN340:
	dm(-3,i6)=r0;
	r2=btgl r0 by r14;
.LN341:
// line 1023
	if sz jump (pc,.P88L20);

.LN342:
// line 1025
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN343:
// line 1026
	jump (pc,.P88L21);

.P88L20:

.P88L21:
.LN344:
// line 1028
	r2=dm(-5,i6);
	r1=dm(-4,i6);
	r0=dm(-7,i6);
	r12=dm(-6,i6);
	comp(r1,r12);
	if eq compu(r2,r0);
	if eq jump (pc,.P88L23);

.LN345:
// line 1030
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN346:
// line 1031
	jump (pc,.P88L24);

.P88L23:

.P88L24:
.LN347:
// line 1019
	r2=dm(-7,i6);
	r1=dm(-6,i6);
	r0=m6;
	r2=r2+r0;
	r1=r1+r14+ci;
	dm(-7,i6)=r2;
	dm(-6,i6)=r1;
	jump (pc,.P88L16);
//-------------------------------------------------------------------
//   End Loop L16
//-------------------------------------------------------------------

.P88L18:
//-------------------------------------------------------------------
//   Part of Loop 1, depth 1
//-------------------------------------------------------------------
.LN348:
// line 1035
	r4=dm(-8,i6);
.LN349:
	r12=m5;
	r8=r15;
	cjump xQueueReceive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ91-1;
.LCJ91:
.LN350:
	dm(-3,i6)=r0;
	r2=pass r0;
.LN351:
// line 1036
	if eq jump (pc,.P88L26);

.LN352:
// line 1038
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN353:
// line 1039
	jump (pc,.P88L27);

.P88L26:

.P88L27:
.LN354:
// line 989
	r2=dm(-2,i6);
	r2=r2+1;
	dm(-2,i6)=r2;
	jump (pc,.P88L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------

.P88L3:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN355:
// line 1041
	r13=dm(-11,i6);
	r14=dm(-10,i6);
	r15=dm(-9,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvSanityCheckCreatedQueue..end:
.prvSanityCheckCreatedQueue..end:
	.type prvSanityCheckCreatedQueue.,STT_FUNC;

prvCreateAndDeleteStaticallyAllocatedQueues.:
.LNprvCreateAndDeleteStaticallyAllocatedQueues.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 24 bytes
//  Scratch registers used: {r2,r4,r8,r12,i12,acc}
//  Call preserved registers used: {r13}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":363
	modify(i7,-2) (nw);
	dm(-3,i6)=r13;
.LN356:
// line 388
	r13=xStaticQueue.6.;
	r12=ucQueueStorageArea.7.;
	dm(i7,m7)=m13;
	dm(i7,m7)=r13;
	r8=8;
	r4=5;
	cjump xQueueGenericCreateStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ92-1;
.LCJ92:
	modify(i7,2) (nw);
.LN357:
	dm(-2,i6)=r0;
	comp(r0,r13);
.LN358:
// line 395
	if eq jump (pc,.P92L2);

.LN359:
	r8=395;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ93-1;
.LCJ93:
.LN360:
	jump (pc,.P92L3);

.P92L2:

.P92L3:
.LN361:
// line 398
	r4=dm(-2,i6);
.LN362:
	cjump prvSanityCheckCreatedQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ94-1;
.LCJ94:
.LN363:
// line 401
	r4=dm(-2,i6);
.LN364:
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ95-1;
.LCJ95:
.LN365:
// line 408
	r12=m5;
	r8=8;
	r4=5;
	cjump xQueueGenericCreate. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ96-1;
.LCJ96:
.LN366:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN367:
// line 413
	if ne jump (pc,.P92L5);

.LN368:
	r8=413;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ97-1;
.LCJ97:
.LN369:
	jump (pc,.P92L6);

.P92L5:

.P92L6:
.LN370:
// line 416
	r4=dm(-2,i6);
.LN371:
	cjump prvSanityCheckCreatedQueue. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ98-1;
.LCJ98:
.LN372:
// line 419
	r4=dm(-2,i6);
.LN373:
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ99-1;
.LCJ99:
.LN374:
// line 422
	r13=dm(-3,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvCreateAndDeleteStaticallyAllocatedQueues..end:
.prvCreateAndDeleteStaticallyAllocatedQueues..end:
	.type prvCreateAndDeleteStaticallyAllocatedQueues.,STT_FUNC;

prvSanityCheckCreatedRecursiveMutex.:
.LNprvSanityCheckCreatedRecursiveMutex.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 32 bytes
//  Scratch registers used: {r1-r2,r4,r8,i12,acc,scc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":1045
	modify(i7,-6) (nw);
	dm(-6,i6)=r15;
	dm(-5,i6)=r4;
.LN375:
// line 1046
	i12=5;
	dm(-4,i6)=i12;
.LN376:
// line 1052
	cjump xQueueGiveMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ100-1;
.LCJ100:
.LN377:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN378:
// line 1054
	if eq jump (pc,.P93L2);

.LN379:
// line 1056
	dm(xErrorOccurred.)=m6;
.LN380:
// line 1057
	jump (pc,.P93L3);

.P93L2:

.P93L3:
.LN381:
// line 1060
	dm(-3,i6)=m13;

.P93L4:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c" line 1060 col 2
//-------------------------------------------------------------------
	r2=dm(-3,i6);
	r1=dm(-4,i6);
	comp(r1,r2);
	if le jump (pc,.P93L6);

.LN382:
// line 1062
	r4=dm(-5,i6);
.LN383:
	r15=m5;
	r8=m5;
	cjump xQueueTakeMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ101-1;
.LCJ101:
.LN384:
	dm(-2,i6)=r0;
	r2=btgl r0 by r15;
.LN385:
// line 1064
	if sz jump (pc,.P93L8);

.LN386:
// line 1066
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN387:
// line 1067
	jump (pc,.P93L9);

.P93L8:

.P93L9:
.LN388:
// line 1060
	r2=dm(-3,i6);
	r2=r2+1;
	dm(-3,i6)=r2;
	jump (pc,.P93L4);
//-------------------------------------------------------------------
//   End Loop L4
//-------------------------------------------------------------------

.P93L6:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN389:
// line 1072
	dm(-3,i6)=m13;

.P93L10:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c" line 1072 col 2
//-------------------------------------------------------------------
	r2=dm(-3,i6);
	r1=dm(-4,i6);
	comp(r1,r2);
	if le jump (pc,.P93L12);

.LN390:
// line 1074
	r4=dm(-5,i6);
.LN391:
	cjump xQueueGiveMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ102-1;
.LCJ102:
.LN392:
	dm(-2,i6)=r0;
	r2=m5;
	r2=btgl r0 by r2;
.LN393:
// line 1076
	if sz jump (pc,.P93L14);

.LN394:
// line 1078
	dm(xErrorOccurred.)=m6;                 // Use of volatile in loops precludes optimizations. 
.LN395:
// line 1079
	jump (pc,.P93L15);

.P93L14:

.P93L15:
.LN396:
// line 1072
	r2=dm(-3,i6);
	r2=r2+1;
	dm(-3,i6)=r2;
	jump (pc,.P93L10);
//-------------------------------------------------------------------
//   End Loop L10
//-------------------------------------------------------------------

.P93L12:
//-------------------------------------------------------------------
//   Part of top level (no loop)
//-------------------------------------------------------------------
.LN397:
// line 1083
	r4=dm(-5,i6);
.LN398:
	cjump xQueueGiveMutexRecursive. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ103-1;
.LCJ103:
.LN399:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN400:
// line 1085
	if eq jump (pc,.P93L17);

.LN401:
// line 1087
	dm(xErrorOccurred.)=m6;
.LN402:
// line 1088
	jump (pc,.P93L18);

.P93L17:

.P93L18:
.LN403:
// line 1089
	r15=dm(-6,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvSanityCheckCreatedRecursiveMutex..end:
.prvSanityCheckCreatedRecursiveMutex..end:
	.type prvSanityCheckCreatedRecursiveMutex.,STT_FUNC;

prvCreateAndDeleteStaticallyAllocatedRecursiveMutexes.:
.LNprvCreateAndDeleteStaticallyAllocatedRecursiveMutexes.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 104 bytes
//  Scratch registers used: {r2,r4,r8,i4,i12,acc}
//  Call preserved registers used: {r15}
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":317
	modify(i7,-24) (nw);
	dm(-24,i6)=r15;
.LN404:
// line 335
	i4=modify(i6,-23) (nw);
	r15=i4;
	r8=r15;
	r4=4;
	cjump xQueueCreateMutexStatic. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ104-1;
.LCJ104:
.LN405:
	dm(-2,i6)=r0;
	comp(r15,r0);
.LN406:
// line 339
	if eq jump (pc,.P96L2);

.LN407:
	r8=339;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ105-1;
.LCJ105:
.LN408:
	jump (pc,.P96L3);

.P96L2:

.P96L3:
.LN409:
// line 343
	r4=dm(-2,i6);
.LN410:
	cjump prvSanityCheckCreatedRecursiveMutex. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ106-1;
.LCJ106:
.LN411:
// line 346
	r4=dm(-2,i6);
.LN412:
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ107-1;
.LCJ107:
.LN413:
// line 353
	r4=4;
	cjump xQueueCreateMutex. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ108-1;
.LCJ108:
.LN414:
	dm(-2,i6)=r0;
	r2=pass r0;
.LN415:
// line 354
	if ne jump (pc,.P96L5);

.LN416:
	r8=354;
	r4=.sDRTOSF.3;
	cjump vAssertCalled. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ109-1;
.LCJ109:
.LN417:
	jump (pc,.P96L6);

.P96L5:

.P96L6:
.LN418:
// line 355
	r4=dm(-2,i6);
.LN419:
	cjump prvSanityCheckCreatedRecursiveMutex. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ110-1;
.LCJ110:
.LN420:
// line 356
	r4=dm(-2,i6);
.LN421:
	cjump vQueueDelete. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ111-1;
.LCJ111:
.LN422:
// line 359
	r15=dm(-24,i6);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.LN.prvCreateAndDeleteStaticallyAllocatedRecursiveMutexes..end:
.prvCreateAndDeleteStaticallyAllocatedRecursiveMutexes..end:
	.type prvCreateAndDeleteStaticallyAllocatedRecursiveMutexes.,STT_FUNC;

prvStaticallyAllocatedCreator.:
.LNprvStaticallyAllocatedCreator.:
//-------------------------------------------------------------------
//  Procedure statistics:
//  Frame size            = 16 bytes
//  Scratch registers used: {r2,r4,acc}
//  No call preserved registers used.
//  Registers that could be clobbered by function calls: {r0-r2,r4,r8,r12,s0-s15,i4,i12-i13,b4,b12-b13,m4,m12,ustat1-ustat4,acc,mcc,scc,btf,sacc,smcc,sscc,sbtf,stky,stkyy,mrf,mrb,msf,msb,lcntr,px}
//-------------------------------------------------------------------
// line "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c":232
	modify(i7,-2) (nw);
	dm(-2,i6)=r4;

.P43L1:
//-------------------------------------------------------------------
//   Loop at "D:\RTOS\FreeRTOS-release-FreeRTOSv10.5.x\Demo\Common\Minimal\StaticAllocation.c" line 236 col 2
//-------------------------------------------------------------------
//   This loop executes 1 iteration of the original loop in an estimated 57 
//   cycles (includes 2 stalls but excludes the cost of function calls).
//-------------------------------------------------------------------
//   This loop's resource usage is:
//     dm dag                          used  24 out of   57 ( 42.1%)
//     multifunction alu               used  24 out of   57 ( 42.1%)
//     multifunction float multiply    used  24 out of   57 ( 42.1%)
//     multifunction integer add sub   used  24 out of   57 ( 42.1%)
//     multifunction integer multiply  used  24 out of   57 ( 42.1%)
//     multifunction mult              used  24 out of   57 ( 42.1%)
//     pm dag                          used  24 out of   57 ( 42.1%)
//     shift immediate                 used  24 out of   57 ( 42.1%)
//     memory access                   used  24 out of  114 ( 21.1%)
//-------------------------------------------------------------------
	// -- 2 stalls --
.LN423:
// line 241
	cjump prvCreateAndDeleteStaticallyAllocatedTasks. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ112-1;
.LCJ112:
.LN424:
// line 242
	cjump prvCreateAndDeleteStaticallyAllocatedQueues. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ113-1;
.LCJ113:
.LN425:
// line 247
	cjump prvGetNextDelayTime. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ114-1;
.LCJ114:
	r4=r0;
.LN426:
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ115-1;
.LCJ115:
.LN427:
// line 248
	r2=dm(uxCycleCounter.);                 // Use of volatile in loops precludes optimizations. 
	r2=r2+1;
	dm(uxCycleCounter.)=r2;                 // Use of volatile in loops precludes optimizations. 
.LN428:
// line 250
	cjump prvCreateAndDeleteStaticallyAllocatedBinarySemaphores. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ116-1;
.LCJ116:
.LN429:
// line 251
	cjump prvCreateAndDeleteStaticallyAllocatedCountingSemaphores. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ117-1;
.LCJ117:
.LN430:
// line 253
	cjump prvGetNextDelayTime. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ118-1;
.LCJ118:
	r4=r0;
.LN431:
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ119-1;
.LCJ119:
.LN432:
// line 254
	r2=dm(uxCycleCounter.);                 // Use of volatile in loops precludes optimizations. 
	r2=r2+1;
	dm(uxCycleCounter.)=r2;                 // Use of volatile in loops precludes optimizations. 
.LN433:
// line 256
	cjump prvCreateAndDeleteStaticallyAllocatedMutexes. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ120-1;
.LCJ120:
.LN434:
// line 257
	cjump prvCreateAndDeleteStaticallyAllocatedRecursiveMutexes. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ121-1;
.LCJ121:
.LN435:
// line 259
	cjump prvGetNextDelayTime. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ122-1;
.LCJ122:
	r4=r0;
.LN436:
	cjump vTaskDelay. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ123-1;
.LCJ123:
.LN437:
// line 260
	r2=dm(uxCycleCounter.);                 // Use of volatile in loops precludes optimizations. 
	r2=r2+1;
	dm(uxCycleCounter.)=r2;                 // Use of volatile in loops precludes optimizations. 
.LN438:
// line 262
	cjump prvCreateAndDeleteStaticallyAllocatedEventGroups. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ124-1;
.LCJ124:
.LN439:
// line 263
	cjump prvCreateAndDeleteStaticallyAllocatedTimers. (db); dm(i7,m7)=r2; dm(i7,m7)=.LCJ125-1;
.LCJ125:
	jump (pc,.P43L1);
//-------------------------------------------------------------------
//   End Loop L1
//-------------------------------------------------------------------
.LN.prvStaticallyAllocatedCreator..end:
.prvStaticallyAllocatedCreator..end:
	.type prvStaticallyAllocatedCreator.,STT_FUNC;

	.file_attr ProjectName="RTOSDemo_CCES_SHARC_21569";
	.file_attr FuncName="xAreStaticAllocationTasksStillRunning.";
	.file_attr FuncName="prvRand.";
	.file_attr FuncName="disable_interrupts.";
	.file_attr FuncName="enable_interrupts.";
	.file_attr FuncName="vStartStaticallyAllocatedTasks.";
	.file_attr FuncName="prvTimerCallback.";
	.file_attr FuncName="prvCreateAndDeleteStaticallyAllocatedTimers.";
	.file_attr FuncName="prvCreateAndDeleteStaticallyAllocatedTasks.";
	.file_attr FuncName="prvStaticallyAllocatedTask.";
	.file_attr FuncName="prvGetNextDelayTime.";
	.file_attr FuncName="prvSanityCheckCreatedEventGroup.";
	.file_attr FuncName="prvCreateAndDeleteStaticallyAllocatedEventGroups.";
	.file_attr FuncName="prvSanityCheckCreatedSemaphore.";
	.file_attr FuncName="prvCreateAndDeleteStaticallyAllocatedCountingSemaphores.";
	.file_attr FuncName="prvCreateAndDeleteStaticallyAllocatedMutexes.";
	.file_attr FuncName="prvCreateAndDeleteStaticallyAllocatedBinarySemaphores.";
	.file_attr FuncName="prvSanityCheckCreatedQueue.";
	.file_attr FuncName="prvCreateAndDeleteStaticallyAllocatedQueues.";
	.file_attr FuncName="prvSanityCheckCreatedRecursiveMutex.";
	.file_attr FuncName="prvCreateAndDeleteStaticallyAllocatedRecursiveMutexes.";
	.file_attr FuncName="prvStaticallyAllocatedCreator.";
	.file_attr Encoding="SW";
	.file_attr Content="CodeData";
.epctext.end:

	.extern xTaskCreateStatic.;
	.type xTaskCreateStatic.,STT_FUNC;
	.extern pvTimerGetTimerID.;
	.type pvTimerGetTimerID.,STT_FUNC;
	.extern xTimerGenericCommand.;
	.type xTimerGenericCommand.,STT_FUNC;
	.extern xTimerCreateStatic.;
	.type xTimerCreateStatic.,STT_FUNC;
	.extern vAssertCalled.;
	.type vAssertCalled.,STT_FUNC;
	.extern xTaskGetTickCount.;
	.type xTaskGetTickCount.,STT_FUNC;
	.extern vTaskDelay.;
	.type vTaskDelay.,STT_FUNC;
	.extern xTimerCreate.;
	.type xTimerCreate.,STT_FUNC;
	.extern uxTaskPriorityGet.;
	.type uxTaskPriorityGet.,STT_FUNC;
	.extern eTaskGetState.;
	.type eTaskGetState.,STT_FUNC;
	.extern vTaskDelete.;
	.type vTaskDelete.,STT_FUNC;
	.extern xTaskCreate.;
	.type xTaskCreate.,STT_FUNC;
	.extern vTaskSuspend.;
	.type vTaskSuspend.,STT_FUNC;
	.extern __divrem_u32.;
	.type __divrem_u32.,STT_FUNC;
	.extern xEventGroupClearBits.;
	.type xEventGroupClearBits.,STT_FUNC;
	.extern xEventGroupSetBits.;
	.type xEventGroupSetBits.,STT_FUNC;
	.extern xEventGroupCreateStatic.;
	.type xEventGroupCreateStatic.,STT_FUNC;
	.extern vEventGroupDelete.;
	.type vEventGroupDelete.,STT_FUNC;
	.extern xEventGroupCreate.;
	.type xEventGroupCreate.,STT_FUNC;
	.extern xQueueSemaphoreTake.;
	.type xQueueSemaphoreTake.,STT_FUNC;
	.extern xQueueGenericSend.;
	.type xQueueGenericSend.,STT_FUNC;
	.extern uxQueueMessagesWaiting.;
	.type uxQueueMessagesWaiting.,STT_FUNC;
	.extern xQueueCreateCountingSemaphoreStatic.;
	.type xQueueCreateCountingSemaphoreStatic.,STT_FUNC;
	.extern vQueueDelete.;
	.type vQueueDelete.,STT_FUNC;
	.extern xQueueCreateCountingSemaphore.;
	.type xQueueCreateCountingSemaphore.,STT_FUNC;
	.extern xQueueCreateMutexStatic.;
	.type xQueueCreateMutexStatic.,STT_FUNC;
	.extern xQueueCreateMutex.;
	.type xQueueCreateMutex.,STT_FUNC;
	.extern xQueueGenericCreateStatic.;
	.type xQueueGenericCreateStatic.,STT_FUNC;
	.extern xQueueGenericCreate.;
	.type xQueueGenericCreate.,STT_FUNC;
	.extern xQueueReceive.;
	.type xQueueReceive.,STT_FUNC;
	.extern xQueueGiveMutexRecursive.;
	.type xQueueGiveMutexRecursive.,STT_FUNC;
	.extern xQueueTakeMutexRecursive.;
	.type xQueueTakeMutexRecursive.,STT_FUNC;

	.section/DOUBLE32 seg_dmda;

	.align 8;
	.type .epcbss,STT_OBJECT;
.epcbss:
	.byte xCreatorTaskTCBBuffer.[96];
	.type xCreatorTaskTCBBuffer.,STT_OBJECT;
	.byte uxCreatorTaskStackBuffer.[1600];
	.type uxCreatorTaskStackBuffer.,STT_OBJECT;
	.byte uxStackBuffer.4.[800];
	.type uxStackBuffer.4.,STT_OBJECT;
	.byte xStaticQueue.6.[84];
	.type xStaticQueue.6.,STT_OBJECT;
	.align 8;
	.byte ucQueueStorageArea.7.[40];
	.type ucQueueStorageArea.7.,STT_OBJECT;
.epcbss.end:

	.section .debug_abbrev;

	.align 1;
	.type .epcabbrev,STT_OBJECT;
.epcabbrev:
	.inc/binary ".\Standard_Demo\StaticAllocation.sbn", 0, 309;
.epcabbrev.end:

	.section .debug_info;

	.align 1;
	.type .epcdebug,STT_OBJECT;
.epcdebug:
	.byte =
		0x0A,0x26,0x00,0x00,0x02,0x00;
	.var = .epcabbrev;
	.byte =
		0x04,0x01,0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,
		0x65,0x65,0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,
		0x73,0x65,0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,
		0x31,0x30,0x2E,0x35,0x2E,0x78,0x5C,0x44,0x65,0x6D,0x6F,0x5C,
		0x43,0x6F,0x6D,0x6D,0x6F,0x6E,0x5C,0x4D,0x69,0x6E,0x69,0x6D,
		0x61,0x6C,0x5C,0x53,0x74,0x61,0x74,0x69,0x63,0x41,0x6C,0x6C,
		0x6F,0x63,0x61,0x74,0x69,0x6F,0x6E,0x2E,0x63,0x00,0x0C;
	.var = .epcline;
	.inc/binary ".\Standard_Demo\StaticAllocation.sbn", 309, 6689;
	.var = .LNxAreStaticAllocationTasksStillRunning.;
	.var = .LN.xAreStaticAllocationTasksStillRunning..end;
	.byte =
		0x01,0xF6,0x0B,0x00,0x00,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN0;
	.var = .LN.xAreStaticAllocationTasksStillRunning..end;
	.byte =
		0x15,0x75,0x78,0x4C,0x61,0x73,0x74,0x43,0x79,0x63,0x6C,0x65,
		0x43,0x6F,0x75,0x6E,0x74,0x65,0x72,0x00,0x01,0x07,0x0C,0x00,
		0x00,0x05,0x03;
	.var = uxLastCycleCounter.0.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x52,0x65,0x74,0x75,0x72,
		0x6E,0x00,0x01,0xF6,0x0B,0x00,0x00,0x02,0x86,0x78,0x00,0x00,
		0x00,0x00,0x00,0x00,0x00,0x13,0x3B,0x1B,0x00,0x00,0x70,0x72,
		0x76,0x52,0x61,0x6E,0x64,0x00,0x01;
	.var = .LNprvRand.;
	.var = .LN.prvRand..end;
	.byte =
		0x01,0x07,0x0C,0x00,0x00,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN9;
	.var = .LN.prvRand..end;
	.byte =
		0x15,0x75,0x6C,0x4D,0x75,0x6C,0x74,0x69,0x70,0x6C,0x69,0x65,
		0x72,0x00,0x01,0x3B,0x1B,0x00,0x00,0x02,0x86,0x74;
	.var = .LN9-.LNprvRand.;
	.byte =
		0x00,0x15,0x75,0x6C,0x49,0x6E,0x63,0x72,0x65,0x6D,0x65,0x6E,
		0x74,0x00,0x01,0x3B,0x1B,0x00,0x00,0x02,0x86,0x78;
	.var = .LN10-.LNprvRand.;
	.byte =
		0x00,0x00,0x00,0x12,0x43,0x05,0x00,0x00,0x16,0x7F,0x1B,0x00,
		0x00,0x76,0x53,0x74,0x61,0x72,0x74,0x53,0x74,0x61,0x74,0x69,
		0x63,0x61,0x6C,0x6C,0x79,0x41,0x6C,0x6C,0x6F,0x63,0x61,0x74,
		0x65,0x64,0x54,0x61,0x73,0x6B,0x73,0x00,0x01;
	.var = .LNvStartStaticallyAllocatedTasks.;
	.var = .LN.vStartStaticallyAllocatedTasks..end;
	.byte =
		0x01,0x01,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN13;
	.var = .LN.vStartStaticallyAllocatedTasks..end;
	.byte =
		0x00,0x00,0x16,0x04,0x1C,0x00,0x00,0x70,0x72,0x76,0x54,0x69,
		0x6D,0x65,0x72,0x43,0x61,0x6C,0x6C,0x62,0x61,0x63,0x6B,0x00,
		0x01;
	.var = .LNprvTimerCallback.;
	.var = .LN.prvTimerCallback..end;
	.byte =
		0x01,0x00,0x00,0x17,0x78,0x45,0x78,0x70,0x69,0x72,0x65,0x64,
		0x54,0x69,0x6D,0x65,0x72,0x00,0x93,0x19,0x00,0x00,0x02,0x86,
		0x70,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN15;
	.var = .LN.prvTimerCallback..end;
	.byte =
		0x15,0x70,0x75,0x78,0x56,0x61,0x72,0x69,0x61,0x62,0x6C,0x65,
		0x54,0x6F,0x49,0x6E,0x63,0x72,0x65,0x6D,0x65,0x6E,0x74,0x00,
		0x01,0x04,0x1C,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,
		0x00,0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x65,0x64,0x00,
		0x01,0xF6,0x0B,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,
		0x00,0x00,0x00,0x05,0x00,0x07,0x0C,0x00,0x00,0x16,0xDD,0x1C,
		0x00,0x00,0x70,0x72,0x76,0x43,0x72,0x65,0x61,0x74,0x65,0x41,
		0x6E,0x64,0x44,0x65,0x6C,0x65,0x74,0x65,0x53,0x74,0x61,0x74,
		0x69,0x63,0x61,0x6C,0x6C,0x79,0x41,0x6C,0x6C,0x6F,0x63,0x61,
		0x74,0x65,0x64,0x54,0x69,0x6D,0x65,0x72,0x73,0x00,0x01;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedTimers.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedTimers..end;
	.byte =
		0x01,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN27;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedTimers..end;
	.byte =
		0x15,0x78,0x54,0x69,0x6D,0x65,0x72,0x00,0x01,0x93,0x19,0x00,
		0x00,0x02,0x86,0x6C,0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,
		0x56,0x61,0x72,0x69,0x61,0x62,0x6C,0x65,0x54,0x6F,0x49,0x6E,
		0x63,0x72,0x65,0x6D,0x65,0x6E,0x74,0x00,0x01,0x07,0x0C,0x00,
		0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x54,
		0x69,0x6D,0x65,0x72,0x50,0x65,0x72,0x69,0x6F,0x64,0x00,0x01,
		0xDD,0x1C,0x00,0x00,0x02,0x86,0x74;
	.var = .LN27-.LNprvCreateAndDeleteStaticallyAllocatedTimers.;
	.byte =
		0x00,0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x65,0x64,0x00,
		0x01,0xF6,0x0B,0x00,0x00,0x02,0x86,0x78;
	.var = .LN27-.LNprvCreateAndDeleteStaticallyAllocatedTimers.;
	.byte =
		0x00,0x15,0x78,0x54,0x69,0x6D,0x65,0x72,0x42,0x75,0x66,0x66,
		0x65,0x72,0x00,0x01,0xAD,0x12,0x00,0x00,0x02,0x86,0x40;
	.var = .LN27-.LNprvCreateAndDeleteStaticallyAllocatedTimers.;
	.byte =
		0x00,0x00,0x00,0x12,0x19,0x0C,0x00,0x00,0x16,0xA7,0x1D,0x00,
		0x00,0x70,0x72,0x76,0x43,0x72,0x65,0x61,0x74,0x65,0x41,0x6E,
		0x64,0x44,0x65,0x6C,0x65,0x74,0x65,0x53,0x74,0x61,0x74,0x69,
		0x63,0x61,0x6C,0x6C,0x79,0x41,0x6C,0x6C,0x6F,0x63,0x61,0x74,
		0x65,0x64,0x54,0x61,0x73,0x6B,0x73,0x00,0x01;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedTasks.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedTasks..end;
	.byte =
		0x01,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN79;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedTasks..end;
	.byte =
		0x15,0x75,0x78,0x53,0x74,0x61,0x63,0x6B,0x42,0x75,0x66,0x66,
		0x65,0x72,0x00,0x01,0xA7,0x1D,0x00,0x00,0x05,0x03;
	.var = uxStackBuffer.4.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x43,0x72,0x65,0x61,0x74,
		0x65,0x64,0x54,0x61,0x73,0x6B,0x00,0x01,0xF0,0x14,0x00,0x00,
		0x02,0x86,0x74,0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x54,0x43,
		0x42,0x42,0x75,0x66,0x66,0x65,0x72,0x00,0x01,0x48,0x10,0x00,
		0x00,0x03,0x86,0x94,0x7F,0x00,0x00,0x00,0x00,0x00,0x14,0x00,
		0x00,0x00,0x00;
	.var = .LN92;
	.var = .LN109;
	.byte =
		0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x65,0x64,0x00,0x01,
		0xF6,0x0B,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,0x00,
		0x00,0x00,0x00,0x0C,0xB7,0x1D,0x00,0x00,0xE4,0x0B,0x00,0x00,
		0x0D,0xC8,0x01,0x00,0xC7,0x01,0x00,0x16,0x08,0x1E,0x00,0x00,
		0x70,0x72,0x76,0x53,0x74,0x61,0x74,0x69,0x63,0x61,0x6C,0x6C,
		0x79,0x41,0x6C,0x6C,0x6F,0x63,0x61,0x74,0x65,0x64,0x54,0x61,
		0x73,0x6B,0x00,0x01;
	.var = .LNprvStaticallyAllocatedTask.;
	.var = .LN.prvStaticallyAllocatedTask..end;
	.byte =
		0x01,0x00,0x00,0x17,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xDC,0x03,0x00,0x00,0x02,0x86,0x78,
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN110;
	.var = .LN.prvStaticallyAllocatedTask..end;
	.byte =
		0x00,0x00,0x13,0xA2,0x1E,0x00,0x00,0x70,0x72,0x76,0x47,0x65,
		0x74,0x4E,0x65,0x78,0x74,0x44,0x65,0x6C,0x61,0x79,0x54,0x69,
		0x6D,0x65,0x00,0x01;
	.var = .LNprvGetNextDelayTime.;
	.var = .LN.prvGetNextDelayTime..end;
	.byte =
		0x01,0x19,0x0C,0x00,0x00,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN112;
	.var = .LN.prvGetNextDelayTime..end;
	.byte =
		0x15,0x78,0x4E,0x65,0x78,0x74,0x44,0x65,0x6C,0x61,0x79,0x00,
		0x01,0x19,0x0C,0x00,0x00,0x02,0x86,0x6C,0x00,0x00,0x00,0x00,
		0x00,0x15,0x78,0x4D,0x61,0x78,0x44,0x65,0x6C,0x61,0x79,0x00,
		0x01,0xDD,0x1C,0x00,0x00,0x02,0x86,0x70;
	.var = .LN112-.LNprvGetNextDelayTime.;
	.byte =
		0x00,0x15,0x78,0x4D,0x69,0x6E,0x44,0x65,0x6C,0x61,0x79,0x00,
		0x01,0xDD,0x1C,0x00,0x00,0x02,0x86,0x74;
	.var = .LN113-.LNprvGetNextDelayTime.;
	.byte =
		0x00,0x15,0x78,0x54,0x69,0x6E,0x79,0x44,0x65,0x6C,0x61,0x79,
		0x00,0x01,0xDD,0x1C,0x00,0x00,0x02,0x86,0x78;
	.var = .LN114-.LNprvGetNextDelayTime.;
	.byte =
		0x00,0x00,0x00,0x16,0x4B,0x1F,0x00,0x00,0x70,0x72,0x76,0x53,
		0x61,0x6E,0x69,0x74,0x79,0x43,0x68,0x65,0x63,0x6B,0x43,0x72,
		0x65,0x61,0x74,0x65,0x64,0x45,0x76,0x65,0x6E,0x74,0x47,0x72,
		0x6F,0x75,0x70,0x00,0x01;
	.var = .LNprvSanityCheckCreatedEventGroup.;
	.var = .LN.prvSanityCheckCreatedEventGroup..end;
	.byte =
		0x01,0x00,0x00,0x17,0x78,0x45,0x76,0x65,0x6E,0x74,0x47,0x72,
		0x6F,0x75,0x70,0x00,0x2B,0x1A,0x00,0x00,0x02,0x86,0x6C,0x00,
		0x14,0x00,0x00,0x00,0x00;
	.var = .LN122;
	.var = .LN.prvSanityCheckCreatedEventGroup..end;
	.byte =
		0x15,0x78,0x45,0x76,0x65,0x6E,0x74,0x42,0x69,0x74,0x73,0x00,
		0x01,0x44,0x1A,0x00,0x00,0x02,0x86,0x70,0x00,0x00,0x00,0x00,
		0x00,0x15,0x78,0x46,0x69,0x72,0x73,0x74,0x54,0x65,0x73,0x74,
		0x42,0x69,0x74,0x73,0x00,0x01,0x4B,0x1F,0x00,0x00,0x02,0x86,
		0x74;
	.var = .LN122-.LNprvSanityCheckCreatedEventGroup.;
	.byte =
		0x00,0x15,0x78,0x53,0x65,0x63,0x6F,0x6E,0x64,0x54,0x65,0x73,
		0x74,0x42,0x69,0x74,0x73,0x00,0x01,0x4B,0x1F,0x00,0x00,0x02,
		0x86,0x78;
	.var = .LN123-.LNprvSanityCheckCreatedEventGroup.;
	.byte =
		0x00,0x00,0x00,0x12,0x44,0x1A,0x00,0x00,0x16,0xDB,0x1F,0x00,
		0x00,0x70,0x72,0x76,0x43,0x72,0x65,0x61,0x74,0x65,0x41,0x6E,
		0x64,0x44,0x65,0x6C,0x65,0x74,0x65,0x53,0x74,0x61,0x74,0x69,
		0x63,0x61,0x6C,0x6C,0x79,0x41,0x6C,0x6C,0x6F,0x63,0x61,0x74,
		0x65,0x64,0x45,0x76,0x65,0x6E,0x74,0x47,0x72,0x6F,0x75,0x70,
		0x73,0x00,0x01;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedEventGroups.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedEventGroups..end;
	.byte =
		0x01,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN154;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedEventGroups..end;
	.byte =
		0x15,0x78,0x45,0x76,0x65,0x6E,0x74,0x47,0x72,0x6F,0x75,0x70,
		0x00,0x01,0x2B,0x1A,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,
		0x00,0x00,0x15,0x78,0x45,0x76,0x65,0x6E,0x74,0x47,0x72,0x6F,
		0x75,0x70,0x42,0x75,0x66,0x66,0x65,0x72,0x00,0x01,0x01,0x12,
		0x00,0x00,0x02,0x86,0x58,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
		0x16,0xA1,0x20,0x00,0x00,0x70,0x72,0x76,0x53,0x61,0x6E,0x69,
		0x74,0x79,0x43,0x68,0x65,0x63,0x6B,0x43,0x72,0x65,0x61,0x74,
		0x65,0x64,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,0x65,0x00,
		0x01;
	.var = .LNprvSanityCheckCreatedSemaphore.;
	.var = .LN.prvSanityCheckCreatedSemaphore..end;
	.byte =
		0x01,0x00,0x00,0x17,0x78,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,
		0x72,0x65,0x00,0x62,0x19,0x00,0x00,0x02,0x86,0x64,0x00,0x17,
		0x75,0x78,0x4D,0x61,0x78,0x43,0x6F,0x75,0x6E,0x74,0x00,0x07,
		0x0C,0x00,0x00,0x02,0x86,0x68,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN173;
	.var = .LN.prvSanityCheckCreatedSemaphore..end;
	.byte =
		0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x65,0x64,0x00,0x01,
		0xF6,0x0B,0x00,0x00,0x02,0x86,0x6C,0x00,0x00,0x00,0x00,0x00,
		0x15,0x78,0x00,0x01,0x07,0x0C,0x00,0x00,0x02,0x86,0x70,0x00,
		0x00,0x00,0x00,0x00,0x15,0x78,0x53,0x68,0x6F,0x72,0x74,0x42,
		0x6C,0x6F,0x63,0x6B,0x54,0x69,0x6D,0x65,0x00,0x01,0xDD,0x1C,
		0x00,0x00,0x02,0x86,0x74;
	.var = .LN173-.LNprvSanityCheckCreatedSemaphore.;
	.byte =
		0x00,0x15,0x78,0x54,0x69,0x63,0x6B,0x43,0x6F,0x75,0x6E,0x74,
		0x00,0x01,0x19,0x0C,0x00,0x00,0x02,0x86,0x78;
	.var = .LN173-.LNprvSanityCheckCreatedSemaphore.;
	.byte =
		0x00,0x00,0x00,0x16,0x4B,0x21,0x00,0x00,0x70,0x72,0x76,0x43,
		0x72,0x65,0x61,0x74,0x65,0x41,0x6E,0x64,0x44,0x65,0x6C,0x65,
		0x74,0x65,0x53,0x74,0x61,0x74,0x69,0x63,0x61,0x6C,0x6C,0x79,
		0x41,0x6C,0x6C,0x6F,0x63,0x61,0x74,0x65,0x64,0x43,0x6F,0x75,
		0x6E,0x74,0x69,0x6E,0x67,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,
		0x72,0x65,0x73,0x00,0x01;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedCountingSemaphores.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedCountingSemaphores..end;
	.byte =
		0x01,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN231;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedCountingSemaphores..end;
	.byte =
		0x15,0x78,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,0x65,0x00,
		0x01,0x62,0x19,0x00,0x00,0x02,0x86,0x74,0x00,0x00,0x00,0x00,
		0x00,0x15,0x75,0x78,0x4D,0x61,0x78,0x43,0x6F,0x75,0x6E,0x74,
		0x00,0x01,0x4B,0x21,0x00,0x00,0x02,0x86,0x78;
	.var = .LN231-.LNprvCreateAndDeleteStaticallyAllocatedCountingSemaphores.;
	.byte =
		0x00,0x15,0x78,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,0x65,
		0x42,0x75,0x66,0x66,0x65,0x72,0x00,0x01,0x86,0x11,0x00,0x00,
		0x03,0x86,0xA0,0x7F;
	.var = .LN231-.LNprvCreateAndDeleteStaticallyAllocatedCountingSemaphores.;
	.byte =
		0x00,0x00,0x00,0x12,0x07,0x0C,0x00,0x00,0x16,0xEE,0x21,0x00,
		0x00,0x70,0x72,0x76,0x43,0x72,0x65,0x61,0x74,0x65,0x41,0x6E,
		0x64,0x44,0x65,0x6C,0x65,0x74,0x65,0x53,0x74,0x61,0x74,0x69,
		0x63,0x61,0x6C,0x6C,0x79,0x41,0x6C,0x6C,0x6F,0x63,0x61,0x74,
		0x65,0x64,0x4D,0x75,0x74,0x65,0x78,0x65,0x73,0x00,0x01;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedMutexes.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedMutexes..end;
	.byte =
		0x01,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN252;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedMutexes..end;
	.inc/binary ".\Standard_Demo\StaticAllocation.sbn", 6998, 143;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedBinarySemaphores.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedBinarySemaphores..end;
	.byte =
		0x01,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN283;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedBinarySemaphores..end;
	.byte =
		0x15,0x78,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,0x65,0x00,
		0x01,0x62,0x19,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,
		0x00,0x15,0x78,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,0x65,
		0x42,0x75,0x66,0x66,0x65,0x72,0x00,0x01,0x86,0x11,0x00,0x00,
		0x03,0x86,0xA4,0x7F,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,
		0x1C,0x23,0x00,0x00,0x70,0x72,0x76,0x53,0x61,0x6E,0x69,0x74,
		0x79,0x43,0x68,0x65,0x63,0x6B,0x43,0x72,0x65,0x61,0x74,0x65,
		0x64,0x51,0x75,0x65,0x75,0x65,0x00,0x01;
	.var = .LNprvSanityCheckCreatedQueue.;
	.var = .LN.prvSanityCheckCreatedQueue..end;
	.byte =
		0x01,0x00,0x00,0x17,0x78,0x51,0x75,0x65,0x75,0x65,0x00,0x1A,
		0x19,0x00,0x00,0x02,0x86,0x60,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN316;
	.var = .LN.prvSanityCheckCreatedQueue..end;
	.inc/binary ".\Standard_Demo\StaticAllocation.sbn", 7141, 136;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedQueues.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedQueues..end;
	.byte =
		0x01,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN356;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedQueues..end;
	.byte =
		0x15,0x78,0x53,0x74,0x61,0x74,0x69,0x63,0x51,0x75,0x65,0x75,
		0x65,0x00,0x01,0x72,0x11,0x00,0x00,0x05,0x03;
	.var = xStaticQueue.6.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x63,0x51,0x75,0x65,0x75,
		0x65,0x53,0x74,0x6F,0x72,0x61,0x67,0x65,0x41,0x72,0x65,0x61,
		0x00,0x01,0xBF,0x23,0x00,0x00,0x05,0x03;
	.var = ucQueueStorageArea.7.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x51,0x75,0x65,0x75,0x65,
		0x00,0x01,0x1A,0x19,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,
		0x00,0x00,0x00,0x00,0x0C,0xCD,0x23,0x00,0x00,0x26,0x05,0x00,
		0x00,0x0D,0x28,0x00,0x27,0x00,0x16,0x62,0x24,0x00,0x00,0x70,
		0x72,0x76,0x53,0x61,0x6E,0x69,0x74,0x79,0x43,0x68,0x65,0x63,
		0x6B,0x43,0x72,0x65,0x61,0x74,0x65,0x64,0x52,0x65,0x63,0x75,
		0x72,0x73,0x69,0x76,0x65,0x4D,0x75,0x74,0x65,0x78,0x00,0x01;
	.var = .LNprvSanityCheckCreatedRecursiveMutex.;
	.var = .LN.prvSanityCheckCreatedRecursiveMutex..end;
	.byte =
		0x01,0x00,0x00,0x17,0x78,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,
		0x72,0x65,0x00,0x62,0x19,0x00,0x00,0x02,0x86,0x6C,0x00,0x14,
		0x00,0x00,0x00,0x00;
	.var = .LN375;
	.var = .LN.prvSanityCheckCreatedRecursiveMutex..end;
	.byte =
		0x15,0x78,0x4C,0x6F,0x6F,0x70,0x73,0x00,0x01,0x62,0x24,0x00,
		0x00,0x02,0x86,0x70;
	.var = .LN375-.LNprvSanityCheckCreatedRecursiveMutex.;
	.byte =
		0x00,0x15,0x78,0x00,0x01,0xF6,0x0B,0x00,0x00,0x02,0x86,0x74;
	.var = .LN375-.LNprvSanityCheckCreatedRecursiveMutex.;
	.byte =
		0x00,0x15,0x78,0x52,0x65,0x74,0x75,0x72,0x6E,0x65,0x64,0x00,
		0x01,0xF6,0x0B,0x00,0x00,0x02,0x86,0x78;
	.var = .LN375-.LNprvSanityCheckCreatedRecursiveMutex.;
	.byte =
		0x00,0x00,0x00,0x12,0xF6,0x0B,0x00,0x00,0x16,0xF6,0x24,0x00,
		0x00,0x70,0x72,0x76,0x43,0x72,0x65,0x61,0x74,0x65,0x41,0x6E,
		0x64,0x44,0x65,0x6C,0x65,0x74,0x65,0x53,0x74,0x61,0x74,0x69,
		0x63,0x61,0x6C,0x6C,0x79,0x41,0x6C,0x6C,0x6F,0x63,0x61,0x74,
		0x65,0x64,0x52,0x65,0x63,0x75,0x72,0x73,0x69,0x76,0x65,0x4D,
		0x75,0x74,0x65,0x78,0x65,0x73,0x00,0x01;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedRecursiveMutexes.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedRecursiveMutexes..end;
	.byte =
		0x01,0x00,0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN404;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedRecursiveMutexes..end;
	.byte =
		0x15,0x78,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,0x65,0x00,
		0x01,0x62,0x19,0x00,0x00,0x02,0x86,0x78,0x00,0x00,0x00,0x00,
		0x00,0x15,0x78,0x53,0x65,0x6D,0x61,0x70,0x68,0x6F,0x72,0x65,
		0x42,0x75,0x66,0x66,0x65,0x72,0x00,0x01,0x86,0x11,0x00,0x00,
		0x03,0x86,0xA4,0x7F,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x16,
		0x4A,0x25,0x00,0x00,0x70,0x72,0x76,0x53,0x74,0x61,0x74,0x69,
		0x63,0x61,0x6C,0x6C,0x79,0x41,0x6C,0x6C,0x6F,0x63,0x61,0x74,
		0x65,0x64,0x43,0x72,0x65,0x61,0x74,0x6F,0x72,0x00,0x01;
	.var = .LNprvStaticallyAllocatedCreator.;
	.var = .LN.prvStaticallyAllocatedCreator..end;
	.byte =
		0x01,0x00,0x00,0x17,0x70,0x76,0x50,0x61,0x72,0x61,0x6D,0x65,
		0x74,0x65,0x72,0x73,0x00,0xDC,0x03,0x00,0x00,0x02,0x86,0x78,
		0x00,0x14,0x00,0x00,0x00,0x00;
	.var = .LN423;
	.var = .LN.prvStaticallyAllocatedCreator..end;
	.byte =
		0x00,0x00,0x15,0x78,0x43,0x72,0x65,0x61,0x74,0x6F,0x72,0x54,
		0x61,0x73,0x6B,0x54,0x43,0x42,0x42,0x75,0x66,0x66,0x65,0x72,
		0x00,0x01,0x48,0x10,0x00,0x00,0x05,0x03;
	.var = xCreatorTaskTCBBuffer.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x43,0x72,0x65,0x61,
		0x74,0x6F,0x72,0x54,0x61,0x73,0x6B,0x53,0x74,0x61,0x63,0x6B,
		0x42,0x75,0x66,0x66,0x65,0x72,0x00,0x01,0xFC,0x25,0x00,0x00,
		0x05,0x03;
	.var = uxCreatorTaskStackBuffer.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x6C,0x4E,0x65,0x78,0x74,
		0x52,0x61,0x6E,0x64,0x00,0x01,0x43,0x05,0x00,0x00,0x05,0x03;
	.var = ulNextRand.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x75,0x78,0x43,0x79,0x63,0x6C,
		0x65,0x43,0x6F,0x75,0x6E,0x74,0x65,0x72,0x00,0x01,0xEB,0x13,
		0x00,0x00,0x05,0x03;
	.var = uxCycleCounter.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x15,0x78,0x45,0x72,0x72,0x6F,0x72,
		0x4F,0x63,0x63,0x75,0x72,0x72,0x65,0x64,0x00,0x01,0xF7,0x25,
		0x00,0x00,0x05,0x03;
	.var = xErrorOccurred.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x0F,0xF6,0x0B,0x00,0x00,0x0C,0x0C,
		0x26,0x00,0x00,0xE4,0x0B,0x00,0x00,0x0D,0x90,0x03,0x00,0x8F,
		0x03,0x00,0x00,0x00;
.epcdebug.end:

	.section .debug_line;

	.align 1;
	.type .epcline,STT_OBJECT;
.epcline:
	.inc/binary ".\Standard_Demo\StaticAllocation.sbn", 7277, 2121;
	.var = .LNxAreStaticAllocationTasksStillRunning.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xC4,0x08,0x01,0x00,0x05,0x02;
	.var = .LN0;
	.byte =
		0x05,0x02,0x0D,0x00,0x05,0x02;
	.var = .LN1;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN2;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN3;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN4;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN5;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN6;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN7;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN8;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN.xAreStaticAllocationTasksStillRunning..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvRand.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xBC,0x06,0x01,0x00,0x05,0x02;
	.var = .LN9;
	.byte =
		0x05,0x10,0x0A,0x00,0x05,0x02;
	.var = .LN10;
	.byte =
		0x05,0x2D,0x01,0x00,0x05,0x02;
	.var = .LN11;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN12;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN.prvRand..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNvStartStaticallyAllocatedTasks.;
	.byte =
		0x04,0x01,0x05,0x01,0xE2,0x00,0x05,0x02;
	.var = .LN13;
	.byte =
		0x05,0x13,0x0C,0x00,0x05,0x02;
	.var = .LN14;
	.byte =
		0x05,0x01,0x10,0x00,0x05,0x02;
	.var = .LN.vStartStaticallyAllocatedTasks..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvTimerCallback.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xB2,0x04,0x01,0x00,0x05,0x02;
	.var = .LN15;
	.byte =
		0x05,0x3E,0x10,0x00,0x05,0x02;
	.var = .LN16;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN17;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN18;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN19;
	.byte =
		0x05,0x03,0x0D,0x00,0x05,0x02;
	.var = .LN20;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN21;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN22;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN23;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN24;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN25;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN26;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvTimerCallback..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedTimers.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xCF,0x04,0x01,0x00,0x05,0x02;
	.var = .LN27;
	.byte =
		0x05,0x12,0x0C,0x00,0x05,0x02;
	.var = .LN28;
	.byte =
		0x05,0x1D,0x1A,0x00,0x05,0x02;
	.var = .LN29;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN30;
	.byte =
		0x12,0x00,0x05,0x02;
	.var = .LN31;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN32;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN33;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN34;
	.byte =
		0x05,0x0E,0x0C,0x00,0x05,0x02;
	.var = .LN35;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN36;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN37;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN38;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN39;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN40;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN41;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN42;
	.byte =
		0x05,0x0C,0x01,0x00,0x05,0x02;
	.var = .LN43;
	.byte =
		0x05,0x02,0x0D,0x00,0x05,0x02;
	.var = .LN44;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN45;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN46;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN47;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN48;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN49;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN50;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN51;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN52;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN53;
	.byte =
		0x05,0x03,0x10,0x00,0x05,0x02;
	.var = .LN54;
	.byte =
		0x05,0x18,0x01,0x00,0x05,0x02;
	.var = .LN55;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN56;
	.byte =
		0x0F,0x00,0x05,0x02;
	.var = .LN57;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN58;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN59;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN60;
	.byte =
		0x05,0x0F,0x0A,0x00,0x05,0x02;
	.var = .LN61;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN62;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN63;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN64;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN65;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN66;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN67;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN68;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN69;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN70;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN71;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN72;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN73;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN74;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN75;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN76;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN77;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN78;
	.byte =
		0x05,0x01,0x0C,0x00,0x05,0x02;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedTimers..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedTasks.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xE5,0x05,0x01,0x00,0x05,0x02;
	.var = .LN79;
	.byte =
		0x05,0x18,0x21,0x00,0x05,0x02;
	.var = .LN80;
	.byte =
		0x05,0x02,0x03,0x7B,0x01,0x00,0x05,0x02;
	.var = .LN81;
	.byte =
		0x05,0x22,0x01,0x00,0x05,0x02;
	.var = .LN82;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN83;
	.byte =
		0x13,0x00,0x05,0x02;
	.var = .LN84;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN85;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN86;
	.byte =
		0x05,0x18,0x0A,0x00,0x05,0x02;
	.var = .LN87;
	.byte =
		0x05,0x07,0x01,0x00,0x05,0x02;
	.var = .LN88;
	.byte =
		0x05,0x03,0x0D,0x00,0x05,0x02;
	.var = .LN89;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN90;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN91;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN92;
	.byte =
		0x05,0x1B,0x18,0x00,0x05,0x02;
	.var = .LN93;
	.byte =
		0x05,0x03,0x03,0x7B,0x01,0x00,0x05,0x02;
	.var = .LN94;
	.byte =
		0x05,0x1A,0x01,0x00,0x05,0x02;
	.var = .LN95;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN96;
	.byte =
		0x11,0x00,0x05,0x02;
	.var = .LN97;
	.byte =
		0x05,0x14,0x01,0x00,0x05,0x02;
	.var = .LN98;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN99;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN100;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN101;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN102;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN103;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN104;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN105;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN106;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN107;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN108;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN109;
	.byte =
		0x05,0x01,0x0C,0x00,0x05,0x02;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedTasks..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvStaticallyAllocatedTask.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xB1,0x06,0x01,0x00,0x05,0x02;
	.var = .LN110;
	.byte =
		0x05,0x0E,0x0F,0x00,0x05,0x02;
	.var = .LN111;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvStaticallyAllocatedTask..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvGetNextDelayTime.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xC6,0x06,0x01,0x00,0x05,0x02;
	.var = .LN112;
	.byte =
		0x05,0x12,0x0B,0x00,0x05,0x02;
	.var = .LN113;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN114;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN115;
	.byte =
		0x05,0x02,0x0E,0x00,0x05,0x02;
	.var = .LN116;
	.byte =
		0x05,0x17,0x0B,0x00,0x05,0x02;
	.var = .LN117;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN118;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN119;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN120;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN121;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN.prvGetNextDelayTime..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvSanityCheckCreatedEventGroup.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xDD,0x06,0x01,0x00,0x05,0x02;
	.var = .LN122;
	.byte =
		0x05,0x13,0x0B,0x00,0x05,0x02;
	.var = .LN123;
	.byte =
		0x05,0x3A,0x01,0x00,0x05,0x02;
	.var = .LN124;
	.byte =
		0x05,0x0F,0x0C,0x00,0x05,0x02;
	.var = .LN125;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN126;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN127;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN128;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN129;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN130;
	.byte =
		0x05,0x14,0x01,0x00,0x05,0x02;
	.var = .LN131;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN132;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN133;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN134;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN135;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN136;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN137;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN138;
	.byte =
		0x05,0x14,0x01,0x00,0x05,0x02;
	.var = .LN139;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN140;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN141;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN142;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN143;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN144;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN145;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN146;
	.byte =
		0x05,0x16,0x01,0x00,0x05,0x02;
	.var = .LN147;
	.byte =
		0x05,0x02,0x0B,0x00,0x05,0x02;
	.var = .LN148;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN149;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN150;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN151;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN152;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN153;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvSanityCheckCreatedEventGroup..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedEventGroups.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xB8,0x05,0x01,0x00,0x05,0x02;
	.var = .LN154;
	.byte =
		0x05,0x27,0x1A,0x00,0x05,0x02;
	.var = .LN155;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN156;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN157;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN158;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN159;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN160;
	.byte =
		0x05,0x21,0x01,0x00,0x05,0x02;
	.var = .LN161;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN162;
	.byte =
		0x05,0x13,0x01,0x00,0x05,0x02;
	.var = .LN163;
	.byte =
		0x05,0x22,0x10,0x00,0x05,0x02;
	.var = .LN164;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN165;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN166;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN167;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN168;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN169;
	.byte =
		0x05,0x22,0x01,0x00,0x05,0x02;
	.var = .LN170;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN171;
	.byte =
		0x05,0x14,0x01,0x00,0x05,0x02;
	.var = .LN172;
	.byte =
		0x05,0x01,0x0C,0x00,0x05,0x02;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedEventGroups..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvSanityCheckCreatedSemaphore.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x8A,0x07,0x01,0x00,0x05,0x02;
	.var = .LN173;
	.byte =
		0x05,0x12,0x0C,0x00,0x05,0x02;
	.var = .LN174;
	.byte =
		0x05,0x20,0x0E,0x00,0x05,0x02;
	.var = .LN175;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN176;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN177;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN178;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN179;
	.byte =
		0x05,0x2A,0x0B,0x00,0x05,0x02;
	.var = .LN180;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN181;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN182;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN183;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN184;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN185;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN186;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN187;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN188;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN189;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN190;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN191;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN192;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN193;
	.byte =
		0x05,0x1F,0x03,0x79,0x01,0x00,0x05,0x02;
	.var = .LN194;
	.byte =
		0x05,0x02,0x14,0x00,0x05,0x02;
	.var = .LN195;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN196;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN197;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN198;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN199;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN200;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN201;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN202;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN203;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN204;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN205;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN206;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN207;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN208;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN209;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN210;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN211;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN212;
	.byte =
		0x05,0x1F,0x03,0x79,0x01,0x00,0x05,0x02;
	.var = .LN213;
	.byte =
		0x05,0x20,0x15,0x00,0x05,0x02;
	.var = .LN214;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN215;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN216;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN217;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN218;
	.byte =
		0x05,0x2A,0x0B,0x00,0x05,0x02;
	.var = .LN219;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN220;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN221;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN222;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN223;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN224;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN225;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN226;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN227;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN228;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN229;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN230;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvSanityCheckCreatedSemaphore..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedCountingSemaphores.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x8C,0x02,0x01,0x00,0x05,0x02;
	.var = .LN231;
	.byte =
		0x05,0x13,0x0B,0x00,0x05,0x02;
	.var = .LN232;
	.byte =
		0x05,0x0F,0x1C,0x00,0x05,0x02;
	.var = .LN233;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN234;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN235;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN236;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN237;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN238;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN239;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN240;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN241;
	.byte =
		0x05,0x03,0x10,0x00,0x05,0x02;
	.var = .LN242;
	.byte =
		0x05,0x10,0x01,0x00,0x05,0x02;
	.var = .LN243;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN244;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN245;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN246;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN247;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN248;
	.byte =
		0x05,0x21,0x01,0x00,0x05,0x02;
	.var = .LN249;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN250;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN251;
	.byte =
		0x05,0x01,0x0C,0x00,0x05,0x02;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedCountingSemaphores..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedMutexes.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xA9,0x03,0x01,0x00,0x05,0x02;
	.var = .LN252;
	.byte =
		0x05,0x0F,0x1C,0x00,0x05,0x02;
	.var = .LN253;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN254;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN255;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN256;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN257;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN258;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN259;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN260;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN261;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN262;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN263;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN264;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN265;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN266;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN267;
	.byte =
		0x05,0x10,0x10,0x00,0x05,0x02;
	.var = .LN268;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN269;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN270;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN271;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN272;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN273;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN274;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN275;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN276;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN277;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN278;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN279;
	.byte =
		0x05,0x21,0x01,0x00,0x05,0x02;
	.var = .LN280;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN281;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN282;
	.byte =
		0x05,0x01,0x0C,0x00,0x05,0x02;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedMutexes..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedBinarySemaphores.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xF0,0x03,0x01,0x00,0x05,0x02;
	.var = .LN283;
	.byte =
		0x05,0x0F,0x1D,0x00,0x05,0x02;
	.var = .LN284;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN285;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN286;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN287;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN288;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN289;
	.byte =
		0x05,0x20,0x01,0x00,0x05,0x02;
	.var = .LN290;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN291;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN292;
	.byte =
		0x05,0x10,0x10,0x00,0x05,0x02;
	.var = .LN293;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN294;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN295;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN296;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN297;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN298;
	.byte =
		0x05,0x21,0x01,0x00,0x05,0x02;
	.var = .LN299;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN300;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN301;
	.byte =
		0x12,0x00,0x05,0x02;
	.var = .LN302;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN303;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN304;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN305;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN306;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN307;
	.byte =
		0x05,0x07,0x01,0x00,0x05,0x02;
	.var = .LN308;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN309;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN310;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN311;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN312;
	.byte =
		0x05,0x21,0x01,0x00,0x05,0x02;
	.var = .LN313;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN314;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN315;
	.byte =
		0x05,0x01,0x0C,0x00,0x05,0x02;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedBinarySemaphores..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvSanityCheckCreatedQueue.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xD7,0x07,0x01,0x00,0x05,0x02;
	.var = .LN316;
	.byte =
		0x05,0x02,0x0E,0x00,0x05,0x02;
	.var = .LN317;
	.byte =
		0x05,0x03,0x0D,0x00,0x05,0x02;
	.var = .LN318;
	.byte =
		0x05,0x1C,0x01,0x00,0x05,0x02;
	.var = .LN319;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN320;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN321;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN322;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN323;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN324;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN325;
	.byte =
		0x05,0x10,0x01,0x00,0x05,0x02;
	.var = .LN326;
	.byte =
		0x05,0x04,0x01,0x00,0x05,0x02;
	.var = .LN327;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN328;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN329;
	.byte =
		0x05,0x04,0x0A,0x00,0x05,0x02;
	.var = .LN330;
	.byte =
		0x05,0x35,0x03,0x7A,0x01,0x00,0x05,0x02;
	.var = .LN331;
	.byte =
		0x05,0x03,0x13,0x00,0x05,0x02;
	.var = .LN332;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN333;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN334;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN335;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN336;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN337;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN338;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN339;
	.byte =
		0x05,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN340;
	.byte =
		0x05,0x04,0x01,0x00,0x05,0x02;
	.var = .LN341;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN342;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN343;
	.byte =
		0x05,0x04,0x0A,0x00,0x05,0x02;
	.var = .LN344;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN345;
	.byte =
		0x05,0x05,0x0B,0x00,0x05,0x02;
	.var = .LN346;
	.byte =
		0x05,0x04,0x0A,0x00,0x05,0x02;
	.var = .LN347;
	.byte =
		0x05,0x35,0x03,0x74,0x01,0x00,0x05,0x02;
	.var = .LN348;
	.byte =
		0x05,0x03,0x19,0x00,0x05,0x02;
	.var = .LN349;
	.byte =
		0x05,0x1C,0x01,0x00,0x05,0x02;
	.var = .LN350;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN351;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN352;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN353;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN354;
	.byte =
		0x05,0x1D,0x03,0x4E,0x01,0x00,0x05,0x02;
	.var = .LN355;
	.byte =
		0x05,0x01,0x3D,0x00,0x05,0x02;
	.var = .LN.prvSanityCheckCreatedQueue..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedQueues.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xEA,0x02,0x01,0x00,0x05,0x02;
	.var = .LN356;
	.byte =
		0x05,0x0B,0x22,0x00,0x05,0x02;
	.var = .LN357;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN358;
	.byte =
		0x10,0x00,0x05,0x02;
	.var = .LN359;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN360;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN361;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN362;
	.byte =
		0x05,0x1C,0x01,0x00,0x05,0x02;
	.var = .LN363;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN364;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN365;
	.byte =
		0x05,0x0C,0x10,0x00,0x05,0x02;
	.var = .LN366;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN367;
	.byte =
		0x0E,0x00,0x05,0x02;
	.var = .LN368;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN369;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN370;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN371;
	.byte =
		0x05,0x1D,0x01,0x00,0x05,0x02;
	.var = .LN372;
	.byte =
		0x05,0x03,0x0C,0x00,0x05,0x02;
	.var = .LN373;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN374;
	.byte =
		0x05,0x01,0x0C,0x00,0x05,0x02;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedQueues..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvSanityCheckCreatedRecursiveMutex.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0x94,0x08,0x01,0x00,0x05,0x02;
	.var = .LN375;
	.byte =
		0x05,0x12,0x0A,0x00,0x05,0x02;
	.var = .LN376;
	.byte =
		0x05,0x0E,0x0F,0x00,0x05,0x02;
	.var = .LN377;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN378;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN379;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN380;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN381;
	.byte =
		0x0C,0x00,0x05,0x02;
	.var = .LN382;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN383;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN384;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN385;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN386;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN387;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN388;
	.byte =
		0x05,0x1A,0x03,0x79,0x01,0x00,0x05,0x02;
	.var = .LN389;
	.byte =
		0x05,0x02,0x15,0x00,0x05,0x02;
	.var = .LN390;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN391;
	.byte =
		0x05,0x0F,0x01,0x00,0x05,0x02;
	.var = .LN392;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN393;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN394;
	.byte =
		0x05,0x04,0x0B,0x00,0x05,0x02;
	.var = .LN395;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN396;
	.byte =
		0x05,0x1A,0x03,0x79,0x01,0x00,0x05,0x02;
	.var = .LN397;
	.byte =
		0x05,0x02,0x14,0x00,0x05,0x02;
	.var = .LN398;
	.byte =
		0x05,0x0E,0x01,0x00,0x05,0x02;
	.var = .LN399;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN400;
	.byte =
		0x0B,0x00,0x05,0x02;
	.var = .LN401;
	.byte =
		0x05,0x03,0x0B,0x00,0x05,0x02;
	.var = .LN402;
	.byte =
		0x05,0x02,0x0A,0x00,0x05,0x02;
	.var = .LN403;
	.byte =
		0x05,0x01,0x0A,0x00,0x05,0x02;
	.var = .LN.prvSanityCheckCreatedRecursiveMutex..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedRecursiveMutexes.;
	.byte =
		0x04,0x01,0x05,0x01,0x03,0xBC,0x02,0x01,0x00,0x05,0x02;
	.var = .LN404;
	.byte =
		0x05,0x0F,0x1B,0x00,0x05,0x02;
	.var = .LN405;
	.byte =
		0x05,0x02,0x01,0x00,0x05,0x02;
	.var = .LN406;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN407;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN408;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN409;
	.byte =
		0x0D,0x00,0x05,0x02;
	.var = .LN410;
	.byte =
		0x05,0x25,0x01,0x00,0x05,0x02;
	.var = .LN411;
	.byte =
		0x05,0x02,0x0C,0x00,0x05,0x02;
	.var = .LN412;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN413;
	.byte =
		0x05,0x10,0x10,0x00,0x05,0x02;
	.var = .LN414;
	.byte =
		0x05,0x03,0x01,0x00,0x05,0x02;
	.var = .LN415;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN416;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN417;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN418;
	.byte =
		0x0A,0x00,0x05,0x02;
	.var = .LN419;
	.byte =
		0x05,0x26,0x01,0x00,0x05,0x02;
	.var = .LN420;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN421;
	.byte =
		0x01,0x00,0x05,0x02;
	.var = .LN422;
	.byte =
		0x05,0x01,0x0C,0x00,0x05,0x02;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedRecursiveMutexes..end;
	.byte =
		0x00,0x01,0x01,0x00,0x05,0x02;
	.var = .LNprvStaticallyAllocatedCreator.;
	.byte =
		0x04,0x01,0x05,0x01,0xF0,0x00,0x05,0x02;
	.var = .LN423;
	.byte =
		0x05,0x2D,0x12,0x00,0x05,0x02;
	.var = .LN424;
	.byte =
		0x05,0x2E,0x0A,0x00,0x05,0x02;
	.var = .LN425;
	.byte =
		0x05,0x22,0x0E,0x00,0x05,0x02;
	.var = .LN426;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN427;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN428;
	.byte =
		0x05,0x38,0x0B,0x00,0x05,0x02;
	.var = .LN429;
	.byte =
		0x05,0x3A,0x0A,0x00,0x05,0x02;
	.var = .LN430;
	.byte =
		0x05,0x22,0x0B,0x00,0x05,0x02;
	.var = .LN431;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN432;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN433;
	.byte =
		0x05,0x2F,0x0B,0x00,0x05,0x02;
	.var = .LN434;
	.byte =
		0x05,0x38,0x0A,0x00,0x05,0x02;
	.var = .LN435;
	.byte =
		0x05,0x22,0x0B,0x00,0x05,0x02;
	.var = .LN436;
	.byte =
		0x05,0x0D,0x01,0x00,0x05,0x02;
	.var = .LN437;
	.byte =
		0x05,0x03,0x0A,0x00,0x05,0x02;
	.var = .LN438;
	.byte =
		0x05,0x33,0x0B,0x00,0x05,0x02;
	.var = .LN439;
	.byte =
		0x05,0x2E,0x0A,0x00,0x05,0x02;
	.var = .LN.prvStaticallyAllocatedCreator..end;
	.byte =
		0x00,0x01,0x01;
.epcline.end:

	.section .debug_pubnames;

	.align 1;
.epcpubnames:
	.type .epcpubnames,STT_OBJECT;
	.byte =
		0x5B,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x0E,0x26,0x00,0x00,0x56,0x1A,0x00,0x00,0x78,0x41,0x72,0x65,
		0x53,0x74,0x61,0x74,0x69,0x63,0x41,0x6C,0x6C,0x6F,0x63,0x61,
		0x74,0x69,0x6F,0x6E,0x54,0x61,0x73,0x6B,0x73,0x53,0x74,0x69,
		0x6C,0x6C,0x52,0x75,0x6E,0x6E,0x69,0x6E,0x67,0x00,0x40,0x1B,
		0x00,0x00,0x76,0x53,0x74,0x61,0x72,0x74,0x53,0x74,0x61,0x74,
		0x69,0x63,0x61,0x6C,0x6C,0x79,0x41,0x6C,0x6C,0x6F,0x63,0x61,
		0x74,0x65,0x64,0x54,0x61,0x73,0x6B,0x73,0x00,0x00,0x00,0x00,
		0x00;
.epcpubnames.end:

	.section .debug_aranges;

	.align 1;
.epcaranges:
	.type .epcaranges,STT_OBJECT;
	.byte =
		0xAC,0x00,0x00,0x00,0x02,0x00;
	.var = .epcdebug;
	.byte =
		0x04,0x00,0x00,0x00,0x00,0x00;
	.var = .LNxAreStaticAllocationTasksStillRunning.;
	.var = .LN.xAreStaticAllocationTasksStillRunning..end-.LNxAreStaticAllocationTasksStillRunning.;
	.var = .LNprvRand.;
	.var = .LN.prvRand..end-.LNprvRand.;
	.var = .LNvStartStaticallyAllocatedTasks.;
	.var = .LN.vStartStaticallyAllocatedTasks..end-.LNvStartStaticallyAllocatedTasks.;
	.var = .LNprvStaticallyAllocatedCreator.;
	.var = .LN.prvStaticallyAllocatedCreator..end-.LNprvStaticallyAllocatedCreator.;
	.var = .LNprvTimerCallback.;
	.var = .LN.prvTimerCallback..end-.LNprvTimerCallback.;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedTimers.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedTimers..end-.LNprvCreateAndDeleteStaticallyAllocatedTimers.;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedTasks.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedTasks..end-.LNprvCreateAndDeleteStaticallyAllocatedTasks.;
	.var = .LNprvStaticallyAllocatedTask.;
	.var = .LN.prvStaticallyAllocatedTask..end-.LNprvStaticallyAllocatedTask.;
	.var = .LNprvGetNextDelayTime.;
	.var = .LN.prvGetNextDelayTime..end-.LNprvGetNextDelayTime.;
	.var = .LNprvSanityCheckCreatedEventGroup.;
	.var = .LN.prvSanityCheckCreatedEventGroup..end-.LNprvSanityCheckCreatedEventGroup.;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedEventGroups.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedEventGroups..end-.LNprvCreateAndDeleteStaticallyAllocatedEventGroups.;
	.var = .LNprvSanityCheckCreatedSemaphore.;
	.var = .LN.prvSanityCheckCreatedSemaphore..end-.LNprvSanityCheckCreatedSemaphore.;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedCountingSemaphores.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedCountingSemaphores..end-.LNprvCreateAndDeleteStaticallyAllocatedCountingSemaphores.;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedMutexes.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedMutexes..end-.LNprvCreateAndDeleteStaticallyAllocatedMutexes.;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedBinarySemaphores.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedBinarySemaphores..end-.LNprvCreateAndDeleteStaticallyAllocatedBinarySemaphores.;
	.var = .LNprvSanityCheckCreatedQueue.;
	.var = .LN.prvSanityCheckCreatedQueue..end-.LNprvSanityCheckCreatedQueue.;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedQueues.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedQueues..end-.LNprvCreateAndDeleteStaticallyAllocatedQueues.;
	.var = .LNprvSanityCheckCreatedRecursiveMutex.;
	.var = .LN.prvSanityCheckCreatedRecursiveMutex..end-.LNprvSanityCheckCreatedRecursiveMutex.;
	.var = .LNprvCreateAndDeleteStaticallyAllocatedRecursiveMutexes.;
	.var = .LN.prvCreateAndDeleteStaticallyAllocatedRecursiveMutexes..end-.LNprvCreateAndDeleteStaticallyAllocatedRecursiveMutexes.;
	.byte =
		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00;
.epcaranges.end:

	.section/DOUBLE32 seg_dmda;

	.align 4;
	.type ulNextRand.,STT_OBJECT;
	.byte ulNextRand.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxCycleCounter.,STT_OBJECT;
	.byte uxCycleCounter.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type xErrorOccurred.,STT_OBJECT;
	.byte xErrorOccurred.[] =
		0x00,0x00,0x00,0x00;
	.align 4;
	.type uxLastCycleCounter.0.,STT_OBJECT;
	.byte uxLastCycleCounter.0.[] =
		0x00,0x00,0x00,0x00;
	.align 8;
	.type .sStatCr.1,STT_OBJECT;
	.byte .sStatCr.1[] =
		0x53,0x74,0x61,0x74,0x43,0x72,0x65,0x61,0x74,0x65,0x00;
	.align 4;
	.type .sT1.2,STT_OBJECT;
	.byte .sT1.2[] =
		0x54,0x31,0x00;
	.align 8;
	.type .sDRTOSF.3,STT_OBJECT;
	.byte .sDRTOSF.3[] =
		0x44,0x3A,0x5C,0x52,0x54,0x4F,0x53,0x5C,0x46,0x72,0x65,0x65,
		0x52,0x54,0x4F,0x53,0x2D,0x72,0x65,0x6C,0x65,0x61,0x73,0x65,
		0x2D,0x46,0x72,0x65,0x65,0x52,0x54,0x4F,0x53,0x76,0x31,0x30,
		0x2E,0x35,0x2E,0x78,0x5C,0x44,0x65,0x6D,0x6F,0x5C,0x43,0x6F,
		0x6D,0x6D,0x6F,0x6E,0x5C,0x4D,0x69,0x6E,0x69,0x6D,0x61,0x6C,
		0x5C,0x53,0x74,0x61,0x74,0x69,0x63,0x41,0x6C,0x6C,0x6F,0x63,
		0x61,0x74,0x69,0x6F,0x6E,0x2E,0x63,0x00;
	.align 4;
	.type .sStatic.5,STT_OBJECT;
	.byte .sStatic.5[] =
		0x53,0x74,0x61,0x74,0x69,0x63,0x00;
