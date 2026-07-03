//Include all global declarations here
#include <python3.12/Python.h>  // Include the Python API for C (Python 3.12)
#include <stdio.h>  // Include standard input/output library
#include <stdbool.h>    // Include library for using boolean type
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>
#include <time.h>

// #define MAX_PARAMETERS_COUNT 16
// #define MAX_HEX_LENGTH 11
#define MAX_PARAMETERS_COUNT 40
#define MAX_HEX_LENGTH 8
#define FULL_COMMAND_LENGTH 11
#define LINE_SIZE 256
#define DATE_BUFFER_SIZE 100
#define PATH_SIZE 256
#define MAX_HEX_SIZE 9
#define HEX_WITH_SENDLN 18

uint32_t Parameter_buffer[MAX_PARAMETERS_COUNT];
uint8_t Parameter_count = 0;
uint8_t Current_Parameter_count = 0;
uint32_t parameter_no;
char Full_command[FULL_COMMAND_LENGTH] = "\0";
char *send_command;
uint32_t reference_file_type = 1;
int32_t Command_Parameter_count=0;


char* TTL_File = "D:\\smac_training_2024\\Source_Code_Folders\\Working\\TTL_Parser\\Input_Files\\TTL_Input_file.ttl";
char* OUT_File = "Output.txt";
char* Json_File= "D:/smac_training_2024/Source_Code_Folders/Working/TTL_Parser/Input_Files/Command_Reference_JSON.json";
char* Yaml_File= "D:/smac_training_2024/Source_Code_Folders/Working/TTL_Parser/Input_Files/Command_Reference_YAML.yaml";
FILE *input_file;       //input file pointer
FILE *output_file;      //output file pointer



typedef struct
{
    int parameter_count;
    char* Dict;
}Python_return_values; //If you need to store and pass any data, you can include it directly within the structure.

Python_return_values parser;
enum Status
{
    FAILURE,
    SUCCESS,
    UNDEFINED
};


//Function declaration
int32_t command_identification(char*,char*,int,char**);
uint8_t is_valid_hex(char);
uint8_t Check_command(char[]);
char* c_to_python_call(char*,char*,int,int,char*,char*,uint32_t);
char* parameter_identification(char* command, uint32_t  parameter_buffer,uint32_t parameter_no,char* dictionary, uint32_t reference_file_type);

