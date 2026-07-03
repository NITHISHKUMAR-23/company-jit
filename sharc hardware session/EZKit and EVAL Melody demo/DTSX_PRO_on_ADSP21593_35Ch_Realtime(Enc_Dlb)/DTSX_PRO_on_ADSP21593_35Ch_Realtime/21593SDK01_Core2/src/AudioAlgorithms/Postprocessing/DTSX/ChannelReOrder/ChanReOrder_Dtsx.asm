/***************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :   DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :   Jasmin Infotech Private Limited,Chennai
*  File Name        :	ChanReOrder.asm 
*  Description      :   This Includes all the DTSX ChanReOrder Implementation functions
*
****************************************************************************/
#include <asm_sprt.h>
#include <def21593.h>
#include "ChanReOrder_var.h"
#include "..\..\..\..\System\Include\Commn.h"

#ifdef DTSX_CHANREORDER
.extern channelcount_based_on_fs.;
.extern	saveforCEnv;
.extern	unsaveforCEnv;

.section/DM  seg_dtsx_kernel_data_dm;
.var NxtChPairModifier;
.var savepointer;
.var SaveOutBufChLoc.;
.var DTS_AssignL1_Flag;
.var DTS_AssignL2_Flag;
.var DTS_AssignL3_Flag;
.var DTS_AssignL4_Flag;
.var DTS_AssignL5_Flag;
.var DTS_AssignL6_Flag;
.var DTS_AssignL7_Flag;
.var DTS_AssignL8_Flag;
.var DTS_AssignL9_Flag;
.var DTS_AssignL10_Flag;
.var DTS_AssignL11_Flag;
.var DTS_AssignL12_Flag;
.var DTS_AssignL13_Flag;
.var DTS_AssignL14_Flag;
.var DTS_AssignL15_Flag;
.var DTS_AssignL16_Flag;
.var DTS_ChanReorder_AssignLine1;
.var DTS_ChanReorder_AssignLine2;
.var DTS_ChanReorder_AssignLine3;
.var DTS_ChanReorder_AssignLine4;
.var DTS_ChanReorder_AssignLine5;
.var DTS_ChanReorder_AssignLine6;
.var DTS_ChanReorder_AssignLine7;
.var DTS_ChanReorder_AssignLine8;
.var DTS_ChanReorder_AssignLine9;
.var DTS_ChanReorder_AssignLine10;
.var DTS_ChanReorder_AssignLine11;
.var DTS_ChanReorder_AssignLine12;
.var DTS_ChanReorder_AssignLine13;
.var DTS_ChanReorder_AssignLine14;
.var DTS_ChanReorder_AssignLine15;
.var DTS_ChanReorder_AssignLine16;
.var DTS_ChanReorder_AssignLines_LIB;
.endseg;

/******************************************************************************
*  Module Name        : Channel_Reorder_lib_DTSX
*  Functionality      : Channel ReOrder library for DTSX 
*  Input Parameters	  : r4 - Input list						
*  Output Parameters  : NA
******************************************************************************/
.section/sw seg_dtsx_chorder_code;
.global Channel_Reorder_lib_DTSX.;  
.type Channel_Reorder_lib_DTSX., STT_FUNC;
Channel_Reorder_lib_DTSX.:
entry;

	call saveforCEnv;								// save the registers for C to ASM call
	
	i4 = r4;
	call readinput_List_DTSX;						    // Reads the input list passed to the library
	
	call copyzeroestoBuffer_Full_DTSX;
	
	dm(SingleChannel) = m5;							// Flag to indicate single channel (C, LFE, Cs)

	r4 = dm(ChannelReorder_DTSX_LIB);
	r4 = pass r4;
	if ne call find_channelPointer_DTSX;			// Updates the channel pointers in the input buffer for DTS:X
		
	// LR Routing	
	r12 = 36;//dm(channelcount_based_on_fs.);
	r12 = r12 - 1;
	dm(NxtChPairModifier) = r12;
	m1 = 1;	
	m2 = 0;
	r12 = dm(LR_Chan_Ptr);							// Points to LR channel in the input buffer
	r12 = pass r12;		
	if ne call copychannelstoBuffer_DTSX;
	
	
	// C Routing
	dm(SingleChannel) = m6;
	m2 = 2;
	r12 = dm(C_Chan_Ptr);						   // Points to C channel in the input buffer				
	r12 = pass r12;	
	if ne call copychannelstoBuffer_DTSX;
	dm(SingleChannel) = m5;
	
	// LFE Routing
	dm(SingleChannel) = m6;
	m2 = 3;
	r12 = dm(LFE_Chan_Ptr);						  // Points to LFE channel in the input buffer	
	r12 = pass r12;	
	if ne call copychannelstoBuffer_DTSX;
	dm(SingleChannel) = m5;
	
    // LssRss Routing
	m1 = 1;	
	m2 = 4;
	r12 = dm(LssRss_Chan_Ptr);			         // Points to LssRss channel in the input buffer	
	r12 = pass r12;
	if ne call copychannelstoBuffer_DTSX;		

