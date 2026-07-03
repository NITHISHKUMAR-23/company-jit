
import yaml
import json

#/******************************************************************************************************************************************
#  Module Name        : Command Validation Module                                                                                                                       *
#  Functionality      : This module validates a command from a file (either JSON or YAML) and retrieves details about it.
#                       It loads the file based on the provided file format (JSON or YAML) and checks if the specified command
#                       exists in the dictionary. If the command exists, it returns the command's name, its full details in JSON format,
#                       and the number of parameters associated with the command. If the command is not found, it returns an "invalid command".
#  
#  Input Parameters   :
#    - command (str): The name of the command to be validated.
#    - parameter (str): A parameter for the command.
#    - parameter_no (int): The number of parameters in the file.
#    - dictionary (dict): The file loaded from the path.
#    - path (str): The path to the file containing the commands (either JSON or YAML).
#    - file_format (int): Format indicator for the file.
#                         - 1: JSON format
#                         - 0: YAML format
#
#  Output  :
#    - If the command is found in the loaded dictionary:
#        - (str): Command name.
#        - (str): Command details as a JSON string.
#        - (int): The number of parameters for the command.
#    - If the command is not found:
#        - ("invalid command", "invalid dictionary", 0)
#********************************************************************************************************************************************

# This function validates a command from a file (either JSON or YAML) and retrieves details about it.
def command_validation(command, parameter, parameter_no, dictionary, path, file_format):
    try:
        # Check file format and load the appropriate file type (JSON or YAML)
        if file_format == 1:  # JSON format
            with open(path, "r") as file:
                dict_data = json.load(file)
        elif file_format == 0:  # YAML format
            with open(path, "r") as file:
                dict_data = yaml.safe_load(file)
        else:
            raise ValueError("Unsupported file format provided. Use 0 for YAML or 1 for JSON.")
        
        # Check if the command exists in the loaded dictionary
        if command in dict_data:
            command_data = dict_data[command]
            
            # Check for 'parameters' key and return data accordingly
            if "parameters" in command_data:
                return command_data.get("name", "Unnamed Command"), json.dumps(command_data), len(command_data["parameters"])
            else:
                return command_data.get("name", "Unnamed Command"), json.dumps(command_data), 0
        else:
            return "invalid command", "command not found", 0

    except FileNotFoundError:
        # Handle the case where the file is not found
        print(f"Error: File '{path}' not found.")
        return "invalid command", "file not found", 0
    except json.JSONDecodeError:
        # Handle the case where JSON decoding fails
        print(f"Error: Failed to decode JSON in file '{path}'. Ensure the file is correctly formatted.")
        return "invalid command", "invalid JSON format", 0
    except yaml.YAMLError:
        # Handle YAML parsing errors
        print(f"Error: Failed to parse YAML in file '{path}'. Ensure the file is correctly formatted.")
        return "invalid command", "invalid YAML format", 0
    except ValueError as ve:
        # Handle invalid file format value
        print(f"Error: {ve}")
        return "invalid command", str(ve), 0
    except Exception as e:
        # Catch any unexpected errors
        print(f"Unexpected error: {e}")
        return "invalid command", f"unexpected error: {e}", 0

      
#*********************************************************************************************************************************
#  Module Name        : extract_bitfields_parameter                                                                                                                      
#  Functionality      : Extracts and processes bitfield information from a given command parameter,                                                                      
#                       generates a formatted result string based on the data, and returns the result.                                                                   
#                       The function supports data in YAML or JSON format and extracts bitfields                                                                         
#                       from a specified parameter number.
#                       
#  Input Parameters   : 
#    command_value    : int  - The command value that contains the bitfields to be extracted.
#    parameter_values : int  - The value associated with the parameter containing bitfields.
#    parameter_number : int  - The number of the parameter to access in the provided data.
#    datas            : str  - The string representing the data in either YAML or JSON format.
#    path             : str  - The file path (currently not used in the function but can be extended).
#    file_format      : int  - The file format: 0 for YAML, 1 for JSON. Other values result in an error.
#  
#  Output Parameters  : 
#    result           : str  - A formatted string containing the processed bitfields and their associated values.
#    json_string      : str  - A JSON string representation of the parsed data.
#    status_code      : int  - A status code where 1 indicates success and 0 indicates an error.
#*******************************************************************************************************************************
 
# command, parameter, parser.parameter_count, parser.Dict, "false", false)

import yaml
import json

