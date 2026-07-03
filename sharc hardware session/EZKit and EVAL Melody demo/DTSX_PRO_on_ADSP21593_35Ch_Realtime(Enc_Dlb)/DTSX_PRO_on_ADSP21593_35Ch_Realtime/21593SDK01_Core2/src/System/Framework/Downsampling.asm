/***************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :  	DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Downsampling.asm
*  Description      :   DTSX + Downsampling routines
*
******************************************************************************/
#include "asm_sprt.h"
#include "..\src\System\Include\Downsampling.h"
.IMPORT "..\src\system\Include\Def_Struct.h";
#include "..\src\system\Include\Commn.h"

#include "def21593.h"

#ifdef DOWNSAMPLING_DTSX

.extern Predac_buffer_Int_c2.;
.extern struct kernel Frmwk.;
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

.extern rightinput_delays_heap.;
.extern Rs_input_delays_heap.;
.extern Rsr_input_delays_heap.;
.extern DnSamp192to48.;

.extern Add1_2chnlout.;
.extern Add3_4chnlout.;
.extern Add5_6chnlout.;
.extern Add7_8chnlout.;
.extern Add9_10chnlout.;
.extern Add11_12chnlout.;
.extern Add13_14chnlout.;
.extern Add15_16chnlout.;
.extern Add17_18chnlout.;
.extern Add19_20chnlout.;
.extern Add21_22chnlout.;
.extern Add23_24chnlout.;
.extern Add25_26chnlout.;
.extern Add27_28chnlout.;

.extern Add1_2chnl.;
.extern Add3_4chnl.;
.extern Add5_6chnl.;
.extern Add7_8chnl.;
.extern Add9_10chnl.;
.extern Add11_12chnl.;
.extern Add13_14chnl.;
.extern Add15_16chnl.;
.extern Add17_18chnl.;
.extern Add19_20chnl.;
.extern Add21_22chnl.;
.extern Add23_24chnl.;
.extern Add25_26chnl.;
.extern Add27_28chnl.;

.extern add_1_input_delays_heap.;
.extern add_1_input_delays_ptr.;
.extern add_3_input_delays_heap.;
.extern add_3_input_delays_ptr.;
.extern add_5_input_delays_heap.;
.extern add_5_input_delays_ptr.;
.extern add_7_input_delays_heap.;
.extern add_7_input_delays_ptr.;
.extern add_9_input_delays_heap.;
.extern add_9_input_delays_ptr.;
.extern add_11_input_delays_heap.;
.extern add_11_input_delays_ptr.;
.extern add_13_input_delays_heap.;
.extern add_13_input_delays_ptr.;
.extern add_15_input_delays_heap.;
.extern add_15_input_delays_ptr.;
.extern add_17_input_delays_heap.;
.extern add_17_input_delays_ptr.;
.extern add_19_input_delays_heap.;
.extern add_19_input_delays_ptr.;
.extern add_21_input_delays_heap.;
.extern add_21_input_delays_ptr.;
.extern add_23_input_delays_heap.;
.extern add_23_input_delays_ptr.;
.extern add_25_input_delays_heap.;
.extern add_25_input_delays_ptr.;
.extern add_27_input_delays_heap.;
.extern add_27_input_delays_ptr.;
.extern add_2_input_delays_heap.;
.extern add_4_input_delays_heap.;
.extern add_6_input_delays_heap.;
.extern add_8_input_delays_heap.;
.extern add_10_input_delays_heap.;
.extern add_12_input_delays_heap.;
.extern add_14_input_delays_heap.;
.extern add_16_input_delays_heap.;
.extern add_18_input_delays_heap.;
.extern add_20_input_delays_heap.;
.extern add_22_input_delays_heap.;
.extern add_24_input_delays_heap.;
.extern add_26_input_delays_heap.;
.extern add_28_input_delays_heap.;

.extern	saveforCEnv;
.extern	unsaveforCEnv;

.extern Dtsx_DS_Ext_in.;

