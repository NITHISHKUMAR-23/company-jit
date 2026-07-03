import yaml
 
# Function to load and print YAML data
def load_yaml(file_path):
    with open(file_path, 'r') as file:
        data = yaml.safe_load(file)  # Load the YAML data into a Python dictionary
        return data
 
# Main function
def main():
    # Load YAML data from the file
    yaml_file = 'example.yaml'
    data = load_yaml(yaml_file)
    
    print(data)
    
    # print(data['Command_0x10']['Parameter1']['Bits']['bit11-8']['0000'])
    # print(data['Command_0x10']['Parameter1']['Bits']['bit15-12'])
    # print(data['Command_0x10']['Parameter1']['Bits']['bit11-8'])
    
if __name__ == "__main__":
    main()
    
    
