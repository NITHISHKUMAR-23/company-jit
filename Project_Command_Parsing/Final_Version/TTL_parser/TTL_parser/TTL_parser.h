#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include <ctype.h>
#include <stdarg.h>
#include <python3.11/Python.h>
#include <time.h>

#define PATH_SIZE 256
#define Max_BUFFER_LENGTH 40
#define MAX_HEX_LENGTH 8
#define FULL_COMMAND_LENGTH 11
#define VALID_PARAMETER 0XF0000000
#define VALID_COMMAND 0XFFFF0000
#define VALID_FORMAT 0x20000000
#define TTL_DATA_SIZE 256
#define DATE_BUFFER_SIZE 100
#define ARGUMENT_SIZE 4
#define HEX_BASE 16
uint8_t reference_file_type;
uint32_t parameter_buffer[Max_BUFFER_LENGTH];
uint8_t parameter_count = 0;
uint32_t current_parameter_count = 0;
char full_command[FULL_COMMAND_LENGTH];

// char *TTL_File = "D:\\my_final\\TTL_Input_file.ttl";
// char *Reference_File_Path = "D:\\my_final\\Command_Reference_JSON.json";
// char *Yaml_File = "D:\\my_final\\Command_Reference_YAML.yaml";
enum status
{
    SUCCESS,
    FAILURE,
    INVALID
};

enum file_type
{
    YAML,
    JSON
};

#define CHECK_28_31_BIT 28
#define CHECK_16_23_BIT 16
#define BIT_ACCESS_8 255
#define BIT_ACCESS_4 127
#define VALID_COMMAND_OR_PARAM 2