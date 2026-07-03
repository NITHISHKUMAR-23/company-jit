/*****************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :  	DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	DTSX_Kernel_asm.asm
*  Description      :   DTSX Decoder Kernel related assembly common 
*  				        function can be	included here
******************************************************************************/
 
#include "..\src\system\Include\Commn.h"
#include <asm_sprt.h>
#include <def21593.h>
.IMPORT "..\src\System\Include\Def_Struct.h";

#ifdef DTSX_DECODER
.segment/bw seg_dtsx_kernal_data;
#ifndef PTR_AS_BUFFER
.var Int_Block0_start_addr. = ___BLOCK0_START;
.global Int_Block0_start_addr.;
.var L2_Core1data_start_addr. = ___L2_CORE1_START;
.global L2_Core1data_start_addr.;
#endif //PTR_AS_BUFFER
.endseg;

.section/DM  seg_dtsx_kernel_data_dm;
.var MODE1_save.;
.var MODE2_save.;
.endseg;

.extern struct kernel Frmwk.;
.extern Pack_buffer_Int.;
.extern Predac_buffer_Int.;
.extern Predac_buffer_Ext.;
.extern Predac_int_ptr_dtsx.;
.extern	saveforCEnv;
.extern	unsaveforCEnv;
.extern ___BLOCK0_START;
.extern ___L2_CORE1_START;

/******************************************************************************
 *  Module Name        : update_pack_rd_ptr
 *  Functionality      : Pack read pointer will get updated here
 *  Input Parameters   : r4 - Frmwk.IOP.Pack.rd_ptr
 *  Output Parameters  : None
 ******************************************************************************/	
.segment/sw seg_dtsx_kernal_code;
.global update_pack_rd_ptr.;
.type update_pack_rd_ptr., STT_FUNC;
#define SAMPLEBLOCK		256
update_pack_rd_ptr.:

	call saveforCEnv;
	m0 = r4;
	b0 = dm(Frmwk.->IOP->Pack->heap);
	i0 = dm(Frmwk.->IOP->Pack->rd_ptr);
	l0 = dm(Frmwk.->IOP->Pack->length);
	modify(i0,m0)(nw);
	dm(Frmwk.->IOP->Pack->rd_ptr)=i0;
	l0=0;
	call unsaveforCEnv;
	nop;
	nop;
	
	i12 = dm(m7,i6);
	jump (m14,i12)(db);
	rframe;
	nop;	
.update_pack_rd_ptr..end:

