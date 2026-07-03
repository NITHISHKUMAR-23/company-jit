import yaml
import json
#*************************************************************************************************************************************************************************
#  Module Name        : Command Validation Module                                                                                                                       *
#  Functionality      : This module validates a command from a file (either JSON or YAML) and retrieves details about it.
#                       It loads the file based on the provided file format (JSON or YAML) and checks if the specified command
#                       exists in the dictionary. If the command exists, it returns the command's name, its full details in JSON format,
#                       and the number of parameters associated with the command. If the command is not found, it returns an "invalid command" response.
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
#  Output Parameters  : 
#    - If the command is found in the loaded dictionary: 
#        - (str): Command name.
#        - (str): Command details as a JSON string.
#        - (int): The number of parameters for the command.
#    - If the command is not found:
#        - ("invalid command", "invalid dictionary", 0)
#***************************************************************************************************************************************************************************


def command_validation(command,parameter,parameter_no,dictionary,path,file_format): # This function validates a command from a file (either JSON or YAML) and retrieves details about it.
    
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