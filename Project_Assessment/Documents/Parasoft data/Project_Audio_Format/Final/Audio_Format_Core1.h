/*****************************************************************************
 * Audio_Format_Core1.h
 *****************************************************************************/

#ifndef __AUDIO_FORMAT_CORE1_H__
#define __AUDIO_FORMAT_CORE1_H__

#include <stdio.h>
#include <stdint.h>

#include <sys/platform.h>
#include <sys/adi_core.h>

#define SIZE 256
#define NO_OF_CHANNELS 16
#define OUTPUT_CHANNELS 16

#pragma section("destination_mapped_in_l3")
static int32_t destination[SIZE * OUTPUT_CHANNELS];

// Declare the function
int32_t* D19API(int32_t array[], int32_t conversion, int32_t file_type);

// Function prototypes
void output_channels_check(void);
void write_output_file(const char *filename);

#endif // HEADER_H
