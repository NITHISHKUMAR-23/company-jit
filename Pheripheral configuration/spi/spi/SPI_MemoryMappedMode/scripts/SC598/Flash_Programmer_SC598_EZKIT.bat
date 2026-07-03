%1\cldp.exe -proc ADSP-SC598 -core 1 -emu 2000 -driver %2\..\..\..\..\scripts\SC598\is25lp512m_dpia_SC598_Core1_EZKIT.dxe -cmd prog -erase affected -format ascii -file %2\..\..\..\..\scripts\SC598\spi_flashcode.dat -cmd compare -file %2\..\..\..\..\scripts\SC598\spi_flashcode.dat -format ascii
pause
