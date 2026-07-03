#include <stdio.h>
#include <stdint.h>

void D19API(int32_t array[], int32_t input_size, int32_t input_channel, int32_t destination[], int32_t conversion) 
{
    switch(conversion) 
    {
        case 1:
            // Block Format to Block Format
            printf("\nBlock Format to Block Format\n");
            for (int32_t i = 0; i < input_size * input_channel; i++) 
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

            for (int32_t i = 0; i < input_size * input_channel; i++) 
            {
                fprintf(BlockFormat_to_BlockFormat, "%d\n", destination[i]);
            }
            fclose(BlockFormat_to_BlockFormat);
            break;  // Add break here to exit the case
        
        case 2:
            // Block Format to Interleaved Format
            printf("\n\nBlock Format to Interleaved Format\n");
            for (int32_t i = 0; i < input_size; i++) 
            {
                for (int32_t j = 0; j < input_channel; j++) 
                {
                    int32_t index = i * input_channel + j;
                    destination[index] = array[j * input_size + i]; 
                }
            }

            for (int32_t i = 0; i < input_size * input_channel; i++) 
            {
                printf("%d ", destination[i]);
            }

            FILE *BlockFormat_to_InterleavedFormat = fopen("BlockFormat_to_InterleavedFormat.dat", "w"); 
            if (BlockFormat_to_InterleavedFormat == NULL) 
            {
                printf("Error opening the file.\n");
                return;  
            }

            for (int32_t i = 0; i < input_size * input_channel; i++) 
            {
                fprintf(BlockFormat_to_InterleavedFormat, "%d\n", destination[i]);
            }
            fclose(BlockFormat_to_InterleavedFormat); 
            break;  // Add break here to exit the case
        
        case 3:
            // Interleaved Format to Interleaved Format 
            printf("\n\nInterleaved Format to Interleaved Format\n");
            for (int32_t i = 0; i < input_size; i++) 
            {
                for (int32_t j = 0; j < input_channel; j++) 
                {
                    int32_t index = i * input_channel + j;
                    destination[index] = array[j * input_size + i]; 
                }
            }
            for (int32_t i = 0; i < input_size * input_channel; i++) 
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

            for (int32_t i = 0; i < input_size * input_channel; i++) 
            {
                fprintf(InterleavedFormat_to_InterleavedFormat, "%d\n", destination[i]);
            }
            fclose(InterleavedFormat_to_InterleavedFormat); 
            break;  // Add break here to exit the case
        
        case 4:
            // Interleaved Format to Block Format
            printf("\n\nInterleaved Format to Block Format\n");
            for (int32_t i = 0; i < input_size; i++) 
            {
                for (int32_t j = 0; j < input_channel; j++) 
                {
                    int32_t index = i * input_channel + j;
                    destination[index] = array[j * input_size + i]; 
                }
            }
            
            for (int32_t i = 0; i < input_channel; i++) 
            {
                for (int32_t j = 0; j < input_size; j++) 
                {
                    int32_t index = j * input_channel + i;
                    destination[i * input_size + j] = destination[index]; 
                }
            }

            for (int32_t i = 0; i < input_size * input_channel; i++) 
            {
                printf("%d ", destination[i]);
            }

            FILE *InterleavedFormat_to_BlockFormat = fopen("InterleavedFormat_to_BlockFormat.dat", "w"); 
            if (InterleavedFormat_to_BlockFormat == NULL) 
            {
                printf("Error opening the file.\n");
                return; 
            }

            for (int32_t i = 0; i < input_size * input_channel; i++) 
            {
                fprintf(InterleavedFormat_to_BlockFormat, "%d\n", destination[i]);
            }
            fclose(InterleavedFormat_to_BlockFormat); 
            break;  // Add break here to exit the case

        default:
            printf("Invalid conversion type.\n");
            break; // Default case for invalid input
    }
}

int32_t main(void) 
{
    FILE *file;
    int32_t number;
    int32_t input_size = 20;
    int32_t input_channel = 8;
    int32_t array[input_size * input_channel];  
    int32_t destination[input_size * input_channel];
    int32_t conversion;

    file = fopen("sample.dat", "r");  
    if (file == NULL) 
    {
        printf("Error opening the file.\n");
        return 1; 
    }

    int32_t i = 0;
    while (fscanf(file, "%d", &number) == 1 && i < input_size * input_channel)
    {
        array[i] = number;  
        i++;
    }
    fclose(file);
    
    printf("Enter conversion type (1-4): ");
    scanf("%d", &conversion); // Corrected scanf format for input
    
    D19API(array, input_size, input_channel, destination, conversion);

    return 0;  
}