// Assign Line 1 Routing
check_AL1:
	m2 = 6;
    dm(DTSX_Ch_Reorder_Count) = m2;
    
    dm(DTS_AssignL1_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine1);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL1_Flag) = m5;
	
// Assign Line 2 Routing
check_AL2:
    dm(DTS_AssignL2_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine2);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL2_Flag) = m5;
	
// Assign Line 3 Routing
check_AL3:
    dm(DTS_AssignL3_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine3);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL3_Flag) = m5;

// Assign Line 4 Routing
check_AL4:
    dm(DTS_AssignL4_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine4);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL4_Flag) = m5;	
	
// Assign Line 5 Routing
check_AL5:
    dm(DTS_AssignL5_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine5);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL5_Flag) = m5;
	
// Assign Line 6 Routing
check_AL6:
    dm(DTS_AssignL6_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine6);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL6_Flag) = m5;
	
// Assign Line 7 Routing
check_AL7:
    dm(DTS_AssignL7_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine7);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL7_Flag) = m5;
	
// Assign Line 8 Routing
check_AL8:
    dm(DTS_AssignL8_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine8);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL8_Flag) = m5;
	
// Assign Line 9 Routing
check_AL9:
    dm(DTS_AssignL9_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine9);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL9_Flag) = m5;
	
// Assign Line 10 Routing
check_AL10:
    dm(DTS_AssignL10_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine10);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL10_Flag) = m5;
	
// Assign Line 11 Routing
check_AL11:
    dm(DTS_AssignL11_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine11);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL11_Flag) = m5;
	
// Assign Line 12 Routing
check_AL12:
    dm(DTS_AssignL12_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine12);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL12_Flag) = m5;

// Assign Line 13 Routing
check_AL13:
    dm(DTS_AssignL13_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine13);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL1_Flag) = m5;

// Assign Line 14 Routing
check_AL14:
    dm(DTS_AssignL14_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine14);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL14_Flag) = m5;
	
// Assign Line 15 Routing
check_AL15:
    dm(DTS_AssignL15_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine15);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL15_Flag) = m5;

// Assign Line 16 Routing
check_AL16:
    dm(DTS_AssignL16_Flag) = m6;	
	r4 = dm(DTS_ChanReorder_AssignLine16);
	call ChanReorder_function_DTSX;
	dm(DTS_AssignL16_Flag) = m5;
		
unsave_exit:	
	call unsaveforCEnv;								// unsave the registers when returning back to C from ASM
	
    i12=dm(m7,i6);
    jump (m14,i12) (db); 
	rframe; nop;
	rts;
.Channel_Reorder_lib_DTSX..end:
.endseg;

/******************************************************************************
*  Module Name        : ChanReorder_function_DTSX
*  Functionality      : Routes the required channels to the Assign Lines 
*  Input Parameters	  : m2 - Modifier of pointer of the Output buffer
						r4 - Assign Line value
*  Output Parameters  : NIL
******************************************************************************/

.global  ChanReorder_function_DTSX;
.type ChanReorder_function_DTSX,STT_FUNC;
ChanReorder_function_DTSX:	

