################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.11.1/SHARC/lib/src/services/Source/smpu/adi_smpu.c 

SRC_OBJS += \
./system/services/smpu/adi_smpu.doj 

C_DEPS += \
./system/services/smpu/adi_smpu.d 


# Each subdirectory must supply rules for building sources it contributes
system/services/smpu/adi_smpu.doj: C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.11.1/SHARC/lib/src/services/Source/smpu/adi_smpu.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593_init_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov0 -DNDEBUG -DCORE1 @includes-67b05e6db0d6a65fa8e85b47f3e40404.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/services/smpu/adi_smpu.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


