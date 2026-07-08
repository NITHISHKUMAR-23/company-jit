################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/AD_Talkthrough_I2S_21593_Core2.c 

SRC_OBJS += \
./src/AD_Talkthrough_I2S_21593_Core2.doj 

C_DEPS += \
./src/AD_Talkthrough_I2S_21593_Core2.d 


# Each subdirectory must supply rules for building sources it contributes
src/AD_Talkthrough_I2S_21593_Core2.doj: ../src/AD_Talkthrough_I2S_21593_Core2.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="AD_Talkthrough_I2S_21593_Core2" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE2 -D_DEBUG @includes-400ffc3c23faf0dc267b55a5b101b37d.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "src/AD_Talkthrough_I2S_21593_Core2.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


