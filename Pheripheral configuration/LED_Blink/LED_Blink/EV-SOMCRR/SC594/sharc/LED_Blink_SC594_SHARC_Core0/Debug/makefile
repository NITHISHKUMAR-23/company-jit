################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL := ${ComSpec}

-include ../makefile.init

RM := clean

# All of the sources participating in the build are defined here
-include sources.mk
-include system/sru/subdir.mk
-include system/pinmux/GeneratedSources/subdir.mk
-include system/linker/subdir.mk
-include system/heap_stack/subdir.mk
-include system/subdir.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
OBJS := $(SRC_OBJS)
# Quote makefile variable : OBJS 
OBJS := $(subst \ ,@, $(OBJS))
OBJS := $(foreach var, $(OBJS), "$(subst @, ,$(var))")
# Quote makefile variable : C_DEPS 
C_DEPS := $(subst \ ,@, $(C_DEPS))
C_DEPS := $(foreach var, $(C_DEPS), "$(subst @, ,$(var))")

# All Target
all: LED_Blink_SC594_SHARC_Core0

# Tool invocations

LED_Blink_SC594_SHARC_Core0.ld: D:/Praveen/SMAC_Training/Peripherals/LED_Blink/EV-SOMCRR/SC594/sharc/LED_Blink_SC594_SHARC_Core0/system/linker/app.ld
	@echo 'Preprocessing LD script: LED_Blink_SC594_SHARC_Core0.ld'
	arm-none-eabi-cpp -E -P -DCORE0 -DDEBUG -o  "LED_Blink_SC594_SHARC_Core0.ld" "D:/Praveen/SMAC_Training/Peripherals/LED_Blink/EV-SOMCRR/SC594/sharc/LED_Blink_SC594_SHARC_Core0/system/linker/app.ld"

LED_Blink_SC594_SHARC_Core0: $(USER_OBJS) $(SRC_OBJS) LED_Blink_SC594_SHARC_Core0.ld
	@echo 'Building target: $@'
	@echo 'Invoking: CrossCore ARM Bare Metal C Linker'
	arm-none-eabi-gcc -mproc=ADSP-SC594 -msi-revision=0.0 -TLED_Blink_SC594_SHARC_Core0.ld -DCORE0 -DDEBUG -Wl,--gc-sections -mdebug-libs -o  "LED_Blink_SC594_SHARC_Core0" @input-file.txt -lm
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES) $(OBJS) $(C_DEPS)  LED_Blink_SC594_SHARC_Core0
	-@echo ' '

.PHONY: all clean dependents

-include ../makefile.targets
