/***************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :  	DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Downsampling.asm
*  Description      :   Downsampling routines
*
******************************************************************************/
#include "asm_sprt.h"
#include "..\src\System\Include\Downsampling.h"
.IMPORT "..\src\system\Include\Def_Struct.h";
#include "..\src\system\Include\Extern_SPI.h"
#include "..\src\system\Include\Commn.h"

#include "def21593.h"

#ifdef DOWNSAMPLING

.extern Predac_buffer_Int.;
.extern struct kernel Frmwk.;
.extern Predac_int.;
.extern C_SW_int.;
.extern C_SW_out.;
.extern LR_int.;
.extern LR_out.;
.extern LSR_RSR_int.;
.extern LSR_RSR_out.;
.extern LS_RS_int.;
.extern LS_RS_out.;
.extern dn_blkcnt_temp.;
.extern leftinput_delays_heap.;
.extern leftinput_delays_ptr.;
.extern lp_cfs_heap_ptr.;
.extern Lsr_input_delays_heap.;
.extern Lsr_input_delays_ptr.;
.extern Ls_input_delays_heap.;
.extern Ls_input_delays_ptr.;
.extern centerinput_delays_heap.;
.extern centerinput_delays_ptr.;
.extern lfeinput_delays_heap.;

.extern leftinput_delays_heap_buffer1;
.extern rightinput_delays_heap_buffer1;
.extern centerinput_delays_heap_buffer1;
.extern lfeinput_delays_heap_buffer1;
.extern Ls_input_delays_heap_buffer1;
.extern Rs_input_delays_heap_buffer1;
.extern Lsr_input_delays_heap_buffer1;
.extern Rsr_input_delays_heap_buffer1;

.extern rightinput_delays_heap.;
.extern Rs_input_delays_heap.;
.extern Rsr_input_delays_heap.;
.extern DnSamp192to48.;

