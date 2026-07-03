/***************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :  	DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Autdet.asm
*  Description      :   Auto detection routines
*
******************************************************************************/


#include "def21593.h"
#include "..\src\system\Include\Codeid.h"
#include "..\src\system\Include\Commn.h"

.IMPORT "..\src\system\Include\Def_Struct.h";

#define subdatatype_handling
#define PREVPC_COMMENTED
#define SKIP_PREVPC_CLEAR

.extern struct kernel Frmwk.;
.extern unsave_timer.;
.extern common_rtn_label;
.extern PcmZeroCountMax.;
.extern AAC_DataLen.;
.global _streamdetect;

#ifdef DTSX_LATENCY_CALC
.extern DTSX_Latency_loop_cnt.;
.section/bw seg_dtsx_Latency_data; 
.var DTSX_latency_framecount. = 0;
.global DTSX_latency_framecount.;
.section/bw seg_dtsx_Latency_data;
.var DTSX_Latency_unformat_header_chk. = 0;
.global DTSX_Latency_unformat_header_chk.;
#endif//DTSX_LATENCY_CALC

.section/sw Seg_Autdet_Code;

/******************************************************************************
			      Initializations  (modified)
******************************************************************************/
_streamdetect:

		bit clr mode1  BITM_REGF_MODE1_PEYEN;
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;

	l1	= dm(Frmwk.->Misc->Control->InAutobufsizeby2);
	r15 = dm(Frmwk.->Misc->Protect->save_rxisr);
	l2 	= l1;

	b1 	= dm(Frmwk.->Autdet->InAutbuf_ptr);

    r9	= dm(Frmwk.->Autdet->StreamDetectEnable);
    r9	= pass r9;
    if eq jump common_rtn_label;

	l4 	= dm(Frmwk.->IOP->Pack->length);
	b4 	= dm(Frmwk.->IOP->Pack->heap);

	r9  = dm(Frmwk.->Autdet->AlignFlg);
	r9  = pass r9;
	if eq jump freset1;
	r11 = r9 - 1;
	if eq jump fresety;
	if lt jump freset1;

	jump Rx0IntMainProcess;

    freset1:
	jump freset1Beg;

freset1Beg:
	dm(Frmwk.->Autdet->AlignFlg) = m6;
	r0  = SYNCSIGUNKNOWN;
	dm(Frmwk.->Autdet->MSGR4)=r0;
	dm(Frmwk.->Autdet->mpegstreamdetected)=m5;
	r11 = dm(Frmwk.->IOP->Pack->heap);
	dm(Frmwk.->Autdet->HeaderAddress) 	= r11;
    	dm(Frmwk.->IOP->Pack->rd_ptr) 		= r11;
    	dm(Frmwk.->IOP->Pack->wr_ptr) 		= r11;
	dm(Frmwk.->Autdet->PauseCount) 		= m5;
	dm(Frmwk.->Autdet->LongPause)  		= m5;
	dm(Frmwk.->Autdet->SmallPause) 		= m5;
	jump ExitSPDIFint;

    fresety:
	jump fresetyBeg;

fresetyBeg:

#ifdef CUSTOMIZATION

#ifndef SKIP_PREVPC_CLEAR

#ifdef PREVPC_COMMENTED
	r0  = -1;
	dm(Frmwk.->Autdet->PrevPc) = r0;

#endif
#endif
#endif /* End of CUSTOMIZATION  */

    fresetx:
	jump fresetxBeg;

fresetxBeg:

#ifdef CUSTOMIZATION

	r0 = dm(Frmwk.->autodetect_mode);  // FORCEPCM2 Odd address modification upgrade
	r1 = FORCEPCM2;
	comp(r0,r1);
	if ne jump ForcePCM2_No;
	r0 = dm(Frmwk.->IOP->Pack->heap);
	dm(Frmwk.->Autdet->HeaderAddress) = r0;
	dm(Frmwk.->IOP->Pack->rd_ptr) = r0;
	dm(Frmwk.->IOP->Pack->wr_ptr) = r0;

ForcePCM2_No:

	dm(Frmwk.->Autdet->BurstSyncFoundHalfPCM) = m5;
#endif
	r0  = SYNCSIGUNKNOWN;
	dm(Frmwk.->Autdet->MSGR4) = r0;
	dm(Frmwk.->Autdet->mpegstreamdetected)=m5;
	dm(Frmwk.->Autdet->PauseCount) = m5;
	dm(Frmwk.->Autdet->LongPause) = m5;
	dm(Frmwk.->Autdet->SmallPause) = m5;
	dm(Frmwk.->Autdet->FormatStream) = m5;
	dm(Frmwk.->Autdet->streamdetected) = m5;
	dm(Frmwk.->Autdet->MayBeDTS) = m5;
	dm(Frmwk.->Autdet->DTSSampleCount) = m5;
	dm(Frmwk.->Autdet->InitHeaderWritten) = m5;
	dm(Frmwk.->Autdet->DataCanBeCopied) = m5;
	dm(Frmwk.->IOP->datacanbeprocessednow) = m5;
	dm(Frmwk.->Autdet->PcmHeaderWritten) = m5;
	dm(Frmwk.->Autdet->empty) = m5;

	dm(Frmwk.->Autdet->HeaderPlaceWritten) = m5;
	r0 = PREVPCCLEARCOUNTMAX;
	dm(Frmwk.->Autdet->PrevPcClearCount) = r0;
	r0  = dm(Frmwk.->SampleDropCount);
	dm(Frmwk.->Autdet->PcmCount) = r0;
	r0=dm(PcmZeroCountMax.);
	dm(Frmwk.->Autdet->PcmZeroCount) = r0;
	dm(Frmwk.->Autdet->PcmDetected) = m5;
    dm(Frmwk.->Autdet->MayBePcm) = m5;

	dm(Frmwk.->Autdet->BurstSyncFound) = m5;
	dm(Frmwk.->Autdet->BurstSyncFoundHalf) = m5;
	dm(Frmwk.->Autdet->BurstPcFound) = m5;
	dm(Frmwk.->Autdet->TransferNeeded) = m5;
	dm(Frmwk.->Autdet->CompareWord) = m5;

//Need to be valid for full length of any stream
	r0  = dm(Frmwk.->Autdet->AlignFlg);
	r1  = 2;
	comp(r0,r1);
	if ne jump noStrIdenBeg;

	jump StrIdenBeg;

noStrIdenBeg:
	r0  = 2;
	dm(Frmwk.->Autdet->AlignFlg) = r0;
	jump ExitSPDIFint;

/*******************************************************************************
			Rx0IntMainProcess      (modified)
*******************************************************************************/

Rx0IntMainProcess:

	i1  = b1;
	i2  = b2;


	r10 = l1;
	r10 = lshift r10 by -1;

	bit set mode1 BITM_REGF_MODE1_PEYEN;
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;


	lcntr = r10, do pckdata until lce;
	   r10  = dm(i2,2);
	   r10  = lshift r10 by -16;
	pckdata:dm(i1,2) = r10;

	bit clr mode1 BITM_REGF_MODE1_PEYEN;
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;


#ifdef CUSTOMIZATION

	r0 = dm(Frmwk.->Autdet->LongPause);
	r0 = pass r0;
	if eq jump (pc,No_LongPause_flag);
	r0 = 10;
	dm(Frmwk.->Autdet->StreamBlockCountMax) = r0;
	dm(Frmwk.->Autdet->StreamBlockCount) = r0;
	dm(Frmwk.->Autdet->LongPause) = m5;

	No_LongPause_flag:
#endif
	r0 = dm(Frmwk.->Autdet->streamdetected);
	r0 = pass r0;
	if eq jump noFormatStr;

	jump FormatStr;

noFormatStr:
	r0 = dm(Frmwk.->Misc->Control->XPcm);
	r0 = pass r0;
	if ne jump StreamIdentify;

	r0 = dm(Frmwk.->Misc->Control->ForcePcm);
	r0 = pass r0;
	if ne jump PcmProcessBeg;

	r0 = dm(Frmwk.->Autdet->PcmDetected);
	r0 = pass r0;
	if ne jump PcmProcessBeg;

	r0 = dm(Frmwk.->Autdet->MayBePcm);
	r0 = pass r0;
	if eq jump StreamIdentify;

#ifdef CUSTOMIZATION

	r14 = dm(Frmwk.->autodetect_mode);
	r0 = CUSTOMAUTODETECT1;  //0xA
	comp(r0,r14);
	if ne jump StreamIdentify; // StreamIdentify
