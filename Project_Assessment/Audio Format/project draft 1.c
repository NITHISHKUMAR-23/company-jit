#include <stdio.h>
#include<stdint.h>

#define SIZE 20            
#define NO_OF_CHANNELS 8   

int32_t array[SIZE * NO_OF_CHANNELS];             
int32_t block_to_block[SIZE * NO_OF_CHANNELS];     
int32_t block_to_interleaved_format[SIZE * NO_OF_CHANNELS]; 
int32_t interleaved_to_interleaved[SIZE * NO_OF_CHANNELS];  
int32_t interleaved_to_block_format[SIZE * NO_OF_CHANNELS];  

void D19API(int32_t array[]) 
{
	// Block Format to Block Format
	printf("\nBlock Format to Block Format\n");
	for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
		block_to_block[i] = array[i]; 
		printf("%d ", block_to_block[i]);
	}
	printf("\n");
    
	FILE *BlockFormat_to_BlockFormat = fopen("BlockFormat_to_BlockFormat.dat", "w");
	if (BlockFormat_to_BlockFormat== NULL) 
    {
		printf("Error opening the file.\n");
		return;
	}

	for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
		fprintf(BlockFormat_to_BlockFormat, "%d\n", block_to_block[i]);
	}
	fclose(BlockFormat_to_BlockFormat);

    // Block Format to Interleaved Format
	printf("\n\nBlock Format to Interleaved Format\n");
	for (int32_t i = 0; i < SIZE; i++) 
    {
		for (int32_t j = 0; j < NO_OF_CHANNELS; j++) 
        {
			int32_t index = i * NO_OF_CHANNELS + j;
			block_to_interleaved_format[index] = block_to_block[j * SIZE + i];
		}
	}

	for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
		printf("%d ", block_to_interleaved_format[i]);
	}
	
	FILE *BlockFormat_to_InterleavedFormat= fopen("BlockFormat_to_InterleavedFormat.dat", "w"); 
	if (BlockFormat_to_InterleavedFormat == NULL) 
    {
		printf("Error opening the file.\n");
		return;  
	}
	
	for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
		fprintf(BlockFormat_to_InterleavedFormat, "%d\n", block_to_interleaved_format[i]);
	}
	fclose(BlockFormat_to_InterleavedFormat); 
	
	// Interleaved Format to Interleaved Format 
    printf("\n\nInterleaved Format to Interleaved Format\n");
    for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
        interleaved_to_interleaved[i] = block_to_interleaved_format[i];
        printf("%d ", interleaved_to_interleaved[i]);
    }

	FILE *InterleavedFormat_to_InterleavedFormat = fopen("InterleavedFormat_to_InterleavedFormat.dat", "w");  // Open the file in write mode
	if (InterleavedFormat_to_InterleavedFormat == NULL) 
    {
		printf("Error opening the file.\n");
		return;
	}

	for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
		fprintf(InterleavedFormat_to_InterleavedFormat, "%d\n", interleaved_to_interleaved[i]);
	}
	fclose(InterleavedFormat_to_InterleavedFormat); 
	
	// Interleaved Format to Block Format
    printf("\n\nInterleaved Format to Block Format\n");
    for (int32_t i = 0; i < NO_OF_CHANNELS; i++) 
    {
        for (int32_t j = 0; j < SIZE; j++) 
        {
            int32_t index = j * NO_OF_CHANNELS + i;
            interleaved_to_block_format[i * SIZE + j] = interleaved_to_interleaved[index];
        }
    }

    for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
        printf("%d ", interleaved_to_block_format[i]);
    }
    
	FILE *InterleavedFormat_to_BlockFormat = fopen("InterleavedFormat_to_BlockFormat.dat", "w");  // Open the file in write mode
	if (InterleavedFormat_to_BlockFormat  == NULL) 
    {
		printf("Error opening the file.\n");
		return; 
	}

	for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++) 
    {
		fprintf(InterleavedFormat_to_BlockFormat , "%d\n",interleaved_to_block_format[i]);
	}
	fclose(InterleavedFormat_to_BlockFormat ); 
	
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