/******************************************************************************
 *  Module Name        : Down_Samp_Processing_32ch
 *  Functionality      : Core Downsampling process for Max of 32ch streams 
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.section/sw  seg_DTSX_DS_kernal_code;
.global Down_Samp_Processing_32ch.; 	//Single I2S
.type Down_Samp_Processing_32ch., STT_FUNC;
Down_Samp_Processing_32ch.:	
	call saveforCEnv;
	
	r0 = dm(Frmwk.->init_ds_processing);
	r0 = pass r0;
	if eq jump no_init_ds_2ch;
	
	call DS_DD_SYS_INIT;
	dm(Frmwk.->init_ds_processing)=m5;
	
no_init_ds_2ch:
	
		/********** LSr_RSr Process *****/	
	
	l0 = 512*2;  
	b0 = LSR_RSR_int.;
	i0 = LSR_RSR_int.;	

    /**block size**/
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
	
	l0 = 512*2;  
	b0 = LS_RS_int.;
	i0 = LS_RS_int.;					

    /**block size**/
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
	
	l0 = 512*2;  
	b0 = C_SW_int.;
	i0 = C_SW_int.;	

    /**block size**/
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
	
	/**24ch support for DTSX  ***/
	 r3 = dm(Frmwk.->DTSX->DTSX_Downsamp_Enable);;
	 r3 = pass r3;
	 if eq jump ds_two_channel;
	 
	/********** add_1_2_  Process *****/	
	l0 = 512*2;  
	b0 = Add1_2chnl.;
	i0 = Add1_2chnl.;	

    /**block size**/
    r1 = 64;    
    MPCM_process1_2: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add1_2chnlout.; 
	i2 = Add1_2chnlout.;
	l2 = 256*2;	
			    	
	b3 = dm(add_1_input_delays_heap.); 
	i3 = dm(add_1_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_1_input_delays_ptr.)=i3;
	
	/********** add_3_4_  Process *****/	
	l0 = 512*2;  
	b0 = Add3_4chnl.;
	i0 = Add3_4chnl.;
		
    /**block size**/
    r1 = 64;     
    MPCM_process3_4: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add3_4chnlout.; 
	i2 = Add3_4chnlout.;
	l2 = 256*2;			
	    	
	b3 = dm(add_3_input_delays_heap.); 
	i3 = dm(add_3_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_3_input_delays_ptr.)=i3;

	/********** add_5_6_  Process *****/	
	l0 = 512*2;  
	b0 = Add5_6chnl.;
	i0 = Add5_6chnl.;	

    /**block size**/
	    r1 = 64;     
    MPCM_process5_6: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add5_6chnlout.; 
	i2 = Add5_6chnlout.;
	l2 = 256*2;	
			    	
	b3 = dm(add_5_input_delays_heap.); 
	i3 = dm(add_5_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_5_input_delays_ptr.)=i3;
	
	/********** add_7_8_  Process *****/	
	l0 = 512*2;  
	b0 = Add7_8chnl.;
	i0 = Add7_8chnl.;
		
    /**block size**/
	    r1 = 64;     
    MPCM_process7_8: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add7_8chnlout.; 
	i2 = Add7_8chnlout.;
	l2 = 256*2;			
	    	
	b3 = dm(add_7_input_delays_heap.); 
	i3 = dm(add_7_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_7_input_delays_ptr.)=i3;
	
		/********** add_9_10_  Process *****/	
	l0 = 512*2;  
	b0 = Add9_10chnl.;
	i0 = Add9_10chnl.;
		
    /**block size**/
	    r1 = 64;     
    MPCM_process9_10: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add9_10chnlout.; 
	i2 = Add9_10chnlout.;
	l2 = 256*2;			
	    	
	b3 = dm(add_9_input_delays_heap.); 
	i3 = dm(add_9_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_9_input_delays_ptr.)=i3;
	
			/********** add_11_12_  Process *****/	
	l0 = 512*2;  
	b0 = Add11_12chnl.;
	i0 = Add11_12chnl.;
		
    /**block size**/
    r1 = 64;     
    MPCM_process11_12: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add11_12chnlout.; 
	i2 = Add11_12chnlout.;
	l2 = 256*2;			
	    	
	b3 = dm(add_11_input_delays_heap.); 
	i3 = dm(add_11_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_11_input_delays_ptr.)=i3;
	
				/********** add_13_14_  Process *****/	
	l0 = 512*2;  
	b0 = Add13_14chnl.;
	i0 = Add13_14chnl.;
		
    /**block size**/
    r1 = 64;     
    MPCM_process13_14: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add13_14chnlout.; 
	i2 = Add13_14chnlout.;
	l2 = 256*2;			
	    	
	b3 = dm(add_13_input_delays_heap.); 
	i3 = dm(add_13_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_13_input_delays_ptr.)=i3;
	
					/********** add_15_16_  Process *****/	
	l0 = 512*2;  
	b0 = Add15_16chnl.;
	i0 = Add15_16chnl.;
		
    /**block size**/
    r1 = 64;     
    MPCM_process15_16: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add15_16chnlout.; 
	i2 = Add15_16chnlout.;
	l2 = 256*2;			
	    	
	b3 = dm(add_15_input_delays_heap.); 
	i3 = dm(add_15_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_15_input_delays_ptr.)=i3;
	
						/********** add_17_18_  Process *****/	
	l0 = 512*2;  
	b0 = Add17_18chnl.;
	i0 = Add17_18chnl.;
		
    /**block size**/
    r1 = 64;     
    MPCM_process17_18: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add17_18chnlout.; 
	i2 = Add17_18chnlout.;
	l2 = 256*2;			
	    	
	b3 = dm(add_17_input_delays_heap.); 
	i3 = dm(add_17_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_17_input_delays_ptr.)=i3;
	
							/********** add_19_20_  Process *****/	
	l0 = 512*2;  
	b0 = Add19_20chnl.;
	i0 = Add19_20chnl.;
		
    /**block size**/
    r1 = 64;     
    MPCM_process19_20: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add19_20chnlout.; 
	i2 = Add19_20chnlout.;
	l2 = 256*2;			
	    	
	b3 = dm(add_19_input_delays_heap.); 
	i3 = dm(add_19_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_19_input_delays_ptr.)=i3;
	
								/********** add_21_22_  Process *****/	
	l0 = 512*2;  
	b0 = Add21_22chnl.;
	i0 = Add21_22chnl.;
		
    /**block size**/
    r1 = 64;     
    MPCM_process21_22: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add21_22chnlout.; 
	i2 = Add21_22chnlout.;
	l2 = 256*2;			
	    	
	b3 = dm(add_21_input_delays_heap.); 
	i3 = dm(add_21_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_21_input_delays_ptr.)=i3;
	
									/********** add_23_24_  Process *****/	
	l0 = 512*2;  
	b0 = Add23_24chnl.;
	i0 = Add23_24chnl.;
		
    /**block size**/
    r1 = 64;     
    MPCM_process23_24: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add23_24chnlout.; 
	i2 = Add23_24chnlout.;
	l2 = 256*2;			
	    	
	b3 = dm(add_23_input_delays_heap.); 
	i3 = dm(add_23_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_23_input_delays_ptr.)=i3;
	
										/********** add_25_26_  Process *****/	
	l0 = 512*2;  
	b0 = Add25_26chnl.;
	i0 = Add25_26chnl.;
		
    /**block size**/
    r1 = 64;     
    MPCM_process25_26: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add25_26chnlout.; 
	i2 = Add25_26chnlout.;
	l2 = 256*2;			
	    	
	b3 = dm(add_25_input_delays_heap.); 
	i3 = dm(add_25_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_25_input_delays_ptr.)=i3;
	
											/********** add_27_28_  Process *****/	
	l0 = 512*2;  
	b0 = Add27_28chnl.;
	i0 = Add27_28chnl.;
		
    /**block size**/
    r1 = 64;     
    MPCM_process27_28: 
    dm(dn_blkcnt_temp.)=r1;   
	b2 = Add27_28chnlout.; 
	i2 = Add27_28chnlout.;
	l2 = 256*2;			
	    	
	b3 = dm(add_27_input_delays_heap.); 
	i3 = dm(add_27_input_delays_ptr.);
	l3 = CORE_BUFFER_SIZE*2;
	l9 = CORE_BUFFER_SIZE;
	b9 = dm(lp_cfs_heap_ptr.);	
	m4 = -2;		//	USED for SIMD Operation
	m1 =  2;		//	USED for SIMD Operation
	m0 = m6;	
	m3 = m6; 	
	call down_samp_block_process_8ch_routine;	
	dm(add_27_input_delays_ptr.)=i3;
	
	ds_two_channel:
	
	/********** LR Process *****/
	
	l0 = 512*2;  
	b0 = LR_int.;
	i0 = LR_int.;					

    /**block size**/
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

