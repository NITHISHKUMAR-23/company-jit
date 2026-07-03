
import yaml
import json


PRINT_LINE_LENGTH = 100  
# *****************************************************************************************************************************
#  Module Name        : extract_bitfields_parameter                                                                          *
#  Functionality      : Extracts and processes bitfield information from a given command parameter.                          *
#                       Generates a formatted result string based on the data and returns the result.                       *
#                       The function supports data in YAML or JSON format and extracts bitfields from a specified           *
#                       parameter number.                                                                                   *
#                                                                                                                           *
#  Input Parameters   :                                                                                                     *
#    command_value    : int  - The command value that contains the bitfields to be extracted.                               *
#    parameter_values : int  - The value associated with the parameter containing bitfields.                                *
#    data             : str  - The string representing the data in either YAML or JSON format.                              *
#    path             : str  - The file path (currently not used in the function but can be extended).                      *
#    file_format      : int  - The file format: 0 for YAML, 1 for JSON. Other values result in an error.                    *
#                                                                                                                           *
#  Output Parameters  :                                                                                                     *
#    result           : str  - A formatted string containing the processed bitfields and their associated values.           *
#*****************************************************************************************************************************

def extract_bitfields_parameter(command_value, parameter_values, data, path, file_format):
    # Initialize an empty string to store the result
    result = " "
    parameter_number = (parameter_values >> 16) & 15  # Extract the bits
        
    try:
        # Construct the key for the parameter and prepare the result string
        accessed_parameter = f"parameter{str(parameter_number)}"
        parameter = f"{'Parameter number'} : {str(parameter_number)}"
        result += "\n" + parameter + "\n" + "\n"
        
        # Check if the accessed parameter exists in the "parameters" section of the data
        if accessed_parameter not in data["parameters"]:
            print(f"Error: {accessed_parameter} not found in parameters.")
            return
        
        # Access the parameter's data
        accessed_param = data["parameters"][accessed_parameter]
        
        # Check if the accessed parameter contains "bitfields"
        if isinstance(accessed_param, dict) and "bitfields" in accessed_param:
            # Iterate over the bitfields in the accessed parameter
            for bitfield, bitfield_data in accessed_param["bitfields"].items():
                
                # If the bitfield is a range (e.g., '15-14')
                if '-' in bitfield:
                    # Split the bitfield range and create a mask to extract the specified bits
                    start, end = map(int, bitfield.split('-'))
                    mask = (1 << (start - end + 1)) - 1  # Create the mask for the bit range
                    
                    extracted_bits_int = (parameter_values >> end) & mask  # Extract the bits
                    # Convert the extracted bits to binary
                    extracted_bits_bin = bin(extracted_bits_int)[2:].zfill(start - end + 1)
                    # Call the function to process the bitfield name and value
                    temp = bitfieldNameAndValue(data, accessed_parameter, bitfield, extracted_bits_bin)
                    if temp:
                        result += temp + "\n"
                else:  # If the bitfield is a single bit (e.g., '0')
                    extracted_bits_bin = (parameter_values >> int(bitfield)) & 1  # Extract the single bit
                    # Call the function to process the bitfield name and value
                    temp = bitfieldNameAndValue(data, accessed_parameter, bitfield, extracted_bits_bin)
                    if temp:
                        result += temp + "\n"
        else:
            # If the parameter doesn't contain 'bitfields', print an error
            print(f"Error: {accessed_parameter} is not a dictionary or missing 'bitfields'.")
               
    except KeyError as e:
        # Catch any KeyError (missing keys in the data) and print an error message
        print(f"Error: Missing expected key in JSON data: {e}")
    except ValueError as e:
        # Catch any ValueError (invalid values, such as non-integer values) and print an error message
        print(f"Error: Invalid value encountered. Ensure parameter values are in correct format. {e}")
   
    # Return the result along with the JSON string of the data and a status code of 1
    # return result, json.dumps(data), 1
    return result

# *****************************************************************************************************************************
#  Module Name        : command_validation                                                                                   *
#  Functionality      : Validates a command from a file (either JSON or YAML) and retrieves details about it.                *
#                       It loads the file based on the provided file format and checks if the specified command exists.      *
#                       If the command exists, it returns the command's name, its full details, and the number of           *
#                       parameters associated with the command. If the command is not found, it returns an error response.   *
#                                                                                                                           *
#  Input Parameters   :                                                                                                     *
#    command          : str  - The name of the command to be validated.                                                     *
#    parameter        : str  - A parameter for the command.                                                                 *
#    parameter_no     : int  - The number of parameters in the file.                                                        *
#    dictionary       : dict - The file loaded from the path.                                                               *
#    path             : str  - The path to the file containing the commands (either JSON or YAML).                          *
#    file_format      : int  - Format indicator for the file.                                                               *
#                       - 1: JSON format                                                                                   *
#                       - 0: YAML format                                                                                   *
#                                                                                                                           *
#  Output Parameters  :                                                                                                     *
#    If the command is found in the loaded dictionary:                                                                      *
#        - str : Command name.                                                                                              *
#        - str : Command details as a JSON string.                                                                          *
#        - int : The number of parameters for the command.                                                                  *
#    If the command is not found:                                                                                           *
#        - ("invalid command", "invalid dictionary", 0)                                                                    *
#*****************************************************************************************************************************

