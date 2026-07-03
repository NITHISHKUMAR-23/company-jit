################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.11.1/SHARC/lib/src/services/Source/gpio/adi_gpio.c 

SRC_OBJS += \
./system/services/gpio/adi_gpio.doj 

C_DEPS += \
./system/services/gpio/adi_gpio.d 


# Each subdirectory must supply rules for building sources it contributes
system/services/gpio/adi_gpio.doj: C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.11.1/SHARC/lib/src/services/Source/gpio/adi_gpio.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="Kernel_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_INCLUDE_LEGACY_SYSREG_NAMES -DNET2272_BULK -DADI_MCAPI @includes-32ef59ff771fd561679f2367174f1e52.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/services/gpio/adi_gpio.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


