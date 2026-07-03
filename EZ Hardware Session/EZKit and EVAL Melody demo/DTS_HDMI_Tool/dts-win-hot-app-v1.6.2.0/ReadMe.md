
# DTS HDMI Output Tool

Change Log

v1.6.2
Fix bug in Coreless DS streams transmission.


>DTS HDMI Output Tool allows streaming of all DTS bitstream types over HDMI on Windows Platform
System 

>Tested on Windows 10 PC.

1. Copy the license file 'dts-hdmi-player.lic' into the same directory as the executable
2. Running dts-hot-app.exe at Windows command prompt will display the following

````
************************* DTS HDMI Output Tool ********************************
  Copyright 2001-2023 DTS, Inc
  Version: 1.6.2.0
*******************************************************************************
[ error ] [dts-hot-player-app.cpp][PlayerApp::dtsParseCommandLine][242] No Input Specified
[ error ] [dts-hot-player-app.cpp][PlayerApp::dtsParseCommandLine][249] Endpoint Not chosen, choose from following Endpoints
Endpoint 0: Speakers (Realtek(R) Audio)

Usage: hdmi-output-tool-cli [Options] [Files]
Options:
       -D, --device                        : Audio device, such as '1'
       -T  --transport <1:Type4, 2:HBR>    : Forced to change the audio transport type to Type4 or HBR.
       -h, --help                          : Show this help.
       -L, --loop                          : Loops playback <number> times. 0 means forever.
       -l, --list-devices                  : List audio devices.
       -u, --unaligned-syncword            : Allow unaligned syncword (default requires DWORD alignment)
       -v, --verbose                       : Verbose mode.
       -w, --wavfile                       : Must use this otpion if the input stream is WAV file
       --dummy-device <output.dat>         : Writes output to specified file
       -bp, --buffer-packet                : Buffers <number> of packets initially to reduce overhead during playback Default: 10, Max: 1000

`````
>>Windows HDMI Output Tool will not work unless a DTS stream type supporting Endpoint can be found.

>>Windows HDMI Output Tool will not work unless a valid DTS license keyfile is detected
---

3. To pass a DTS:X bitstream (an example file UBD1-ChID-4824-639k-80fhrh-CPM200.dtshd is present in the dts-hot-app.exe folder), please use the following command:

```` 
C:\>dts-hot-app.exe -D 1 22-9624-chid-96-1509k-51.dtshd
````
The following Output can be observerd during a successful playback

````
************************* DTS HDMI Output Tool ********************************
  Copyright 2001-2023 DTS, Inc
  Version: 1.6.2.0
*******************************************************************************
[ info ] [dts-hot-security.cpp][DtsSecurity::DTS_HOT_SAPI_InstallLicense][99] Valid License file dts-hdmi-player.lic found : Success.

 Stream Type                  : DTS 96/24
 Representation Type          : 0 ( NONE )
 Sampling Rate                : 96000
 Frame Duration               : 1024 samples
 Core Substream               : Yes
 List Of Core Substream       : |
 Extension Substream          : No

Supported Formats by Sink Device
KSDATAFORMAT_SUBTYPE_IEC61937_DTS
Channel counts supported      :2 6 8
Sample Rates supported        :44100 48000 88200 96000

KSDATAFORMAT_SUBTYPE_IEC61937_DTS-HD
Channel counts supported      :2 6 8
Sample Rates supported        :44100 48000 88200 96000 176400 192000

[ info ] [dts-wasapi.cpp][AudioEndPoint::InitAudioClient][365] The latency is 42.0 ms
...
[ info ] [dts-hot-win-dts-player.cpp][DTSPlayer::ConsumeData][952] Buffer latency is 38.49 milliseconds
[====================] 0h:0m:20.0s / 0h:0m:20.0s (frame 1875 / 1876)
[ info ] [dts-hot-win-dts-player.cpp][DTSPlayer::ConsumeData][977] Frames Dropped 0
[ info ] [dts-hot-win-dts-player.cpp][DTSPlayer::ConsumeData][1006] Audio Client Stopped and Reset
[ info ] [dts-hot-player-factory.cpp][WinPlayerFactory::CreateDTSPlayer][85] Seeking to beginning of stream, 0 playback(s) left
[ info ] [dts-hot-player-app.cpp][PlayerApp::CloseStream][300] Input File Closed
````

----
4. To list the available Endpoint Devices, run below command

```` 
C:\>dts-hot-app.exe -l 
````
The following log can be seen

````
************************* DTS HDMI Output Tool ********************************
  Copyright 2001-2023 DTS, Inc
  Version: 1.6.2.0
*******************************************************************************
Endpoint 0: Speakers (Realtek(R) Audio)
Endpoint 1: 1 - marantz-AVR (AMD High Definition Audio Device)
````

You can check which device to be used with the command line option '-D' followed by a whitespace and the listed number of Endpoint.

- To use **Endpoint 1: 1 - marantz-AVR (AMD High Definition Audio Device)** with the stream **22-9624-chid-96-1509k-51.dtshd** give the below command 

````
C:\>dts-hot-app.exe -D 1 22-9624-chid-96-1509k-51.dtshd

````
--------
