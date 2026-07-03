################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/AudioAlgorithms/Postprocessing/DTSX/TruBass/TruBass_Kernel.c 

C_DEPS += \
./src/AudioAlgorithms/Postprocessing/DTSX/TruBass/TruBass_Kernel.d 

SRC_OBJS += \
./src/AudioAlgorithms/Postprocessing/DTSX/TruBass/TruBass_Kernel.doj 


# Each subdirectory must supply rules for building sources it contributes
src/AudioAlgorithms/Postprocessing/DTSX/TruBass/TruBass_Kernel.doj: ../src/AudioAlgorithms/Postprocessing/DTSX/TruBass/TruBass_Kernel.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core2" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE2 -D_DEBUG -DADI_MCAPI @includes-a318ad7d378d42081e06695e469bae54.txt -enum-is-int -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/AudioAlgorithms/Postprocessing/DTSX/TruBass/TruBass_Kernel.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


