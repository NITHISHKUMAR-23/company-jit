#include "TTL_parser.h"

uint8_t *c_to_python_call(uint8_t *function_name, uint8_t *command, uint32_t parameter_buffer[], uint8_t *path, uint32_t reference_file_type, uint32_t current_parameter_count)
{

    Py_Initialize();
    PyObject *pName = PyUnicode_FromString("TTL_parser");
    PyObject *pModule = PyImport_Import(pName);
    Py_DECREF(pName);

    if (pModule != NULL)
    {
        // Get the function from the Python script
        PyObject *pFunc = PyObject_GetAttrString(pModule, function_name);

        if (pFunc && PyCallable_Check(pFunc))
        {
            // Call the Python function and get the result (JSON string)
            PyObject *py_list = PyList_New(current_parameter_count);
            if (py_list == NULL)
            {
                PyErr_Print();
                return NULL;
            }
            // Populate the Python list with integers from parameter_buffer
            for (uint32_t i = 0; i < current_parameter_count; ++i)
            {
                PyObject *py_int = PyLong_FromLong(parameter_buffer[i]);
                if (py_int == NULL)
                {
                    PyErr_Print();
                    Py_XDECREF(py_list);
                    return NULL;
                }
                PyList_SetItem(py_list, i, py_int); // PyList_SetItem steals the reference
            }
            PyObject *pArg = PyTuple_Pack(5,
                                          PyUnicode_FromString(command),
                                          py_list,
                                          PyUnicode_FromString(path),
                                          PyLong_FromLong(reference_file_type),
                                          PyLong_FromLong(current_parameter_count));

            PyObject *pValue = PyObject_CallObject(pFunc, pArg);

            // Handle the return value
            if (pValue != NULL)
            {
                // If the result is a string, convert it to a C string
                uint8_t *result = (uint8_t *)PyUnicode_AsUTF8(pValue);
                if (result != NULL)
                {

                    return result;
                }
                else
                {
                    PyErr_Print();
                }
            }
            // Clean up
            Py_XDECREF(pValue);
        }

        else
        {
            if (PyErr_Occurred())
                PyErr_Print();
            fprintf(stderr, "Cannot find function '%s'.\n", function_name);
        }

        Py_XDECREF(pFunc);
        Py_DECREF(pModule);
    }
    else
    {
        PyErr_Print();
        fprintf(stderr, "Failed to load 'parser' module.\n");
    }

    // Finalize the Python interpreter
    Py_Finalize();
    return NULL;
}

uint32_t check_command(uint32_t ttl_value)
{
    if (((ttl_value >> CHECK_28_31_BIT) & BIT_ACCESS_4) != VALID_COMMAND_OR_PARAM)
    {
        // Invalid command, set parameter buffer to 0 and return UNDEFINED
        parameter_buffer[parameter_count++] = (uint32_t)(0);
        return INVALID;
    }

    uint32_t check_cmd_or_param = (ttl_value >> CHECK_16_23_BIT) & BIT_ACCESS_8;

    if (check_cmd_or_param == 0)
    {
        // Store the command in full_command and reset the parameter count
        uint8_t hex_string[MAX_HEX_LENGTH];
        sprintf(hex_string, "%X", ttl_value);
        strcat(full_command, hex_string);
        current_parameter_count = parameter_count;
        parameter_count = 0;
        return SUCCESS;
    }
    else if ((check_cmd_or_param > 0) || (check_cmd_or_param > 0)) // If the value is between 1 and 15, it's a parameter
    {
        // If it's a parameter, store it in the parameter buffer
        parameter_buffer[parameter_count++] = ttl_value;
        return FAILURE; // Valid parameter
    }
    else // Invalid value for command/parameter
    {
        // Reset parameter buffer and return UNDEFINED
        parameter_buffer[parameter_count++] = (uint32_t)(0);
        return INVALID;
    }
    return FAILURE;
}

