"""
player.py
---------
Lightweight MPV IPC controller + playlist manager for the EAC3 audio
player GUI.

WHY RAW JSON-IPC INSTEAD OF THE `python-mpv` PIP PACKAGE?
    python-mpv needs libmpv (a compiled .so) available on the system,
    which can be a pain to get installed on a Raspberry Pi. Talking
    directly to mpv's own --input-ipc-server unix socket needs nothing
    but the `mpv` binary + Python's stdlib (socket/json), so that's
    what this uses.

WHY MPV AT ALL?
    Your files are .eac3 (Dolby Digital Plus). Since audio leaves the
    RPi over HDMI and AVR8 does the actual decoding, the Pi must send
    the compressed bitstream through untouched ("passthrough") rather
    than decode it to PCM itself. mpv supports this natively via
    --audio-spdif=eac3, wrapping the compressed frames in IEC61937 so
    they go out over HDMI/ALSA as a recognizable bitstream instead of
    being (wrongly) played as noise.

mpv is started once, in --idle mode, and stays running for the life of
this Flask process. Tracks are loaded into it on demand via `loadfile`.
"""

import json
import os
import socket
import subprocess
import threading
import time
import random

MPV_SOCKET = "/tmp/mpv_eac3_socket"
MPV_BINARY = "mpv"

# ---------------------------------------------------------------------
# !!! EDIT THIS to match your RPi's actual HDMI ALSA device !!!
#
# ROOT CAUSE (found from your aplay -l + Kodi settings): card 0
# (vc4hdmi0) is the right card — it matches what Kodi uses and Kodi's
# passthrough to the ADV7625 works fine on it. The bug is the ALSA
# device *string*, not the card/cable.
#
# The Pi's vc4-hdmi driver is unusual: at the raw "hw:" level it only
# accepts the IEC958_SUBFRAME_LE wire format and nothing else — plain
# "hw:vc4hdmi0,0" fails format negotiation for both bitstream and
# ordinary PCM. Raspberry Pi OS ships /usr/share/alsa/cards/vc4-hdmi.conf
# specifically to work around this: it exposes an "iec958" ALSA PCM
# that does the subframe conversion for you. Kodi's audio engine goes
# through that layer internally, which is why Kodi works even though
# it's "the same card" — going straight at "hw:" the way this script
# was doing skips that layer entirely.
#
# Fix: point at the iec958 device instead of hw. Find your card name
# with `aplay -l`, e.g.:
#     card 0: vc4hdmi0 [vc4-hdmi-0], device 0: MAI PCM i2s-hifi-0
# -> becomes "alsa/iec958:CARD=vc4hdmi0,DEV=0" below.
# You can sanity-check this on the Pi first, outside the app:
#     speaker-test -c 2 -D iec958:CARD=vc4hdmi0,DEV=0 -t wav
# ---------------------------------------------------------------------
HDMI_AUDIO_DEVICE = "alsa/iec958:CARD=vc4hdmi0,DEV=0"

# EAC3/AC3/DTS are wrapped as compressed IEC61937 frames and sent
# bit-exact to AVR8 over HDMI ("bitstream passthrough") instead of
# being decoded to PCM on the Pi.
SPDIF_FORMATS = "ac3,eac3,dts"


