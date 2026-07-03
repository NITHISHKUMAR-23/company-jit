/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Function_Prototypes.h
*  Description      :   Function_Prototypes are added.
******************************************************************************/
#ifndef SYSTEM_INCLUDE_FUNCTION_PROTOTYPE_H_
#define SYSTEM_INCLUDE_FUNCTION_PROTOTYPE_H_


void CustomerPP_gain_control(int *CustPPInputList);
void pack_t0_int();
void Pack_rd_ptr_upadate_c2();
void int_t0_predac();

#ifdef MDMA_COPY
void MDMA_init(void);
void MDMA_Copy(int BuffSize, int SrcBuff, int DstBuff);
#endif

void PreDac_Int_To_Cust_PP_Buffer(void);


void fixtofloatConversion(void);
void floattofixConversion(void);
void Cust_PP_To_PreDac_Int_Buffer(void);
void Customer_PP_kernel(void);

void Predac_buffer_Int_to_Predac_buffer(void);

void Pre_Dac_Ptr_Update_Rd_C2(void);
void Pre_Dac_Ptr_Update(void);
void FreeMemoryAll(void);
void Init_Var(void);
void MCPCMDecoder(void);
void Shared_Memory_Var_Update(void);
void Control_DataVariable_Update(void);



void Init_Var_Fs();
int Free_AllotMemoryPackDac (int , int , int );
void Autodetect_MemoryAlloc();
void PreDac_Buffer_Int_Rearrange();
void PostProcessing_Routine(void);
void Command_Update(void);
void CommandProcessing(void);
void CUSTOMER_PP_COMMAND(void);
int PlayForgnd(void);
void Init_Struct(void);
void Enable_Cache(void);

#ifdef LED_TOGGLE
	void Initialize_Led2(void);
	void Led2_Set_Routine(void);
	void Led2_Clr_Routine(void);
	void Led2_Toggle_Routine(void);
#endif
#ifdef CUSTOMER_PP
void Customer_Post_Processing(void);
#endif

void Routing_To_Predac_buffer(void);

#ifdef DTSX_DECODER
void DtsxPostProcessing(void);
void COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_OPTI(void);
void COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON_MCPCM(void);
void COPYPREDACTO_INTERNALPACK_MCPCM_DTSXON(void);
void MCPCMProcessing(void);
void Copying_Meta_Control_Data(void);
void convertSpkrOut( volatile unsigned int *spkrOut );
void DTSX_Kernel(void);
void SHIFTPREDACINT_MCPCM(int *,int,int);
void COPYPREDACTO_EXTPREDAC_MCPCM_DTSX(int *);
void addpredac_rd_ptr_dtsx_update(void);
void DTSX_Control_DataVariable_Update(void);
void MODE_SAVE_DTSX(void);
void MODE_CLR_DTSX(void);
int get_fft_ptr1(int);
void convertSpkrMask_pp(unsigned int*);
void Predac_buffer_to_Predac_buffer_Int(void);

#ifdef DTSX_CHANREORDER
int Channel_Reorder_lib_DTSX(int*);
void convertSpkrMask(unsigned int*);
void Channel_Reorder_Kernel(void);
#endif //DTSX_CHANREORDER

#ifdef DOWNSAMPLING_DTSX
void Dtsx_Downsampling(void);
void Int_predac_to_DS_Inputbuffer_cpy(void);
void DS_outputbuffer_to_DSPredac_cpy(void);
void Down_Samp_Processing_32ch(void);
void DTSX_DS_internal_to_Predac_int_copy(void);
void Predac_int_to_DTSX_DS_buffcopy(void);
#endif //DOWNSAMPLING_DTSX

#ifdef TRUBASS
void TruBass_Process(void);
void TruBassCommandExtraction(void);
void MODE_SAVE_DTSX(void);
void MODE_CLR_DTSX(void);
void FixToFloatTruBass(int);
void FloatToFixTruBass(int);
#endif //TRUBASS

#ifdef DTSX_MIPS_CALC
void STIMER_DTSX(void);
int ETIMER_DTSX(void);
void DtsxCalculateMIPS(void);
#endif // DTSX_MIPS_CALC

#ifdef OPTICAL_TESTING
void Routing_To_Predac_buffer_optical_final(void);
void Routing_To_Predac_buffer_optical(void);
#endif //OPTICAL_TESTING

#endif // DTSX_DECODER

#endif /* SYSTEM_INCLUDE_FUNCTION_PROTOTYPE_H_ */
