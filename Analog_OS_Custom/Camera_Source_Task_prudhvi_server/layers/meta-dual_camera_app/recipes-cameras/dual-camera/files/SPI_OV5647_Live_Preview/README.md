# Raspberry Pi – Dual Camera Live Preview (OV5642 Arducam SPI & OV5647 Omnivision CSI)

## Overview

This project provides a simple SDL-based live preview application for **two camera types** on Raspberry Pi:

1. **Arducam Mini OV5642 (SPI interface)**  
   - Communicates over SPI + I²C  
   - Captures JPEG frames, decoded to RGB, displayed with SDL2  

2. **Raspberry Pi Camera Module OV5647 (CSI interface – Omnivision)**  
   - Connects via CSI ribbon cable  
   - Uses Raspberry Pi camera stack (libcamera) 
   - Provides live preview through SDL2  

Both cameras are supported in a **single preview application**, showing their outputs together in one window.

---

## Features

- Support for **OV5642 (SPI)** and **OV5647 (CSI)**  
- **Single SDL2 preview window** with both camera streams  
- Optimized SPI transfer for OV5642 to improve frame rate  
- Direct OV5647 capture using Raspberry Pi camera interface  
- Example code for live preview without saving frames  

---

## Hardware Connections

### 1. Arducam Mini OV5642 (SPI + I²C)

#### Chip Select (CS) Pin (BCM GPIO)
```c
#define CAM_CS1    17

I²C Pins

#define sda_port   2   // SDA
#define scl_port   3   // SCL

SPI Pins
(Default SPI0 interface on Raspberry Pi)


MISO → GPIO 9  
MOSI → GPIO 10  
SCLK → GPIO 11  

2. Raspberry Pi Camera Module OV5647 (CSI)
Connects directly to the CSI ribbon connector on Raspberry Pi

No extra wiring required

Must be enabled in Raspberry Pi config (libcamera stack or Unicam support)

Platform Configuration (bcm283x_board_driver.h)
These defines are used to set up memory-mapped peripherals:

For Raspberry Pi 1:

#define BCM2835_PERI_BASE   0x20000000
For Raspberry Pi 2 / 3:

#define BCM2835_PERI_BASE   0x3F000000
For Raspberry Pi 4:

#define BCM2835_PERI_BASE   0xFE000000
⚠️ Set the correct base address for your board.

Build and Run
Clone the repository and compile:


git clone https://github.com/ArduCAM/RaspberryPi.git

cd RasDual_Camera_on_RPI/SPI_OV5647_Live_Preview
make -f Makefile_combined
Run the live preview demo:

./ArducamSDL_Live_combined

This will:

Initialize the Arducam OV5642 (SPI)

Initialize the Raspberry Pi OV5647 (CSI)

Open a single SDL2 window with both live previews.