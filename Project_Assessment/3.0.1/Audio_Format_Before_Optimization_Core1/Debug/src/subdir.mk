################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/Audio_Format_Before_Optimization_Core1.c \
../src/function.c 

SRC_OBJS += \
./src/Audio_Format_Before_Optimization_Core1.doj \
./src/function.doj 

C_DEPS += \
./src/Audio_Format_Before_Optimization_Core1.d \
./src/function.d 


# Each subdirectory must supply rules for building sources it contributes
src/Audio_Format_Before_Optimization_Core1.doj: ../src/Audio_Format_Before_Optimization_Core1.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="Audio_Format_Before_Optimization_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-815549e0a5d0f562bbe5c04e316c1145.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/Audio_Format_Before_Optimization_Core1.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/function.doj: ../src/function.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="Audio_Format_Before_Optimization_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-815549e0a5d0f562bbe5c04e316c1145.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/function.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


