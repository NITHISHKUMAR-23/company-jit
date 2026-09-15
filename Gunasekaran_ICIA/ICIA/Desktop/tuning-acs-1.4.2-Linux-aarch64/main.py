'''
This script provides a Flask-based API for the DemoApp, which is designed to
manage DAR files and their configurations. It includes endpoints for serving a
frontend application, managing archives and configurations, controlling volume,
and interacting with interface parameters.

Usage:
    Run the script with the following command:
        python main.py --config <interface.json>
    Example:
        python main.py --config Jasmin_IN_Demo_AIQ-H-P-U_DPL5-6-0_V02.eval.interface.json
Arguments:
    - -c, --config: Specifies the interface.json file to parse the DAR
      configuration list. Default: "generic.eval.interface.json"
'''

import os
from flask import Flask, request, send_file, abort
from flask_cors import CORS
import json
import argparse
import serial
from time import sleep
import struct
import math
import array
import socket
import requests
import subprocess


#jasmin integrated code
HEADER_H = b'\xAA'
HEADER_L = b'\x55'
FOOTER_H = b'\x55'
FOOTER_L = b'\xAA'




class DemoApp:

    def __init__(self, config_path):          
        self.active_volume = 1  # Range from 0 to 1 (-40 dB to 0 dB)
        self.active_configuration = ""
        self.active_archives = ""

        self.proxy_parameters = {}
        self.open_config(config_path)  
        
    @staticmethod    
    def send_tcp_command(host, port, message):
        try:
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
                sock.connect((host, port))
                sock.sendall(message.encode('utf-8'))
                response = sock.recv(1024)
                return response.decode()
            
        except Exception as e:
            return f"Error: {e}"

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


