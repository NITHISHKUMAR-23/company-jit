################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/CCES_Porting_Training/Porting_Library/Files/CCES_Porting_Library.c 

SRC_OBJS += \
./src/CCES_Porting_Library.doj 

C_DEPS += \
./src/CCES_Porting_Library.d 


# Each subdirectory must supply rules for building sources it contributes
src/CCES_Porting_Library.doj: D:/CCES_Porting_Training/Porting_Library/Files/CCES_Porting_Library.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="CCES_Porting_Library" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -save-temps -path-output ./$(@D) -DCORE0 -D_DEBUG @includes-dd0bdcff7da8be8ad8327a58c33c24ba.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/CCES_Porting_Library.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


