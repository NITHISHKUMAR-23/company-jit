/***************************************************************************
*
*  (C)Copyright Analog Devices Inc., India.
*  All rights reserved. Reproduction in whole or part is prohibited without 
*  the written permission of the copyright owner.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Txmitter.asm
*  Description      : 

******************************************************************************/


#include "def21569.h"
#include "..\src\system\Include\Adr_Lkup_Tab_Macros.h"
#include "..\src\system\Include\HostDefines.h"
#include "..\src\system\Include\Commn.h"

.IMPORT "..\src\system\Include\Def_Struct.h";
.extern struct kernel Frmwk.;
.extern buff_cnt.;
.extern framre_cnt.;

.segment/dm mem_block0_Kernal_data_Txm;
.var save_r0_tx;
.var save_mode2_tx;

.extern rdma_rd_ptr.;

.endseg;
.extern unsave_lbrm_reg_tx;
.extern save_lbrm_reg_tx;
.extern PP_flag.;
.extern stop_timer.;
.extern restart_timer.;

/******************************************************************************
 *  Module Name        : transmitter
 *  Functionality      : transmitter Processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.section/sw  Seg_Txmitter_Code;   

.global transmitter.;
.type transmitter., STT_FUNC;
transmitter.:  
    call stop_timer.;
    
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(26*4))=MODE1;

	bit clr mode1 (  BITM_REGF_MODE1_BR0
                     | BITM_REGF_MODE1_BR8
                     | BITM_REGF_MODE1_PEYEN
                     | BITM_REGF_MODE1_BDCST1
                     | BITM_REGF_MODE1_BDCST9);
    
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
	bit set MODE1 BITM_REGF_MODE1_CBUFEN;
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
	
	I_ACALL (save_lbrm_reg_tx);

	l0 = 0;l1 = 0; l2 = 0; l3 = 0; l4 = 0; l5 = 0; l9 = 0; l8=0; l11 = 0;
	
 	r0 = m5;
    r11 = dm(PP_flag.);
	comp(r0,r11);
	
	i1 = dm(Frmwk.->Tx->dac_buf_LCRSw0_ptr);
	i2 = dm(Frmwk.->Tx->dac_buf_LsLsrRsRsr0_ptr);
	i3 = dm(Frmwk.->Tx->dac_buf_addch1ch3addch2ch4_set0_ptr);	
 
	i4 = dm(Frmwk.->Tx->dac_buf_addch5ch7addch6ch8_set0_ptr);



	i5 = dm(Frmwk.->Tx->dac_buf_addch9ch11addch10ch12_set0_ptr);



	i11 = dm(Frmwk.->Tx->dac_buf_addch13ch15addch14ch16_set0_ptr);

	if eq jump Bufupdate; 
	
	i1 = dm(Frmwk.->Tx->dac_buf_LCRSw1_ptr);
	i2 = dm(Frmwk.->Tx->dac_buf_LsLsrRsRsr1_ptr);
	i3 = dm(Frmwk.->Tx->dac_buf_addch1ch3addch2ch4_set1_ptr);

	i4 = dm(Frmwk.->Tx->dac_buf_addch5ch7addch6ch8_set1_ptr);


	i5 = dm(Frmwk.->Tx->dac_buf_addch9ch11addch10ch12_set1_ptr);


	i11 = dm(Frmwk.->Tx->dac_buf_addch13ch15addch14ch16_set1_ptr);


Bufupdate:	
	r9 = 32;
	dm(Frmwk.->IOP->CopyToDacCounter) = r9;	//Don't change r9 - Reserved
	

    r3 = dm(Frmwk.->IOP->Predac->wr_ptr); 
    r4 = dm(Frmwk.->IOP->Predac->rd_ptr);
    r0 = r3-r4;
    r3 = 0;
    comp(r0,r3);
    if lt jump modifier;
    
    r3 = 1024;
	r3 = lshift r3 by 2;
	r2 = r0-r3;
	//r2 = pass r2;
	comp(r2,r3);
	if lt jump Bufzero;
	
	if ge jump Tx_continue ;
	
modifier:	
	r4 = dm(Frmwk.->IOP->Predac->length);
	r4 = lshift r4 by 2;
	r2 = r0+r4;
	
	r3 = 1024;
	r3 = lshift r3 by 2;
	
	r0 = r2-r3;
	//r0=pass r0;
	comp(r0,r3);
	if lt jump Bufzero;
	
Tx_continue:
	r4 = dm(Frmwk.->Mute_flag_from_HOST);
	dm(Frmwk.->mute_flag) = r4;
	
	dm(Frmwk.->IOP->DataValid) = m6;
	dm(Frmwk.->Misc->Control->OutBufferEmptyFlag) = m6;
	
	l0 = dm(Frmwk.->IOP->Predac->length);
	b0 = dm(Frmwk.->IOP->Predac->heap);
	i0 = dm(Frmwk.->IOP->Predac->rd_ptr);
	
	l13 = 0;
	b13 = dm(Frmwk.->internal_Tx_buff);
	i13 = dm(Frmwk.->internal_Tx_buff);

    r0 = dm(TX_DAC_Output_Ch_Cnt.);
	r1 = 1;
	r2=16;
	comp(r0,r1);
	if eq jump Skip_Channel_modifier_TX_16;
	
	r1 = 2;
	r2=12;
	comp(r0,r1);
	if eq jump Skip_Channel_modifier_TX_18;
	

	r2=8;      //24 ch 

	
Skip_Channel_modifier_TX_24:
	
	m2 = r2;
	m11 = r2;
			 
CopyToDacOut_24: 

	r3  = pm(i13,1);  //L
	r4  = pm(i13,1);  //R
	
 	r5  = pm(i13,1);  //C
	r11 = pm(i13,1);  //SW
	
	r6  = pm(i13,1);  //Ls
	r10 = pm(i13,1);  //Rs
	
	r14 = pm(i13,1);  //SBL 
	r15 = pm(i13,1);  //SBR
	 
	r7  = pm(i13,1);
	r8  = pm(i13,1);
	
	r12 = pm(i13,1);
	r13 = pm(i13,1);
	
    modify(i0,12)(nw);
	
Check_mute_24:
      
	r0 = dm(Frmwk.->mute_flag);
	r0 = pass r0;
	if eq jump skipmute_24;

	r3  = 0;
	r4  = 0;
	r5  = 0;
	r6  = 0;
	r11 = 0;
	r15 = 0;
	r14 = 0;
	r10 = 0;

	r7  = 0;
	r8  = 0;    
	r12 = 0;
	r13 = 0;
/*	r2 = 0;
	r1 = 0;
	mrf = 0; */
	
