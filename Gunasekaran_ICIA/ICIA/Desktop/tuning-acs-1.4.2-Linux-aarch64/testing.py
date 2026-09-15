import os
from flask import Flask, request, send_file, abort
from flask_cors import CORS
import json
import argparse
import requests
import struct

# Helper function to calculate CRC (define this as per your requirement)
def calculate_crc(data):
    # Placeholder CRC calculation (update this with the actual function)
    return 0  # Assuming a dummy CRC value of 0 for now

class DemoApp:

    def __init__(self, config_path):          
        self.active_volume = 1  # Range from 0 to 1 (-40 dB to 0 dB)
        self.active_configuration = ""
        self.active_archives = ""

        self.proxy_parameters = {}
        self.open_config(config_path)  

    def open_config(self, config_path):
        # Helper functions to load the config file and populate active archives
        # and configurations
        with open(config_path, 'r') as file:
            config = json.load(file)
            self.active_archive = config_path.split(
                "/")[-1].split(".interface.json")[0]
            self.active_archives = {self.active_archive: []}
            for config_item in config['configurations']:
                self.active_archives[self.active_archive].append(
                    config_item['name'])
                self.proxy_parameters = {}

                types = {
                    "PARAM_TYPE_LINEAR": "Linear",
                    "PARAM_TYPE_LOOGARITHMIC": "Logarithmic",
                    "PARAM_TYPE_TOGGLE": "Toggle",
                    "PARAM_TYPE_ENUM": "Enum"
                }
                for param in config_item['parameters']:
                    param_id = str(param['id']['id'])
                    self.proxy_parameters[param_id] = {
                        key: float(param[key]) if isinstance(
                            param[key], (int, float)) else param[key]
                        for key in [
                            "description", "max", "min",
                            "name", "stepSize", "unit", "formatting"
                        ]
                    }
                    self.proxy_parameters[param_id].update({
                        "defaultValue": float(param['default']) if isinstance(param['default'], (int, float)) else param['default'],
                        "id": param['id']['id'],
                        "type": types[param['type']],
                        "plainValue": 0.0
                    })


# Function to send command to the server
def send_command_to_server():
    rest_address = "http://localhost:8099"  # The server's REST address
    
    # Hardcoded configuration for sending command
    data = b'\x55\x55\x55\x55'  # Example of the raw binary data you need to send
    
    # Endpoint to send the PUT request
    endpoint = f"{rest_address}/activeArchive"

    try:
        # Send the raw binary data to the server using PUT request
        response = requests.put(endpoint, data=data)
        
        # Check for a successful response
        if response.status_code == 200:
            print("Command successful.")
            print(f"Response: {response.text}")
        else:
            print(f"Command failed. Status Code: {response.status_code}, Error: {response.text}")

    except requests.exceptions.RequestException as e:
        print(f"Error communicating with server: {e}")


# Create Flask app
def create_app(template_path="", test_api_dir=".", interface_json=""):
    demo_app = DemoApp(interface_json)
   
    # Directory paths for demo_app and test API
    demo_app_dir = os.path.abspath(template_path)
    test_api_dir = os.path.abspath(test_api_dir)
    
    app = Flask(__name__, static_folder=demo_app_dir)
    CORS(app)

    # Log setup
    import logging
    log = logging.getLogger('werkzeug')
    log.setLevel(logging.ERROR)

    @app.route("/")
    def home():
        return "DemoApp is running!"

    return app


# Main entry point
if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Test API for the DemoApp",
    )
    
    parser.add_argument('-c', '--config',
                        help='interface.json file where to parse the DAR configuration list',
                        required=False,
                        default="Jasmin_IN_Demo_AIQ-H-P-U_DPL6-0-0_V03_250516_FINAL_DEMO.prod.interface.json")
    
    args = parser.parse_args()

    # Create the Flask app
    app = create_app(
        template_path=r"demo_app",
        test_api_dir="/",
        interface_json=args.config,
    )

    # Start sending command to the server
    send_command_to_server()

    # Run the Flask app
    app.run(debug=True)
