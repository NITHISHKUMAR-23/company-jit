%1\cldp.exe -proc ADSP-21593 -emu 2000 -driver %2\..\..\..\scripts\21593\is25lp512m_dpia_21593_Core1_EZLITE.dxe -cmd prog -erase affected -format ascii -file %2\..\..\..\scripts\21593\spi_flashcode.dat -cmd compare -file %2\..\..\..\scripts\21593\spi_flashcode.dat -format ascii
pause
