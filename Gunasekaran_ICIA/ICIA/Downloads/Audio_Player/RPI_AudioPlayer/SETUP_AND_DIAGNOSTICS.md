# Setup & "no digital output" diagnostics

## What changed in this revision
- Tracks are now read live from a real folder on the Pi (default
  `/home/jasminuser/dolby`), not from an upload folder. Nothing is
  ever uploaded from the iPad.
- The folder path is editable from the GUI: tap the gear icon next
  to the path shown at the top of the player card, type a new
  absolute path, tap **Save**. It's stored in `player_config.json`
  next to `main.py`, so it survives a reboot.
- If the configured folder doesn't exist or isn't readable, the
  track list shows the exact error instead of silently showing
  nothing.

## 1. Install once
```bash
cd /home/jasminuser/RPI_AudioPlayer
python3 -m venv venv        # optional but recommended
source venv/bin/activate    # if you made a venv
pip install -r requirements.txt
sudo apt install mpv        # if not already installed
```

## 2. Find your real HDMI ALSA device name
`player.py` has this near the top:
```python
HDMI_AUDIO_DEVICE = "alsa/hw:vc4hdmi0,0"
```
This is almost certainly why you're getting **no output at all** —
if this string doesn't match your Pi's actual card, mpv opens
silently (or errors, depending on version) and nothing reaches AVR8.

On the Pi itself, run:
```bash
aplay -l
```
Look for the HDMI-out card, e.g.:
```
card 0: vc4hdmi0 [vc4-hdmi-0], device 0: MAI PCM i2s-hifi-0
```
That becomes `alsa/hw:vc4hdmi0,0`. If your Pi has two HDMI ports
(Pi 4/400/5), check whether you're plugged into HDMI0 or HDMI1 —
`vc4hdmi0` vs `vc4hdmi1`. Update `HDMI_AUDIO_DEVICE` in `player.py`
to match, save, restart the app.

## 3. Isolate the problem: Pi-side vs downstream hardware
Work outward from the Pi one link at a time — don't debug the whole
chain at once.

**a) Does mpv even open the device?**
```bash
mpv --no-video --ao=alsa --audio-device=alsa/hw:vc4hdmi0,0 \
    --audio-spdif=ac3,eac3,dts /home/jasminuser/dolby/<somefile>.eac3
```
Run this directly on the Pi (SSH is fine — it doesn't need a
monitor). Watch the terminal output for errors. If it errors here,
the problem is 100% Pi-side (wrong device name, mpv build without
spdif support, or file path/permission issue) — nothing to do with
Kodi, the GUI, or AVR9/AVR8 yet.

**b) Is the bitstream actually leaving the HDMI port?**
Some AVRs show the incoming format on their front display or app
(e.g. "Dolby Digital Plus" vs "PCM 2.0"). Check AVR9's HDMI input
display when the command above is running. If AVR9 shows PCM or
nothing, the Pi is either not sending compressed audio or HDMI audio
output is disabled somewhere in `raspi-config` /
`/boot/config.txt` (`hdmi_drive=2`, and confirm `dtoverlay` isn't
disabling audio on that port).

**c) AVR9 → AVR8 link**
Since this hop is wired connections between two boards rather than a
standard consumer HDMI/optical run, confirm with whoever built that
link what format it expects out of AVR9 (I2S? S/PDIF passthrough
re-encoded?) — a working HDMI bitstream into AVR9 can still produce
silence at AVR8 if that inter-board link expects something different
from what AVR9 is outputting.

**d) ADAU1466Z (Sigma) digital output**
Confirm in SigmaStudio (or whatever's loaded on the ADAU1466Z) that
the input routing/sample-rate settings match what AVR9 is actually
sending it — this is a common silent-output cause independent of
anything upstream being correct.

Doing (a)–(d) in order tells you which single hop is actually broken,
rather than re-testing the whole chain each time.

## 4. Autostart on boot — headless, no password prompt
This is the fix for the systemd/Kodi password issue you hit: that
happened because a boot-time service can't attach to a desktop login
session. This app doesn't need one, so it doesn't hit that wall.

```bash
sudo cp eac3-player.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable eac3-player.service
sudo systemctl start eac3-player.service
```

Before enabling, check `jasminuser`'s actual UID and fix the
`XDG_RUNTIME_DIR` line in the service file if it isn't 1000:
```bash
id -u jasminuser
```

Check it came up clean:
```bash
sudo systemctl status eac3-player.service
journalctl -u eac3-player.service -f
```

No monitor, no login, no Kodi, no password prompt — the iPad just
opens `http://<pi-ip>:5600` after boot.