/******************************************************************************
 *  Module Name        : Down_Samp_Processing
 *  Functionality      :  Downsamoling process for PCM and MCPCM streams based 
 						  on downsamp_flag and DnSamp192to48 flags and Downsampling init
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.section/sw  seg_pcm_downsampling_kernal_code;
.global Down_Samp_Processing.; 	//Single I2S
.type Down_Samp_Processing., STT_FUNC;
Down_Samp_Processing.:	
	call saveforCEnv;
	
	r0 = dm(Frmwk.->init_ds_processing);
	r0 = pass r0;
	if eq jump no_init_ds;
	
	call DS_DD_SYS_INIT;
	dm(Frmwk.->init_ds_processing)=m5;
	
no_init_ds:	
		
	l0 = 1024*2;  
	b0 = LR_int.;
	i0 = LR_int.;
	r1=64;    
    PCM_process: 
    dm(dn_blkcnt_temp.)=r1; 
	b2 = Predac_int.; 
	i2  = Predac_int.; 
	l2 = 256*2;			    	// length of ltrt buffer 
		
	b3 = dm(leftinput_delays_heap.); 
	i3 = dm(leftinput_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
		
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 
		
down_samp_block_process:

	call down_samp_main_Pcm_MCPCM;

	r0 = dm(dn_blkcnt_temp.); 
	r0 = r0 - 1;
	dm(dn_blkcnt_temp.) = r0;
	
	if ne jump down_samp_block_process;
	dm(leftinput_delays_ptr.)=i3;	
	
	l0 = 0; l9 = 0;l2=0;
	call unsaveforCEnv;
	i12=dm(m7,i6);
    jump (m14,i12) (db); rframe; nop;	

Down_Samp_Processing..end:

/******************************************************************************
 *  Module Name        : Down_Samp_Processing_8ch
 *  Functionality      :  Core Downsampling process for Max of 8ch streams 
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.section/sw  seg_downsampling_kernal_code;
.global Down_Samp_Processing_8ch.; 	//Single I2S
.type Down_Samp_Processing_8ch., STT_FUNC;
Down_Samp_Processing_8ch.:	
	call saveforCEnv;
	
	r0 = dm(Frmwk.->init_ds_processing);
	r0 = pass r0;
	if eq jump no_init_ds_2ch;
	
	call DS_DD_SYS_INIT;
	dm(Frmwk.->init_ds_processing)=m5;
	
no_init_ds_2ch:
	
	r0 = dm(Frmwk.->StreamType);
	r0 = r0-1;
	if eq jump ds_two_channel;
	
	/********** LSr_RSr Process *****/		
	l0 = 1024*2;  
	b0 = LSR_RSR_int.;
	i0 = LSR_RSR_int.;	

	r1=64;	     
	
    MPCM_processLSr_RSr: 
    dm(dn_blkcnt_temp.)=r1;     
    
	b2 = LSR_RSR_out.; 
	i2  = LSR_RSR_out.;
	l2 = 256*2;			    	// length of ltrt buffer 
		
	b3 = dm(Lsr_input_delays_heap.); 
	i3 = dm(Lsr_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	
	
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	
	call down_samp_block_process_8ch_routine;	

	dm(Lsr_input_delays_ptr.)=i3;		
	
	/********** LS_RS Process *****/	
	
	l0 = 1024*2;  
	b0 = LS_RS_int.;
	i0 = LS_RS_int.;					

	r1=64;     
    MPCM_processLS_RS: 
    dm(dn_blkcnt_temp.)=r1;  
	b2 = LS_RS_out.; 
	i2  = LS_RS_out.;
	l2 = 256*2;			    	// length of ltrt buffer 
		
	b3 = dm(Ls_input_delays_heap.); 
	i3 = dm(Ls_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
		
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	
	call down_samp_block_process_8ch_routine;	

	dm(Ls_input_delays_ptr.)=i3;		
		
	/********** C_SW  Process *****/	
	
	l0 = 1024*2;  
	b0 = C_SW_int.;
	i0 = C_SW_int.;	

	r1=64;  
    MPCM_processC_SW: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = C_SW_out.; 
	i2  = C_SW_out.;
	l2 = 256*2;			    	// length of ltrt buffer 
		
	b3 = dm(centerinput_delays_heap.); 
	i3 = dm(centerinput_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;	
	
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	
	call down_samp_block_process_8ch_routine;	

	dm(centerinput_delays_ptr.)=i3;
	
	ds_two_channel:
	
	/********** LR Process *****/
	
	l0 = 1024*2;  
	b0 = LR_int.;
	i0 = LR_int.;					

	r1=64;	     
    MPCM_processLR: 
    dm(dn_blkcnt_temp.)=r1; 
	b2 = LR_out.; 
	i2  = LR_out.;
	l2 = 256*2;			    	// length of ltrt buffer 
		
	b3 = dm(leftinput_delays_heap.); 
	i3 = dm(leftinput_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
		
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	
	call down_samp_block_process_8ch_routine;	

	dm(leftinput_delays_ptr.)=i3;
		
	l0 = 0; l9 = 0;l2=0;
	call unsaveforCEnv;
	i12=dm(m7,i6);
    jump (m14,i12) (db); rframe; nop;	

Down_Samp_Processing_8ch..end:
.endseg;

/******************************************************************************
 *  Module Name        : down_samp_block_process_8ch_routine
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.section/sw  seg_downsampling_kernal_code;
.global down_samp_block_process_8ch_routine;
down_samp_block_process_8ch_routine:
down_samp_block_process_8chanel:

	call down_samp_main_Pcm_MCPCM;

	r0 = dm(dn_blkcnt_temp.); 
	r0 = r0 - 1;
	dm(dn_blkcnt_temp.) = r0;
	
	if ne jump down_samp_block_process_8chanel;
	rts;
down_samp_block_process_8ch_routine.end:
.endseg;

/******************************************************************************
 *  Module Name        : down_samp_main_Pcm_MCPCM
 *  Functionality      : core downsampling Process for PCM and MCPCM stream
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.section/sw  seg_downsampling_kernal_code;
.global down_samp_main_Pcm_MCPCM;
down_samp_main_Pcm_MCPCM:

	ustat2=0x00000001;
	nop;nop;    

	lcntr=8,do do_next_sample_Pcm_MCPCM until lce;

	bit tst ustat2 0x00000001;	    // test ustat1=0x00000001
	if tf jump compute_ltop_Pcm_MCPCM;	    // BTF=1 if true

	f3 = dm(i0,m0);				// Channel 1 Value 
	dm(i3,1)=f3;			
	f3 = dm(i0,m3);				// Channel 2 Value 
	dm(i3,-3)=f3;

	r3 = dm(DnSamp192to48.);
	r3 = pass r3;
	if eq jump do_next_sample_Pcm_MCPCM;

	f3 = dm(i0,m0);					//for Downsamp1_4
	dm(i3,1)=f3;
	f3 = dm(i0,m3);
	dm(i3,-3)=f3;

	f3 = dm(i0,m0);
	dm(i3,1)=f3;
	f3 = dm(i0,m3); 
	dm(i3,-3)=f3;

	jump do_next_sample_Pcm_MCPCM;

compute_ltop_Pcm_MCPCM:
	f3 = dm(i0,m0);		
	f4 = dm(i0,m3);
	s3 = f4;		
		
	bit SET mode1 (                      
                  BITM_REGF_MODE1_PEYEN         
                 | BITM_REGF_MODE1_BDCST9); 
	
	nop;nop;nop;nop;
		
	dm(i3,m1)=f3,f4=pm(i9,m14);	// Channel input , co_eff update for input delay buffer
	
	f12=0;
	f13=0; 
	r0=CORE_BUFFER_SIZE-1;
	f8=0;
	f10=0;
	r0 = lshift r0 by -1;
		
	lcntr=r0, do unrolled_loop_end_Pcm_MCPCM until lce;
	f8=f3*f4, f12=f8+f12, f3=dm(i3,m1),f4=pm(i9,m14);  
	
unrolled_loop_end_Pcm_MCPCM:   f10=f3*f4,f13=f10+f13,f3=dm(i3,m1),f4=pm(i9,m14);

   f8  = f3*f4, f12 = f8+f12;
   f13 = f10+f13; 
   f12 = f8+f12;
   f0  = f12+f13;
   f12 = dm(i3,m4);	
   dm(i2,m1) = f0;  		       

	BIT CLR mode1 BITM_REGF_MODE1_PEYEN | BITM_REGF_MODE1_BDCST9;	// Disabling both SIMD and Broadcast mode for Index I9
	nop;nop;nop;nop;

    do_next_sample_Pcm_MCPCM: bit tgl USTAT2 0x00000001;	 // toggles bit 15 of ustat1    
    rts;
down_samp_main_Pcm_MCPCM.end:
.endseg;

/******************************************************************************
 *  Module Name        : DS_DD_SYS_INIT
 *  Functionality      : Downsampling memory initialization
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/ 
.section/sw  seg_downsampling_kernal_code;
.global DS_DD_SYS_INIT;    
DS_DD_SYS_INIT:

	l3 = 0; m3 = 2; 	
	i3 = leftinput_delays_heap_buffer1;
	dm(leftinput_delays_heap.) = i3;
	
	i3 = rightinput_delays_heap_buffer1;
	dm(rightinput_delays_heap.) = i3;
	
	i3 = centerinput_delays_heap_buffer1;
	dm(centerinput_delays_heap.) = i3;
	
	i3 = lfeinput_delays_heap_buffer1;
	dm(lfeinput_delays_heap.) = i3;		
	
	i3 = Ls_input_delays_heap_buffer1;
	dm(Ls_input_delays_heap.) = i3;
	
	i3 = Rs_input_delays_heap_buffer1;
	dm(Rs_input_delays_heap.) = i3;
	
	i3 = Lsr_input_delays_heap_buffer1;
	dm(Lsr_input_delays_heap.) = i3;
	
	i3 = Rsr_input_delays_heap_buffer1;
	dm(Rsr_input_delays_heap.) = i3;
			
DS_Init_Routine:

	i3 = dm(leftinput_delays_heap.);
	dm(leftinput_delays_ptr.) = i3;
	
	i3 = dm(centerinput_delays_heap.);
	dm(centerinput_delays_ptr.) = i3;	
	
    i3 = dm(Ls_input_delays_heap.);
	dm(Ls_input_delays_ptr.) = i3;	
	
	i3 = dm(Lsr_input_delays_heap.);
	dm(Lsr_input_delays_ptr.) = i3;		
	
Clear_Core_Buffers:	
			
	r1 = CORE_BUFFER_SIZE;//CORE_BUFFER_SIZE;
	r2=8;
	r1 = r1*r2(ssi);
	r1 = lshift r1 by -1; //For SIMD
	
	i3 = dm(leftinput_delays_heap.);	
	
    bit SET mode1 BITM_REGF_MODE1_PEYEN;      
	nop;nop;nop;nop;
	
    r0=0;
	lcntr=r1,do copy_zeroCore until lce;   
copy_zeroCore: dm(i3,m3)=r0; //m3=2;

	bit CLR mode1 BITM_REGF_MODE1_PEYEN; 
	nop;nop;nop;nop;
	
	i3 = lp_cfs128_1to2or2to1.;			//for Downsamp1-2 - transfer table [Re-used from ROM-I]
				
	r0 = dm(DnSamp192to48.);
	r0 = pass r0;
	if eq jump copytoheap;
									
Transfer192to48: 
	i3 = lp_cfs128_1to4or4to1.;		//for Downsamp1-4 - transfer table [Re-used from ROM-I]
	
copytoheap:	dm(lp_cfs_heap_ptr.)=i3;	
	rts; 
DS_DD_SYS_INIT.end:
.endseg;
/******************************************************************************
 *  Module Name        : Pre_Dac_Ptr_Update_DS
 *  Functionality      : Predac pointer update for Downsampling case
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.section/sw  seg_downsampling_kernal_code;
.global Pre_Dac_Ptr_Update_DS.;
.type Pre_Dac_Ptr_Update_DS., STT_FUNC;
Pre_Dac_Ptr_Update_DS.:
	
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

.Pre_Dac_Ptr_Update_DS..end:
.endseg;

/******************************************************************************
 *  Module Name        : Predac_Int_TO_Predac
 *  Functionality      : copy routine (Predac_int to Predac buffer)
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.section/sw  seg_pcm_downsampling_kernal_code;
.global Predac_Int_TO_Predac_ext.; 	//Single I2S
.type Predac_Int_TO_Predac_ext., STT_FUNC;
Predac_Int_TO_Predac_ext.:

	call saveforCEnv;	
	
	l1 = 256*2;
	b1 =Predac_int.;
	i1 = Predac_int.;	
		
	l4 = dm(Frmwk.->IOP->Predac->length); b4 = dm(Frmwk.->IOP->Predac->heap);
	i4 = dm(Frmwk.->IOP->Predac->wr_ptr);
	
	bit SET mode1 BITM_REGF_MODE1_PEYEN|BITM_REGF_MODE1_ALUSAT;
    nop;
    nop;	
    r2=31;
	r1=256;		
	r4=34;
    m0=r4;	
		 
	lcntr = r1, do Predac_Int_TO_Predac1 until lce;	

	f0 = dm(i1,2); 
	r0 = fix f0 by r2; 
	dm(i4,2) = r0;  
	   
	Predac_Int_TO_Predac1: modify(i4,m0)(nw);	

	bit clr mode1 BITM_REGF_MODE1_PEYEN |BITM_REGF_MODE1_ALUSAT;
	nop;
	nop;	
    
	call unsaveforCEnv;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.Predac_Int_TO_Predac_ext..end:	
.endseg;

#endif //DOWNSAMPLING