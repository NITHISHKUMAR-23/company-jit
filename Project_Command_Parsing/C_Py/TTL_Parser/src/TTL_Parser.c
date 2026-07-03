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

/******************************************************************************************************************************************
 * Function Name       : Check_command
 * Functionality       : This function checks the validity of the given TTL command. 
 *                       If valid, it processes the command and stores it or its parameter in the buffer.
 * Input Parameters    : ttl_data (char[])        : The command string to be validated.
 * Output Parameters   : uint8_t                  : Status code indicating the result of the validation.
 *******************************************************************************************************************************************/
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
 *  Functionality      : Establishes a communication bridge between a C program and a Python script.
 *                       Initializes the Python interpreter, loads a Python module, and invokes a Python
 *                       function with the provided arguments.
 *  Input Parameters   :
 *                       - function_name (char*)      : Name of the Python function to be invoked.
 *                       - command (char*)            : A string representing a specific command.
 *                       - dictionary (char*)         : A string representing a dictionary or configuration data.
 *                       - path (char*)               : Path to a file (e.g., JSON) used by the Python function.
 *                       - reference_file_type (int)  : Numeric flag indicating the type of the reference file.
 *                       - input_buffer (char*)       : Input data to be passed to Python function.
 *                       - Current_Parameter_count    : The current count of parameters.
 *  Output Parameters  : Returns a JSON string (char*) from the Python function.
 ***************************************************************************************************/
char *dict = NULL;
// C to Python call function definition
// Pass the arguments appropriately to the respective function you want to access, ensuring they align with the function's parameter requirements.

char *c_to_python_call(char *function_name, char *command, char *dictionary, char *path, uint32_t reference_file_type, char *input_buffer, int Current_Parameter_count)
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
            PyObject *pArg = PyTuple_Pack(6,
                                          PyUnicode_FromString(command),
                                          PyUnicode_FromString(dictionary),
                                          PyUnicode_FromString(path),
                                          PyLong_FromLong(reference_file_type),
                                          PyUnicode_FromString(input_buffer),
                                          PyLong_FromLong(Current_Parameter_count));

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
 
    static char hexValue[MAX_HEX_LENGTH + 1]; // 8 hex digits + null terminator
    char *tokenSendln = strstr(line, "sendln '");
    char *tokenMpause = strstr(line, "mpause ");
 
    if (tokenSendln != NULL)
    {
        sscanf(tokenSendln, "sendln '0x%8s", hexValue); // Adjusted to read full 8 digits after 0x
        if ((hexValue[MAX_HEX_LENGTH] == '\'') || (hexValue[MAX_HEX_LENGTH - 1] == '\0') || (tokenSendln[HEX_WITH_SENDLN] != '\''))
        {
            printf("Invalid TTL format -> %s\n", line);
            hexValue[0] = '\0';
        }
        hexValue[MAX_HEX_LENGTH] = '\0'; // Ensure null termination
        return hexValue;
    }
    else if (tokenMpause != NULL)
    {
        tokenMpause = NULL;
    }
    else
    {
        if (strncmp(line, "//", CMNT_SLASH_SIZE))
        {
            return NULL;
        }
        else
        {
            printf("Invalid TTL format -> %s\n", line);
        }
    }
    return NULL;
}

/***************************************************************************************************
 *  Module Name        : command_identification
 *  Functionality      : Identifies and validates a command based on the provided file format and string.
 *                       Interacts with Python for validation and returns result.
 *  Input Parameters   :
 *                       - command (char*)            : Command string to validate.
 *                       - path (char*)               : File path for reference.
 *                       - file_format (int)          : Format flag (JSON or YAML).
 *                       - Full_Command_Details (char**): Pointer to store command details.
 *  Output Parameters  : Returns integer status (1 for valid, 0 for invalid).
//**************************************************************************************************/

int command_identification(char *command, char *path, int file_format, char **Full_Command_Details) // Function to identify and validate a command based on the file format and command string
{
    char result[1000] = ""; // Ensure this is large enough to hold the final string
    char buffer[10];

    for (int i = 0; i < Current_Parameter_count; i++) {
        sprintf(buffer, "%d", Parameter_buffer[i]); // Convert integer to string
        strcat(result, buffer); // Append to the result string
        if (i < Current_Parameter_count - 1) {
            strcat(result, ","); // Append a comma if not the last element
        }
    }
    // Call the Python function 'command_validation' from the Python script and pass parameters
    *Full_Command_Details = c_to_python_call("command_validation", command, "false", path, file_format, result, Current_Parameter_count);
    if (strstr(*Full_Command_Details, "invalid"))
    {
        return FAILURE;
    }
    Command_Parameter_count = parser.parameter_count;
    return SUCCESS;
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

void writeCommand(const char *commandValue)
{
    if (commandValue != NULL)
    {
        fprintf(output_file, "%35s : %s\n", "Command", commandValue);
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
        line[strcspn(line, "\n")] = '\0';
        if ((strcmp(line, "//") != 0) && (line[0] != '\0') && strspn(line, " \t\r\n") != strlen(line))
        {
            char *hexValue = extractHexValues(line);
            if (hexValue != NULL)
            {
                strcpy(Full_command, "0x");
                uint8_t Status = Check_command(hexValue); 
                if (Status == SUCCESS)
                {
                    Full_Command_Details = NULL;
                    // Call the command_identification function to process the command and retrieve the result
                    if (command_identification(Full_command, Reference_File_Path, reference_file_type, &Full_Command_Details) == 0)
                    {
                        printf("%s is %s\n", Full_command, Full_Command_Details);
                        continue; // this should be uncommand while integrating
                    }

                    double_long_line();
                    if(Current_Parameter_count==0 && Command_Parameter_count!=0)
                    {
                        printf("There is no parameter for %s command in TTL_Input_file\n",Full_Command_Details);
                        writeCommand(Full_Command_Details);
                    }
                    else
                    {
                        writeCommand(Full_Command_Details);
                    }
                }
                else if (Status == UNDEFINED)
                {
                    printf("%s : is an Invalid Command or Parameter\n", hexValue);
                }
            }
        }
    }
    double_long_line();
    fclose(input_file);
    fclose(output_file);
    return 0;
}