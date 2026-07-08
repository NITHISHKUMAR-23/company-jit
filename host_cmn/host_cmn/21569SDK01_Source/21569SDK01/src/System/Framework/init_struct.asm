/*****************************************************************************
 *
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you 
agree to the terms of the associated Analog Devices License Agreement.
 *
 *  Project          :  	21569SDK
 *  Organization     :  	Jasmin Infotech Private Limited,Chennai
 *  File Name        :		init_struct.asm
 *  Description      :   	Copy Routines
 ******************************************************************************/
#define COUNT 64

#include "asm_sprt.h"
.IMPORT "..\src\system\Include\Def_Struct.h";
#include "..\src\system\Include\Adr_Lkup_Tab_Macros.h"
#include "..\src\system\Include\HostDefines.h"
#include "..\src\system\Include\Commn.h"
#include "..\src\system\Include\Codeid.h"
#include "..\src\system\Include\Extern_SPI.h"
#include "def21569.h"


.section/DM  seg_dmda;
  
.var save_l4.;
.var save_i4.;
.var save_mode2.;
.var save_r0.;
             
.endseg;

.extern struct kernel Frmwk.;
.extern Predac_buffer_Int.;
.extern down_samp_flag.;

/******************************************************************************
*  Module Name        : save_lbrm_reg_rx
*  Functionality      : Saving of registers which is used in receiver ISR
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/	
.section/sw  Seg_Init_Struct_Code;
I_ALABEL_ALG_(save_lbrm_reg_rx)

	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(0*4))=b1;	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(1*4))=i1;	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(2*4))=l1; 
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(3*4))=b2;	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(4*4))=i2;	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(5*4))=l2; 
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(6*4))=b4;	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(7*4))=i4;	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(8*4))=l4; 
	
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(22*4))=b0; dm(Frmwk.->Misc->Protect->prolbufsave_rx+(23*4))=i0; dm(Frmwk.->Misc->Protect->prolbufsave_rx+(24*4))=l0; 
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(25*4))=b3; dm(Frmwk.->Misc->Protect->prolbufsave_rx+(26*4))=i3; dm(Frmwk.->Misc->Protect->prolbufsave_rx+(27*4))=l3; 
	
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(33*4))=b5; dm(Frmwk.->Misc->Protect->prolbufsave_rx+(34*4))=i5; dm(Frmwk.->Misc->Protect->prolbufsave_rx+(35*4))=l5; 
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(36*4))=b9; dm(Frmwk.->Misc->Protect->prolbufsave_rx+(37*4))=i9; dm(Frmwk.->Misc->Protect->prolbufsave_rx+(38*4))=l9;

	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(28*4)) = m2; 
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(9*4))  = r0;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(10*4)) = r1;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(11*4)) = r2;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(12*4)) = r4;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(13*4)) = r9;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(14*4)) = r10;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(15*4)) = r11;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(16*4)) = r13;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(17*4)) = r14;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(18*4)) = r15;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(30*4)) = r12;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(31*4)) = s0;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(29*4)) = s10; 	
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(20*4)) = ASTATX;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(32*4)) = ASTATY;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(21*4)) = LCNTR;	
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(39*4)) = b8;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(40*4)) = i8;
	dm(Frmwk.->Misc->Protect->prolbufsave_rx+(41*4)) = l8;
	
	rts;
save_lbrm_reg_rx.end:	

/******************************************************************************
*  Module Name        : saveforCEnv
*  Functionality      : Saving of PEx, PEy, DAG1,2, & MODE1 registers
*						This will be called when calling an asm module from 'c'				
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/	
I_ALABEL_ALG_(saveforCEnv)
	
	I_ACALL (saveforCEnvNoMode1);	
	rts;	
saveforCEnv.end:

/******************************************************************************
*  Module Name        : unsave_lbrm_reg_rx
*  Functionality      : Unsaving of registers which is used in receiver ISR
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/	

I_ALABEL_ALG_(unsave_lbrm_reg_rx)
	
	ASTATX = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(20*4));
	ASTATY = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(32*4));
	r0 = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(21*4));	
	LCNTR=r0;
	b1=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(0*4));	i1=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(1*4));	l1=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(2*4)); 
	b2=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(3*4));	i2=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(4*4));	l2=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(5*4)); 
	b4=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(6*4));	i4=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(7*4));	l4=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(8*4)); 
	
	b0=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(22*4)); i0=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(23*4)); l0=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(24*4)); 
	b3=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(25*4)); i3=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(26*4)); l3=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(27*4)); 
	
	b5=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(33*4)); i5=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(34*4)); l5=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(35*4)); 
	b9=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(36*4)); i9=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(37*4)); l9=dm(Frmwk.->Misc->Protect->prolbufsave_rx+(38*4)); 

	m2  = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(28*4));
	r0  = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(9*4));
	r1  = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(10*4));
	r2  = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(11*4));
	r4  = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(12*4));
	r9  = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(13*4));
	r10 = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(14*4));
	r11 = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(15*4));
	r13 = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(16*4));
	r14 = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(17*4));
	r15 = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(18*4));
	r12 = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(30*4));
	s0  = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(31*4));
	b8  = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(39*4));
	i8  = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(40*4));
	l8  = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(41*4));	
	s10 = dm(Frmwk.->Misc->Protect->prolbufsave_rx+(29*4)); 
	rts;
unsave_lbrm_reg_rx.end:	

I_ALABEL_ALG_(save_lbrm_reg_tx)

	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(0*4))=b0;	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(1*4))=i0;	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(2*4))=l0; 
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(3*4))=b1;	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(4*4))=i1;	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(5*4))=l1; 
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(6*4))=b2;	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(7*4))=i2;	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(8*4))=l2; 
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(9*4))=b3;	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(10*4))=i3; dm(Frmwk.->Misc->Protect->prolbufsave_tx+(11*4))=l3; 
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(12*4))=b4;    dm(Frmwk.->Misc->Protect->prolbufsave_tx+(13*4))=i4; dm(Frmwk.->Misc->Protect->prolbufsave_tx+(14*4))=l4; 
	
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(29*4))=b5; dm(Frmwk.->Misc->Protect->prolbufsave_tx+(30*4))=i5; dm(Frmwk.->Misc->Protect->prolbufsave_tx+(31*4))=l5; 	
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(34*4))=b8; dm(Frmwk.->Misc->Protect->prolbufsave_tx+(35*4))=i8; dm(Frmwk.->Misc->Protect->prolbufsave_tx+(36*4))=l8; 		
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(37*4))=b9; dm(Frmwk.->Misc->Protect->prolbufsave_tx+(38*4))=i9; dm(Frmwk.->Misc->Protect->prolbufsave_tx+(39*4))=l9; 			
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(40*4))=b13; dm(Frmwk.->Misc->Protect->prolbufsave_tx+(41*4))=i13;	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(42*4))=l13; 			

	
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(32*4)) = r7; 	
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(33*4)) = r8; 	
	
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(15*4)) = r0;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(16*4)) = r3;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(17*4)) = r4;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(18*4)) = r5;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(19*4)) = r6;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(20*4)) = r10;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(21*4)) = r11;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(22*4)) = r14;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(23*4)) = r15;
        dm(Frmwk.->Misc->Protect->prolbufsave_tx+(24*4)) = m2;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(25*4)) = m4;

	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(28*4)) = LCNTR;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(43*4)) = r9;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(44*4)) = r2;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(45*4)) = s3;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(46*4)) = s4;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(47*4)) = s5;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(48*4)) = s6;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(49*4)) = s10;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(50*4)) = s11;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(51*4)) = s14;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(52*4)) = s0;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(53*4)) = m12;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(54*4)) = m11;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(55*4)) = r13;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(56*4)) = r1;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(57*4)) = m0;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(58*4)) = r12;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(59*4)) = s1;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(60*4)) = s12;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(61*4)) = s15;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(62*4)) = ASTATX;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(63*4)) = ASTATY;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(64*4)) = s7;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(65*4)) = s8;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(66*4)) = s13;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(67*4)) = r12;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(68*4)) = s2;
	r1 = mr0f;
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(69*4)) = r1;
	r1 = mr1f;	
	dm(Frmwk.->Misc->Protect->prolbufsave_tx+(70*4)) = r1;
	rts;
save_lbrm_reg_tx.end:	

/*************************************************************************/

