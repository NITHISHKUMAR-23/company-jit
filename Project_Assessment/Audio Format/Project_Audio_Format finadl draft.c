#include <stdio.h>
#include <stdint.h>

void D19API(int32_t array[], int32_t SIZE, int32_t NO_OF_CHANNELS, int32_t destination[], int32_t conversion, int32_t output_CHANNELS)
{
	switch(conversion)
	{
	case 1:
		// Block Format to Block Format
		printf("\nBlock Format to Block Format\n");
		for (int32_t i = 0; i < SIZE * NO_OF_CHANNELS; i++)
		{
		    destination[i] = array[i];
		}
		
        if (output_CHANNELS > NO_OF_CHANNELS) 
        {
			for (int32_t i = SIZE * NO_OF_CHANNELS; i < SIZE * output_CHANNELS; i++) 
            {
				destination[i] = destination[i % (SIZE * NO_OF_CHANNELS)]; 
			}
		}
		for (int32_t i = 0; i < SIZE * output_CHANNELS; i++) 
        {
			printf("%d ",destination[i]);
		}

		printf("\n");

		FILE *BlockFormat_to_BlockFormat = fopen("BlockFormat_to_BlockFormat.dat", "w");
		if (BlockFormat_to_BlockFormat == NULL)
		{
			printf("Error opening the file.\n");
			return;
		}

		for (int32_t i = 0; i < SIZE * output_CHANNELS; i++)
		{
			fprintf(BlockFormat_to_BlockFormat, "%d\n", destination[i]);
		}
		fclose(BlockFormat_to_BlockFormat);
		break;

	case 2:
		// Block Format to Interleaved Format
		printf("\nBlock Format to Interleaved Format\n");
		for (int32_t i = 0; i < SIZE; i++)
		{
			for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
			{
				int32_t index = i * NO_OF_CHANNELS + j;
				destination[j * SIZE + i] = array[index];
			}
		}

		if (output_CHANNELS > NO_OF_CHANNELS) 
        {
			for (int32_t i = SIZE * NO_OF_CHANNELS; i < SIZE * output_CHANNELS; i++) 
            {
				destination[i] = destination[i % (SIZE * NO_OF_CHANNELS)]; 
			}
		}

		for (int32_t i = 0; i < SIZE * output_CHANNELS; i++)
		{
			printf("%d ", destination[i]);
		}

		FILE *BlockFormat_to_InterleavedFormat = fopen("BlockFormat_to_InterleavedFormat.dat", "w");
		if (BlockFormat_to_InterleavedFormat == NULL)
		{
			printf("Error opening the file.\n");
			return;
		}

		for (int32_t i = 0; i < SIZE * output_CHANNELS; i++)
		{
			fprintf(BlockFormat_to_InterleavedFormat, "%d\n", destination[i]);
		}
		fclose(BlockFormat_to_InterleavedFormat);
		break;

	case 3:
		// Interleaved Format to Interleaved Format
		printf("\nInterleaved Format to Interleaved Format\n");
		for (int32_t i = 0; i < SIZE; i++)
		{
			for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
			{
				int32_t index = i * NO_OF_CHANNELS + j;
				destination[j * SIZE + i] = array[index];
			}
		}

		// Handle output for more output channels than input channels
		if (output_CHANNELS > NO_OF_CHANNELS) {
			for (int32_t i = SIZE * NO_OF_CHANNELS; i < SIZE * output_CHANNELS; i++) 
            {
				destination[i] = destination[i % (SIZE * NO_OF_CHANNELS)]; 
			}
		}

		for (int32_t i = 0; i < SIZE * output_CHANNELS; i++)
		{
			destination[i] = destination[i];
			printf("%d ", destination[i]);
		}

		// Handle output for more output channels than input channels
		if (output_CHANNELS > NO_OF_CHANNELS) {
			for (int32_t i = SIZE * NO_OF_CHANNELS; i < SIZE * output_CHANNELS; i++) 
            {
				destination[i] = destination[i % (SIZE * NO_OF_CHANNELS)]; 
			}
		}

		FILE *InterleavedFormat_to_InterleavedFormat = fopen("InterleavedFormat_to_InterleavedFormat.dat", "w");
		if (InterleavedFormat_to_InterleavedFormat == NULL)
		{
			printf("Error opening the file.\n");
			return;
		}

		for (int32_t i = 0; i < SIZE * output_CHANNELS; i++)
		{
			fprintf(InterleavedFormat_to_InterleavedFormat, "%d\n", destination[i]);
		}
		fclose(InterleavedFormat_to_InterleavedFormat);
		break;

	case 4:
		// Interleaved Format to Block Format
		printf("\nInterleaved Format to Block Format\n");
		for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
		{
			for (int32_t j = 0; j < SIZE; j++)
			{
				int32_t index = j * NO_OF_CHANNELS + i;
				destination[j * NO_OF_CHANNELS + i] = array[index];
			}
		}
		
		// Handle output for more output channels than input channels
		if (output_CHANNELS > NO_OF_CHANNELS) {
			for (int32_t i = SIZE * NO_OF_CHANNELS; i < SIZE * output_CHANNELS; i++) 
            {
				destination[i] = destination[i % (SIZE * NO_OF_CHANNELS)]; 
			}
		}

		for (int32_t i = 0; i < SIZE * output_CHANNELS; i++)
		{
			printf("%d ", destination[i]);
		}

		FILE *InterleavedFormat_to_BlockFormat = fopen("InterleavedFormat_to_BlockFormat.dat", "w");
		if (InterleavedFormat_to_BlockFormat == NULL)
		{
			printf("Error opening the file.\n");
			return;
		}

		for (int32_t i = 0; i < SIZE * output_CHANNELS; i++)
		{
			fprintf(InterleavedFormat_to_BlockFormat, "%d\n", destination[i]);
		}
		fclose(InterleavedFormat_to_BlockFormat);
		break;

	default:
		printf("Invalid conversion type.\n");
		break;
	}
}

int32_t main(void)
{
	FILE *file;
	int32_t number;
	int32_t SIZE = 4;               
	int32_t NO_OF_CHANNELS = 2;     
	int32_t output_CHANNELS = 2;    
	int32_t array[SIZE * NO_OF_CHANNELS];
	int32_t destination[SIZE * output_CHANNELS];
	int32_t conversion;

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

	printf("Enter conversion type (1-4): ");
	scanf("%d", &conversion); 

	D19API(array, SIZE, NO_OF_CHANNELS, destination, conversion, output_CHANNELS);

	return 0;
}
