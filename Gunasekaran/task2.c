#include "main.h"

void sum_of_array()
{
    int32_t array[MAX];
    int32_t *p_array;   // Pointer to hold the base address of the dynamically allocated array
    int32_t sum;
    sum = 0;
    p_array = array;
    // Input the array elements
    printf("Enter %d integers:\n", MAX);
    for (int32_t i = 0; i < MAX; i++) {
        scanf("%d", &p_array[i]);
    }

    // Calculate the sum of the array elements
    for (int32_t i = 0; i < MAX; i++) {
        sum += p_array[i];
    }

    // Print the sum
    printf("Sum of the array elements: %d\n", sum);

}