skipmute_24:
	dm(i1,m6) = r3;  //L
    dm(i1,m6) = r5;  //R

	dm(i1,m6) = r4;  //C
	dm(i1,m6) = r11; //SW
	
	dm(i2,m6) = r6;  //LS
	dm(i2,m6) = r14; //SBL

	dm(i2,m6) = r10; //RS
	dm(i2,m6) = r15; //SBR

	dm(i3,m6) = r7;  //ADDCH1
	dm(i3,m6) = r12; //ADDCH3

	dm(i3,m6) = r8;  //ADDCH2
	dm(i3,m6) = r13; //ADDCH4

	r3  = pm(i13,1);  
	r4  = pm(i13,1);  	
 	r5  = pm(i13,1);  
	r11 = pm(i13,1);  	
	r6  = pm(i13,1);  
	r10 = pm(i13,1); 
	r14 = pm(i13,1);  
	r15 = pm(i13,1);  	 
	r7  = pm(i13,1);
	r8  = pm(i13,1);
	r12 = pm(i13,1);
	r13 = pm(i13,1);

   modify(i0,12)(nw);
   
   	r0 = dm(Frmwk.->mute_flag);
	r0 = pass r0;
	if eq jump skipmute_24_1;

	r3  = 0;
	r4  = 0;
	r5  = 0;
	r6  = 0;
	r10 = 0;
	r15 = 0;
	r14 = 0;
	r11 = 0;
	r7  = 0;
	r8  = 0;    
	r12 = 0;
	r13 = 0;

