################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../system/SoftConfig_EV_SOMCRR_EZKIT_ADAU_Reset.c \
../system/SoftConfig_EV_SOMCRR_EZKIT_ADC_DAC.c \
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
system/SoftConfig_EV_SOMCRR_EZKIT_ADAU_Reset.doj: ../system/SoftConfig_EV_SOMCRR_EZKIT_ADAU_Reset.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="I2S_TDM_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-94929b0e21bf1df634ff7b2eacbb5827.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/SoftConfig_EV_SOMCRR_EZKIT_ADAU_Reset.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/SoftConfig_EV_SOMCRR_EZKIT_ADC_DAC.doj: ../system/SoftConfig_EV_SOMCRR_EZKIT_ADC_DAC.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="I2S_TDM_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-94929b0e21bf1df634ff7b2eacbb5827.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/SoftConfig_EV_SOMCRR_EZKIT_ADC_DAC.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/adi_initialize.doj: ../system/adi_initialize.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="I2S_TDM_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-94929b0e21bf1df634ff7b2eacbb5827.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/adi_initialize.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


