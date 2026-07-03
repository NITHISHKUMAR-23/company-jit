/*****************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Customerasm.asm
*  Description      : Customer Post processing asm functions

******************************************************************************/
#include "def21593.h"
#include "asm_sprt.h"
.IMPORT "..\src\System\Include\Def_Struct.h";
#include "..\src\System\Include\Commn.h"

.section/DM  Seg_Sdram_Ext;
.var save_buff[20];
.endseg;

.extern Predac_buffer_Cust_PP.;
.extern struct kernel Frmwk.;
.extern Predac_buffer_Int_c2.;
.extern CustomerPP_Buffer.;
.extern saveforCEnv;
.extern unsaveforCEnv;

.section/sw  Seg_CustomerPP_Code;
/******************************************************************************
*  Module Name        : floattofixConversion
*  Functionality      : This Routine Convert the Floating Format datas 
*					   into Fixed Format datas 
*  Input Parameters   : None
*  Output Parameters  : None
******************************************************************************/
.global floattofixConversion.;
.type floattofixConversion., STT_FUNC;
floattofixConversion.:						
    call saveforCEnv;
	/********Float to fix conversion for CustomerPP_Buffer *******/
	l1 = PP_BUFF_MAX_SIZE; 
	b1 = CustomerPP_Buffer.;
	i1 = CustomerPP_Buffer.;
	
	r0=dm(Frmwk.->ADI_DecoderError); 
	
	r0=pass r0;
	
	if ne jump Fill_Zero1;
	
	r1=31;
	
	r0 = PP_BUFF_MAX_SIZE;
	 
	lcntr = r0 , do Cpy2PreDacBufinFIX until lce;
	 		f0 = dm(i1,m5);  
	        r0 = fix f0 by r1;
		   
    Cpy2PreDacBufinFIX:dm(i1,m6) = r0; 
    jump end_copy1;
    
    Fill_Zero1:
    r1 = 0;
    r0 = PP_BUFF_MAX_SIZE;
	lcntr = r0 , do Cpy2PreDacBufinFIX2 until lce;
    Cpy2PreDacBufinFIX2:dm(i1,m6) = r1; 
    end_copy1:
    
    	call unsaveforCEnv;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;                      
		
floattofixConversion..END:

/******************************************************************************
*  Module Name        : fixtofloatConversion
*  Functionality      : This Routine Process Convert Fixed Format datas 
                      into Floating Format datas
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/
.global fixtofloatConversion.;	
.type fixtofloatConversion., STT_FUNC;			
fixtofloatConversion.:
	
	/***********Fix to float conversion for CustomerPP_Buffer *******/
	call saveforCEnv;
	
	l1 = PP_BUFF_MAX_SIZE ; b1 =CustomerPP_Buffer.;
	i1 = CustomerPP_Buffer.;
	
	r1=-31;	
	r0= PP_BUFF_MAX_SIZE;
	
	lcntr = r0 , do Cpy2PreDacinFloat until lce;
 		r0 = dm(i1,m5);  
	    f0 = float r0 by r1;
    Cpy2PreDacinFloat:dm(i1,m6) = f0;       
	
	call unsaveforCEnv;
	i12=dm(m7,i6);
	jump (m14,i12) (db); rframe; nop;
fixtofloatConversion..END:

/******************************************************************************
*  Module Name        : PreDac_Int_To_Cust_PP_Buffer
*  Functionality      : This Routine Process is to copy Predac_buffer_Int 
                	   to CustomerPP_buffer	
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/
.global PreDac_Int_To_Cust_PP_Buffer.;	
.type PreDac_Int_To_Cust_PP_Buffer., STT_FUNC;			
PreDac_Int_To_Cust_PP_Buffer.:
     call saveforCEnv;
     
     i1 = CustomerPP_Buffer.; 
     l1 = 0;  
     i0 = Predac_buffer_Int_c2.;
     l0 = 0;
     
   
       
     r0 = NO_OF_SAMPLE_PROCESSING;
     
     BIT SET MODE1 BITM_REGF_MODE1_PEYEN;
     nop;nop;nop;nop;nop;nop;
     
     lcntr = r0 , do Cpy2Cust_PP until lce;
        r2 = dm(i0,2);  //1&2 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //3&4 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //5&6 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //7&8 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //9&10 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //11&12 channels
        dm(i1,2) = r2;  
        r2 = dm(i0,2);  //13&14 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //15&16 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //17&18 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //19&20 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //21&22 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //23&24 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //25&26 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //27&28 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //29&30 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //31&32 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //33&34 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //35&36 channels

	Cpy2Cust_PP: dm(i1,2) = r2; 
    
     BIT clr MODE1 BITM_REGF_MODE1_PEYEN;
     nop;nop;nop;nop;nop;nop;
     
       call unsaveforCEnv;
        
  	   i12=dm(m7,i6);
	   jump (m14,i12) (db); rframe; nop;
PreDac_Int_To_Cust_PP_Buffer..END:

/******************************************************************************
*  Module Name        : Cust_PP_To_PreDac_Int_Buffer
*  Functionality      : This Routine Process is to copy CustomerPP_buffer 
                	   to Predac_buffer_Int	
*  Input Parameters	  : None
*  Output Parameters  : None
******************************************************************************/
.global Cust_PP_To_PreDac_Int_Buffer.;	
.type Cust_PP_To_PreDac_Int_Buffer., STT_FUNC;			
Cust_PP_To_PreDac_Int_Buffer.:
     call saveforCEnv;
     
     i0 = CustomerPP_Buffer.; 
     l0 = 0;  
     i1 = Predac_buffer_Int_c2.;
     l1 = 0; 
     
     r0=dm(Frmwk.->ADI_DecoderError); 
     r0=pass r0;
     if ne jump Fill_Zero;
     

     
     r0 = NO_OF_SAMPLE_PROCESSING;
     
     BIT SET MODE1 BITM_REGF_MODE1_PEYEN;
     nop;nop;nop;nop;nop;nop;
     
    lcntr = r0 , do Cpy2Predac_int until lce;
        r2 = dm(i0,2);  //1&2 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //3&4 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //5&6 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //7&8 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //9&10 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //11&12 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //13&14 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //15&16 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //17&18 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //19&20 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //21&22 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //23&24 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //25&26 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //27&28 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //29&30 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //31&32 channels
        dm(i1,2) = r2; 
        r2 = dm(i0,2);  //33&34 channels
        dm(i1,2) = r2;
        r2 = dm(i0,2);  //35&36 channels

    Cpy2Predac_int: dm(i1,2) = r2;
     
     BIT clr MODE1 BITM_REGF_MODE1_PEYEN;
     nop;nop;nop;nop;nop;nop;
     
    jump end_copy;
    Fill_Zero:
    r1=0;
    r0=BUFF_MAX_SIZE;
	lcntr = r0 , do Cpy2PreDacBufinFIX1 until lce;
    Cpy2PreDacBufinFIX1:dm(i1,m6) = r1; 
    end_copy:
     
     call unsaveforCEnv;
        
  	   i12=dm(m7,i6);
	   jump (m14,i12) (db); rframe; nop;
Cust_PP_To_PreDac_Int_Buffer..END:

.endseg;