################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../system/mcapi/GeneratedSources/mcapi_config.c 

SRC_OBJS += \
./system/mcapi/GeneratedSources/mcapi_config.doj 

C_DEPS += \
./system/mcapi/GeneratedSources/mcapi_config.d 


# Each subdirectory must supply rules for building sources it contributes
system/mcapi/GeneratedSources/mcapi_config.doj: ../system/mcapi/GeneratedSources/mcapi_config.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="addition_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -DCORE1 -D_DEBUG -DADI_MCAPI @includes-2063cf8533cf4c4e5e2b5d14e8cafd9e.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/mcapi/GeneratedSources/mcapi_config.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


