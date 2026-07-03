import sys
import yaml

# Function to load a YAML file
def load_yaml(file_path):
    with open(file_path, 'r') as file:
        data = yaml.safe_load(file)
        return data

def check_parameter1(Command, Parameter, start, end, value):
    # Global variable for the YAML content
    global yaml_content

    # Assuming yaml_content is loaded with the YAML file
    parameters_map = yaml_content[f'Command_0x{Command:X}']
    parameter_bits = parameters_map[f'Parameter{Parameter}']['Bits']
    bit_range_key = f'bit{start}-{end}'
    
    result = ""  # Store the result to return

    if bit_range_key in parameter_bits:
        description = parameter_bits[bit_range_key]
        if isinstance(description, dict):
            if value in description:
                result = f"Value '{value}' enables: {description[value]}"
            else:
                result = f"Value '{value}' is not valid for bit range {bit_range_key}.\nValid values are:"
                for valid_value, meaning in description.items():
                    result += f"\n  {valid_value}: {meaning}"
        else:
            result = f"Bit range {bit_range_key} description: {description}"
    else:
        result = f"Bit range {bit_range_key} is not defined in Parameter{Parameter}."
    
    return result

def main():
    # Path to the YAML file
    yaml_file = 'example.yaml'

    # Load the YAML content
    global yaml_content
    yaml_content = load_yaml(yaml_file)

    # Parse command-line arguments
    if len(sys.argv) != 6:
        sys.exit("Usage: python yaml_access.py <Command> <Parameter> <start> <end> <value>")

    Command = int(sys.argv[1], 16)  # Hexadecimal command
    Parameter = int(sys.argv[2])
    start = int(sys.argv[3])
    end = int(sys.argv[4])
    value = sys.argv[5]

    # Get the result from the check_parameter1 function
    result = check_parameter1(Command, Parameter, start, end, value)

    # Output the result back to the C program
    sys.stdout.write(result)

if __name__ == "__main__":
    main()
