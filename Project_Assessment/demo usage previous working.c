
#include <stdio.h>
#include <stdlib.h>

#define SIZE 256
#define NO_OF_CHANNELS 8

int array[SIZE * NO_OF_CHANNELS];

// Function to read the file
void read_file(const char *filename, int array[SIZE * NO_OF_CHANNELS]) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        perror("Error opening file");
        exit(1);
    }

    for (int i = 0; i < SIZE * NO_OF_CHANNELS; i++) {
        // Read hexadecimal values from file
        if (fscanf(file, "%x", &array[i]) != 1) {
            printf("Error reading data at index %d\n", i);
            break;
        }
    }

    fclose(file);
}

void D19API(int array[SIZE * NO_OF_CHANNELS]) {
    int interleavedtoblockformat[SIZE * NO_OF_CHANNELS];
    int blocktoblock[SIZE * NO_OF_CHANNELS];
    int blocktointerleavedformat[SIZE * NO_OF_CHANNELS];
    int interleavedtointerleaved[SIZE * NO_OF_CHANNELS];

    // Interleaved Format to Block format
    printf("\nInterleaved Format to Block Format\n");
    for (int i = 0; i < NO_OF_CHANNELS; i++) {
        for (int j = 0; j < SIZE; j++) {
            int index = j * NO_OF_CHANNELS + i;
            interleavedtoblockformat[i * SIZE + j] = array[index];
        }
    }

    // Print block format
    for (int i = 0; i < SIZE * NO_OF_CHANNELS; i++) {
        printf("%d ", interleavedtoblockformat[i]);
    }

    // Block Format to Block format (copy)
    printf("\n\nBlock Format to Block Format\n");
    for (int i = 0; i < SIZE * NO_OF_CHANNELS; i++) {
        blocktoblock[i] = interleavedtoblockformat[i];
        printf("%d ", blocktoblock[i]);
    }

    // Block format to Interleaved Format
    printf("\n\nBlock Format to Interleaved Format\n");
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < NO_OF_CHANNELS; j++) {
            int index = i * NO_OF_CHANNELS + j;
            blocktointerleavedformat[index] = interleavedtoblockformat[j * SIZE + i];
        }
    }

    // Print interleaved format
    for (int i = 0; i < SIZE * NO_OF_CHANNELS; i++) {
        printf("%d ", blocktointerleavedformat[i]);
    }

    // Interleaved Format to Interleaved Format
    printf("\n\nInterleaved Format to Interleaved Format\n");
    for (int i = 0; i < SIZE * NO_OF_CHANNELS; i++) {
        interleavedtointerleaved[i] = blocktointerleavedformat[i];
        printf("%d ", interleavedtointerleaved[i]);
    }
}

int main() {
    // Assuming the file contains 32-bit hex values
    read_file("sample.dat", array);  // Read data from file
    D19API(array);  // Call the sine function to print the array
    return 0;
}