Down_Samp_Processing_32ch..end:
.endseg;
/******************************************************************************
 *  Module Name        : down_samp_block_process_8ch_routine
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
 .section/sw  seg_DTSX_DS_kernal_code;
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
 .section/sw  seg_DTSX_DS_kernal_code;
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
.section/sw  seg_DTSX_DS_kernal_code;
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
		
    /**24ch support for DTSX  ***/
	r3 = dm(Frmwk.->DTSX->DTSX_Downsamp_Enable);
	r3 = pass r3;
	if eq jump DS_Init_Routine;
	i3 = Add1_input_delays_heap_buffer1;
	dm(add_1_input_delays_heap.) = i3;
	
	i3 = Add2_input_delays_heap_buffer1;
	dm(add_2_input_delays_heap.) = i3;
	
	i3 = Add3_input_delays_heap_buffer1;
	dm(add_3_input_delays_heap.) = i3;
	
	i3 = Add4_input_delays_heap_buffer1;
	dm(add_4_input_delays_heap.) = i3;	
	
	i3 = Add5_input_delays_heap_buffer1;
	dm(add_5_input_delays_heap.) = i3;
	
	i3 = Add6_input_delays_heap_buffer1;
	dm(add_6_input_delays_heap.) = i3;
	
	i3 = Add7_input_delays_heap_buffer1;
	dm(add_7_input_delays_heap.) = i3;
	
	i3 = Add8_input_delays_heap_buffer1;
	dm(add_8_input_delays_heap.) = i3;	
	
	i3 = Add9_input_delays_heap_buffer1;
	dm(add_9_input_delays_heap.) = i3;
	
	i3 = Add10_input_delays_heap_buffer1;
	dm(add_10_input_delays_heap.) = i3;
	
	i3 = Add11_input_delays_heap_buffer1;
	dm(add_11_input_delays_heap.) = i3;
	
	i3 = Add12_input_delays_heap_buffer1;
	dm(add_12_input_delays_heap.) = i3;	
	
	i3 = Add13_input_delays_heap_buffer1;
	dm(add_13_input_delays_heap.) = i3;
	
	i3 = Add14_input_delays_heap_buffer1;
	dm(add_14_input_delays_heap.) = i3;
	
	i3 = Add15_input_delays_heap_buffer1;
	dm(add_15_input_delays_heap.) = i3;
	
	i3 = Add16_input_delays_heap_buffer1;
	dm(add_16_input_delays_heap.) = i3;	
	
	i3 = Add17_input_delays_heap_buffer1;
	dm(add_17_input_delays_heap.) = i3;
	
	i3 = Add18_input_delays_heap_buffer1;
	dm(add_18_input_delays_heap.) = i3;
	
	i3 = Add19_input_delays_heap_buffer1;
	dm(add_19_input_delays_heap.) = i3;
	
	i3 = Add20_input_delays_heap_buffer1;
	dm(add_20_input_delays_heap.) = i3;	
	
	i3 = Add21_input_delays_heap_buffer1;
	dm(add_21_input_delays_heap.) = i3;
	
	i3 = Add22_input_delays_heap_buffer1;
	dm(add_22_input_delays_heap.) = i3;
	
	i3 = Add23_input_delays_heap_buffer1;
	dm(add_23_input_delays_heap.) = i3;
	
	i3 = Add24_input_delays_heap_buffer1;
	dm(add_24_input_delays_heap.) = i3;	
	
	i3 = Add25_input_delays_heap_buffer1;
	dm(add_25_input_delays_heap.) = i3;
		
	i3 = Add26_input_delays_heap_buffer1;
	dm(add_26_input_delays_heap.) = i3;	
	
	i3 = Add27_input_delays_heap_buffer1;
	dm(add_27_input_delays_heap.) = i3;
		
	i3 = Add28_input_delays_heap_buffer1;
	dm(add_28_input_delays_heap.) = i3;	
	
