################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/power_using_loop_Core1.c 

SRC_OBJS += \
./src/power_using_loop_Core1.doj 

C_DEPS += \
./src/power_using_loop_Core1.d 


# Each subdirectory must supply rules for building sources it contributes
src/power_using_loop_Core1.doj: ../src/power_using_loop_Core1.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="power_using_loop_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-d3996f2515348a8af7e64c3f463e5a0f.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/power_using_loop_Core1.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


