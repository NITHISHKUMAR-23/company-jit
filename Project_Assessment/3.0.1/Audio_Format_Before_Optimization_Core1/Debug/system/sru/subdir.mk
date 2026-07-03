################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../system/sru/sru_config.c 

SRC_OBJS += \
./system/sru/sru_config.doj 

C_DEPS += \
./system/sru/sru_config.d 


# Each subdirectory must supply rules for building sources it contributes
system/sru/sru_config.doj: ../system/sru/sru_config.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="Audio_Format_Before_Optimization_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-815549e0a5d0f562bbe5c04e316c1145.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/sru/sru_config.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


