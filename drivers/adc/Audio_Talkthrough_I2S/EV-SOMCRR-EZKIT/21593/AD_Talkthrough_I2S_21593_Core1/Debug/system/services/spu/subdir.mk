################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/analog/cces/3.0.1/SHARC/lib/src/services/Source/spu/adi_spu.c 

SRC_OBJS += \
./system/services/spu/adi_spu.doj 

C_DEPS += \
./system/services/spu/adi_spu.d 


# Each subdirectory must supply rules for building sources it contributes
system/services/spu/adi_spu.doj: C:/analog/cces/3.0.1/SHARC/lib/src/services/Source/spu/adi_spu.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="AD_Talkthrough_I2S_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-856bdb4caccfe052bc72d485a52b7c6c.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "system/services/spu/adi_spu.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


