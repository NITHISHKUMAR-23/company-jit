
/*
 4) Write a c Program for IIR Filter Directform -II using 2 rd order with HPF cutoff frequency is 800 Hz.
	Use the below coefficent for 800 Hz.
	A={1,         -1.85214649,  0.86234863}
	B={0.92862378, -1.85724756,  0.92862378}
*/	

#include<stdio.h>
#include<stdlib.h>

#define _CRT_SECURE_NO_WARNINGS

typedef struct header_file
{
	char chunk_id[4];
	int chunk_size;
	char format[4];
	char subchunk1_id[4];
	int subchunk1_size;
	short int audio_format;
	short int num_channels;
	int sample_rate;			// sample_rate denotes the sampling rate.
	int byte_rate;
	short int block_align;
	short int bits_per_sample;
	char subchunk2_id[4];
	int subchunk2_size;			// subchunk2_size denotes the number of samples.
} header;

/* Variable Decalaration */
typedef struct header_file* header_p;
typedef  float float32_t;
typedef  int uint32_t;
FILE *fr, *fw;
float fs;
#define N 3
#define FRAME 256


void IIR_Filter_Directform_II(float *src, float *out, float frame, float *A, float *B);

float state[N]={0};

/* Filter Coefficient Declaration */
    float A[N] = {1,-1.85214649,0.86234863};
	float B[N] = {0.92862378,-1.85724756,0.92862378};

int main()
{
	if (fopen_s(&fr, "mixed_audio.wav", "rb") != 0) {
		printf("Error opening file\n");
		return 1;
	}
	if (fopen_s(&fw, "Output.wav", "wb") != 0) {
		printf("Error opening file\n");
		return 1;
	}
	header_p meta = (header_p)malloc(sizeof(header));
	fread(meta, 1, sizeof(header), fr);
	fwrite(meta, 1, sizeof(header), fw);
	fs = meta->sample_rate;

	float src[FRAME] = { 0 };
	float out[FRAME] = { 0 };
	float out1[FRAME] = { 0 };
	short Inbuf[256] = { 0 };
	short outbuf[256] = { 0 };
	int i = 0, j = 0;

	while (!feof(fr)) {
	/* Read the Input wav file to Buffer */
	fread(Inbuf, sizeof(short int), FRAME, fr);

	/* Fix to Float Conversion */
	for (i = 0; i < FRAME; i++)
	{
		src[i] = (float)(Inbuf[i] / 32767.f);
	}

   
	/* Need to call Filter function Here */
    IIR_Filter_Directform_II(src, out, FRAME, A, B);


	/* Float to Fix Conversion */
	for (i = 0; i < FRAME; i++)
	{
		outbuf[i] = (short)((out[i] * 32767.f));
	}

	/* Write the Output buffer to wav file */
	fwrite(outbuf, sizeof(short int), FRAME, fw);
	}
	return 0;
}

void IIR_Filter_Directform_II(float *src, float *out, float frame, float *A, float *B)
{
        
    float d1 = state[0];
    float d2 = state[1];

    int i= 0;
    float v_of_n = 0;

    for(i = 0; i < frame; i++)
    {
        v_of_n = src[i] - (A[1]*d1)- (A[2]*d2);
        out[i] = (B[0]*v_of_n ) + (B[1]*d1) + (B[2]*d2);
        d2 = d1;
        d1 = v_of_n ;

    }
    state[0] = d1;
    state[1] = d2;
       
}
