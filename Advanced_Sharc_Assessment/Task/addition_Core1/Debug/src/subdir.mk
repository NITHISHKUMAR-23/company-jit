################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
ASM_SRCS += \
../src/addition.asm \
../src/float.asm \
../src/temp.asm 

C_SRCS += \
../src/addition_Core1.c 

SRC_OBJS += \
./src/addition.doj \
./src/addition_Core1.doj \
./src/float.doj \
./src/temp.doj 

ASM_DEPS += \
./src/addition.d \
./src/float.d \
./src/temp.d 

C_DEPS += \
./src/addition_Core1.d 


# Each subdirectory must supply rules for building sources it contributes
src/addition.doj: ../src/addition.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="addition_Core1" -proc ADSP-21593 -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-f388188af303e8db12e8fd45c87615a7.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/addition.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/addition_Core1.doj: ../src/addition_Core1.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="addition_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -DCORE1 -D_DEBUG -DADI_MCAPI @includes-2063cf8533cf4c4e5e2b5d14e8cafd9e.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/addition_Core1.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/float.doj: ../src/float.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="addition_Core1" -proc ADSP-21593 -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-f388188af303e8db12e8fd45c87615a7.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/float.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/temp.doj: ../src/temp.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="addition_Core1" -proc ADSP-21593 -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-f388188af303e8db12e8fd45c87615a7.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/temp.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