Check_None:
	r2 = 0;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_5;
	jump General_Check_routine;
	
Check_Reservedbyte_5:
	r2 = 5;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_7;
	jump General_Check_routine;
	
Check_Reservedbyte_7:
	r2 = 7;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_8;
	jump General_Check_routine;	

Check_Reservedbyte_8:
	r2 = 8;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_9;
	jump General_Check_routine;
	
Check_Reservedbyte_9:
	r2 = 9;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_11;
	jump General_Check_routine;
	
Check_Reservedbyte_11:
	r2 = 11;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_12;
	jump General_Check_routine;	
	
Check_Reservedbyte_12:
	r2 = 12;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_17;
	jump General_Check_routine;	
	
Check_Reservedbyte_17:
	r2 = 17;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_18;
	jump General_Check_routine;
	
Check_Reservedbyte_18:
	r2 = 18;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_20;
	jump General_Check_routine;
	
Check_Reservedbyte_20:
	r2 = 20;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_21;
	jump General_Check_routine;
	
Check_Reservedbyte_21:
	r2 = 21;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_23;
	jump General_Check_routine;	
	
Check_Reservedbyte_23:
	r2 = 23;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_26;
	jump General_Check_routine;
	
Check_Reservedbyte_26:
	r2 = 26;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_29;
	jump General_Check_routine;
	
Check_Reservedbyte_29:
	r2 = 29;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_30;
	dm(SingleChannel) = m6;
	jump General_Check_routine;
	
Check_Reservedbyte_30:
	r2 = 30;
	comp(r2,r4);
	if ne jump Check_Reservedbyte_31;
	jump General_Check_routine;
						
Check_Reservedbyte_31:
	r2 = 31;
	comp(r2,r4);
	if ne jump Check_Surrback;
							
General_Check_routine:	
	r2 = dm(DTSX_Ch_Reorder_Count);
	r12 = 2;
	r5 = dm(SingleChannel);
	r5 = pass r5;
	if eq jump modify_channel;
	r12 = 1;
modify_channel:
	r2 = r2 + r12;
	dm(DTSX_Ch_Reorder_Count) = r2;
	jump ChanReorder_function_DTSX_end;
	
	
Check_Surrback:
	m2 = dm(DTSX_Ch_Reorder_Count);
	
	r2 = 1;
	comp(r2,r4);
	if ne jump Check_FrontWide; 

	r2 = 2;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	r12 = dm(LrsRrs_Chan_Ptr);								// Points to LrsRrs channel in the input buffer	
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;

	jump copychannelsRoutine;
	
Check_FrontWide:

	r2 = 2;
	comp(r2,r4);
	if ne jump Check_FrontHeight;
	
	r2 = 2;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	r12 = dm(LwRw_Chan_Ptr);								// Points to LwRw channel in the input buffer
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;	

	jump copychannelsRoutine;
	
Check_FrontHeight:

	r2 = 3;
	comp(r2,r4);
	if ne jump Check_TopFront;
	
	r2 = 2;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	r12 = dm(Lfh_Chan_Ptr);                                // Points to Lh  channel in the input buffer
	r12 = pass r12;
	dm(SingleChannel) = m6;
	dm(SaveOutBufChLoc.) = m2;
	if ne call copychannelstoBuffer_DTSX; 
		
	r12 = dm(SaveOutBufChLoc.);
	r12 = r12 + 1;
	dm(SaveOutBufChLoc.) = r12;	
	r12 = dm(Rfh_Chan_Ptr);                                // Points to Rh channel in the input buffer
	r12 = pass r12;
	dm(SingleChannel) = m6;
	dm(DTSX_Lh_Rh_flag) = m6; 
	m2 = dm(SaveOutBufChLoc.);
	
	if eq jump ChanReorder_function_DTSX_end;

	jump copychannelsRoutine;
	
Check_TopFront:

    r2 = 4;
	comp(r2,r4);
	if ne jump Check_SideHeight ;
	
	r2 = 2;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	r12 = dm(LtfRtf_Chan_Ptr);								// Points to LtfRtf channel in the input buffer
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;	

	jump copychannelsRoutine;
	
