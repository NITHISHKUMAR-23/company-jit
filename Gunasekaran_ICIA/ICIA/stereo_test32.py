from pathlib import Path
import subprocess

AUDIO_DEV = "hw:3,0"
SAMPLE_RATE = "48000"

# Frame 1: Ch1 = F8720000, Ch2 = 4E1F0000
# Frame 2: Ch1 = 00150000, Ch2 = 02000000
words = [
    0xF8720000, 0x4E1F0000,
    0x00150000, 0x02000000,
]

out = bytearray()

# Repeat pattern for long playback
for _ in range(48000 * 10):
    for word in words:
        sample24 = (word >> 8) & 0xFFFFFF

        # S24_LE: 24-bit sample in 32-bit little-endian container
        out += bytes([
            sample24 & 0xFF,
            (sample24 >> 8) & 0xFF,
            (sample24 >> 16) & 0xFF,
            0xFF if (sample24 & 0x800000) else 0x00,
        ])

Path("stereo_test32.raw").write_bytes(out)

print("Generated stereo_test32.raw")
print("Size:", len(out), "bytes")

subprocess.run([
    "aplay",
    "-D", AUDIO_DEV,
    "-t", "raw",
    "-f", "S24_LE",
    "-c", "2",
    "-r", SAMPLE_RATE,
    "stereo_test32.raw",
], check=True)
