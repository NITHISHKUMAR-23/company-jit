################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/ConfigSoftSwitches_EV_21593_SOM_LED_OFF.c \
D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/ConfigSoftSwitches_EV_21593_SOM_LED_ON.c \
D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/ConfigSoftSwitches_EV_SC594_SOM_LED_OFF.c \
D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/ConfigSoftSwitches_EV_SC594_SOM_LED_ON.c \
D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/ConfigSoftSwitches_EV_SOMCRR_EZLITE_LED_OFF.c \
D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/ConfigSoftSwitches_EV_SOMCRR_EZLITE_LED_ON.c \
D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/LED_Blink.c 

SRC_OBJS += \
./src/ConfigSoftSwitches_EV_21593_SOM_LED_OFF.doj \
./src/ConfigSoftSwitches_EV_21593_SOM_LED_ON.doj \
./src/ConfigSoftSwitches_EV_SC594_SOM_LED_OFF.doj \
./src/ConfigSoftSwitches_EV_SC594_SOM_LED_ON.doj \
./src/ConfigSoftSwitches_EV_SOMCRR_EZLITE_LED_OFF.doj \
./src/ConfigSoftSwitches_EV_SOMCRR_EZLITE_LED_ON.doj \
./src/LED_Blink.doj 

C_DEPS += \
./src/ConfigSoftSwitches_EV_21593_SOM_LED_OFF.d \
./src/ConfigSoftSwitches_EV_21593_SOM_LED_ON.d \
./src/ConfigSoftSwitches_EV_SC594_SOM_LED_OFF.d \
./src/ConfigSoftSwitches_EV_SC594_SOM_LED_ON.d \
./src/ConfigSoftSwitches_EV_SOMCRR_EZLITE_LED_OFF.d \
./src/ConfigSoftSwitches_EV_SOMCRR_EZLITE_LED_ON.d \
./src/LED_Blink.d 


# Each subdirectory must supply rules for building sources it contributes
src/ConfigSoftSwitches_EV_21593_SOM_LED_OFF.doj: D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/ConfigSoftSwitches_EV_21593_SOM_LED_OFF.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="LED_Blink_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-208703ee7140b5bc9186ca62010f6f8f.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "src/ConfigSoftSwitches_EV_21593_SOM_LED_OFF.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/ConfigSoftSwitches_EV_21593_SOM_LED_ON.doj: D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/ConfigSoftSwitches_EV_21593_SOM_LED_ON.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="LED_Blink_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-208703ee7140b5bc9186ca62010f6f8f.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "src/ConfigSoftSwitches_EV_21593_SOM_LED_ON.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/ConfigSoftSwitches_EV_SC594_SOM_LED_OFF.doj: D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/ConfigSoftSwitches_EV_SC594_SOM_LED_OFF.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="LED_Blink_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-208703ee7140b5bc9186ca62010f6f8f.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "src/ConfigSoftSwitches_EV_SC594_SOM_LED_OFF.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/ConfigSoftSwitches_EV_SC594_SOM_LED_ON.doj: D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/ConfigSoftSwitches_EV_SC594_SOM_LED_ON.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="LED_Blink_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-208703ee7140b5bc9186ca62010f6f8f.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "src/ConfigSoftSwitches_EV_SC594_SOM_LED_ON.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/ConfigSoftSwitches_EV_SOMCRR_EZLITE_LED_OFF.doj: D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/ConfigSoftSwitches_EV_SOMCRR_EZLITE_LED_OFF.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="LED_Blink_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-208703ee7140b5bc9186ca62010f6f8f.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "src/ConfigSoftSwitches_EV_SOMCRR_EZLITE_LED_OFF.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/ConfigSoftSwitches_EV_SOMCRR_EZLITE_LED_ON.doj: D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/ConfigSoftSwitches_EV_SOMCRR_EZLITE_LED_ON.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="LED_Blink_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-208703ee7140b5bc9186ca62010f6f8f.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "src/ConfigSoftSwitches_EV_SOMCRR_EZLITE_LED_ON.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/LED_Blink.doj: D:/Pheripheral\ configuration/gpio/gpio/LED_Blink/LED_Blink.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="LED_Blink_21593_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-208703ee7140b5bc9186ca62010f6f8f.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -absolute-path-dependencies -gnu-style-dependencies -MD -Mo "src/LED_Blink.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


