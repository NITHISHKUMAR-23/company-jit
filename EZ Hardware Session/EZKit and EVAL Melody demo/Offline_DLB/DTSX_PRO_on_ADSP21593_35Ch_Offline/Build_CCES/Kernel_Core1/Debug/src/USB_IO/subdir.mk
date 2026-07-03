################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/EZ\ Hardware\ Session/EZKit\ and\ EVAL\ Melody\ demo/Offline_DLB/DTSX_PRO_on_ADSP21593_35Ch_Offline/Core1/Kernel/src/USB_IO/ConfigSoftSwitches_EV_21593_SOM.c \
D:/EZ\ Hardware\ Session/EZKit\ and\ EVAL\ Melody\ demo/Offline_DLB/DTSX_PRO_on_ADSP21593_35Ch_Offline/Core1/Kernel/src/USB_IO/ConfigSoftSwitches_EV_SOMCRR_EZKIT.c \
D:/EZ\ Hardware\ Session/EZKit\ and\ EVAL\ Melody\ demo/Offline_DLB/DTSX_PRO_on_ADSP21593_35Ch_Offline/Core1/Kernel/src/USB_IO/usbio.c \
D:/EZ\ Hardware\ Session/EZKit\ and\ EVAL\ Melody\ demo/Offline_DLB/DTSX_PRO_on_ADSP21593_35Ch_Offline/Core1/Kernel/src/USB_IO/usboptions.c 

SRC_OBJS += \
./src/USB_IO/ConfigSoftSwitches_EV_21593_SOM.doj \
./src/USB_IO/ConfigSoftSwitches_EV_SOMCRR_EZKIT.doj \
./src/USB_IO/usbio.doj \
./src/USB_IO/usboptions.doj 

C_DEPS += \
./src/USB_IO/ConfigSoftSwitches_EV_21593_SOM.d \
./src/USB_IO/ConfigSoftSwitches_EV_SOMCRR_EZKIT.d \
./src/USB_IO/usbio.d \
./src/USB_IO/usboptions.d 


# Each subdirectory must supply rules for building sources it contributes
src/USB_IO/ConfigSoftSwitches_EV_21593_SOM.doj: D:/EZ\ Hardware\ Session/EZKit\ and\ EVAL\ Melody\ demo/Offline_DLB/DTSX_PRO_on_ADSP21593_35Ch_Offline/Core1/Kernel/src/USB_IO/ConfigSoftSwitches_EV_21593_SOM.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="Kernel_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_INCLUDE_LEGACY_SYSREG_NAMES -DNET2272_BULK -DADI_MCAPI @includes-32ef59ff771fd561679f2367174f1e52.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/USB_IO/ConfigSoftSwitches_EV_21593_SOM.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/USB_IO/ConfigSoftSwitches_EV_SOMCRR_EZKIT.doj: D:/EZ\ Hardware\ Session/EZKit\ and\ EVAL\ Melody\ demo/Offline_DLB/DTSX_PRO_on_ADSP21593_35Ch_Offline/Core1/Kernel/src/USB_IO/ConfigSoftSwitches_EV_SOMCRR_EZKIT.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="Kernel_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_INCLUDE_LEGACY_SYSREG_NAMES -DNET2272_BULK -DADI_MCAPI @includes-32ef59ff771fd561679f2367174f1e52.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/USB_IO/ConfigSoftSwitches_EV_SOMCRR_EZKIT.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/USB_IO/usbio.doj: D:/EZ\ Hardware\ Session/EZKit\ and\ EVAL\ Melody\ demo/Offline_DLB/DTSX_PRO_on_ADSP21593_35Ch_Offline/Core1/Kernel/src/USB_IO/usbio.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="Kernel_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_INCLUDE_LEGACY_SYSREG_NAMES -DNET2272_BULK -DADI_MCAPI @includes-32ef59ff771fd561679f2367174f1e52.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/USB_IO/usbio.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/USB_IO/usboptions.doj: D:/EZ\ Hardware\ Session/EZKit\ and\ EVAL\ Melody\ demo/Offline_DLB/DTSX_PRO_on_ADSP21593_35Ch_Offline/Core1/Kernel/src/USB_IO/usboptions.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="Kernel_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_INCLUDE_LEGACY_SYSREG_NAMES -DNET2272_BULK -DADI_MCAPI @includes-32ef59ff771fd561679f2367174f1e52.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/USB_IO/usboptions.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


