################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
ASM_SRCS += \
../Customer_PP/Customerasm.asm 

C_SRCS += \
../Customer_PP/Customer_PP.c 

C_DEPS += \
./Customer_PP/Customer_PP.d 

SRC_OBJS += \
./Customer_PP/Customer_PP.doj \
./Customer_PP/Customerasm.doj 

ASM_DEPS += \
./Customer_PP/Customerasm.d 


# Each subdirectory must supply rules for building sources it contributes
Customer_PP/Customer_PP.doj: ../Customer_PP/Customer_PP.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-f33d386a7db5545a623f286082bb4e19.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -p -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "Customer_PP/Customer_PP.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Customer_PP/Customerasm.doj: ../Customer_PP/Customerasm.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -si-revision 0.0 -g -DCORE0 -D_DEBUG @includes-f5df3f4d15b6ba8d07628f08bfae24ee.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "Customer_PP/Customerasm.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


