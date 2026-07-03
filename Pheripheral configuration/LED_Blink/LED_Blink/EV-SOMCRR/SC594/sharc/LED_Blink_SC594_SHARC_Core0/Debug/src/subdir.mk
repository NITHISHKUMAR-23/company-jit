################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/LED_Blink_SC594_SHARC_Core0.c 

SRC_OBJS += \
./src/LED_Blink_SC594_SHARC_Core0.o 

C_DEPS += \
./src/LED_Blink_SC594_SHARC_Core0.d 


# Each subdirectory must supply rules for building sources it contributes
src/LED_Blink_SC594_SHARC_Core0.o: ../src/LED_Blink_SC594_SHARC_Core0.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore ARM Bare Metal C Compiler'
	arm-none-eabi-gcc -g -ffunction-sections -fdata-sections -DCORE0 -D_DEBUG @includes-a9dc6274eae7a6dd2d6b5de055b8f20d.txt -Wall -c -mproc=ADSP-SC594 -msi-revision=0.0 -gdwarf-2 -MMD -MP -MF"src/LED_Blink_SC594_SHARC_Core0.d" -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


