#include "TTL_Parser.h" // Include the header file for the TTL Parser

/******************************************************************************************************************************************
 *  Module Name        : Check_command, is_valid_hex
 *  Functionality      : This function validates a given command (TTL data) by checking its format. It
 *                       ensures that the command starts with '2' and is followed by specific hexadecimal
 *                       characters. Based on the validity of the command, it either stores the parameter in
 *                       a buffer for further processing or returns if it is a command or an error indicating that the command
 *                       is either invalid, undefined, or has failed.
 *  Input Parameters   : ttl_data (char[])        : The command data as a string which is being validated.
 *  Output Parameters  : uint8_t                  : Returns one of the following status codes:
 *                                               SUCCESS - The command is valid and returned.
 *                                               FAILURE - The parameter value is valid and stored in a buffer.
 *                                               UNDEFINED - The command is invalid and if the parameter is invalid it is stored as zero.
 *******************************************************************************************************************************************/

uint8_t is_valid_hex(char c)
{
    return ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'F') || (c >= 'a' && c <= 'f'));
}

uint8_t Check_command(char ttl_data[])
{
    if (strlen(ttl_data) != MAX_HEX_LENGTH)
    {
        return UNDEFINED;
    }
    if (ttl_data[0] == '2' && ttl_data[3] == '0' && ttl_data[2] == '0')
    {
        for (int i = 0; i < MAX_HEX_LENGTH; i++)
        {
            if (!is_valid_hex(ttl_data[i]))
            {
                Parameter_buffer[Parameter_count++] = (uint32_t)(0);
                return UNDEFINED;
            }
        }
        send_command = ttl_data;
        strcat(Full_command, send_command);
        Current_Parameter_count = Parameter_count;
        Parameter_count = 0;
        return SUCCESS;
    }
    else if ((ttl_data[0] == '2'))
    {
        for (int i = 0; i < MAX_HEX_LENGTH; i++)
        {
            if (!is_valid_hex(ttl_data[i]))
            {
                Parameter_buffer[Parameter_count++] = (uint32_t)(0);
                return UNDEFINED;
            }
        }
        Parameter_buffer[Parameter_count++] = (uint32_t)strtoul(ttl_data, NULL, 16);
        return FAILURE;
    }
    else
    {
        Parameter_buffer[Parameter_count++] = (uint32_t)(0);
        return UNDEFINED;
    }
    return 0;
}

/***************************************************************************************************
 *  Module Name        : c_to_python_call
 *  Functionality      : This function establishes a communication bridge between a C program and a Python script.
 *                       It initializes the Python interpreter, loads a Python module (`TTL_Parser`), and calls a
 *                       specific Python function with given arguments. The function retrieves the result from
 *                       Python (a JSON string) and returns it to the C program.
 *  Input Parameters   :
 *                       - function_name (char*)      : Name of the Python function to be invoked.
 *                       - command (char*)            : A string representing a specific command.
 *                       - parameter (int)            : An integer parameter passed to the Python function.
 *                       - parameter_no (int)         : An integer indicating the parameter number or type.
 *                       - dictionary (char*)         : A string representing a dictionary or configuration data.
 *                       - path (char*)               : Path to a file (e.g., JSON) used by the Python function.
 *                       - reference_file_type (int)  : Numeric flag indicating the type of the reference file.
 *  Output Parameters  :
 *                       - A JSON string (char*) : The result returned by the Python function.
 *                       - Updates `parser` structure with:
 *                           - `parameter_count` : Count of parameters returned by the Python function.
 *                           - `Dict`            : A dictionary or configuration string returned by Python.
 ***************************************************************************************************/
char *dict = NULL;
// C to Python call function definition
// Pass the arguments appropriately to the respective function you want to access, ensuring they align with the function's parameter requirements.

