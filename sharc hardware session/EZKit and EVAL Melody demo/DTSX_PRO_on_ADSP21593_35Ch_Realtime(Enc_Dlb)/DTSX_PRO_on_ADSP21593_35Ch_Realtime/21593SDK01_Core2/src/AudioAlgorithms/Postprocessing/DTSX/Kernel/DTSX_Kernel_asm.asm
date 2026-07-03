/*****************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :  	DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	DTSX_Kernel_asm.asm
*  Description      :   DTSX Decoder Postprocessing Kernel related assembly common 
*  				        function can be	included here
******************************************************************************/
 
#include "..\src\system\Include\Commn.h"
#include <asm_sprt.h>
#include <def21593.h>
.IMPORT "..\src\System\Include\Def_Struct.h";
#include <platform_include.h>

#ifdef DTSX_DECODER
.extern struct kernel Frmwk.;

.extern Add_Meta_Data_buffer.;
.extern Pack_buffer_Int.; 
.extern Predac_buffer_Int_c2.;
.extern	saveforCEnv;
.extern	unsaveforCEnv;
.extern ___BLOCK0_START;
.extern ___L2_CORE2_START;
.extern ___FFTBLOCK0ADDR;
.extern ___FFTBLOCK2ADDR;
.extern numchannels_c1_MCPCM.;
.extern DTSX_DecoderMask.;
.extern Predac_buffer_Int_Ptr.;

.segment/dm seg_dtsx_kernel_data_dm;
.var MODE1_save.;
//.var MODE2_save.;
.var InnerCount;
.var Pack_ext_ptr;
.global Pack_ext_ptr;
.global ChBlockNo.;
.var ChBlockNo.;
.var Pack_int_ptr;
.global Pack_int_ptr;
.var BlockZeroStartAddr. = ___BLOCK0_START;
.global BlockZeroStartAddr.;
.var FFT_DM_start. = (___FFTBLOCK0ADDR)/4;
.global FFT_DM_start.;
.var FFT_PM_start. = (___FFTBLOCK2ADDR)/4;
.global FFT_PM_start.;
.var fft_save_buff[5];
.var L2_core2StartAddr. = ___L2_CORE2_START;
.global L2_core2StartAddr.;
.endseg;
 
