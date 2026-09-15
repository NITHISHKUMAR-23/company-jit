with open("known24.raw", "wb") as f:
    for i in range(48000):
        # Left = F87200
        f.write(bytes([0x00, 0x72, 0xF8]))

        # Right = 4E1F00
        f.write(bytes([0x00, 0x1F, 0x4E]))
