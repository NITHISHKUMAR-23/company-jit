################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/simple_interest_library_Core1.c 

SRC_OBJS += \
./src/simple_interest_library_Core1.doj 

C_DEPS += \
./src/simple_interest_library_Core1.d 


# Each subdirectory must supply rules for building sources it contributes
src/simple_interest_library_Core1.doj: ../src/simple_interest_library_Core1.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="simple_interest_library_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-0860b75a8e117191827ef798cbeab769.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/simple_interest_library_Core1.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