#endif

  	jump PcmProcessBeg;
/*-------------------------------------------------------------------------
			PCM Process      (modified)
-------------------------------------------------------------------------*/

    PcmProcessBeg:
	jump PcmProcess;


PcmProcess:
	dm(Frmwk.->Autdet->PcmHeaderWritten) = m6;
	r14 = dm(Frmwk.->Misc->Control->InAutobufsizeby2);
	i2=b2;

	i4 = dm(Frmwk.->IOP->Pack->wr_ptr);
	dm(Frmwk.->Autdet->HeaderAddress) = i4;
	dm(Frmwk.->Autdet->HeaderPlaceWritten) = m6;

	lcntr = r14,do pcmcpy_lop until lce;
		   r10 = dm(i2,1);
	pcmcpy_lop: dm(i4,1) = r10;

	dm(Frmwk.->IOP->Pack->wr_ptr) = i4;

	jump StreamIdentify;

Rx0IntMainProcess.END:
PcmProcess.END:
/******************************************************************************
			FORMAT/UNFORMAT STREAM BLOCK (modified)
*******************************************************************************/

FormatStr:
	r0 = dm(Frmwk.->Autdet->FormatStream);
	r0 = pass r0;
	if eq jump unformatDTS;

	jump FormatStreamBlock;


/******************************************************************************
			UNFORMAT STREAM BLOCK	     (modified)
*******************************************************************************/

    unformatDTS:

	r0 = dm(Frmwk.->Autdet->StreamBlockCount);
	r0 = r0 - 1;
	dm(Frmwk.->Autdet->StreamBlockCount) = r0;

	r0 = dm(Frmwk.->autodetect_mode);
	r1 = 9;
	comp(r0,r1);

	if eq jump ChkStreamBlockCountZero;

	r0  = dm(Frmwk.->Autdet->DTSSampleCount);
	r1  = 4096;
	r2  = 4;
	comp(r0,r1);
	if eq jump ChkMissDet;
	r1  = 2048;
	r2  = 3;
	comp(r0,r1);
	if eq jump ChkMissDet;
	r1  = 1024;
	r2  = 2;
	comp(r0,r1);
	if eq jump ChkMissDet;
	r1  = 512;
	r2  = 1;
	comp(r0,r1);
	if ne jump ChkStreamBlockCountZero;

ChkMissDet:

	r0 = dm(Frmwk.->Autdet->StreamBlockCount);
	r1 = dm(Frmwk.->Autdet->unformatdtsblockcountmax0);
	r2 = r2 - 1;
	comp(r0,r1);
	if eq jump ChkHeader;
	r2 =  pass r2;
	if eq jump ChkStreamBlockCountZero;
	r1 = dm(Frmwk.->Autdet->unformatdtsblockcountmax1);
	r2 = r2 - 1;
	comp(r0,r1);
	if eq jump ChkHeader;
	r2 =  pass r2;
	if eq jump ChkStreamBlockCountZero;
	r1 = dm(Frmwk.->Autdet->unformatdtsblockcountmax2);
	r2 = r2 - 1;
	comp(r0,r1);
	if eq jump ChkHeader;
	r2 =  pass r2;
	if eq jump ChkStreamBlockCountZero;
	r1 = dm(Frmwk.->Autdet->unformatdtsblockcountmax3);
	comp(r0,r1);
	if ne jump ChkStreamBlockCountZero;


ChkHeader:
	r0 = dm(Frmwk.->Autdet->StreamBlockOffset);
	r1 = dm(Frmwk.->Autdet->InAutbuf_ptr);
	r0 = r1 + r0;
	i1 = r0;
	r0 = dm(i1,1);
	r2 = dm(i1,1);

	r1 = 0x7ffe;//DTSSYNCSIG1SHUFFLED;

	comp(r0,r1);
	if ne jump checksig2;
	r1 = 0x8001;

	comp(r2,r1);
	if eq jump freset1;

checksig2:

	r1 = 0x1fff;//DTSSYNCSIG2SHUFFLED;
	comp(r0,r1);
	if ne jump ChkStreamBlockCountZero;
	r1 = 0xe800;
	comp(r2,r1);
	if eq jump freset1;

ChkStreamBlockCountZero:

	r14 = dm(Frmwk.->Misc->Control->InAutobufsizeby2);
	i1 = b1;

    format0pro5:

	r0 = dm(Frmwk.->Autdet->MSGR4);
	r1 = 3;
	comp(r0,r1);
	if eq jump do_for_dts;

	r0 = dm(Frmwk.->Autdet->MSGR4);
	r1 = 4;
	comp(r0,r1);
	if ne jump skip_not_dts;

do_for_dts:
//#ifdef __DTS__

    i4 = dm(Frmwk.->IOP->Pack->wr_ptr);
	r11 = pass r14;
	if eq jump ExitSPDIFint;

loopstartldcd:

	r0 = dm(Frmwk.->Autdet->empty);
	r0 = pass r0, r10 = dm(i1,m6);
	if ne jump newpointerldcd;

	r10 = lshift r10 by 16;
	dm(i4,m5) = r10;
	dm(Frmwk.->Autdet->empty) = m6;
	jump loopendcheckldcd;

newpointerldcd:

	r0 = dm(i4,m5);
	r0 = r0 or r10;
	dm(i4,m6) = r0;
	dm(Frmwk.->IOP->Pack->wr_ptr)= i4;
	dm(Frmwk.->Autdet->empty) = m5;

loopendcheckldcd:
	r11 = r11 - 1;
	if ne jump loopstartldcd;

//#endif

skip_not_dts:

	r0 = dm(Frmwk.->Autdet->StreamBlockCount);
	r0 = pass r0;
	if ne jump ExitSPDIFint;

    format0pro1:

	r0 = dm(Frmwk.->Autdet->StreamBlockOffset);
	r1 = dm(Frmwk.->Autdet->InAutbuf_ptr);
	r0 = r1 + r0;
	i1 = r0;

	r0 = dm(i1,1);
	r2 = dm(i1,1);
	r1 = DTSSYNCSIG1SHUFFLED;
	comp(r0,r1);
	if ne jump chksig2;
	r1 = 0x8001;
	comp(r2,r1);
	if eq jump format0pro4;

chksig2:

	r1 = DTSSYNCSIG2SHUFFLED;
	comp(r0,r1);
	if ne jump fresetx;
	r1 = 0xe800;
	comp(r2,r1);
	if ne jump fresetx;

    format0pro4:
	r2 = dm(Frmwk.->Autdet->StreamBlockCountMax);
	dm(Frmwk.->Autdet->StreamBlockCount) = r2;

	r0 = dm(Frmwk.->Autdet->MSGR4);
	r1 = 3;
	comp(r0,r1);
	if eq jump do_for_dts1;

	r0 = dm(Frmwk.->Autdet->MSGR4);
	r1 = 4;
	comp(r0,r1);
	if ne jump ExitSPDIFint;

do_for_dts1:

//#ifdef __DTS__

	i4 = dm(Frmwk.->IOP->Pack->wr_ptr);
	r0 = dm(Frmwk.->Autdet->StreamBlockOffset);
	r0 = lshift r0 by -1;
	r4 = dm(Frmwk.->Misc->Control->InAutobufsizeby2);
	r4 = lshift r4 by -1;
	r0 = r0-r4;

	r1 = dm(Frmwk.->Autdet->StreamBlockOffset);
	r2 = 0x1;
	r1 = r1 and r2;
	if ne r0 = r0 + 1;

	m2 = r0;
	modify(i4,m2)(nw);
	dm(Frmwk.->Autdet->HeaderAddress) = i4;
	dm(Frmwk.->Autdet->HeaderPlaceWritten) = m6;
#ifdef DTSX_LATENCY_CALC   	
	r10 = dm(DTSX_Latency_loop_cnt.);
	r10 = r10-1;
	dm(DTSX_Latency_loop_cnt.) = r10;
	r10 = pass r10;
	if ne jump Skip_latency_calc;
	r0 = dm(i4,m5);
	r1 = 0x7ffe8001;
	comp(r0,r1);
	if eq jump update_DTSCD_header_Type1;
	r1 = 0x1fffe800;
	comp(r0,r1);
	if eq jump update_DTSCD_header_Type2;
	jump Timer_enable_flow;
update_DTSCD_header_Type1:
	dm(DTSX_Latency_unformat_header_chk.) = m6;
	jump Timer_enable_flow;
update_DTSCD_header_Type2:
	dm(DTSX_Latency_unformat_header_chk.) = m5;
