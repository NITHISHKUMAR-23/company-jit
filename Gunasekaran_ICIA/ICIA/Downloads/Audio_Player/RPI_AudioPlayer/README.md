# EAC3 Audio Player GUI (RPi → AVR8 → AVR9 → Output)

A standalone web GUI (separate from your existing AVR9 UART-command
GUI on port 5500) that lets you play `.eac3` files from an iPad
browser. The RPi streams the file to `mpv`, which sends the audio out
over **HDMI as a compressed bitstream** ("passthrough") — AVR8 does
the actual EAC3 decoding downstream. The RPi itself never decodes to
PCM.

## 1. Install on the RPi

```bash
sudo apt update
sudo apt install -y mpv python3-pip
cd RPI_AudioPlayer
pip3 install -r requirements.txt
```

## 2. Find your HDMI ALSA device name

```bash
aplay -l
```

Look for the HDMI output card, e.g.:

```
card 0: vc4hdmi0 [vc4-hdmi-0], device 0: MAI PCM i2s-hifi-0
```

Open `player.py` and set:

```python
HDMI_AUDIO_DEVICE = "alsa/hw:vc4hdmi0,0"   # <- match what aplay -l showed you
```

If your Pi has two HDMI outputs (Pi 4/5), make sure you pick the one
actually wired to AVR8 (could be `vc4hdmi0` or `vc4hdmi1`).

> **Passthrough note:** For EAC3 bitstream passthrough to work over
> HDMI, AVR8 must advertise EAC3 support in its EDID, and the Pi's
> HDMI audio config needs to be in a mode that doesn't force
> stereo/PCM-only. If audio comes out as silence or noise instead of
> clean sound, that's the first place to check — not the Flask app.
> Since your colleague already validated playback with this hardware
> chain, their known-good `mpv`/ALSA settings (if different from the
> defaults here) should be dropped into `player.py`.

## 3. Run

```bash
python3 main.py
```

The GUI is served at `http://<RPi-IP>:5600` — open that from Safari
on the iPad (same Wi-Fi network as the RPi, same idea as your existing
AVR9 command GUI on port 5500).

## 4. Using it

- **Upload**: tap "+ Upload .eac3 file to RPi", pick a file from the
  iPad's Files app — it's saved into `static/audio/` on the Pi and
  shows up in the list immediately.
- **Tap a track** in the list to play it directly.
- **Transport row**: Previous / Play-Pause / Next / Stop.
- **Repeat**: tap to cycle Off → All → One → Off.
- **Shuffle**: tap to toggle on/off.
- The equalizer bars animate while something is playing — this is a
  **decorative animation**, not a live level meter. Because audio
  leaves the Pi as an untouched EAC3 bitstream (for AVR8 to decode),
  there's no PCM signal on the Pi side to measure real levels from.

## Files

```
RPI_AudioPlayer/
├── main.py              # Flask app + REST endpoints (port 5600)
├── player.py            # mpv IPC controller + playlist/repeat/shuffle logic
├── requirements.txt
├── templates/
│   └── index.html       # GUI page
└── static/
    ├── style/player.css
    └── audio/           # uploaded .eac3 files land here
```

## Running alongside the existing AVR9 command GUI

This app is fully independent — different Flask process, different
port (5600 vs 5500), no shared code, and it never touches the UART
serial port. You can run both with something like:

```bash
# terminal / service 1 — existing AVR9 command GUI
cd RPI_UART_AVR9 && python3 main.py

# terminal / service 2 — this new audio player GUI
cd RPI_AudioPlayer && python3 main.py
```

For production use on the Pi, wrap each in its own `systemd` service
so they start on boot and restart if they crash — happy to write those
unit files if you want them.
