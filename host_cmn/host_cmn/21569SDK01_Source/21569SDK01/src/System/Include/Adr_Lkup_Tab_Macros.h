/***************************************************************************
*
*  (C)Copyright Analog Devices Inc., India.
*  All rights reserved. Reproduction in whole or part is prohibited without 
*  the written permission of the copyright owner.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Adr_Lkup_Tab_Macros.h
*  Description      :   Call,JUMP,and Argument passing Macros definitions included
******************************************************************************/

#ifndef ADR_LKUP_TAB_MACROS_H
#define ADR_LKUP_TAB_MACROS_H

#if !defined(__ECC__) // ASM source file being processed

/************ ASSEMBLY MACRO ***********************/
#define I_ALABEL_( X )\
			.section/sw seg_kernal_code;\
			.global X;\
			 X:	
			 
#define I_ALABEL_ALG_( X )\
			.section/sw seg_kernal_code;\
			.global X;\
			 X:
			 
#define I_ALABEL_DTSHD( X_ )\
			.section/dm seg_ALT;\
			.global X_ ## LabelEntry;\
			.var X_ ## LabelEntry = X_ ## Label;\
			.section/dm seg_ALT_RAM;\
			.global X_ ## RAMLabelEntry;\
			.var X_ ## RAMLabelEntry = X_ ## Label;\
			.section/ sw seg_swco_dtshd;\
			.global X_ ## Label;\
			 X_ ## Label:	 			 
			 
#define I_ALABEL_SYS_( X )\
			.section/sw seg_kernal_code;\
			.global X;\
			 X:	
			 	 
#define I_ACCALL( X_) i12 = dm(X_ ## RAMLabelEntry);	\
					 r2 = i6;	\
					 i6 = i7;	\
					 jump (m13,i12)(db); 	\
					 dm(i7, m7) = r2;   \
					 dm(i7, m7) = pc;					 	
			 
#define I_ALABEL_SPI_( X )\
			.section/sw seg_kernal_code;\
			.global X;\
			 X:
			 		 			 			 			 
#define I_ACALL( X) call(X);
						 	
					 
#define I_AJUMP( X) jump (X); 					 	
					 	
/************ ASSEMBLY MACRO ENDS ***********************/


#else  // C source file being processed


/********************************NO ARGUMENTS**********************************/

#define I_CLABEL_( X )	void X()
	

#define I_CCALL_( X )	\
	do {				\
		X ();			\
	} while(0)

/*****************************SINGLE ARGUMENT**********************************/

#define I_CLABEL_1ARG_( X, ARGU1 )	void X (ARGU1)

#define I_CCALL_1ARG_( X, ARGU1 )	\
	do {							\
		X (ARGU1);					\
	} while(0)

/********************************TWO ARGUMENTS*********************************/
#define I_CLABEL_2ARG_( X, ARGU1, ARGU2 )	\
	void X (ARGU1, ARGU2)

#define I_CCALL_2ARG_( X, ARGU1, ARGU2 )	\
	do {									\
		X (ARGU1, ARGU2);					\
	} while(0)


/********************************THREE ARGUMENTS*******************************/
#define I_CLABEL_3ARG_( X, ARGU1, ARGU2, ARGU3 )		\
	void X (ARGU1, ARGU2, ARGU3 )

#define I_CCALL_3ARG_( X, ARGU1, ARGU2, ARGU3 )		\
	do {												\
		X (ARGU1, ARGU2, ARGU3);						\
	} while(0)


#endif	// if processing a C source file

#endif /*  End of #ifndef ADR_LKUP_TAB_MACROS_H 	*/

