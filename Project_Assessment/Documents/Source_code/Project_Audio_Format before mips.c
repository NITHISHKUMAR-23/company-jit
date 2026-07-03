/*****************************************************************************
 * Audio_Format_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "Audio_Format_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

#include <stdio.h>
#include <stdint.h>

void D19API(int32_t array[], int32_t SIZE, int32_t NO_OF_CHANNELS, int32_t destination[], int32_t conversion, int32_t OUTPUT_CHANNELS, int32_t file_type)
{
	switch(conversion)
	{
	case 1:
	    printf("\nBlock Format to Block Format\n");
	    if(file_type == 1)
	    {
	        // Block Format to Block Format for Block File
		    for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
		    {
			    for (int32_t j = 0; j < SIZE; j++)
			    {
				    int32_t index = j * NO_OF_CHANNELS + i;
				    destination[j * NO_OF_CHANNELS + i] = array[index];
			    }
		    }
	    }
	    else if(file_type == 2)
		{
		    // Block Format to Block Format for Interleaved File
		    for (int32_t i = 0; i < SIZE; i++)
		    {
			    for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
			    {
				    int32_t index = i * NO_OF_CHANNELS + j;
				    destination[j * SIZE + i] = array[index];
			    }
		    }
		}

		FILE *BlockFormat_to_BlockFormat = fopen("BlockFormat_to_BlockFormat.dat", "w");
		if (BlockFormat_to_BlockFormat == NULL)
		{
			printf("Error opening the file\n");
			return;
		}

		for (int32_t i = 0; i < SIZE * OUTPUT_CHANNELS; i++)
		{
			fprintf(BlockFormat_to_BlockFormat, "%x\n", destination[i]);
		}
		fclose(BlockFormat_to_BlockFormat);
		break;

	case 2:
	    printf("\nBlock Format to Interleaved Format\n");
	    if(file_type == 1)
	    {
	        // Block Format to Interleaved Format for Block File
		    for (int32_t i = 0; i < SIZE; i++)
		    {
			    for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
		    	{
			    	int32_t index = i * NO_OF_CHANNELS + j;
				    destination[j * SIZE + i] = array[index];
			    }
		    }
	    }
		else if(file_type == 2)
		{
		    // Block Format to Interleaved Format for Interleaved File
		    for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
		    {
			    for (int32_t j = 0; j < SIZE; j++)
			    {
			    	int32_t index = j * NO_OF_CHANNELS + i;
				    destination[j * NO_OF_CHANNELS + i] = array[index];
			    }
		    }
		}

		FILE *BlockFormat_to_InterleavedFormat = fopen("BlockFormat_to_InterleavedFormat.dat", "w");
		if (BlockFormat_to_InterleavedFormat == NULL)
		{
			printf("Error opening the file\n");
			return;
		}

		for (int32_t i = 0; i < SIZE * OUTPUT_CHANNELS; i++)
		{
			fprintf(BlockFormat_to_InterleavedFormat, "%x\n", destination[i]);
		}
		fclose(BlockFormat_to_InterleavedFormat);
		break;

	case 3:
	    printf("\nInterleaved Format to Interleaved Format\n");
	    if(file_type == 1)
	    {
	        // Interleaved Format to Interleaved Format for Block File
		    for (int32_t i = 0; i < SIZE; i++)
    		{
	    		for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
		    	{
			    	int32_t index = i * NO_OF_CHANNELS + j;
				    destination[j * SIZE + i] = array[index];
    			}
	    	}
	    }
		else if(file_type == 2)
		{
		    // Interleaved Format to Interleaved Format for Interleaved File
    		for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
	    	{
		    	for (int32_t j = 0; j < SIZE; j++)
			    {
				    int32_t index = j * NO_OF_CHANNELS + i;
    				destination[j * NO_OF_CHANNELS + i] = array[index];
		    	}
		    }
		}

		FILE *InterleavedFormat_to_InterleavedFormat = fopen("InterleavedFormat_to_InterleavedFormat.dat", "w");
		if (InterleavedFormat_to_InterleavedFormat == NULL)
		{
			printf("Error opening the file\n");
			return;
		}

		for (int32_t i = 0; i < SIZE * OUTPUT_CHANNELS; i++)
		{
			fprintf(InterleavedFormat_to_InterleavedFormat, "%x\n", destination[i]);
		}
		fclose(InterleavedFormat_to_InterleavedFormat);
		break;

	case 4:
    	printf("\nInterleaved Format to Block Format\n");
	    if(file_type == 1)
	    {
	        // Interleaved Format to Block Format for Block File
    		for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
	    	{
		    	for (int32_t j = 0; j < SIZE; j++)
			    {
				    int32_t index = j * NO_OF_CHANNELS + i;
    				destination[j * NO_OF_CHANNELS + i] = array[index];
	    		}
		    }
	    }
	    else if(file_type == 2)
	    {
	        // Interleaved Format to Block Format for Interleaved File
    		for (int32_t i = 0; i < SIZE; i++)
	    	{
		    	for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
			    {
				    int32_t index = i * NO_OF_CHANNELS + j;
	    			destination[j * SIZE + i] = array[index];
		    	}
	    	}
	    }

		FILE *InterleavedFormat_to_BlockFormat = fopen("InterleavedFormat_to_BlockFormat.dat", "w");
		if (InterleavedFormat_to_BlockFormat == NULL)
		{
			printf("Error opening the file\n");
			return;
		}

		for (int32_t i = 0; i < SIZE * OUTPUT_CHANNELS; i++)
		{
			fprintf(InterleavedFormat_to_BlockFormat, "%x\n", destination[i]);
		}
		fclose(InterleavedFormat_to_BlockFormat);
		break;

	default:
		printf("Invalid conversion type\n");
        return;
	}

	if (OUTPUT_CHANNELS > NO_OF_CHANNELS)
	{
	    for (int32_t i = SIZE * NO_OF_CHANNELS; i < SIZE * OUTPUT_CHANNELS; i++)
	    {
			destination[i] = destination[i % (SIZE * NO_OF_CHANNELS)];
		}
	}
	for (int32_t i = 0; i < SIZE * OUTPUT_CHANNELS; i++)
	{
		printf("%x ",destination[i]);
	}

}

int32_t main(void)
{
	FILE *file;
	int32_t number;
	int32_t SIZE;
	int32_t NO_OF_CHANNELS;
	int32_t OUTPUT_CHANNELS;

	SIZE = 256;
	NO_OF_CHANNELS = 16;
	OUTPUT_CHANNELS = 16;

	int32_t array[SIZE * NO_OF_CHANNELS];

	#pragma section("destination_mapped_in_l3")
	int32_t destination[SIZE * OUTPUT_CHANNELS];

	int32_t conversion = 3;
	int32_t file_type = 2;
	int32_t i;

	i = 0;

	file = fopen("MCPCM_48K_Sine_input.dat", "r");
	if (file == NULL)
	{
		printf("Error opening the file.\n");
		return 1;
	}

	while (fscanf(file, "%x", &number) == 1 && i < SIZE * NO_OF_CHANNELS)
	{
		array[i] = number;
		i++;
	}
	fclose(file);

//    printf("Enter file type (1 - Block or 2 - Interleaved): ");
//	scanf("%d", &file_type);

	if(file_type !=1 && file_type != 2)
	{
	    printf("Invalid File Type");
	    return 0;
	}
	
//	printf("Conversion Types\n"
//	"1 - Block_to_Block\n"
//	"2 - Block_to_Interleaved\n"
//	"3 - Interleaved_to_Interleaved\n"
//	"4 - Interleaved_to_Block\n"
//	"Enter conversion type (1-4) : ");
//	scanf("%d", &conversion);

	D19API(array, SIZE, NO_OF_CHANNELS, destination, conversion, OUTPUT_CHANNELS, file_type);

	return 0;
}
