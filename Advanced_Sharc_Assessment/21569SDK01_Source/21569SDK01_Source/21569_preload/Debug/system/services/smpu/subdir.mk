################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.9.1/SHARC/lib/src/services/Source/smpu/adi_smpu.c 

SRC_OBJS += \
./system/services/smpu/adi_smpu.doj 

C_DEPS += \
./system/services/smpu/adi_smpu.d 


# Each subdirectory must supply rules for building sources it contributes
system/services/smpu/adi_smpu.doj: C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.9.1/SHARC/lib/src/services/Source/smpu/adi_smpu.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569_preload" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DPRELOAD_CODE -DCORE0 -D_DEBUG @includes-119cb84ed3b47fd231fd2db1b05087ac.txt -structs-do-not-overlap -no-const-strings -no-multiline -misra -misra-strict -misra-no-cross-module -misra-no-runtime -misra-testing -misra-suppress-advisory -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/services/smpu/adi_smpu.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


