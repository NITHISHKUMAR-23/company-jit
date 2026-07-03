import json
import yaml

def extract_ttl_details(Full_command, Parameter_buffer, Reference_File_Path, reference_file_type, Current_Parameter_count):
    # Load the reference file based on the specified type
    try:
        with open(Reference_File_Path, "r") as file:
            if reference_file_type == 1:
                values = json.load(file)
            elif reference_file_type == 0:
                values = yaml.safe_load(file)
            else:
                return "Invalid file type"
    except (FileNotFoundError, ValueError, yaml.YAMLError, json.JSONDecodeError) as e:
        return f"Error loading reference file: {e}"

    if Full_command in values:
        command_dict = values.get(Full_command, {})
    else:
        return "Invalid dictionary"

    result = "\t" * 8 + command_dict.get("name", "Unknown") + "(" + Full_command + ")" 

    try:
        Command_Parameter_count = len(command_dict.get("parameters", []))
    except TypeError:
        return "\t" * 8 + command_dict.get("name", "Unknown") + "(" + Full_command + ")"

    if (Current_Parameter_count - Command_Parameter_count) >= 0:
        i = Current_Parameter_count - Command_Parameter_count
    else:
        i = 0

    for i in range(i, Current_Parameter_count):
        if Parameter_buffer[i] != 0:
            try:
                parameter_Number = int((Parameter_buffer[i] & 0x00FF0000) >> 16)
                accessed_parameter = f"parameter{str(parameter_Number)}"
                parameter = f"{'Parameter number'} : {str(parameter_Number)}"
                result += "\n" + parameter + "\n" + "\n"

                if accessed_parameter not in command_dict.get("parameters", {}):
                    result += f"Error: {accessed_parameter} not found in parameters.\n"
                    continue

                accessed_param = command_dict["parameters"][accessed_parameter]

                if isinstance(accessed_param, dict) and "bitfields" in accessed_param:
                    for bitfield, bitfield_data in accessed_param["bitfields"].items():
                        if '-' in bitfield:
                            start, end = map(int, bitfield.split('-'))
                            mask = (1 << (start - end + 1)) - 1
                            extracted_bits_int = (Parameter_buffer[i] >> end) & mask
                            extracted_bits_bin = bin(extracted_bits_int)[2:].zfill(start - end + 1)
                            temp = bitfieldNameAndValue(command_dict, accessed_parameter, bitfield, extracted_bits_bin)
                            if temp:
                                result += temp + "\n"
                        else:
                            extracted_bits_bin = (Parameter_buffer[i] >> int(bitfield)) & 1
                            temp = bitfieldNameAndValue(command_dict, accessed_parameter, bitfield, extracted_bits_bin)
                            if temp:
                                result += temp + "\n"
                else:
                    result += f"Error: {accessed_parameter} is not a dictionary or missing 'bitfields'.\n"
            except KeyError as e:
                result += f"Error: Missing expected key in JSON data: {e}\n"
            except ValueError as e:
                result += f"Error: Invalid value encountered. Ensure parameter values are in correct format. {e}\n"

    return result


def bitfieldNameAndValue(data, parameter_input, bitfield, bit_value):
    bit_value = str(bit_value)
    parameter_data = data.get("parameters", {}).get(parameter_input, {})

    if not parameter_data:
        return f"Error: '{parameter_input}' not found."

    bitfield_data = parameter_data.get("bitfields", {}).get(bitfield, {})
    if not bitfield_data:
        return f"Error: '{bitfield}' not found in '{parameter_input}'."

    field_name = bitfield_data.get("name", "Unknown")
    if field_name == "Reserved":
        return None

    values = bitfield_data.get("values", {})
    value_description = values.get(bit_value, values.get("default", "Undefined"))

    if not value_description:
        return f"Error: Bit value '{bit_value}' not found for bitfield '{bitfield}'."

    return f"-> {field_name:<41} : {value_description}"
