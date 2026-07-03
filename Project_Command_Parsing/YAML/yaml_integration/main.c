#include <stdio.h>
#include <stdlib.h>

int main() {
    // Parameters to pass to the Python script
    int Command = 0x35;
    int Parameter = 1;
    int start = 10;
    int end = 8;
    const char *value = "110";  // Value is a string, which is fine

    // Construct the command string with the arguments
    char command[512];
    snprintf(command, sizeof(command), 
        "python D:\\Project_Command_Parsing\\YAML\\yaml_integration\\yaml_access.py %X %d %d %d %s", 
        Command, Parameter, start, end, value);

    // Open a pipe to the Python script and pass the arguments
    FILE *fp = popen(command, "r");
    if (fp == NULL) {
        perror("Failed to run Python script");
        return EXIT_FAILURE;
    }

    // Read and display the output from the Python script
    char output[1024];
    while (fgets(output, sizeof(output), fp) != NULL) {
        printf("%s", output);  // Print the output from Python
    }

    // Close the file pointer
    fclose(fp);

    return 0;
}
