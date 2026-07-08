################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/CCES_Porting_Training/CCES_Porting_Training/Statistical_Calculations/Files/CCES_Porting_Kernel.c 

SRC_OBJS += \
./src/CCES_Porting_Kernel.doj 

C_DEPS += \
./src/CCES_Porting_Kernel.d 


# Each subdirectory must supply rules for building sources it contributes
src/CCES_Porting_Kernel.doj: D:/CCES_Porting_Training/CCES_Porting_Training/Statistical_Calculations/Files/CCES_Porting_Kernel.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="Kernel" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE0 -DMEAN -D_DEBUG @includes-90df628ea9fbfa05d4f93eca2b18a00c.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/CCES_Porting_Kernel.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