Timer_enable_flow:
	r13 = dm(Frmwk.->DTSX->dtsxframecount);
	dm(DTSX_latency_framecount.) = r13;
	dm(i4,m5) = 0xf8726053;
	TPERIOD = 0x7FFFFFFF;
	TCOUNT = TPERIOD;
	nop;nop;
	nop;nop;
	bit set MODE2 BITM_REGF_MODE2_TIMEN;
	nop;nop;		
Skip_latency_calc:
#endif//DTSX_LATENCY_CALC	

//#endif

	jump ExitSPDIFint;

format0pro3:

	r0 = dm(Frmwk.->Autdet->MSGR4);
	r1 = 3;
	comp(r0,r1);
	if eq jump do_for_dts2;

	r0 = dm(Frmwk.->Autdet->MSGR4);
	r1 = 4;
	comp(r0,r1);
	if ne jump skip_not_dts2;

do_for_dts2:

///#ifdef __DTS__

	i4 = dm(Frmwk.->IOP->Pack->wr_ptr);
	r0 = dm(Frmwk.->Autdet->dtssyncmsb);
	r1 = dm(Frmwk.->Autdet->dtssynclsb);
	r0 = lshift r0 by 16;
	r0 = r1 or r0;
	dm(i4,1) = r0;
    dm(Frmwk.->IOP->Pack->wr_ptr) = i4;
	dm(Frmwk.->Autdet->empty) = m5;

//#endif

skip_not_dts2:

	r14 = pass r14;
	if gt jump format0pro5;
	jump ExitSPDIFint;
/******************************************************************************
			FORMAT STREAM BLOCK	  (modified)
******************************************************************************/
format0pro3.END:

FormatStreamBlock:
	i1  = b1;
	r14 = dm(Frmwk.->Misc->Control->InAutobufsizeby2);

    FormatStrBeg:

    r2  = dm(Frmwk.->Autdet->MSGR4);
    r0  = 2;
	r2  = r2-r0;
	if ne jump notdolbysteam;

    dm(Frmwk.->Autdet->HIGHTOLOWBRDOLBY) = m6;

notdolbysteam:

	r2  = dm(Frmwk.->Autdet->StreamBlockCount);
	r2  = pass r2;
	if eq jump fresety;

	dm(Frmwk.->Autdet->HIGHTOLOWBRDOLBY) = m5;

	r2  = r2 - 1;
	dm(Frmwk.->Autdet->StreamBlockCount) = r2;

	r0  = dm(Frmwk.->Autdet->TransferNeeded);
	r0  = pass r0;
	if eq jump noproc_for_cpy;
	jump proc_for_cpy;

noproc_for_cpy:
	r0  = dm(Frmwk.->Autdet->BurstSyncFound);
	r0  = pass r0;
	if eq jump HuntHeaderAgain1;

	dm(Frmwk.->Autdet->BurstSyncFound) = m5;
	jump rdSamp;

FormatStreamBlock.END:

rdSamp:

	r0 = dm(Frmwk.->Autdet->BurstPcFound);
	r0 = pass r0;
	if ne jump chkforPd1;

	r14 = r14 - 1,r10 = dm(i1,1);	    /* PC */
#ifdef subdatatype_handling
	dm(Frmwk.->Autdet->pc_value) = r10;
#endif
	r1  = 0x001f;
	r11 = r10 and r1;

	r1  = 3;
	comp(r11,r1);
	if eq jump readlen1pause;

	r1  = dm(Frmwk.->Autdet->PrevPc);
	comp(r1,r11);
	if ne jump nochkforPd;

	jump chkforPd;

nochkforPd:

	dm(Frmwk.->Autdet->PrevPc) = r11;
	jump fresetx;

rdSamp.END:

chkforPd:		  // marked "f"	in flow chart

    r0  = 0x00000080;
	r0  = r0 and r10;	  // check for error bit
	if ne jump fresetx;

    chkforPd1:
	dm(Frmwk.->Autdet->BurstPcFound) = m5;

	r14 = pass r14;
	if eq jump ExitSPDIFint3;

	r14 = r14 - 1,r10 = dm(i1,1);	    /* PD */
	r10 = pass r10;
	if eq jump fresetx;

	r13 = DOLBYSTREAMLENGTH;
	dm(Frmwk.->Autdet->No_Of_DWords_In_Present_Burst) = r13;
	dm(Frmwk.->Autdet->streamdetected) = m6;

	dm(Frmwk.->Autdet->PcmDetected) = m5;

	dm(Frmwk.->Autdet->mpegstreamdetected)=m5;

	r1 = 3;
	comp(r11,r1);
	if eq jump readlen1pause;

	r1 = 1;
	r4 = 2;
	r0 = dm(Frmwk.->Autdet->dolbyblockcountmax);
	r9 = DOLBYSTREAMLENGTH;
	comp(r11,r1);
	r1 = 682;
	if eq jump readlen1Beg;

	dm(Frmwk.->Autdet->mpegstreamdetected)=m6;

	r1 = 4;
	r4 = 5;
	r0 = dm(Frmwk.->Autdet->mpegl1blockcountmax);
	r9 = MPEGL1STREAMLENGTH - 4;
	comp(r11,r1);
	r1 = 64;
	if eq jump readlen1Beg;

	r1 = 5;
	r4 = 6;
	r0 = dm(Frmwk.->Autdet->mpegl2blockcountmax);
	r9 = MPEGL2STREAMLENGTH - 4;
	comp(r11,r1);
	r1 = 64;
	if eq jump readlen1Beg;

	r1 = 6;
	r4 = 6;
	r0 = dm(Frmwk.->Autdet->mpegl2blockcountmax);
	r9 = MPEGL2STREAMLENGTH - 4;
	comp(r11,r1);
	r1 = 64;
	if eq jump readlen1Beg;

	dm(Frmwk.->Autdet->mpegstreamdetected)=m5;

	/* MPEGH */
	r1 = 0x19;  //MPEGH
	r4 = 25;  //MSGR4
	r2 = dm(Frmwk.->sampling_fs_micro);
	r3 = 2;
	comp(r2,r3);
	if eq jump mpegh_2Ch48kHz;
	r3 = 10;
	comp(r2,r3);
	if eq jump mpegh_2Ch192kHz;
mpegh_2Ch48kHz:
	r0 = dm(Frmwk.->Autdet->mpeghblockcountmax);
	r9 = (MPEGHSTREAMLENGTH/4)-4;
	comp(r11,r1);
	r1 = 128;
	if eq jump readlen1Beg;
mpegh_2Ch192kHz:
    r2 = dm(Frmwk.->autodetect_mode);
    r3 = 9;
    comp(r2,r3);
    if eq jump mpegh_8Ch192kHz;
	r0 = dm(Frmwk.->Autdet->mpeghblockcountmax);
	r9 = (MPEGHSTREAMLENGTH/4)-4;
	comp(r11,r1);
	r1 = 128;
	if eq jump readlen1Beg;
mpegh_8Ch192kHz:
	r0 = dm(Frmwk.->Autdet->mpeghblockcountmax);
	r9 = (MPEGHSTREAMLENGTH)-4;
	comp(r11,r1);
	r1 = 512;
	if eq jump readlen1Beg;
/* MPEGH */


	r1 = 7;
	r4 = 8;
	r0 = dm(Frmwk.->Autdet->aacblockcountmax);	// AAC1 (16*2)
	r9 = AACSTREAMLENGTH-4; //1024
	comp(r11,r1);
	r1 = 64;
	if eq jump readlen1Beg;


#ifdef MPEG4_AAC

	r1 = 20;
	comp(r11,r1);
	if ne jump Check_For_LATM_LOAS;

	r2 = dm(Frmwk.->Autdet->pc_value);
	r2 = fext r2 by 5:2;

	r1 = 0;
	r0 = dm(Frmwk.->Autdet->aacblockcountmax);	//32
	r9 = AACSTREAMLENGTH-4; //1024
	comp(r2,r1);
	r1 = 64;
	if eq jump readlen1Beg;

	r0 = dm(MPEG4_AAC_LC.);
	r0 = pass r0;
	if ne jump Check_For_FurtherAAC;

	r1 = 1;
	r0 = dm(Frmwk.->Autdet->aacblockcountmax_hrls);	//64
	r9 = AACSTREAMLENGTH_HRLS-4; //2048
	comp(r2,r1);
	r1 = 64;
	if eq jump readlen1Beg;

	r1 = 2;
	r0 = dm(Frmwk.->Autdet->aacblockcountmax_qrls);	//128
	r9 = AACSTREAMLENGTH_QRLS-4; //4096
	comp(r2,r1);
	r1 = 64;
	if eq jump readlen1Beg;

	r1 = 3;
	r0 = dm(Frmwk.->Autdet->aacblockcountmax_drhs);	//16
	r9 = AACSTREAMLENGTH_DRLS-4; //512
	comp(r2,r1);
	r1 = 64;
	if eq jump readlen1Beg;


