################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.9.1/SHARC/lib/src/drivers/Source/spdif/adi_spdif_rx_v1.c 

C_DEPS += \
./system/drivers/spdif/adi_spdif_rx_v1.d 

SRC_OBJS += \
./system/drivers/spdif/adi_spdif_rx_v1.doj 


# Each subdirectory must supply rules for building sources it contributes
system/drivers/spdif/adi_spdif_rx_v1.doj: C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.9.1/SHARC/lib/src/drivers/Source/spdif/adi_spdif_rx_v1.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-f33d386a7db5545a623f286082bb4e19.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -p -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/drivers/spdif/adi_spdif_rx_v1.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


