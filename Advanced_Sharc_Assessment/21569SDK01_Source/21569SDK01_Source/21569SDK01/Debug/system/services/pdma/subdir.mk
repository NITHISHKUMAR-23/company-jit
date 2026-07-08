################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.9.1/SHARC/lib/src/services/Source/pdma/adi_pdma_2156x.c 

C_DEPS += \
./system/services/pdma/adi_pdma_2156x.d 

SRC_OBJS += \
./system/services/pdma/adi_pdma_2156x.doj 


# Each subdirectory must supply rules for building sources it contributes
system/services/pdma/adi_pdma_2156x.doj: C:/Analog\ Devices/CrossCore\ Embedded\ Studio\ 2.9.1/SHARC/lib/src/services/Source/pdma/adi_pdma_2156x.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-ab653c6517841d4eff128baae859ecc6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -p -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/services/pdma/adi_pdma_2156x.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


