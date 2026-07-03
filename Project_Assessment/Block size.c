#include <stdio.h>
#include <stdlib.h>

void print_data_info(const char *filename, int num_channels, size_t block_size) {
    FILE *file = fopen(filename, "rb");
    if (file == NULL) {
        perror("Error opening file");
        return;
    }

    // Find the file size
    fseek(file, 0, SEEK_END);
    long file_size = ftell(file);
    fseek(file, 0, SEEK_SET);

    // Calculate the number of blocks (samples per block)
    size_t num_samples = file_size / (num_channels * sizeof(float));

    printf("File: %s\n", filename);
    printf("Number of Channels: %d\n", num_channels);
    printf("Block Size: %zu\n", num_samples);
    printf("Number of Samples in File: %zu\n", num_samples);
    printf("Total Data Size: %ld bytes\n", file_size);

    // Read the data (example of reading the first few samples)
    float *data = (float *)malloc(num_channels * sizeof(float));  // One block of data

    for (size_t i = 0; i < num_samples; ++i) {
        size_t read_count = fread(data, sizeof(float), num_channels, file);
        if (read_count != num_channels) {
            printf("Error reading data at sample %zu\n", i);
            break;
        }
        // Process or print the data (this is just for demonstration)
        printf("Block %zu: ", i + 1);
        for (int j = 0; j < num_channels; ++j) {
            printf("%f ", data[j]);
        }
        printf("\n");
    }

    free(data);
    fclose(file);
}

int main() {
    const char *filename = "MCPCM_48K_Sine_input.dat"; // Replace with your file path
    int num_channels = 8; // Assume you know the number of channels
    size_t block_size = 1024; // Assume each block contains 1024 samples (adjust as needed)

    print_data_info(filename, num_channels, block_size);

    return 0;
}
