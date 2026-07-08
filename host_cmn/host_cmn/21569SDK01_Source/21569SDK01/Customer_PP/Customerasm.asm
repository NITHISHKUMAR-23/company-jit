#include "def21573.h"
#include "asm_sprt.h"
.IMPORT "..\src\System\Include\Def_Struct.h";
#include "..\src\System\Include\Adr_Lkup_Tab_Macros.h"
#include "..\src\System\Include\Commn.h"
.extern Predac_buffer_Cust_PP.;
.section/DM  seg_sdram_ext;
.var save_buff[20];
.endseg;
.extern struct kernel Frmwk.;
.extern Predac_buffer_Int.;
.extern CustomerPP_Buffer.;

.section/sw  seg_Customer_code;
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
    I_ACALL (saveforCEnv);

	/********Float to fix conversion for CustomerPP_Buffer *******/
	l1 = dm(PP_BUFF_MAX_SIZE_Var.);   
	b1 = CustomerPP_Buffer.;
	i1 = CustomerPP_Buffer.;
	
	r0=dm(Frmwk.->ADI_DecoderError); 
	
	r0=pass r0;
	
	if ne jump Fill_Zero;
	
	r1=31;
	
	r0=dm(PP_BUFF_MAX_SIZE_Var.); 
	
    bit CLR mode1  BITM_REGF_MODE1_RND32;
    nop; nop;
    bit SET mode1 BITM_REGF_MODE1_ALUSAT;
    nop; nop;
	 
	lcntr = r0 , do Cpy2PreDacBufinFIX until lce;
	 		f0 = dm(i1,m5);  
	        r0 = fix f0 by r1;
		   
    Cpy2PreDacBufinFIX:dm(i1,m6) = r0; 
    
    bit SET mode1  BITM_REGF_MODE1_RND32;
    nop; nop;
    bit CLR mode1 BITM_REGF_MODE1_ALUSAT;
    nop; nop;

    I_ACALL (unsaveforCEnv);
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
	I_ACALL (saveforCEnv);
	
	l1 = dm(PP_BUFF_MAX_SIZE_Var.);
	b1 =CustomerPP_Buffer.;
	i1 = CustomerPP_Buffer.;
	
	r1=-31;	
	r0= dm(PP_BUFF_MAX_SIZE_Var.);
	
	lcntr = r0 , do Cpy2PreDacinFloat until lce;
 		r0 = dm(i1,m5);  
	    f0 = float r0 by r1;
    Cpy2PreDacinFloat:dm(i1,m6) = f0;       
	
	I_ACALL (unsaveforCEnv);
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
     I_ACALL (saveforCEnv);
     
     i15 = CustomerPP_Buffer.;   
     i0 = Predac_buffer_Int.;
       
     r0 = NO_OF_SAMPLE_PROCESSING;
    // r0 = lshift r0 by -1;
    
     m2 = 2;
     m12 = 2;
     
    r3 = dm(TX_DAC_Output_Ch_Cnt.);
	r4 = 3;
	m11 = 14;
	comp(r3,r4);
	if eq jump Channel_pp_copy_6_16;
	
	r4 = 2;
	m11 = 8;
	comp(r3,r4);
	if eq jump Channel_pp_copy_6_16;

	m11 = 6; //16 ch
    
