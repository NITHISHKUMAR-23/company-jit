echo in post-build
REM Creating a ROM image file
%2\ARM\aarch64-none-elf\aarch64-none-elf\bin\objcopy.exe %1 -O binary -j .ospi_flash_code  %1.dat