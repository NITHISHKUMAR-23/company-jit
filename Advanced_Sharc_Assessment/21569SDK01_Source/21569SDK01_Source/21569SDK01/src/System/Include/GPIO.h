/***************************************************************************
*
 *  (C)Copyright Analog Devices Inc., India.
*  All rights reserved. Reproduction in whole or part is prohibited without
*  the written permission of the copyright owner.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	GPIO.h
*  Description      :   Defines and variables
******************************************************************************/

#ifndef GPIO_H_
#define GPIO_H_

#include <services/gpio/adi_gpio.h>

section("seg_gpio_data")
int Led_Toggle_Count=0;
section("seg_gpio_data")
int Led_Toggle_Count2=0;

#define Num_Of_Callbacks	2

#define LED1             	"LED1"
#define LED1_PORT      		(ADI_GPIO_PORT_B)
#define LED1_PIN       		(ADI_GPIO_PIN_6)

#define LED2             	"LED2"
#define LED2_PORT      		(ADI_GPIO_PORT_B)
#define LED2_PIN       		(ADI_GPIO_PIN_3)

#define PB1              	"PB1"
#define PB1_PORT         	(ADI_GPIO_PORT_B)
#define PB1_PORT_PIN     	(ADI_GPIO_PIN_7)
#define PB1_PINT         	(ADI_GPIO_PIN_INTERRUPT_0)
#define PB1_PINT_PIN     	(ADI_GPIO_PIN_7)
#define PIN_ASSIGN      	(ADI_GPIO_PIN_ASSIGN_PBL_PINT0)
#define PIN_ASSIGN_BYTE 	(ADI_GPIO_PIN_ASSIGN_BYTE_0)

#define PB2              	"PB2"
#define PB2_PORT         	(ADI_GPIO_PORT_B)
#define PB2_PORT_PIN     	(ADI_GPIO_PIN_8)
#define PB2_PINT         	(ADI_GPIO_PIN_INTERRUPT_0)
#define PB2_PINT_PIN     	(ADI_GPIO_PIN_8)
#define PIN_ASSIGN_1      	(ADI_GPIO_PIN_ASSIGN_PBL_PINT0)
#define PIN_ASSIGN_BYTE_1	(ADI_GPIO_PIN_ASSIGN_BYTE_0)

#endif /* GPIO_H_ */
