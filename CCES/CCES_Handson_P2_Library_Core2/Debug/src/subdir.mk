################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/CCES_Handson_P2_Library_Core2.c 

SRC_OBJS += \
./src/CCES_Handson_P2_Library_Core2.doj 

C_DEPS += \
./src/CCES_Handson_P2_Library_Core2.d 


# Each subdirectory must supply rules for building sources it contributes
src/CCES_Handson_P2_Library_Core2.doj: ../src/CCES_Handson_P2_Library_Core2.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="CCES_Handson_P2_Library_Core2" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE2 -D_DEBUG -DADI_MCAPI @includes-0d2da54026495b2112320526d1de29d9.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/CCES_Handson_P2_Library_Core2.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


