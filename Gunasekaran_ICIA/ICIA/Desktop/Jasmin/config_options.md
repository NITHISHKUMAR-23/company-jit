
# Configuration Parameters for `config.json`

The `config.json` file controls the frontend application's display. It supports
various parameters that must be correctly configured before reloading the page.

Users can choose different predefined `config.json` files by appending
`?demo=<NAME>` to the URL.

For example: `http://localhost/?config=generic.json`

- `car_model`: Name of the car model displayed.
- `title`: Main title shown in the application.
- `subtitle`: Description under the title, e.g., "Channels: 16".
- `api_url`: API URL. Set to "/" if the app and API share the same port.
- `update_continuously`: Enables real-time frontend updates by continuously
  fetching the API.
- `update_continuously_time_ms`: Interval duration in milliseconds between each
  update, used with `update_continuously`.
- `log_file`: Name of the log file downloaded when an error occurs.
- `images`: Configuration for image resources.
  - `bird_view`: Path to the main upper view image (center).
  - `car_brand`: Path to the car model image (left).
  - `car_header`: Path to the header car image (right).
- `show_seats`: Determines seat selection display. Can be a boolean or a list of
  modes, e.g., `true` or `["modeFoo", "modeBar"]`.
- `seats_title`: Main title for the seat buttons group.
- `drive_seat_position_right`: Indicates if the driver's seat is on the right.
- `seats`: Names of seat buttons and IDs for `id_seat`.
- `seat_placeholders_positions`: Relative positions of the seat display.
- `seats_title`: Main title of the seats buttons group.
- `drive_seat_position_right`: Indicates whether the driver's seat is positioned
  on the right.
- `seats`: Names of seat buttons and as ID for `id_seat`.
- `seat_placeholders_positions`: Represents the relative positions of the seat
  display as
- `style`: Configure the app's visuals, such as colors and sizes. If any
  arguments are omitted, default values will be used.
  - `base`: General settings applicable to the entire app.
    - `background_1`: Color of the furthest background layer. Default: #101113
    - `background_2`: Color of the second background layer. Default: #1C1C1C
    - `background_3`: Color of the third background layer. Default: #1E2024
    - `background_4`: Color of the fourth background layer. Default: #26292F
    - `outline_1`: Color of the outline for each box in the app. Default:
      #26292F
    - `outline_2`: Color of the outline for selected boxes. Default: #536CB2
    - `text_color_1`: Color for most text, except the master volume. Default:
      #FFFFFF
    - `text_color_2`: Color for the master volume box. Default: #FDD682
  - `images`: Style settings for the app's images.
    - `bird_view_filter`: Filter applied to the bird view image. Default:
      grayscale(100%)
    - `bird_view_background`: Color of the bird view filter. Default: #1E2024B3
    - `car_header`: Style of the `car_header`. Accepts `"dark"` or `""`.
  - `seat_placeholder`: Configuration for all seat placeholder indicators.
    - `width`: Default: 41px
    - `height`: Default: 27px
    - `border`: Default: 2px solid #536CB2
    - `background`: Default: rgba(51, 64, 85, .8)
    - `borderRadius`: Default: 8px
  - `modes`: Configuration for the mode option boxes.
    - `spacing`: Internal spacing between boxes. Default: 13px
    - `max_width`: Maximum width of each box. Default: 240px
    - `max_height`: Maximum height of each box. Default: 145px
    - `title_size`: Text size for titles. Default: 20px
    - `description_size`: Text size for descriptions. Default: 12px
    - `title_description_space`: Space between the title and the description.
      Default: 12px
  - `tabs`: Defines various tabs within the application, each comprising a set
    of modes.
  - `name`: Name of the tab.
  - `modes`: List of modes in each tab.
    - `name`: Name of the mode and as ID for `id_mode`.
    - `description`: Description of the mode.
    - `subtitle` (optional): Replace the value of the global `subtitle` for this
      mode selection. Eg: "Channels: 8".
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

# Beta features

## Proxy parameters

The following feature is under test and it is not recommended to be used in a
oficial demostrations.

For each dar configuraiton, you can add a field `parameters` with a list of IDs
that you would like to display for that configuraiton only. So the parameter
control will only be displayed for that combination only, and if that
configuration offers the proxy parameters. All values of the parameter available
in the `interface.json` are used in the app, like the title, max, min, step
values. So in the `config.json` you only add the `parameters` field for a
specific `dar_configs` member:

Example:

`"dar_configs": [ { "name": "audioiq-ds", "id_mode": "AudioIQ", "id_seat":
    "Driver seat", "parameters":[4, 5] }, `