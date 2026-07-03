/*****************************************************************************
 * project_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "project_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>

// WAV file header structure
typedef struct {
    char riff[4];         // "RIFF"
    uint32_t size;        // File size
    char wave[4];         // "WAVE"
    char fmt[4];          // "fmt "
    uint32_t fmtSize;     // Format size
    uint16_t audioFormat; // Audio format (1 for PCM)
    uint16_t numChannels; // Number of channels (6 for 5.1)
    uint32_t sampleRate;  // Sample rate
    uint32_t byteRate;    // Byte rate
    uint16_t blockAlign;  // Block align
    uint16_t bitsPerSample; // Bits per sample
    char data[4];         // "data"
    uint32_t dataSize;    // Data size
} WAVHeader;

// Function to read WAV file
WAVHeader readWAV(const char* filename, int16_t** leftChannel, int16_t** rightChannel, int16_t** centerChannel, int16_t** lfeChannel, int16_t** leftSurroundChannel, int16_t** rightSurroundChannel) {
    FILE* file = fopen(filename, "rb");
    if (!file) {
        perror("Failed to open file");
        exit(EXIT_FAILURE);
    }

    WAVHeader header;
    fread(&header, sizeof(WAVHeader), 1, file);

    // Allocate memory for the 6 channels
    int numSamples = header.dataSize / (header.bitsPerSample / 8 * header.numChannels);
    *leftChannel = (int16_t*)malloc(numSamples * sizeof(int16_t));
    *rightChannel = (int16_t*)malloc(numSamples * sizeof(int16_t));
    *centerChannel = (int16_t*)malloc(numSamples * sizeof(int16_t));
    *lfeChannel = (int16_t*)malloc(numSamples * sizeof(int16_t));
    *leftSurroundChannel = (int16_t*)malloc(numSamples * sizeof(int16_t));
    *rightSurroundChannel = (int16_t*)malloc(numSamples * sizeof(int16_t));

    // Read the audio data
    int16_t* buffer = (int16_t*)malloc(header.dataSize);
    fread(buffer, header.dataSize, 1, file);
    fclose(file);

    // Split into the 6 channels (L, R, C, LFE, LS, RS)
    for (int i = 0; i < numSamples; i++) {
        (*leftChannel)[i] = buffer[i * 6];       // Left channel
        (*rightChannel)[i] = buffer[i * 6 + 1];  // Right channel
        (*centerChannel)[i] = buffer[i * 6 + 2]; // Center channel
        (*lfeChannel)[i] = buffer[i * 6 + 3];    // LFE channel
        (*leftSurroundChannel)[i] = buffer[i * 6 + 4]; // Left Surround channel
        (*rightSurroundChannel)[i] = buffer[i * 6 + 5]; // Right Surround channel
    }

    free(buffer);
    return header;
}

// Function to write WAV file
void writeWAV(const char* filename, WAVHeader header, int16_t* data, int dataSize) {
    FILE* file = fopen(filename, "wb");
    if (!file) {
        perror("Failed to open file for writing");
        exit(EXIT_FAILURE);
    }

    fwrite(&header, sizeof(WAVHeader), 1, file);
    fwrite(data, sizeof(int16_t), dataSize, file);
    fclose(file);
}

// IIR Filter (High-Pass and Low-Pass)
void applyFilter(int16_t* input, int16_t* output, int numSamples, float* B, float* A) {
    float z1 = 0.0f, z2 = 0.0f; // State variables

    for (int n = 0; n < numSamples; n++) {
        float x = (float)input[n];  // Convert to float

        // Apply filter
        float y = B[0] * x + z1;
        z1 = B[1] * x - A[1] * y + z2;
        z2 = B[2] * x - A[2] * y;

        // Clamp to 16-bit signed integer range
        if (y > 32767.0f) y = 32767.0f;
        if (y < -32768.0f) y = -32768.0f;

        output[n] = (int16_t)y;  // Store result
    }
}

// Apply Gain (10 dB)
void applyGain(int16_t* input, int16_t* output, int numSamples, float gain) {
    for (int i = 0; i < numSamples; i++) {
        int32_t amplified = (int32_t)(input[i] * gain);
        if (amplified > 32767) amplified = 32767;
        if (amplified < -32768) amplified = -32768;

        output[i] = (int16_t)amplified;
    }
}

// Main function
int main() {
    int16_t *leftChannel, *rightChannel, *centerChannel, *lfeChannel, *leftSurroundChannel, *rightSurroundChannel;

    // Read the input WAV file
    WAVHeader header = readWAV("mcpcm_48k_5.1 1.wav", &leftChannel, &rightChannel, &centerChannel, &lfeChannel, &leftSurroundChannel, &rightSurroundChannel);

    // Allocate memory for filtered output
    int16_t* filteredLeft = (int16_t*)malloc(header.dataSize / 6);
    int16_t* filteredRight = (int16_t*)malloc(header.dataSize / 6);
    int16_t* filteredCenter = (int16_t*)malloc(header.dataSize / 6);
    int16_t* filteredLeftSurround = (int16_t*)malloc(header.dataSize / 6);
    int16_t* filteredRightSurround = (int16_t*)malloc(header.dataSize / 6);
    int16_t* filteredLFE = (int16_t*)malloc(header.dataSize / 6);

    // Coefficients for IIR HPF
    float BHPF[3] = {0.98895, -1.97791, 0.98895};
    float AHPF[3] = {1.00000, -1.97778, 0.97803};

    // Coefficients for IIR LPF
    float BLPF[3] = {0.000061, 0.000122, 0.000061};
    float ALPF[3] = {1.000000, -1.977786, 0.978030};

    // Apply the IIR HPF to all channels except LFE
    applyFilter(leftChannel, filteredLeft, header.dataSize / sizeof(int16_t) / 6, BHPF, AHPF);
    applyFilter(rightChannel, filteredRight, header.dataSize / sizeof(int16_t) / 6, BHPF, AHPF);
    applyFilter(centerChannel, filteredCenter, header.dataSize / sizeof(int16_t) / 6, BHPF, AHPF);
    applyFilter(leftSurroundChannel, filteredLeftSurround, header.dataSize / sizeof(int16_t) / 6, BHPF, AHPF);
    applyFilter(rightSurroundChannel, filteredRightSurround, header.dataSize / sizeof(int16_t) / 6, BHPF, AHPF);

    // Apply the IIR LPF to all channels
    applyFilter(leftChannel, filteredLeft, header.dataSize / sizeof(int16_t) / 6, BLPF, ALPF);
    applyFilter(rightChannel, filteredRight, header.dataSize / sizeof(int16_t) / 6, BLPF, ALPF);
    applyFilter(centerChannel, filteredCenter, header.dataSize / sizeof(int16_t) / 6, BLPF, ALPF);
    applyFilter(leftSurroundChannel, filteredLeftSurround, header.dataSize / sizeof(int16_t) / 6, BLPF, ALPF);
    applyFilter(rightSurroundChannel, filteredRightSurround, header.dataSize / sizeof(int16_t) / 6, BLPF, ALPF);

    // Apply LPF to the LFE and then 10 dB gain
    applyFilter(lfeChannel, filteredLFE, header.dataSize / sizeof(int16_t) / 6, BLPF, ALPF);
    applyGain(filteredLFE, filteredLFE, header.dataSize / sizeof(int16_t) / 6, pow(10.0f, 10.0f / 20.0f));  // Apply 10 dB gain

    // Write the output WAV file
    writeWAV("output.wav", header, filteredLeft, header.dataSize / 6);

    // Free allocated memory
    free(leftChannel);
    free(rightChannel);
    free(centerChannel);
    free(lfeChannel);
    free(leftSurroundChannel);
    free(rightSurroundChannel);
    free(filteredLeft);
    free(filteredRight);
    free(filteredCenter);
    free(filteredLeftSurround);
    free(filteredRightSurround);
    free(filteredLFE);

    return 0;
}
