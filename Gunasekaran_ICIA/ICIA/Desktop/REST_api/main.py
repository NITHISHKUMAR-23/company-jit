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
from flask import Flask, request, send_file, abort, jsonify
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
volume_command_id = 0x00000005
volume_param_id = "0x00000005"

ACS_API_BASE = 'http://localhost:8099'


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

    @app.route('/activeArchive', methods=['GET', 'PUT'])
    def active_archive():
        if request.method == 'PUT':
            if request.json is None or \
               "archive" not in request.json or \
               "configuration" not in request.json:
                return abort(400, {"message": "Missing archive or configuration in request body"})

            archive = request.json["archive"]
            configuration = request.json["configuration"]

            try:
                response = requests.put(
                    f"{ACS_API_BASE}/activeArchive",
                    json={"archive": archive, "configuration": configuration},
                    timeout=5
                )
                

                if response.status_code != 200:
                    try:
                        error_data = response.json()
                    except ValueError:
                        error_data = {"message": f"Non-200 response with no JSON body. Status: {response.status_code}"}
                    return jsonify({"error": error_data}), response.status_code

                try:
                    return jsonify(response.json()), 200
                except ValueError:
                    return jsonify({
                        "archive": archive,
                        "configuration": configuration 
                        })

            except requests.RequestException as e:
                return jsonify({"error": "Failed to connect to ACS API", "details": str(e)}), 503

        elif request.method == 'GET':
            try:
                response = requests.get(f"{ACS_API_BASE}/activeArchive", timeout=5)
                if response.status_code != 200:
                    try:
                        error_data = response.json()
                    except ValueError:
                        error_data = {"message": f"Non-200 response with no JSON body. Status: {response.status_code}"}
                    return jsonify({"error": error_data}), response.status_code

                try:
                    return jsonify(response.json()), 200
                except ValueError:
                    return jsonify({"message": "Got response from ACS but not JSON"}), 200

            except requests.RequestException as e:
                return jsonify({"error": "Failed to fetch active archive from ACS API", "details": str(e)}), 503


    @app.route('/volume', methods=['GET', 'PUT'])
    def volume():
        if request.method == 'GET':
            try:
                resp = requests.get(f"{ACS_API_BASE}/volume", timeout=5)
                print(resp)
                resp.raise_for_status()
                return jsonify(resp.json()), 200
            except requests.RequestException as e:
                return jsonify({"error": "Failed to connect to ACS API", "details": str(e)}), 503

        if request.method == 'PUT':
            if not request.is_json or 'volume' not in request.json:
                abort(400, description="Missing 'volume' in JSON body")

            vol = request.json['volume']
            
            #vol = round(vol)
            print("vol_1" ,vol)
            dB = 40 - vol
            print("vol_2", dB)
            gain = 10 ** (dB/20)
            print("gain ",gain)
            vol = gain
            
            
           
            try:
                vol_float = float(vol)
                # Optionally clamp volume here based on ACS spec
            except ValueError:
                abort(400, description="Volume must be a number")

            try:
                resp = requests.put(f"{ACS_API_BASE}/volume", json={"volume": vol_float}, timeout=5)
                #print("ACS Response:", resp.status_code, resp.text)
                resp.raise_for_status()

                # Check if response has JSON content
                if resp.text.strip():  # only try to parse JSON if there's content
                    return jsonify(resp.json()), 200
                else:
                    return jsonify({"message": "Volume updated successfully"}), 200

            except requests.RequestException as e:
                return jsonify({"error": "Failed to update volume on ACS API", "details": str(e)}), 503
            except ValueError as ve:
                # Handle JSON decode error gracefully
                print("Error parsing ACS response JSON:", ve)
                return jsonify({"message": "Volume updated, but response was not JSON"}), 200





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
    


    @app.route('/proxyParameterPlainValue/<parameterId>', methods=['GET', 'PUT', 'OPTIONS'])
    def proxy_parameters_plainValue(parameterId):
        parameterId = str(parameterId)
        if request.method == 'GET' or request.method == 'OPTIONS':
            # Fetch all parameters and find this one
            try:
                response = requests.get(f"{ACS_API_BASE}/parameters", timeout=5)
                if response.status_code != 200:
                    return jsonify({"error": response.json()}), response.status_code

                params = response.json()
                param = next((p for p in params.get('parameters', []) if p.get('id') == parameterId), None)
                if param is None:
                    return abort(404, {"message": f"Parameter ID {parameterId} not found."})

                return {"plainValue": param.get('value')}

            except requests.RequestException as e:
                return jsonify({"error": "Failed to connect to ACS API", "details": str(e)}), 503

        if request.method == 'PUT':
            if not request.is_json or 'plainValue' not in request.json:
                return abort(400, {"message": "Plain value is missing from the request body."})

            try:
                validated_plainValue = float(request.json['plainValue'])
            except ValueError:
                return abort(400, {"message": "Plain value must be a float."})

            payload = {
                "parameters": [
                    {
                        "id": parameterId,
                        "value": validated_plainValue
                    }
                ]
            }

            try:
                response = requests.put(f"{ACS_API_BASE}/set_parameter_values", json=payload, timeout=5)
                if response.status_code != 200:
                    return jsonify({"error": response.json()}), response.status_code

                return {"plainValue": validated_plainValue}

            except requests.RequestException as e:
                return jsonify({"error": "Failed to connect to ACS API", "details": str(e)}), 503

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