DS_Init_Routine:

	i3 = dm(leftinput_delays_heap.);
	dm(leftinput_delays_ptr.) = i3;
	
	i3 = dm(centerinput_delays_heap.);
	dm(centerinput_delays_ptr.) = i3;	
	
    i3 = dm(Ls_input_delays_heap.);
	dm(Ls_input_delays_ptr.) = i3;	
	
	i3 = dm(Lsr_input_delays_heap.);
	dm(Lsr_input_delays_ptr.) = i3;		
	/**24ch support for DTSX  ***/	
	r3 = dm(Frmwk.->DTSX->DTSX_Downsamp_Enable);
	r3 = pass r3;
	if eq jump Clear_Core_Buffers;
	i3 = dm(add_1_input_delays_heap.);
	dm(add_1_input_delays_ptr.) = i3;
	
	i3 = dm(add_3_input_delays_heap.);
	dm(add_3_input_delays_ptr.) = i3;	
	
	i3 = dm(add_5_input_delays_heap.);
	dm(add_5_input_delays_ptr.) = i3;
	
	i3 = dm(add_7_input_delays_heap.);
	dm(add_7_input_delays_ptr.) = i3;	
	
	i3 = dm(add_9_input_delays_heap.);
	dm(add_9_input_delays_ptr.) = i3;
	
	i3 = dm(add_11_input_delays_heap.);
	dm(add_11_input_delays_ptr.) = i3;	
	
	i3 = dm(add_13_input_delays_heap.);
	dm(add_13_input_delays_ptr.) = i3;
	
	i3 = dm(add_15_input_delays_heap.);
	dm(add_15_input_delays_ptr.) = i3;	
	
	i3 = dm(add_17_input_delays_heap.);
	dm(add_17_input_delays_ptr.) = i3;
	
	i3 = dm(add_19_input_delays_heap.);
	dm(add_19_input_delays_ptr.) = i3;	
	
	i3 = dm(add_21_input_delays_heap.);
	dm(add_21_input_delays_ptr.) = i3;
	
	i3 = dm(add_23_input_delays_heap.);
	dm(add_23_input_delays_ptr.) = i3;	
	
	i3 = dm(add_25_input_delays_heap.);
	dm(add_25_input_delays_ptr.) = i3;	
	
	i3 = dm(add_27_input_delays_heap.);
	dm(add_27_input_delays_ptr.) = i3;	

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
 *  Module Name        : Int_predac_to_DS_Inputbuffer_cpy
 *  Functionality      :
 *  Input Parameters   : None
 *  Output Parameters  : None
 *****************************************************************************/
