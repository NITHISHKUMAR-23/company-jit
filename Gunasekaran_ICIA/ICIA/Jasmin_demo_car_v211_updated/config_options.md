
# Configuration parameters for `config.json`

The `config.json` configuration file dictates the display of the frontend
application. It supports various parameters, all of which must be properly
configured before reloading the page.

- `car_model`: Displayed car model name.
- `title`: Main title displayed in the application.
- `subtitle`: Description under the title. Eg: "Channels: 16".
- `api_url`: API URL. Set to "/" if the app is on the same port as the API.
- `update_continuously`: Determines if the App should fetch the API
  continuously, enabling real-time frontend updates upon external changes.
- `update_continuously_time_ms`: The interval duration in milliseconds between
  each update, designed to be used in conjunction with the `update_continuously`
  option.
- `log_file`: Name of the log file downloaded when an error occurs.
- `images`: Image resources configuration.
  - `bird_view`: Path to the main upper view image (center).
  - `car_brand`: Path to the model car image (left).
  - `car_header`: Path to the header car image (right).
  - `car_header_style`: Style of the `car_header`. It accepts `"dark"` or `""`.
- `show_seats`: Determines seat selection display. It can take either a boolean
  value or a list of modes eg: `true` or `["modeFoo", "modeBar"]`.
- `seats_title`: Main title of the seats buttons group.
- `drive_seat_position_right`: Indicates whether the driver's seat is positioned
  on the right.
- `seats`: Names of seat buttons and as ID for `id_seat`.
- `seat_placeholders_positions`: Represents the relative positions of the seat display as
  percentages, organized in arrays of two values [`% from left`, `% from top`].
- `seat_placeholder_style`: Configuration for all seat placeholder indicators.
  - `width`
  - `height`
  - `border`
  - `background1Color`
  - `borderRadius`
- `tabs`: Defines various tabs within the application, each comprising a set of
  modes.
  - `name`: Name of the tab.
  - `modes`: List of modes in each tab.
    - `name`: Name of the mode and as ID for `id_mode`.
    - `description`: Description of the mode.
    - `subtitle` (optional): Replace the value of the global `subtitle` for
      this mode selection. Eg: "Channels: 8".
- `dar_file`: Name of the Dynamic Audio Reproduction (DAR) file.
- `gain`
  - `min`: The minimum gain value expressed in decibels (dB), which corresponds
    to `0` in the plain range within the DAR file.
  - `max`: The maximum gain value expressed in decibels (dB), which corresponds
    to `1` in the plain range within the DAR file.
- `dar_configs`: Array mapping modes and seats to DAR configurations.
  - `name`: DAR tuning configuration name.
  - `id_mode`: Mode ID to be set. It should match the `tabs/modes/name` values.
  - `id_seat`: Seat ID to be set. It should match the `seats` values.