Check_SideHeight:

    r2 = 6;
    comp(r2,r4);
    if ne jump Check_TopRear ;
	
	r2 = 2;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	r12 = dm(LhsRhs_Chan_Ptr);								// Points to LhsRhs channel in the input buffer
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;	

	jump copychannelsRoutine;
       
	
Check_TopRear:

    r2 = 10;
	comp(r2,r4);
	if ne jump Check_RearHt ;
	
	r2 = 2;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	r12 = dm(LtrRtr_Chan_Ptr);								// Points to LtrRtr channel in the input buffer
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;	

	jump copychannelsRoutine;
	
Check_RearHt:

    r2 = 13;
	comp(r2,r4);
	if ne jump Check_Htcenter ;
	
	r2 = 2;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	r12 = dm(LrhRrh_Chan_Ptr);								// Points to LhrRhr channel in the input buffer
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;	

	jump copychannelsRoutine;

Check_Htcenter:

	r2 = 14;
	comp(r2,r4);
	if ne jump Check_RearHtCenter; 
		
	r2 = 1;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	dm(SingleChannel) = m6;
	
	r12 = dm(Ch_Chan_Ptr);								// Points to Ch channel in the input buffer	
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;
	
	jump copychannelsRoutine;
	
Check_RearHtCenter:

	r2 = 15;
	comp(r2,r4);
	if ne jump Check_OverHead; 
		
	r2 = 1;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	dm(SingleChannel) = m6;
	
	r12 = dm(CHr_Chan_Ptr);									// Points to Chr channel in the input buffer	
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;

	jump copychannelsRoutine;

Check_OverHead:

    r2 = 16;
	comp(r2,r4);
	if ne jump Check_SideSurr ;
		
	r2 = 1;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	dm(SingleChannel) = m6;
	
	r12 = dm(Oh_Chan_Ptr);								// Points to Oh channel in the input buffer
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;	

	jump copychannelsRoutine;
	
 Check_SideSurr:	

    r2 = 19;
	comp(r2,r4);
	if ne jump Check_CenterSurr ;
		
	r2 = 2;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	r12 = dm(LsRs_Chan_Ptr);								// Points to LsRs channel in the input buffer
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;	

	jump copychannelsRoutine;
	
Check_CenterSurr:

    r2 = 22;
	comp(r2,r4);
	if ne jump Check_LowFront ;
		
	r2 = 1;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	dm(SingleChannel) = m6;
	
	r12 = dm(Cs_Chan_Ptr);								// Points to Cs channel in the input buffer
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;	

	jump copychannelsRoutine;
	
Check_LowFront:

    r2 = 24;
	comp(r2,r4);
	if ne jump Check_CenterLowFront ;
		
	r2 = 2;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	r12 = dm(LlfRlf_Chan_Ptr);								// Points to Llf Rlf channel in the input buffer
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;	

	jump copychannelsRoutine;
	
Check_CenterLowFront:

    r2 = 25;
	comp(r2,r4);
	if ne jump Check_FrontCenter  ;
		
	r2 = 1;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	dm(SingleChannel) = m6;
	
	r12 = dm(Clf_Chan_Ptr);								// Points to Clf channel in the input buffer
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;	

	jump copychannelsRoutine;
	
Check_FrontCenter:

    r2 = 27;
	comp(r2,r4);
	if ne jump Check_Lfe2  ;
		
	r2 = 2;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	r12 = dm(LcRc_Chan_Ptr);								// Points to LcRc channel in the input buffer
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;	

	jump copychannelsRoutine;
	
Check_Lfe2:

    r2 = 28;
	comp(r2,r4);
	if ne jump ChanReorder_function_DTSX_end ;
		
	r2 = 1;
	r0 = dm(DTSX_Ch_Reorder_Count);
	r0 = r0 + r2;
	dm(DTSX_Ch_Reorder_Count) = r0 ;
	
	dm(SingleChannel) = m6;	
	
	r12 = dm(LFE2_Chan_Ptr);								// Points to Lfe2 channel in the input buffer
	r12 = pass r12;
	if eq jump ChanReorder_function_DTSX_end;