/*************MPEG-4 LATM/LOAS support ***********************/
Check_For_LATM_LOAS:
	r1 = 23;
	comp(r11,r1);
	if ne jump Check_For_FurtherAAC;

	r2 = dm(Frmwk.->Autdet->pc_value);
	r1 = fext r2 by 5:2;
	r2 = fext r2 by 8:1;
	r2= r1 xor r2;

	r1 =1;
	r0 = dm(Frmwk.->Autdet->aacblockcountmax_latmloas2);	//32
	r9 = AACSTREAMLENGTH_LATM_LOAS2-4; //1024
	comp(r1,r2);
	r1 = 64;
	if eq jump readlen1Beg;

	r0 = dm(MPEG4_AAC_LC.);
	r0 = pass r0;
	if ne jump Check_For_FurtherAAC;

	r0 = dm(Frmwk.->Autdet->aacblockcountmax_latmloas0);	//30
	r9 = AACSTREAMLENGTH_LATM_LOAS0-4; //960
	r2 = pass r2;
	r1 = 64;
	if eq jump readlen1Beg;

	r1 =3;
	r0 = dm(Frmwk.->Autdet->aacblockcountmax_latmloas1);	//60
	r9 = AACSTREAMLENGTH_LATM_LOAS1-4; //1920
	comp(r1,r2);
	r1 = 64;
	if eq jump readlen1Beg;

	r0 = dm(Frmwk.->Autdet->aacblockcountmax_latmloas3);	//64
	r9 = AACSTREAMLENGTH_LATM_LOAS3-4; //2048
	r1 = 64;
	jump readlen1Beg;


/*************************************************************/
#endif


Check_For_FurtherAAC:


	r1 = 0x1c;			// AAC2
	r4 = 8;
	r0 = dm(Frmwk.->Autdet->aacblockcountmax);
	r9 = AACSTREAMLENGTH-4;
	comp(r11,r1);
	r1 = 64;
	if eq jump readlen1Beg;

	dm(Frmwk.->Autdet->mpegstreamdetected)=m6;

	r1 = 8; 			// avoid hardcoding
	r4 = 5;
	r0 = dm(Frmwk.->Autdet->mpegl1blockcountmax);
	r9 = MPEGL1STREAMLENGTH - 4;
	comp(r11,r1);
	r1 = 64;
	if eq jump readlen1Beg;

	r1 = 9;
	r4 = 6;
	r0 = dm(Frmwk.->Autdet->mpegl2blockcountmax);
	r9 = MPEGL2STREAMLENGTH - 4;
	comp(r11,r1);
	r1 = 64;
	if eq jump readlen1Beg;

	dm(Frmwk.->Autdet->mpegstreamdetected)=m5;

	r1 = 11;
	r4 = 4;
	r0 = dm(Frmwk.->Autdet->dtsblockcountmax1);
	r9 = DTSSTREAM1LENGTH-4;

	comp(r11,r1);
	r1 = 682;
	if eq jump readlen1Beg;

	r1 = 12;
	r4 = 3;
	r0 = dm(Frmwk.->Autdet->dtsblockcountmax2);

	r9 = DTSSTREAM2LENGTH-4;

	comp(r11,r1);
	r1 = 682;
	if eq jump readlen1Beg;

	r1 = 13;
	r4 = 4;
	r0 = dm(Frmwk.->Autdet->dtsblockcountmax3);


	r9 = DTSSTREAM3LENGTH-4;

	comp(r11,r1);
	r1 = 682;
	if eq jump readlen1Beg;

//DD+
	r1 = 21;
	r4 = SYNCSIGDDPLUS;
	r0 = dm(Frmwk.->Autdet->ddplusblockcountmax);
    r9 = DDPLUS0STREAMLENGTH - 4; // DD+
	comp(r11,r1);
	r1 = 682;
#ifndef subdatatype_handling
	if eq jump readlen1Beg;
#else
	if ne jump checkTrueHD;
	r2 = dm(Frmwk.->Autdet->pc_value);
	r2 = fext r2 by 5:2;
	if sz jump readlen1Beg;
checkTrueHD:
#endif
// True-HD
    r1 = 22;
	r4 = SYNCSIGTRUEHD;
	r0 = dm(Frmwk.->Autdet->truehdblockcountmax);
	r9 = TRUEHDSTREAMLENGTH-4;
	comp(r11,r1);
	r1 = 682;
#ifndef subdatatype_handling
	if eq jump readlen1Beg;
#else
	if ne jump checkDTSHD;
	r2 = dm(Frmwk.->Autdet->pc_value);
	r2 = fext r2 by 5:2;
	if sz jump readlen1Beg;

checkDTSHD:
#endif

/******************************************************************************
                           DTS MA/HD/LBR
******************************************************************************/
	r1 = 17;  // DTS HD

	r0 = dm(Frmwk.->Autdet->dtshdblockcountmax);
	r9 = DTSHDSTREAMLENGTH-4;

	comp(r11,r1);
	if ne jump MaybeWmapro;

	r2  = dm(i1,-2);
	r2  = dm(i1, 2);
	r11 = r2;
	r2  = lshift r2 by -8;
	r13 = 0x7;
	r2  = r2 and r13;       /* Burst Length */

	r4 = SYNCSIGDTSMA;
	r13 = dm(Frmwk.->autodetect_mode);
	r10 = 9;
	comp(r13,r10);
	r1 = 682;
	if ne jump MayBeLBRorHR;

	r10=4;
	comp(r2,r10);
	if eq jump readlen1Beg;
	jump Unknownstreamdetection;

MayBeLBRorHR:
	r10 = dm(Frmwk.->sampling_fs_micro);
	r13 = 1;
	comp(r10,r13);


	if eq jump MayBeDTSLBR;
	r13 = 2;
	comp(r10,r13);
	if ne jump MayBeDTSHD;
MayBeDTSLBR:
	r4 = SYNCSIGDTSLBR;
	r9 = DTSLBRSTREAMLENGTH-4;
	r0 = dm(Frmwk.->Autdet->dtslbrblockcountmax);
	r13=3;
	comp(r13,r2);
	if eq jump  readlen1Beg;
	jump Unknownstreamdetection;
MayBeDTSHD:
	r4 = SYNCSIGDTSHR;

	r9 = DTSHDHR2KFRAMELENGTH - 4; //16384
	r0 = dm(Frmwk.->Autdet->dtshdhr2kblockcountmax);
	r13=4;  //8192 repetition period
	comp(r2,r13);
	if eq jump readlen1Beg;

	r9 = DTSHDHR1KFRAMELENGTH - 4; //8192
	r0 = dm(Frmwk.->Autdet->dtshdhr1kblockcountmax);
	r13=3;
	comp(r2,r13);
	if eq jump readlen1Beg;

    r9 = DTSHDHR512KFRAMELENGTH - 4; //4096
	r0 = dm(Frmwk.->Autdet->dtshdhr512blockcountmax);
	r13= 2;
	comp(r2,r13);
	if eq jump readlen1Beg;
    jump Unknownstreamdetection;


MaybeWmapro:
	r1 = 18;
	r4 = SYNCSIGWMAPRO;
	r0 = dm(Frmwk.->Autdet->wmablockcountmax0);
	r9 = WMA0STREAMLENGTH-4;
	comp(r11,r1);
	r1 = 682;
	if ne jump Unknownstreamdetection;

	jump CheckWMAPro;

chkforPd.END:

CheckWMAPro:

	r2  = dm(i1,-2);
	r2  = dm(i1, 2);	              /* WMAPro Data subtype */
	r11 = r2;
	r2  = lshift r2 by -5;
	r13 = 0x3;
	r2  = r2 and r13;
	dm(Frmwk.->Autdet->FrameSizeWMAPRO)=r2;

	r2 = pass r2;                    // framesize 4k
	if eq jump readlen1Beg;

	r0 = dm(Frmwk.->Autdet->wmablockcountmax1);
	r9 = WMA1STREAMLENGTH-4;
	r2 = r2-1;                      // framesize 2k
	if eq jump readlen1Beg;

	r0 = dm(Frmwk.->Autdet->wmablockcountmax2);
	r9 = WMA2STREAMLENGTH-4;
	r2 = r2-1;                       // framesize 1k
	if eq jump readlen1Beg;

	r0 = dm(Frmwk.->Autdet->wmablockcountmax3);
	r9 = WMA3STREAMLENGTH-4;
	r2 = r2-1;                       // framesize 0.5k
	if eq jump readlen1Beg;