void double_long_line(FILE *output_file, uint8_t size)
{
    for (uint32_t i = 0; i < size; i++)
    {
        fputc('=', output_file);
    }
    fputc('\n', output_file);
}
uint32_t file_handle_init_meta_data(FILE *input_file, FILE *output_file, uint8_t *Reference_File_Path, const uint8_t *TTL_file, time_t now, uint8_t *day, const uint8_t *author, uint8_t line_length, const uint8_t *extension)
{
    {

        if (!input_file || !output_file)
        {
            if (input_file == NULL)
            {
                perror("Error opening input file");
                fclose(output_file);
                fclose(input_file);
                return FAILURE;
            }
            else
            {
                perror("Error opening output file");
                fclose(output_file);
                return FAILURE;
            }
        }

        else
        {
            fseek(input_file, 0, SEEK_END);
            long file_size = ftell(input_file);

            if (file_size == 0)
            {
                printf("Error: The file '%s' is empty!\n", TTL_file);
                fclose(input_file);
                fclose(output_file);
                return FAILURE;
            }

            else
            {
                fseek(input_file, 0, SEEK_SET);

                if (extension != NULL)
                {
                    if (strcmp(extension, ".json") == 0)
                    {
                        // printf("json");
                        reference_file_type = JSON;
                    }
                    else if (strcmp(extension, ".yaml") == 0 || strcmp(extension, ".yml") == 0)
                    {
                        reference_file_type = YAML;
                    }
                    else
                    {
                        perror("Error: Both files must be either .json or .yaml/.yml\n");
                        return EXIT_FAILURE;
                    }
                }
                else
                {
                    perror("Error: There is no any file extension for the reference file\n");
                    return EXIT_FAILURE;
                }

                if (author == NULL)
                {
                    author = getenv("USERNAME");
                }

                double_long_line(output_file, line_length);
                fprintf(output_file, "Input TTL file : %s\n", TTL_file);
                fprintf(output_file, "Author : %s", author);
                time(&now);
                strftime(day, DATE_BUFFER_SIZE, "\t\t\t\t\t\tTime : %H:%M:%S \t\t\t\t\t Date : %d-%m-%Y", localtime(&now));
                fprintf(output_file, "%s\n", day);
                return SUCCESS;
            }
        }
    }
}

uint32_t extract_hex(uint8_t *ttl_data)
{
    uint8_t ttl_data_copy[strlen(ttl_data) + 1];
    strcpy(ttl_data_copy, ttl_data);
    uint8_t *command = strtok(ttl_data_copy, "x");

    if (strcmp(command, "sendln '0") == 0)
    {
        uint8_t *str = strtok(NULL, "'");
        if (strlen(str) == MAX_HEX_LENGTH)
        {
            for (uint32_t i = 0; i < MAX_HEX_LENGTH; i++)
            {
                if (!isxdigit(str[i]))
                {
                    parameter_buffer[parameter_count++] = (uint32_t)(0);
                    return INVALID;
                }
            }
            uint32_t return_data = strtoul(str, NULL, HEX_BASE);
            return return_data;
        }
        else
        {
            parameter_buffer[parameter_count++] = (uint32_t)(0);
            return INVALID;
        }
    }
}

uint8_t write_ttl_info(FILE *output_file, int8_t line_length, uint8_t *Command_result)
{
    if (Command_result != NULL && output_file != NULL)
    {
        double_long_line(output_file, line_length);
        fprintf(output_file, "%s\n", Command_result);
        return SUCCESS;
    }
    else{
        printf("Failed to write the ttl information\n");
        return FAILURE;
    }
    
}

int main(int argc, uint8_t *argv[])
{
    time_t current_time;
    uint8_t current_day[DATE_BUFFER_SIZE];
    uint8_t ttl_data[TTL_DATA_SIZE];
    uint8_t current_line = 0u;
    uint8_t print_line_length = 120u;
    const uint8_t *username = getenv("USER");
    uint8_t command_details[DATE_BUFFER_SIZE];
    uint8_t *TTL_File;
    uint8_t *OUT_File;
    uint8_t *Reference_File_Path;

    FILE *input_file;
    FILE *output_file;

    if (argc != ARGUMENT_SIZE)
    {
        fprintf(stderr, "Usage: %s <TTL_File> <OUT_File> <Reference_File>\n", argv[0]);
        return EXIT_FAILURE;
    }

    // Get file paths from the command line arguments
    TTL_File = argv[1];
    OUT_File = argv[2];
    Reference_File_Path = argv[3];

    input_file = fopen(TTL_File, "r");
    output_file = fopen(OUT_File, "w");
    const uint8_t *extension = strrchr(Reference_File_Path, '.'); // Find last occurrence of '.'

    file_handle_init_meta_data(input_file, output_file, Reference_File_Path, TTL_File, current_time, current_day, username, print_line_length, extension);

    while (fgets(ttl_data, sizeof(ttl_data), input_file) != NULL)
    {
        int hex_data = extract_hex(ttl_data);
        if (hex_data > INVALID)
        {

            strcpy(full_command, "0x");

            uint32_t status = check_command(hex_data);

            if (status == SUCCESS)
            {
                uint8_t *Command_result = (uint8_t *)c_to_python_call("extract_ttl_details", full_command, parameter_buffer, Reference_File_Path, reference_file_type, current_parameter_count);
                uint8_t written_status = write_ttl_info(output_file, print_line_length, Command_result);
                if (written_status == FAILURE)
                {
                    printf("no return for command %s", full_command);
                }
            }
        }
    }
    double_long_line(output_file, print_line_length);
    fclose(input_file);
    fclose(output_file);
    return SUCCESS;
}