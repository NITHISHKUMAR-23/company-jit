#include "main.h"

void structure()
{
    struct Data person;

    printf("Enter your initial: ");
    scanf(" %c", &person.initial); // Space before %c to consume any newline character

    printf("Enter your name: ");
    scanf(" %[^\n]", person.name); // Read string with spaces

    printf("Enter your age: ");
    scanf("%d", &person.age);

    printf("Enter your height (in feet): ");
    scanf("%f", &person.height);

    printf("Enter the year: ");
    scanf("%d", &person.year);

    printf("Enter your salary: ");
    scanf("%lf", &person.salary);

    // Print the structure members
    printf("Initial: %c\n", person.initial);
    printf("Name: %s\n", person.name);
    printf("Age: %d\n", person.age);
    printf("Height: %.2f\n", person.height);
    printf("Year: %d\n", person.year);
    printf("Salary: %.2lf\n", person.salary);
}