Unknownstreamdetection:

	dm(Frmwk.->Autdet->BreakCount) = r1;
	r0 = SYNCSIGUNKNOWN;
	dm(Frmwk.->Autdet->MSGR4)=r0;
	dm(Frmwk.->Autdet->PauseCount) = m5;
	dm(Frmwk.->Autdet->LongPause) = m5;
	dm(Frmwk.->Autdet->SmallPause) = m5;
	r0 = dm(Frmwk.->Autdet->blockcountmax);
	dm(Frmwk.->Autdet->StreamBlockCountMax) = r0;
	dm(Frmwk.->Autdet->StreamBlockCount) = r0;

    r11 = dm(Frmwk.->IOP->Pack->heap);
	dm(Frmwk.->Autdet->HeaderAddress) = r11;
    dm(Frmwk.->IOP->Pack->rd_ptr) = r11;
    dm(Frmwk.->IOP->Pack->wr_ptr) = r11;


	jump FormatStrBeg;

    readlen1Beg:
	jump readlen1;

CheckWMAPro.END:

readlen1:

    r2=dm(Frmwk.->mpeg2support);
    r2=pass r2;
    if ne jump supportmpegdecoding;

	r2 = dm(Frmwk.->Autdet->mpegstreamdetected) ;
	r2 = pass r2;
	if ne jump Unknownstreamdetection;

supportmpegdecoding:

	dm(Frmwk.->Autdet->BreakCount) = r1;
	//dm(Frmwk.->Autdet->MSGR4)=r4;
	dm(Frmwk.->Autdet->PauseCount) = m5;
	dm(Frmwk.->Autdet->LongPause) = m5;
	dm(Frmwk.->Autdet->SmallPause) = m5;
	dm(Frmwk.->Autdet->HIGHTOLOWBRDOLBY) = m5;
	dm(Frmwk.->Autdet->StreamBlockCountMax) = r0;
	dm(Frmwk.->Autdet->StreamBlockCount) = r0;
	dm(Frmwk.->Autdet->DTSDataLengthDouble) = r9;
	#ifdef AAC_DEC
	dm(AAC_DataLen.) = r9;
	#endif
	dm(Frmwk.->Autdet->No_Of_DWords_In_Present_Burst) = r9;
	dm(Frmwk.->Autdet->PdValue) = r10;
	//r11=dm(-2,i1);		
	modify(i1,-2)(nw);
	r11 = dm(i1,2);	
	dm(Frmwk.->Autdet->PcValue) = r11;
	dm(Frmwk.->Autdet->TransferNeeded) = m6;


	i4 = dm(Frmwk.->IOP->Pack->wr_ptr);
	dm(Frmwk.->Autdet->HeaderAddress) = i4;
	dm(Frmwk.->Autdet->HeaderPlaceWritten)= m6;
	dm(Frmwk.->Autdet->HeaderAddWritten)= m6;

	r9 = dm(Frmwk.->Autdet->DTSDataLengthDouble);
	r9 = lshift r9 by -1;
	dm(Frmwk.->Autdet->DTSDataLength) = r9;
	dm(Frmwk.->Autdet->empty) = m5;

	r0 = dm(Frmwk.->Autdet->MSGR4);
	comp(r0,r4);
	if eq jump skip_pack_init;

	r0 = dm(Frmwk.->IOP->Pack->heap);
	dm(Frmwk.->Autdet->HeaderAddress) = r0;
    dm(Frmwk.->IOP->Pack->rd_ptr) = r0;
    dm(Frmwk.->IOP->Pack->wr_ptr) = r0;

skip_pack_init:
	dm(Frmwk.->Autdet->MSGR4)=r4;



	r2 = dm(Frmwk.->Autdet->MSGR4);
	r0 = 2;
	comp(r0,r2);


	r0 = 1;
	comp(r0,r2);
	if eq jump skip_IEC_write;

//#ifndef __PCM__
//#ifndef __AC3__
	r13 = 0xf8724e1f;   // 0x4e1ff872;	    /* 0xf872 */
#ifdef DTSX_LATENCY_CALC	
	r10 = dm(DTSX_Latency_loop_cnt.);
	r10 = r10-1;
	dm(DTSX_Latency_loop_cnt.) = r10;
	r10 = pass r10;
	if ne jump Skip_Timer_flow;
	r13 = dm(Frmwk.->DTSX->dtsxframecount);
	dm(DTSX_latency_framecount.) = r13;
	r13 = 0xf8726053;
	TPERIOD = 0x7FFFFFFF;
	TCOUNT = TPERIOD;
	nop;nop;
	nop;nop;
	bit set MODE2 BITM_REGF_MODE2_TIMEN;
    nop;nop;	
Skip_Timer_flow:
#endif//DTSX_LATENCY_CALC	
	i4 = dm(Frmwk.->IOP->Pack->wr_ptr);
	dm(i4,1) = r13;
	r10 = dm(Frmwk.->Autdet->PdValue);

	r11 = dm(Frmwk.->Autdet->PcValue);
	r11 = lshift r11 by 16;
	r10 = r10 or r11;
	dm(i4,1) = r10;
    dm(Frmwk.->IOP->Pack->wr_ptr) = i4;
	dm(Frmwk.->Autdet->InitHeaderWritten) = m6;
//#endif
//#endif

skip_IEC_write:

	jump FormatStrBeg;

readlen1pause:

	r0 = dm(Frmwk.->Autdet->PauseCount);
	r0 = r0 + 1;
	dm(Frmwk.->Autdet->PauseCount) = r0;

	dm(Frmwk.->Autdet->SmallPause) = m6;

	r1 = dm(Frmwk.->Autdet->PcmDetected);
	r1 = pass r1;
	if ne jump declareUnKnown;

	r1 = dm(Frmwk.->Autdet->BreakCount);
	comp(r0,r1);
	if lt jump SmallPause;

declareUnKnown:

	dm(Frmwk.->Autdet->LongPause) = m6;		// Similar to Unknown Condition
	dm(Frmwk.->Autdet->SmallPause) = m5;

	r11 = dm(Frmwk.->IOP->Pack->heap);
	dm(Frmwk.->Autdet->HeaderAddress) = r11;
    dm(Frmwk.->IOP->Pack->rd_ptr) = r11;
    dm(Frmwk.->IOP->Pack->wr_ptr) = r11;
	r0 = SYNCSIGUNKNOWN;
	dm(Frmwk.->Autdet->MSGR4)=r0;
	dm(Frmwk.->Autdet->mpegstreamdetected)=m5;
	dm(Frmwk.->Autdet->DataCanBeCopied) = m5;
	dm(Frmwk.->IOP->datacanbeprocessednow) = m5;

SmallPause:

	r0 = dm(Frmwk.->Autdet->StreamBlockCountMax);
	dm(Frmwk.->Autdet->StreamBlockCount) = r0;
	dm(Frmwk.->Autdet->TransferNeeded) = m5;
	dm(Frmwk.->Autdet->HeaderPlaceWritten) = m5;
	r0  = dm(Frmwk.->SampleDropCount);

	dm(Frmwk.->Autdet->PcmCount) = r0;
	r0 = PREVPCCLEARCOUNTMAX;
	dm(Frmwk.->Autdet->PrevPcClearCount) = r0;
	r0  = dm(PcmZeroCountMax.);
	dm(Frmwk.->Autdet->PcmZeroCount) = r0;
	dm(Frmwk.->Autdet->PcmDetected) = m5;
    dm(Frmwk.->Autdet->MayBePcm) = m5;

	jump FormatStrBeg;

readlen1.END:
/*-------------------------------------------------------------------------
			IEC HEADER CHECKING	  (modified)
-------------------------------------------------------------------------*/

sync_not_found:
	jump sync_not_found1;

sync_not_found1:
	jump fresety;

sync_not_found1.END:

HuntHeaderAgain1:
	jump HuntHeaderAgain;

