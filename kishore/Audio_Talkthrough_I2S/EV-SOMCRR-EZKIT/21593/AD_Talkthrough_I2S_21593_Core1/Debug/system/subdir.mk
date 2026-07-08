################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/kishore/Audio_Talkthrough_I2S/SoftConfig_EV_SOMCRR_EZKIT_ADAU_Reset.c \
D:/kishore/Audio_Talkthrough_I2S/SoftConfig_EV_SOMCRR_EZKIT_ADC_DAC.c \
../system/adi_initialize.c 

SRC_OBJS += \
./system/SoftConfig_EV_SOMCRR_EZKIT_ADAU_Reset.doj \
./system/SoftConfig_EV_SOMCRR_EZKIT_ADC_DAC.doj \
./system/adi_initialize.doj 

C_DEPS += \
./system/SoftConfig_EV_SOMCRR_EZKIT_ADAU_Reset.d \
./system/SoftConfig_EV_SOMCRR_EZKIT_ADC_DAC.d \
./system/adi_initialize.d 


# Each subdirectory must supply rules for building sources it contributes
system/SoftConfig_EV_SOMCRR_EZKIT_ADAU_Reset.doj: D:/kishore/Audio_Talkthrough_I2S/SoftConfig_EV_SOMCRR_EZKIT_ADAU_Reset.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="AD_Talkthrough_I2S_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-49ced185bbb932a8513c68b3544527ba.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "system/SoftConfig_EV_SOMCRR_EZKIT_ADAU_Reset.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/SoftConfig_EV_SOMCRR_EZKIT_ADC_DAC.doj: D:/kishore/Audio_Talkthrough_I2S/SoftConfig_EV_SOMCRR_EZKIT_ADC_DAC.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="AD_Talkthrough_I2S_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-49ced185bbb932a8513c68b3544527ba.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "system/SoftConfig_EV_SOMCRR_EZKIT_ADC_DAC.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/adi_initialize.doj: ../system/adi_initialize.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="AD_Talkthrough_I2S_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-49ced185bbb932a8513c68b3544527ba.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "system/adi_initialize.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


