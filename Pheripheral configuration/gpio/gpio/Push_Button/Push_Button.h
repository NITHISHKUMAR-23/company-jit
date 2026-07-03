/*********************************************************************************
Copyright(c) 2020 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*****************************************************************************
 * Push_Button.h
 *****************************************************************************/

#ifndef __PUSH_BUTTON_H__
#define __PUSH_BUTTON_H__

/* Add your custom header content here */

/* This macro should be enabled when EV-SOMCRR-EZKIT is used */
//#define EV_SOMCRR_EZKIT_SUPPORT

/* This macro should be enabled when EV-SOMCRR-EZLITE is used */
#define EV_SOMCRR_EZLITE_SUPPORT


/* This to make sure at a time only either EV-SOMCRR-EZKIT
 * is defined or EV-SOMCRR-EZLITE, both should not be defined together
 */
#if defined(EV_SOMCRR_EZKIT_SUPPORT) && defined(EV_SOMCRR_EZLITE_SUPPORT)
#error "Only one of the macro EV_SOMCRR_EZKIT_SUPPORT or EV_SOMCRR_EZLITE_SUPPORT should be defined"
#elif !defined(EV_SOMCRR_EZKIT_SUPPORT) && !defined(EV_SOMCRR_EZLITE_SUPPORT)
#error "Either one of the macro EV_SOMCRR_EZKIT_SUPPORT or EV_SOMCRR_EZLITE_SUPPORT should be defined"
#endif


#if defined(__ADSP21593__)

/*
 * Push button 1 GPIO settings
 */

/* GPIO port to which push button 1 is connected to */
#define PUSH_BUTTON1_PORT           	(ADI_GPIO_PORT_B)

/* GPIO pin within the port to which push button 1 is connected to */
#define PUSH_BUTTON1_PIN            	(ADI_GPIO_PIN_3)

/* GPIO pint to which push button 1 is connected to */
#define PUSH_BUTTON1_PINT          		(ADI_GPIO_PIN_INTERRUPT_0)

/* Pin within the pint to which push button 1 is connected to */
#define PUSH_BUTTON1_PINT_PIN     		(ADI_GPIO_PIN_3)

/*PINT port assignment to which push button 1 is connected*/
#define PUSH_BUTTON1_PIN_ASSIGN 		(ADI_GPIO_PIN_ASSIGN_PBL_PINT0)

/*Byte assignment in the PINT block to which push button 1 is connected*/
#define PUSH_BUTTON1_PIN_ASSIGN_BYTE 	(ADI_GPIO_PIN_ASSIGN_BYTE_0)

/* Label printed on the EZ-Kit */
#define PUSH_BUTTON1_LABEL          	"SW3"

/*
 * Push button 2 GPIO settings
 */

/* GPIO port to which push button 2 is connected to */
#define PUSH_BUTTON2_PORT           	(ADI_GPIO_PORT_B)

/* GPIO pin within the port to which push button 2 is connected to */
#define PUSH_BUTTON2_PIN            	(ADI_GPIO_PIN_5)

/* GPIO pint to which push button 2 is connected to */
#define PUSH_BUTTON2_PINT	          	(ADI_GPIO_PIN_INTERRUPT_0)

/* Pin within the pint to which push button 2 is connected to */
#define PUSH_BUTTON2_PINT_PIN	     	(ADI_GPIO_PIN_5)

/*PINT port assignment to which push button 2 is connected*/
#define PUSH_BUTTON2_PIN_ASSIGN			(ADI_GPIO_PIN_ASSIGN_PBL_PINT0)

/*Byte assignment in the PINT block to which push button 1 is connected*/
#define PUSH_BUTTON2_PIN_ASSIGN_BYTE 	(ADI_GPIO_PIN_ASSIGN_BYTE_0)

/* Label printed on the EZ-Kit */
#define PUSH_BUTTON2_LABEL          	"SW4"


#elif defined(__ADSPSC594__) || defined(__ADSPSC598__)

/*
 * Push button 1 GPIO settings
 */

/* GPIO port to which push button 1 is connected to */
#define PUSH_BUTTON1_PORT           	(ADI_GPIO_PORT_D)

/* GPIO pin within the port to which push button 1 is connected to */
#define PUSH_BUTTON1_PIN            	(ADI_GPIO_PIN_0)

/* GPIO pint to which push button 1 is connected to */
#define PUSH_BUTTON1_PINT          		(ADI_GPIO_PIN_INTERRUPT_2)

/* Pin within the pint to which push button 1 is connected to */
#define PUSH_BUTTON1_PINT_PIN     		(ADI_GPIO_PIN_0)

/*PINT port assignment to which push button 1 is connected*/
#define PUSH_BUTTON1_PIN_ASSIGN 		(ADI_GPIO_PIN_ASSIGN_PDL_PINT2)

/*Byte assignment in the PINT block to which push button 1 is connected*/
#define PUSH_BUTTON1_PIN_ASSIGN_BYTE 	(ADI_GPIO_PIN_ASSIGN_BYTE_0)

/* Label printed on the EZ-Kit */
#define PUSH_BUTTON1_LABEL          	"SW3"

/*
 * Push button 2 GPIO settings
 */

/* GPIO port to which push button 2 is connected to */
#define PUSH_BUTTON2_PORT           	(ADI_GPIO_PORT_H)

/* GPIO pin within the port to which push button 2 is connected to */
#define PUSH_BUTTON2_PIN            	(ADI_GPIO_PIN_0)

/* GPIO pint to which push button 2 is connected to */
#define PUSH_BUTTON2_PINT	          	(ADI_GPIO_PIN_INTERRUPT_6)

/* Pin within the pint to which push button 2 is connected to */
#define PUSH_BUTTON2_PINT_PIN	     	(ADI_GPIO_PIN_0)

/*PINT port assignment to which push button 2 is connected*/
#define PUSH_BUTTON2_PIN_ASSIGN			(ADI_GPIO_PIN_ASSIGN_PHL_PINT6)

/*Byte assignment in the PINT block to which push button 1 is connected*/
#define PUSH_BUTTON2_PIN_ASSIGN_BYTE 	(ADI_GPIO_PIN_ASSIGN_BYTE_0)

/* Label printed on the EZ-Kit */
#define PUSH_BUTTON2_LABEL          	"SW4"


#endif

#endif /* __PUSH_BUTTON_H__ */
