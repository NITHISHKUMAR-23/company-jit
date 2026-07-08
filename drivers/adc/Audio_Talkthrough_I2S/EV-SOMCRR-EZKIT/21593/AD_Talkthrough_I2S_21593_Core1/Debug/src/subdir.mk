################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/drivers/adc/Audio_Talkthrough_I2S/Audio_Talkthrough_I2S.c 

SRC_OBJS += \
./src/Audio_Talkthrough_I2S.doj 

C_DEPS += \
./src/Audio_Talkthrough_I2S.d 


# Each subdirectory must supply rules for building sources it contributes
src/Audio_Talkthrough_I2S.doj: D:/drivers/adc/Audio_Talkthrough_I2S/Audio_Talkthrough_I2S.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="AD_Talkthrough_I2S_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-856bdb4caccfe052bc72d485a52b7c6c.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "src/Audio_Talkthrough_I2S.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