I_ALABEL_ALG_(unsave_lbrm_reg_tx)

	r1 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(69*4));
	mr0f = r1; 
	r1 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(70*4));
	mr1f = r1;
	r0 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(28*4));
	LCNTR = r0;
	b0=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(0*4));	i0=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(1*4));	l0=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(2*4)); 
	b1=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(3*4));	i1=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(4*4));	l1=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(5*4)); 
	b2=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(6*4));	i2=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(7*4));	l2=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(8*4)); 
	b3=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(9*4));	i3=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(10*4)); l3=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(11*4)); 
	b4=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(12*4)); i4=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(13*4)); l4=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(14*4)); 
	
	b5=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(29*4)); i5=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(30*4)); l5=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(31*4)); 	
	b8=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(34*4)); i8=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(35*4)); l8=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(36*4)); 		
	b9=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(37*4)); i9=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(38*4)); l9=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(39*4)); 			
	b13=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(40*4)); i13=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(41*4)); l13=dm(Frmwk.->Misc->Protect->prolbufsave_tx+(42*4)); 
	
	r7 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(32*4)); 	
	r8 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(33*4)); 	

	r0  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(15*4));
	r3  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(16*4));
	r4  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(17*4));
	r5  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(18*4));
	r6  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(19*4));
	r10 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(20*4));
	r11 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(21*4));
	r14 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(22*4));
	r15 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(23*4));
    m2  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(24*4));
	m4  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(25*4));
	r9  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(43*4));
    r2  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(44*4));
   	s3  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(45*4));
	s4  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(46*4));
	s5  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(47*4));
	s6  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(48*4));
	s10 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(49*4));
	s11 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(50*4));
	s14 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(51*4));
    s0  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(52*4));
    m12 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(53*4));
    m11 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(54*4));
    r13 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(55*4));
    r1  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(56*4));
    m0  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(57*4));
    r12 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(58*4));
	s1  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(59*4));
    s12 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(60*4));
    s15 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(61*4));
    ASTATX = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(62*4));
	ASTATY = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(63*4));
    s7  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(64*4));
	s8  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(65*4));
	s13 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(66*4));
	r12 = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(67*4));
	s2  = dm(Frmwk.->Misc->Protect->prolbufsave_tx+(68*4));

	rts;
unsave_lbrm_reg_tx.end:

