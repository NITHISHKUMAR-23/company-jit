with open("known24.raw", "wb") as f:
    for i in range(48000):
        # Left = 0x112233
        f.write(bytes([0x33, 0x22, 0x11]))

        # Right = 0x445566
        f.write(bytes([0x66, 0x55, 0x44]))
