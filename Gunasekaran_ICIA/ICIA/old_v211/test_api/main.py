import os
from flask import Flask, request, send_file, abort
from flask_cors import CORS

# Directory paths for template and test API
template_dir = os.path.abspath('./demo_app')
test_api_dir = os.path.abspath('.')
app = Flask(__name__, static_folder=template_dir)
CORS(app)

# Dictionary to store active archives and configurations
active_archives = {
    "": [],
    "Jasmin_DemoCar_Opteo_Virtuo_20230929_V4.eval": [
        "%1%2_FrtSeat_Opt_Prof",
        "%2%2_DrvSeat_Opt_Prof",
        "%3%2_FrtSeat_Vir_Prof",
        "%4%2_DrvSeat_Vir_Prof",
        "%5%2_FrtSeat_Opt_Perf",
        "%6%2_DrvSeat_Opt_Perf",
        "%7%12_FrtSeat_Opt_Pro",
        "%8%12_DrvSeat_Opt_Pro",
    ]
}

# Default active configuration, archive, and volume
active_configuration = "%1%2_FrtSeat_Opt_Prof"
active_archive = "Jasmin_DemoCar_Opteo_Virtuo_20230929_V4.eval"
active_volume = 1 # Range from 0 to 1 (-40 dB to 0 dB)

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

        # Update active archive and configuration
        active_archive = request.json["archive"]
        active_configuration = request.json["configuration"]

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
    global active_volume

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
        except ValueError:
            return abort(404, {"message": f"Volume value must be a float."
                               f"Received: {request.json['volume']}"})

        # If all validations pass, update the active volume
        active_volume = validated_volume

    return {"volume": active_volume}

# Everything not declared before (not a Flask route / API endpoint)
# Static files needed by the frontend


@app.route("/<path:path>")
def route_frontend(path):
    file_path = os.path.join(app.static_folder, path)
    if os.path.isfile(file_path):
        return send_file(file_path)
    return abort(404)


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=False, port=5000)