.section/sw  seg_DTSX_DS_kernal_code;
.global Int_predac_to_DS_Inputbuffer_cpy.; 	
.type Int_predac_to_DS_Inputbuffer_cpy., STT_FUNC;
Int_predac_to_DS_Inputbuffer_cpy.:
	call saveforCEnv;	
	i1 = Dtsx_DS_Ext_in.;	
	b1 = Dtsx_DS_Ext_in.; 
	l1 = BUFF_MAX_SIZE_512;
	
	i4 = i1;
	
    l2 = 512*2;			 //L_R_int
	b2 = LR_int.;
	i2 = LR_int.;
	
	l3 = 512*2;			  //C_SW_int
	b3 = C_SW_int.;
	i3 = C_SW_int.;
	
	l0 = 512*2;			  //LS_RS_int
	b0 = LS_RS_int.;
	i0 = LS_RS_int.;
	
	l5 = 512*2; 		  //LSR_RSR_int
	b5 = LSR_RSR_int.;
	i5 = LSR_RSR_int.;	
	
	l9 = 512*2;           //add_1_2_int
	b9 = Add1_2chnl.;
	i9 = Add1_2chnl.;	
	
	l10 = 512*2;          //add_3_4_int
	b10 = Add3_4chnl.; 
	i10 = Add3_4chnl.;	
	
	l11 = 512*2;          //add_5_6_int
	b11 = Add5_6chnl.;
	i11 = Add5_6chnl.;	
	
	l12 = 512*2;          //add_7_8_int
	b12 = Add7_8chnl.;
	i12 = Add7_8chnl.;	
	
	m0 = 20;
			
	call DS_inp16ch_copy;
				
	l2 = 512*2;          //add_9_10_int
	b2 = Add9_10chnl.;
	i2 = Add9_10chnl.;	
	
	l3 = 512*2;          //add_11_12_int
	b3 = Add11_12chnl.;
	i3 = Add11_12chnl.;	
	
	l0 = 512*2;          //add_13_14_int
	b0 = Add13_14chnl.;
	i0 = Add13_14chnl.;	
	
	l5 = 512*2;          //add_15_16_int
	b5 = Add15_16chnl.;
	i5 = Add15_16chnl.;	
	
	l9 = 512*2;          //add_17_18_int
	b9 = Add17_18chnl.;
	i9 = Add17_18chnl.;	
	
	l10 = 512*2;          //add_19_20_int
	b10 = Add19_20chnl.;
	i10 = Add19_20chnl.;	
	
	l11 = 512*2;          //add_21_22_int
	b11 = Add21_22chnl.;
	i11 = Add21_22chnl.;	
	
	l12 = 512*2;          //add_23_24_int
	b12 = Add23_24chnl.;
	i12 = Add23_24chnl.;
	
	i1 = i4;
	modify(i1,16)(nw); 
	m0 = 20;	
	
	call DS_inp16ch_copy;
	
	l2 = 512*2;          //add_25_26_int
	b2 = Add25_26chnl.;
	i2 = Add25_26chnl.;	
	
	l3 = 512*2;          //add_27_28_int
	b3 = Add27_28chnl.;
	i3 = Add27_28chnl.;	
	
	i1 = i4;
	modify(i1,32)(nw); 
	m0 = 32;
	
	call DS_inp4ch_copy;
				
	call unsaveforCEnv;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.Int_predac_to_DS_Inputbuffer_cpy..end:
.endseg;

.section/sw  seg_DTSX_DS_kernal_code;
.global DS_inp16ch_copy;
DS_inp16ch_copy:

	bit SET mode1 BITM_REGF_MODE1_PEYEN;
    nop;
    nop;
	
	r8 = 0;			
	r1=-31;	  
	lcntr = 512, do Int_predac_to_DS_Inputbuffer_cpy_loop until lce;
	     
	/******** Int Predac to DS buffer copying*****/
	
        r0 = dm(i1,2);			         
        r0 = lshift r0 by r8;		
        f0 = float r0 by r1;	
	    dm(i2,2)  = f0;	 
	    
	    r0 = dm(i1,2);	    	        
	    r0 = lshift r0 by r8;
	    f0 = float r0 by r1;			    
		dm(i3,2) = f0;			
		
	    r0 = dm(i1,2);	                
	    r0 = lshift r0 by r8;	
	    f0 = float r0 by r1;
	    dm(i0,2) = f0;	  
	    
	    r0 = dm(i1,2);	    	        
        r0 = lshift r0 by r8;		  			    	
	    f0 = float r0 by r1; 		
	    dm(i5,2) = f0;  		
	      
	    r0 = dm(i1,2);	    	        	
        r0 = lshift r0 by r8;		  			    	
	    f0 = float r0 by r1; 		
	    pm(i9,2) = f0;
	    
	    r0 = dm(i1,2);	    	        
        r0 = lshift r0 by r8;		  			    	
	    f0 = float r0 by r1; 		
	    pm(i10,2) = f0; 
	       
	    r0 = dm(i1,2);	    	        
        r0 = lshift r0 by r8;		  			    	
	    f0 = float r0 by r1; 		
	    pm(i11,2) = f0;
	    
	    r0 = dm(i1,2);	    	       
        r0 = lshift r0 by r8;		  			    	
	    f0 = float r0 by r1; 		
	    pm(i12,2) = f0; 
		        
