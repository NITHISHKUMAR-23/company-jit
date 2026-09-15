import re
from pathlib import Path

DAT_FILE = "/home/jasminuser/Downloads/Pump.dat"

text = Path(DAT_FILE).read_text(errors="ignore")
words = re.findall(r"\b[0-9A-Fa-f]{8}\b", text)

print("Words found:", len(words))
print("First 10 DAT words:", words[:10])

out = bytearray()

for w in words:
    value32 = int(w, 16)

    # Take upper 16 bits: F8720000 -> F872
    sample16 = (value32 >> 16) & 0xFFFF

    out += sample16.to_bytes(2, byteorder="little", signed=False)

Path("pump16.raw").write_bytes(out)

print("Generated pump16.raw bytes:", len(out))

print("First 10 samples written:")
for i in range(0, min(20, len(out)), 2):
    print(f"{out[i+1]:02X}{out[i]:02X}")
