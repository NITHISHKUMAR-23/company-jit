/*****************************************************************************
 * power_using_loop_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "power_using_loop_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

#include <stdio.h>
#include <math.h>



inline double calculate_power_using_loop(double base, double exponent)
{
	double value_of_power = 1.0;
    for (int i = 0; i < exponent; i++)
    {
    	value_of_power *= base;
    }
    return value_of_power;
}

int main()
{
	double base = 5, exponent = 5, output;

    output = calculate_power_using_loop(base, exponent);

    printf("%.2lf power %.2lf is %.2lf", base, exponent, output);
    return 0;
}