/******************************************************************************
*  Module Name        : unsaveforCEnv
*  Functionality      : Unsaving of PEx, PEy, DAG1,2, & MODE1 registers
*						This will be called when returning from an asm module to 'c'	
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/		

I_ALABEL_ALG_(unsaveforCEnv)

	I_ACALL (unsaveforCEnvNoMode1);	
	nop;
	
	rts;
unsaveforCEnv.end:

/******************************************************************************
*  Module Name        : saveforCEnvNoMode1
*  Functionality      : Saving of PEx, PEy, DAG1, DAG2 registers
*						This will be called when returning from an asm module to 'c'	
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/		
		
I_ALABEL_ALG_(saveforCEnvNoMode1)	

	dm(Frmwk.->Misc->Protect->savestack+(1*4)) = r3;  dm(Frmwk.->Misc->Protect->savestack+(2*4)) = r5;
	dm(Frmwk.->Misc->Protect->savestack+(3*4)) = r6;  dm(Frmwk.->Misc->Protect->savestack+(4*4)) = r7;  dm(Frmwk.->Misc->Protect->savestack+(5*4)) = r9;
	dm(Frmwk.->Misc->Protect->savestack+(6*4)) = r10; dm(Frmwk.->Misc->Protect->savestack+(7*4)) = r11; dm(Frmwk.->Misc->Protect->savestack+(8*4)) = r13;
	dm(Frmwk.->Misc->Protect->savestack+(9*4)) = r14; dm(Frmwk.->Misc->Protect->savestack+(10*4)) = r15;

	dm(Frmwk.->Misc->Protect->savestack+(11*4)) = b0;  dm(Frmwk.->Misc->Protect->savestack+(12*4)) = b1;  dm(Frmwk.->Misc->Protect->savestack+(13*4)) = b2;
	dm(Frmwk.->Misc->Protect->savestack+(14*4)) = b3;  dm(Frmwk.->Misc->Protect->savestack+(15*4)) = b5;
	dm(Frmwk.->Misc->Protect->savestack+(18*4)) = b8;  dm(Frmwk.->Misc->Protect->savestack+(19*4)) = b9;
	dm(Frmwk.->Misc->Protect->savestack+(20*4)) = b10; dm(Frmwk.->Misc->Protect->savestack+(21*4)) = b11; dm(Frmwk.->Misc->Protect->savestack+(22*4)) = b14;
	dm(Frmwk.->Misc->Protect->savestack+(23*4)) = b15;

	dm(Frmwk.->Misc->Protect->savestack+(24*4)) = i0;  dm(Frmwk.->Misc->Protect->savestack+(25*4)) = i1;  dm(Frmwk.->Misc->Protect->savestack+(26*4)) = i2;
	dm(Frmwk.->Misc->Protect->savestack+(27*4)) = i3;  dm(Frmwk.->Misc->Protect->savestack+(28*4)) = i5;
	dm(Frmwk.->Misc->Protect->savestack+(31*4)) = i8;  dm(Frmwk.->Misc->Protect->savestack+(32*4)) = i9;
	dm(Frmwk.->Misc->Protect->savestack+(33*4)) = i10; dm(Frmwk.->Misc->Protect->savestack+(34*4)) = i11; dm(Frmwk.->Misc->Protect->savestack+(35*4)) = i14;
	dm(Frmwk.->Misc->Protect->savestack+(36*4)) = i15;

	dm(Frmwk.->Misc->Protect->savestack+(37*4)) = l0;  dm(Frmwk.->Misc->Protect->savestack+(38*4)) = l1;  dm(Frmwk.->Misc->Protect->savestack+(39*4)) = l2;
	dm(Frmwk.->Misc->Protect->savestack+(40*4)) = l3;  dm(Frmwk.->Misc->Protect->savestack+(41*4)) = l5;
	dm(Frmwk.->Misc->Protect->savestack+(44*4)) = l8;  dm(Frmwk.->Misc->Protect->savestack+(45*4)) = l9;
	dm(Frmwk.->Misc->Protect->savestack+(46*4)) = l10; dm(Frmwk.->Misc->Protect->savestack+(47*4)) = l11; dm(Frmwk.->Misc->Protect->savestack+(48*4)) = l14;
	dm(Frmwk.->Misc->Protect->savestack+(49*4)) = l15;

	dm(Frmwk.->Misc->Protect->savestack+(50*4)) = m0;  dm(Frmwk.->Misc->Protect->savestack+(51*4)) = m1;  dm(Frmwk.->Misc->Protect->savestack+(52*4)) = m2;
	dm(Frmwk.->Misc->Protect->savestack+(53*4)) = m3;  dm(Frmwk.->Misc->Protect->savestack+(54*4)) = m8;  dm(Frmwk.->Misc->Protect->savestack+(55*4)) = m9;
	dm(Frmwk.->Misc->Protect->savestack+(56*4)) = m10; dm(Frmwk.->Misc->Protect->savestack+(57*4)) = m11; dm(Frmwk.->Misc->Protect->savestack+(58*4)) = m12;

	dm(Frmwk.->Misc->Protect->savestack+(59*4)) = l13;
	dm(Frmwk.->Misc->Protect->savestack+(60*4)) = l12;
	dm(Frmwk.->Misc->Protect->savestack+(61*4)) = l4;
	dm(Frmwk.->Misc->Protect->savestack+(62*4)) = MODE1;
	
I_ALABEL_ALG_(ClearLengthRegisters)

	l0 = 0; l1 = 0; l2  = 0; l3  = 0; l4  = 0; l5  = 0;
	l8 = 0; l9 = 0; l10 = 0; l11 = 0; l12 = 0; l13 = 0; l14 = 0; l15 = 0;
	rts;
	
ClearLengthRegisters.end:	

saveforCEnvNoMode1.end:	

/******************************************************************************
*  Module Name        : unsaveforCEnvNoMode1
*  Functionality      : Unsaving of PEx, PEy, DAG1, DAG2, registers
*						This will be called when returning from an asm module to 'c'	
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/		
	
I_ALABEL_ALG_(unsaveforCEnvNoMode1)	
	
		r3 = dm(Frmwk.->Misc->Protect->savestack+(1*4));	 r5 = dm(Frmwk.->Misc->Protect->savestack+(2*4));
		r6 = dm(Frmwk.->Misc->Protect->savestack+(3*4));	 r7 = dm(Frmwk.->Misc->Protect->savestack+(4*4));	r9  = dm(Frmwk.->Misc->Protect->savestack+(5*4));
		r10= dm(Frmwk.->Misc->Protect->savestack+(6*4));	 r11= dm(Frmwk.->Misc->Protect->savestack+(7*4));   r13 = dm(Frmwk.->Misc->Protect->savestack+(8*4));
		r14= dm(Frmwk.->Misc->Protect->savestack+(9*4));	 r15= dm(Frmwk.->Misc->Protect->savestack+(10*4));
	
		b0 = dm(Frmwk.->Misc->Protect->savestack+(11*4));    b1 = dm(Frmwk.->Misc->Protect->savestack+(12*4));  b2 = dm(Frmwk.->Misc->Protect->savestack+(13*4));
		b3 = dm(Frmwk.->Misc->Protect->savestack+(14*4));    b5 = dm(Frmwk.->Misc->Protect->savestack+(15*4));
		b8 = dm(Frmwk.->Misc->Protect->savestack+(18*4)); 	 b9 = dm(Frmwk.->Misc->Protect->savestack+(19*4));
		b10= dm(Frmwk.->Misc->Protect->savestack+(20*4));    b11= dm(Frmwk.->Misc->Protect->savestack+(21*4));  b14= dm(Frmwk.->Misc->Protect->savestack+(22*4));
		b15= dm(Frmwk.->Misc->Protect->savestack+(23*4));
	
		i0 = dm(Frmwk.->Misc->Protect->savestack+(24*4));    i1 = dm(Frmwk.->Misc->Protect->savestack+(25*4));  i2 = dm(Frmwk.->Misc->Protect->savestack+(26*4));
		i3 = dm(Frmwk.->Misc->Protect->savestack+(27*4));    i5 = dm(Frmwk.->Misc->Protect->savestack+(28*4));
		i8 = dm(Frmwk.->Misc->Protect->savestack+(31*4));    i9 = dm(Frmwk.->Misc->Protect->savestack+(32*4));
		i10= dm(Frmwk.->Misc->Protect->savestack+(33*4));    i11= dm(Frmwk.->Misc->Protect->savestack+(34*4));  i14= dm(Frmwk.->Misc->Protect->savestack+(35*4));
		i15= dm(Frmwk.->Misc->Protect->savestack+(36*4));
	
		l0 = dm(Frmwk.->Misc->Protect->savestack+(37*4));    l1 = dm(Frmwk.->Misc->Protect->savestack+(38*4));  l2 = dm(Frmwk.->Misc->Protect->savestack+(39*4));
		l3 = dm(Frmwk.->Misc->Protect->savestack+(40*4));    l5 = dm(Frmwk.->Misc->Protect->savestack+(41*4));
		l8 = dm(Frmwk.->Misc->Protect->savestack+(44*4));    l9 = dm(Frmwk.->Misc->Protect->savestack+(45*4));
		l10= dm(Frmwk.->Misc->Protect->savestack+(46*4));    l11= dm(Frmwk.->Misc->Protect->savestack+(47*4));  l14= dm(Frmwk.->Misc->Protect->savestack+(48*4));
		l15= dm(Frmwk.->Misc->Protect->savestack+(49*4));
	
		m0 = dm(Frmwk.->Misc->Protect->savestack+(50*4));    m1 = dm(Frmwk.->Misc->Protect->savestack+(51*4));  m2 = dm(Frmwk.->Misc->Protect->savestack+(52*4));
		m3 = dm(Frmwk.->Misc->Protect->savestack+(53*4));    m8 = dm(Frmwk.->Misc->Protect->savestack+(54*4));  m9 = dm(Frmwk.->Misc->Protect->savestack+(55*4));
		m10= dm(Frmwk.->Misc->Protect->savestack+(56*4));    m11= dm(Frmwk.->Misc->Protect->savestack+(57*4));  m12= dm(Frmwk.->Misc->Protect->savestack+(58*4));
	
		l13= dm(Frmwk.->Misc->Protect->savestack+(59*4));
		l12= dm(Frmwk.->Misc->Protect->savestack+(60*4));
		l4 = dm(Frmwk.->Misc->Protect->savestack+(61*4));
		MODE1 = dm(Frmwk.->Misc->Protect->savestack+(62*4));
	
		rts;
unsaveforCEnvNoMode1.end:	
.endseg;

/******************************************************************************
 *  Module Name        : Flag_Toggle
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
 
.section/sw  Seg_Init_Struct_Code;
.global Flag_Toggle.;
.type Flag_Toggle., STT_FUNC;
Flag_Toggle.:
	
	I_ACALL (FLAG_TOGGLE_ROUTINE);	
	
Flag_Toggle..END:

/******************************************************************************
 *  Module Name        : FlagsConfigure
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
 
.global FlagsConfigure.;
.type FlagsConfigure., STT_FUNC;
FlagsConfigure.:

    bit set FLAGS BITM_REGF_FLAGS_FLG0O; 
	nop;nop;nop;nop;
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;		
	
.FlagsConfigure..end:

/******************************************************************************
 *  Module Name        : SendInitializationDone
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
 
.global SendInitializationDone.;
.type SendInitializationDone., STT_FUNC;
SendInitializationDone.:

    call SendInitializationDone_asm; 
	nop;nop;nop;nop;
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;	
	
.SendInitializationDone..end:

.endseg;

	/******************************************************************************
*  Module Name        : Pre_Dac_Ptr_Update
*  Functionality      : Predac channels pointer update after decoding & post processing process
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/	

.global Pre_Dac_Ptr_Update.;
.type Pre_Dac_Ptr_Update., STT_FUNC;
Pre_Dac_Ptr_Update.:
	
	I_ACALL (saveforCEnv);
   /*--------------------------------------*/     
    l1 = dm(Frmwk.->IOP->Predac->length);
    b1 = dm(Frmwk.->IOP->Predac->heap);
    i1 = dm(Frmwk.->IOP->Predac->wr_ptr);       		
   	
   	r0 = dm(Frmwk.->IOP->Predac->lengthhalf);
   	m2 = r0;  	
   	
   	modify(i1,m2)(nw);
   		   	
	dm(Frmwk.->IOP->Predac->wr_ptr) = i1;		
	
	I_ACALL (unsaveforCEnv);
	nop;
	nop;
	
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;

