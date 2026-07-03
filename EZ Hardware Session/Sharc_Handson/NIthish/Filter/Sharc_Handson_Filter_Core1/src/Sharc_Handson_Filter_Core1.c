/*****************************************************************************
 * Sharc_Handson_Filter_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "Sharc_Handson_Filter_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef struct wav_header
{
    char chunk_id[4];
    int chunk_size;
    char format[4];
    char subchunk1_id[4];
    int subchunk1_size;
    short int audio_format;
    short int num_channels;
    int sample_rate; // sample_rate denotes the sampling rate.
    int byte_rate;
    short int block_align;
    short int bits_per_sample;
    char subchunk2_id[4];
    int subchunk2_size; // subchunk2_size denotes the number of samples.
} wav_header;

typedef struct wav_header *wav_header_p;
FILE *input_file, *output_file;
float sampling_rate;
#define FILTER_ORDER 3
#define STATE_DELAY 4
#define FRAME_SIZE 256

double filter_coeff_A[FILTER_ORDER] = {1, -1.85214649, 0.86234863};
double filter_coeff_B[FILTER_ORDER] = {0.00255054, 0.00510107, 0.00255054};

double filter_states[STATE_DELAY] = {0};
float output_samples[FRAME_SIZE] = {0};
float input_samples[FRAME_SIZE] = {0};

short input_buffer[FRAME_SIZE] = {0};
short output_buffer[FRAME_SIZE] = {0};

void iir_Filter_DirectForm_1(float[], float[], int, double[], double[], double[]);

int main()
{
    // Use fopen instead of fopen_s
    input_file = fopen("pcm48k.wav", "rb");
    if (input_file == NULL)
    {
        printf("Error opening input file\n");
        return 1;
    }

    output_file = fopen("Output.wav", "wb");
    if (output_file == NULL)
    {
        printf("Error opening output file\n");
        fclose(input_file); // Close input file if it was opened
        return 1;
    }

    wav_header_p header_metadata = (wav_header_p)malloc(sizeof(wav_header));
    fread(header_metadata, 1, sizeof(wav_header), input_file);
    fwrite(header_metadata, 1, sizeof(wav_header), output_file);
    sampling_rate = header_metadata->sample_rate;

    while (!feof(input_file))
    {
        /* Read the Input wav file to Buffer */
        fread(input_buffer, sizeof(short int), FRAME_SIZE, input_file);

        /* Fix to Float Conversion */
        for (int i = 0; i < FRAME_SIZE; i++)
        {
            input_samples[i] = (float)(input_buffer[i] / 32767.f);
        }

        /* Call the Filter function */
        iir_Filter_DirectForm_1(input_samples, output_samples, FRAME_SIZE, filter_coeff_A, filter_coeff_B, filter_states);

        /* Float to Fix Conversion */
        for (int i = 0; i < FRAME_SIZE; i++)
        {
            output_buffer[i] = (short)((output_samples[i] * 32767.f));
        }

        /* Write the Output buffer to wav file */
        fwrite(output_buffer, sizeof(short int), FRAME_SIZE, output_file);
    }

    free(header_metadata);
    fclose(input_file);
    fclose(output_file);
    return 0;
}

void iir_Filter_DirectForm_1(float src[], float out[], int n, double a[], double b[], double states[])
{
    double state1, state2, state3, state4;

    state1 = states[0];
    state2 = states[1];
    state3 = states[2];
    state4 = states[3];

    for (int i = 0; i < n; i++)
    {
        out[i] = (src[i] * b[0]) + (b[1] * state1) + (b[2] * state2) + ((-a[1]) * state3) + ((-a[2]) * state4);
        state2 = state1;
        state1 = src[i];
        state4 = state3;
        state3 = out[i];
    }

    states[0] = state1;
    states[1] = state2;
    states[2] = state3;
    states[3] = state4;
}
