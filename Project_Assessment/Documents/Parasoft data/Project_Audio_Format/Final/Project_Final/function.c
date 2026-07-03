#include "Audio_Format_Core1.h"

inline int32_t * D19API(int32_t array[], int32_t conversion, int32_t file_type)
{
    switch (conversion)
    {
    case 1:
        if (file_type == 1)
        {
            // Block Format to Block Format for Block File
            #pragma vector_for
            #pragma no_alias
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
            #pragma vector_for
            #pragma no_alias
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
        if (file_type == 1)
        {
            // Block Format to Interleaved Format for Block File
            #pragma vector_for
            #pragma no_alias
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
            #pragma vector_for
            #pragma no_alias
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
        if (file_type == 1)
        {
            // Interleaved Format to Interleaved Format for Block File
            #pragma vector_for
            #pragma no_alias
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
            #pragma vector_for
            #pragma no_alias
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
        if (file_type == 1)
        {
            // Interleaved Format to Block Format for Block File
            #pragma vector_for
            #pragma no_alias
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
            #pragma vector_for
            #pragma no_alias
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
        return NULL;
    }
    return destination;
}

void output_channels_check(void)
{
    if (NO_OF_CHANNELS < OUTPUT_CHANNELS )
    {
        #pragma vector_for
        #pragma no_alias
        for (int32_t i = (SIZE * NO_OF_CHANNELS); i < (SIZE * OUTPUT_CHANNELS); i++)
        {
            destination[i] = destination[i % (SIZE * NO_OF_CHANNELS)];
        }
    }

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