skipmute_24_1:

	dm(i4,m6) = r3;  //ADDCH5
	dm(i4,m6) = r5; //ADDCH7	
	dm(i4,m6) = r4;  //ADDCH6
	dm(i4,m6) = r11; //ADDCH8
	
	dm(i5,m6) = r6;  //ADDCH9
	dm(i5,m6) = r14; //ADDCH11
	dm(i5,m6) = r10;  //ADDCH10
	dm(i5,m6) = r15; //ADDCH12
	
	pm(i11,m14) = r7;  //ADDCH13
	pm(i11,m14) = r12; //ADDCH15	
	pm(i11,m14) = r8;  //ADDCH14
	pm(i11,m14) = r13; //ADDCH16	
	
    modify(i0,m2)(nw);
    modify(i13,m11)(nw);

	r3 = dm(Frmwk.->IOP->CopyToDacCounter);
	r3 = r3 - 1;
	dm(Frmwk.->IOP->CopyToDacCounter) = r3;
	if gt jump CopyToDacOut_24;
	
	jump copy_tx_over;
	
Skip_Channel_modifier_TX_18:
	
	m2 = r2;
	m11 = r2;
			 
CopyToDacOut_18: 

	r3  = pm(i13,1);  //L
	r4  = pm(i13,1);  //R
	
 	r5  = pm(i13,1);  //C
	r11 = pm(i13,1);  //SW
	
	r6  = pm(i13,1);  //Ls
	r10 = pm(i13,1);  //Rs
	
	r14 = pm(i13,1);  //SBL 
	r15 = pm(i13,1);  //SBR
	 
	r7  = pm(i13,1);
	r8  = pm(i13,1);
	
	r12 = pm(i13,1);
	r13 = pm(i13,1);
	
    modify(i0,12)(nw);
	
Check_mute_18:
      
	r0 = dm(Frmwk.->mute_flag);
	r0 = pass r0;
	if eq jump skipmute_18;

	r3  = 0;
	r4  = 0;
	r5  = 0;
	r6  = 0;
	r11 = 0;
	r15 = 0;
	r14 = 0;
	r10 = 0;

	r7  = 0;
	r8  = 0;    
	r12 = 0;
	r13 = 0;
/*	r2 = 0;
	r1 = 0;
	mrf = 0; */
	
skipmute_18:
	dm(i1,m6) = r3;  //L
    dm(i1,m6) = r5;  //R

	dm(i1,m6) = r4;  //C
	dm(i1,m6) = r11; //SW
	
	dm(i2,m6) = r6;  //LS
	dm(i2,m6) = r14; //SBL

	dm(i2,m6) = r10; //RS
	dm(i2,m6) = r15; //SBR

	dm(i3,m6) = r7;  //ADDCH1
	dm(i3,m6) = r12; //ADDCH3

	dm(i3,m6) = r8;  //ADDCH2
	dm(i3,m6) = r13; //ADDCH4
	
	r3  = pm(i13,1);  
	r4  = pm(i13,1);  	
 	r5  = pm(i13,1);  
	r11 = pm(i13,1);  	
	r6  = pm(i13,1);  
	r10 = pm(i13,1); 
	r14 = pm(i13,1);  
	r15 = pm(i13,1);  	 

   modify(i0,8)(nw);
   
   	r0 = dm(Frmwk.->mute_flag);
	r0 = pass r0;
	if eq jump skipmute_18_1;

	r3  = 0;
	r4  = 0;
	r5  = 0;
	r6  = 0;
	r10 = 0;
	r15 = 0;
	r14 = 0;
	r11 = 0;
	
skipmute_18_1:

	dm(i4,m6) = r3;  //ADDCH5
	dm(i4,m6) = r5; //ADDCH7	
	dm(i4,m6) = r4;  //ADDCH6
	dm(i4,m6) = r11; //ADDCH8
	
	dm(i5,m6) = r6;  //ADDCH9
	dm(i5,m6) = 0; //ADDCH11
	dm(i5,m6) = r10;  //ADDCH10
	dm(i5,m6) = 0; //ADDCH12	
	
    modify(i0,m2)(nw);
    modify(i13,m11)(nw);

	r3 = dm(Frmwk.->IOP->CopyToDacCounter);
	r3 = r3 - 1;
	dm(Frmwk.->IOP->CopyToDacCounter) = r3;
	if gt jump CopyToDacOut_18;
	
	jump copy_tx_over;
	