/******************************************************************************
 *  Module Name        : COPYEXTPACKTO_INTPACK_DTSX
 *  Functionality      : Copy DTSX input data from External Pack to Internal pack
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global COPYEXTPACKTO_INTPACK_DTSX.;
.type COPYEXTPACKTO_INTPACK_DTSX., STT_FUNC;
COPYEXTPACKTO_INTPACK_DTSX.:
	call saveforCEnv;	
	l0 = dm(Frmwk.->IOP->Pack->lengthhalf); b0 = Pack_buffer_Int.;
	i0 = b0;
	
	l1 = dm(Frmwk.->IOP->Pack->length); 
	b1 = dm(Frmwk.->IOP->Pack->heap);   
	i1 = dm(Frmwk.->IOP->Pack->rd_ptr); 
	m0 = 2;
		
	r10 = dm(Frmwk.->IOP->Pack->lengthhalf);
	r10 = lshift r10 by -4;	
	lcntr = r10, do cpy_ExtPack_to_IntPack_DTSX until lce;
	    r0 = dm(i1,m6);r1 = dm(i1,m6);	
	    r2 = dm(i1,m6);r3 = dm(i1,m6);	
	    r4 = dm(i1,m6);r5 = dm(i1,m6);
	    r6 = dm(i1,m6);r7 = dm(i1,m6);	
	    r8 = dm(i1,m6);r9 = dm(i1,m6);	
	    r10 = dm(i1,m6);r11 = dm(i1,m6);	
	    r12 = dm(i1,m6);r13 = dm(i1,m6);
	    r14 = dm(i1,m6);r15 = dm(i1,m6);
	    
	    dm(i0,m6) = r0;dm(i0,m6) = r1;
	    dm(i0,m6) = r2;dm(i0,m6) = r3;
	    dm(i0,m6) = r4;dm(i0,m6) = r5;
	    dm(i0,m6) = r6;dm(i0,m6) = r7;
	    dm(i0,m6) = r8;dm(i0,m6) = r9;
	    dm(i0,m6) = r10;dm(i0,m6) = r11;
	    dm(i0,m6) = r12;dm(i0,m6) = r13;
	    dm(i0,m6) = r14;		
	cpy_ExtPack_to_IntPack_DTSX: dm(i0,m6) = r15;
	call unsaveforCEnv;
	nop;
	nop;

	i12 = dm(m7,i6);
	jump (m14,i12)(db);
	rframe;
	nop;
.COPYEXTPACKTO_INTPACK_DTSX..end:

/******************************************************************************
 *  Module Name        : ConvertBlock2Interleaved_2PredacExt
 *  Functionality      : Convert block based to interleaved format
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global ConvertBlock2Interleaved_2PredacExt.;
.type ConvertBlock2Interleaved_2PredacExt., STT_FUNC;
ConvertBlock2Interleaved_2PredacExt.:    
	call saveforCEnv;
	b5 = Predac_buffer_Ext.; i5 = dm(Frmwk.->IOP->Predac->wr_ptr);
	l5 = dm(Frmwk.->IOP->Predac->length);	
	i2 = r4; //pPCMout buffer
	l2 = 0;
	
	b3 = Predac_buffer_Ext.; //External Predac Heap
	l3 = dm(Frmwk.->IOP->Predac->length);
	
	l1 = 0;		
	r10 = dm(Frmwk.->SampleBlock);
	
	r0 = 36;//dm(Frmwk.->Number_Of_Channels);	
	m1 = r10;
	m2 = r0;	
	i3 = i5;  //take backup of op buffer
	r10 = lshift r10 by -3; //divided by 8
	
	lcntr = r0, do update_ch_ptr until lce;  //channel count
		r4 = dm (i2,m6);
		r4 = pass r4;
		if eq jump update_ch_ptr;
        i1 = r4;
        
		lcntr = r10, do pPCM2PredacExt until lce;  //sample count

		/******* copying 16 channels********/
	
			r0 = dm(i1,m6);	//sample block size jump
			r1 = dm(i1,m6);	
			r2 = dm(i1,m6);	
			r3 = dm(i1,m6);	
			
			r4 = dm(i1,m6);	
			r5 = dm(i1,m6);	
			r6 = dm(i1,m6);	
			r7 = dm(i1,m6);
			
			dm(i5,m2) = r0;	//Out
			dm(i5,m2) = r1;	
			dm(i5,m2) = r2;	
			dm(i5,m2) = r3;	
			
			dm(i5,m2) = r4;	
			dm(i5,m2) = r5;	
			dm(i5,m2) = r6;	
		pPCM2PredacExt: dm(i5,m2) = r7;	
		modify(i3, m6)(nw);	
		i5 = i3;	
 	update_ch_ptr: nop;
	
final:nop;	
	call unsaveforCEnv;
	nop;
	nop;
	
	i12 = dm(m7,i6);
	jump (m14,i12)(db);
	rframe;
	nop;	
.ConvertBlock2Interleaved_2PredacExt..end:
/*************************************************************************************************
 *  Module Name        : Change_Block_copy_for_96and192Khz
 *  Functionality      : Changing and copying the 192 and 96KHZ block size data to 256 block size 
 *  Input Parameters   : None
 *  Output Parameters  : None
 *************************************************************************************************/
