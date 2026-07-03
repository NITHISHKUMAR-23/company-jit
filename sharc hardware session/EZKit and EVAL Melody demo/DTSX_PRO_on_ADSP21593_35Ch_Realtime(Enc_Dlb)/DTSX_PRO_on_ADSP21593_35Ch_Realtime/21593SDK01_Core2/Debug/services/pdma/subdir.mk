################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.11.1/SHARC/lib/src/services/Source/pdma/adi_pdma_2156x.c 

C_DEPS += \
./services/pdma/adi_pdma_2156x.d 

SRC_OBJS += \
./services/pdma/adi_pdma_2156x.doj 


# Each subdirectory must supply rules for building sources it contributes
services/pdma/adi_pdma_2156x.doj: C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.11.1/SHARC/lib/src/services/Source/pdma/adi_pdma_2156x.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core2" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE2 -D_DEBUG -DADI_MCAPI @includes-55478ad070e02f42014f6f9bf1079bf5.txt -enum-is-int -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "services/pdma/adi_pdma_2156x.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