class MPVController:
    def __init__(self, audio_device=HDMI_AUDIO_DEVICE, on_track_end=None):
        self.audio_device = audio_device
        self.on_track_end = on_track_end  # callback() fired on natural end-of-file
        self._proc = None
        self._sock = None
        self._lock = threading.Lock()          # guards socket writes + request_id counter
        self._event_thread = None
        self._running = False

        # ---- request/reply dispatch table ------------------------------
        # Only ONE thread (_reader_loop) ever calls socket.recv(). Every
        # get_property() call registers a request_id + threading.Event
        # here, then waits on it; the reader thread fills in the reply
        # and sets the event when a matching line arrives. This replaces
        # an earlier version where get_property() did its own recv() in
        # the calling thread AT THE SAME TIME as the background event
        # thread was also doing recv() on the same socket — whichever
        # thread's recv() happened to grab the bytes "won", so property
        # replies (position, duration, pause, idle-active) were
        # frequently swallowed by the event thread and silently
        # discarded, leaving get_property() to time out and fall back to
        # its default. That's what made the GUI's timestamp look frozen.
        self._next_id = 1
        self._pending = {}   # request_id -> reply dict (once arrived)
        self._waiters = {}   # request_id -> threading.Event

    # ---- lifecycle ----------------------------------------------------
    def start(self):
        if os.path.exists(MPV_SOCKET):
            try:
                os.remove(MPV_SOCKET)
            except OSError:
                pass

        cmd = [
            MPV_BINARY,
            "--idle=yes",
            "--no-video",
            "--no-terminal",
            "--input-ipc-server={}".format(MPV_SOCKET),
            "--ao=alsa",
	    "--audio-device=alsa/default",
            "--audio-spdif={}".format(SPDIF_FORMATS),
            "--volume=100",
            "--keep-open=no",
        ]
        # Previously both stdout/stderr went to DEVNULL, so mpv's own
        # errors (e.g. ALSA format/device failures) were invisible —
        # nothing showed up anywhere to explain a silent failure. Log
        # them to a file instead so `tail -f /tmp/mpv_eac3.log` (or
        # journalctl, if run under systemd) shows the real reason.
        self._log = open("/tmp/mpv_eac3.log", "a")
        self._proc = subprocess.Popen(cmd, stdout=self._log, stderr=self._log)

        deadline = time.time() + 8
        while time.time() < deadline and not os.path.exists(MPV_SOCKET):
            time.sleep(0.1)
        if not os.path.exists(MPV_SOCKET):
            raise RuntimeError(
                "mpv did not create its IPC socket in time. "
                "Is mpv installed? Try: sudo apt install mpv"
            )

        self._connect()
        self._running = True
        self._event_thread = threading.Thread(target=self._reader_loop, daemon=True)
        self._event_thread.start()

    def _connect(self):
        self._sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self._sock.connect(MPV_SOCKET)

    def stop_process(self):
        self._running = False
        try:
            self.send({"command": ["quit"]})
        except Exception:
            pass
        if self._proc:
            self._proc.terminate()

    # ---- low-level IPC --------------------------------------------------
    def send(self, payload):
        with self._lock:
            data = (json.dumps(payload) + "\n").encode("utf-8")
            self._sock.sendall(data)

    def get_property(self, name, default=None):
        print("Requesting property:", name)
        with self._lock:
            request_id = self._next_id
            print("Sending request:", request_id)
            self._next_id += 1
            event = threading.Event()
            self._waiters[request_id] = event
            try:
                req = {"command": ["get_property", name], "request_id": request_id}
                self._sock.sendall((json.dumps(req) + "\n").encode("utf-8"))
            except Exception:
                del self._waiters[request_id]
                return default

        got = event.wait(3)
        with self._lock:
            self._waiters.pop(request_id, None)
            msg = self._pending.pop(request_id, None)
        print("Message:", msg)
        if not got or msg is None:
            return default
        if msg.get("error") == "success":
            return msg.get("data", default)
        
        print("Received:", msg)
        return default

    # ---- single reader thread: dispatches events vs. property replies ---
    def _reader_loop(self):
        buf = b""
        self._sock.settimeout(1.0)
        while self._running:
            try:
                chunk = self._sock.recv(4096)
                if not chunk:
                    continue
                buf += chunk
                while b"\n" in buf:
                    line, buf = buf.split(b"\n", 1)
                    if not line.strip():
                        continue
                    try:
                        msg = json.loads(line.decode("utf-8", "ignore"))
                        print("MPV:", msg)
                    except ValueError:
                        continue

                    request_id = msg.get("request_id")
                    if request_id is not None and request_id in self._waiters:
                        with self._lock:
                            self._pending[request_id] = msg
                            waiter = self._waiters.get(request_id)
                        if waiter:
                            waiter.set()
                        continue

                    if msg.get("event") == "end-file" and msg.get("reason") == "eof":
                        if self.on_track_end:
                            self.on_track_end()
            except socket.timeout:
                continue
            except OSError:
                break

    # ---- playback commands ----------------------------------------------
    def load(self, filepath):
        self.send({"command": ["loadfile", filepath, "replace"]})
        time.sleep(0.3)

    def play(self):
        self.send({"command": ["set_property", "pause", False]})

    def pause(self):
        self.send({"command": ["set_property", "pause", True]})

    def toggle_pause(self):
        self.send({"command": ["cycle", "pause"]})

    def stop(self):
        self.send({"command": ["stop"]})

    def set_loop_file(self, enabled):
        self.send({"command": ["set_property", "loop-file", "inf" if enabled else "no"]})

    def is_paused(self):
        return bool(self.get_property("pause", True))

    def is_idle(self):
        # True when mpv has no file loaded — right after startup, after
        # Stop, or automatically at end-of-file (this app runs mpv with
        # --keep-open=no, so it drops back to idle as soon as a track
        # finishes). Toggling "pause" while idle is a no-op: there's
        # nothing to un-pause, so it silently keeps reporting
        # paused=True forever. Default True (safe: treat an unreachable
        # mpv as idle too) so callers reload rather than send a no-op.
        return bool(self.get_property("idle-active", True))

    def position(self):
        pos = self.get_property("playback-time", None)
        print("DEBUG playback-time =", pos)

        pos2 = self.get_property("time-pos", None)
        print("DEBUG time-pos =", pos2)

        return pos2 if pos2 is not None else (pos or 0)
        

    def duration(self):
        return self.get_property("duration", 0) or 0


