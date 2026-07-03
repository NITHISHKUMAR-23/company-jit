#define SIZE 20
#define NO_OF_CHANNELS 8
#define OUTPUT_CHANNELS 8

#include <stdio.h>
#include <stdint.h>

#pragma section("destination_mapped_in_l3")
static int32_t destination[SIZE * OUTPUT_CHANNELS];



void D19API(int32_t array[], int32_t conversion, int32_t file_type)
{
	switch (conversion)
	{
	case 1:
	    printf("\nBlock Format to Block Format\n");
	    if(file_type == 1)
	    {
	        // Block Format to Block Format for Block File
			#pragma vector_for
			#pragma no_alias
		    for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
		    {
			    for (int32_t j = 0; j < SIZE; j++)
			    {
				    int32_t index = j * NO_OF_CHANNELS + i;
				    destination[j * NO_OF_CHANNELS + i] = array[index];
			    }
		    }
	    }
	    else
		{
		    // Block Format to Block Format for Interleaved File
			#pragma vector_for
			#pragma no_alias
		    for (int32_t i = 0; i < SIZE; i++)
		    {
			    for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
			    {
				    int32_t index = (i * NO_OF_CHANNELS) + j;
				    destination[j * SIZE + i] = array[index];
			    }
		    }
		}
		break;

	case 2:
	    printf("\nBlock Format to Interleaved Format\n");
	    if(file_type == 1)
	    {
	        // Block Format to Interleaved Format for Block File
			#pragma vector_for
			#pragma no_alias
		    for (int32_t i = 0; i < SIZE; i++)
		    {
			    for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
		    	{
			    	int32_t index = (i * NO_OF_CHANNELS) + j;
				    destination[j * SIZE + i] = array[index];
			    }
		    }
	    }
		else
		{
		    // Block Format to Interleaved Format for Interleaved File
			#pragma vector_for
			#pragma no_alias
		    for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
		    {
			    for (int32_t j = 0; j < SIZE; j++)
			    {
			    	int32_t index = (j * NO_OF_CHANNELS) + i;
				    destination[j * NO_OF_CHANNELS + i] = array[index];
			    }
		    } 
		}
		break;

	case 3:
	    printf("\nInterleaved Format to Interleaved Format\n");
	    if(file_type == 1)
	    {
	        // Interleaved Format to Interleaved Format for Block File
			#pragma vector_for
			#pragma no_alias
		    for (int32_t i = 0; i < SIZE; i++)
    		{
	    		for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
		    	{
			    	int32_t index = (i * NO_OF_CHANNELS) + j;
				    destination[j * SIZE + i] = array[index];
    			}
	    	}
	    }
		else
		{
		    // Interleaved Format to Interleaved Format for Interleaved File
			#pragma vector_for
			#pragma no_alias
    		for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
	    	{
		    	for (int32_t j = 0; j < SIZE; j++)
			    {
				    int32_t index = (j * NO_OF_CHANNELS) + i;
    				destination[j * NO_OF_CHANNELS + i] = array[index];
		    	}
		    }
		}
		break;

	case 4:
    	printf("\nInterleaved Format to Block Format\n");
	    if(file_type == 1)
	    {
	        // Interleaved Format to Block Format for Block File
			#pragma vector_for
			#pragma no_alias
    		for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
	    	{
		    	for (int32_t j = 0; j < SIZE; j++)
			    {
				    int32_t index = (j * NO_OF_CHANNELS) + i;
    				destination[j * NO_OF_CHANNELS + i] = array[index];
	    		}
		    }
	    }
	    else
	    {
	        // Interleaved Format to Block Format for Interleaved File
			#pragma vector_for
			#pragma no_alias
    		for (int32_t i = 0; i < SIZE; i++)
	    	{
		    	for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
			    {
				    int32_t index = i * NO_OF_CHANNELS + j;
	    			destination[j * SIZE + i] = array[index];
		    	}
	    	}
	    }
		break;

	default:
		printf("Invalid conversion type\n");
        return;
	}

	if (OUTPUT_CHANNELS > NO_OF_CHANNELS)
	{
		#pragma vector_for
		#pragma no_alias
	    for (int32_t i = (SIZE * NO_OF_CHANNELS); i < (SIZE * OUTPUT_CHANNELS); i++)
	    {
			destination[i] = destination[i % (SIZE * NO_OF_CHANNELS)];
		}
	}

	for (int32_t i = 0; i < (SIZE * OUTPUT_CHANNELS); i++)
	{
		printf("%x ",destination[i]);
	}

	FILE *output_file = fopen("output_file.dat", "w");
	if (output_file == NULL)
	{
		printf("Error opening the file\n");
		return;
	}
	for (int32_t i = 0; i < (SIZE * OUTPUT_CHANNELS); i++)
	{
		fprintf(output_file, "%x\n", destination[i]);
	}
	fclose(output_file);

}

int32_t main(void)
{
	FILE *file;
	int32_t number;
	int32_t conversion;
	int32_t file_type;
	int32_t i;
	int32_t array[SIZE * NO_OF_CHANNELS];

	conversion = 3;
	file_type = 2;
	i = 0;

	file = fopen("MCPCM_48K_Sine_input.dat", "r");
	if (file == NULL)
	{
		printf("Error opening the file.\n");
		return 1;
	}
	#pragma vector_for
	#pragma no_alias
	while (fscanf(file, "%x", &number) == 1 && i < (SIZE * NO_OF_CHANNELS))
	{
		array[i] = number;
		i++;
	}
	fclose(file);

	if(file_type !=1 && file_type != 2)
	{
	    printf("Invalid File Type");
	    return 0;
	}

	D19API(array, conversion, file_type);

	return 0;
}