.Pre_Dac_Ptr_Update..end:

/******************************************************************************
*  Module Name        : AddPredac_Ptr_Update
*  Functionality      : Predac channels pointer update after decoding & post processing process
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/	

.global AddPredac_Ptr_Update.;
.type AddPredac_Ptr_Update., STT_FUNC;
AddPredac_Ptr_Update.:

	I_ACALL (saveforCEnv);
   /*--------------------------------------*/     
    l1 = dm(Frmwk.->IOP->AddPreDac->length);
    b1 = dm(Frmwk.->IOP->AddPreDac->heap);
    i1 = dm(Frmwk.->IOP->AddPreDac->wr_ptr);       		
   	
   	r0 = dm(Frmwk.->IOP->AddPreDac->lengthhalf);
   	m2 = r0;  	
   	
   	modify(i1,m2)(nw);
	dm(Frmwk.->IOP->AddPreDac->wr_ptr) = i1;	
	
	I_ACALL (unsaveforCEnv);
	nop;
	nop;
	
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;

.AddPredac_Ptr_Update..end:
.endseg;

/******************************************************************************
 *  Module Name        : Pack_TO_Predac
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.section/sw  seg_kernal_code_l3;
.global Pack_TO_Predac.; 	//Single I2S
.type Pack_TO_Predac., STT_FUNC;
Pack_TO_Predac.:

	I_ACALL (saveforCEnv);	
	
	l1 = dm(Frmwk.->IOP->Pack->length);
	b1 = dm(Frmwk.->IOP->Pack->heap);
	i1 = dm(Frmwk.->IOP->Pack->rd_ptr);	
	
	l0 = dm(Frmwk.->IOP->Predac->length);
	b0 = dm(Frmwk.->IOP->Predac->heap);
	i0 = dm(Frmwk.->IOP->Predac->wr_ptr);	

	bit set mode1 BITM_REGF_MODE1_PEYEN;
    nop;
    nop;	
					
	r2 = dm(Frmwk.->SampleBlock);
	
	r4 = NUMMAXCHAN - 2;
    m0 = r4;	
	 
	lcntr = r2, do cpy_pack_to_predac_8channels until lce;        
	   
   /******** Pack to Predac buffer copying*****/

    r0 = dm(i1,2);			// Left In  Right In			
    dm(i0,2) = r0;			// Left Out	Right Out
   
cpy_pack_to_predac_8channels: modify(i0,m0)(nw);	

	bit clr mode1 BITM_REGF_MODE1_PEYEN;
    nop;
    nop;	

	I_ACALL (unsaveforCEnv);
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.Pack_TO_Predac..end:	
.endseg;

/******************************************************************************
 *  Module Name        : Pack_TO_Predac_MCPCM_SPDIF
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.section/sw  seg_kernal_code_l3;
.global Pack_TO_Predac_MCPCM_SPDIF.; 	//Single I2S
.type Pack_TO_Predac_MCPCM_SPDIF., STT_FUNC;
Pack_TO_Predac_MCPCM_SPDIF.:

	I_ACALL (saveforCEnv);	
	
	l1 = dm(Frmwk.->IOP->Pack->length);
	b1 = dm(Frmwk.->IOP->Pack->heap);
	i1 = dm(Frmwk.->IOP->Pack->rd_ptr);		
		
	l0 = dm(Frmwk.->IOP->Predac->length);
	b0 = dm(Frmwk.->IOP->Predac->heap);
	i0 = dm(Frmwk.->IOP->Predac->wr_ptr);
	
	r4 = 0;
	/********** This function is to make memset for predac buffer ************/

	r2 = dm(Frmwk.->IOP->Predac->lengthhalf);	
	lcntr = r2, do mem_zero_mcpcm1_spdif until lce;
	mem_zero_mcpcm1_spdif: dm(i0,1) = r4;
	
	/****************************** memset end ******************************/		
	i0 = dm(Frmwk.->IOP->Predac->wr_ptr);
	bit SET mode1 BITM_REGF_MODE1_PEYEN;
    nop;
   	nop;
   	
	r3 = 0;			
	r2 = dm(Frmwk.->SampleBlock);
	
	r4 = NUMMAXCHAN - NO_OF_INPUT_CHANNEL;
    m0 = r4;
	
	lcntr = r2, do cpy_pack_to_predac_8channels8_spdif until lce;	
	/******** Pack to Predac buffer copying*****/

  	r0 = dm(i1,2);			// Left In  Right In			
    dm(i0,2) = r0;			// Left Out	Right Out
     
    dm(i1,2) = r3;
    dm(i1,2) = r3;
    dm(i1,2) = r3;
    						
    dm(i0,2) = r3;
    dm(i0,2) = r3;
    dm(i0,2) = r3;

	cpy_pack_to_predac_8channels8_spdif:  modify(i0,m0)(nw); 	

	bit clr mode1 BITM_REGF_MODE1_PEYEN;
    nop;
    nop;

	I_ACALL (unsaveforCEnv);
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.Pack_TO_Predac_MCPCM_SPDIF..end:	
.endseg;
	
/******************************************************************************
 *  Module Name        : Pack_TO_Predac_MCPCM
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.section/sw  seg_kernal_code_l3;
.global Pack_TO_Predac_MCPCM.; 	//Single I2S
.type Pack_TO_Predac_MCPCM., STT_FUNC;
Pack_TO_Predac_MCPCM.:

	I_ACALL (saveforCEnv);	
	
	l1 = dm(Frmwk.->IOP->Pack->length);
	b1 = dm(Frmwk.->IOP->Pack->heap);
	i1 = dm(Frmwk.->IOP->Pack->rd_ptr);		
		
	l0 = dm(Frmwk.->IOP->Predac->length);
	b0 = dm(Frmwk.->IOP->Predac->heap);
	i0 = dm(Frmwk.->IOP->Predac->wr_ptr);
	
	r4 = 0;
	/********** This function is to make memset for predac buffer ************/

	r2 = dm(Frmwk.->IOP->Predac->lengthhalf);	
	lcntr = r2, do mem_zero_mcpcm1 until lce;
	mem_zero_mcpcm1: dm(i0,1) = r4;
	
	/****************************** memset end ******************************/		
	i0 = dm(Frmwk.->IOP->Predac->wr_ptr);
	bit SET mode1 BITM_REGF_MODE1_PEYEN;
    nop;
   	nop;	
			
	r2 = dm(Frmwk.->SampleBlock);
	
	r4 = NUMMAXCHAN - NO_OF_INPUT_CHANNEL;
    m0 = r4;
	
	lcntr = r2, do cpy_pack_to_predac_8channels8 until lce;	
	/******** Pack to Predac buffer copying*****/

  	r0 = dm(i1,2);			// Left In  Right In			
    dm(i0,2) = r0;			// Left Out	Right Out   	
    r0 = dm(i1,2);	    	// C SW		    
  	#ifdef C_SW_Swap
   		r0<->s0;			    
  	#endif		  
    dm(i0,2) = r0;			// C SW
    r0 = dm(i1,2);	    	// LS RS			    		 
    dm(i0,2) = r0;			// LS RS
    r0 = dm(i1,2);	    	// LSR RSR	
    dm(i0,2) = r0;			// LSR RSR		
 
	cpy_pack_to_predac_8channels8:  modify(i0,m0)(nw); 	

	bit clr mode1 BITM_REGF_MODE1_PEYEN;
    nop;
    nop;	 

	I_ACALL (unsaveforCEnv);
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.Pack_TO_Predac_MCPCM..end:	
.endseg;

