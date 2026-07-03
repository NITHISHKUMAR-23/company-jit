/*****************************************************************************
 * Fixed_Floating_Conversion_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "Fixed_Floating_Conversion_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

float fixed_to_float(int fixed_value, int fractional_bits);

int main()
{
    int fixed_value;
    int fractional_bits;

//    printf("Enter fixed point value: ");
//    scanf("%d", &fixed_value);
    fixed_value = 512;

//    printf("Enter the number of fractional bits in Q-format: ");
//    scanf("%d", &fractional_bits);
    fractional_bits = 31;

    float float_value = fixed_to_float(fixed_value, fractional_bits);

    // Print the results
    printf("Fixed: %d - Float: %e", fixed_value, float_value);

    return 0;
}
// Function to convert fixed-point number to floating-point
float fixed_to_float(int fixed_value, int fractional_bits)
{
    // Calculate the scale factor based on the fractional bits
    int fixed_point_one = 1LL << fractional_bits;
    return (float)fixed_value / (float)fixed_point_one;
}
