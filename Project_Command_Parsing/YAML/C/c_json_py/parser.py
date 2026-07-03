import sys
import json

# Check if the required arguments are passed
if len(sys.argv) < 4:
    print("Usage: python search_json.py <command_name> <bitfield> <value>")
    sys.exit(1)

# Arguments passed from C program
command_name = sys.argv[1]
bitfield = sys.argv[2]
value_to_find = sys.argv[3]

# Example JSON data (this can be loaded from a file)
# json_data = '''
# {
#     "command_name": {
#         "name": "Command Name",
#         "parameters": {
#             "template": {
#                 "bitfields": {
#                     "0-3": {
#                         "values": {
#                             "0001": "Value 1",
#                             "0010": "Value 2"
#                         }
#                     },
#                     "4-7": {
#                         "values": {
#                             "0100": "Value 3",
#                             "0101": "Value 4"
#                         }
#                     }
#                 }
#             }
#         }
#     }
# }
# '''

# Load the JSON data (in real use case, load it from a file)
json_file_path = "D:\\Project_Command_Parsing\\YAML\\C\\c_json_py\\ttl.json"  # Replace with your JSON file path
try:
    with open(json_file_path, 'r') as json_file:
        data = json.load(json_file)
except Exception as e:
    print(f"Error reading the JSON file: {e}")
    sys.exit(1)

# Extract the command section
command_section = data.get("command_name", {})
# print(command_section)
if command_name != command_section["name"]:
    print(f"Command '{command_name}' not found.")
    sys.exit(1)

# Access the bitfields
bitfields = command_section.get("parameters", {}).get("template", {}).get("bitfields", {})

for key in bitfields.keys():
    print(key)
    
# Search for the bitfield and the value in the bitfields
if bitfield in bitfields:
    values = bitfields[bitfield].get("values", {})
    if value_to_find in values:
        print(f"Bitfield '{bitfield}' with value '{value_to_find}' maps to: {values[value_to_find]}")
    else:
        print(f"Value '{value_to_find}' not found in bitfield '{bitfield}'")
else:
    print(f"Bitfield '{bitfield}' not found in the command '{command_name}'")
