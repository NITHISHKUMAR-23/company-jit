################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.11.1/SHARC/lib/src/drivers/Source/twi/adi_twi.c 

SRC_OBJS += \
./system/drivers/twi/adi_twi.doj 

C_DEPS += \
./system/drivers/twi/adi_twi.d 


# Each subdirectory must supply rules for building sources it contributes
system/drivers/twi/adi_twi.doj: C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.11.1/SHARC/lib/src/drivers/Source/twi/adi_twi.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-8ed3ab3e2629072de30378482a77a9cf.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/drivers/twi/adi_twi.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


