/*****************************************************************************
 * Audio_Format_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "Audio_Format_Core1.h"

int32_t main(void)
{
    FILE *file;
    int32_t number;
    int32_t file_type;
    int32_t conversion;
    int32_t i;
    int32_t array[SIZE * NO_OF_CHANNELS];

    file_type = 1;
    conversion = 1;
    i = 0;

    file = fopen("sample_block.dat", "r");
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

    if (file_type != 1 && file_type != 2)
    {
        printf("Invalid File Type\n");
        return 0;
    }

    int32_t *output = D19API(array, conversion, file_type);

    for (int32_t i = 0; i < (SIZE * OUTPUT_CHANNELS); i++)
    {
        printf("%x ", *(output+i) );
    }
    printf("\n");

    // Write output to file
    write_output_file("output_file.dat");

    return 0;
}
