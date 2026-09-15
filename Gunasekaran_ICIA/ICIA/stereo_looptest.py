from pathlib import Path
import subprocess

AUDIO_DEV = "hw:3,0"
SAMPLE_RATE = "48000"

words = [
    0xF8720000,
    0x4E1F0000,
    0x00150000,
    0x02000000,
]

out = bytearray()

# Repeat pattern for long duration
for _ in range(48000 * 10):  # 10 seconds approx
    for word in words:
        sample24 = (word >> 8) & 0xFFFFFF
        out += sample24.to_bytes(3, "little")

Path("stereo_test.raw").write_bytes(out)

print("File size:", len(out), "bytes")

subprocess.run(
    [
        "aplay",
        "-D",
        AUDIO_DEV,
        "-t",
        "raw",
        "-f",
        "S24_LE",
        "-c",
        "2",
        "-r",
        SAMPLE_RATE,
        "stereo_test.raw",
    ],
    check=True,
)
