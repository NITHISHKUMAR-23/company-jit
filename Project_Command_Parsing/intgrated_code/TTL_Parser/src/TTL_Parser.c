#include "TTL_Parser.h"

int main()
{
    char Full_command[15];
    char path[256];
    uint32_t reference_file_type = 1; // 1-json
    uint32_t Current_Parameter_count = 3;
    // prasanth
    uint32_t Parameter_buffer[3] = {20014321, 12345678, 20034321};
    // int parameter_buffer[3] = {20014321, 12345678, 20034321};
    // int parameter_no = 5;   // from buffer

    if (reference_file_type == 1)
        strcpy(path, "D:\\Project_Command_Parsing\\intgrated_code\\TTL_Parser\\Input_Files\\Command_Reference_JSON.json");
    else
        strcpy(path, "D:\\Project_Command_Parsing\\intgrated_code\\TTL_Parser\\Input_Files\\Command_Reference_YAML.yaml");
    // strcpy(path,"D:\\smac_training_2024\\Source_Code_Folders\\Working\\TTL_Parser\\Input_Files\\Command_Reference_YAML.yaml");

    strcpy(Full_command, "0x20000030");

    char *command_string = command_identification(Full_command, path, reference_file_type);
    printf("%s\n", command_string);
    // printf("%d\n",parser.parameter_count);

    // printf("%s",parser.Dict);

    // prasanth
    for (uint32_t i = 0; i <= Current_Parameter_count; i++)
    {
        if (Parameter_buffer[i] != 0)
        {

            uint32_t parameter_no = i + 1;
            char *parameter_string = parameter_identification(Full_command, Parameter_buffer[i], parameter_no, parser.Dict, reference_file_type);
        }
    }
}

char *command_identification(char *command, char *path, int file_format)
{
    char *str = c_to_python_call("command_validation", command, false, false, "false", path, file_format);
    // printf("%s\n",str);
    return str;
}
// prasanth
char *parameter_identification(char *command, uint32_t parameter,uint32_t parameter_no, char *dictionary, uint32_t reference_file_type)
{
    char *output = c_to_python_call("extract_bitfields_parameter", command, parameter, parameter_no, parser.Dict, "false", reference_file_type);
    // printf("%s",output);
    printf("%s", output);
}

char *c_to_python_call(char *function_name, char *command, int parameter, int parameter_no, char *dictionary, char *path, int reference_file_type)
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
            PyObject *pArg = PyTuple_Pack(6, PyUnicode_FromString(command), PyLong_FromLong(parameter), PyLong_FromLong(parameter_no), PyUnicode_FromString(dictionary), PyUnicode_FromString(path), PyLong_FromLong(reference_file_type));

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