copychannelsRoutine:
	call copychannelstoBuffer_DTSX;
	
ChanReorder_function_DTSX_end:
	r12 = dm(DTSX_Lh_Rh_flag);                                
	r12 = pass r12;
	if eq jump single_ch_clr; 
	dm(SingleChannel) = m5;
	dm(DTSX_Lh_Rh_flag) = m5;
	
single_ch_clr:		
	rts;
.ChanReorder_function_DTSX.end:

/******************************************************************************
*  Module Name        : copychannelstoBuffer_DTSX
*  Functionality      : Copies upto two channels from input buffer to output buffer in interleaved order
*  Input Parameters	  : r12 - Contains the start address of the channel to be copied
						m2 - modifier to update the pointer of the Channel ReOrder output buffer
*  Output Parameters  : NA
******************************************************************************/
.section/sw seg_dtsx_chorder_code;
.global copychannelstoBuffer_DTSX;
.type copychannelstoBuffer_DTSX, STT_FUNC;
copychannelstoBuffer_DTSX:

	l1 = dm(ChanReorder_InBufLen_LIB); b1 = dm(ChanReorder_InBufHeap_LIB);
	i1 =  r12; //r12 - CHAN POINTER
	
	l0 = dm(ChanReorder_OutBufLen_LIB); b0 = dm(ChanReorder_OutBufHeap_LIB);
	i0 = dm(ChanReorder_OutBufPtr_LIB); 
	
	r10 = SAMPLEBLOCK;	
	modify(i0, m2)(nw);	      //m2 - CHAN NUMBER   m1 - 2,m4 - 30,m2 -0
	b2 = i1;                  //i2 - internal predac(succ sample),i0- ext predac(inter) m1 = 1; m4 = 30;

	r0 = dm(SingleChannel);
	r0 = pass r0;
	if ne jump Single_Channel_copy;
	m4 = dm(NxtChPairModifier);
	l2 = SAMPLEBLOCK*2; m3 = r10; m2 = SAMPLEBLOCK+1;
	lcntr = r10, do cpy_chan until lce;			    		
			    r1 = dm(i2, m3);
			    r2 = dm(i2, m2);
			    
				dm(i0, m1) = r1;	 
cpy_chan:		dm(i0, m4) = r2;

	i2 = b2;
	l2 = 0;
	modify(i2,512)(nw); //SAMPLEBLOCK*2
	jump copychannelstoBuffer_end;

Single_Channel_copy:
	m3 = 36;/*dm(channelcount_based_on_fs.);*/ l2 = SAMPLEBLOCK;
	lcntr = r10, do cpy_chan1 until lce;			    		
			    r1 = dm(i2,m6);
cpy_chan1:		dm(i0,m3) = r1;		
	
	i2 = b2;
	l2 = 0;
	modify(i2,256)(nw);//SAMPLEBLOCK
copychannelstoBuffer_end:
	dm(ChanReorder_InBufHeap_LIB_Ptr) = i2;			// Updates the read ptr of the remaining channels for default configuration
	
	l0=0; l1=0; l2=0;
	rts;
.copychannelstoBuffer_DTSX.end:
.endseg;

.section/sw seg_dtsx_chorder_code;
.global copyzeroestoBuffer_Full_DTSX;
.type copyzeroestoBuffer_Full_DTSX,STT_FUNC; 
copyzeroestoBuffer_Full_DTSX:
	
	l0 = dm(ChanReorder_OutBufLen_LIB); b0 = dm(ChanReorder_OutBufHeap_LIB);
	i0 = dm(ChanReorder_OutBufPtr_LIB);  	

	r10 = BUFF_MAX_SIZE;
	lcntr = r10, do cpy_zeroes until lce;		    						
cpy_zeroes: dm(i0, m6) = 0;	

	l0=0; 
	rts;
.copyzeroestoBuffer_Full_DTSX.end:
.endseg;

