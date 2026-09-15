import re
import subprocess
import time
from pathlib import Path

DAT_FILE = "/home/jasminuser/Downloads/Pump.dat"
AUDIO_DEV = "hw:2,0"
SAMPLE_RATE = "48000"

text = Path(DAT_FILE).read_text(errors="ignore")
words = re.findall(r"\b[0-9A-Fa-f]{8}\b", text)

if not words:
    raise RuntimeError("No 32-bit hex words found in DAT file")

out = bytearray()

for w in words:
    value32 = int(w, 16)
    sample16 = (value32 >> 16) & 0xFFFF
    out += sample16.to_bytes(2, byteorder="little", signed=False)

print(f"Loaded {len(words)} words")
print(f"Generated {len(out)} bytes")

print("First 20 output samples:")
for i in range(0, min(40, len(out)), 2):
    print(f"{out[i + 1]:02X}{out[i]:02X}")

while True:
    p = subprocess.Popen([
        "aplay",
        "-D", AUDIO_DEV,
        "-t", "raw",
        "-f", "S16_LE",
        "-c", "2",
        "-r", SAMPLE_RATE
    ], stdin=subprocess.PIPE)

    p.stdin.write(out)
    p.stdin.close()
    p.wait()
    time.sleep(0.05)
