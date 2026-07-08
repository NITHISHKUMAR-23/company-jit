// Program to find square root

#include <stdio.h>
#include <math.h>

int main() 
{
    double number, sq_root;

    // Get input from user for input
    printf("Enter a number : ");
    scanf("%lf", &number);
    
    // Calculate the square root
    sq_root=sqrt(number);
    
    // Display the result
    printf("Square root of %.lf = %.2f",number,sq_root);

    return 0;
}
