from pathlib import Path
import subprocess

out = bytearray()

# Ch1 = 0x7FFF, Ch2 = 0x8000 repeating
for _ in range(48000 * 10):
    out += (0x7FFF).to_bytes(2, "little", signed=False)
    out += (0x8000).to_bytes(2, "little", signed=False)

Path("s16_toggle.raw").write_bytes(out)

subprocess.run([
    "aplay",
    "-D", "hw:3,0",
    "-t", "raw",
    "-f", "S16_LE",
    "-c", "2",
    "-r", "48000",
    "s16_toggle.raw",
], check=True)
