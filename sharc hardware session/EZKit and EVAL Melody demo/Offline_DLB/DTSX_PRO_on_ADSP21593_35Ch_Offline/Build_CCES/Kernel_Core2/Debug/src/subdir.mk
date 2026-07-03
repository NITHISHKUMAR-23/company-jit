################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/EZ\ Hardware\ Session/EZKit\ and\ EVAL\ Melody\ demo/Offline_DLB/DTSX_PRO_on_ADSP21593_35Ch_Offline/Core2/Kernel/src/Kernel_Core2.c 

SRC_OBJS += \
./src/Kernel_Core2.doj 

C_DEPS += \
./src/Kernel_Core2.d 


# Each subdirectory must supply rules for building sources it contributes
src/Kernel_Core2.doj: D:/EZ\ Hardware\ Session/EZKit\ and\ EVAL\ Melody\ demo/Offline_DLB/DTSX_PRO_on_ADSP21593_35Ch_Offline/Core2/Kernel/src/Kernel_Core2.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="Kernel_Core2" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE2 -D_DEBUG -DADI_DEBUG -DADI_MCAPI -DDTS_COMPILER_SHARC @includes-292b2e39519ed1aeb40892a115a2a945.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -section switch=seg_dts_data_switch -gnu-style-dependencies -MD -Mo "src/Kernel_Core2.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