/******************************************************************************
*  Module Name        : COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON
*  Functionality      : Copying each samples from Internal Predac to 
						Internal Pack buffer (Interleaved to Block)
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/	
.section/sw seg_dtsx_kernal_code;
.global COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON.;
.type COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON., STT_FUNC;
COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON.:
entry;

	call saveforCEnv;
	r2 = dm(Frmwk.->SampleBlock);
	r1 = dm(Frmwk.->DTSX->DTSX_NumChannel);	
	r4 = 1;                     //Innerloop count 1,if ch is 16	
	r3 = 32 ;
	comp(r1,r3);
	if eq r4 = lshift r4 by 1;  //Innerloop count is 2, if ch is 32
	dm(InnerCount) = r4;         //Take backup of innerloop count
	r0 = r1*r2(SSI);
	
	l12 = r0; b12 = Pack_buffer_Int.;
	i12 = b12;
	
	l4 = DTSX_INTPREDAC_LEN;
	b4 = Predac_buffer_Int_c2.;
	i4 = Predac_buffer_Int_c2.; 
		
	b3 = b4; i3 = i4;
	l3 = l4;
	
	r0 = 32;
	r0 = r0 - r1;
	m4 = r0;	
	m12 = 256;
    r3 = 8;
    comp(r1,r3);
    if eq jump EightChCpy;        //if channel is 8 , jump to Eight channel copy routine
    
    r3 = dm(DTSX_DecoderMask.);
    r0 = 0x6; 	//LR
    comp(r3, r0);
    if eq jump CopyOnly16Channels;   
  
	lcntr = r2, do cpy_bufptr until lce;	 
	r4 = dm(InnerCount);        //Restore the innerloop count	
		lcntr = r4, do cpy_to_inbuf until lce; 
			r0 = dm(i3, m6);					// Ch In
			r1 = dm(i3, m6);
			r2 = dm(i3, m6);
			r3 = dm(i3, m6);
			
			r4 = dm(i3, m6);					// Ch In
			r5 = dm(i3, m6);
			r6 = dm(i3, m6);
			r7 = dm(i3, m6);
			
			r8 = dm(i3, m6);					// Ch In
			r9 = dm(i3, m6);
			r10 = dm(i3, m6);
			r11 = dm(i3, m6);
			
			r12 = dm(i3, m6);					// Ch In
			r13 = dm(i3, m6);
			r14 = dm(i3, m6);
			r15 = dm(i3, m6);
		    
		    pm(i12, m12) = r0;
		    pm(i12, m12) = r1;
		    pm(i12, m12) = r2;
		    pm(i12, m12) = r3;
		   
		    pm(i12, m12) = r4;
		    pm(i12, m12) = r5;
		    pm(i12, m12) = r6;
		    pm(i12, m12) = r7; 
			   
		    pm(i12, m12) = r8;
		    pm(i12, m12) = r9;
		    pm(i12, m12) = r10;
		    pm(i12, m12) = r11; 
		   
		    pm(i12, m12) = r12;
		    pm(i12, m12) = r13;
		    pm(i12, m12) = r14;
     	cpy_to_inbuf: pm(i12, m12) = r15;  // Ch Out
      	modify(i3, 4)(nw);
	cpy_bufptr: modify(i12, m14)(nw);	 
	 jump Pack_ptr_Update;
	
 EightChCpy:
	lcntr = r2, do Et_cpy_bufptr until lce;
		
		r0 = dm(i3, m6);					// Ch In
		r1 = dm(i3, m6);
		r2 = dm(i3, m6);
		r3 = dm(i3, m6);
		
		r4 = dm(i3, m6);					// Ch In
		r5 = dm(i3, m6);
		r6 = dm(i3, m6);
		r7 = dm(i3, m6);
		
		pm(i12, m12) = r0;
		pm(i12, m12) = r1;
		pm(i12, m12) = r2;
		pm(i12, m12) = r3;
		   
		pm(i12, m12) = r4;
		pm(i12, m12) = r5;
		pm(i12, m12) = r6;
		pm(i12, m12) = r7; 
			   
		modify(i3, m4)(nw);			   
	Et_cpy_bufptr: modify(i12, m14)(nw);

		jump Pack_ptr_Update;

CopyOnly16Channels:

	m4 = 16;
	r2 = dm(Frmwk.->SampleBlock);
	r1 = 16;
	r0 = r1*r2(SSI);
	l12 = r0;

	lcntr = r2, do cpy_chs_16 until lce;
		
		r0 = dm(i3, m6);					// Ch In
		r1 = dm(i3, m6);
		r2 = dm(i3, m6);
		r3 = dm(i3, m6);
		
		r4 = dm(i3, m6);					// Ch In
		r5 = dm(i3, m6);
		r6 = dm(i3, m6);
		r7 = dm(i3, m6);
		
		r8 = dm(i3, m6);					// Ch In
		r9 = dm(i3, m6);
		r10 = dm(i3, m6);
		r11 = dm(i3, m6);
		
		r12 = dm(i3, m6);					// Ch In
		r13 = dm(i3, m6);
		r14 = dm(i3, m6);
		r15 = dm(i3, m6);
	    
	    pm(i12, m12) = r0;
	    pm(i12, m12) = r1;
	    pm(i12, m12) = r2;
	    pm(i12, m12) = r3;
	   
	    pm(i12, m12) = r4;
	    pm(i12, m12) = r5;
	    pm(i12, m12) = r6;
	    pm(i12, m12) = r7; 
		   
	    pm(i12, m12) = r8;
	    pm(i12, m12) = r9;
	    pm(i12, m12) = r10;
	    pm(i12, m12) = r11; 
	   
	    pm(i12, m12) = r12;
	    pm(i12, m12) = r13;
	    pm(i12, m12) = r14;
	    pm(i12, m12) = r15;
			   
		modify(i3, m4)(nw);	 
			   
	cpy_chs_16: modify(i12, m14)(nw);
        
Pack_ptr_Update:i4 = dm(Frmwk.->IOP->Pack->rd_ptr_c2);
	call unsaveforCEnv;
	i12=dm(m7,i6);
	jump (m14,i12) (db); 
	rframe; nop;
.COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON..end:
/******************************************************************************
 *  Module Name        : COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_MCPCM
 *  Functionality      : Copying each samples from Internal Predac to 
						Internal Pack buffer (Interleaved to Block)
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_MCPCM.;
.type COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_MCPCM., STT_FUNC;
COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_MCPCM.:
entry;

	call saveforCEnv;
	r2 = dm(Frmwk.->SampleBlock);
	r1 = dm(Frmwk.->DTSX->DTSX_NumChannel);	
	r4 = 1;                     //Innerloop count 1,if ch is 16	
	r3 = 32 ;
	comp(r1,r3);
	if eq r4 = lshift r4 by 1;  //Innerloop count is 2, if ch is 32
	dm(InnerCount) = r4;         //Take backup of innerloop count
	r0 = r1*r2(SSI);
	
	l12 = r0; b12 = Pack_buffer_Int.;
	i12 = b12;
	
	l4 = DTSX_INTPREDAC_LEN;//dm(Frmwk.->IOP->Predac->length); //b12 = Frmwk.->IOP->Pack->heap;
	b4 = Predac_buffer_Int_c2.;//pm( Frmwk.->IOP->Predac->heap) ;
	i4 = Predac_buffer_Int_c2.;//pm(Frmwk.->IOP->Predac->rd_ptr_c2);
	
	b3 = b4; i3 = i4;
	l3 = l4;	
	r0 = 32;
	r0 = r0 - r1;
	m4 = r0;
	
	m12 = 256;
    r3 = 8;
    comp(r1,r3);
    if eq jump EightChCpy1;        //if channel is 8 , jump to Eight channel copy routine
    
    r3 = dm(DTSX_DecoderMask.);
    r0 = 0x6; 	//LR
    comp(r3, r0);
    if eq jump CopyOnly16Channels1; 
  
	lcntr = r2, do cpy_bufptr1 until lce;	
		r4 = dm(InnerCount);        //Restore the innerloop count	
			lcntr = r4, do cpy_to_inbuf2 until lce; 
				r0 = dm(i3, m6);					// Ch In
				r1 = dm(i3, m6);
				r2 = dm(i3, m6);
				r3 = dm(i3, m6);
				
				r4 = dm(i3, m6);					// Ch In
				r5 = dm(i3, m6);
				r6 = dm(i3, m6);
				r7 = dm(i3, m6);
				
				r8=5;
				r9=dm(numchannels_c1_MCPCM.);
				
				comp(r8,r9);			
				if ge jump copy_twochannel;	
			    
			    pm(i12, m12) = r2;
			    pm(i12, m12) = r0;
			    pm(i12, m12) = r1;
			    pm(i12, m12) = r4; 
			   
			    pm(i12, m12) = r5;
			    pm(i12, m12) = r3;
			    pm(i12, m12) = r6;
			    pm(i12, m12) = r7; 
			    
			    jump normal_copy;		    
		    
copy_twochannel:
 
		    pm(i12, m12) = r0;
		    pm(i12, m12) = r1;
		    pm(i12, m12) = r2;
		    pm(i12, m12) = r3;
		   
		    pm(i12, m12) = r4;
		    pm(i12, m12) = r5;
		    pm(i12, m12) = r6;
		    pm(i12, m12) = r7; 
				    
normal_copy:	    
			r8 = dm(i3, m6);					// Ch In
			r9 = dm(i3, m6);
			r10 = dm(i3, m6);
			r11 = dm(i3, m6);
			
			r12 = dm(i3, m6);					// Ch In
			r13 = dm(i3, m6);
			r14 = dm(i3, m6);
			r15 = dm(i3, m6);
			   
		    pm(i12, m12) = r8;
		    pm(i12, m12) = r9;
		    pm(i12, m12) = r10;
		    pm(i12, m12) = r11; 
		   
		    pm(i12, m12) = r12;
		    pm(i12, m12) = r13;
		    pm(i12, m12) = r14;
     	cpy_to_inbuf2: pm(i12, m12) = r15;  // Ch Out
     	 modify(i3, 4)(nw);
	cpy_bufptr1: modify(i12, m14)(nw);
	 
	 jump Pack_ptr_Update;
	
 EightChCpy1:
	lcntr = r2, do Et_cpy_bufptr1 until lce;
	
		r0 = dm(i3, m6);					// Ch In
		r1 = dm(i3, m6);
		r2 = dm(i3, m6);
		r3 = dm(i3, m6);
		
		r4 = dm(i3, m6);					// Ch In
		r5 = dm(i3, m6);
		r6 = dm(i3, m6);
		r7 = dm(i3, m6);
		
		pm(i12, m12) = r0;
		pm(i12, m12) = r1;
		pm(i12, m12) = r2;
		pm(i12, m12) = r3;
		   
		pm(i12, m12) = r4;
		pm(i12, m12) = r5;
		pm(i12, m12) = r6;
		pm(i12, m12) = r7; 
			   
		modify(i3, m4)(nw);	 
		   
	Et_cpy_bufptr1: modify(i12, m14)(nw);

		jump Pack_ptr_Update;

CopyOnly16Channels1:

	m4 = 16;
	r2 = dm(Frmwk.->SampleBlock);
	r1 = 16;
	r0 = r1*r2(SSI);
	l12 = r0;

	lcntr = r2, do cpy_chs_161 until lce;
		
		r0 = dm(i3, m6);					// Ch In
		r1 = dm(i3, m6);
		r2 = dm(i3, m6);
		r3 = dm(i3, m6);
		
		r4 = dm(i3, m6);					// Ch In
		r5 = dm(i3, m6);
		r6 = dm(i3, m6);
		r7 = dm(i3, m6);
		
		r8 = dm(i3, m6);					// Ch In
		r9 = dm(i3, m6);
		r10 = dm(i3, m6);
		r11 = dm(i3, m6);
		
		r12 = dm(i3, m6);					// Ch In
		r13 = dm(i3, m6);
		r14 = dm(i3, m6);
		r15 = dm(i3, m6);
	    
	    pm(i12, m12) = r0;
	    pm(i12, m12) = r1;
	    pm(i12, m12) = r2;
	    pm(i12, m12) = r3;
	   
	    pm(i12, m12) = r4;
	    pm(i12, m12) = r5;
	    pm(i12, m12) = r6;
	    pm(i12, m12) = r7; 
		   
	    pm(i12, m12) = r8;
	    pm(i12, m12) = r9;
	    pm(i12, m12) = r10;
	    pm(i12, m12) = r11; 
	   
	    pm(i12, m12) = r12;
	    pm(i12, m12) = r13;
	    pm(i12, m12) = r14;
	    pm(i12, m12) = r15;
			   
		modify(i3, m4)(nw);	 
			   
	cpy_chs_161: modify(i12, m14)(nw);
        
Pack_ptr_Update1:i4 = dm(Frmwk.->IOP->Pack->rd_ptr_c2);

	call unsaveforCEnv;
	i12=dm(m7,i6);
	jump (m14,i12) (db); 
	rframe; nop;
.COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_MCPCM..end:
/******************************************************************************
 *  Module Name        : COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_OPTI
 *  Functionality      : Copying each samples from Internal Predac to 
						 Internal Pack buffer (Block to Block)
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_OPTI.;
.type COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_OPTI., STT_FUNC;
COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_OPTI.:
entry;
	call saveforCEnv;
	r2 = dm(Frmwk.->SampleBlock);
	r1 = dm(Frmwk.->DTSX->DTSX_NumChannel);	
	r0 = r1*r2(SSI);
	
	l12 = r0; b12 = Pack_buffer_Int.;
	i12 = b12;
		
	l4 = DTSX_INTPREDAC_LEN;
	b4 = Predac_buffer_Int_c2.;
	i4 = Predac_buffer_Int_c2.;
	
	b3 = b4; i3 = i4;
	l3 = l4;
	r2 = lshift r2 by -1;
	bit set mode1 BITM_REGF_MODE1_PEYEN;
    nop;
	nop;    
	lcntr = r1, do cpy_channel until lce;     //channel
	  	lcntr = r2, do cpy_sample until lce;  //sample
              r0 = dm(i3, 2);
  		cpy_sample: pm(i12, 2) = r0;
  	cpy_channel:nop;     
         
    bit clr mode1 BITM_REGF_MODE1_PEYEN;
    nop;
	nop;     
	call unsaveforCEnv;

	i12=dm(m7,i6);
	jump (m14,i12) (db); 
	rframe; nop;
.COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_OPTI..end:

/******************************************************************************
 *  Module Name        : SHIFTPREDACINT_MCPCM
 *  Functionality      : Shift DTSX decoder + Postprocessing output data by 8 bit
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global SHIFTPREDACINT_MCPCM.;
.type SHIFTPREDACINT_MCPCM., STT_FUNC;
SHIFTPREDACINT_MCPCM.:
entry;

	call saveforCEnv;	
	
	l12 = r8;
	b12 = r4;
	i12 = b12;  
    
    bit set mode1 BITM_REGF_MODE1_PEYEN;
    nop;
	nop; 
    
	lcntr = r12, do shift_predac until lce;  //4096 - 16ch(Max Channel)*256,Because of SIMD loop count is 4096/2
		r0 = pm(i12, m13);
		r0 = lshift r0 by 8;
	shift_predac:pm(i12, 2) = r0;
	 
	bit clr mode1 BITM_REGF_MODE1_PEYEN;
    nop;
	nop; 
	 
	call unsaveforCEnv;	
     i12=dm(m7,i6);
    jump (m14,i12) (db); 
	rframe; nop;
.SHIFTPREDACINT_MCPCM..end:

/******************************************************************************
 *  Module Name        : addpredac_rd_ptr_dtsx_update
 *  Functionality      : Addpredac read pointer update
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global addpredac_rd_ptr_dtsx_update.;
.type addpredac_rd_ptr_dtsx_update., STT_FUNC;
addpredac_rd_ptr_dtsx_update.:
	
	call saveforCEnv;
	   /*--------------------------------------*/     
	l1 = dm(Frmwk.->IOP->AddPreDac->length);
	b1 = dm(Frmwk.->IOP->AddPreDac->heap); 
	i1 = dm(Frmwk.->IOP->AddPreDac->rd_ptr_c2);       		
	
	r0 = dm(Frmwk.->IOP->AddPreDac->lengthhalf);
	m2=r0;  	
	
	modify(i1,m2)(nw);
	dm(Frmwk.->IOP->AddPreDac->rd_ptr_c2) = i1;	
	
	call unsaveforCEnv;
	nop;
	nop;
	
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;

