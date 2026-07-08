/*****************************************************************************
 *
 *  (C)Copyright Analog Devices Inc., India.
 *  All rights reserved. Reproduction in whole or part is prohibited without
 *  the written permission of the copyright owner.
 *
 *  Project          :  	21569SDK
 *  Organization     :  	Jasmin Infotech Private Limited,Chennai
 *  File Name        :		GPIO.c
 *  Description      :   	GPIO configuration routines

 ******************************************************************************/

#include "..\src\system\Include\GPIO.h"

#include "..\src\system\Include\Commn.h"

void led_toggle_routine(void);
void led_clr_routine(void);
void led_set_routine(void);
void initialize_led(void);
void pintCallback(ADI_GPIO_PIN_INTERRUPT ePinInt, uint32_t PinIntData,  void *pCBParam);
void pintCallback1(ADI_GPIO_PIN_INTERRUPT ePinInt, uint32_t PinIntData,  void *pCBParam);

#ifdef LED_TOGGLE
section("seg_gpio_code")
void led_toggle_routine(void)
{
	if( Led_Toggle_Count <= 0)
	{
		adi_gpio_Toggle(LED1_PORT, LED1_PIN);
		Led_Toggle_Count = 23;
	}
	Led_Toggle_Count--;

}
section("seg_gpio_code")
void led_set_routine(void)
{
	adi_gpio_Set(LED2_PORT, LED2_PIN);
}

section("seg_gpio_code")
void Heartbeat_led_set_routine(void)
{
	adi_gpio_Set(LED1_PORT, LED1_PIN);
}

section("seg_gpio_code")
void led_clr_routine(void)
{
	adi_gpio_Clear(LED2_PORT, LED2_PIN);
}
#endif

section("seg_gpio_code")
void initialize_led(void)
{
    adi_gpio_SetDirection(LED1_PORT, LED1_PIN, ADI_GPIO_DIRECTION_OUTPUT);
    adi_gpio_SetDirection(LED2_PORT, LED2_PIN, ADI_GPIO_DIRECTION_OUTPUT);
}
