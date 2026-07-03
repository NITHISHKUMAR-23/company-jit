################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../system/linker/apt.c \
../system/linker/page_table_mem.c 

SRC_OBJS += \
./system/linker/apt.o \
./system/linker/page_table_mem.o 

C_DEPS += \
./system/linker/apt.d \
./system/linker/page_table_mem.d 


# Each subdirectory must supply rules for building sources it contributes
system/linker/apt.o: ../system/linker/apt.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore ARM Bare Metal C Compiler'
	arm-none-eabi-gcc -g -ffunction-sections -fdata-sections -DCORE0 -D_DEBUG @includes-a9dc6274eae7a6dd2d6b5de055b8f20d.txt -Wall -c -mproc=ADSP-SC594 -msi-revision=0.0 -gdwarf-2 -MMD -MP -MF"system/linker/apt.d" -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/linker/page_table_mem.o: ../system/linker/page_table_mem.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore ARM Bare Metal C Compiler'
	arm-none-eabi-gcc -g -ffunction-sections -fdata-sections -DCORE0 -D_DEBUG @includes-a9dc6274eae7a6dd2d6b5de055b8f20d.txt -Wall -c -mproc=ADSP-SC594 -msi-revision=0.0 -gdwarf-2 -MMD -MP -MF"system/linker/page_table_mem.d" -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


