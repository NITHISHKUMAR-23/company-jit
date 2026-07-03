#include <python3.11/Python.h>
#include <stdio.h>
#include <stdbool.h>

char* command_identification(char*,char*,int);
char* c_to_python_call(char*,char*,int,int,char*,char*,int);
char* parameter_identification(char* command, uint32_t  parameter_buffer,uint32_t parameter_no,char* dictionary, uint32_t reference_file_type);

typedef struct 
{
    int parameter_count;
    char* Dict;
}Python_return_values;
int original_parameter_count;
Python_return_values parser;