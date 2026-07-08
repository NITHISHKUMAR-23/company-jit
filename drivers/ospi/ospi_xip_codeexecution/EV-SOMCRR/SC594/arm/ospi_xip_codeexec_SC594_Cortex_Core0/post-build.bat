echo in post-build
REM Creating a ROM image file
%2\ARM\arm-none-eabi\arm-none-eabi\bin\objcopy.exe %1 -O binary -j .ospi_flash_code  %1.dat