HuntHeaderAgain:

	r0  = dm(Frmwk.->Autdet->BurstSyncFoundHalf);
	r0  = pass r0;
	if ne jump HalfIECFound;

	r14 = r14 - 1,r10 = dm(i1,1);
	r13 = IEC958SHUFFLEDSIG;	    /* f872 */
	comp(r10,r13);
	if ne jump sync_not_found;

   HalfIECFound:

	dm(Frmwk.->Autdet->BurstSyncFoundHalf) = m5;


	r14 = pass r14;
	if eq jump ExitSPDIFint2;

	r13 = 0x4e1f;
	r14 = r14 - 1,r10 = dm(i1,1);
	comp(r10,r13);
	if ne jump sync_not_found;


	dm(Frmwk.->Autdet->InitHeaderWritten) = m5;
	r14 = pass r14;
	if eq jump nordSamp;
	jump rdSamp;

nordSamp:
	dm(Frmwk.->Autdet->BurstSyncFound) = m6;
	jump ExitSPDIFint;
HuntHeaderAgain.END:

ExitSPDIFint2:
	nop;
	dm(Frmwk.->Autdet->BurstSyncFoundHalf) = m6;
	jump ExitSPDIFint;

ExitSPDIFint3:
	nop;
	dm(Frmwk.->Autdet->BurstPcFound) = m6;
	jump ExitSPDIFint;
ExitSPDIFint4:
	dm(Frmwk.->Autdet->BurstSyncFoundHalf) = m6;
	dm(Frmwk.->Autdet->BurstSyncFoundHalfPCM) = m6;
	jump ExitSPDIFint;

/*-------------------------------------------------------------------------
			SAMPLES COPY ROUTINE	  (modified)
-------------------------------------------------------------------------*/

proc_for_cpy:

	r10 = dm(Frmwk.->Autdet->No_Of_DWords_In_Present_Burst);
	r10 = r10 - r14;
	r13 = r14;
	if gt jump SetIteration;
	r13 = dm(Frmwk.->Autdet->No_Of_DWords_In_Present_Burst);
	dm(Frmwk.->Autdet->TransferNeeded) = m5;
SetIteration:

	r1 = dm(Frmwk.->Autdet->MSGR4);
	r0 = 1;
	comp(r0,r1);
	if eq jump not_for_pcm;

//#ifndef __PCM__

    i4 = dm(Frmwk.->IOP->Pack->wr_ptr);
	r11 = pass r13;
	if eq jump ExitSPDIFint;
proc_for_cpy.END:

	/*----------- Optimisation ------------------------------*/

		r1 = 16;
		r0 = dm(Frmwk.->Autdet->empty);
		r0 = pass r0;
		if ne jump OddStart;
		r11 = lshift r11 by -1;
		if sz jump SingleEven;
		r10 = dm(i1,m6);
		r10 = lshift r10 by r1,r0=dm(i1,m6);

loopstart:
		    r0 = r0 or r10,r10 = dm(i1,m6);
			r11 = r11 - 1,dm(i4,m6) = r0;
			if ne jump loopstart(db);
			nop;
			r10 = lshift r10 by r1,r0=dm(i1,m6);
	modify(i1,-2)(nw);
		btst r13 by 0;
		if sz jump Rearr_Pack_Over;
		SingleEven:
			r10 = dm(i1,m6);
			r10 = lshift r10 by 16;
			dm(i4,m5) = r10;
			dm(Frmwk.->Autdet->empty) = m6;
			jump Rearr_Pack_Over;
	OddStart:

		dm(Frmwk.->Autdet->empty) = m5;
		r0 = dm(i4,m5);
		r10 = dm(i1,m6);
		r0 = r0 or r10;
		dm(i4,m6) = r0;
		r11 = r11-1;
		if le jump Rearr_Pack_Over;
		r11 = lshift r11 by -1;
		if sz jump SingleOdd;
		loopstart1:
		    r10 = dm(i1,m6);
			r10 = lshift r10 by 16;
			r0=dm(i1,m6);
			r0 = r0 or r10;
			dm(i4,m6) = r0;
			r11 = r11 - 1;
			if ne jump loopstart1;
		btst r13 by 0;
		if not sz jump Rearr_Pack_Over;
		SingleOdd:
			r10 = dm(i1,m6);
			r10 = lshift r10 by 16;
			dm(i4,m5) = r10;
			dm(Frmwk.->Autdet->empty) = m6;

		Rearr_Pack_Over:
		dm(Frmwk.->IOP->Pack->wr_ptr)= i4;

		/*------------------------------------------------------------------*/


	jump sigskipXpcm;

//#endif

not_for_pcm:

//#ifdef __PCM__
		m2 = r13;
	modify(i1,m2)(nw);
//#endif

sigskipXpcm:

	r10 = dm(Frmwk.->Autdet->No_Of_DWords_In_Present_Burst);
	r10 = r10 - r13;
	dm(Frmwk.->Autdet->No_Of_DWords_In_Present_Burst) = r10;

	r14 = r14 - r13;

	if le jump ExitSPDIFint;
	jump HuntHeaderAgain;

/*-------------------------------------------------------------------------
			EXIT INTERRUPT		  (modified)
-------------------------------------------------------------------------*/

    ExitSPDIFint:
	jump ExitSPDIFint1;

ExitSPDIFint1:
	r0 = dm(Frmwk.->Autdet->MSGR4);
	dm(Frmwk.->Autdet->MSGR_Save) = r0;

#ifdef CUSTOMIZATION
	r0 = dm(Frmwk.->Autdet->MayBePcm);
	dm(Frmwk.->Autdet->save_MAYBEPCM) = r0;

	r0 = dm(Frmwk.->autodetect_mode);
	r2 = 9;
	comp(r0,r2);
	if ne jump No_Autodetect3;

	r0 = dm(Frmwk.->Autdet->MSGR4);
	r2 = 1;
	comp(r0,r2);

	if ne jump No_Autodetect3;

	r0 = 0xF;
	dm(Frmwk.->Autdet->MSGR_Save) = r0;

No_Autodetect3:
#endif


	jump common_rtn_label;
ExitSPDIFint1.END:
/*-------------------------------------------------------------------------
			STREAM IDENTIFICATION BLOCK   (modified)
-------------------------------------------------------------------------*/

    StreamIdentify:
	jump StreamIdentify1;

StreamIdentify1:
	i1  = b1;
	r14 = dm(Frmwk.->Misc->Control->InAutobufsizeby2);

#ifdef CUSTOMIZATION
	jump StrIdenBeg;
#endif

StreamIdentify1.END:

StrIdenBeg:
	r14 = pass r14;
	if eq jump ExitSPDIFint;

	r0  = dm(Frmwk.->Autdet->BurstSyncFound);
	r0  = pass r0;
	if ne jump chk_ID_fur;

#ifdef CUSTOMIZATION
	r0 = dm(Frmwk.->Autdet->BurstSyncFoundHalfPCM);
	r0 = pass r0;
	if eq jump check_for_fur_Half;

	dm(Frmwk.->Autdet->BurstSyncFoundHalf) = m5;
	dm(Frmwk.->Autdet->BurstSyncFoundHalfPCM) = m5;
	r10 = r15;
	jump No_inc_DTS_Sig1;
	check_for_fur_Half:
#endif

	r0  = dm(Frmwk.->Autdet->BurstSyncFoundHalf);
	r0  = pass r0;
	if ne jump chk_ID_furHalf;

    xchk:
	r14 = r14 - 1,r10 = dm(i1,m6);

	r0  = dm(Frmwk.->Autdet->MayBeDTS);
	r0  = pass r0;
	if eq jump No_inc_DTS_Sig1;
	r0  = dm(Frmwk.->Autdet->DTSSampleCount);
	r0  = r0 + 1;
	dm(Frmwk.->Autdet->DTSSampleCount) = r0;
    No_inc_DTS_Sig1:

	r13 = IEC958SHUFFLEDSIG;	    /* f872 */
	comp(r10,r13);
	r15 = r10;

	if eq jump chk_ID_furHalf;
	jump chkdtspcm;


chk_ID_furHalf:
	dm(Frmwk.->Autdet->BurstSyncFoundHalf) = m5;
	nop;nop;
	r14 = pass r14;
	if eq jump ExitSPDIFint2;


	r13 = 0x4e1f;
	r10 = dm(i1,m5);
	comp(r10,r13);
	if eq jump IEC_sig_foundBeg;
    jump chkdtspcm2;

    IEC_sig_foundBeg:
	jump IEC_Sig_found;

