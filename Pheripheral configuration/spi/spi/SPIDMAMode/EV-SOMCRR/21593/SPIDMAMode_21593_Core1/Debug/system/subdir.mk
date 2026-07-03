################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/Pheripheral\ configuration/spi/spi/SPIDMAMode/ConfigSoftSwitches_EV_21593_SOM.c \
D:/Pheripheral\ configuration/spi/spi/SPIDMAMode/ConfigSoftSwitches_EV_SOMCRR_EZKIT.c \
D:/Pheripheral\ configuration/spi/spi/SPIDMAMode/ConfigSoftSwitches_SOMCRR_EZLITE.c \
../system/adi_initialize.c 

SRC_OBJS += \
./system/ConfigSoftSwitches_EV_21593_SOM.doj \
./system/ConfigSoftSwitches_EV_SOMCRR_EZKIT.doj \
./system/ConfigSoftSwitches_SOMCRR_EZLITE.doj \
./system/adi_initialize.doj 

C_DEPS += \
./system/ConfigSoftSwitches_EV_21593_SOM.d \
./system/ConfigSoftSwitches_EV_SOMCRR_EZKIT.d \
./system/ConfigSoftSwitches_SOMCRR_EZLITE.d \
./system/adi_initialize.d 


# Each subdirectory must supply rules for building sources it contributes
system/ConfigSoftSwitches_EV_21593_SOM.doj: D:/Pheripheral\ configuration/spi/spi/SPIDMAMode/ConfigSoftSwitches_EV_21593_SOM.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="SPIDMAMode_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI -DADI_DEBUG @includes-0eaf8e76b98b9c6f293f8adb7677aec2.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "system/ConfigSoftSwitches_EV_21593_SOM.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/ConfigSoftSwitches_EV_SOMCRR_EZKIT.doj: D:/Pheripheral\ configuration/spi/spi/SPIDMAMode/ConfigSoftSwitches_EV_SOMCRR_EZKIT.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="SPIDMAMode_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI -DADI_DEBUG @includes-0eaf8e76b98b9c6f293f8adb7677aec2.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "system/ConfigSoftSwitches_EV_SOMCRR_EZKIT.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/ConfigSoftSwitches_SOMCRR_EZLITE.doj: D:/Pheripheral\ configuration/spi/spi/SPIDMAMode/ConfigSoftSwitches_SOMCRR_EZLITE.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="SPIDMAMode_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI -DADI_DEBUG @includes-0eaf8e76b98b9c6f293f8adb7677aec2.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "system/ConfigSoftSwitches_SOMCRR_EZLITE.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/adi_initialize.doj: ../system/adi_initialize.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="SPIDMAMode_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE1 -D_DEBUG -DADI_MCAPI -DADI_DEBUG @includes-0eaf8e76b98b9c6f293f8adb7677aec2.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "system/adi_initialize.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


