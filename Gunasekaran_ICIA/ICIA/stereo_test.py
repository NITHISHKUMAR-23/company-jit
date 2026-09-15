from pathlib import Path
import subprocess

AUDIO_DEV = "hw:3,0"
SAMPLE_RATE = "48000"

# Frame 1: Ch1=F8720000, Ch2=4E1F0000
# Frame 2: Ch1=00150000, Ch2=02000000
words = [
    "F8720000", "4E1F0000",
    "00150000", "02000000",
]

out = bytearray()

for h in words:
    word = int(h, 16)

    # Convert SHARC-style 32-bit word XXYYZZ00
    # to ALSA S24_LE bytes ZZ YY XX
    sample24 = (word >> 8) & 0xFFFFFF
    out += sample24.to_bytes(3, "little")

Path("stereo_test.raw").write_bytes(out)

subprocess.run([
    "aplay",
    "-D", AUDIO_DEV,
    "-t", "raw",
    "-f", "S24_LE",
    "-c", "2",
    "-r", SAMPLE_RATE,
    "stereo_test.raw"
], check=True)
