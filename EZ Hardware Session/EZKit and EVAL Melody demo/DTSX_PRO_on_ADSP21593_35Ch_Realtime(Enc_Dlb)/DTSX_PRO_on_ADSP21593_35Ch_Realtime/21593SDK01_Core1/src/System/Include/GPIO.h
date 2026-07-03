/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	GPIO.h
*  Description      :   Defines and variables
******************************************************************************/

#ifndef GPIO_H_
#define GPIO_H_

#include <services/gpio/adi_gpio.h>

section("seg_gpio_data")
int Led_Toggle_Count=0;


#define LED1             	"LED1"
#define LED1_PORT      		(ADI_GPIO_PORT_C)
#define LED1_PIN       		(ADI_GPIO_PIN_3)


#endif /* GPIO_H_ */
