#include "Audio_Format_Core1.h"


inline int32_t * D19API(int32_t source_array[], int32_t conversion_type, int32_t file_type)
{
    switch (conversion_type)
    {
    case BLOCK_TO_BLOCK:
        printf("\nBlock Format to Block Format\n");
        if (file_type == BLOCK)
        {
            // Block Format to Block Format for Block File
            #pragma vector_for
            #pragma no_alias
            for (int32_t i = 0; i < INPUT_CHANNELS; i++)
            {
                for (int32_t j = 0; j < SIZE; j++)
                {
                    int32_t index = (j * INPUT_CHANNELS) + i;
                    destination[(j * INPUT_CHANNELS) + i] = source_array[index];
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
                for (int32_t j = 0; j < INPUT_CHANNELS; j++)
                {
                    int32_t index = (i * INPUT_CHANNELS) + j;
                    destination[(j * SIZE) + i] = source_array[index];
                }
            }
        }
        break;

    case BLOCK_TO_INTERLEAVED:
        printf("\nBlock Format to Interleaved Format\n");
        if (file_type == BLOCK)
        {
            // Block Format to Interleaved Format for Block File
            #pragma vector_for
            #pragma no_alias
            for (int32_t i = 0; i < SIZE; i++)
            {
                for (int32_t j = 0; j < INPUT_CHANNELS; j++)
                {
                    int32_t index = (i * INPUT_CHANNELS) + j;
                    destination[(j * SIZE) + i] = source_array[index];
                }
            }
        }

        else
        {
            // Block Format to Interleaved Format for Interleaved File
            #pragma vector_for
            #pragma no_alias
            for (int32_t i = 0; i < INPUT_CHANNELS; i++)
            {
                for (int32_t j = 0; j < SIZE; j++)
                {
                    int32_t index = (j * INPUT_CHANNELS) + i;
                    destination[(j * INPUT_CHANNELS) + i] = source_array[index];
                }
            }
        }
        break;

    case INTERLEAVED_TO_INTERLEAVED:
        printf("\nInterleaved Format to Interleaved Format\n");
        if (file_type == BLOCK)
        {
            // Interleaved Format to Interleaved Format for Block File
            #pragma vector_for
            #pragma no_alias
            for (int32_t i = 0; i < SIZE; i++)
            {
                for (int32_t j = 0; j < INPUT_CHANNELS; j++)
                {
                    int32_t index = (i * INPUT_CHANNELS) + j;
                    destination[(j * SIZE) + i] = source_array[index];
                }
            }
        }

        else
        {
            // Interleaved Format to Interleaved Format for Interleaved File
            #pragma vector_for
            #pragma no_alias
            for (int32_t i = 0; i < INPUT_CHANNELS; i++)
            {
                for (int32_t j = 0; j < SIZE; j++)
                {
                    int32_t index = (j * INPUT_CHANNELS) + i;
                    destination[(j * INPUT_CHANNELS) + i] = source_array[index];
                }
            }
        }
        break;

    case INTERLEAVED_TO_BLOCK:
        printf("\nInterleaved Format to Block Format\n");
        if (file_type == BLOCK)
        {
            // Interleaved Format to Block Format for Block File
            #pragma vector_for
            #pragma no_alias
            for (int32_t i = 0; i < INPUT_CHANNELS; i++)
            {
                for (int32_t j = 0; j < SIZE; j++)
                {
                    int32_t index = (j * INPUT_CHANNELS) + i;
                    destination[(j * INPUT_CHANNELS) + i] = source_array[index];
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
                for (int32_t j = 0; j < INPUT_CHANNELS; j++)
                {
                    int32_t index = (i * INPUT_CHANNELS) + j;
                    destination[(j * SIZE) + i] = source_array[index];
                }
            }
        }
        break;

    default:
        printf("Invalid conversion type\n");
        return NULL;
    }


    if (OUTPUT_CHANNELS > INPUT_CHANNELS)
        {
            #pragma vector_for
            #pragma no_alias
            for (int32_t i = (SIZE * INPUT_CHANNELS); i < (SIZE * OUTPUT_CHANNELS); i++)
            {
                destination[i] = destination[i % (SIZE * INPUT_CHANNELS)];
            }
        }

    return destination;

}


// Function to write the contents in output file
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

