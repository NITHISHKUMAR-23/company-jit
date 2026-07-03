/*****************************************************************************
 * power_using_math_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "power_using_math_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

#include <stdio.h>
#include <math.h>

inline double calculate_power_using_math_function(double base, double exponent)
{
    return pow(base, exponent);
}

int main()
{
    double base = 5, exponent = 5, output;

    output = calculate_power_using_math_function(base, exponent);

    printf("%.2lf power %.2lf is %.2lf.", base, exponent, output);

    return 0;
}
