#include <python3.12/Python.h>  // Include the Python API for C (Python 3.12)
#include <stdio.h>  // Include standard input/output library
#include <stdbool.h>    // Include library for using boolean type

// Function prototype for command identification
int command_identification(char*,char*,int,char**);
// Function prototype for calling a Python function from C and passing parameters
char* c_to_python_call(char*,char*,int,int,char*,char*,int);

// structure to store parsed data from Python call
typedef struct 
{
    int parameter_count;
    char* Dict;
}Python_return_values;

// Global variable to store the parsed return values
Python_return_values parser;

// Boolean variable to reference the type of file (JSON or YAML)
bool reference_file_type = 0;

// File paths for the JSON and YAML files that store command reference data
char* Json_File = "D:\\smac_training_2024\\Source_Code_Folders\\Working\\TTL_Parser\\Input_Files\\Command_Reference_JSON.json";
char* Yaml_File = "D:\\smac_training_2024\\Source_Code_Folders\\Working\\TTL_Parser\\Input_Files\\Command_Reference_YAML.yaml";