Skip_Channel_modifier_TX_16:
	
	m2 = r2;
	m11 = r2;
			 
CopyToDacOut_16: 

	r3  = pm(i13,1);  //L
	r4  = pm(i13,1);  //R
	
 	r5  = pm(i13,1);  //C
	r11 = pm(i13,1);  //SW
	
	r6  = pm(i13,1);  //Ls
	r10 = pm(i13,1);  //Rs
	
	r14 = pm(i13,1);  //SBL 
	r15 = pm(i13,1);  //SBR
	 
	r7  = pm(i13,1);
	r8  = pm(i13,1);
	
	r12 = pm(i13,1);
	r13 = pm(i13,1);
	
    modify(i0,12)(nw);
	
Check_mute_16:
      
	r0 = dm(Frmwk.->mute_flag);
	r0 = pass r0;
	if eq jump skipmute_16;

	r3  = 0;
	r4  = 0;
	r5  = 0;
	r6  = 0;
	r11 = 0;
	r15 = 0;
	r14 = 0;
	r10 = 0;

	r7  = 0;
	r8  = 0;    
	r12 = 0;
	r13 = 0;
/*	r2 = 0;
	r1 = 0;
	mrf = 0; */
	
skipmute_16:
	dm(i1,m6) = r3;  //L
    dm(i1,m6) = r5;  //R

	dm(i1,m6) = r4;  //C
	dm(i1,m6) = r11; //SW
	
	dm(i2,m6) = r6;  //LS
	dm(i2,m6) = r14; //SBL

	dm(i2,m6) = r10; //RS
	dm(i2,m6) = r15; //SBR

	dm(i3,m6) = r7;  //ADDCH1
	dm(i3,m6) = r12; //ADDCH3

	dm(i3,m6) = r8;  //ADDCH2
	dm(i3,m6) = r13; //ADDCH4
	
	r3  = pm(i13,1);  
	r4  = pm(i13,1);  	
 	r5  = pm(i13,1);  
	r11 = pm(i13,1);  	
	
   modify(i0,4)(nw);
   
   	r0 = dm(Frmwk.->mute_flag);
	r0 = pass r0;
	if eq jump skipmute_16_1;

	r3  = 0;
	r4  = 0;
	r5  = 0;
	r6  = 0;
skipmute_16_1:

	dm(i4,m6) = r3;  //ADDCH5
	dm(i4,m6) = r5; //ADDCH7	
	dm(i4,m6) = r4;  //ADDCH6
	dm(i4,m6) = r11; //ADDCH8	
	
    modify(i0,m2)(nw);
    modify(i13,m11)(nw);

	r3 = dm(Frmwk.->IOP->CopyToDacCounter);
	r3 = r3 - 1;
	dm(Frmwk.->IOP->CopyToDacCounter) = r3;
	if gt jump CopyToDacOut_16;
	 
copy_tx_over:  
	dm(Frmwk.->IOP->Predac->rd_ptr) = i0;
	
Transmitover:
	r3 = dm(Frmwk.->IOP->DacCount);
	r3 = r3 - r9; 
	dm(Frmwk.->IOP->DacCount) = r3;
	if gt jump after_update;

after_update1:
   
	r3 = dm(Frmwk.->IOP->NextDacCount);
	dm(Frmwk.->IOP->DacCount) = r3;

after_update:
	I_ACALL (unsave_lbrm_reg_tx);
	call restart_timer.;	
	i12 = dm(Frmwk.->Misc->Protect->saveint+(34*4));
	MODE1=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(26*4));	
	nop;nop;
	
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;	
	
Bufzero:
	r3 = dm(Frmwk.->Misc->Control->OutBufferEmptyFlag);		
    r3 = pass r3;
    if eq jump startbufzeroperation;
    
    dm(Frmwk.->IOP->DataValid) = m5;
    
    dm(Frmwk.->Autdet->HeaderPlaceWritten) = m5;
    dm(Frmwk.->IOP->datacanbeprocessednow) = m5; 
    r0 = dm(buff_cnt.);
    r0 = r0+1;
    dm(buff_cnt.) = r0;
    dm(Frmwk.->Misc->Control->OutBufferEmptyFlag) = m5;
    r0 = 5;
    r1 = dm(framre_cnt.);
    comp(r1,r0);
    if lt jump endahd;
    nop;
    nop;
    endahd:nop;

