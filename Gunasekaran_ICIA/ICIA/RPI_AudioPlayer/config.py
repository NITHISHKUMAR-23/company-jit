"""
config.py
---------
Persists user-editable settings (currently just the audio folder path)
to a small JSON file so they survive a Pi reboot / service restart.

Default matches the folder you described: /home/jasminuser/dolby
"""

import json
import os

CONFIG_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), "player_config.json")

DEFAULT_CONFIG = {
    "audio_dir": "/home/jasminuser/dolby",
}


def load_config():
    if os.path.exists(CONFIG_PATH):
        try:
            with open(CONFIG_PATH, "r") as f:
                data = json.load(f)
            cfg = dict(DEFAULT_CONFIG)
            cfg.update(data or {})
            return cfg
        except (ValueError, OSError):
            pass
    return dict(DEFAULT_CONFIG)


def save_config(cfg):
    tmp_path = CONFIG_PATH + ".tmp"
    with open(tmp_path, "w") as f:
        json.dump(cfg, f, indent=2)
    os.replace(tmp_path, CONFIG_PATH)


def get_audio_dir():
    return load_config().get("audio_dir", DEFAULT_CONFIG["audio_dir"])


def set_audio_dir(path):
    cfg = load_config()
    cfg["audio_dir"] = path
    save_config(cfg)
    return cfg