char *c_to_python_call(char *function_name, char *command, int parameter, int parameter_no, char *dictionary, char *path, uint32_t reference_file_type, char *Parameter_buffer)
{
    
    // Initialize the Python interpreter
    Py_Initialize();

    // Import the Python script
    PyObject *pName = PyUnicode_FromString("TTL_Parser"); // Python module name
    PyObject *pModule = PyImport_Import(pName);
    Py_DECREF(pName);

    if (pModule != NULL)
    {
        // Get the function from the Python script
        PyObject *pFunc = PyObject_GetAttrString(pModule, function_name);

        if (pFunc && PyCallable_Check(pFunc))
        {
            // Call the Python function and get the result (JSON string)
            PyObject *pArg = PyTuple_Pack(7,
                                          PyUnicode_FromString(command),
                                          PyLong_FromLong(parameter),
                                          PyLong_FromLong(parameter_no),
                                          PyUnicode_FromString(dictionary),
                                          PyUnicode_FromString(path),
                                          PyLong_FromLong(reference_file_type),
                                          PyUnicode_FromString(dictionary));
            // PyObject *paramBufferList = PyList_New(0);
            

        // for (uint32_t i = 0; Parameter_buffer[i] != 0; i++) {
        //     PyList_Append(paramBufferList, PyLong_FromLong(Parameter_buffer[i]));
        // }
        
        // PyTuple_SetItem(pArg, 5, paramBufferList);
        
        // for (uint32_t i = 0; Parameter_buffer[i] != 0; i++) // Assuming Parameter_buffer is null-terminated or has some sentinel value
        //             {
                        
        //             printf("%x\n",Parameter_buffer[i]);
        //             }
        //             printf("\n");





            PyObject *pValue = PyObject_CallObject(pFunc, pArg);

            if (pValue != NULL)
            {
                // Return the JSON string
                Py_XDECREF(pFunc);
                Py_DECREF(pModule);

                parser.parameter_count = PyLong_AsLong(PyTuple_GetItem(pValue, 2));
                parser.Dict = (char *)PyUnicode_AsUTF8(PyTuple_GetItem(pValue, 1));
                return (char *)PyUnicode_AsUTF8(PyTuple_GetItem(pValue, 0));
                // return pValue; // Return JSON string
            }
            else
            {
                PyErr_Print();
                fprintf(stderr, "Failed to call Python function '%s'.\n", function_name);
            }
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

char *extractHexValues(const char *line)
{
    static char hexValue[MAX_HEX_SIZE]; // 8 hex digits + null terminator
    char *tokenSendln = strstr(line, "sendln '");
    char *tokenMpause = strstr(line, "mpause ");

    if (tokenSendln != NULL)
    {
        sscanf(tokenSendln, "sendln '0x%8s", hexValue); // Adjusted to read full 8 digits after 0x
        if ((hexValue[MAX_HEX_SIZE - 1] == '\'') || (hexValue[MAX_HEX_SIZE - NULL_WITH_LAST_CHAR] == '\0') || (tokenSendln[HEX_WITH_SENDLN] != '\''))
        {
            printf("Invalid TTL format -> %s", line);
            hexValue[0] = '\0';
        }
        hexValue[MAX_HEX_SIZE - 1] = '\0'; // Ensure null termination
        return hexValue;
    }
    else if (tokenMpause != NULL)
    {
        tokenMpause = NULL;
    }
    else
    {
        printf("Invalid TTL format -> %s", line);
    }
    return NULL;
}

//*************************************************************************************************************************************************************************
//  Module Name        : command_identification
//  Functionality      : This function identifies and validates a command based on the provided file format and command string.
//                       It interacts with a Python function to validate the command, and checks for invalid strings within
//                       the returned command string.
//                       If the command is invalid, it returns 0, otherwise, it returns 1.
//
//  Input Parameters   :
//    - char* command: The command string that needs to be validated.
//    - char* path: The file path that is passed for validation.
//    - int file_format: The file format associated with the command.
//    - char** command_string: A pointer to store the validated command string returned from Python function.
//
//  Output  :
//    - Returns an integer (1 if the command is valid, 0 if invalid).
//***************************************************************************************************************************************************************************

int command_identification(char *command, char *path, int parameter_no, int *file_format, char **Command_Name, int *testing) // Function to identify and validate a command based on the file format and command string
{
    // printf("%d",parameter_no);
char result[256];
void array_to_string(int *arr, int parameter_no, char *result) {
    char buffer[50]; // Temporary buffer for each number
    result[0] = '\0'; // Initialize result as an empty string
  
    for (int i = 0; i < parameter_no; i++) {
        sprintf(buffer, "%d", testing[i]); // Convert integer to string
        strcat(result, buffer);       // Append to the result string
        if (i < parameter_no - 1) {
            strcat(result, ","); // Add a comma between numbers
        }
        // printf("%d ",testing[i]);
    }
}

array_to_string(testing, parameter_no, result);

// printf("%s",result);

    // Call the Python function 'command_validation' from the Python script and pass parameters
    *Command_Name = c_to_python_call("command_validation", command, false, false, "false", path, file_format,result);
     printf("guydgugeg");
    if (strstr(*Command_Name, "invalid"))
    {
        return FAILURE;
    }
    Command_Parameter_count = parser.parameter_count;
    return SUCCESS;
}

// Function to identify a parameter by invoking a Python method
char *parameter_identification(char *command, uint32_t parameter, uint32_t parameter_no, char *dictionary, uint32_t reference_file_type)
{
    // Call the Python function `extract_bitfields_parameter` with the provided arguments
    char *output = c_to_python_call(
        "extract_bitfields_parameter",
        command,
        parameter,
        false,
        parser.Dict,
        "false",
        reference_file_type,
        false);
    // Print the output returned by the Python function
    // printf("%s", output);
    return output;
}

/* Function to print a doube horizontal line for visual separation in the output file
   This function prints a line of equals to the provided output file, creating a visual separator.
*/
void double_long_line()
{
    for (int i = 0; i < PRINT_LINE_LENGTH; i++)
    {                            // 88 is the number of dashes you need
        fputc('=', output_file); // Print a dash
    }
    fputc('\n', output_file); // Print a newline at the end
}

/*  Function to initialize and write metadata to the output file
    This function writes metadata including the TTL file name, current time and date, and author's username to the output file.

    Parameters:
    - char* TTL_file: The name of the TTL file being referenced.
    - time_t now: The current time.
    - char* day: A buffer to store the formatted date and time string.
    - char* author: The author's username.

    Returns:
    - None
*/
void InitializeMetaData(char *TTL_file, time_t now, char *day, char *author)
{
    double_long_line();
    fprintf(output_file, "Given TTL file : TTL_Input_file");
    time(&now);
    strftime(day, DATE_BUFFER_SIZE, "\t\t\t\t\tTime : %H:%M:%S \t\t\t\t Date : %d-%m-%Y", localtime(&now));
    fprintf(output_file, "%s\n", day);
    fprintf(output_file, "Author : %s\n", author);
}

/*  Function to write the bitfield name and value to the output file
    This function writes the provided bitfield name and value to the output file if they are not NULL.

    Parameters:
    - const char* bitfieldNameAndValue: The bitfield name and value to write.

    Returns:
    - None
*/
void writeparamAndBitfieldDetails(const char *paramAndBitfieldDetails)
{
    if (paramAndBitfieldDetails != NULL)
    {
        fprintf(output_file, "%s\n", paramAndBitfieldDetails);
    }
}

/*  Function to write the command value to the output file
    This function writes the provided command value to the output file if it is not NULL.

    Parameters:
    - const char* commandValue: The command value to write.

    Returns:
    - None
*/
void writeCommand(const char *commandValue, char *Full_command)
{
    if (commandValue != NULL)
    {
        fprintf(output_file, "%35s : %s (%s)\n", "Command", commandValue, Full_command);
    }
}

/*  Main function of the program
    This function initializes the program, reads the input TTL file, extracts hexadecimal values, processes them, and writes metadata and results to the output file.

    Parameters:
    - None

    Returns:
    - int: Exit status of the program (0 for success, EXIT_FAILURE for failure).
*/
int main(void)
{

    time_t now;
    char day[DATE_BUFFER_SIZE];
    char *username = getenv("USER"); // To print Author Name

    if (username == NULL)
    {
        username = getenv("USERNAME");
    }

    input_file = fopen(TTL_File, "r");
    output_file = fopen(OUT_File, "w");

    // Error Handling on input TTL file and output.txt file
    if (!input_file || !output_file)
    {
        perror("Error opening input/output file");
        return EXIT_FAILURE;
    }

    fseek(input_file, 0, SEEK_END);
    long file_size = ftell(input_file); // Get the size of the file

    if (file_size == 0)
    {
        // If the file is empty
        printf("Error: The file '%s' is empty!\n", TTL_File);
    }
    fseek(input_file, 0, SEEK_SET);

    InitializeMetaData(TTL_File, now, day, username); // To Initialize MetaData

    char Reference_File_Path[PATH_SIZE]; // Buffer to hold the path to the file (JSON or YAML)

    // Set the file path based on the reference_file_type (JSON or YAML)
    if (reference_file_type == true)
        strncpy(Reference_File_Path, Json_File, PATH_SIZE);
    else
        strncpy(Reference_File_Path, Yaml_File, PATH_SIZE);

    char line[LINE_SIZE];
    while (fgets(line, sizeof(line), input_file))
    {
        if (line != NULL && line[0] != '\n')
        {
            char *hexValue = extractHexValues(line);
            if (hexValue != NULL && hexValue[0] != '\0')
            {
                strcpy(Full_command, "0x");
                uint8_t Status = Check_command(hexValue); // Value IS GIVEN BY BOOPALAN_TEAM IN LOOP BY GETTING INPUT FROM TTL
                if (Status == SUCCESS)
                {
                    Command_Name = NULL;
                    // Call the command_identification function to process the command and retrieve the result
                    parameter_no = sizeof(testing) / sizeof(testing[0]);
                    
                    //  command_identification(char *command, char *path, int parameter_no, int file_format, char **Command_Name, int *testing) 
                    if (command_identification(Full_command, Reference_File_Path, parameter_no, reference_file_type, &Command_Name, testing) == 0)
                    {
                        printf("%s is %s\n", Full_command, Command_Name);
                        continue; // this should be uncommand while integrating
                    }
                    double_long_line();
                    writeCommand(Command_Name, Full_command);
                    for (uint32_t i = 0; i < Current_Parameter_count; i++)
                    {
                        // Check if the current parameter in the buffer is not zero
                        if (Parameter_buffer[i] != 0)
                        {
                            parameter_string;
                            // Call the `parameter_identification` function to process the parameter
                            // `parameter_identification` returns a string based on the processing of the parameter
                            parameter_string = parameter_identification(
                                Full_command,
                                Parameter_buffer[i],
                                parameter_no,
                                parser.Dict,
                                reference_file_type);

                            writeparamAndBitfieldDetails(parameter_string);
                            fputc('\n', output_file);                                     
                        }
                    }
                }
                else if (Status == UNDEFINED)
                {
                    printf("%s : is an Invalid Command or Parameter", hexValue);
                }
            }
        }
    }
    double_long_line();
    fclose(input_file);
    fclose(output_file);
    return 0;
}