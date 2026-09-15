"""
kodi_controller.py

Handles all communication with Kodi using JSON-RPC.
"""

import os
import requests
from requests.auth import HTTPBasicAuth
from config import (
    KODI_URL,
    KODI_USERNAME,
    KODI_PASSWORD
)


class KodiController:

    def __init__(self):
        self.url = KODI_URL
        self.auth = HTTPBasicAuth(KODI_USERNAME, KODI_PASSWORD)

    # ---------------------------------------------------------
    # Generic JSON-RPC Call
    # ---------------------------------------------------------

    def rpc(self, method, params=None):

        payload = {
            "jsonrpc": "2.0",
            "method": method,
            "id": 1
        }

        if params:
            payload["params"] = params

        try:

            response = requests.post(
                self.url,
                json=payload,
                auth=self.auth,
                timeout=5
            )

            response.raise_for_status()

            return response.json()

        except Exception as e:

            print("Kodi Error :", e)

            return None

    # ---------------------------------------------------------
    # Ping Kodi
    # ---------------------------------------------------------

    def ping(self):

        response = self.rpc("JSONRPC.Version")

        return response is not None

    # ---------------------------------------------------------
    # Open File
    # ---------------------------------------------------------

    def play_file(self, full_path):

        params = {
            "item": {
                "file": full_path
            }
        }

        return self.rpc(
            "Player.Open",
            params
        )

    # ---------------------------------------------------------
    # Active Player
    # ---------------------------------------------------------

    def get_player_id(self):

        response = self.rpc(
            "Player.GetActivePlayers"
        )

        if not response:
            return None

        result = response.get("result", [])

        if len(result) == 0:
            return None

        return result[0]["playerid"]

    # ---------------------------------------------------------
    # Pause / Resume
    # ---------------------------------------------------------

    def play_pause(self):

        player = self.get_player_id()

        if player is None:
            return None

        return self.rpc(
            "Player.PlayPause",
            {
                "playerid": player
            }
        )

    # ---------------------------------------------------------
    # Stop
    # ---------------------------------------------------------

    def stop(self):

        player = self.get_player_id()

        if player is None:
            return None

        return self.rpc(
            "Player.Stop",
            {
                "playerid": player
            }
        )

    # ---------------------------------------------------------
    # Current Item
    # ---------------------------------------------------------

    def current_item(self):

        player = self.get_player_id()

        if player is None:
            return None

        response = self.rpc(
            "Player.GetItem",
            {
                "playerid": player,
                "properties": [
                    "title",
                    "file"
                ]
            }
        )

        return response

    # ---------------------------------------------------------
    # Playback Properties
    # ---------------------------------------------------------

    def properties(self):

        player = self.get_player_id()

        if player is None:
            return None

        response = self.rpc(
            "Player.GetProperties",
            {
                "playerid": player,
                "properties": [
                    "speed",
                    "time",
                    "totaltime",
                    "percentage"
                ]
            }
        )

        return response

    # ---------------------------------------------------------
    # Playback Status
    # ---------------------------------------------------------

    def status(self):

        player = self.get_player_id()

        if player is None:

            return {
                "state": "stopped"
            }

        prop = self.properties()

        if not prop:
            return {
                "state": "unknown"
            }

        result = prop["result"]

        state = "paused"

        if result["speed"] == 1:
            state = "playing"

        return {
            "state": state,
            "percentage": result["percentage"],
            "time": result["time"],
            "totaltime": result["totaltime"]
        }

    # ---------------------------------------------------------
    # Is Playing
    # ---------------------------------------------------------

    def is_playing(self):

        player = self.get_player_id()

        return player is not None

    # ---------------------------------------------------------
    # Get Current File
    # ---------------------------------------------------------

    def current_file(self):

        item = self.current_item()

        if not item:
            return None

        try:

            return item["result"]["item"]["file"]

        except:

            return None


if __name__ == "__main__":

    kodi = KodiController()

    print("Kodi Running :", kodi.ping())

    print("Status")

    print(kodi.status())

    print("Current File")

    print(kodi.current_file())