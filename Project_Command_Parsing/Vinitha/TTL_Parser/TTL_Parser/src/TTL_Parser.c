#include "TTL_Parser.h" // Include the header file for the TTL Parser

/******************************************************************************************************************************************
 *  Module Name        : MetadataWriter
 *  Functionality      : This function initializes and writes metadata to an output file. The metadata includes the TTL file name, 
 *                       current time and date, and the author's username. It formats the date and time, constructs metadata, 
 *                       and writes it to the specified output file.
 *  Input Parameters   : 
 *                       - TTL_file (char*)       : The name of the TTL file being referenced.
 *                       - now (time_t)           : The current time.
 *                       - day (char*)            : A buffer to store the formatted date and time string.
 *                       - author (char*)         : The author's username.
 *  Output Parameters  : None
 ******************************************************************************************************************************************/

void InitializeMetaData(char *TTL_file, time_t now, char *day, char *author)
{
    double_long_line();
    fprintf(output_file, "Given TTL file : TTL_Input_file");
    time(&now);
    strftime(day, DATE_BUFFER_SIZE, "\t\t\t\t\tTime : %H:%M:%S \t\t\t\t Date : %d-%m-%Y", localtime(&now));
    fprintf(output_file, "%s\n", day);
    fprintf(output_file, "Author : %s\n", author);
}

/******************************************************************************************************************************************
 *  Module Name        : TTLHexExtractor
 *  Functionality      : This function extracts an 8-digit hexadecimal value from a given input string 
 *                       containing the pattern `sendln '0x...`. It validates the format of the extracted 
 *                       hexadecimal value and ensures null termination. If the input does not match the 
 *                       expected format, it prints an error message and returns NULL.
 *  Input Parameters   : line (const char*)        : The input string to be parsed for hexadecimal value.
 *  Output Parameters  : char*                    : Returns the extracted hexadecimal value as a string if valid.
 *                                               NULL if the format is invalid or the pattern is not found.
 ******************************************************************************************************************************************/

char *extractHexValues(const char *line)
{
    static char hexValue[MAX_HEX_SIZE]; // 8 hex digits + null terminator
    char *tokenSendln = strstr(line, "sendln '");

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
    return NULL;
}

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
 ******************************************************************************************************************************************/

uint8_t is_valid_hex(char c)
{
    return ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'F') || (c >= 'a' && c <= 'f'));
}

uint8_t Check_command(char ttl_data[])
{
    if (strlen(ttl_data) != MAX_HEX_LENGTH)
    {
        Parameter_buffer[Parameter_count++] = (uint32_t)(0);
        printf("Invalid: TTL data length is not equal to MAX_HEX_LENGTH\n");
        return UNDEFINED;
    }

    // Validate the hex string
    for (int i = 0; i < MAX_HEX_LENGTH; i++)
    {
        if (!is_valid_hex(ttl_data[i]))
        {
            Parameter_buffer[Parameter_count++] = (uint32_t)(0);
            printf("Invalid: TTL data contains non-hexadecimal characters\n");
            return UNDEFINED;
        }
    }

    // Case: Starts with '2' and has a specific format
    if (ttl_data[0] == '2' && ttl_data[2] == '0' && ttl_data[3] == '0')
    {
        send_command = ttl_data;
        strcat(Full_command, send_command);
        Current_Parameter_count = Parameter_count;
        Parameter_count = 0;
        printf("Valid: Command processed successfully\n");  // Message added before success
        return SUCCESS;
    }
    // Case: Starts with '2' but not in specific format
    else if (ttl_data[0] == '2')
    {
        Parameter_buffer[Parameter_count++] = (uint32_t)strtoul(ttl_data, NULL, 16);
        return FAILURE;
    }

    // Case: Invalid command
    Parameter_buffer[Parameter_count++] = (uint32_t)(0);
    printf("Invalid: TTL data does not start with '2'\n");
    return UNDEFINED;
}

/******************************************************************************************************************************************
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
 *******************************************************************************************************************************************/

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

/******************************************************************************************************************************************
 *  Module Name        : command_identification
 *  Functionality      : This function identifies and validates a command based on the provided file format and command string.
 *                       It interacts with a Python function to validate the command, and checks for invalid strings within
 *                       the returned command string.
 *                       If the command is invalid, it returns 0, otherwise, it returns 1.
 *
 *  Input Parameters   :
 *    - char* command: The command string that needs to be validated.
 *    - char* path: The file path that is passed for validation.
 *    - int file_format: The file format associated with the command.
 *    - char** command_string: A pointer to store the validated command string returned from the Python function.
 *
 *  Output  :
 *    - Returns an integer (1 if the command is valid, 0 if invalid).
 ******************************************************************************************************************************************/


int command_identification(char *command, char *path, int file_format, char **Command_Name) // Function to identify and validate a command based on the file format and command string
{
    // Call the Python function 'command_validation' from the Python script and pass parameters
    *Command_Name = c_to_python_call("command_validation", command, false, false, "false", path, file_format);
    if (strstr(*Command_Name, "invalid"))
    {
        return FAILURE;
    }
    Command_Parameter_count = parser.parameter_count;
    return SUCCESS;
}

/******************************************************************************************************************************************
 *  Module Name        : IdentifyParameter
 *  Functionality      : This function identifies a parameter by invoking a Python method. It interfaces with the Python 
 *                       environment to process or validate the parameter and returns the identified result.
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************************************************************************/

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
        reference_file_type);
    return output;
}

/******************************************************************************************************************************************
 *  Module Name        : PrintSeparator
 *  Functionality      : This function prints a double horizontal line (a line of equals signs) to the provided output file,
 *                       creating a visual separator for clarity and organization of the file content.
 *  Input Parameters   : None
 *  Output Parameters  : None
 ******************************************************************************************************************************************/