def create_app(template_path="", test_api_dir=".", interface_json=""):
    demo_app = DemoApp(interface_json)
   
    # Directory paths for demo_app and test API
    demo_app_dir = os.path.abspath(template_path)
    test_api_dir = os.path.abspath(test_api_dir)
    app = Flask(__name__, static_folder=demo_app_dir)
    CORS(app)
    

    import logging
    log = logging.getLogger('werkzeug')
    log.setLevel(logging.ERROR)

    # Handle public endpoints

    @app.route("/", methods=['GET'])
    def index():
        """
        This endpoint serves the main demo app.

        - GET: Route to the frontend web application (demo app).
        """
        index_path = os.path.join(app.static_folder, "index.html")
        return send_file(index_path)

    @app.route('/docs/', methods=['GET'])
    def docs():
        """
        This endpoint serves as a gateway to the comprehensive API documentation.
        It offers valuable insights into the API's functionality.

        - GET: Route to a static HTML page.
        """
        index_path = os.path.join(test_api_dir, "test_api/docs.html")
        return send_file(index_path)

    @app.route('/archives/', methods=['GET'])
    def archives():
        """
        This endpoint retrieves details about all the DAR (archive) files and their
        associated configurations.

        In the provided example, there is a single DAR file with 12 configurations,
        each representing a unique combination of mode and seat.

        Note that this operation does not involve sending DAR files, but it allows
        querying the API for a list of available configurations for the demo app's
        use.

        - GET: Returns the list of archives and configurations in a JSON format.
        """
        return demo_app.active_archives  # Returns data in a JSON response
        
    def calculate_crc(data):
        curr_crc = 0xAA
        sum1 = curr_crc & 0xFF
        sum2 = (curr_crc >> 8) & 0xFF
        for byte in data:
            sum1 = (sum1 + byte) % 0xFF
            sum2 = (sum2 + sum1) % 0xFF
        # Return the least significant byte of the CRC result
        return sum1 & 0xFF # Take only the least significant byte


    @app.route('/activeArchive', methods=['PUT', 'GET'])
    def activeArchive():
        #rest_address = "http://0.0.0.0:55813" 
        #MSG_ID = b'\x01\x00\x00\x00'
        #CONF_HDR_ID = b'\x08\x00\x00\x00'
        """
        This endpoint reflects the current combination of archive and configuration
        in the following JSON body format:

            {
                "archive": "dar_file.eval",
                "configuration": "configuration_name"
            }

        - GET: Retrieve the current active archive and configuration.
        - PUT: Update the active archive and configuration based on the provided
                request.
                This involves a configuration switching, e.g.,
                    - acs -> `set_active_configuration_by_name()'
                    - libdirac -> `dirac_create()`

        If the requested archive or configuration does not exist, a 404 error is
        returned.
        """
        if request.method == 'PUT':
            # Validate the requested 'archive' and 'configuration' values
            # The validation may include:
            # - The request body with the required format
            # - The requested 'configuration' exists within the 'archive' (dar) file
            # - The 'configuration' has a parameter named "Volume Control" with ID
            #   0x00000005.
            # - The configuration switch was successful

            if request.json is None or \
                "archive" not in request.json or \
                "configuration" not in request.json or \
                request.json["archive"] not in demo_app.active_archives or \
                request.json["configuration"] not in \
                    demo_app.active_archives[request.json["archive"]]:

                return abort(404, {
                    "message": f"Invalid request or configuration. "
                    f"Received: {str(request)}"
                })

            # Update active archive and configuration
            demo_app.active_archive = request.json["archive"]
            demo_app.active_configuration = request.json["configuration"]
            conf_name = demo_app.active_configuration
            #print(data)
                # Command to run the test-client executable
            command = ['./test-client', '-p', '55813', 'set_active_configuration_by_name', conf_name]


            try:
                # Run the command and capture the output
                result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

                # Check if the command ran successfully
                if result.returncode == 0:
                    print("Command: ", command)
                    print("Output:", result.stdout)  # This will print the output from the command
                else:
                    print("Command failed with error:")
                    print("Error:", result.stderr)  # This will print any error that occurred

            except Exception as e:
                print(f"Error running the command: {e}")


        return {
            "archive": demo_app.active_archive,
            "configuration": demo_app.active_configuration
        }  # Returns data in a JSON response

    @app.route('/volume', methods=['PUT', 'GET'])
    def volume():
        """
        Map to a parameter for volume control.

        This endpoint is linked to a parameter named "Volume Control" with
        ID 0x00000005.

        It takes the following JSON body format:

            {
                "volume": 1.0,
            }

        - GET: Retrieve the current volume value.
        - PUT: Set the volume value (parameter "Volume Control") based on the
            value provided in the JSON request body.
            This involves a parameter setting, e.g.,
                - acs -> `set_parameter_values()'
                - libdirac -> `dirac_set_parameter()'
        """
        if request.method == 'PUT':
            # Validate the volume value.
            # The validation may include:
            # - 'volume' is present in the request body
            # - 'volume' value is a float or integer.
            # - 'volume' value falls within the acceptable range for the parameter.

            if request.json is None or request.json['volume'] is None:
                return abort(404, {
                    "message": "Volume value is missing from the request body. "
                    f"Received: {str(request)}"
                })

            try:
                validated_volume = float(request.json['volume'])  
                value = validated_volume
                level = round(20 * math.log10(value))
                print(level)
                '''
                print(rounded_value)
                value = validated_volume
                dB = 20 * math.log10(value)
                level = round(-dB)
                '''
                struct_value = struct.pack('<f', float(level))
                value = b'\x10\x00\x00\x00\x01\x00\x00\x00\x07\x00\x00\x00\x05\x00\x00\x00'
                value = value + struct_value
                payload = value.ljust(1028, b'\x00')
                crc = calculate_crc(payload)
                crc = struct.pack('B', crc)
                data = HEADER_H + HEADER_L + payload + crc + FOOTER_H + FOOTER_L
                command_id = 0x5
                
                #print(data)
                command = ['./test-client', '-p', '55813', 'set_parameter_values', str(command_id), str(level)]


                try:
                    # Run the command and capture the output
                    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    
                    # Check if the command ran successfully
                    if result.returncode == 0:
                        print("Command: ",command)
                        print("Output:", result.stdout)  # This will print the output from the command
                    else:
                        print("Command failed with error:")
                        print("Error:", result.stderr)  # This will print any error that occurred
    
                except Exception as e:
                    print(f"Error running the command: {e}")
                
                

            except ValueError:
                return abort(404, {"message": f"Volume value must be a float."
                                   f"Received: {request.json['volume']}"})

            # If all validations pass, update the active volume
            demo_app.active_volume = validated_volume

        return {"volume": demo_app.active_volume}

    # Everything not declared before (not a Flask route / API endpoint)
    # Static files needed by the frontend

    @app.route("/<path:path>")
    def route_frontend(path):
        file_path = os.path.join(app.static_folder, path)
        if os.path.isfile(file_path):
            return send_file(file_path)
        return abort(404)

    @app.route('/proxyParameters', methods=['OPTIONS', 'GET'])
    def proxy_parameters():
        """
        Get a list of all the proxy parameters.
        """

        return demo_app.proxy_parameters
        


    @app.route('/proxyParameterPlainValue/<parameterId>', methods=['OPTIONS', 'GET', 'PUT'])
    def proxy_parameters_plainValue(parameterId):
        """
        Get or set the plain value of the specified proxy parameter.
        Example body of a PUT or GET:

        {
            "plainValue": 0.2
        }

        Get or set the plain value of the specified proxy parameter.

        - GET/OPTIONS: Retrieve the plain value of the specified proxy parameter.
        - PUT: Update the plain value of the specified proxy parameter.
        """
        parameterId = str(parameterId)
        if request.method == 'GET' or request.method == 'OPTIONS':
            if parameterId not in demo_app.proxy_parameters:
                return abort(404, {"message": f"Parameter ID {parameterId} not found. {demo_app.proxy_parameters}"})
            return {
                "plainValue": demo_app.proxy_parameters[parameterId]['plainValue']
            }

        if request.method == 'PUT':
            if parameterId not in demo_app.proxy_parameters:
                return abort(404, {"message": f"Parameter ID {parameterId} not found."})

            if request.json is None or 'plainValue' not in request.json:
                return abort(404, {"message": "Plain value is missing from the request body."})

            try:
                validated_plainValue = float(request.json['plainValue'])
            except ValueError:
                return abort(404, {"message": "Plain value must be a float."})

            demo_app.proxy_parameters[parameterId]['plainValue'] = validated_plainValue
            return {"plainValue": demo_app.proxy_parameters[parameterId]['plainValue']}

    return app
    



if __name__ == "__main__":
    '''
    Example on how to run this script:

    python main.py --config Jasmin_IN_Demo_AIQ-H-P-U_DPL6-0-0_V03_250516_FINAL_DEMO.prod.interface.json
    
    sudo python /home/jasminuser/Downloads/Tuning_Phase_2/Jasmin/main.py --config /home/jasminuser/Downloads/Tuning_Phase_2/Jasmin/Jasmin_IN_Demo_AIQ-H-P-U_DPL6-0-0_V03_250516_FINAL_DEMO.prod.interface.json
    
    '''
  
    parser = argparse.ArgumentParser(
        description="Test API for the DemoApp",
    )
    
    parser.add_argument('-c', '--config',
                        help='interface.json file where to parse the DAR configuration list',
                        required=False,
                        default="Jasmin_IN_Demo_AIQ-H-P-U_DPL6-0-0_V03_250516_FINAL_DEMO.prod.interface.json")
    
    args = parser.parse_args()
    app = create_app(
        template_path=r"demo_app",
        test_api_dir="/",
        interface_json=args.config,
    )


    app.run(host="0.0.0.0", debug=False, port=5000)
