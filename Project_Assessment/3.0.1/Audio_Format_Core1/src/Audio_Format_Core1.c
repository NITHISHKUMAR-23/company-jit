/*****************************************************************************
 * Audio_Format_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "Audio_Format_Core1.h"

int32_t main(void)
{
    FILE *file;
    int32_t input_data;
    int32_t file_type;
    int32_t conversion_type;
    int32_t i;

	#pragma section("array_mapped_in_l3")
    static int32_t source_array[SIZE * INPUT_CHANNELS];

    file_type = 20;     // 10-Block format data,  20-Interleaved format data
    conversion_type = 3;    // 1-Block to Block, 2-Block to Interleaved, 3-Interleaved to Interleaved, 4-Interleaved to Block
    i = 0;

    file = fopen("MCPCM_48K_Sine_input.dat", "r");
    if (file == NULL)
    {
        printf("Error opening the file.\n");
        return 1;
    }

    #pragma vector_for
    #pragma no_alias
    while (fscanf(file, "%x", &input_data) == 1 && i < (SIZE * INPUT_CHANNELS))
    {
    	source_array[i] = input_data;
        i++;
    }
    fclose(file);

    if (file_type != BLOCK && file_type != INTERLEAVED)   // Checking the input file type
    {
        printf("Invalid File Type\n");
        return 0;
    }

    int32_t *output = D19API(source_array, conversion_type, file_type);

    for (int32_t i = 0; i < (SIZE * OUTPUT_CHANNELS); i++)
    {
        printf("%x ", *(output+i) );
    }
    printf("\n");

    // Write output to file
    write_output_file("output_file.dat");

    return 0;
}