/******************************************************************************
 *  Module Name        : Init_Struct
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.section/sw  seg_kernal_code_l3;
.global Init_Struct.;
.type Init_Struct., STT_FUNC;
Init_Struct.:
	
	I_ACALL(saveforCEnv);	

	/********************
	Kernel I/O buffers & variables Init
	********************/
	r0 = PACK_LENGTH_PCM_EXT;
	dm(Frmwk.->pack_length_pcm) = r0;
	
	r0 = PREDAC_LENGTH_PCM;
	dm(Frmwk.->predac_length_pcm) = r0;
	
	r0 = PREDAC_LENGTH_MCPCM;
	dm(Frmwk.->predac_length_mcpcm) = r0;
	
	r0 = PACK_LENGTH_MCPCM;
	dm(Frmwk.->pack_length_mcpcm) = r0;


	r0=24;
	dm(Frmwk.->No_of_DAC_channel) = r0;	
	r0 = NUMMAXCHAN;
	dm(Frmwk.->Max_No_of_DAC_channel) = r0;
	r0 = 0;
    dm(Frmwk.->Tx_ChSel) = r0;
    r0 = NO_OF_INPUT_CHANNEL;
    dm(Frmwk.->inputChannelConfig) = r0;
        	
	r0 = DEFAULT_FS;
	dm(Frmwk.->OutputSampleRate) = r0;
	dm(Frmwk.->sampling_fs_micro) = r0;	
	dm(Frmwk.->InitDoneForStreamType) = m7;			
	dm(Frmwk.->PrevOutputSampleRate) = m7;
	dm(Frmwk.->prev_sampling_fs_micro) = m7;
	dm(Frmwk.->prev_DS_sampling_fs_micro) = m7;	
	dm(Frmwk.->Tx->Latency_data) = m5;
	dm(Frmwk.->Tx->buf_zero_data) = m5;			
	dm(Frmwk.->IOP->datacanbeprocessednow) = m5;
	dm(Frmwk.->IOP->LatencyDone) = m5;
	r0 = INAUTOBUFSIZEBY2;
	dm(Frmwk.->Misc->Control->InAutobufsizeby2) = r0;	
	r0 = OUTAUTOBUFSIZEBY2;
	dm(Frmwk.->Misc->Control->OutAutobufsizeby2) = r0;
	
	r1 = Sample_Processing_PP; //64;
	dm(Frmwk.->SampleBlock) = r1;	
	dm(Frmwk.->IOP->DataValid) = m5;	
			
	/********************
	Auto Detection variables Init
	********************/
	r0 = SYNCSIGUNKNOWN;
	dm(Frmwk.->Autdet->MSGR4) = r0;								// stream unknown 
	dm(Frmwk.->Autdet->MSGR_Save) = r0;						
	r0 = 16384;
	dm(Frmwk.->SampleDropCount) = r0;	
	r0 = 384;
	dm(Frmwk.->Autdet->No_Of_DWords_In_Present_Burst) = r0;

	dm(Frmwk.->autodetect_mode) = m5;		
	l4 = 0;
	l13 = 0;
				
	r0 = 2;
	dm(Frmwk.->loop_offset) = r0;
	
	dm(Frmwk.->MemoryAllotMCLPCM) = m5;
	dm(Frmwk.->MemoryAllotPack) = m5;
	dm(Frmwk.->MemoryAllotDac) 	= m5;

	dm(Frmwk.->stop_flag) = m5;
	dm(Frmwk.->run_flag)= m5;		
	dm(Frmwk.->Autdet->autodetect3) = m5;	
	dm(Frmwk.->Misc->Control->ForcePcm) = m5;
	dm(Frmwk.->AutodetectMode_Enable) = m5;
	dm(Frmwk.->InitDoneForAutodetectMode) = m5;			
		 
	dm(Frmwk.->PrevAuDt_Enable) = m7;
	r0 = STREAM_TYPE_FORMUTE;
	dm(Frmwk.->Stream_Type_ForMUTE) = r0;		
	
	r0 = SIGNATURE_DEFAULT;
	dm(Frmwk.->Spi->INTR_DESC_LOCN) = r0;
	
    dm(Frmwk.->init_ds_processing) = m6;
	I_ACALL(unsaveforCEnv);
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.Init_Struct..END:
.endseg;
 
 /******************************************************************************
 *  Module Name        : PackUpdate
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
 .section/sw  Seg_Init_Struct_Code;
.global PackUpdate.;
.type PackUpdate., STT_FUNC;
PackUpdate.:
    dm(save_l4.) = l4;
	l4 = dm(Frmwk.->IOP->Pack->length);	
	b4 = dm(Frmwk.->IOP->Pack->heap);
	i4 = dm(Frmwk.->IOP->Pack->rd_ptr);
	
    r0 = dm(Frmwk.->IOP->Pack->lengthhalf);
	m4 = r0;
	
    modify(i4,m4)(nw);
	dm(Frmwk.->IOP->Pack->rd_ptr) = i4;
	
	l4  = dm(save_l4.);
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.PackUpdate..END:


.global Predac_Buffer_Int_To_Predac_Buffer_Ext.; 	//Single I2S
.type Predac_Buffer_Int_To_Predac_Buffer_Ext., STT_FUNC;
Predac_Buffer_Int_To_Predac_Buffer_Ext.:
	I_ACALL (saveforCEnv);	
	
	 l0 = BUFF_MAX_SIZE; b0 = Predac_buffer_Int.;
	 i0 = Predac_buffer_Int.;

	 l15 = dm(Frmwk.->IOP->Predac->length); b15 = dm(Frmwk.->IOP->Predac->heap);
	 i15 = dm(Frmwk.->IOP->Predac->wr_ptr);
	 	
	 r2 = dm(Frmwk.->SampleBlock);				
	 
	 m2=2;
	m12=m2;	
	
	 r0 = 2;
	 m2 = r0;
	 m12 = r0;
	 
	r3 = dm(TX_DAC_Output_Ch_Cnt.);
	r4 = 1;
	m3 = 16;
	m11 = 16;
	comp(r3,r4);
	if eq jump Ch_copy_16;
	 
	r4 = 2;
	m3 = 14;
	m11 = 14;
	comp(r3,r4);
	if eq jump Ch_copy_18;
	
	m3 = 8;     //24 ch
	m11 = 8;    //24 ch
	
Ch_copy_24:
	bit SET mode1 BITM_REGF_MODE1_PEYEN;
	nop; nop;
		
	lcntr = r2, do PredacInt_PredacExt_24 until lce;        
		 r0 = dm(i0,m2);
		 r1 = dm(i0,m2), pm(i15,m12) = r0;  // 1 2
		 r0 = dm(i0,m2), pm(i15,m12) = r1;  // 3 4    
		 r1 = dm(i0,m2), pm(i15,m12) = r0;  // 5 6		
		 r0 = dm(i0,m2), pm(i15,m12) = r1;  // 7 8	    	    
		 r1 = dm(i0,m2), pm(i15,m12) = r0;  // 9 10
		 r0 = dm(i0,m2), pm(i15,m12) = r1;  // 11 12	    
	     r1 = dm(i0,m2), pm(i15,m12) = r0;  // 13 14	
		 r0 = dm(i0,m2), pm(i15,m12) = r1;  // 15 16
		 r1 = dm(i0,m2), pm(i15,m12) = r0;	// 17 18
		 r0 = dm(i0,m2), pm(i15,m12) = r1;  // 19 20
	     r1 = dm(i0,m2), pm(i15,m12) = r0;  // 21 22 
		 				 pm(i15,m12) = r1;  // 23 24	
		modify(i15, m11)(nw);	
	PredacInt_PredacExt_24:modify(i0, m3)(nw); 	//skip remaining channels
    
     BIT clr MODE1 BITM_REGF_MODE1_PEYEN;
     nop; nop;
     jump Predaccpy_EXIT;
     
Ch_copy_18:
	bit SET mode1 BITM_REGF_MODE1_PEYEN;
	nop; nop;
		
	lcntr = r2, do PredacInt_PredacExt_18 until lce;        
		 r0 = dm(i0,m2);
		 r1 = dm(i0,m2), pm(i15,m12) = r0;  // 1 2
		 r0 = dm(i0,m2), pm(i15,m12) = r1;  // 3 4    
		 r1 = dm(i0,m2), pm(i15,m12) = r0;  // 5 6		
		 r0 = dm(i0,m2), pm(i15,m12) = r1;  // 7 8	    	    
		 r1 = dm(i0,m2), pm(i15,m12) = r0;  // 9 10
		 r0 = dm(i0,m2), pm(i15,m12) = r1;  // 11 12	    
	     r1 = dm(i0,m2), pm(i15,m12) = r0;  // 13 14	
		 r0 = dm(i0,m2), pm(i15,m12) = r1;  // 15 16
		  				 pm(i15,m12) = r0;	// 17 18	
		modify(i15, m11)(nw);	
	PredacInt_PredacExt_18:modify(i0, m3)(nw); 	//skip remaining channels
    
     BIT clr MODE1 BITM_REGF_MODE1_PEYEN;
     nop; nop;
     jump Predaccpy_EXIT;
		 
Ch_copy_16:
	bit SET mode1 BITM_REGF_MODE1_PEYEN;
	nop; nop;
		
	lcntr = r2, do PredacInt_PredacExt_16 until lce;        
		 r0 = dm(i0,m2);
		 r1 = dm(i0,m2), pm(i15,m12) = r0;  // 1 2
		 r0 = dm(i0,m2), pm(i15,m12) = r1;  // 3 4    
		 r1 = dm(i0,m2), pm(i15,m12) = r0;  // 5 6		
		 r0 = dm(i0,m2), pm(i15,m12) = r1;  // 7 8	    	    
		 r1 = dm(i0,m2), pm(i15,m12) = r0;  // 9 10
		 r0 = dm(i0,m2), pm(i15,m12) = r1;  // 11 12	    
	     r1 = dm(i0,m2), pm(i15,m12) = r0;  // 13 14	
		                 pm(i15,m12) = r1;  // 15 16	
		modify(i15, m11)(nw);	
	PredacInt_PredacExt_16:modify(i0, m3)(nw); 	//skip remaining channels
    
     BIT clr MODE1 BITM_REGF_MODE1_PEYEN;
     nop; nop;
	
Predaccpy_EXIT:			
	I_ACALL (unsaveforCEnv);
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;	
.Predac_Buffer_Int_To_Predac_Buffer_Ext..end:	

/******************************************************************************
*  Module Name        : Status_Update
*  Functionality      : System, decoder, post processing specific status is updated in status bytes.
						system specific - Run, Mute, sampling frequency status						
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/	

.global Status_Update.;
.type Status_Update., STT_FUNC;
Status_Update.:
	
	I_ACALL (saveforCEnv); 

	dm(Frmwk.->Spi->RESERVED_BYTE8) = r0;      // STATUS Byte 23 
	r1 = FORCEADC;
	r0 = dm(Frmwk.->autodetect_mode);
	comp(r0,r1);
	if eq jump Continue_StatusUpdate;

	r1 = FORCEPCM3;
	comp(r0,r1);
	if eq jump Continue_StatusUpdate;

	r1 = SYNCSIGUNKNOWN;
	r0 = dm(Frmwk.->StreamType);
	comp(r0,r1);
	if eq jump Status_UpdateLabelEnd;

	r1 = SYNCSIGPCMZERO;
	comp(r0,r1);
	if eq jump Status_UpdateLabelEnd;
	
Continue_StatusUpdate:	
#ifdef STATUS_UPDATE
	r1 = dm(Frmwk.->StreamType);
#endif	

	r0 = 0;	
	r1 = dm(Frmwk.->sampling_fs_micro);

	r0 = r0 or fdep r1 by 4:4;	
	dm(Frmwk.->Spi->STATUS_BYTE6) = r0;
 	
common_status:
	r1 = dm(Frmwk.->Spi->STATUS_BYTE1T); 
	r0 = 0xFF9F;
	r1 = r0 and r1;
	dm(Frmwk.->Spi->STATUS_BYTE1T) = r1;	
	r5 = dm(Frmwk.->StreamType);
	r0 = 0xFFFFFFE0;
	r1 = r1 and r0;
	r1 = r1 or r5;
	r0 = 0x8000; //status valid
	r1 = r1 or r0;	
	dm(Frmwk.->Spi->STATUS_BYTE1)=r1;
	
	r1 = dm(Frmwk.->Spi->STATUS_BYTE5T); // Update AAC Audio Coding Mode	
	r0 = dm(Frmwk.->Spi->STATUS_BYTE5);
	
	r2 = 0xFFE0;
	r0 = r2 and r0;

	r0 = r0 or fdep r1 by 0:4;
	dm(Frmwk.->Spi->STATUS_BYTE5)=r0;		

	r0 = dm(Frmwk.->Spi->STATUS_BYTE6);
	r2 = 0;
	r1 = dm(down_samp_flag.);
	r1 = pass r1;
	if eq jump DS_Straight_Sampling; 
	
	r2 = 2;     // 1/4 Downsampling
	r1 = 0;    //dm(DnSamp192to48.);
	r1 = pass r1;
	if eq r2 = m6;  //1/2 Downsampling
	  
DS_Straight_Sampling:
	r0 = bclr r0 by 8;
	r0 = bclr r0 by 9;
	r0 = r0 or fdep r2 by 8:2;  // Downsampling is updated in r2
	dm(Frmwk.->Spi->STATUS_BYTE6) = r0;
	
    r0 = 0;
	r1 = dm(Frmwk.->run_flag);
	r0 = r0 or fdep r1 by 0:1;
	
	r1 = dm(Frmwk.->mute_flag);
	r0 = r0 or fdep r1 by 1:1;
	
	dm(Frmwk.->Spi->STATUS_BYTE4)=r0;
	
 	//StatusByte14 update for PCM		
	r0 = dm(Frmwk.->StreamType);
	r1 = SYNCSIGPCM;
	comp(r0, r1);
	if eq jump PCMStatusByte14Update;
	
	r0 = dm(Frmwk.->autodetect_mode);		
	r1 = FORCEPCM3;
	comp(r0,r1);
	if ne jump no_PCM_update;
	
PCMStatusByte14Update:	
	r0 = 0x7FFF;
	dm(Frmwk.->Spi->STATUS_BYTE14) = r0;		
	no_PCM_update:
    I_ACALL (Status_Compare);
    
Status_UpdateLabelEnd:
     	
	I_ACALL (unsaveforCEnv);	
	i12 = dm(m7,i6);
    jump (m14,i12) (db); rframe; nop;
Status_Update..end:	
.endseg;


/******************************************************************************
*  Module Name        : Status_Compare
*  Functionality      : Update the new status values in status bytes if any status change happens, 
						this will be performed after every frame decoding & post processing
						if any decoder error happenes except (no error & error case), this will not be called
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/	

I_ALABEL_ALG_(Status_Compare)

Status_Compare_Autodetect:
	r1 = dm(Frmwk.->ADCEnable);				
	r1 = pass r1;
	if eq jump continueupdate1;
	
	r1 = 0x800f;
	dm(Frmwk.->Spi->STATUS_BYTE1) = r1;
	dm(Frmwk.->Spi->PREV_STATUS_BYTE1) = r1;
continueupdate1:

	r3 = SIGNATURE_STATUS_CHANGE;
	r0 = dm(Frmwk.->Spi->PREV_STATUS_BYTE1);
	r1 = dm(Frmwk.->Spi->STATUS_BYTE1);
	r2 = 0x001F;
	r0 = r0 and r2;
	r1 = r1 and r2;
	comp(r0,r1);		
	if eq jump No_Stream_Change;
	r3 = SIGNATURE_STREAM_STATUS_CHANGE;

No_Stream_Change:

	r4 = 0;	
	//Status_byte 1, 2 & 3 is compared with its corresponding previous status byte values and update the new values in its status bytes
	l0 = 0; l1 = 0;	
	i0 = Frmwk.->Spi->STATUS_BYTE1;
	i1 = Frmwk.->Spi->PREV_STATUS_BYTE1;
	
	lcntr = 3, do compare_status_bytesf3 until lce;
	r0 = dm(i1,0);
	r1 = dm(i0,1);	
	dm(i1,1) = r1;
	comp(r0,r1);
	if ne r4 = r4+1;
	compare_status_bytesf3:nop;		
	
	i0 = Frmwk.->Spi->STATUS_BYTE5;
	i1 = Frmwk.->Spi->PREV_STATUS_BYTE5;
	
	//Status_byte4 is specific to decoder. this byte is skipped in checking
	//Status_byte 5 to 16 and Reserved Status_byte1 to 5 is compared with its corresponding previous status byte values and update the new values in its status bytes
	lcntr = 17, do compare_status_bytesl12 until lce;
	r0 = dm(i1,0);
	r1 = dm(i0,1);	
	dm(i1,1) = r1;
	comp(r0,r1);
	if ne r4 = r4+1;
	compare_status_bytesl12:nop;		
		
	r4 = pass r4;
	if ne jump send_interrupt_statusc;
	
	r4 = SIGNATURE_STREAM_STATUS_CHANGE;
	comp(r3,r4);	
	if ne rts;

send_interrupt_statusc:

	r0 = dm(Frmwk.->Spi->INTR_DESC_LOCN);
	r4 = 0xFFCF;
	r0 = r0 and r4;
	r0 = r0 or r3;
	dm(Frmwk.->Spi->INTR_DESC_LOCN) = r0;
	
#ifdef TIMER_CHECK_ENABLE	
	r1 = dm(Timer_Interp_Flag.);        //Interrupt  UPDATION IN Interrupt Description 
	r0 = r0 or fdep r1 by 6:1;		
	dm(Frmwk.->Spi->INTR_DESC_LOCN) = r0;
#endif
	//after update all the status values in status bytes, DSP toggles Flag0 to HIGH to host micro interrupt
	I_ACALL (FLAG_TOGGLE_ROUTINE);	
	rts;
Status_Compare.END:

/******************************************************************************
*  Module Name        : Status_Comparison
*  Functionality      : Update the new status values in status bytes if any status change happens, 
*						this will be called irrespective of decoder process. since it updates the kernel specific status values
*						this will be called only when no special function command is issued						
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/	

.global Status_Comparison.; 	//Single I2S
.type Status_Comparison., STT_FUNC;
Status_Comparison.:
//I_ALABEL_ALG_(_Status_Comparison)

	dm(Frmwk.->Misc->Protect->save_creg) = r3;
	dm(Frmwk.->Misc->Protect->save_creg+(1*4)) = r5;	
/*	r1 = 1;
	r0 = dm(Frmwk.->Autdet->MSGR_Save);
	comp(r0,r1);
	if eq jump StatusInvalidEnd;
	
	jump StatusInvalid;  */  //status invalid bit clearing
	
