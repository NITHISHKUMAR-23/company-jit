/*********************************************************************************
Copyright(c) 2020-2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/
 
/*****************************************************************************
 * Push_Button.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "Push_Button.h"

#include <services/gpio/adi_gpio.h>
#include <stdio.h>


void ConfigSoftSwitches_EV_SOMCRR_EZKIT(void);

#define GPIO_MEMORY_SIZE (ADI_GPIO_CALLBACK_MEM_SIZE*2)
static uint8_t gpioMemory[GPIO_MEMORY_SIZE];
int volatile count1, count2 = 0;

void gpioCallback(ADI_GPIO_PIN_INTERRUPT ePinInt, uint32_t Data, void *pCBParam)
{
	if(ePinInt == PUSH_BUTTON1_PINT)
	{
		if(Data & PUSH_BUTTON1_PINT_PIN)
		{
			printf("PB1 pressed\n");

#if defined(EV_SOMCRR_EZKIT_SUPPORT)
			for(int volatile i=0;i<20;i++)
			{
				adi_gpio_Toggle(ADI_GPIO_PORT_C,ADI_GPIO_PIN_1);
				adi_gpio_Toggle(ADI_GPIO_PORT_C,ADI_GPIO_PIN_2);
				adi_gpio_Toggle(ADI_GPIO_PORT_C,ADI_GPIO_PIN_3);
				for(int volatile i=0;i<0x1000000;i++);
			}
#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
			for(int volatile i=0;i<0x1000000;i++);
#endif
			count1++;
		}


	}

	if(ePinInt == PUSH_BUTTON2_PINT)
	{
		if(Data & PUSH_BUTTON2_PINT_PIN)
		{
			printf("PB2 pressed\n");

#if defined(EV_SOMCRR_EZKIT_SUPPORT)
			for(int volatile i=0;i<20;i++)
			{
				adi_gpio_Toggle(ADI_GPIO_PORT_C,ADI_GPIO_PIN_1);
				adi_gpio_Toggle(ADI_GPIO_PORT_C,ADI_GPIO_PIN_2);
				adi_gpio_Toggle(ADI_GPIO_PORT_C,ADI_GPIO_PIN_3);
				for(int volatile i=0;i<0x1000000;i++);
			}
#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
			for(int volatile i=0;i<0x1000000;i++);
#endif
			count2++;
		}

	}


}


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

	/* Begin adding your custom code here */

	ADI_GPIO_RESULT Result;

#if defined(EV_SOMCRR_EZKIT_SUPPORT)
	ConfigSoftSwitches_EV_SOMCRR_EZKIT();
#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
     /* No soft config is required for EV-SOMCRR-EZLITE */
#endif


	if(PUSH_BUTTON1_PORT == PUSH_BUTTON2_PORT)
	{
		/*Configure the GPIO as output for PB1 and PB2*/
		Result = adi_gpio_PortInit(PUSH_BUTTON1_PORT,PUSH_BUTTON1_PIN | PUSH_BUTTON2_PIN,ADI_GPIO_DIRECTION_INPUT,true);
		if(Result != ADI_GPIO_SUCCESS)
		{
			printf("GPIO Initialization failed \n");
		}
	}

	else
	{
		/*Configure the GPIO as output for PB1*/
		Result = adi_gpio_PortInit(PUSH_BUTTON1_PORT,PUSH_BUTTON1_PIN,ADI_GPIO_DIRECTION_INPUT,true);
		if(Result != ADI_GPIO_SUCCESS)
		{
			printf("GPIO Initialization failed \n");
		}

		/*Configure the GPIO as output for PB2*/
		Result = adi_gpio_PortInit(PUSH_BUTTON2_PORT,PUSH_BUTTON2_PIN,ADI_GPIO_DIRECTION_INPUT,true);
		if(Result != ADI_GPIO_SUCCESS)
		{
			printf("GPIO Initialization failed \n");
		}

	}

	uint32_t gpiocallbacks;
	Result = adi_gpio_Init((void*)gpioMemory,GPIO_MEMORY_SIZE,&gpiocallbacks);
	if(Result != ADI_GPIO_SUCCESS)
	{
		printf("GPIO Initialization failed \n");
	}

	/*Register Callback for PB1 GPIO pin*/
	Result = adi_gpio_RegisterCallback(PUSH_BUTTON1_PINT, PUSH_BUTTON1_PINT_PIN, gpioCallback,(void*)0);
	if(Result != ADI_GPIO_SUCCESS)
	{
		printf("GPIO Initialization failed \n");
	}

	/*Register Callback for PB2 GPIO pin*/
	Result = adi_gpio_RegisterCallback(PUSH_BUTTON2_PINT, PUSH_BUTTON2_PINT_PIN, gpioCallback,(void*)0);
	if(Result != ADI_GPIO_SUCCESS)
	{
		printf("GPIO Initialization failed \n");
	}

	/* Configure the PINT interrupt for level */
	Result = adi_gpio_PinInt(PUSH_BUTTON1_PIN_ASSIGN, PUSH_BUTTON1_PINT_PIN, PUSH_BUTTON1_PINT, PUSH_BUTTON1_PIN_ASSIGN_BYTE,true,ADI_GPIO_SENSE_LEVEL_HIGH);
	if(Result != ADI_GPIO_SUCCESS)
	{
		printf("GPIO Initialization failed \n");
	}

	/* Configure the PINT interrupt for level */
	Result = adi_gpio_PinInt(PUSH_BUTTON2_PIN_ASSIGN, PUSH_BUTTON2_PINT_PIN, PUSH_BUTTON2_PINT, PUSH_BUTTON2_PIN_ASSIGN_BYTE,true,ADI_GPIO_SENSE_LEVEL_HIGH);
	if(Result != ADI_GPIO_SUCCESS)
	{
		printf("GPIO Initialization failed \n");
	}

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

#if defined(EV_SOMCRR_EZKIT_SUPPORT)
	printf("Press both PB1/SW3 and PB2/SW4 and check that LED2,4,5 blinks for 10 times and then stops \n");
#elif defined(EV_SOMCRR_EZLITE_SUPPORT)
	printf("Press both PB1 and PB2 one after another \n");
#endif

	while(count1 == 0 || count2 == 0);

	printf("All done\n");

	return 0;
}