def command_validation(command,dictionary,path,file_format, input_array, Current_Parameter_count): # This function validates a command from a file (either JSON or YAML) and retrieves details about it.
    Full_Command_Details = ""
    def string_to_array(string):
        return list(map(int, string.split(',')))
    
    if input_array:
        input_buffer = string_to_array(input_array)
        
    if file_format == 1:    # Check if the file format is JSON (file_format == 1)
        with open(path, "r") as file:
            dict = json.load(file)  # Parse the file content into a Python dictionary
    elif file_format == 0:  # If the file format is YAML (file_format == 0)
        with open(path, "r") as file:
            dict = yaml.safe_load(file) # Parse the file content into a Python dictionary

    if command in dict: # Check if the provided command exists in the dictionary (loaded from the file)
        # If the command exists, return the the name of the command, command's full details as a JSON string and number of parameters for the command
        if "parameters" in dict[command]:
            Full_Command_Details += dict[command]["name"] + " (" + command + ")"
            # return (dict[command]["name"], json.dumps(dict[command]), len(dict[command]["parameters"]))  # Convert dictionary to JSON string
            starting_param_count=0
            if Current_Parameter_count >= len(dict[command]["parameters"]):
                starting_param_count = Current_Parameter_count-len(dict[command]["parameters"])
                
            for i in range(starting_param_count,Current_Parameter_count):
                if input_buffer[i] != 0:
                    checking = extract_bitfields_parameter(command, input_buffer[i], dict[command], path, file_format)
                    Full_Command_Details += checking
            return Full_Command_Details, "json.dumps(data)", 1
            # return Full_Command_Details   
        else:
            Full_Command_Details += dict[command]["name"]
            return Full_Command_Details, "json.dumps(data)", 1
            # return Full_Command_Details 
    else:
        return ("invalid command","invalid dictionary",0)   # If the command is not found in the dictionary, return a invalid command
        # return ("invalid command") 
        

# *****************************************************************************************************************************
#  Module Name        : bitfieldNameAndValue                                                                                 *
#  Functionality      : Retrieves and prints the name and value description of a specific bitfield within a given parameter. *
#                       Navigates to the required section of the data, checks for the existence of the specified parameter   *
#                       and bitfield, and fetches the corresponding value description for the specified bit value.           *
#                       If the bitfield name is "Reserved", the function returns early.                                      *
#                                                                                                                           *
#  Input Parameters   :                                                                                                     *
#    data             : dict - The structured data containing parameters and bitfields.                                     *
#    parameter_input  : str  - The name of the parameter whose bitfields will be examined.                                   *
#    bitfield         : str  - The name of the bitfield within the specified parameter to fetch data for.                    *
#    bit_value        : str  - The specific bit value to fetch its description.                                             *
#                                                                                                                           *
#  Output Parameters  :                                                                                                     *
#    Returns a formatted string with the bitfield name and its corresponding value description, or None if the bitfield      *
#    is labeled as "Reserved".                                                                                              *
#*****************************************************************************************************************************


def bitfieldNameAndValue(data, parameter_input, bitfield, bit_value):
    bit_value= str(bit_value)
 
    # Navigate directly to the parameter section in the JSON structure
    parameter_data = data.get("parameters", {}).get(parameter_input, {})
   
    if not parameter_data:
       
        print (f"Error: '{parameter_input}' not found.")
 
    parameter_name = parameter_input
 
    # Find the bitfield in the parameter's bitfields
    bitfield_data = parameter_data.get("bitfields", {}).get(bitfield, {}) or parameter_data.get("Bitfields", {}).get(bitfield, {})
   
    if not bitfield_data:
       
        print (f"Error: '{bitfield}' not found in '{parameter_name}'.")
 
    # Extract the name of the bitfield
    field_name = bitfield_data.get("name")
 
    #print(field_name)
    if field_name == "Reserved":
        return
 
    # Get the values dictionary, which contains the descriptions for different bit values
    values = bitfield_data.get("values", {}) or bitfield_data.get("Values", {})
   
    # Get the description for the provided bit_value, or use the default description if not provided
    value_description = values.get(bit_value, values.get("default"))
 
 
    if not value_description:
       
        print(f"Error: Bit value '{bit_value}' not found for bitfield '{bitfield}'.")
 
    # Return the formatted string with parameter and bitfield information on separate lines
    return f"{"-> "}{field_name:<41} : {value_description}"
 