.addpredac_rd_ptr_dtsx_update..end:


/******************************************************************************
 *  Module Name        : COPYPREDACTO_EXTPREDAC_MCPCM_DTSX
 *  Functionality      : Copying DTSX Decoder + PP Output each samples  to 
						 Internal Predac buffer (Block to Interleaved)
 *  Input Parameters   : Predac_buffer_Int_Ptr
 *  Output Parameters  : None
 ******************************************************************************/
.global COPYPREDACTO_EXTPREDAC_MCPCM_DTSX.;
.type COPYPREDACTO_EXTPREDAC_MCPCM_DTSX., STT_FUNC;
COPYPREDACTO_EXTPREDAC_MCPCM_DTSX.:
entry ;
	call saveforCEnv;
	b12 = r4; 
	i12 = b12;
	l12 = DTSXINTPREDACSIZE; m12 = 1;
	
	b4 = Predac_buffer_Int_c2.; 
	i4 = Predac_buffer_Int_c2.;
	l4 = BUFF_MAX_SIZE; 
	m4 = 36;
	
	i1 = i12; 
	i2 = i4;   
	 
	r2 = dm(Frmwk.->SampleBlock); 
	
	/********** This function is to make memset for core2 internal predac buffer ************/
	r1 = 0;
	
	r0 = BUFF_MAX_SIZE;	
	lcntr = r0, do mem_zero_predacint_c2 until lce;
	mem_zero_predacint_c2: dm(i4,1) = r1;
 
	/******************************* memset end ******************************/	
		
	lcntr = 32 , do No_Channel until lce;    //Channnel	    
		lcntr = r2, do No_Samples until lce; //Sample
			r0 = pm(i12,m12);
		 No_Samples: dm(i4,m4) = r0;
		 modify(i2,1)(nw);		
	No_Channel:i4 = i2;
	
	call unsaveforCEnv;	
    i12=dm(m7,i6);
    jump (m14,i12) (db); 
	rframe; nop;