Status_ComparisonLabelContinue:


	r1 = FORCEADC;					 
	r0 = dm(Frmwk.->autodetect_mode);
	comp(r0,r1);
	if eq jump StatusInvalidEnd;

	
	r1 = FORCEPCM3;
	comp(r0,r1);
	if eq jump StatusInvalidEnd;
	
	r1 = SYNCSIGUNKNOWN;
	r0 = dm(Frmwk.->Autdet->MSGR_Save);
	comp(r0,r1);
	if eq jump StatusInvalid;
	
	r1 = SYNCSIGPCMZERO;
	comp(r0,r1);
	if ne jump StatusInvalidEnd;
	
StatusInvalid:	
	r0 = dm(Frmwk.->Spi->STATUS_BYTE1);
	r3 = 0x7FFF;	
	r0 = r0 and r3;
	dm(Frmwk.->Spi->STATUS_BYTE1) = r0;	
	
StatusInvalidEnd:						

	r3 = SIGNATURE_STATUS_CHANGE;
	r0 = dm(Frmwk.->Spi->PREV_STATUS_BYTE1);
	r1 = dm(Frmwk.->Spi->STATUS_BYTE1);
	r2 = 0x001F;
	r0 = r0 and r2;
	r1 = r1 and r2;
	comp(r0,r1);		
	if eq jump No_Stream_ChangeA;
	r3 = SIGNATURE_STREAM_STATUS_CHANGE;

