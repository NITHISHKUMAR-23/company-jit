# Demo App

The Demo App, developed using React, is a responsive web application designed to
grant users control over various audio settings, enabling them to tailor their
audio experience during the demo.

The `test_api` folder contains an optional dummy API that illustrates how the
API is expected to work in connection with the frontend. It retrieves hardcoded
data aligned with the provided dar file `Dummy_For_DemoApp.eval.dar`.

## Installation Instructions

### Run with the `test_api`

Install python and setup the environment
    ```
        python -m venv .env &&
        source .env/Scripts/activate &&
        pip install -r test_api/requirements.txt
    ```

Run the `test_api`
    ```
        python test_api/main.py
    ```

The API is now running at the port 80. Open the API docs in your browser.
[http://localhost:5000/docs](http://localhost:5000/docs)

### Run with final API

Instruct the API to serve all files in the `demo_app` folder where `index.html`
is located.

### Optional: Host the App independently of the API using Node.js

If you require to serve the App in a different port than the API, set the
`api_url` (port and url of the API) in the `config.json`.

To serve the App, you can use the
[serve npm package](https://www.npmjs.com/package/serve) as `serve -s demo_app`

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
