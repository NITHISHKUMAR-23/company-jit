import yaml
import json

# This function validates a command from a file (either JSON or YAML) and retrieves details about it.
def command_validation(command,parameter,parameter_no,dictionary,path,file_format):
    
    if file_format == 1:    # Check if the file format is JSON (file_format == 1)
        with open(path, "r") as file:
            dict = json.load(file)  # Parse the file content into a Python dictionary
    elif file_format == 0:  # If the file format is YAML (file_format == 0)
        with open(path, "r") as file:
            dict = yaml.safe_load(file) # Parse the file content into a Python dictionary

    if command in dict: # Check if the provided command exists in the dictionary (loaded from the file)
        # If the command exists, return the the name of the command, command's full details as a JSON string and number of parameters for the command
        return (dict[command]["name"], json.dumps(dict[command]), len(dict[command]["parameters"]))  # Convert dictionary to JSON strin
    else:
        return ("invalid command","invalid dictionary",0)   # If the command is not found in the dictionary, return a invalid command