Int_predac_to_DS_Inputbuffer_cpy_loop: modify(i1,m0)(nw); 	

	bit clr mode1 BITM_REGF_MODE1_PEYEN;
    nop;
    nop;
  
    rts;    
.DS_inp16ch_copy.end:  
.endseg;

.section/sw  seg_DTSX_DS_kernal_code;
.global DS_inp4ch_copy;
DS_inp4ch_copy:

	bit SET mode1 BITM_REGF_MODE1_PEYEN;
    nop;
    nop;
	
	r8 = 0;			
	r1=-31;	  
	lcntr = 512, do Int_predac_to_DS_Inputbuf_cpy_loop until lce;
	     
	/******** Int Predac to DS buffer copying*****/
	
        r0 = dm(i1,2);			         
        r0 = lshift r0 by r8;		
        f0 = float r0 by r1;	
	    dm(i2,2)  = f0;	 
	    
	    r0 = dm(i1,2);	    	        
	    r0 = lshift r0 by r8;
	    f0 = float r0 by r1;			    
		dm(i3,2) = f0;			 
		        
Int_predac_to_DS_Inputbuf_cpy_loop: modify(i1,m0)(nw); 	

	bit clr mode1 BITM_REGF_MODE1_PEYEN;
    nop;
    nop;
  
    rts;    
.DS_inp4ch_copy.end:  
.endseg;

.section/sw  seg_DTSX_DS_kernal_code;    
.global DS_outputbuffer_to_DSPredac_cpy.; 
.type DS_outputbuffer_to_DSPredac_cpy., STT_FUNC;
DS_outputbuffer_to_DSPredac_cpy.:
	call saveforCEnv;			
	i0 = Predac_buffer_Int_c2.;
	b0 = Predac_buffer_Int_c2.; 
	l0 = BUFF_MAX_SIZE;
	
	i4 = i0;
	
	/********** This function is to make memset for core2 internal predac buffer ************/
	//r1 = 0;
	
	//r0 = BUFF_MAX_SIZE;	
	//lcntr = r0, do mem_zero_predacint_c2 until lce;
	//mem_zero_predacint_c2: dm(i0,1) = r1;
 
	/******************************* memset end ******************************/
		
    l2 = 256*2;
	b2 = LR_out.;
	i2 = LR_out.;
	
	l3 = 256*2;
	b3 = C_SW_out.;
	i3 = C_SW_out.;
	
	l1 = 256*2;
	b1 = LS_RS_out.;
	i1 = LS_RS_out.;
	
	l5 = 256*2;
	b5 = LSR_RSR_out.;
	i5 = LSR_RSR_out.;
	
	l9 = 256*2;						//add_1_2_out
	b9 = Add1_2chnlout.;
	i9 = Add1_2chnlout.;
	
	l10 = 256*2;					//add_3_4_out
	b10 = Add3_4chnlout.;
	i10 = Add3_4chnlout.;

	l11 = 256*2;					//add_5_6_out
	b11 = Add5_6chnlout.;
	i11 = Add5_6chnlout.;
		
	l12 = 256*2; 					//add_7_8_out
	b12 = Add7_8chnlout.;
	i12 = Add7_8chnlout.;
	
	m0 = 20;
	
	call DS_out16ch_copy;
				
	l2 = 256*2;						//add_9_10_out
	b2 = Add9_10chnlout.;			
	i2 = Add9_10chnlout.;
	
	l3 = 256*2;						//add_11_12_out
	b3 = Add11_12chnlout.;
	i3 = Add11_12chnlout.;
	
	l1 = 256*2;						//add_13_14_out
	b1 = Add13_14chnlout.;
	i1 = Add13_14chnlout.;
	
	l5 = 256*2;						//add_15_16_out
	b5 = Add15_16chnlout.;
	i5 = Add15_16chnlout.;
	
	l9 = 256*2;						//add_17_18_out
	b9 = Add17_18chnlout.;
	i9 = Add17_18chnlout.;
	
	l10 = 256*2;					//add_19_20_out
	b10 = Add19_20chnlout.;
	i10 = Add19_20chnlout.;

	l11 = 256*2;					//add_21_22_out
	b11 = Add21_22chnlout.;
	i11 = Add21_22chnlout.;
		
	l12 = 256*2;					//add_23_24_out
	b12 = Add23_24chnlout.;
	i12 = Add23_24chnlout.;
	
	i0 = i4;
	modify(i0,16)(nw); 
	m0 = 20;	
	
    call DS_out16ch_copy;
    
    l2 = 256*2;          //add_25_26_int
	b2 = Add25_26chnlout.;
	i2 = Add25_26chnlout.;	
	
	l3 = 256*2;          //add_27_28_int
	b3 = Add27_28chnlout.;
	i3 = Add27_28chnlout.;	
	
	i0 = i4;
	modify(i0,32)(nw); 
	m0 = 32;
	
	call DS_out4ch_copy;
      		
	call unsaveforCEnv;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