void double_long_line()
{
    for (int i = 0; i < PRINT_LINE_LENGTH; i++)
    {                            // 88 is the number of dashes you need
        fputc('=', output_file); // Print a dash
    }
    fputc('\n', output_file); // Print a newline at the end
}

/******************************************************************************************************************************************
 *  Module Name        : BitfieldWriter
 *  Functionality      : This function writes the provided bitfield name and value to the output file 
 *                       if they are not NULL. It ensures that the bitfield name and value are valid 
 *                       before attempting to write them to the file.
 *  Input Parameters   : 
 *                       - BitfieldNameandValue (const char*) : The bitfield name and value to write to the output file.
 *  Output Parameters  : None
 ******************************************************************************************************************************************/

void WriteParamandBitfieldDetails(const char *paramAndBitfieldDetails)
{
    if (paramAndBitfieldDetails != NULL)
    {
        fprintf(output_file, "%s\n", paramAndBitfieldDetails);
    }
}

/******************************************************************************************************************************************
 *  Module Name        : CommandWriter
 *  Functionality      : This function writes the provided command value to the output file 
 *                       if it is not NULL. It ensures that the command value is valid before 
 *                       writing it to the file.
 *  Input Parameters   : 
 *                       - commandValue (const char*) : The command value to write to the output file.
 *  Output Parameters  : None
 ******************************************************************************************************************************************/

void WriteCommand(const char *commandValue, char *Full_command)
{
    if (commandValue != NULL)
    {
        fprintf(output_file, "%35s : %s (%s)\n", "Command", commandValue, Full_command);
    }
}

/******************************************************************************************************************************************
 *  Module Name        : main
 *  Functionality      : This function initializes the program, reads the input TTL file, extracts hexadecimal values, 
 *                       processes them, and writes metadata and results to the output file. It handles file operations, 
 *                       error checking, and coordinating the overall program flow.
 *  Input Parameters   : None
 *  Output Parameters  : 
 *                       - int : Exit status of the program (0 for success, EXIT_FAILURE for failure).
 ******************************************************************************************************************************************/


int main(int argc, char *argv[])
{
    time_t now;
    char day[DATE_BUFFER_SIZE];
    char *username = getenv("USER"); // To print Author Name
    if (username == NULL) {
        username = getenv("USERNAME");
    }

    // Validate the number of command-line arguments
    if (argc != 5) {
        printf("Usage: %s <TTL_File> <Reference_File> <Output_File> <Reference_File_Type>\n", argv[0]);
        printf("Example: %s input.ttl reference.json output.txt 1\n", argv[0]);
        return EXIT_FAILURE; // Exit program with failure code
    }

    // Extract arguments into meaningful variables
    char *TTL_File = argv[1];                // Input TTL file
    char *Reference_File_Path = argv[2];     // Path to the reference file (JSON or YAML)
    char *OUT_File = argv[3];                // Path to the output file
    int reference_file_type = atoi(argv[4]); // Reference file type (1 = JSON, 0 = YAML)

    // Optional: Validate reference_file_type input
    if (reference_file_type != 0 && reference_file_type != 1) {
        printf("Error: <Reference_File_Type> must be 0 (YAML) or 1 (JSON).\n");
        return EXIT_FAILURE;
    }

    // Open input and output files
    input_file = fopen(TTL_File, "r");
    output_file = fopen(OUT_File, "w");

    // Error Handling on input TTL file and output file
    if (!input_file || !output_file) {
        perror("Error opening input/output file");
        return EXIT_FAILURE;
    }

    fseek(input_file, 0, SEEK_END);
    long file_size = ftell(input_file); // Get the size of the file

    if (file_size == 0) {
        // If the file is empty
        printf("Error: The file '%s' is empty!\n", TTL_File);
        fclose(input_file);
        fclose(output_file);
        return EXIT_FAILURE;
    }
    fseek(input_file, 0, SEEK_SET);

    // Initialize MetaData
    InitializeMetaData(TTL_File, now, day, username);

    char line[LINE_SIZE];
    while (fgets(line, sizeof(line), input_file)) {
        if (line != NULL && line[0] != '\n') {
            char *hexValue = extractHexValues(line);
            if (hexValue != NULL && hexValue[0] != '\0') {
                strcpy(Full_command, "0x");
                uint8_t Status = Check_command(hexValue); // Check command validity
                if (Status == SUCCESS) {
                    Command_Name = NULL;

                    // Call the command_identification function to process the command and retrieve the result
                    if (command_identification(Full_command, Reference_File_Path, reference_file_type, &Command_Name) == 0) {
                        printf("%s is %s\n", Full_command, Command_Name);
                        continue; // Skip further processing for invalid commands
                    }

                    double_long_line(); // Print separator
                    WriteCommand(Command_Name, Full_command); // Write command details to output file

                    for (uint32_t i = 0; i < Current_Parameter_count; i++) {
                        // Check if the current parameter in the buffer is not zero
                        if (Parameter_buffer[i] != 0) {
                            // Process the parameter using `parameter_identification`
                            parameter_string = parameter_identification(Full_command, Parameter_buffer[i], 0, NULL, reference_file_type);

                            // Write parameter and bitfield details to output
                            WriteParamandBitfieldDetails(parameter_string);
                            fputc('\n', output_file); // Newline after writing parameter
                        }
                    }

                    // Print successful output message
                    printf("Output successfully written for command: %s\n", Full_command);
                } else if (Status == UNDEFINED) {
                    printf("%s : is an Invalid Command or Parameter\n", hexValue);
                }
            }
        }
    }

    double_long_line(); // Print separator at the end
    fclose(input_file); // Close the input file
    fclose(output_file); // Close the output file
}
