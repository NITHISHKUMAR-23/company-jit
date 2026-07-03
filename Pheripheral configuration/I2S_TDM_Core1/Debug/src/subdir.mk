################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/Audio_Talkthrough_TDM.c 

SRC_OBJS += \
./src/Audio_Talkthrough_TDM.doj 

C_DEPS += \
./src/Audio_Talkthrough_TDM.d 


# Each subdirectory must supply rules for building sources it contributes
src/Audio_Talkthrough_TDM.doj: ../src/Audio_Talkthrough_TDM.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="I2S_TDM_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-94929b0e21bf1df634ff7b2eacbb5827.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/Audio_Talkthrough_TDM.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


