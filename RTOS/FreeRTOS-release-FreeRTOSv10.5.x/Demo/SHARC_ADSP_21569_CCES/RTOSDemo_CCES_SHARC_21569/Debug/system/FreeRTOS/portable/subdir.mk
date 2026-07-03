################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
ASM_SRCS += \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/SHARC_215xx/portASM.asm 

C_SRCS += \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/SHARC_215xx/port.c 

SRC_OBJS += \
./system/FreeRTOS/portable/port.doj \
./system/FreeRTOS/portable/portASM.doj 

ASM_DEPS += \
./system/FreeRTOS/portable/portASM.d 

C_DEPS += \
./system/FreeRTOS/portable/port.d 


# Each subdirectory must supply rules for building sources it contributes
system/FreeRTOS/portable/port.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/SHARC_215xx/port.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/FreeRTOS/portable/port.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/FreeRTOS/portable/portASM.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/SHARC_215xx/portASM.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k.exe -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -si-revision any -D_ADI_THREADS -g -D_DEBUG -D__ADI_FREERTOS -DCORE0 @includes-91cff6f3ea198d0eda909d726667ce70.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "system/FreeRTOS/portable/portASM.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


