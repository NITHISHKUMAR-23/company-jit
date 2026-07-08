################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/CCES_Porting_Training/CCES_Porting_Training/Porting_Library/Files/CCES_Porting_Library.c 

SRC_OBJS += \
./src/CCES_Porting_Library.doj 

C_DEPS += \
./src/CCES_Porting_Library.d 


# Each subdirectory must supply rules for building sources it contributes
src/CCES_Porting_Library.doj: D:/CCES_Porting_Training/CCES_Porting_Training/Porting_Library/Files/CCES_Porting_Library.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="Library" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE0 -D_DEBUG @includes-82277160cfa2bd466194872861c8290d.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/CCES_Porting_Library.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


