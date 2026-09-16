#!/bin/bash
# --- Camera Configuration Script for IMX219 / MAX967xx ---

echo "[INFO] Configuring camera subdevices..."

# Set basic format
v4l2-ctl -v width=640,height=480,pixelformat=RGGB

# Media-ctl configuration for sensor pipeline
media-ctl -d "platform:fe801000.csi" --set-v4l2 '"max96717:0 23-0040":0[fmt:SRGGB8_1X8/640x480 field:none]'
media-ctl -d "platform:fe801000.csi" --set-v4l2 '"max96724:0 10-0027":0[fmt:SRGGB8_1X8/640x480 field:none]'
media-ctl -d "platform:fe801000.csi" --set-v4l2 '"imx219 24-0010":0[fmt:SRGGB8_1X8/640x480 field:none]'

# Exposure and gain controls (tune as needed)
v4l2-ctl -d /dev/v4l-subdev2 --set-ctrl=exposure=2000
v4l2-ctl -d /dev/v4l-subdev2 --set-ctrl=analogue_gain=100
v4l2-ctl -d /dev/v4l-subdev2 --set-ctrl=digital_gain=1900

echo "[INFO] Camera configuration complete!"

