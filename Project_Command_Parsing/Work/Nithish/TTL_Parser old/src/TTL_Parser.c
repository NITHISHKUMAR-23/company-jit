#include "TTL_Parser.h"     // Include the header file for the TTL Parser

int main()
{
    char Full_command[15];  // Buffer to hold the command string
    char path[256];     // Buffer to hold the path to the file (JSON or YAML)

    // Set the file path based on the reference_file_type (JSON or YAML)
    if(reference_file_type == true)
    strcpy(path,Json_File);
    else
    strcpy(path,Yaml_File);

    strcpy(Full_command,"0x20000333");

    char* command_string = NULL;
    // Call the command_identification function to process the command and retrieve the result
    if(command_identification(Full_command,path,reference_file_type,&command_string) == 0)
    {
        printf("%s is %s\n",Full_command,command_string);
        // continue;  this should be uncommand while integrating
    }
    // printf("Dictonary:\n%s\n",parser.Dict);
    // printf("parameter count : %d\n",parser.parameter_count);
    printf("%s\n",command_string);  // Print the result command string
}

// Function to identify and validate a command based on the file format and command string
int command_identification(char* command,char*path,int file_format,char** command_string)
{
    // Call the Python function 'command_validation' from the Python script and pass parameters
    *command_string = c_to_python_call("command_validation",command,false,false,"false",path,file_format);
    if(strstr(*command_string,"invalid"))
    {
        return 0;
    }
    return 1;
}

// Function to call a Python function from C using the Python C API
char* c_to_python_call(char* function_name,char* command,int parameter,int parameter_no,char* dictionary,char* path, int reference_file_type) 
{
    // Initialize the Python interpreter
    Py_Initialize();

    // Import the Python script
    PyObject *pName = PyUnicode_FromString("TTL_Parser");  // Python module name
    PyObject *pModule = PyImport_Import(pName);
    Py_DECREF(pName);

    if (pModule != NULL) {
        // Get the function from the Python script
        PyObject *pFunc = PyObject_GetAttrString(pModule, function_name);

        if (pFunc && PyCallable_Check(pFunc)) {
            // Call the Python function and get the result (JSON string)   
            PyObject *pArg = PyTuple_Pack(6, 
                PyUnicode_FromString(command),
                PyLong_FromLong(parameter),
                PyLong_FromLong(parameter_no),
                PyUnicode_FromString(dictionary),
                PyUnicode_FromString(path),
                PyLong_FromLong(reference_file_type)
            );

            PyObject *pValue = PyObject_CallObject(pFunc, pArg);

            if (pValue != NULL) {
                // Return the JSON string
                Py_XDECREF(pFunc);
                Py_DECREF(pModule);

                parser.parameter_count = PyLong_AsLong(PyTuple_GetItem(pValue, 2));
                parser.Dict = (char*)PyUnicode_AsUTF8(PyTuple_GetItem(pValue, 1));
                return (char*)PyUnicode_AsUTF8(PyTuple_GetItem(pValue, 0));
                // return pValue; // Return JSON string
            } else {
                PyErr_Print();
                fprintf(stderr, "Failed to call Python function '%s'.\n",function_name);
            }
        } else {
            if (PyErr_Occurred())
                PyErr_Print();
            fprintf(stderr, "Cannot find function '%s'.\n",function_name);
        }

        Py_XDECREF(pFunc);
        Py_DECREF(pModule);
    } else {
        PyErr_Print();
        fprintf(stderr, "Failed to load 'parser' module.\n");
    }

    // Finalize the Python interpreter
    Py_Finalize();
    return NULL;
}