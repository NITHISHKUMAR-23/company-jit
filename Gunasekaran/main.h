#include <stdio.h>
#include<string.h>
#include<stdlib.h>
#include <stdint.h>
#include<math.h>

#define MAX 5
#define ADD(x, y) ((x) + (y))
#define SUBTRACT(x, y) ((x) - (y))
#define MULTIPLY(x, y) ((x) * (y))
#define DIVIDE(x, y) ((x) / (y))
#define POWER(x, y) (pow((x), (y))) // Using pow from math.h

// Define a structure with optimized member order to reduce padding
struct Data {
    char initial;      // 1 byte
    char name[50];     // 50 bytes
    int age;          // 4 bytes
    short year;       // 2 bytes
    float height;     // 4 bytes
    double salary;    // 8 bytes
};

void structure();
void sum_of_array();
void operations();