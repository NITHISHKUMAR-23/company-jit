with open("force.raw", "wb") as f:
    for i in range(48000):
        f.write(bytes([0x72, 0xF8]))  # F872 (little-endian)
        f.write(bytes([0x1F, 0x4E]))  # 4E1F (little-endian)

exit()