No_Stream_ChangeA:
    
	r5 = dm(Frmwk.->Autdet->HIGHTOLOWBRDOLBY);		
	r5 = pass r5;
	if eq jump notoutbufferfull;
	dm(Frmwk.->Misc->Control->OutBufferEmptyFlag) = m5;
			
notoutbufferfull:
	r5 = dm(Frmwk.->mute_flag);	
	r1 = 0;
	
 
 	r5 = r5 or r1;
	
	r5 = lshift r5 by 1;
	r2 = dm(Frmwk.->run_flag);
	r2 = r2 or r5;
	
	r1 = dm(Frmwk.->Autdet->SmallPause);			
    r2 = r2 or fdep r1 by 14:1;
	r1 = dm(Frmwk.->Autdet->LongPause);		
	r2 = r2 or fdep r1 by 15:1;	
	
    r1 = dm(Frmwk.->Spi->STATUS_BYTE4T);
    r2 = r1 or r2;
    
    dm(Frmwk.->Spi->STATUS_BYTE4) = r2;			/********/
    
    r1= 0xBFFF;
    r0= dm(Frmwk.->Spi->STATUS_BYTE1);
    r2 = r0;
    r0 = r1 and r0;
    dm(Frmwk.->Spi->STATUS_BYTE1) = r0;
    
    r4 = 0;

	r0 = dm(Frmwk.->Spi->PREV_STATUS_BYTE1);
	r1 = dm(Frmwk.->Spi->STATUS_BYTE1);
	dm(Frmwk.->Spi->PREV_STATUS_BYTE1) = r1;
	comp(r0,r1);
	if ne r4 = r4+1;

	r0 = dm(Frmwk.->Spi->PREV_STATUS_BYTE4);
	r1 = dm(Frmwk.->Spi->STATUS_BYTE4);
	dm(Frmwk.->Spi->PREV_STATUS_BYTE4) = r1;
	r2 = 0xffff; 
	r0 = r0 and r2;
	r1 = r1 and r2;
	comp(r1,r0);
	if ne r4 = r4+1;

	r4 = pass r4;
	if ne jump send_interrupt_status;
	
	r4 = SIGNATURE_STREAM_STATUS_CHANGE;
	comp(r3,r4);	
	if ne jump Status_Comparison_rtn;

