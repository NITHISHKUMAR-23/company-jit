################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/LED_Blink_21593_Core2.c 

SRC_OBJS += \
./src/LED_Blink_21593_Core2.doj 

C_DEPS += \
./src/LED_Blink_21593_Core2.d 


# Each subdirectory must supply rules for building sources it contributes
src/LED_Blink_21593_Core2.doj: ../src/LED_Blink_21593_Core2.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="LED_Blink_21593_Core2" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE2 -D_DEBUG @includes-22c80016e3cd5acb285ee622c1ba460c.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "src/LED_Blink_21593_Core2.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