IEC_Sig_found:



	r14 = r14 - 1,r10 = dm(i1,m6);		    // PB


	r0  = dm(Frmwk.->Autdet->CompareWord);
	r0  = pass r0;
	if eq jump IEX_Sig;
	dm(Frmwk.->Autdet->CompareWord) = r10;
	//jump StrIdenBeg;
	jump StrIdenBeg;

    IEX_Sig:

	r0  = dm(Frmwk.->SampleDropCount);//PCMCOUNTMAX;

	dm(Frmwk.->Autdet->PcmCount) = r0;
        dm(Frmwk.->Autdet->MayBePcm) = m5;
	r0 = PREVPCCLEARCOUNTMAX;
	dm(Frmwk.->Autdet->PrevPcClearCount) = r0;

	r14 = pass r14;
	if gt jump chk_ID_fur;
	dm(Frmwk.->Autdet->BurstSyncFound) = m6;
	jump ExitSPDIFint;

    chk_ID_fur:
	dm(Frmwk.->Autdet->BurstSyncFound) = m5;
	r14 = r14 - 1,r10 = dm(i1,m6);		// PC

	r0 = dm(Frmwk.->Autdet->MayBeDTS);
	r0 = pass r0;
	if eq jump No_inc_DTS_Sig2;
	r0 = dm(Frmwk.->Autdet->DTSSampleCount);
	r0 = r0 + 1;
	r0 = r0 + 1;
	dm(Frmwk.->Autdet->DTSSampleCount) = r0;
No_inc_DTS_Sig2:
#ifdef subdatatype_handling
	dm(Frmwk.->Autdet->pc_value) = r10;
#endif
	r1  = 0x001f;	     // last 5 bits indicate Data type
	r11 = r10 and r1;
	r0  = dm(Frmwk.->Autdet->PrevPc);


 	comp(r0,r11);

	if ne jump iex1;



	dm(Frmwk.->Autdet->FormatStream) = m6;

	jump chkforPd;

    iex1:dm(Frmwk.->Autdet->PrevPc) = r11;
	jump StrIdenBeg;
StrIdenBeg.END:

IEC_Sig_found.END:

/*-------------------------------------------------------------------------
			UNFORMATTED DTS CHECKING     (modified)
-------------------------------------------------------------------------*/
chkdtspcm:

	r14 = pass r14;

#ifdef CUSTOMIZATION
	if eq jump ExitSPDIFint4;
#else
	if eq jump ExitSPDIFint;
#endif
	jump chkdtspcm2;

chkdtspcm.END:

chkdtspcm2:
	r10 = dm(i1,m5);		    //PB
	dm(Frmwk.->Autdet->dtssynclsb) = r10;
	dm(Frmwk.->Autdet->dtssyncmsb) = r15;

	r11 = DTSSYNCSIG1SHUFFLED;	    /* 7ffe */
	comp(r11,r15);
	if ne jump chksig21;
	r11 = 0x8001;
	comp(r11,r10);
	if eq jump DTS_Sig_f;

chksig21:
	r11 = DTSSYNCSIG2SHUFFLED;	    /* 1fff */
	comp(r11,r15);
	if ne jump pcmchk;
	r11 = 0xe800;
	comp(r11,r10);
	if ne jump pcmchk;

DTS_Sig_f:


	r14 = r14 - 1,r10 = dm(i1,m6);		    // PB

	r0  = dm(Frmwk.->Autdet->MayBeDTS);
	r0  = pass r0;
	if eq jump No_inc_DTS_Sig11;
	r0  = dm(Frmwk.->Autdet->DTSSampleCount);
	r0  = r0 + 1;
	dm(Frmwk.->Autdet->DTSSampleCount) = r0;
No_inc_DTS_Sig11:

	dm(Frmwk.->Autdet->dtssyncmsb) = r15;
	dm(Frmwk.->Autdet->dtssynclsb) = r10;


	r0  = dm(Frmwk.->SampleDropCount);//PCMCOUNTMAX;

	dm(Frmwk.->Autdet->PcmCount) = r0;
	r0 = PREVPCCLEARCOUNTMAX;
	dm(Frmwk.->Autdet->PrevPcClearCount) = r0;
        dm(Frmwk.->Autdet->MayBePcm) = m5;

	r0  = dm(Frmwk.->Autdet->MayBeDTS);
	r0  = pass r0;
	if eq jump no_DTS_Sig_f1;
	jump DTS_Sig_f1;

no_DTS_Sig_f1:
	dm(Frmwk.->Autdet->MayBeDTS) = m6;
	dm(Frmwk.->Autdet->DTSSampleCount) = m5;
//	jump StrIdenBeg;
	jump StrIdenBeg;

chkdtspcm2.END:

DTS_Sig_f1:
	r0  = dm(Frmwk.->Autdet->DTSSampleCount);
	r1  = 512;
	r2  =  dm(Frmwk.->Autdet->unformatdtsblockcountmax0);
	comp(r0,r1);
	if eq jump DeclareDTSBeg;
	r1  = 1024;
	r2  = dm(Frmwk.->Autdet->unformatdtsblockcountmax1);
	comp(r0,r1);
	if eq jump DeclareDTSBeg;
	r1  = 2048;
	r2  = dm(Frmwk.->Autdet->unformatdtsblockcountmax2);
	comp(r0,r1);
	if eq jump DeclareDTSBeg;
	r1  = 4096;
	r2  = dm(Frmwk.->Autdet->unformatdtsblockcountmax3);
	comp(r0,r1);
	if eq jump DeclareDTSBeg;
	r1  = 8192;
	r2  = dm(Frmwk.->Autdet->unformatdtsblockcountmax4);
	comp(r0,r1);
	if eq jump DeclareDTSBeg;

	dm(Frmwk.->Autdet->DTSSampleCount) = m5;
	jump pcmchk;

    DeclareDTSBeg:
	jump DeclareDTS;
DTS_Sig_f1.END:

DeclareDTS:
	dm(Frmwk.->Autdet->PrevFrameDTS) = m6;
	r0 = dm(Frmwk.->Autdet->DTSSampleCount);
	r0 = lshift r0 by -1;
	dm(Frmwk.->Autdet->DTSSampleCount) = r0;

#ifdef PREVPC_COMMENTED
	r0  = -1;
   	dm(Frmwk.->Autdet->PrevPc) = r0;
#endif

	dm(Frmwk.->Autdet->StreamBlockCountMax) = r2;
	dm(Frmwk.->Autdet->StreamBlockCount) = r2;
	r2  = dm(Frmwk.->Misc->Control->InAutobufsizeby2);
	r2  = r2 - r14;
	r2  = r2 - 1;
	r2 	= r2 - 1;
	dm(Frmwk.->Autdet->StreamBlockOffset) = r2;

	r4  = SYNCSIGDTSLDCD;
	dm(Frmwk.->Autdet->MSGR4)=r4;
	dm(Frmwk.->Autdet->mpegstreamdetected)=m5;
	dm(Frmwk.->Autdet->PauseCount) = m5;
	dm(Frmwk.->Autdet->LongPause) = m5;
	dm(Frmwk.->Autdet->SmallPause) = m5;
	dm(Frmwk.->Autdet->HIGHTOLOWBRDOLBY) = m5;
	dm(Frmwk.->Autdet->FormatStream) = m5;
	dm(Frmwk.->Autdet->streamdetected) = m6;
	dm(Frmwk.->Autdet->PcmDetected) = m5;
    dm(Frmwk.->Autdet->MayBePcm) = m5;


	r4 = dm(Frmwk.->IOP->Pack->wr_ptr);
	dm(Frmwk.->Autdet->HeaderAddress) = r4;
	dm(Frmwk.->Autdet->HeaderPlaceWritten) = m6;

	jump format0pro3;

/*-------------------------------------------------------------------------
			PCM/PCM ZERO CHECKING	     (modified)
-------------------------------------------------------------------------*/
    pcmchk:
	jump pcmchkBeg;
DeclareDTS.END:

pcmchkBeg:
	r10 = dm(Frmwk.->Autdet->dtssynclsb);
	r10 = pass r10;
	if ne jump pcmchkcont;
	r10 = dm(Frmwk.->Autdet->dtssyncmsb);
	r10 = pass r10;

	if eq jump pcmchk1;
pcmchkcont:

	r0 = dm(Frmwk.->Autdet->PrevPcClearCount);
	r0 = r0-1;
	dm(Frmwk.->Autdet->PrevPcClearCount) = r0;
	if ne jump CheckPcmCount;

#ifdef PREVPC_COMMENTED
	r0  = -1;
	dm(Frmwk.->Autdet->PrevPc) = r0;
