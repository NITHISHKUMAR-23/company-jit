#include <stdio.h>
#include <stdint.h>

#define SIZE 20            
#define NO_OF_CHANNELS 8   

int32_t array[SIZE * NO_OF_CHANNELS];  
int32_t destination[SIZE * NO_OF_CHANNELS]; 

void D19API(int32_t array[]) 
{
    // Block Format to Block Format
    printf("\nBlock Format to Block Format\n");
    for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
        destination[i] = array[i];  
        printf("%d ", destination[i]);
    }
    printf("\n");
    
    FILE *BlockFormat_to_BlockFormat = fopen("BlockFormat_to_BlockFormat.dat", "w");
    if (BlockFormat_to_BlockFormat == NULL) 
    {
        printf("Error opening the file.\n");
        return;
    }

    for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
        fprintf(BlockFormat_to_BlockFormat, "%d\n", destination[i]);
    }
    fclose(BlockFormat_to_BlockFormat);

    // Block Format to Interleaved Format
    printf("\n\nBlock Format to Interleaved Format\n");
    for (int32_t i = 0; i < SIZE; i++) 
    {
        for (int32_t j = 0; j < NO_OF_CHANNELS; j++) 
        {
            int32_t index = i * NO_OF_CHANNELS + j;
            destination[index] = array[j * SIZE + i]; 
        }
    }

    for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
        printf("%d ", destination[i]);
    }
    
    FILE *BlockFormat_to_InterleavedFormat = fopen("BlockFormat_to_InterleavedFormat.dat", "w"); 
    if (BlockFormat_to_InterleavedFormat == NULL) 
    {
        printf("Error opening the file.\n");
        return;  
    }

    for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
        fprintf(BlockFormat_to_InterleavedFormat, "%d\n", destination[i]);
    }
    fclose(BlockFormat_to_InterleavedFormat); 
    
    // Interleaved Format to Interleaved Format 
    printf("\n\nInterleaved Format to Interleaved Format\n");
    for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
        destination[i] = destination[i]; 
        printf("%d ", destination[i]);
    }

    FILE *InterleavedFormat_to_InterleavedFormat = fopen("InterleavedFormat_to_InterleavedFormat.dat", "w");
    if (InterleavedFormat_to_InterleavedFormat == NULL) 
    {
        printf("Error opening the file.\n");
        return;
    }

    for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
        fprintf(InterleavedFormat_to_InterleavedFormat, "%d\n", destination[i]);
    }
    fclose(InterleavedFormat_to_InterleavedFormat); 
    
    // Interleaved Format to Block Format
    printf("\n\nInterleaved Format to Block Format\n");
    for (int32_t i = 0; i < NO_OF_CHANNELS; i++) 
    {
        for (int32_t j = 0; j < SIZE; j++) 
        {
            int32_t index = j * NO_OF_CHANNELS + i;
            destination[i * SIZE + j] = destination[index]; 
        }
    }

    for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
        printf("%d ", destination[i]);
    }
    
    FILE *InterleavedFormat_to_BlockFormat = fopen("InterleavedFormat_to_BlockFormat.dat", "w"); 
    if (InterleavedFormat_to_BlockFormat == NULL) 
    {
        printf("Error opening the file.\n");
        return; 
    }

    for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
        fprintf(InterleavedFormat_to_BlockFormat, "%d\n", destination[i]);
    }
    fclose(InterleavedFormat_to_BlockFormat); 
}

int32_t main(void) 
{
    FILE *file;
    int32_t number;

    file = fopen("sample.dat", "r");  
    if (file == NULL) 
    {
        printf("Error opening the file.\n");
        return 1; 
    }

    int32_t i = 0;
    while (fscanf(file, "%d", &number) == 1 && i < SIZE * NO_OF_CHANNELS)
    {
        array[i] = number;  
        i++;
    }
    fclose(file);

    D19API(array);

    return 0;  
}
