with open("known16.raw", "wb") as f:
    for i in range(48000):
        # Left = 0x1234
        f.write(bytes([0x34, 0x12]))

        # Right = 0x5678
        f.write(bytes([0x78, 0x56]))