#endif

	r0 = PREVPCCLEARCOUNTMAX;
	dm(Frmwk.->Autdet->PrevPcClearCount) = r0;

	CheckPcmCount:
	r0  = dm(Frmwk.->Autdet->PcmCount);
	r0  = r0 - 1;
	dm(Frmwk.->Autdet->PcmCount) = r0;
	r0  = dm(PcmZeroCountMax.);
	dm(Frmwk.->Autdet->PcmZeroCount) = r0;
	if ne jump noDeclarePCM;
	jump DeclarePCM;

noDeclarePCM:
	r0  = dm(Frmwk.->Autdet->PcmDetected);
	r0  = pass r0;
#ifdef CUSTOMIZATION
	if ne jump exit_to_StrIden;

	MaybePCMCOUNT_change:
	r0 = dm(Frmwk.->SampleDropCount);
	r2 = dm(Frmwk.->Autdet->MaybePcm_count);                     //For customAutodetect1 spec
	r2 = r0 - r2;
	dm(Frmwk.->Autdet->MAYBEPCMCOUNT_var) = r2;
	r0  = dm(Frmwk.->Autdet->PcmCount);
	r2 = dm(Frmwk.->Autdet->MAYBEPCMCOUNT_var);
        comp(r0,r2);
        if gt jump pcmchkx;
        dm(Frmwk.->Autdet->MayBePcm) = m6;
    jump pcmchkx;

	pcmchk1_mod:
	r0 = dm(Frmwk.->Autdet->PcmZeroCount); // PcmZeroCount
	r0 = r0 - 1;
	dm(Frmwk.->Autdet->PcmZeroCount) = r0; // PcmZeroCount

	jump pcmchk2;
#else
	if eq jump nooStrIdenBeg;
#endif
	jump StrIdenBeg;

nooStrIdenBeg:
	r0  = dm(Frmwk.->Autdet->PcmCount);
	r2  = MAYBEPCMCOUNT;
        comp(r0,r2);
        if gt jump pcmchkx;
        dm(Frmwk.->Autdet->MayBePcm) = m6;
    pcmchkx:


	r0  = SYNCSIGUNKNOWN;
	dm(Frmwk.->Autdet->MSGR4)=r0;
	dm(Frmwk.->Autdet->PauseCount) = m5;
	dm(Frmwk.->Autdet->LongPause) = m5;
	dm(Frmwk.->Autdet->SmallPause) = m5;
	dm(Frmwk.->Autdet->mpegstreamdetected)=m5;
//	jump StrIdenBeg;
	jump StrIdenBeg;

    pcmchk1:
	r0  = dm(Frmwk.->Autdet->PcmZeroCount);
	r0  = r0 - 1;
	dm(Frmwk.->Autdet->PcmZeroCount) = r0;

/*	Added to handle DTS CD FFWD/RWD Noise */

        r2=dm(PcmZeroCountMax.);
        r4 = 3;
	r2 =r2-r4;
	comp(r2,r0);

	if lt jump pcmchk2;


	r0 = dm(Frmwk.->Autdet->PrevFrameDTS);
	r0 = pass r0;
	if eq jump pcmchk2;


		r0 = dm(Frmwk.->SampleDropCount);//PCMCOUNTMAX;

	dm(Frmwk.->Autdet->PcmCount)=r0;
	r0 = PREVPCCLEARCOUNTMAX;
	dm(Frmwk.->Autdet->PrevPcClearCount) = r0;
	dm(Frmwk.->Autdet->MayBePcm)=m5;

pcmchk2:


	r0 = dm(Frmwk.->Autdet->PcmZeroCount);
	r0 = pass r0;
	if eq jump DeclarePCMZeroBeg;

	jump StrIdenBeg;
pcmchkBeg.END :



DeclarePCM:		// No IEC sig found for 0.5 sec
	dm(Frmwk.->Autdet->BurstSyncFoundHalfPCM) = m5;
	dm(Frmwk.->Autdet->PrevFrameDTS)=m5;

	dm(Frmwk.->Autdet->PauseCount) = m5;
	dm(Frmwk.->Autdet->LongPause) = m5;
	dm(Frmwk.->Autdet->SmallPause) = m5;
	dm(Frmwk.->Autdet->HIGHTOLOWBRDOLBY) = m5;
	dm(Frmwk.->Autdet->mpegstreamdetected)=m5;

    decpcmpro1:

	r0 = dm(Frmwk.->SampleDropCount);

	dm(Frmwk.->Autdet->PcmCount) = r0;
	dm(Frmwk.->Autdet->MayBePcm) = m5;

	dm(Frmwk.->Autdet->BurstSyncFound) = m5;
	dm(Frmwk.->Autdet->BurstSyncFoundHalf) = m5;
	dm(Frmwk.->Autdet->BurstPcFound) = m5;
	dm(Frmwk.->Autdet->CompareWord) = m5;

	r0 = dm(Frmwk.->Autdet->PcmDetected);
	r0 = pass r0;
	if eq jump PcmProcess1;

exit_to_StrIden:

//	jump StrIdenBeg;
	jump StrIdenBeg;

PcmProcess1:

	r4 = SYNCSIGPCM;
	dm(Frmwk.->Autdet->MSGR4)=r4;
	dm(Frmwk.->Autdet->PcmDetected) = m6;

	dm(Frmwk.->Autdet->MayBeDTS) = m5;			//Added to take care of 4K Frsize noise
	dm(Frmwk.->Autdet->DTSSampleCount) = m5;	//Added to take care of 4K Frsize noise

	r0 = dm(Frmwk.->Misc->Control->ForcePcm);
	r0 = pass r0;
	if ne jump exit_to_StrIden;
#ifdef CUSTOMIZATION
	r0 = dm(Frmwk.->autodetect_mode); // _autodetect_mode    //For CustomAutodetect1
	r4 = CUSTOMAUTODETECT1;
	comp(r0,r4);
	if eq jump exit_to_StrIden;
#endif
	i4 = dm(Frmwk.->IOP->Pack->wr_ptr);
	dm(Frmwk.->Autdet->HeaderAddress) = i4;
	dm(Frmwk.->Autdet->HeaderPlaceWritten) = m6;
	dm(Frmwk.->Autdet->PcmHeaderWritten) = m6;
	r14 = pass r14;
	if eq jump ExitSPDIFint;

	i2 = b2;

	r10 = dm(Frmwk.->Misc->Control->InAutobufsizeby2);
	r10 = r10 - r14;
	if eq jump skip_zeroing;

	r0 = 0;
	lcntr = r10,do pcmcpy_lop2 until lce;
	modify(i2,1)(nw);
	pcmcpy_lop2: dm(i4,1) = r0;

skip_zeroing:

	r0 = i1;

	btst r14 by 0;
	if sz jump proceedtocopy;
	r14 = r14 - 1;
	r10 = dm(i1,1); //dummy
	modify(i2,1)(nw);
	r10 = 0;
	dm(i4,1) = r10;
	if eq jump ExitSPDIFint;

proceedtocopy:

	lcntr = r14,do pcmcpy_lop1 until lce;
		   r10 = dm(i2,1);
	pcmcpy_lop1: dm(i4,1) = r10;
	dm(Frmwk.->IOP->Pack->wr_ptr) = i4;

	i1 = r0;

	jump StrIdenBeg;

    DeclarePCMZeroBeg:
	jump DeclarePCMZero;
DeclarePCM.END:

DeclarePCMZero:
	r4 = SYNCSIGPCMZERO;
	dm(Frmwk.->Autdet->MSGR4) = r4;
	dm(Frmwk.->Autdet->mpegstreamdetected)=m5;
	dm(Frmwk.->Autdet->PauseCount) = m5;
	dm(Frmwk.->Autdet->LongPause) = m5;
	dm(Frmwk.->Autdet->SmallPause) = m5;
	dm(Frmwk.->Autdet->HIGHTOLOWBRDOLBY) = m5;
	dm(Frmwk.->Autdet->PcmDetected) = m5;

	r0 = dm(Frmwk.->SampleDropCount);//PCMCOUNTMAX;

	dm(Frmwk.->Autdet->PcmCount) = r0;
    dm(Frmwk.->Autdet->MayBePcm) = m5;
	r0 = PREVPCCLEARCOUNTMAX;
	dm(Frmwk.->Autdet->PrevPcClearCount) = r0;
    r0 = dm(PcmZeroCountMax.);
	dm(Frmwk.->Autdet->PcmZeroCount) = r0;

	jump StrIdenBeg;
DeclarePCMZero.END:

/**************************************************************************/

freset1Beg.END:

fresetyBeg.END:

fresetxBeg.END:

FormatStr.END:

_streamdetect.END:
.endseg;