/******************************************************************************
*  Module Name        : readinput_List_DTSX
*  Functionality      : Reads Data from input list buffer and stores in respective library variables 
*  Input Parameters	  : i4 - Base address of Input list buffer						
*  Output Parameters  : NA
******************************************************************************/
.section/sw seg_dtsx_chorder_code;
.global readinput_List_DTSX;
.type readinput_List_DTSX,STT_FUNC;
readinput_List_DTSX:

	r0 = dm(i4, m6);
	dm(ChanReorder_inputConfig_LIB) = r0;					// Input Channel Configuration
	
	r0 = dm(i4, m6);
	dm(DTS_ChanReorder_AssignLines_LIB) = r0;	            // Assign Lines values
	
	r1 = fext r0 by 0:5;
	dm(DTS_ChanReorder_AssignLine1) = r1;					// Assign Line 1 value bit[4:0]
	
	r1 = fext r0 by 5:5;
	dm(DTS_ChanReorder_AssignLine2) = r1;					// Assign Line 2 value bit[9:5]
	
	r1 = fext r0 by 10:5;
	dm(DTS_ChanReorder_AssignLine3) = r1;					// Assign Line 3 value bit[14:10]
	
	r1 = fext r0 by 15:5;
	dm(DTS_ChanReorder_AssignLine4) = r1;					// Assign Line 4 value bit[19:15]
	
	r1 = fext r0 by 20:5;
	dm(DTS_ChanReorder_AssignLine5) = r1;					// Assign Line 5 value bit[24:20]
	
	r1 = fext r0 by 25:5;
	dm(DTS_ChanReorder_AssignLine6) = r1;					// Assign Line 6 value bit[29:25]
	
	r0 = dm(i4, m6);
	dm(DTS_ChanReorder_AssignLines_LIB) = r0;	            // Assign Lines values
	
	r1 = fext r0 by 0:5;
	dm(DTS_ChanReorder_AssignLine7) = r1;					// Assign Line 7 value bit[4:0]
	
	r1 = fext r0 by 5:5;
	dm(DTS_ChanReorder_AssignLine8) = r1;					// Assign Line 8 value bit[9:5]
	
	r1 = fext r0 by 10:5;
	dm(DTS_ChanReorder_AssignLine9) = r1;					// Assign Line 9 value bit[14:10]
	
	r1 = fext r0 by 15:5;
	dm(DTS_ChanReorder_AssignLine10) = r1;					// Assign Line 10 value bit[19:15]
	
	r1 = fext r0 by 20:5;
	dm(DTS_ChanReorder_AssignLine11) = r1;					// Assign Line 11 value bit[24:20]
	
	r1 = fext r0 by 25:5;
	dm(DTS_ChanReorder_AssignLine12) = r1;					// Assign Line 12 value bit[29:25]
	
	r0 = dm(i4, m6);
	dm(DTS_ChanReorder_AssignLines_LIB) = r0;	            // Assign Lines values
	
	r1 = fext r0 by 0:5;
	dm(DTS_ChanReorder_AssignLine13) = r1;					// Assign Line 13 value bit[4:0]
	
	r1 = fext r0 by 5:5;
	dm(DTS_ChanReorder_AssignLine14) = r1;					// Assign Line 14 value bit[9:5]
	
	r1 = fext r0 by 10:5;
	dm(DTS_ChanReorder_AssignLine15) = r1;					// Assign Line 15 value bit[14:10]
	
	r1 = fext r0 by 15:5;
	dm(DTS_ChanReorder_AssignLine16) = r1;					// Assign Line 16 value bit[19:15]
	
	r0 = dm(i4, m6);
	dm(ChanReorder_InBufHeap_LIB) = r0;						// Base Address of input buffer
	
	r0 = dm(i4, m6);
	dm(ChanReorder_InBufPtr_LIB) = r0;						// Pointer of input buffer
	
	r0 = dm(i4, m6);
	dm(ChanReorder_InBufLen_LIB) = r0;						// Length of input buffer
	
	r0 = dm(i4, m6);
	dm(ChanReorder_OutBufHeap_LIB) = r0;					// Base Address of output buffer
	
	r0 = dm(i4, m6);
	dm(ChanReorder_OutBufPtr_LIB) = r0;						// Pointer of output buffer
		
	r0 = dm(i4, m6);
	dm(ChanReorder_OutBufLen_LIB) = r0;						// Length of output buffer	
	
	r0 = dm(i4, m6);
	dm(ChannelReorder_DTSX_LIB) = r0;						// DTS X flag 
	
	r0 = dm(i4,m6);
	dm(Lsrs_swap_flag) = r0;						        // DTS LSRS Swap flag 	

	rts;
