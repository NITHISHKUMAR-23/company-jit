echo in post-build
REM Creating a ROM image file
REM For TargetSupport set either EV_SOMCRR_EZKIT_SUPPORT (default), EV_SOMCRR_EZLITE_SUPPORT
Set TargetSupport=EV_SOMCRR_EZKIT_SUPPORT
REM For IceSupport set either 1000, 1500, 2000 (default)
Set IceSupport=2000
%2\elfloader.exe -proc ADSP-21593 -romsplitter -f hex -width 8 -romsplitter %1.dxe -o %1.rom.ldr
if "%TargetSupport%"=="EV_SOMCRR_EZKIT_SUPPORT" (cldp.exe -proc ADSP-21593 -emu %IceSupport% -driver "C:\Analog Devices\EV-SC59x_EZ-KIT-Rel4.0.0\EV-SC59x_EZ-KIT\Examples\Device_Programmer\Legacy_SPI_ISSI_Flash\EV-SOMCRR\21593\is25lp512m_dpia_21593_Core1\is25lp512m_dpia_21593_Core1_EZKIT.dxe" -cmd prog -erase affected -format hex -file %1.rom.ldr -cmd compare -format hex -file %1.rom.ldr)
if "%TargetSupport%"=="EV_SOMCRR_EZLITE_SUPPORT" (cldp.exe -proc ADSP-21593 -emu %IceSupport% -driver "C:\Analog Devices\EV-SC59x_EZ-KIT-Rel4.0.0\EV-SC59x_EZ-KIT\Examples\Device_Programmer\Legacy_SPI_ISSI_Flash\EV-SOMCRR\21593\is25lp512m_dpia_21593_Core1\is25lp512m_dpia_21593_Core1_EZLITE.dxe" -cmd prog -erase affected -format hex -file %1.rom.ldr -cmd compare -format hex -file %1.rom.ldr)
