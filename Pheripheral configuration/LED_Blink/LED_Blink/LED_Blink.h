/*********************************************************************************
Copyright(c) 2020-2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/
 
/*****************************************************************************
 * LED_Blink.h
 *****************************************************************************/

#ifndef __LED_BLINK_H__
#define __LED_BLINK_H__

/* Add your custom header content here */
#include <services/gpio/adi_gpio.h>
#include <stdio.h>


/* This macro should be enabled when EV-SOMCRR-EZKIT is used */
#define EV_SOMCRR_EZKIT_SUPPORT

/* This macro should be enabled when EV-SOMCRR-EZLITE is used */
//#define EV_SOMCRR_EZLITE_SUPPORT


/* This to make sure at a time only either EV-SOMCRR-EZKIT
 * is defined or EV-SOMCRR-EZLITE, both should not be defined together
 */
#if defined(EV_SOMCRR_EZKIT_SUPPORT) && defined(EV_SOMCRR_EZLITE_SUPPORT)
#error "Only one of the macro EV_SOMCRR_EZKIT_SUPPORT or EV_SOMCRR_EZLITE_SUPPORT should be defined"
#elif !defined(EV_SOMCRR_EZKIT_SUPPORT) && !defined(EV_SOMCRR_EZLITE_SUPPORT)
#error "Either one of the macro EV_SOMCRR_EZKIT_SUPPORT or EV_SOMCRR_EZLITE_SUPPORT should be defined"
#endif


#endif /* __LED_BLINK_H__ */
