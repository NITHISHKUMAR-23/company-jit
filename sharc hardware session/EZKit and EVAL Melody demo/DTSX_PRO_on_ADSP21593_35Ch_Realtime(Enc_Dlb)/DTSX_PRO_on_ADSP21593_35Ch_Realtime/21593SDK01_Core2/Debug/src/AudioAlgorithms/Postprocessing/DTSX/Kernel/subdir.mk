################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
ASM_SRCS += \
../src/AudioAlgorithms/Postprocessing/DTSX/Kernel/DTSX_Kernel_asm.asm 

C_SRCS += \
../src/AudioAlgorithms/Postprocessing/DTSX/Kernel/DTSX_Kernel.c 

C_DEPS += \
./src/AudioAlgorithms/Postprocessing/DTSX/Kernel/DTSX_Kernel.d 

SRC_OBJS += \
./src/AudioAlgorithms/Postprocessing/DTSX/Kernel/DTSX_Kernel.doj \
./src/AudioAlgorithms/Postprocessing/DTSX/Kernel/DTSX_Kernel_asm.doj 

ASM_DEPS += \
./src/AudioAlgorithms/Postprocessing/DTSX/Kernel/DTSX_Kernel_asm.d 


# Each subdirectory must supply rules for building sources it contributes
src/AudioAlgorithms/Postprocessing/DTSX/Kernel/DTSX_Kernel.doj: ../src/AudioAlgorithms/Postprocessing/DTSX/Kernel/DTSX_Kernel.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core2" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE2 -D_DEBUG -DADI_MCAPI @includes-55478ad070e02f42014f6f9bf1079bf5.txt -enum-is-int -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/AudioAlgorithms/Postprocessing/DTSX/Kernel/DTSX_Kernel.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/AudioAlgorithms/Postprocessing/DTSX/Kernel/DTSX_Kernel_asm.doj: ../src/AudioAlgorithms/Postprocessing/DTSX/Kernel/DTSX_Kernel_asm.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21593SDK01_Core2" -proc ADSP-21593 -si-revision any -g -DCORE2 -D_DEBUG -DADI_MCAPI @includes-829b02e60cf9d69099200e6a4711f448.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/AudioAlgorithms/Postprocessing/DTSX/Kernel/DTSX_Kernel_asm.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


