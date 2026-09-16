#!/bin/bash
MEDIA_DEV="platform:1f00128000.csi"
v4l2-ctl -v width=1920,height=1080,pixelformat=RGGB

media-ctl -d "$MEDIA_DEV" --set-v4l2 '"imx219 11-0010":0[fmt:SRGGB8_1X8/1920x1080 field:none]'
media-ctl -d "$MEDIA_DEV" -V "'csi2':0 [fmt:SRGGB8_1X8/1920x1080 field:none]"
#media-ctl -d "$MEDIA_DEV" -V "'csi2':1 [fmt:SRGGB8_1X8/1920x1080 field:none]"
media-ctl -d "$MEDIA_DEV" -l "'csi2':1 -> 'rp1-cfe-csi2-ch0':0 [1]"

#media-ctl -p -d "$MEDIA_DEV"

v4l2-ctl -d /dev/v4l-subdev2 --set-ctrl=exposure=1600
v4l2-ctl -d /dev/v4l-subdev2 --set-ctrl=analogue_gain=100
v4l2-ctl -d /dev/v4l-subdev2 --set-ctrl=digital_gain=1900
