/*******************************************************************************

Copyright(c) 2020-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.

*******************************************************************************/
 
/*****************************************************************************
 * LED_Blink.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"

#include "LED_Blink.h"

#if defined(__ADSP21591__) || defined(__ADSP21593__)
void SoftSwitches_EV_21593_SOM_LED_ON(void);
void SoftSwitches_EV_21593_SOM_LED_OFF(void);
#elif defined(__ADSPSC598__)
void SoftSwitches_EV_SC598_SOM_LED_ON(void);
void SoftSwitches_EV_SC598_SOM_LED_OFF(void);
#else
void SoftSwitches_EV_SC594_SOM_LED_ON(void);
void SoftSwitches_EV_SC594_SOM_LED_OFF(void);
#endif

#if defined EV_SOMCRR_EZLITE_SUPPORT
void SoftConfig_EV_SOMCRR_EZLITE_LED_ON(void);
void SoftConfig_EV_SOMCRR_EZLITE_LED_OFF(void);
#endif

/** 
 * If you want to use command program arguments, then place them in the following string. 
 */
char __argv_string[] = "";

int main(int argc, char *argv[])
{
	/**
	 * Initialize managed drivers and/or services that have been added to 
	 * the project.
	 * @return zero on success 
	 */
	adi_initComponents();
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif

#if defined EV_SOMCRR_EZKIT_SUPPORT

	ADI_GPIO_RESULT Result;

	/*Configure the Port Pin PC_01 as output for LED blink*/
	Result = adi_gpio_SetDirection(ADI_GPIO_PORT_C,ADI_GPIO_PIN_1, ADI_GPIO_DIRECTION_OUTPUT);
	if(Result!= ADI_GPIO_SUCCESS)
	{
		printf("GPIO Initialization failed \n");
	}

	/*Configure the Port Pin PC_02 as output for LED blink*/
	Result = adi_gpio_SetDirection(ADI_GPIO_PORT_C,ADI_GPIO_PIN_2, ADI_GPIO_DIRECTION_OUTPUT);
	if(Result!= ADI_GPIO_SUCCESS)
	{
		printf("GPIO Initialization failed \n");
	}

	/*Configure the Port Pin PC_03 as output for LED blink*/
	Result = adi_gpio_SetDirection(ADI_GPIO_PORT_C,ADI_GPIO_PIN_3, ADI_GPIO_DIRECTION_OUTPUT);
	if(Result!= ADI_GPIO_SUCCESS)
	{
		printf("GPIO Initialization failed \n");
	}

#endif

	volatile int i=0;
#ifndef AUTOTEST
	while(1)
#endif
	{
		/* Turn LED on */
#if defined(__ADSP21591__) || defined(__ADSP21593__)
		/* LEDs on EV-21593-SOM */
		SoftSwitches_EV_21593_SOM_LED_ON();
#elif defined(__ADSPSC598__)
		/* LEDs on EV-SC598-SOM */
		SoftSwitches_EV_SC598_SOM_LED_ON();
#else
		/* LEDs on EV-SC594-SOM */
		SoftSwitches_EV_SC594_SOM_LED_ON();
#endif

#if defined EV_SOMCRR_EZKIT_SUPPORT
		/* LEDs on EV-SOMCRR-EZKIT */
		adi_gpio_Set(ADI_GPIO_PORT_C,ADI_GPIO_PIN_1);
		adi_gpio_Set(ADI_GPIO_PORT_C,ADI_GPIO_PIN_2);
		adi_gpio_Set(ADI_GPIO_PORT_C,ADI_GPIO_PIN_3);
#elif defined EV_SOMCRR_EZLITE_SUPPORT
		/* LEDs on EV-SOMCRR-EZLITE */
		SoftConfig_EV_SOMCRR_EZLITE_LED_ON();
#endif
		printf("LED Blink.\n");
		/*Delay*/
		for(i=0;i<0x1000000;i++);

		/* Turn LED off */
#if defined(__ADSP21591__) || defined(__ADSP21593__)
		/* LEDs on EV-21593-SOM */
		SoftSwitches_EV_21593_SOM_LED_OFF();
#elif defined(__ADSPSC598__)
		/* LEDs on EV-SC598-SOM */
		SoftSwitches_EV_SC598_SOM_LED_OFF();
#else
		/* LEDs on EV-SC594-SOM */
		SoftSwitches_EV_SC594_SOM_LED_OFF();
#endif

#if defined EV_SOMCRR_EZKIT_SUPPORT
		/* LEDs on EV-SOMCRR-EZKIT */
		adi_gpio_Clear(ADI_GPIO_PORT_C,ADI_GPIO_PIN_1);
		adi_gpio_Clear(ADI_GPIO_PORT_C,ADI_GPIO_PIN_2);
		adi_gpio_Clear(ADI_GPIO_PORT_C,ADI_GPIO_PIN_3);
#elif defined EV_SOMCRR_EZLITE_SUPPORT
		/* LEDs on EV-SOMCRR-EZLITE */
		SoftConfig_EV_SOMCRR_EZLITE_LED_OFF();
#endif
		printf("LED Off.\n");
		/*Delay*/
		for(i=0;i<0x1000000;i++);

	}
#ifdef AUTOTEST
	printf("All done\n");
	printf("Reminder : Manual Check is a must.\n");
	return 0;
#endif
}

