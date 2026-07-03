#include "add_Core1.h"
#include <stdio.h>

// Declare the assembly function
extern void add(int r5, int r8);
extern int r5 = 10;  // Example value for r4
extern int r8 = 20;  // Example value for r8

//
//void add(int r4, int r8) {
//    int i0 = r4;
//    int i1 = r8;
//
//
//
//    int result = i0 + i1;
//
//
//    printf("Result of add: %d\n", result);
//}

int main() {


    // Call the add function
    add(r5, r8);

    return 0;
}

