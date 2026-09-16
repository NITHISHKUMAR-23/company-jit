#!/bin/bash

MEDIA_DEV="platform:1f00110000.csi"

media-ctl -d "$MEDIA_DEV" -r

media-ctl -d "$MEDIA_DEV" --set-route '"max96724 10-0027" [0/0 -> 6/0 [1], 1/0 -> 6/1 [1]]'
media-ctl -d "$MEDIA_DEV" --set-route '"csi2" [0/0 -> 1/0 [1], 0/1 -> 2/0 [1]]'

media-ctl -d "$MEDIA_DEV" --set-v4l2 '"imx219 17-0010":0[fmt:SRGGB10_1X10/1920x1080 field:none]'
media-ctl -d "$MEDIA_DEV" --set-v4l2 '"max96717 15-0040":1[fmt:SRGGB10_1X10/1920x1080 field:none]'
media-ctl -d "$MEDIA_DEV" --set-v4l2 '"max96724 10-0027":6/0[fmt:SRGGB10_1X10/1920x1080 field:none]'

media-ctl -d "$MEDIA_DEV" --set-v4l2 '"imx219 18-0010":0[fmt:SRGGB10_1X10/1920x1080 field:none]'
media-ctl -d "$MEDIA_DEV" --set-v4l2 '"max96717 16-0040":1[fmt:SRGGB10_1X10/1920x1080 field:none]'
media-ctl -d "$MEDIA_DEV" --set-v4l2 '"max96724 10-0027":6/1[fmt:SRGGB10_1X10/1920x1080 field:none]'

media-ctl -d "$MEDIA_DEV" -V "'csi2':0/0 [fmt:SRGGB10_1X10/1920x1080 field:none]"  # VC0
media-ctl -d "$MEDIA_DEV" -V "'csi2':0/1 [fmt:SRGGB10_1X10/1920x1080 field:none]"  # VC1

sudo media-ctl -d "$MEDIA_DEV" -l "'csi2':1 -> 'rp1-cfe-csi2-ch0':0 [1]"
sudo media-ctl -d "$MEDIA_DEV" -l "'csi2':2 -> 'rp1-cfe-csi2-ch1':0 [1]"
