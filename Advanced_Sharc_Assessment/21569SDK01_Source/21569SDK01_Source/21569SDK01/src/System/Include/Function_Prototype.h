/***************************************************************************
*
*  (C)Copyright Analog Devices Inc., India.
*  All rights reserved. Reproduction in whole or part is prohibited without 
*  the written permission of the copyright owner.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Function_Prototype.h
*  Description      :   Function prototypes for various functions can be included here
******************************************************************************/

#ifndef _function_prototype_H_
#define _function_prototype_H_


/*****************************************************************************
	Framework Modules
*****************************************************************************/

    void SPI0_RxCore_Handler (uint32_t , void *);
    void initialize_led(void);
    void SPIReceive(void);

	void Enable_Cache(void);
	void Sport_init_Reconfig(void);

	//void EMDMA0_CORE2_Int_Handler();
	void Sport_init(void);
	void SendInitializationDone(void);
	void Status_Update(void);
	void Status_Comparison(void);
	void stop_sport_RX(void);
	void stop_sport_TX(void);


	void CUSTOMER_PP_COMMAND(void);
	void CommandProcessing(void);
	void Play_Command(void);
	void Stop_Command(void);
	void Mute_Command(void);
	void Resume_Command(void);
	void General_Decoding_Command(void);

	void SportInitialize_Command(void);
	void SPORT_Recongifuration(void);

	void MPCM_Input_command(void);
	void SendIRQInterrupt(void);

	void Flag_Toggle(void);
	void Set_Global_Interrupt(void);
	void Clear_Global_Interrupt(void);
	void Stop_Sport_Tx(void);
	void Stop_Sport_Rx(void);
	void Init_Var_Fs(void);
	void Set_Priority(void);
	void SPORT_Sync(void);
	void DAI_init(void);
	void TX_DAC_Channel_check();

	void adi_sec_SetPriority(int *,int *);

#endif /* FUNCTION_PROTOTYPE_H_ */
