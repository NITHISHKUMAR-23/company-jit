import sys
import json
 
def parse_json_command(command, parameter, data):
    parameter_count=0
    if command in data:
        parameter_count=len(data[command]["parameters"])
        print(parameter_count)
        print(data[command]["name"])
        sys.exit(1)
    else:
        print(parameter_count)
        sys.exit(1)
 
def parameter_parsing(command_name,parameter_value,data):
    print(data)
   
def main():
    # Check if the required arguments are passed
    if len(sys.argv) < 4:
        print("Usage: python parser.py <command_name> <parameter> <parameter_number>")
        sys.exit(1)
 
    # Arguments passed from the command line
    command_name = sys.argv[1]
    parameter_value = sys.argv[2]
    parameter_no =sys.argv[3]
 
    # Path to your JSON file
    file_path = "D:\\Project_Command_Parsing\\Work\\prasanth\\Prem\\example.json"  # Update this path accordingly
 
    try:
        # Load JSON file
        with open(file_path, 'r') as json_file:
            data = json.load(json_file)
    except Exception as e:
        print(f"Error reading the JSON file: {e}")
        sys.exit(1)
 
 
    # Call the function to parse the JSON and process the command
    if parameter_value == "false":
        parse_json_command(command_name, parameter_value, data)
    else:
        parameter_num = "parameter"+parameter_no
        print(parameter_num)
        parameter_parsing(command_name,parameter_value,data[command_name]["parameters"][parameter_num])
       
 
 
if __name__ == "__main__":
    main()