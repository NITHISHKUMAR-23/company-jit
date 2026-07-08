/***************************************************************************
*
*  (C)Copyright Analog Devices Inc., India.
*  All rights reserved. Reproduction in whole or part is prohibited without 
*  the written permission of the copyright owner.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Receiver_ISR.asm
*  Description      :   Receiving 12 channels 64 samples in L,R,Ls,Rs,C,Sw,Sbl,Sbr,AddCh1, AddCh2, AddCh3, AddCh4 Format
						save & unsave register function for receiver ISR

******************************************************************************/


.IMPORT "..\src\system\Include\Def_Struct.h";
#include "def21569.h"
#include "..\src\system\Include\Adr_Lkup_Tab_Macros.h"
#include "..\src\system\Include\HostDefines.h"
#include "..\src\system\Include\Commn.h"
#include <asm_sprt.h>

.extern struct kernel Frmwk.;
.extern Chaining_pointer.;
.extern stop_timer.;
.extern restart_timer.;
.extern SingleI2S_prev_b2.;
.extern counttransmitter.;
.extern flag_receiver2.;
.extern common_rtn_label;
//.extern _streamdetect;
.extern int_SP0ABuffer4_ptr.;
.extern int_SP0ABuffer4_ptr.;

.extern unsave_lbrm_reg_rx;
.extern save_lbrm_reg_rx;

.section/sw Seg_Receiver_ISR_Code;

/******************************************************************************
*  Module Name        : receiver1
*  Functionality      : This function used for receive input data through 
						Single I2S or four I2S configured	
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/	
.global receiver1.; 	//Single I2S
.type receiver1., STT_FUNC;
receiver1.:
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(19*4))=MODE1;
	
	bit clr mode1 (  BITM_REGF_MODE1_BR0
                     | BITM_REGF_MODE1_BR8
                     | BITM_REGF_MODE1_PEYEN
                     | BITM_REGF_MODE1_BDCST1
                     | BITM_REGF_MODE1_BDCST9);
    
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
	bit set MODE1 BITM_REGF_MODE1_CBUFEN;
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
	call stop_timer.;
	I_ACALL (save_lbrm_reg_rx);
	
	dm(Frmwk.->Autdet->flag_receiver2) = m5;	
	
	l1 = 0; l2 = 0;

	r11 = dm(counttransmitter.);
	r11 = pass r11;
	b2  = dm(Frmwk.->Rx->DummyInAutbuf0_ptr);
	if eq jump Bufrx;
	b2  = dm(Frmwk.->Rx->DummyInAutbuf1_ptr);
	
	Bufrx:
	
		dm(Frmwk.->Rx->SingleI2S_prev_b2) = r11;
		//jump _streamdetect;

.global receiver2.;		//4 I2S MCPCM

receiver2.:           
    dm(Frmwk.->Misc->Protect->prolbufsave_rx+(19*4)) = MODE1;

	I_ACALL (save_lbrm_reg_rx);
	call stop_timer.;
	dm(Frmwk.->Autdet->flag_receiver2) = m6; 
	l1 = 0; l2 = 0; l4=0; 	
AutoDetectMode_RX:

	
	dm(Frmwk.->Autdet->autodetectcount) = m5;
	r10 = dm(Frmwk.->autodetect_mode);
	r9  = FORCEADC;
	comp(r10,r9);
	if eq jump FORCEADC_RX;	

    r11 = dm(counttransmitter.);
    r11 = pass r11;

	b0  = dm(Frmwk.->Rx->DummyInAutbuf0_ptr);
	b1  = dm(Frmwk.->Rx->DummyInAutbuf2_ptr);
	b2  = dm(Frmwk.->Rx->DummyInAutbuf4_ptr);	
	b3  = dm(Frmwk.->Rx->DummyInAutbuf6_ptr);
		
	if eq jump Bufrx_lpcm;
	b0  = dm(Frmwk.->Rx->DummyInAutbuf1_ptr);
	b1  = dm(Frmwk.->Rx->DummyInAutbuf3_ptr);
	b2  = dm(Frmwk.->Rx->DummyInAutbuf5_ptr);	
	b3  = dm(Frmwk.->Rx->DummyInAutbuf7_ptr);	
	
Bufrx_lpcm:
	l0 = 256;
	l1 = 256;
	l2 = 256;
	l3 = 256;


	r10 = dm(Frmwk.->Autdet->autodetect3);
	r10 = pass r10;
	if ne jump AUTODETECT3_RX;	
	r10 = dm(Frmwk.->MCLPCM_ON);
	r10 = pass r10;
	if ne jump MCLPCM_RX;
	
	jump Donedetect;	

AUTODETECT3_RX:  
   	i4 = dm(Frmwk.->Rx->INPUTsamples_ptr);
  
   	r0 = dm(Frmwk.->Misc->Control->InAutobufsizeby2);
   	r0 = lshift r0 by -1;
   	s0 = r0;  
  
	bit set mode1 BITM_REGF_MODE1_PEYEN;
	nop;
	nop;
  
	nop;nop;

pcmcpy_lpcm:

    r10 = dm(i0,2);	           
	dm(i4,2) = r10;
		    
	r10 = dm(i1,2);	
	dm(i4,2) = r10;
	    
	r10 = dm(i2,2);
	dm(i4,2) = r10;
		    
	r10 = dm(i3,2);
	dm(i4,2) = r10;
		   
	r0 = r0 - 1;
	if gt jump pcmcpy_lpcm;
	      
	bit clr mode1 BITM_REGF_MODE1_PEYEN;
	nop;
	nop;
  
	nop;nop;
	l0 = 0;

	b2 = dm(Frmwk.->Rx->INPUTsamples_ptr);	
	//jump _streamdetect;	

/*----   return label	---------------*/

