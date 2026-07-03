#include <stdio.h>
#include <stdint.h>

#define SIZE 20
#define NO_OF_CHANNELS 8
#define OUTPUT_CHANNELS 8

// Declare the function without inline (if necessary)
void D19API(int32_t array[], int32_t conversion, int32_t file_type);

// Function prototypes for other functions
void write_output_file(const char *filename);
void display_output(void);
void handle_greater_output_channels(void);

