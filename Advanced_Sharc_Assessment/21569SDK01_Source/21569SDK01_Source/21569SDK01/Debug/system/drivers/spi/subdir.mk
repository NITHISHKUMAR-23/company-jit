################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.9.1/SHARC/lib/src/drivers/Source/spi/adi_spi.c 

C_DEPS += \
./system/drivers/spi/adi_spi.d 

SRC_OBJS += \
./system/drivers/spi/adi_spi.doj 


# Each subdirectory must supply rules for building sources it contributes
system/drivers/spi/adi_spi.doj: C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.9.1/SHARC/lib/src/drivers/Source/spi/adi_spi.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-ab653c6517841d4eff128baae859ecc6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -p -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/drivers/spi/adi_spi.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


