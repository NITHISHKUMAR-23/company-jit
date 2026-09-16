#!/bin/bash
 
MEDIA_DEV="platform:1f00110000.csi"
 
# Configure video node format
v4l2-ctl -v width=1920,height=1080,pixelformat=RGGB

media-ctl -d "$MEDIA_DEV" -V "'csi2':0 [fmt:SRGGB8_1X8/1920x1080 field:none]"
media-ctl -d "$MEDIA_DEV" -V "'csi2':1 [fmt:SRGGB8_1X8/1920x1080 field:none]"
sudo media-ctl -d "$MEDIA_DEV" -l "'csi2':1 -> 'rp1-cfe-csi2-ch0':0 [1]"
 
# Configure camera subdevice (IMX219)
media-ctl -d "$MEDIA_DEV" --set-v4l2 '"imx219 16-0010":0[fmt:SRGGB8_1X8/1920x1080 field:none]'
 
# Configure serializer (MAX96717)
media-ctl -d "$MEDIA_DEV" --set-v4l2 '"max96717 15-0040":1[fmt:SRGGB8_1X8/1920x1080 field:none]'
 
# Configure deserializer (MAX96724)
media-ctl -d "$MEDIA_DEV" --set-v4l2 '"max96724 10-0027":6[fmt:UYVY8_1X16/1920x1080 field:none]'


v4l2-ctl -d /dev/video0 --set-fmt-video width=1920,height=1080,pixelformat='RGGB'