.DS_outputbuffer_to_DSPredac_cpy..end:
.endseg;

.section/sw  seg_DTSX_DS_kernal_code;
.global DS_out16ch_copy;
DS_out16ch_copy:
		
	bit SET mode1 BITM_REGF_MODE1_PEYEN|BITM_REGF_MODE1_ALUSAT;
    nop;
    nop;	
	r1=31;				
	//r2=dm(Frmwk.->SampleBlock);
	lcntr = 256, do DS_outputbuffer_to_DSpredac_cpy_loop until lce;  
		
	    f0 = dm(i2,2) ;			
	    r0 = fix f0 by r1; 	        	
	    dm(i0,2) = r0;	
		
	    f0 = dm(i3,2);	    		
	    r0 = fix f0 by r1; 
	    dm(i0,2) = r0;	
		
	    f0 = dm(i1,2);	    	
	    r0 = fix f0 by r1; 
	    dm(i0,2) = r0;	
			
	    f0 = dm(i5,2);	    		
	    r0 = fix f0 by r1; 
	    dm(i0,2) = r0;
		
	    f0 = pm(i9,2);	    		
	    r0 = fix f0 by r1; 
	    dm(i0,2) = r0;
			
		f0 = pm(i10,2);	    		
		r0 = fix f0 by r1; 
		dm(i0,2) = r0;
 
		f0 = pm(i11,2);	    		
		r0 = fix f0 by r1; 
		dm(i0,2) = r0;
		  
		f0 = pm(i12,2);	    		
		r0 = fix f0 by r1; 
		dm(i0,2) = r0;		  
			  
DS_outputbuffer_to_DSpredac_cpy_loop: modify(i0,m0)(nw);	
		
	bit clr mode1 BITM_REGF_MODE1_PEYEN|BITM_REGF_MODE1_ALUSAT;
    nop;
    nop;

	rts;
.DS_out16ch_copy.end:			
.endseg;

.section/sw  seg_DTSX_DS_kernal_code;
.global DS_out4ch_copy;
DS_out4ch_copy:
		
	bit SET mode1 BITM_REGF_MODE1_PEYEN|BITM_REGF_MODE1_ALUSAT;
    nop;
    nop;	
	r1=31;				
	//r2=dm(Frmwk.->SampleBlock);
	lcntr = 256, do DS_outputbuf_to_DSpredac_cpy_loop until lce;  
		
	    f0 = dm(i2,2) ;			
	    r0 = fix f0 by r1; 	        	
	    dm(i0,2) = r0;	
		
	    f0 = dm(i3,2);	    		
	    r0 = fix f0 by r1; 
	    dm(i0,2) = r0;		  
			  
DS_outputbuf_to_DSpredac_cpy_loop: modify(i0,m0)(nw);	
		
	bit clr mode1 BITM_REGF_MODE1_PEYEN|BITM_REGF_MODE1_ALUSAT;
    nop;
    nop;

	rts;
.DS_out4ch_copy.end:			
.endseg;

#endif //DOWNSAMPLING_DTSX