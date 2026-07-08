################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../system/adi_initialize.c 

C_DEPS += \
./system/adi_initialize.d 

SRC_OBJS += \
./system/adi_initialize.doj 


# Each subdirectory must supply rules for building sources it contributes
system/adi_initialize.doj: ../system/adi_initialize.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-608aa8d6e2e334d580d03d87688ebfd5.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/adi_initialize.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


