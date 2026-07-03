#include <stdio.h>

#define SIZE 20
#define NO_OF_CHANNELS 8  

int array[SIZE * NO_OF_CHANNELS];    
int blocktoblock[SIZE * NO_OF_CHANNELS]; 
int interleavedtoblockformat[SIZE * NO_OF_CHANNELS];
int blocktointerleavedformat[SIZE * NO_OF_CHANNELS];
int interleavedtointerleaved[SIZE * NO_OF_CHANNELS];

void D19API(int array[])
{
    // Block Format to Block Format (copy)
    printf("\nBlock Format to Block Format\n");
    for (int i = 0; i < SIZE * NO_OF_CHANNELS; i++) {
        blocktoblock[i] = array[i];
        printf("%d ", blocktoblock[i]);
    }

    // Block Format to Interleaved Format
    printf("\n\nBlock Format to Interleaved Format\n");
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < NO_OF_CHANNELS; j++) {
            int index = i * NO_OF_CHANNELS + j;
            blocktointerleavedformat[index] = blocktoblock[j * SIZE + i];
        }
    }

    // Print interleaved format
    for (int i = 0; i < SIZE * NO_OF_CHANNELS; i++) {
        printf("%d ", blocktointerleavedformat[i]);
    }

    // Interleaved Format to Interleaved Format (copy)
    printf("\n\nInterleaved Format to Interleaved Format\n");
    for (int i = 0; i < SIZE * NO_OF_CHANNELS; i++) {
        interleavedtointerleaved[i] = blocktointerleavedformat[i];
        printf("%d ", interleavedtointerleaved[i]);
    }

    // Interleaved Format to Block Format
    printf("\n\nInterleaved Format to Block Format\n");
    for (int i = 0; i < NO_OF_CHANNELS; i++) {
        for (int j = 0; j < SIZE; j++) {
            int index = j * NO_OF_CHANNELS + i;
            interleavedtoblockformat[i * SIZE + j] = interleavedtointerleaved[index];
        }
    }

    // Print block format
    for (int i = 0; i < SIZE * NO_OF_CHANNELS; i++) {
        printf("%d ", interleavedtoblockformat[i]);
    }

}

int main() 
{
    FILE *file;
    int number;
    file = fopen("sample.dat", "r"); 

    if (file == NULL) 
    {
        printf("Error opening the file.\n");
        return 1;
    }
    int i = 0;
    while (fscanf(file, "%d", &number) == 1 && i < SIZE * NO_OF_CHANNELS) {
        array[i] = number;
        i++;
    }
    fclose(file);
    D19API(array);
    return 0;
}
