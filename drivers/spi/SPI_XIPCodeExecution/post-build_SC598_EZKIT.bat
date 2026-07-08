echo in post-build
REM Creating a ROM image file
%2\elfloader.exe -proc ADSP-SC598 -romsplitter -f hex -width 8 -romsplitter %1.dxe -o %1.rom.ldr
%2\cldp.exe -proc ADSP-SC598 -core 1 -emu 2000 -driver "C:\Analog Devices\EV-SC59x_EZ-KIT-Rel4.0.0\EV-SC59x_EZ-KIT\Examples\Device_Programmer\Legacy_SPI_ISSI_Flash\EV-SOMCRR\SC598\is25lp512m_dpia_SC598_Core1\is25lp512m_dpia_SC598_Core1_EZKIT.dxe" -cmd prog -erase affected -format hex -file %1.rom.ldr -cmd compare -format hex -file %1.rom.ldr