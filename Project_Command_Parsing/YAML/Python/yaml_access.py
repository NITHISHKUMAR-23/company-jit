import yaml
 
# Function to load a YAML file
def load_yaml(file_path):
    with open(file_path, 'r') as file:
        data = yaml.safe_load(file)  
        return data
 
 
def check_parameter1(Command, Parameter, start, end, value):
 
    parameters_map = yaml_content[f'Command_0x{Command:X}']
    parameter_bits = parameters_map[f'Parameter{Parameter}']['Bits']
    bit_range_key = f'bit{start}-{end}'
    if bit_range_key in parameter_bits:
        description = parameter_bits[bit_range_key]
        if isinstance(description, dict):
            if value in description:
                print(f"Value '{value}' corresponds to: {description[value]}")
            else:
                print(f"Value '{value}' is not valid for bit range {bit_range_key}.")
                print("Valid values are:")
                for valid_value, meaning in description.items():
                    print(f"  {valid_value}: {meaning}")
        else:
            print(f"Bit range {bit_range_key} description: {description}")
    else:
        print(f"Bit range {bit_range_key} is not defined in Parameter{Parameter}.")
 
def main():
    # Path to the YAML file
    yaml_file = 'example.yaml'

 
    global yaml_content
    yaml_content = load_yaml(yaml_file)
 
    # Inputs for validation
    Command = 0x10  # Command ID
    Parameter = 1   # Parameter number
    start = 5      # Start bit
    end = 2         # End bit
    value = "0001"  # Value to validate
 
    # Check the parameter
    check_parameter1(Command, Parameter, start, end, value)
if __name__ == "__main__":
    main()