.readinput_List_DTSX.end:
.endseg;

/******************************************************************************
*  Module Name        : find_channelPointer_DTSX
*  Functionality      : Updates the channel pointers in the input buffer for DTS:X
*  Input Parameters	  : NA
*  Output Parameters  : NA
******************************************************************************/
.section/sw seg_dtsx_chorder_code;
.global find_channelPointer_DTSX;
.type find_channelPointer_DTSX,STT_FUNC;
find_channelPointer_DTSX:

	dm(SurrHt_Chan_Ptr) = m5;

	l0 = dm(ChanReorder_InBufLen_LIB); b0 = dm(ChanReorder_InBufHeap_LIB);
	i0 = dm(ChanReorder_InBufPtr_LIB);	m2 = SAMPLEBLOCK*2;	m1 = SAMPLEBLOCK;
	
	r8 = dm(ChanReorder_inputConfig_LIB);
	
	dm(C_Chan_Ptr) = m5;	
	r1 = fext r8 by 0:1;
	if sz jump Nextch_LR_X;
	dm(C_Chan_Ptr) = i0;
	modify(i0, m1)(nw);	

Nextch_LR_X:
	dm(LR_Chan_Ptr) = m5;
	r1 = fext r8 by 1:1;
	if sz jump Swap_check_LSRS;	
	dm(LR_Chan_Ptr) = i0;
	modify(i0, m2)(nw);	
	
Swap_check_LSRS:
	r0 = dm(Lsrs_swap_flag);
	r0 = pass r0;
	if ne jump Nextch_LFE_X;
	call Nextch_LsRs_X;
	
Nextch_LFE_X:
	dm(LFE_Chan_Ptr) = m5;			
	r1 = fext r8 by 3:1;
	if sz jump Nextch_Cs_X;
	dm(LFE_Chan_Ptr) = i0;
	modify(i0, m1)(nw);
	
Nextch_Cs_X:	
	dm(Cs_Chan_Ptr) = m5;		
	r1 = fext r8 by 4:1;
	if sz jump Nextch_LrsRrs_X;
	dm(Cs_Chan_Ptr) = i0;	
	modify(i0, m1)(nw);
		
Nextch_LrsRrs_X:
	dm(LrsRrs_Chan_Ptr) = m5;			
	r1 = fext r8 by 6:1;
	if sz jump Nextch_LssRss_X;
	dm(LrsRrs_Chan_Ptr) = i0;	
	modify(i0, m2)(nw);
	
Nextch_LssRss_X:
	dm(LssRss_Chan_Ptr) = m5;			
	r1 = fext r8 by 11:1;
	if sz jump Nextch_LcRc_X;
	dm(LssRss_Chan_Ptr) = i0;	
	modify(i0, m2)(nw);	
	
Nextch_LcRc_X:	
	dm(LcRc_Chan_Ptr) = m5;		
	r1 = fext r8 by 9:1;
	if sz jump Nextch_LfhRfh_X;
	dm(LcRc_Chan_Ptr) = i0;
	modify(i0, m2)(nw);	
	
Nextch_LfhRfh_X:	
	dm(Lfh_Chan_Ptr) = m5;		
	r1 = fext r8 by 5:1;
	if sz jump Nextch_Ch_X;
	dm(Lfh_Chan_Ptr) = i0;
	modify(i0, m1)(nw);
	
Nextch_Ch_X:
	dm(Ch_Chan_Ptr) = m5; 	
	r1 = fext r8 by 7:1;
	r1 = pass r1;
	if eq jump Nextch_Rfh_X;
	dm(Ch_Chan_Ptr) = i0; 
	modify(i0, m1)(nw);
		
