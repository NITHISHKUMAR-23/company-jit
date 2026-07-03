#include "main.h"

void operations() {
    double_t a, b;

    // Get user input
    printf("Enter two numbers (a and b): ");
    scanf("%lf %lf", &a, &b);

    // Using macros to perform calculations
    printf("Addition (a + b): %.2lf\n", ADD(a, b));
    printf("Subtraction (a - b): %.2lf\n", SUBTRACT(a, b));
    printf("Multiplication (a * b): %.2lf\n", MULTIPLY(a, b));
    printf("Division (a / b): %.2lf\n", DIVIDE(a, b));
    printf("Power (a ^ b): %.2lf\n", POWER(a, b));
}
