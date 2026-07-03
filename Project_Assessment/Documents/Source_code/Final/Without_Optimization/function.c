
#include "Audio_Format_Before_Optimization_Core1.h"

int32_t * D19API(int32_t array[], int32_t conversion, int32_t file_type)
{
    switch (conversion)
    {
    case 1:
        printf("\nBlock Format to Block Format\n");
        if (file_type == 1)
        {
            // Block Format to Block Format for Block File
            for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
            {
                for (int32_t j = 0; j < SIZE; j++)
                {
                    int32_t index = (j * NO_OF_CHANNELS) + i;
                    destination[(j * NO_OF_CHANNELS) + i] = array[index];
                }
            }
        }

        else
        {
            // Block Format to Block Format for Interleaved File
            for (int32_t i = 0; i < SIZE; i++)
            {
                for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
                {
                    int32_t index = (i * NO_OF_CHANNELS) + j;
                    destination[(j * SIZE) + i] = array[index];
                }
            }
        }
        break;

    case 2:
        printf("\nBlock Format to Interleaved Format\n");
        if (file_type == 1)
        {
            // Block Format to Interleaved Format for Block File
            for (int32_t i = 0; i < SIZE; i++)
            {
                for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
                {
                    int32_t index = (i * NO_OF_CHANNELS) + j;
                    destination[(j * SIZE) + i] = array[index];
                }
            }
        }

        else
        {
            // Block Format to Interleaved Format for Interleaved File
            for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
            {
                for (int32_t j = 0; j < SIZE; j++)
                {
                    int32_t index = (j * NO_OF_CHANNELS) + i;
                    destination[(j * NO_OF_CHANNELS) + i] = array[index];
                }
            }
        }
        break;

    case 3:
        printf("\nInterleaved Format to Interleaved Format\n");
        if (file_type == 1)
        {
            // Interleaved Format to Interleaved Format for Block File
            for (int32_t i = 0; i < SIZE; i++)
            {
                for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
                {
                    int32_t index = (i * NO_OF_CHANNELS) + j;
                    destination[(j * SIZE) + i] = array[index];
                }
            }
        }

        else
        {
            // Interleaved Format to Interleaved Format for Interleaved File
            for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
            {
                for (int32_t j = 0; j < SIZE; j++)
                {
                    int32_t index = (j * NO_OF_CHANNELS) + i;
                    destination[(j * NO_OF_CHANNELS) + i] = array[index];
                }
            }
        }
        break;

    case 4:
        printf("\nInterleaved Format to Block Format\n");
        if (file_type == 1)
        {
            // Interleaved Format to Block Format for Block File
            for (int32_t i = 0; i < NO_OF_CHANNELS; i++)
            {
                for (int32_t j = 0; j < SIZE; j++)
                {
                    int32_t index = (j * NO_OF_CHANNELS) + i;
                    destination[(j * NO_OF_CHANNELS) + i] = array[index];
                }
            }
        }

        else
        {
            // Interleaved Format to Block Format for Interleaved File
            for (int32_t i = 0; i < SIZE; i++)
            {
                for (int32_t j = 0; j < NO_OF_CHANNELS; j++)
                {
                    int32_t index = (i * NO_OF_CHANNELS) + j;
                    destination[(j * SIZE) + i] = array[index];
                }
            }
        }
        break;

    default:
        printf("Invalid conversion type\n");
        return NULL;
    }

    if (OUTPUT_CHANNELS > NO_OF_CHANNELS)
    {
        for (int32_t i = (SIZE * NO_OF_CHANNELS); i < (SIZE * OUTPUT_CHANNELS); i++)
        {
        	destination[i] = destination[i % (SIZE * NO_OF_CHANNELS)];
        }
    }
    return destination;

}

void write_output_file(const char *filename)
{
    FILE *output_file = fopen(filename, "w");
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

