"""
playlist.py

Playlist management for Audio Player
"""

import os
import random

from config import (
    AUDIO_FOLDER,
    SUPPORTED_EXTENSIONS
)


class Playlist:

    def __init__(self):

        self.folder = AUDIO_FOLDER

        self.files = []

        self.current_index = -1

        #
        # Play Mode
        #
        # 0 -> Normal
        # 1 -> Repeat One
        # 2 -> Repeat All
        #

        self.play_mode = 0

        self.shuffle = False

        self.shuffle_order = []

    # ----------------------------------------------------

    def load(self):

        self.files = []

        if not os.path.exists(self.folder):

            return []

        for file in sorted(os.listdir(self.folder)):

            if file.lower().endswith(SUPPORTED_EXTENSIONS):

                self.files.append(file)

        self.current_index = -1

        self.generate_shuffle()

        return self.files

    # ----------------------------------------------------

    def generate_shuffle(self):

        self.shuffle_order = list(range(len(self.files)))

        random.shuffle(self.shuffle_order)

    # ----------------------------------------------------

    def set_folder(self, folder):

        self.folder = folder

        return self.load()

    # ----------------------------------------------------

    def current(self):

        if self.current_index < 0:

            return None

        if self.current_index >= len(self.files):

            return None

        return self.files[self.current_index]

    # ----------------------------------------------------

    def current_path(self):

        file = self.current()

        if file is None:

            return None

        return os.path.join(self.folder, file)

    # ----------------------------------------------------

    def select(self, filename):

        if filename not in self.files:

            return None

        self.current_index = self.files.index(filename)

        return self.current_path()

    # ----------------------------------------------------

    def next(self):

        if len(self.files) == 0:

            return None

        #
        # Repeat One
        #

        if self.play_mode == 1:

            return self.current_path()

        #
        # Shuffle
        #

        if self.shuffle:

            return self.next_shuffle()

        #
        # Normal
        #

        self.current_index += 1

        if self.current_index >= len(self.files):

            #
            # Repeat All
            #

            if self.play_mode == 2:

                self.current_index = 0

            else:

                self.current_index = len(self.files) - 1

                return None

        return self.current_path()

    # ----------------------------------------------------

    def previous(self):

        if len(self.files) == 0:

            return None

        if self.play_mode == 1:

            return self.current_path()

        if self.shuffle:

            return self.previous_shuffle()

        self.current_index -= 1

        if self.current_index < 0:

            if self.play_mode == 2:

                self.current_index = len(self.files) - 1

            else:

                self.current_index = 0

                return None

        return self.current_path()

    # ----------------------------------------------------

    def next_shuffle(self):

        if len(self.shuffle_order) == 0:

            return None

        if self.current_index == -1:

            self.current_index = self.shuffle_order[0]

            return self.current_path()

        position = self.shuffle_order.index(self.current_index)

        position += 1

        if position >= len(self.shuffle_order):

            if self.play_mode == 2:

                self.generate_shuffle()

                position = 0

            else:

                return None

        self.current_index = self.shuffle_order[position]

        return self.current_path()

    # ----------------------------------------------------

    def previous_shuffle(self):

        if len(self.shuffle_order) == 0:

            return None

        if self.current_index == -1:

            return None

        position = self.shuffle_order.index(self.current_index)

        position -= 1

        if position < 0:

            if self.play_mode == 2:

                position = len(self.shuffle_order) - 1

            else:

                return None

        self.current_index = self.shuffle_order[position]

        return self.current_path()

    # ----------------------------------------------------

    def first(self):

        if len(self.files) == 0:

            return None

        self.current_index = 0

        return self.current_path()

    # ----------------------------------------------------

    def last(self):

        if len(self.files) == 0:

            return None

        self.current_index = len(self.files) - 1

        return self.current_path()

    # ----------------------------------------------------

    def enable_shuffle(self):

        self.shuffle = True

        self.generate_shuffle()

    # ----------------------------------------------------

    def disable_shuffle(self):

        self.shuffle = False

    # ----------------------------------------------------

    def set_play_mode(self, mode):

        #
        # 0 Normal
        # 1 Repeat One
        # 2 Repeat All
        #

        self.play_mode = mode

    # ----------------------------------------------------

    def count(self):

        return len(self.files)

    # ----------------------------------------------------

    def get_all(self):

        return self.files

    # ----------------------------------------------------

    def info(self):

        return {

            "folder": self.folder,

            "files": self.files,

            "current": self.current(),

            "current_index": self.current_index,

            "count": len(self.files),

            "play_mode": self.play_mode,

            "shuffle": self.shuffle

        }


# ------------------------------------------------------------

if __name__ == "__main__":

    playlist = Playlist()

    playlist.load()

    print()

    print("Files")

    print("----------------")

    for file in playlist.get_all():

        print(file)

    print()

    print("Total :", playlist.count())

    print()

    print("First")

    print(playlist.first())

    print()

    print("Next")

    print(playlist.next())

    print()

    print("Previous")

    print(playlist.previous())

    print()

    print("Information")

    print(playlist.info())