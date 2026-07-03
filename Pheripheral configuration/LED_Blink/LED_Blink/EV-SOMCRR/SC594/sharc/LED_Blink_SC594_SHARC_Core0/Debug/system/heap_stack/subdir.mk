################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../system/heap_stack/app_heap_stack.c 

SRC_OBJS += \
./system/heap_stack/app_heap_stack.o 

C_DEPS += \
./system/heap_stack/app_heap_stack.d 


# Each subdirectory must supply rules for building sources it contributes
system/heap_stack/app_heap_stack.o: ../system/heap_stack/app_heap_stack.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore ARM Bare Metal C Compiler'
	arm-none-eabi-gcc -g -ffunction-sections -fdata-sections -DCORE0 -D_DEBUG @includes-a9dc6274eae7a6dd2d6b5de055b8f20d.txt -Wall -c -mproc=ADSP-SC594 -msi-revision=0.0 -gdwarf-2 -MMD -MP -MF"system/heap_stack/app_heap_stack.d" -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


