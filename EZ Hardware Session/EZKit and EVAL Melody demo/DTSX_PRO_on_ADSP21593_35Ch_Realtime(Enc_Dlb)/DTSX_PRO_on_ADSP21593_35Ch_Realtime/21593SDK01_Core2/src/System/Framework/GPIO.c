/*****************************************************************************
 *
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
 *
 *  Project          :  	21593SDK
 *  Organization     :  	Jasmin Infotech Private Limited,Chennai
 *  File Name        :		GPIO.c
 *  Description      :   	GPIO configuration routines

 ******************************************************************************/
#pragma default_section(CODE,"Seg_Gpio_Code")
#include "../Include/GPIO.h"
#include "../Include/Commn.h"

#ifdef LED_TOGGLE
void Initialize_Led2(void)
{

	adi_gpio_SetDirection(LED2_PORT, LED2_PIN, ADI_GPIO_DIRECTION_OUTPUT);
}
void Led2_Set_Routine(void)
{
	adi_gpio_Set(LED2_PORT, LED2_PIN);
}

void Led2_Clr_Routine(void)
{
	adi_gpio_Clear(LED2_PORT, LED2_PIN);
}

void Led2_Toggle_Routine(void)
{
	PP_process_cnt++;
	if(PP_process_cnt==188)
	{
		Led2_Set_Routine();
	}
	else if(PP_process_cnt==375)
	{
		Led2_Clr_Routine();
		PP_process_cnt = 0;
	}

}

#endif
