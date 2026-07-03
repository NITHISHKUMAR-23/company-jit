/*****************************************************************************
 * Audio_Format_Core1.h
 *****************************************************************************/

#ifndef __AUDIO_FORMAT_CORE1_H__
#define __AUDIO_FORMAT_CORE1_H__

#include <stdio.h>
#include <stdint.h>

#include <sys/platform.h>
#include <sys/adi_core.h>

#define SIZE 256 				// Size of input samples taken
#define INPUT_CHANNELS 16		// Input channel size
#define OUTPUT_CHANNELS 16		// Output channel size

#define BLOCK 10
#define INTERLEAVED 20

#define BLOCK_TO_BLOCK 1
#define BLOCK_TO_INTERLEAVED 2
#define INTERLEAVED_TO_INTERLEAVED 3
#define INTERLEAVED_TO_BLOCK 4

#pragma section("destination_mapped_in_l3")
static int32_t destination[SIZE * OUTPUT_CHANNELS];   // For storing the converted output data

// Declare the function
int32_t* D19API(int32_t array[], int32_t conversion, int32_t file_type);

//void output_channels_check(void);
void write_output_file(const char *filename);

#endif // HEADER_H
