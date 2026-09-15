import re
import subprocess
from pathlib import Path

DAT_FILE = "/home/jasminuser/Downloads/hdmi_input.dat"
AUDIO_DEV = "hw:2,0"

text = Path(DAT_FILE).read_text(errors="ignore")
words = re.findall(r"\b[0-9A-Fa-f]{8}\b", text)

samples = []
for w in words:
    value32 = int(w, 16)
    sample16 = (value32 >> 16) & 0xFFFF
    samples.append(sample16)

print("Words found:", len(words))
print("First 10 samples:")
for s in samples[:10]:
    print(f"{s:04X}")

out = bytearray()

# Repeat full file continuously inside buffer
for _ in range(1000):
    for s in samples:
        out += s.to_bytes(2, byteorder="little", signed=False)

while True:
    p = subprocess.Popen([
        "aplay",
        "-D", AUDIO_DEV,
        "-t", "raw",
        "-f", "S16_LE",
        "-c", "2",
        "-r", "192000"
    ], stdin=subprocess.PIPE)

    p.stdin.write(out)
    p.stdin.close()
    p.wait()
