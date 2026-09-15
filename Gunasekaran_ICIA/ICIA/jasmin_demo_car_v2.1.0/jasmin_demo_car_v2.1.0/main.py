import os
from flask import Flask, request, send_file, abort
from flask_cors import CORS
import serial
from time import sleep
import struct
from math import *

# Directory paths for template and test API
template_dir = os.path.abspath('./demo_app')
test_api_dir = os.path.abspath('.')
app = Flask(__name__, static_folder=template_dir)
CORS(app)

#jasmin integrated code
HEADER_H = b'\xAA'
HEADER_L = b'\x55'
SET_PARAM = b'\x03'
SET_ACT_ARCHIVE = b'\x01'
SET_ARCHIVE_CMD = b'\x02'
FOOTER_H = b'\x55'
FOOTER_L = b'\xAA'

#Error Status
#ERR_ST = 0

#Communication protocol initialization
ser=serial.Serial(port='/dev/ttyUSB1',baudrate=115200,bytesize=8,parity='N',stopbits=1,timeout=2)   #USB1


# Dictionary to store active archives and configurations
active_archives = {
    "": [],
    "Dummy_For_DemoApp_seatmodes.eval": [
        "%1%Opteo_Stereo_Driverseat",
        "%10%Virtuo_Frontseat",
        "%11%Virtuo_Backseat",
        "%12%Virtuo_Allseat",
        "%2%Opteo_Stereo_Frontseat",
        "%3%Opteo_Stereo_Backseat",
        "%4%Opteo_Stereo_Allseat",
        "%5%Opteo_Atmos_Driverseat",
        "%6%Opteo_Atmos_Frontseat",
        "%7%Opteo_Atmos_Backseat",
        "%8%Opteo_Atmos_Allseat",
        "%9%Virtuo_Driverseat"
    ]
}

# Default active configuration, archive, and volume
active_configuration = "%1%Opteo_Stereo_Driverseat"
active_archive = "Dummy_For_DemoApp_seatmodes.eval"
active_volume = 1 # Range from 0 to 1 (-60 dB to 0 dB)

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
    return active_archives  # Returns data in a JSON response


@app.route('/activeArchive', methods=['PUT', 'GET'])
def activeArchive():
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
    global active_archive, active_configuration
    parameter_length = b'\x1E\x00\x00\x00'

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
            request.json["archive"] not in active_archives or \
            request.json["configuration"] not in \
                active_archives[request.json["archive"]]:

            return abort(404, {
                "message": f"Invalid request or configuration. "
                f"Received: {str(request)}"
            })

        else:
            active_archive = request.json["archive"]
            active_configuration = request.json["configuration"]
            conf_data = active_configuration.encode().ljust(30, b'\x00')
            crc =  calculate_crc(SET_ARCHIVE_CMD + parameter_length + conf_data)
            crc = struct.pack('B', crc)
            data = HEADER_H + HEADER_L + SET_ARCHIVE_CMD + parameter_length + conf_data + crc + FOOTER_H + FOOTER_L
            ser.write(data)
            #update for error status
            
            #sleep(0.5)
            ERR_ST = ser.readline()
            print("status:{}".format(ERR_ST))

    return {
        "archive": active_archive,
        "configuration": active_configuration
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
            - libdirac -> `dirac_set_parameter()`
    """
    def plain_to_normalized(plain):
        Max = 0
        Min = -120
        default = 0
        if(plain > Max):
            return 0
        if(plain < Min):
            return -1
        if(plain > default):
            plain_range = Max - default
        else:
            plain_range = default - Min
        if(plain_range > 0.0):
            normalized = (plain - default) / plain_range
            return normalized
        
        
        
    global active_volume
    parameter_size = b'\x08\x00\x00\x00'
    volume_id = b'\x13\x00\x00\x10'

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
            Gain_Linear = float(request.json['volume'])
            plain = 20*log(Gain_Linear,10)
            plain = round(plain)
            normalized = plain_to_normalized(plain)
            #jasmin integrated code
            active_data = struct.pack('f', normalized)
            crc = calculate_crc(SET_PARAM + parameter_size + volume_id + active_data)
            crc = struct.pack('B', crc)
            active_data = active_data + b'\x00' * 22
            if len(active_data) != 26:
                raise ValueError("Byte representation is not 26 bytes long")
            data = HEADER_H + HEADER_L + SET_PARAM + parameter_size + volume_id + active_data + crc + FOOTER_H + FOOTER_L
            ser.write(data)
            #update for error status
            
            #sleep(0.5)
            ERR_ST = ser.readline().decode().strip()
            print(ERR_ST)
        except ValueError:
            return abort(404, {"message": f"Volume value must be a float."
                                   f"Received: {request.json['volume']}"})

        # If all validations pass, update the active volume
        active_volume = Gain_Linear

    return {"volume": active_volume}

# Everything not declared before (not a Flask route / API endpoint)
# Static files needed by the frontend


@app.route("/<path:path>")
def route_frontend(path):
    file_path = os.path.join(app.static_folder, path)
    if os.path.isfile(file_path):
        return send_file(file_path)
    return abort(404)
        
        
def calculate_crc(data):
    curr_crc = 0xAA
    sum1 = curr_crc & 0xFF
    sum2 = (curr_crc >> 8) & 0xFF

    for byte in data:
        sum1 = (sum1 + byte) % 0xFF
        sum2 = (sum2 + sum1) % 0xFF

    # Return the least significant byte of the CRC result
    return sum1 & 0xFF # Take only the least significant byte
    



if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True, port=5600)
