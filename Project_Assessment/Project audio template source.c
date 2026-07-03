#include<stdio.h>
#define SIZE 256
#define NO_OF_CHANNELS 8

// Declare the 1D array
int array[SIZE * NO_OF_CHANNELS] = {
    #include "sine_tone.dat"  // Assuming sine_tone.dat contains the appropriate data
};

// Function to print the 1D array as if it were 2D
void sine(int array[SIZE * NO_OF_CHANNELS]) 
{
    // int interleavedformat[SIZE*NO_OF_CHANNELS];

    int interleavedtoblockformat[SIZE*NO_OF_CHANNELS];
    int blocktoblock[SIZE*NO_OF_CHANNELS];
    int blocktointerleavedformat[SIZE*NO_OF_CHANNELS];
    int interleavedtointerleaved[SIZE*NO_OF_CHANNELS];
    // // Interleaved Format to interleaved format
    // printf("Interleaved Format to Interleaved Format \n");
    // for (int i = 0; i < SIZE; i++) 
    // {  // Loop over rows
    //     for (int j = 0; j < NO_OF_CHANNELS; j++) 
    //     {  // Loop over columns
    //         // Compute the correct index in the 1D array
    //         int index = i * NO_OF_CHANNELS + j;
    //         interleavedformat[index] = array[index];
    //     }
    //     // printf("\n");  // Print a newline after each row for better formatting
    // }
    // for (int i = 0; i < SIZE*NO_OF_CHANNELS; i++)
    // printf("%d ",interleavedformat[i] );

    // Interleaved Format to Block format
    printf("\nInterleaved Format to Block Format\n");
    for (int i = 0; i < NO_OF_CHANNELS; i++) 
    {  // Loop over rows
        for (int j = 0; j < SIZE; j++) 
        {  // Loop over columns
            // Compute the correct index in the 1D array
            int index = j * NO_OF_CHANNELS + i;
            interleavedtoblockformat[i * SIZE + j]=array[index];
        }
        // printf("\n");  // Print a newline after each row for better formatting
    }
    for (int i = 0; i < SIZE*NO_OF_CHANNELS; i++)
    printf("%x ",interleavedtoblockformat[i]);

    // Block Format to Block format
    printf("\n\nBlock Format to Block Format\n");
    for (int i = 0; i < NO_OF_CHANNELS * SIZE; i++) 
    {
       blocktoblock[i] = interleavedtoblockformat[i];
       printf("%x ",blocktoblock[i]);
    }

    // Block format to Interleaved Format 
    printf("\n\nBlock Format to Interleaved Format\n");
    for (int i = 0; i < SIZE; i++) 
    {  // Loop over rows
        for (int j = 0; j < NO_OF_CHANNELS; j++) 
        {  // Loop over columns
            // Compute the correct index in the 1D array
            int index = i * NO_OF_CHANNELS + j;
            blocktointerleavedformat[index] = interleavedtoblockformat[j * SIZE + i];
        }
        // printf("\n");  // Print a newline after each row for better formatting
    }
    for (int i = 0; i < SIZE*NO_OF_CHANNELS; i++)
    printf("%x ",blocktointerleavedformat[i]);


    // Interleaved Format to Interleaved Format
    printf("\n\nInterleaved Format to Interleaved Format\n");
    for (int i = 0; i < NO_OF_CHANNELS * SIZE; i++) 
    {
       interleavedtointerleaved[i] = blocktointerleavedformat[i];
       printf("%x ",interleavedtointerleaved[i]);
    }

}

int main() {
    sine(array);  // Call the sine function to print the array
    return 0;
}