.COPYPREDACTO_EXTPREDAC_MCPCM_DTSX..end: 

#ifdef TRUBASS
/******************************************************************************
 *  Module Name        : FixToFloatTruBass
 *  Functionality      : Convert DTSX Decoder output to floating point for 
 *			 trubass processing
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.segment/sw seg_trubass_kernal_code;
.global FixToFloatTruBass.;	
.type FixToFloatTruBass., STT_FUNC;			
FixToFloatTruBass.:
	
	CALL (saveforCEnv);
	
	l1 = r4; 
	b1 = dm(Predac_buffer_Int_Ptr.);
	i1 = dm(Predac_buffer_Int_Ptr.);
	
	r1 = -31;	
	
	lcntr = r4 , do FixToFloat until lce;
 		r0 = dm(i1, m5);  
	    f0 = float r0 by r1;
    FixToFloat: dm(i1, m6) = f0;       
	
	CALL (unsaveforCEnv);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
FixToFloatTruBass..END:

/******************************************************************************
 *  Module Name        : FloatToFixTruBass
 *  Functionality      : Convert Trubass output to fixed point.
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global FloatToFixTruBass.;
.type FloatToFixTruBass., STT_FUNC;
FloatToFixTruBass.:	
					
    CALL (saveforCEnv);

	l1 = r4; 
	b1 = dm(Predac_buffer_Int_Ptr.);
	i1 = dm(Predac_buffer_Int_Ptr.);
	
	r1 = 31;
	 
	lcntr = r4 , do FloatToFix until lce;
	 		f0 = dm(i1, m5);  
	        r0 = fix f0 by r1;
		   
    FloatToFix: dm(i1, m6) = r0; 
    
    CALL (unsaveforCEnv);
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;                      
		
FloatToFixTruBass..END:
.endseg;
#endif //TRUBASS

/******************************************************************************
 *  Module Name        : ENABLE_TIMER
 *  Functionality      : Enables timer routine
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.segment/sw seg_dtsx_kernal_code;
.global ENABLE_TIMER.;
.type ENABLE_TIMER., STT_FUNC;
ENABLE_TIMER.:
entry;

#ifdef __ADI_GENERATED_DEF_HEADERS__
	bit set mode2 BITM_REGF_MODE2_TIMEN;
	nop;
#else
	bit set mode2 TIMEN;
	nop;
#endif //__ADI_GENERATED_DEF_HEADERS__     

	i12=dm(m7,i6);
	jump (m14,i12) (db); 
	rframe; nop;
	
.ENABLE_TIMER..end:

/******************************************************************************
 *  Module Name        : DISABLE_TIMER
 *  Functionality      : Disables timer routine
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global DISABLE_TIMER.;
.type DISABLE_TIMER., STT_FUNC;
DISABLE_TIMER.:
entry;

#ifdef __ADI_GENERATED_DEF_HEADERS__
	bit clr mode2 BITM_REGF_MODE2_TIMEN;
	nop;
#else
	bit clr mode2 TIMEN;
	nop;
#endif //__ADI_GENERATED_DEF_HEADERS__ 

	i12 = dm(m7,i6);
	jump (m14,i12) (db); 
	rframe; nop;
	
.DISABLE_TIMER..end:

/******************************************************************************
 *  Module Name        : CALCULATE_MCPS
 *  Functionality      : MIPS calculation based on cycle count
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global CALCULATE_MCPS.;
.type CALCULATE_MCPS., STT_FUNC;
CALCULATE_MCPS.:
entry;

#ifdef __ADI_GENERATED_DEF_HEADERS__
	bit clr mode2 BITM_REGF_MODE2_TIMEN;
	nop;
#else
	bit clr mode2 TIMEN;
	nop;
#endif //__ADI_GENERATED_DEF_HEADERS__
        
	r0 = TPERIOD;
	r1 = TCOUNT;
	r1 = r0 - r1;
	/*r0 = dm(Peak_Cycles.);
	comp(r0,r1);
	if lt r0 = r1;
	dm(Peak_Cycles.) = r0;*/
	TPERIOD = 0x7FFFFFFF;
	TCOUNT = TPERIOD;
        
	i12 = dm(m7,i6);
	jump (m14,i12) (db); 
	rframe; nop;
	
