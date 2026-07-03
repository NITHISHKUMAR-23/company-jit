################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.11.1/SHARC/lib/src/services/Source/pwr/adi_pwr.c 

SRC_OBJS += \
./system/services/pwr/adi_pwr.doj 

C_DEPS += \
./system/services/pwr/adi_pwr.d 


# Each subdirectory must supply rules for building sources it contributes
system/services/pwr/adi_pwr.doj: C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.11.1/SHARC/lib/src/services/Source/pwr/adi_pwr.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593_preload_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov0 -g -DNDEBUG -DPRELOAD_CODE -DCORE1 @includes-91d4960dd71b0e872dc70ce59f5c6828.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/services/pwr/adi_pwr.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