class Playlist:
    """
    Tracks the ordered list of files + current index + repeat/shuffle
    state. Kept separate from MPVController so the transport logic
    (what "Next" means under shuffle/repeat) lives in one obvious place.
    """
    REPEAT_OFF, REPEAT_ONE, REPEAT_ALL = "off", "one", "all"

    def __init__(self):
        self.tracks = []   # filenames in library order
        self.order = []    # playback order (indices into self.tracks)
        self.pos = -1      # index into self.order
        self.repeat = self.REPEAT_OFF
        self.shuffle = False

    def set_tracks(self, tracks):
        current_file = self.current()
        self.tracks = list(tracks)
        self._rebuild_order(keep_current=current_file)

    def _rebuild_order(self, keep_current=None):
        self.order = list(range(len(self.tracks)))
        if self.shuffle:
            random.shuffle(self.order)
        if keep_current and keep_current in self.tracks:
            idx = self.tracks.index(keep_current)
            self.pos = self.order.index(idx)
        else:
            self.pos = -1

    def set_shuffle(self, enabled):
        self.shuffle = enabled
        self._rebuild_order(keep_current=self.current())

    def set_repeat(self, mode):
        if mode in (self.REPEAT_OFF, self.REPEAT_ONE, self.REPEAT_ALL):
            self.repeat = mode

    def current(self):
        if 0 <= self.pos < len(self.order):
            return self.tracks[self.order[self.pos]]
        return None

    def select(self, filename):
        if filename in self.tracks:
            idx = self.tracks.index(filename)
            self.pos = self.order.index(idx)
            return self.current()
        return None

    def next(self):
        if not self.order:
            return None
        if self.repeat == self.REPEAT_ONE:
            return self.current()
        if self.pos + 1 < len(self.order):
            self.pos += 1
            return self.current()
        if self.repeat == self.REPEAT_ALL:
            self.pos = 0
            if self.shuffle:
                random.shuffle(self.order)
            return self.current()
        return None  # end of playlist, nothing more to play

    def previous(self):
        if not self.order:
            return None
        if self.pos - 1 >= 0:
            self.pos -= 1
            return self.current()
        if self.repeat == self.REPEAT_ALL:
            self.pos = len(self.order) - 1
            return self.current()
        return self.current()
