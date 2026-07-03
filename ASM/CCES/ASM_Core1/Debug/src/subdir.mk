################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
ASM_SRCS += \
../src/project.asm 

C_SRCS += \
../src/ASM_Core1.c 

SRC_OBJS += \
./src/ASM_Core1.doj \
./src/project.doj 

ASM_DEPS += \
./src/project.d 

C_DEPS += \
./src/ASM_Core1.d 


# Each subdirectory must supply rules for building sources it contributes
src/ASM_Core1.doj: ../src/ASM_Core1.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="ASM_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-a7c636f90c276d670cb38381f31bd889.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/ASM_Core1.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/project.doj: ../src/project.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="ASM_Core1" -proc ADSP-21593 -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI @includes-e725c9c041ec07dfd6fc30477abf5969.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/project.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