.global common_rtn_label;	
common_rtn_label:
	I_AJUMP (rtn_label);	
common_rtn_label.END:

	
I_ALABEL_ (rtn_label)
	dm(Frmwk.->Misc->Protect->save_rxisr) = r15;		
    
   	l4 = 0;
	l2 = 0; 
    l1 = 0;

	r10 = dm(Frmwk.->Autdet->flag_receiver2);
	r10 = pass r10;
	if eq jump SingleI2S;
	
	r10 = dm(Frmwk.->autodetect_mode);
	r11 = FORCEADC;
	comp(r10,r11);
    if eq jump Donedetect;
	 
	r11 = FORCEPCM3;
	comp(r10, r11);
	if eq jump Donedetect;	
	 
	r10 = dm(Frmwk.->Autdet->autodetectcount);
	r10 = r10 + 1;
	dm(Frmwk.->Autdet->autodetectcount) = r10;
	r11 = 4;
	comp(r10,r11);
	if ge jump Donedetect;  
 
	r11 = dm(Frmwk.->Misc->Control->InAutobufsizeby2);
	r10 = r10 * r11(ssi);
	m2  = r10;
	i2  = dm(Frmwk.->Rx->INPUTsamples_ptr);
	nop;
	modify(i2,m2);
	b2  = i2;
	//jump _streamdetect;

Donedetect:
	I_ACALL (unsave_lbrm_reg_rx);
	call restart_timer.;
	MODE1 = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(19*4));
	nop;nop;
	
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
rtn_label.END:
	
SingleI2S:

#ifdef DMA_HIGH_PRIORITY	
/** code added to enable dma*/

	r0 = dm(Check_EPDMARx1);
	r0 = pass r0;
	if eq jump no_dma_change3;
	
	r0 = dm(CEP0);
	r0 = pass r0;
	if ne jump Enable_DMA1;
	
	r0 = dm(ECEP0);
	r0 = pass r0;
	if eq jump no_dma_change3;
	
	r0 = dm(IIEP0);
	r0 = r0 - 1;
	dm(IIEP0) = r0;
	
	dm(IMEP0) = m5;
	
	r0 = dm(ECEP0);
	dm(CEP0) = r0;
	
Enable_DMA1:
	r0 = dm(DMAC0);
	r0 = bset r0 by 0;
	dm(DMAC0) = r0;

no_dma_change3:
	dm(Check_EPDMARx1) = m5;

/** code added to enable dma.End*/
#endif
	
 	I_ACALL (unsave_lbrm_reg_rx);
	call restart_timer.;
	MODE1=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(19*4));		
	nop;nop;
	
	i12 = dm(m7,i6);
jump (m14,i12) (db); rframe; nop;
/*----   return label - end	---------------*/
.receiver1..END:

 
MCLPCM_RX:	

    r0 = 0xF;
    dm(Frmwk.->Autdet->MSGR_Save) = r0;
	
	l4 = dm(Frmwk.->IOP->Pack->length);
	b4 = dm(Frmwk.->IOP->Pack->heap);	
	i4 = dm(Frmwk.->IOP->Pack->wr_ptr);
	r0 = dm(Frmwk.->Misc->Control->InAutobufsizeby2);
	r0 = lshift r0 by -1;
   	s0 = r0;  
  
	bit set mode1 BITM_REGF_MODE1_PEYEN;
	nop;
	nop;

pcmcpy_mcpcm:
	r10 = dm(i0,2);			// Left & Right In
	dm(i4,2) = r10;

	r10 = dm(i1,2);			// Center In & SW
	dm(i4,2) = r10;

	r10 = dm(i2,2);			// Ls & Rs In		
	dm(i4,2) = r10;

	r10 = dm(i3,2);			// SBL & SBR In
	dm(i4,2) = r10;
		    	    	    
	r0 = r0 - 1;
	if gt jump pcmcpy_mcpcm;

	bit clr mode1 BITM_REGF_MODE1_PEYEN;
	nop;
	nop;

    dm(Frmwk.->IOP->Pack->wr_ptr) = i4;

    jump common_rtn_label;

FORCEADC_RX:		
	    
wchdradc:	
	r11 = dm(counttransmitter.);
	r11 = pass r11;
	b2  = dm(Frmwk.->Rx->DummyInAutbuf0_ptr);
	if eq jump Bufrx_adc;
	b2  = dm(Frmwk.->Rx->DummyInAutbuf1_ptr);
	
Bufrx_adc:	
	l4 = dm(Frmwk.->IOP->Pack->length);
	b4 = dm(Frmwk.->IOP->Pack->heap);	
	i4 = dm(Frmwk.->IOP->Pack->wr_ptr);
	r10 = dm(Frmwk.->Misc->Control->InAutobufsizeby2);
	r10 = lshift r10 by -1;

	lcntr = r10,do pcmcpy_adc until lce;
    r10 = dm(i2,1);			// Left
    dm(i4,1) = r10;
    r10 = dm(i2,1);
	pcmcpy_adc: dm(i4,1) = r10;     // Right
	
    dm(Frmwk.->IOP->Pack->wr_ptr) = i4;	
    jump common_rtn_label;
		
/*************************************************************************/
.receiver2..END:


.endseg;