Channel_pp_copy_6_16:
	 BIT SET MODE1 BITM_REGF_MODE1_PEYEN;
     nop;nop;nop;nop;nop;nop;
     
     lcntr = r0 , do Cpy2Cust_PP until lce;
       r1 = dm(i0,m2);
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //1&2 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //3&4 channels
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //5&6 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //7&8 channels
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //9&10 channels
                       pm(i15,m11) = r2;  //11&12 channels
     Cpy2Cust_PP: modify(i0,20) (nw); //skip 20 channels
     
     BIT clr MODE1 BITM_REGF_MODE1_PEYEN;
     nop;nop;nop;nop;nop;nop;
       I_ACALL (unsaveforCEnv);
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
     I_ACALL (saveforCEnv);
     
     i0 = CustomerPP_Buffer.;   
     i15 = Predac_buffer_Int.;
     
     r0=dm(Frmwk.->ADI_DecoderError); 
     r0=pass r0;
     if ne jump Fill_Zero;
     
     
     m2 = 2;
     m12 = 2;
     
     
     r0 = NO_OF_SAMPLE_PROCESSING;
     
    r3 = dm(TX_DAC_Output_Ch_Cnt.);
	r4 = 1;
	m11 = 16;
	comp(r3,r4);
	if eq jump Channel_pp_copy_16;
	
	r4 = 2;
	m11 = 14;
	comp(r3,r4);
	if eq jump Channel_pp_copy_18;
	
	m11 = 8;  //modifier for 24 ch
	
Channel_pp_copy_24:
     BIT SET MODE1 BITM_REGF_MODE1_PEYEN;
     nop;nop;nop;nop;nop;nop; 
   
       lcntr = r0 , do  Cpy2Predac_int_24 until lce;
       r1 = dm(i0,m2);
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //1&2 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //3&4 channels
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //5&6 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //7&8 channels
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //9&10 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //11&12 channels
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //13&14 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //15&16 channels
       r1 = dm(i0,m2), pm(i15,m12) = r1;  //17&18 channels
       r1 = dm(i0,m2), pm(i15,m12) = r1;  //19&20 channels
       r1 = dm(i0,m2), pm(i15,m12) = r1;  //21&22 channels
       				   pm(i15,m12) = r1;  //23&24 channels   	
     Cpy2Predac_int_24: modify(i15,m11) (nw); //skip remaining channels
	      
     BIT clr MODE1 BITM_REGF_MODE1_PEYEN;
     nop;nop;nop;nop;nop;nop;
     
    jump end_copy;
Channel_pp_copy_18:
 	 BIT SET MODE1 BITM_REGF_MODE1_PEYEN;
     nop;nop;nop;nop;nop;nop; 
   
       lcntr = r0 , do  Cpy2Predac_int_18 until lce;
       r1 = dm(i0,m2);
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //1&2 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //3&4 channels
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //5&6 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //7&8 channels
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //9&10 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //11&12 channels
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //13&14 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //15&16 channels
                       pm(i15,m12) = r1;  //17&18 channels    	
     Cpy2Predac_int_18: modify(i15,m11) (nw); //skip remaining channels
	      
     BIT clr MODE1 BITM_REGF_MODE1_PEYEN;
     nop;nop;nop;nop;nop;nop;
     
    jump end_copy;
Channel_pp_copy_16:
	 BIT SET MODE1 BITM_REGF_MODE1_PEYEN;
     nop;nop;nop;nop;nop;nop; 
     //r0 = lshift r0 by -1;
   
   
       lcntr = r0 , do  Cpy2Predac_int_16 until lce; 
       r1 = dm(i0,m2);
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //1&2 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //3&4 channels
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //5&6 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //7&8 channels
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //9&10 channels
       r1 = dm(i0,m2), pm(i15,m12) = r2;  //11&12 channels
       r2 = dm(i0,m2), pm(i15,m12) = r1;  //13&14 channels
                       pm(i15,m12) = r2;  //15&16 channels  	
     Cpy2Predac_int_16: modify(i15,m11) (nw); //skip remaining channels
	      
     BIT clr MODE1 BITM_REGF_MODE1_PEYEN;
     nop;nop;nop;nop;nop;nop;
     
    jump end_copy;

    Fill_Zero:
    r1=0;
    r0= BUFF_MAX_SIZE;
	lcntr = r0 , do Cpy2PreDacBufinFIX1 until lce;
    Cpy2PreDacBufinFIX1:pm(i15,m14) = r1; 
    end_copy:
     
     I_ACALL (unsaveforCEnv);
        
  	   i12=dm(m7,i6);
	   jump (m14,i12) (db); rframe; nop;
Cust_PP_To_PreDac_Int_Buffer..END:

.endseg;