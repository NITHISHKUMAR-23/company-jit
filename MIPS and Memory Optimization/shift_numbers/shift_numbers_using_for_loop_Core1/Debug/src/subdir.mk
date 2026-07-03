################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/shift_numbers_using_for_loop_Core1.c 

SRC_OBJS += \
./src/shift_numbers_using_for_loop_Core1.doj 

C_DEPS += \
./src/shift_numbers_using_for_loop_Core1.d 


# Each subdirectory must supply rules for building sources it contributes
src/shift_numbers_using_for_loop_Core1.doj: ../src/shift_numbers_using_for_loop_Core1.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="shift_numbers_using_for_loop_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-3b034a1bc9f93cf29176e33bb430fa2c.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/shift_numbers_using_for_loop_Core1.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