def extract_bitfields_parameter(command_value, parameter_values, parameter_number, datas, path, file_format):
    result = " "
    parameter_number = (parameter_values >> 16) & 15  # Extract the bits

    # Parse data based on file format
    try:
        if file_format == 0:
            data = yaml.safe_load(datas)  # YAML parsing
        elif file_format == 1:
            data = json.loads(datas)  # JSON parsing
        else:
            raise ValueError("Invalid file format. Supported formats: 0 (YAML), 1 (JSON).")
    except (yaml.YAMLError, json.JSONDecodeError, ValueError) as e:
        print(f"Error parsing data: {e}")
        return

    # Construct the key for the parameter and prepare the result string
    accessed_parameter = f"parameter{parameter_number}"
    result += f"\nParameter number : {parameter_number}\n\n"

    # Check if the accessed parameter exists in the "parameters" section of the data
    if accessed_parameter not in data.get("parameters", {}):
        print(f"Error: {accessed_parameter} not found in parameters.")
        return

    accessed_param = data["parameters"][accessed_parameter]

    # Check if the parameter contains "bitfields"
    if isinstance(accessed_param, dict) and "bitfields" in accessed_param:
        for bitfield, bitfield_data in accessed_param["bitfields"].items():
            extracted_bits_bin = None

            # If the bitfield is a range (e.g., '15-14')
            if '-' in bitfield:
                start, end = map(int, bitfield.split('-'))
                mask = (1 << (start - end + 1)) - 1  # Create the mask for the bit range
                extracted_bits_int = (parameter_values >> end) & mask  # Extract the bits
                extracted_bits_bin = bin(extracted_bits_int)[2:].zfill(start - end + 1)
            else:  # Single bit (e.g., '0')
                extracted_bits_bin = (parameter_values >> int(bitfield)) & 1  # Extract the single bit

            # Process the bitfield name and value
            if extracted_bits_bin:
                temp = BitfieldNameandValue(data, accessed_parameter, bitfield, extracted_bits_bin)
                if temp:
                    result += temp + "\n"
    else:
        print(f"Error: {accessed_parameter} is not a dictionary or missing 'bitfields'.")

    return result, json.dumps(data), 1

#/******************************************************************************************************************************************
#  Module Name        : BitfieldNameandValue
#  Functionality      : This function retrieves and prints the name and value description of a specific bitfield within a given 
#                       parameter in a structured data format (like JSON). It navigates to the required section of the data, 
#                       checks for the existence of the specified parameter and bitfield, and fetches the corresponding 
#                       value description for the specified bit value. If the bit value is not found, it returns an error message.
#                       If the bitfield name is "Reserved", the function returns early without performing further actions.
#  Input Parameters   : data (dict)               : The structured data (typically a dictionary) containing parameters and bitfields.
#                       parameter_input (str)      : The name of the parameter whose bitfields will be examined.
#                       bitfield (str)             : The name of the bitfield within the specified parameter to fetch data for.
#                       bit_value (str)            : The specific bit value to fetch its description.
#  Output Parameters  : None                       : This function does not return any output but prints error messages or the 
#                                               bitfield name along with its corresponding value description.
#  Return Values      : str                        : Returns a formatted string with the bitfield name and its corresponding value description,
#                                               or None if the bitfield is labeled as "Reserved".
#******************************************************************************************************************************************/
def BitfieldNameandValue(data, parameter_input, bitfield, bit_value):
    bit_value = str(bit_value)
 
    # Check if parameters section exists in the data
    parameters = data.get("parameters", {})
    if not parameters:
        print("Error: No parameters found in the data.")
        return

    # Navigate directly to the parameter section
    parameter_data = parameters.get(parameter_input)
    if not parameter_data:
        print(f"Error: '{parameter_input}' not found in parameters.")
        return

    parameter_name = parameter_input

    # Try to find the bitfield in both 'bitfields' and 'Bitfields' keys
    bitfield_data = parameter_data.get("bitfields") or parameter_data.get("Bitfields")
    if not bitfield_data:
        print(f"Error: '{bitfield}' not found in '{parameter_name}' bitfields.")
        return

    # Extract the name of the bitfield
    field_name = bitfield_data.get("name")
    if not field_name:
        print(f"Error: No 'name' field found for bitfield '{bitfield}'.")
        return

    # Skip processing if bitfield name is "Reserved"
    if field_name == "Reserved":
        return

    # Get the values dictionary for the bitfield
    values = bitfield_data.get("values") or bitfield_data.get("Values")
    if not values:
        print(f"Error: No 'values' found for bitfield '{bitfield}'.")
        return

    # Get the description for the provided bit_value
    value_description = values.get(bit_value)
    if value_description is None:
        # If bit_value is not found, check for the default description
        value_description = values.get("default")
        if not value_description:
            print(f"Error: Bit value '{bit_value}' and default not found for bitfield '{bitfield}'.")
            return

    # Return the formatted string with parameter and bitfield information on separate lines
    return f"-> {field_name:<41} : {value_description}"
