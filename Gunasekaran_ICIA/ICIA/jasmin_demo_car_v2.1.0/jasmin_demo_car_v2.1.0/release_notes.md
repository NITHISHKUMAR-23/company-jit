# Release Notes

## Demo App v2.1.0

- Add configurability for dynamically setting app subtitle (channels) based on
  mode setting (backwards compatible).
- Fix item alignment for select mode (no line brakes).
- Increase space between the car "Master gain" box.
- Update of mode images and configurations.

## Demo App v2.0.1

- Fix master gain quantity box

## Demo App v2.0.0

- Support to render any variable quantity, name and description for:
  - `seats`
  - `modes`
  - `tabs`
- Fetch volume level from API when App is mounted for the first time.
- Improvements in state handling for `update_continuously`.
- Expanded support for `config.json` parameters
  - `title`
  - `seat_placeholder_style`
    - `width`
    - `height`
    - `border`
    - `background1Color`
    - `borderRadius`
  - `tabs`
  - `log_file`
  - `seats_title`
  - `seats`
    - `name`
    - `placeholders`
  - `images/car_header_style`
- Replace:
  - `channels` to `subtitle` to make it more generic.
  - `seat_positions` to `seat_placeholders_positions` for better description.
- Expand `show_seats`, so it can take a boolean value or a list of modes.
- Remove: `drive_seat_position_right` since it is configurable from `seats`.
- Error handling:
  - Add API status
  - Add `log_file` to `config.json` which allows the user to download the logs
  and error messages.
  - Add `Download log file`
  - Add `Download config.json`

## Demo App v1.0.0

- Updates to hardcoded text strings:
  - `Channels` to `Channels:`
  - `Automative` to `Automotive`
- Expanded support for `config.json` parameters:
  - `drive_seat_position_right`
  - `seat_placeholders`
- Fetch current configuration when page mounts the first time.
- Enhance the handling of the `update_continuously` feature.
- Enlarge the dimensions of the gain text box.
- Reduce dimensions of the error message and show the app in the background.

## Demo App v0.1.0

- Expanded support for `config.json` parameters:
  - `api_url`
  - `show_seats`
  - `images`
  - `seats`
  - `car_model`
  - `channels`
  - `dar_file`
  - `update_continuously`
  - `gain`
- Added support for adjusting `volume` settings.
- Extended error message coverage now alerts for:
  - Presence of DAR file name in API data.
  - JSON configurations linking to DAR archives.
  - DAR archives linking back to JSON configurations.
  - Ensuring all seat/mode combinations map to a JSON configuration.
- Resolved `svg` icon issues by switching them to `png` format.

## Demo App v0.0.0

This marks the initial version of the App.

- Introduced a basic dummy API for testing purposes.
- Enabled communication with the API to configure modes and seats.
- Established basic mapping in `config.json` (`dar_configs`).
- Implemented critical error messages for both production and development modes.
- Introduced extended error messages for detecting invalid `dar_configs` mapping.