.CALCULATE_MCPS..end:

/******************************************************************************
 *  Module Name        : MODE_SAVE_DTSX
 *  Functionality      : Mode registers saved for DTSX Decoder
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global MODE_SAVE_DTSX.;
.type MODE_SAVE_DTSX.,STT_FUNC;
MODE_SAVE_DTSX.:
entry;
	
	dm(MODE1_save.) = MODE1;

	bit clr MODE1 0x2000;	//Clr ALUSAT
	nop;nop;

	bit set MODE1 0x10000;		//Set Rnd32
	nop;nop;
	
	//dm(MODE2_save.) = MODE2;

	//bit set MODE2 0x80;		//set btb bitset
	//nop;nop;
	
	i12=dm(m7,i6);
	jump (m14,i12) (db); 
	rframe; nop;
	
.MODE_SAVE_DTSX..END:
/******************************************************************************
 *  Module Name        : MODE_CLR_DTSX
 *  Functionality      : Mode registers unsaved for DTSX Decoder
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global MODE_CLR_DTSX.;
.type MODE_CLR_DTSX.,STT_FUNC;
MODE_CLR_DTSX.:
entry;
	
	//bit clr MODE2 0x80;		//Clr btb bitset
	//nop;nop;

	bit clr MODE1 0x10000;		//Clr Rnd32
	nop;nop;

	bit set MODE1 0x2000;		//Set ALUSAT
	nop;nop;

	MODE1 = dm(MODE1_save.);
	//MODE2 = dm(MODE2_save.);
	
	i12=dm(m7,i6);
	jump (m14,i12) (db); 
	rframe; nop;
	
.MODE_CLR_DTSX..END:

/******************************************************************************
 *  Module Name        : STIMER_DTSX
 *  Functionality      : Enables Timer routine
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global STIMER_DTSX.;
.type STIMER_DTSX.,STT_FUNC;
STIMER_DTSX.:
entry;
	TPERIOD = 0x7FFFFFFF;
	TCOUNT = TPERIOD;
#ifdef __ADI_GENERATED_DEF_HEADERS__
	bit set mode2 BITM_REGF_MODE2_TIMEN;
#else
	bit set mode2 TIMEN;
#endif
	
	i12=dm(m7,i6);
	jump (m14,i12) (db);
	rframe; nop;
	
.STIMER_DTSX..END:
/******************************************************************************
 *  Module Name        : STIMER_DTSX
 *  Functionality      : Disables Timer routine
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
/* Calculate MIPS */
.global ETIMER_DTSX.;
.type ETIMER_DTSX.,STT_FUNC;
ETIMER_DTSX.:
entry;
#ifdef __ADI_GENERATED_DEF_HEADERS__
	bit clr mode2 BITM_REGF_MODE2_TIMEN;
#else
   	bit clr mode2 TIMEN;
#endif
	r0 = TPERIOD;
	r1 = TCOUNT;
	r0 = r0 - r1;
	/*r0 = dm(Peak_Cycles.);
	comp(r0,r1);
	if lt r0 = r1;
	dm(Peak_Cycles.) = r0;*/
	TPERIOD = 0x7FFFFFFF;
	TCOUNT = TPERIOD;	

	i12=dm(m7,i6);
	jump (m14,i12) (db); 
	rframe; nop;
	
.ETIMER_DTSX..END: 

/******************************************************************************
 *  Module Name        : get_fft_ptr1
 *  Functionality      : internal memory assignment for FFT pointers used
 *			 inside library
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global get_fft_ptr1.;	
.type get_fft_ptr1., STT_FUNC;			
get_fft_ptr1.:
entry;

	dm(fft_save_buff)   = r2;

    r2 = 0xFF;
search_256_1:
    r0= r4 and r2;
    r0 = pass r0;
    if eq jump end_1;
    r4= r4 + 1;
    jump search_256_1;
    
 end_1:
 	r0 = r4;

	r2 = dm(fft_save_buff);

 	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.get_fft_ptr1..end:

.endseg;

#endif  //DTSX_DECODER
