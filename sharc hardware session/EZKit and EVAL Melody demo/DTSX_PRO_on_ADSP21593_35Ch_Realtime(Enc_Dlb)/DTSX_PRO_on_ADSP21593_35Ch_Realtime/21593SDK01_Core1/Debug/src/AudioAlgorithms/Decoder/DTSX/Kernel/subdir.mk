################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
ASM_SRCS += \
../src/AudioAlgorithms/Decoder/DTSX/Kernel/DTSX_Kernel_asm.asm 

C_SRCS += \
../src/AudioAlgorithms/Decoder/DTSX/Kernel/DTSX_Kernel.c 

SRC_OBJS += \
./src/AudioAlgorithms/Decoder/DTSX/Kernel/DTSX_Kernel.doj \
./src/AudioAlgorithms/Decoder/DTSX/Kernel/DTSX_Kernel_asm.doj 

ASM_DEPS += \
./src/AudioAlgorithms/Decoder/DTSX/Kernel/DTSX_Kernel_asm.d 

C_DEPS += \
./src/AudioAlgorithms/Decoder/DTSX/Kernel/DTSX_Kernel.d 


# Each subdirectory must supply rules for building sources it contributes
src/AudioAlgorithms/Decoder/DTSX/Kernel/DTSX_Kernel.doj: ../src/AudioAlgorithms/Decoder/DTSX/Kernel/DTSX_Kernel.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-8ed3ab3e2629072de30378482a77a9cf.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/AudioAlgorithms/Decoder/DTSX/Kernel/DTSX_Kernel.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/AudioAlgorithms/Decoder/DTSX/Kernel/DTSX_Kernel_asm.doj: ../src/AudioAlgorithms/Decoder/DTSX/Kernel/DTSX_Kernel_asm.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -si-revision any -g -DCORE1 -D_DEBUG @includes-61f6bf9d7ce64e05f9f3040dcd70264e.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/AudioAlgorithms/Decoder/DTSX/Kernel/DTSX_Kernel_asm.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


