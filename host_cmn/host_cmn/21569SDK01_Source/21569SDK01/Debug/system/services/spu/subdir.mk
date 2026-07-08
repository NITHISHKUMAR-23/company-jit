################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.9.1/SHARC/lib/src/services/Source/spu/adi_spu.c 

C_DEPS += \
./system/services/spu/adi_spu.d 

SRC_OBJS += \
./system/services/spu/adi_spu.doj 


# Each subdirectory must supply rules for building sources it contributes
system/services/spu/adi_spu.doj: C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.9.1/SHARC/lib/src/services/Source/spu/adi_spu.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-608aa8d6e2e334d580d03d87688ebfd5.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/services/spu/adi_spu.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


