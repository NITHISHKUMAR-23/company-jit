#include <stdio.h>
#include <stdlib.h>

int main() {
    // Parameters to pass to the Python script
    const char *command_name = "Special_Commands";  // Example command name
    const char *bitfield = "5-4";              // Example bitfield
    const char *value_to_find = "10";        // Example value to search for

    // Construct the command string with the arguments
    char command[512];
    snprintf(command, sizeof(command), "python D:\\Project_Command_Parsing\\YAML\\C\\c_json_py\\parser.py %s %s %s", command_name, bitfield, value_to_find);

    // Open a pipe to the Python script and pass the arguments
    FILE *fp = popen(command, "r");
    if (fp == NULL) {
        perror("Failed to run Python script");
        return EXIT_FAILURE;
    }

    // Read and display the output from the Python script
    char output[1024];
    while (fgets(output, sizeof(output), fp) != NULL) {
        printf("%s", output);
    }

    // Close the file pointer
    fclose(fp);

    return 0;
}
