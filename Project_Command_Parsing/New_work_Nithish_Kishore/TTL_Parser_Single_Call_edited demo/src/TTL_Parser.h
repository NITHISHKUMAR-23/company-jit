//Include all global declarations here
#include <python3.11/Python.h>  // Include the Python API for C (Python 3.12)
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
#define PRINT_LINE_LENGTH 100
#define NULL_WITH_LAST_CHAR 2

uint32_t Parameter_buffer[MAX_PARAMETERS_COUNT];
uint8_t Parameter_count = 0;
uint8_t Current_Parameter_count = 0;
uint32_t parameter_no;
char Full_command[FULL_COMMAND_LENGTH] = "\0";
char *send_command;
uint32_t reference_file_type = 1;
int32_t Command_Parameter_count=0;
char *Command_Name;
char *parameter_string;


char* TTL_File = "D:\\Project_Command_Parsing\\New_work_Nithish_Kishore\\TTL_Parser_Single_Call\\Input_Files\\TTL_Input_file.ttl";
char* OUT_File = "Output.txt";
char* Json_File= "D:\\Project_Command_Parsing\\New_work_Nithish_Kishore\\TTL_Parser_Single_Call\\Input_Files\\Command_Reference_JSON.json";
char* Yaml_File= "D:\\Project_Command_Parsing\\New_work_Nithish_Kishore\\TTL_Parser_Single_Call\\Input_Files\\Command_Reference_YAML.yaml";
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
int32_t command_identification(char*,char*,int,char**,uint32_t *);
uint8_t is_valid_hex(char);
uint8_t Check_command(char[]);
char* c_to_python_call(char*,char*,int,char*,char*,uint32_t,uint32_t *);
char* parameter_identification(char* command, uint32_t  parameter_buffer,char* dictionary, uint32_t reference_file_type);
void writeCommand(const char *, char *);
void writeparamAndBitfieldDetails(const char *);
void InitializeMetaData(char *, time_t, char *, char *);
void double_long_line();
