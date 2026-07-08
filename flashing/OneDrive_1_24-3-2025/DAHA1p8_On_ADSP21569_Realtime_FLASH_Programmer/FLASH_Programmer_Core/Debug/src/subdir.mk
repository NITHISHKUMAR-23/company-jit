################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
ASM_SRCS += \
../src/FLASH_Programmer.asm 

C_SRCS += \
../src/FLASH_Programmer_Core1.c 

SRC_OBJS += \
./src/FLASH_Programmer.doj \
./src/FLASH_Programmer_Core1.doj 

ASM_DEPS += \
./src/FLASH_Programmer.d 

C_DEPS += \
./src/FLASH_Programmer_Core1.d 


# Each subdirectory must supply rules for building sources it contributes
src/FLASH_Programmer.doj: ../src/FLASH_Programmer.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="FLASH_Programmer_Core" -proc ADSP-21569 -si-revision 0.0 -g -D_DEBUG -DCORE0 @includes-3813beccca1b96ac2af550731d1c3130.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/FLASH_Programmer.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/FLASH_Programmer_Core1.doj: ../src/FLASH_Programmer_Core1.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="FLASH_Programmer_Core" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -D_DEBUG -DCORE0 @includes-5d1491460c12711c86afea4a7c590e85.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/FLASH_Programmer_Core1.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


