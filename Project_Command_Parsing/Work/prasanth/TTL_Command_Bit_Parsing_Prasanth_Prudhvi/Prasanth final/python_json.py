import sys
import json
 
# Function to load a json file
def load_json(file_path):
    with open(file_path, 'r') as file:
        data = json.load(file)
        return data
 
# Function to extract bitfields for parameter 1 and include parameter count
def extract_bitfields_parameter_1(command_value, parameter_values, data, parameter_number):
    Parameter(parameter_number)
    parameter_value = int(parameter_values, 16)  # Convert the hex value to an integer
    accessed_parameter = "parameter"+str(parameter_number)
    for bitfield, bitfield_data in data[command_value]["parameters"][accessed_parameter]["bitfields"].items():
        if '-' in bitfield:  # Bit range like '15-14'
            start, end = map(int, bitfield.split('-'))
            mask = (1 << (start - end + 1)) - 1  # Create a mask to extract bits in the range
            extracted_bits_int = (parameter_value >> end) & mask
            extracted_bits_bin = bin(extracted_bits_int)[2:].zfill(start - end + 1)
            print(data[command_value]["parameters"], accessed_parameter, bitfield, extracted_bits_bin)
        else:  # Single bit like '0'
            extracted_bits_bin = (parameter_value >> int(bitfield)) & 1
            print(data[command_value]["parameters"], accessed_parameter, bitfield, extracted_bits_bin)
 
def Parameter(parameter_number):
    return f"Parameter \t\t\t: {str(parameter_number)}"

def main():
    # Path to the json file
    json_file = 'example.json'
 
    # Load the json content
    json_content = load_json(json_file)
    parameter_values ="20014321"
    # Given example parameter values
    command_value = "0x20000030"
    parameter_number = 1
    # print(json_content)
    extract_bitfields_parameter_1(command_value, parameter_values, json_content, parameter_number)
   
 
if __name__ == "__main__":
    main()