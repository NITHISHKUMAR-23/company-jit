################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/EZ\ Hardware\ Session/EZKit\ and\ EVAL\ Melody\ demo/Offline_DLB/DTSX_PRO_on_ADSP21593_35Ch_Offline/Core1/Kernel/src/Kernel_Core1.c 

SRC_OBJS += \
./src/Kernel_Core1.doj 

C_DEPS += \
./src/Kernel_Core1.d 


# Each subdirectory must supply rules for building sources it contributes
src/Kernel_Core1.doj: D:/EZ\ Hardware\ Session/EZKit\ and\ EVAL\ Melody\ demo/Offline_DLB/DTSX_PRO_on_ADSP21593_35Ch_Offline/Core1/Kernel/src/Kernel_Core1.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="Kernel_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_INCLUDE_LEGACY_SYSREG_NAMES -DNET2272_BULK -DADI_MCAPI @includes-32ef59ff771fd561679f2367174f1e52.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/Kernel_Core1.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