.global Change_Block_copy_for_96and192Khz.;
.type Change_Block_copy_for_96and192Khz., STT_FUNC;
Change_Block_copy_for_96and192Khz.: 
	Call saveforCEnv;
    b5 = Predac_buffer_Ext.; i5 = dm(Frmwk.->IOP->Predac->wr_ptr); 
    l5 = dm(Frmwk.->IOP->Predac->length);

	i2 = r4; //pPCMout buffer 
	l2 = 0;	
	i3 = r4;
	l3 = 0;
    r0  = dm(Frmwk.->Number_Of_Channels);
    r2  = dm(Frmwk.->SampleBlock);
       
    m1 = 0;
    r1 = 256;
    m2 = r1;
    r8 = 0;
    r2 = lshift r2 by -8; //(sampleblock/256) to know frequency of stream
       
    lcntr = r2, do copy_based_on_fs until lce;       		            
	    lcntr = 36, do copy_based_on_channel_count until lce;	    	
	    		r4 = dm(i2,m6);
	    		m2 = r1;
	    		r4 = pass r4;
	    		if eq jump no_copy;	    		
    			i1 = r4;
    			m2 = 0;
   				modify(i1,m1)(nw);       			
		    	lcntr = r1, do sample_copy until lce;		    		
		    		r4=dm(i1,m6);		    					
		    	sample_copy:dm(i5,m6)=r4;		    		
	    		no_copy: modify(i5,m2)(nw);	    		 
    	copy_based_on_channel_count: nop;	    	
	    	r8 = r8 + r1;
	    	m1 = r8;
	    	i2=i3;	    	    		    	
	copy_based_on_fs: nop;		
    
    Call unsaveforCEnv;
	nop;
	nop;    
    i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop; 
.Change_Block_copy_for_96and192Khz..end:
/******************************************************************************
 *  Module Name        : PredacPtrUpdate_DTSX
 *  Functionality      : Predac write pointer will be updated here
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global PredacPtrUpdate_DTSX.;
.type PredacPtrUpdate_DTSX., STT_FUNC;
PredacPtrUpdate_DTSX.:
	call saveforCEnv;
	/*--------------------------------------*/     
	l1 = dm(Frmwk.->IOP->Predac->length);
	b1 = dm(Frmwk.->IOP->Predac->heap);
	i1 = dm(Frmwk.->IOP->Predac->wr_ptr); 		
	
	r0 = dm(Frmwk.->IOP->Predac->lengthhalf);
	m2=r0;  		   	
	modify(i1,m2)(nw);
	dm(Frmwk.->IOP->Predac->wr_ptr) = i1;			
	call unsaveforCEnv;
	nop;
	nop;		
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;	
.PredacPtrUpdate_DTSX..END:	

/******************************************************************************
 *  Module Name        : SHIFTPREDACINT_MCPCM
 *  Functionality      : Shift DTSX decoder output data by 8 bit
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
.global SHIFTPREDACINT_MCPCM.;
.type SHIFTPREDACINT_MCPCM., STT_FUNC;
SHIFTPREDACINT_MCPCM.:
entry;

        call saveforCEnv;        
        l0 = 9216;
        b0 = dm(Predac_int_ptr_dtsx.); 
        i0 = dm(Predac_int_ptr_dtsx.); 
 		r4 = 9216;
        lcntr = r4, do shift_predac until lce;
        	r0 = dm(i0, m5);
        	r0 = lshift r0 by 8;
        shift_predac:dm(i0, m6) = r0;
        
        call unsaveforCEnv;
		nop;
		nop;		
		i12=dm(m7,i6);
		jump (m14,i12) (db); rframe; nop;		
.SHIFTPREDACINT_MCPCM..end:

/******************************************************************************
 *  Module Name        : ENABLE_TIMER
 *  Functionality      : Enables timer routine
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************/
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
#endif //__ADI_GENERATED_DEF_HEADERS__
	
	i12=dm(m7,i6);
	jump (m14,i12) (db);
	rframe; nop;
	
.STIMER_DTSX..END:

/******************************************************************************
 *  Module Name        : ETIMER_DTSX
 *  Functionality      : Disables Timer Routine
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
#endif //__ADI_GENERATED_DEF_HEADERS__

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
	
	dm(MODE2_save.) = MODE2;

	bit set MODE2 0x80;		//set btb bitset
	nop;nop;
	
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
	
	bit clr MODE2 0x80;		//Clr btb bitset
	nop;nop;

	bit clr MODE1 0x10000;		//Clr Rnd32
	nop;nop;

	bit set MODE1 0x2000;		//Set ALUSAT
	nop;nop;

	MODE1 = dm(MODE1_save.);
	MODE2 = dm(MODE2_save.);
	
	i12=dm(m7,i6);
	jump (m14,i12) (db); 
	rframe; nop;
	
.MODE_CLR_DTSX..END:
/*******************************************************************************************/
.endseg;
#endif //DTSX_DECODER