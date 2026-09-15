import subprocess

AUDIO_DEV = "hw:2,0"

samples = [
    0xF872,
    0x4E1F,
    0x0015,
    0x0200,
    0x0B77,
    0x00FF,
    0x3487,
    0xFFE1,
    0x0620,
    0x0000,
]

out = bytearray()

# Repeat continuously inside the buffer
for _ in range(10000):
    for sample in samples:
        out += sample.to_bytes(2, byteorder="little", signed=False)

while True:
    p = subprocess.Popen([
        "aplay",
        "-D", AUDIO_DEV,
        "-t", "raw",
        "-f", "S16_LE",
        "-c", "2",
        "-r", "48000"
    ], stdin=subprocess.PIPE)

    p.stdin.write(out)
    p.stdin.close()
    p.wait()