Nextch_Rfh_X:
	dm(Rfh_Chan_Ptr) = m5;	
	r1 = fext r8 by 5:1;
	if sz jump Nextch_LFE2_X;
	dm(Rfh_Chan_Ptr) = i0;
	modify(i0, m1)(nw);
	
Nextch_LFE2_X:
	dm(LFE2_Chan_Ptr) = m5;			
	r1 = fext r8 by 12:1;
	if sz jump Nextch_LwRw_X;
	dm(LFE2_Chan_Ptr) = i0;	
	modify(i0, m1)(nw);		
		
Nextch_LwRw_X:
	dm(LwRw_Chan_Ptr) = m5;			
	r1 = fext r8 by 10:1;
	if sz jump Nextch_Oh_X;
	dm(LwRw_Chan_Ptr) = i0;
	modify(i0, m2)(nw);	
	
Nextch_Oh_X:
	dm(Oh_Chan_Ptr) = m5;			
	r1 = fext r8 by 8:1;
	if sz jump Nextch_LhsRhs_X;
	dm(Oh_Chan_Ptr) = i0;	
	modify(i0, m1)(nw);		
	
Nextch_LhsRhs_X:	
	dm(LhsRhs_Chan_Ptr) = m5;		
	r1 = fext r8 by 13:1;
	if sz jump Nextch_CHr_X;
	dm(LhsRhs_Chan_Ptr) = i0;	
	modify(i0, m2)(nw);	
	
Nextch_CHr_X:
	dm(CHr_Chan_Ptr) = m5;			
	r1 = fext r8 by 14:1;
	if sz jump Nextch_LrhRrh_X;
	dm(CHr_Chan_Ptr) = i0;	
	modify(i0, m1)(nw);		
	
Nextch_LrhRrh_X:
	dm(LrhRrh_Chan_Ptr) = m5;			
	r1 = fext r8 by 15:1;
	if sz jump Nextch_Clf_X;
	dm(LrhRrh_Chan_Ptr) = i0;	
	modify(i0, m2)(nw);	
	
Nextch_Clf_X:
	dm(Clf_Chan_Ptr) = m5;			
	r1 = fext r8 by 16:1;
	if sz jump Nextch_LlfRlf_X;
	dm(Clf_Chan_Ptr) = i0;	
	modify(i0, m1)(nw);			
	
Nextch_LlfRlf_X:
	dm(LlfRlf_Chan_Ptr) = m5;			
	r1 = fext r8 by 17:1;
	if sz jump Nextch_LtfRtf_X;
	dm(LlfRlf_Chan_Ptr) = i0;	
	modify(i0, m2)(nw);		
	
Nextch_LtfRtf_X:	
	dm(LtfRtf_Chan_Ptr) = m5;		
	r1 = fext r8 by 18:1;
	if sz jump Nextch_LtrRtr_X;
	dm(LtfRtf_Chan_Ptr) = i0;	
	modify(i0, m2)(nw);
	
Nextch_LtrRtr_X:	
	dm(LtrRtr_Chan_Ptr) = m5;		
	r1 = fext r8 by 19:1;
	if sz jump Check_LSRS;
	dm(LtrRtr_Chan_Ptr) = i0;	
	modify(i0, m2)(nw);
	
Check_LSRS:
	r0 = dm(Lsrs_swap_flag);
	r0 = pass r0;
	if eq jump channelPointer_end_X;
	call Nextch_LsRs_X;
		
channelPointer_end_X:	
	l0 = 0;
	rts;
.find_channelPointer_DTSX.end:
.endseg;

.section/sw  seg_dtsx_chorder_code;
.global Nextch_LsRs_X;    
Nextch_LsRs_X:	
	m2 = SAMPLEBLOCK*2;
	dm(LsRs_Chan_Ptr) = m5;	
	r1 = fext r8 by 2:1;
	if sz jump nomodify_ptr;
	dm(LsRs_Chan_Ptr) = i0;
	modify(i0, m2)(nw);
nomodify_ptr:
	rts;
Nextch_LsRs_X.end:
.endseg;	
#endif //DTSX_CHANREORDER