startbufzeroperation:    
	r0 = dm(Frmwk.->Tx->buf_zero_data);
	r3 = dm(Frmwk.->Bufzerocount);
	r3 = r3 - 1;
	if lt jump skip_store;
	dm(Frmwk.->Bufzerocount) = r3;
	
skip_store:			
	r3 = r9; 
	
	r0 = dm(TX_DAC_Output_Ch_Cnt.);
	r1 = 1;
	comp(r0,r1);
	if eq jump Tx_Bufzero_16;
	

	r1 = 2;
	comp(r0,r1);
	if eq jump Tx_Bufzero_18;

Tx_Bufzero_24:
	dm(i1,m6) = r0;	//L
	dm(i1,m6) = r0;	//C
	
	dm(i1,m6) = r0;	//R
	dm(i1,m6) = r0;	//Sw
	
	dm(i2,m6) = r0;	//Ls 
	dm(i2,m6) = r0;	//SBL 
	
  	dm(i2,m6) = r0;	//Rs
  	dm(i2,m6) = r0;	//SBR
  	
  	dm(i3,m6) = r0;
  	dm(i3,m6) = r0;
  	
  	dm(i3,m6) = r0;
  	dm(i3,m6) = r0;

  	dm(i4,m6) = r0;
  	dm(i4,m6) = r0;
  	dm(i4,m6) = r0;
  	dm(i4,m6) = r0;
  	dm(i5,m6) = r0;
  	dm(i5,m6) = r0;	
  	dm(i5,m6) = r0;
  	dm(i5,m6) = r0;
  	pm(i11,m14) = r0;
  	pm(i11,m14) = r0;
  	pm(i11,m14) = r0;
  	pm(i11,m14) = r0;
  	
	r3 = r3-1;
   	if gt jump Tx_Bufzero_24;	
	jump after_update1;
	nop;nop;nop;nop;
	
Tx_Bufzero_18:
	dm(i1,m6) = r0;	//L
	dm(i1,m6) = r0;	//C
	
	dm(i1,m6) = r0;	//R
	dm(i1,m6) = r0;	//Sw
	
	dm(i2,m6) = r0;	//Ls 
	dm(i2,m6) = r0;	//SBL 
	
  	dm(i2,m6) = r0;	//Rs
  	dm(i2,m6) = r0;	//SBR
  	
  	dm(i3,m6) = r0;
  	dm(i3,m6) = r0;
  	
  	dm(i3,m6) = r0;
  	dm(i3,m6) = r0;
  	
  	dm(i4,m6) = r0;
  	dm(i4,m6) = r0;
  	dm(i4,m6) = r0;
  	dm(i4,m6) = r0;
  	dm(i5,m6) = r0;
  	dm(i5,m6) = r0;	
  	dm(i5,m6) = r0;
  	dm(i5,m6) = r0;
	
	r3 = r3-1;
   	if gt jump Tx_Bufzero_18;	
	jump after_update1;
	nop;nop;nop;nop;
	
Tx_Bufzero_16:
	dm(i1,m6) = r0;	//L
	dm(i1,m6) = r0;	//C
	
	dm(i1,m6) = r0;	//R
	dm(i1,m6) = r0;	//Sw
	
	dm(i2,m6) = r0;	//Ls 
	dm(i2,m6) = r0;	//SBL 
	
  	dm(i2,m6) = r0;	//Rs
  	dm(i2,m6) = r0;	//SBR
  	
  	dm(i3,m6) = r0;
  	dm(i3,m6) = r0;
  	
  	dm(i3,m6) = r0;
  	dm(i3,m6) = r0;

  	dm(i4,m6) = r0;
  	dm(i4,m6) = r0;
  	dm(i4,m6) = r0;
  	dm(i4,m6) = r0;

	r3 = r3-1;
   	if gt jump Tx_Bufzero_16;	
	jump after_update1;

	nop;nop;nop;nop;	

.transmitter..END:
.endseg;
