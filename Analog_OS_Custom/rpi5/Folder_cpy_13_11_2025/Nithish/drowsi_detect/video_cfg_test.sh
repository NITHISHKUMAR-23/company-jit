#!/bin/bash

MEDIA_DEV="platform:1f00110000.csi"

media-ctl -d "$MEDIA_DEV" -r

v4l2-ctl -v width=1920,height=1080,pixelformat=RGGB
media-ctl -d "$MEDIA_DEV" --set-route '"max96724 10-0027" [0/0 -> 6/0 [0x01], 1/0 -> 6/1 [0x01]]'

media-ctl -d "$MEDIA_DEV" --set-route '"csi2" [0/0 -> 1/0 [0x01], 0/1 -> 2/0 [0x00]]'

media-ctl -d "$MEDIA_DEV" --set-v4l2 '"imx219 17-0010":0[fmt:SRGGB8_1X8/1920x1080 field:none]'
media-ctl -d "$MEDIA_DEV" --set-v4l2 '"max96717 15-0040":1[fmt:SRGGB8_1X8/1920x1080 field:none]'
media-ctl -d "$MEDIA_DEV" --set-v4l2 '"max96724 10-0027":6[fmt:UYVY8_1X16/1920x1080 field:none]'

media-ctl -d "$MEDIA_DEV" --set-v4l2 '"imx219 18-0010":0[fmt:SRGGB8_1X8/1920x1080 field:none]'
media-ctl -d "$MEDIA_DEV" --set-v4l2 '"max96717 16-0040":1[fmt:SRGGB8_1X8/1920x1080 field:none]'
media-ctl -d "$MEDIA_DEV" --set-v4l2 '"max96724 10-0027":6[fmt:UYVY8_1X16/1920x1080 field:none]'



media-ctl -d "$MEDIA_DEV" -V "'csi2':0 [fmt:SRGGB8_1X8/1920x1080 field:none]"
media-ctl -d "$MEDIA_DEV" -V "'csi2':1 [fmt:SRGGB8_1X8/1920x1080 field:none]"



sudo media-ctl -d "$MEDIA_DEV" -l "'csi2':1 -> 'rp1-cfe-csi2-ch0':0 [1]"
sudo media-ctl -d "$MEDIA_DEV" -l "'csi2':2 -> 'rp1-cfe-csi2-ch1':0 [0]"

v4l2-ctl -d /dev/v4l-subdev5 --set-ctrl=exposure=1600
v4l2-ctl -d /dev/v4l-subdev5 --set-ctrl=analogue_gain=100
v4l2-ctl -d /dev/v4l-subdev5 --set-ctrl=digital_gain=1900

#media-ctl -p -d "$MEDIA_DEV"
