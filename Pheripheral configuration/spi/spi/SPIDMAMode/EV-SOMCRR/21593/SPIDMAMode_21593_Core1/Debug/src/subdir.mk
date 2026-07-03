################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/Pheripheral\ configuration/spi/spi/SPIDMAMode/SPIDMAMode.c 

SRC_OBJS += \
./src/SPIDMAMode.doj 

C_DEPS += \
./src/SPIDMAMode.d 


# Each subdirectory must supply rules for building sources it contributes
src/SPIDMAMode.doj: D:/Pheripheral\ configuration/spi/spi/SPIDMAMode/SPIDMAMode.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="SPIDMAMode_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI -DADI_DEBUG @includes-0eaf8e76b98b9c6f293f8adb7677aec2.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "src/SPIDMAMode.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


