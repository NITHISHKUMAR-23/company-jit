import sys
import yaml

# Function to load a YAML file
def load_yaml(file_path):
    try:
        with open(file_path, 'r') as file:
            data = yaml.safe_load(file)
            return data
    except FileNotFoundError:
        print(f"Error: The file {file_path} was not found.")
        sys.exit(1)
    except yaml.YAMLError as e:
        print(f"Error: Failed to parse the YAML file. {e}")
        sys.exit(1)

# Function to extract bitfields for parameter 1 and include parameter count
def extract_bitfields_parameter(command_value, parameter_values, data, parameter_number):
    try:
        parameter_value = int(parameter_values, 16)  # Convert the hex value to an integer
        accessed_parameter = f"parameter{parameter_number}"
        
        # Check if the command_value exists in the data
        if command_value not in data:
            print(f"Error: Command value {hex(command_value)} not found in data.")
            sys.exit(1)
        
        command_data = data[command_value]
        
        # Check if the accessed_parameter exists in the command data
        if accessed_parameter not in command_data["parameters"]:
            print(f"Error: {accessed_parameter} not found in parameters of command value {hex(command_value)}.")
            sys.exit(1)
        
        parameters = command_data["parameters"][accessed_parameter]
        
        # Check if bitfields exist in the parameters
        if "bitfields" not in parameters:
            print(f"Error: No bitfields found for {accessed_parameter} in command value {hex(command_value)}.")
            sys.exit(1)

        for bitfield, bitfield_data in parameters["bitfields"].items():
            try:
                if '-' in bitfield:  # Bit range like '15-14'
                    start, end = map(int, bitfield.split('-'))
                    mask = (1 << (start - end + 1)) - 1  # Create a mask to extract bits in the range
                    extracted_bits_int = (parameter_value >> end) & mask
                    extracted_bits_bin = bin(extracted_bits_int)[2:].zfill(start - end + 1)
                    json_bit_parser(data,accessed_parameter, bitfield, extracted_bits_bin)                #call the next API
                else:  # Single bit like '0'
                    extracted_bits_bin = (parameter_value >> int(bitfield)) & 1
                    json_bit_parser(data,accessed_parameter, bitfield, extracted_bits_bin)                  #call the next API
            except ValueError as e:
                print(f"Error: Invalid bitfield format '{bitfield}' in {accessed_parameter}. {e}")
                sys.exit(1)

    except ValueError as e:
        print(f"Error: Invalid parameter value '{parameter_values}'. {e}")
        sys.exit(1)
        
        
        
def json_bit_parser(json_data, parameter_input, bitfield, bit_value):
    # Extract the 4th bit from the parameter input
    parameter_no = get_parameter_number(parameter_input)
 
    # Navigate directly to the parameter section in the JSON structure
    parameter_data = json_data.get("parameters", {}).get(parameter_no, {})
   
    if not parameter_data:
        # Return an error if the parameter does not exist
        print( f"Error: '{parameter_no}' not found.")
 
    # Find the bitfield in the parameter's bitfields
    bitfield_data = parameter_data.get("bitfields", {}).get(bitfield, {})
   
    if not bitfield_data:
        # Return an error if the bitfield does not exist
        print(f"Error: '{bitfield}' not found in '{parameter_no}'.")
 
    # Extract the name of the bitfield
    field_name = bitfield_data.get("name")
 
    # Get the values dictionary, which contains the descriptions for different bit values
    values = bitfield_data.get("values", {})
   
    # Get the description for the provided bit_value, or use the default description if not provided
    value_description = values.get(bit_value, values.get("default"))
 
    if not value_description:
        # Return an error if the bit value does not exist
        print(f"Error: Bit value '{bit_value}' not found for bitfield '{bitfield}'.")
 
    # Return the field name and corresponding description as a formatted string
    print(f"{field_name} - {value_description}")




def main():
    # Path to the YAML file
    yaml_file = 'example.yaml'

    # Load the YAML content
    yaml_content = load_yaml(yaml_file)
    parameter_values = '20014321'  # Given example parameter values
    command_value = 0x20000030
    parameter_number = 1

    extract_bitfields_parameter(command_value, parameter_values, yaml_content, parameter_number)
    

if __name__ == "__main__":
    main()