send_interrupt_status:
	r0 = dm(Frmwk.->Spi->INTR_DESC_LOCN);
	r4 = 0xFFCF;
	r0 = r0 and r4;
	r0 = r0 or r3;
	dm(Frmwk.->Spi->INTR_DESC_LOCN) = r0;
	
	I_ACALL (FLAG_TOGGLE_ROUTINE);	

Status_Comparison_rtn:

	r3 = dm(Frmwk.->Misc->Protect->save_creg) ;
	r5 = dm(Frmwk.->Misc->Protect->save_creg+(1*4)) ;
			
	i12 = dm(m7,i6);
    jump (m14,i12) (db); rframe; nop;
Status_Comparison..end:


SendInitializationDone_asm:

	r0 = dm(Frmwk.->Spi->INTR_DESC_LOCN);
	r1 = SIGNATURE_ADI_BITS;
	r0 = r0 and r1;
	r1 = SIGNATURE_INITIALISATION_DONE;
	r0 = r0 or r1;
	dm(Frmwk.->Spi->INTR_DESC_LOCN) = r0;
	
	I_ACALL (FLAG_TOGGLE_ROUTINE); // Send IRQ to Host	
	rts;
	
/******************************************************************************
 *  Module Name        : Clear_Global_Interrupt
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/	
.global Clear_Global_Interrupt.;
.type Clear_Global_Interrupt., STT_FUNC;
Clear_Global_Interrupt.:

    bit clr MODE1 BITM_REGF_MODE1_IRPTEN;
	
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;	

.Clear_Global_Interrupt..end:

/******************************************************************************
 *  Module Name        : Clear_Interrupt
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.global Clear_Interrupt.;
.type Clear_Interrupt., STT_FUNC;
Clear_Interrupt.:
	bit clr MODE1 BITM_REGF_MODE1_IRPTEN;
	nop;nop;nop;nop;nop;nop;nop;
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.Clear_Interrupt..END:

/******************************************************************************
 *  Module Name        : Set_Global_Interrupt
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.global Set_Global_Interrupt.;
.type Set_Global_Interrupt., STT_FUNC;
Set_Global_Interrupt.:

    bit set MODE1 BITM_REGF_MODE1_IRPTEN;
 
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;	
	
.Set_Global_Interrupt..end:

/******************************************************************************
 *  Module Name        : SET_TIMER
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None		
 * It is an ASM function which will set timer period value to Maximum value (0x7FFFFFFF)
 * Then The count value is initialized with period value.
 * It enables the timer and count value starts to decrement during each cycle.
 *****************************************************************************/
 
.global SET_TIMER.;
.type SET_TIMER., STT_FUNC;
SET_TIMER.:

	TPERIOD = 0x7FFFFFFF;
	TCOUNT = TPERIOD;
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
	bit set MODE2 BITM_REGF_MODE2_TIMEN;
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
	nop;	
	
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.SET_TIMER..end:

/******************************************************************************
 *  Module Name        : CALCULATE_MIPS
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.global CALCULATE_MIPS.;
.type CALCULATE_MIPS., STT_FUNC;
CALCULATE_MIPS.:

	dm(save_i4.) = i4;
	
	i4 = r4;
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
	bit clr MODE2 BITM_REGF_MODE2_TIMEN;
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
	r0 = TPERIOD;
	r1 = TCOUNT;
	r1 = r0 - r1;
	r0 = dm(i4,m5);
	comp(r0,r1);
	if lt r0 = r1;
	dm(i4,m5) = r0; 

	TPERIOD = 0x7FFFFFFF;
	TCOUNT = TPERIOD;
	
	i4 = dm(save_i4.);
	i12 = dm(m7,i6);
jump (m14,i12) (db); rframe; nop;

.CALCULATE_MIPS..end: 

/******************************************************************************
 *  Module Name        : stop_timer
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.global stop_timer.;
.type stop_timer., STT_FUNC;
stop_timer.:

	dm(save_r0.) = r0;
	
	r0 = MODE2;
	dm(save_mode2.) = r0;
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
	bit clr MODE2 BITM_REGF_MODE2_TIMEN;
	nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;
	
    r0 = dm(save_r0.) ;

    rts;
    
.stop_timer..end: 

/******************************************************************************
 *  Module Name        : restart_timer
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.global restart_timer.;
.type restart_timer., STT_FUNC;
restart_timer.:

     dm(save_r0.) = r0;
     r0 = dm(save_mode2.);
     MODE2 = r0;
     r0 = dm(save_r0.);
     rts;

.restart_timer..end: 

/******************************************************************************
 *  Module Name        : fixtofloatConversion_Predacbuf
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/	
.global fixtofloatConversion_Predacbuf.;	
.type fixtofloatConversion_Predacbuf., STT_FUNC;			
fixtofloatConversion_Predacbuf.:
	//***********Fix to float conversion for Predac buffer *******
	I_ACALL (saveforCEnv);

	l1 = dm(Frmwk.->IOP->Predac->length);
	b1 = dm(Frmwk.->IOP->Predac->heap);
	i1 = dm(Frmwk.->IOP->Predac->wr_ptr);

	r1 = -31;	
	r0 = dm(Frmwk.->SampleBlock);
	
	lcntr = r0 , do Cpy2PreDacinFloat until lce;
 	r0 = dm(i1,m5);  
    f0 = float r0 by r1;
	dm(i1,m6) = f0;
	r0 = dm(i1,m5);  
	f0 = float r0 by r1;
	dm(i1,m6) = f0;
	r0 = dm(i1,m5);  
	f0 = float r0 by r1;
	dm(i1,m6) = f0;
	r0 = dm(i1,m5);  
	f0 = float r0 by r1;
	dm(i1,m6) = f0;
	r0 = dm(i1,m5);  
	f0 = float r0 by r1;
	dm(i1,m6) = f0;
	r0 = dm(i1,m5);  
	f0 = float r0 by r1;
	dm(i1,m6) = f0;
    r0 = dm(i1,m5);  
	f0 = float r0 by r1;
	dm(i1,m6) = f0;
	r0 = dm(i1,m5);  
	f0 = float r0 by r1;
	dm(i1,m6) = f0;
    Cpy2PreDacinFloat:modify(i1,24)(nw);       
	
	I_ACALL (unsaveforCEnv);
	i12 = dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
fixtofloatConversion_Predacbuf..END:


.endseg; 

  