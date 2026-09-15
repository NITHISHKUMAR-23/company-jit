# Demo App

The Demo App, developed using React, is a responsive web application designed to
grant users control over various audio settings, enabling them to tailor their
audio experience during the demo.

## Folder structure

```text
    .
    ├── test_api           // Optional dummy API to simulate backend interactions for the demo_app.
    ├── demo_app           // The Dirac Demo App, with the `index.html` that need to be served by the API.
    ├── README.md          // This document.
    └── release_notes.md   // Information about the changes, improvements, and bug fixes included in each release.
```

## Installation Instructions

1. Configure the API framework based on the integrated demo (see options below),
   then open the browser to access the `Dirac Demo App`.
2. Replace `dar` and `interface.json` with the desired files.
3. Modify `config.json` as needed, particularly updating the DAR names. Refer to
   the [configuration options document](config_options.md) for guidance on
   setting up `config.json`. One of the predefined demos in the `demos` folder
   can be used as a reference.
4. Delete any demo folders that are not relevant to the configured demo.
5. Refresh the page to apply and display the changes.

### API based on the python `test_api`

The `test_api` folder includes a sample API that demonstrates the expected
interaction between the backend and the frontend. It processes the
`generic.eval.interface.json` file to provide data consistent with the DAR file.

Since the API is built with Python, you must install Python and its
dependencies. You can achieve this by running:

```bash
python -m venv .env && source .env/Scripts/activate && pip install -r test_api/requirements.txt
```

Run the `test_api` and pointing to the `interface.json` where your demo is based
    on.

```bash
python test_api/main.py -c resources/generic.eval.interface.json
```

The API is now running at the port 80. Open the API docs in your browser.
[http://localhost:5000/docs](http://localhost:5000/docs)

### Custom API

Instruct the API to serve all files in the `demo_app` folder where `index.html`
is located.

### Audiosettings API

#### Basic Installation

1. Extract the contents of the `audiosettings.zip` file.
2. Navigate to `audiosettings/lib/native` and run the `diracaudiosettings.exe`
3. executable.
4. Open your browser and visit [http://localhost:8080/](http://localhost:8080/)
   to ensure there are no errors.

#### Custom Audio Settings Installation

1. Follow the setup guide provided in the [Audiosettings Demo Mode
   configuration](https://dirac.atlassian.net/wiki/spaces/DEV/pages/99386718/audiosettings+Demo-Mode+configuration)
   for application setup.
2. Access the `audiosettings/lib/native/demo-mode/demo_app` directory and copy
   the contents of the `demo_app.zip` release from [Box - Demo App
   Releases](https://dirac.ent.box.com/folder/220751262215).
3. Run the `diracaudiosettings.exe` executable located in the
   `audiosettings/lib/native` directory.
4. Open your browser and navigate to
   [http://localhost:8080/](http://localhost:8080/) to use the application.

#### Download AudioSettings

Download the latest Audio Settings App from one of the following options:

- [latest version
  artifactory](https://artifactory.dirac.services/artifactory/webapp/#/artifacts/browse/tree/General/audiosettings/update/develop)
- If you are unsure about the `dap_lambic` version, update
   `RT_Core_Audio_Processor_X.Y.Z.vst3`, downloading the file from the [latest
   github release build](https://github.com/diracrd/dap_lambic/deployments)

### Tuning ACS API

1. Obtain the latest tuning-acs package.
2. Follow the standard setup procedure for tuning-acs:
   1. Replace `dapctl_impl.dll` with the target implementation.
   2. Configure `config.json` for tuning-acs as needed.
3. Execute tuning-acs in standalone mode, pointing to the `demo_app` folder:

   ```bash
   acs.exe -c config.json -s dar_files_folder --rest-serve-folder demo_app_folder
   ```

4. The Dirac Demo App should now be running on the specified port.
   By default, it is accessible at:
      [http://localhost:8099/](http://localhost:8099/)

### Host the App independently of the API using Node.js

If you require to serve the App in a different port than the API, set the
`api_url` (port and url of the API) in the `config.json`.

To serve the App, you can use the [serve npm
package](https://www.npmjs.com/package/serve) as `serve -s demo_app`

## Configuration options for `config.json`

Kindly consult the [configuration options document](config_options.md) for
reference on how to set up the `config.json` file.

## Error Handling

### Critical Errors

Critical errors display a red full-screen message to alert users of app errors.

#### Critical Error Coverage

- No API connection
- Invalid or missing `config.json`
- API responds with errors (GET or PUT requests)

### Extended Errors

Extended errors include critical errors and additional warnings for potential
`config.json` configuration issues. To inspect extended errors:

1. Open your browser's console as per these
2. [instructions](https://balsamiq.com/support/faqs/browserconsole/) and reload
   the app.
3. Optionally, refresh the app to clear old messages (usually Shift + CTRL + R).

#### Extended Error Coverage

- Critical errors
- Presence of DAR file name in API data
- JSON configurations link to DAR archives
- DAR archives link to JSON configurations
- All seat/mode combinations map to a JSON configuration
