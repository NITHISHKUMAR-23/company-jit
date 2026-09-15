"""
kodi_controller.py

Handles all communication with Kodi using JSON-RPC.
"""

import os
import time
import logging
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
        #
        # Cached Information
        #

        self.connected = False

        self.player_id = None

        self.retry_count = 3

        self.retry_delay = 1

        self.last_rpc_time = 0

        self.version = None
        self.last_ping = 0

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

        for attempt in range(self.retry_count):

            try:

                response = requests.post(

                    self.url,

                    json=payload,

                    auth=self.auth,

                    timeout=5

                )

                response.raise_for_status()

                self.connected = True

                self.last_rpc_time = time.time()

                return response.json()

            except Exception as ex:

                logging.warning(
                    "RPC Retry %d/%d : %s",
                    attempt + 1,
                    self.retry_count,
                    ex
                )
                logging.error("RPC Failed : %s", method)
                self.connected = False

                time.sleep(self.retry_delay)

        return None

    # ---------------------------------------------------------
    # Ping Kodi
    # ---------------------------------------------------------

    def ping(self):

        #
        # Use cached value for 3 seconds
        #

        if time.time() - self.last_ping < 3:
            return self.connected

        response = self.rpc("JSONRPC.Version")

        self.last_ping = time.time()

        self.connected = response is not None

        return self.connected

    # ---------------------------------------------------------
    # Open File
    # ---------------------------------------------------------

    def play_file(self, full_path):

        params = {
            "item": {
                "file": full_path
            }
        }
        response = self.rpc(
            "Player.Open",
            params
        )

        if response:
            self.clear_player_cache()

            logging.info("Kodi Play : %s", full_path)

        return response

    # ---------------------------------------------------------
    # Active Player
    # ---------------------------------------------------------

    def get_player_id(self):

        #
        # Return cached player
        #

        if self.player_id is not None:
            return self.player_id

        response = self.rpc("Player.GetActivePlayers")

        if not response:
            return None

        result = response.get("result", [])

        if len(result) == 0:
            return None

        self.player_id = result[0]["playerid"]

        return self.player_id

    # ---------------------------------------------------------
    # Pause / Resume
    # ---------------------------------------------------------

    def play_pause(self):

        player = self.get_player_id()

        if player is None:
            return None

        response = self.rpc(
            "Player.PlayPause",
            {
                "playerid": player
            }
        )

        logging.info("Kodi Pause / Resume")

        return response

    # ---------------------------------------------------------
    # Stop
    # ---------------------------------------------------------

    def stop(self):

        player = self.get_player_id()

        if player is None:
            return None

        response = self.rpc(
            "Player.Stop",
            {
                "playerid": player
            }
        )

        self.clear_player_cache()

        logging.info("Kodi Stop")

        return response

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


        except Exception as ex:

            logging.error(ex)

            return None

    def clear_player_cache(self):

        self.player_id = None

    def is_paused(self):

        status = self.status()

        return status.get("state") == "paused"

    def is_stopped(self):

        status = self.status()

        return status.get("state") == "stopped"

    def playback_finished(self):

        if not self.is_stopped():
            return False

        player = self.get_player_id()

        if player is None:
            return True

        return False

    def kodi_version(self):

        if self.version:
            return self.version

        response = self.rpc("JSONRPC.Version")

        if not response:
            return None

        version = response.get("result", {}).get("version", {})

        self.version = "{}.{}".format(

            version.get("major", 0),

            version.get("minor", 0)

        )

        return self.version

    def get_system_info(self):

        return {

            "connected": self.connected,

            "player_id": self.player_id,

            "kodi_version": self.kodi_version(),

            "last_rpc": self.last_rpc_time

        }


if __name__ == "__main__":
    kodi = KodiController()

    print("Kodi Running :", kodi.ping())

    print("Status")

    print(kodi.status())

    print("Current File")

    print(kodi.current_file())
