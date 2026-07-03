################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/event_groups.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/list.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/queue.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/tasks.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/timers.c 

SRC_OBJS += \
./system/FreeRTOS/event_groups.doj \
./system/FreeRTOS/list.doj \
./system/FreeRTOS/queue.doj \
./system/FreeRTOS/tasks.doj \
./system/FreeRTOS/timers.doj 

C_DEPS += \
./system/FreeRTOS/event_groups.d \
./system/FreeRTOS/list.d \
./system/FreeRTOS/queue.d \
./system/FreeRTOS/tasks.d \
./system/FreeRTOS/timers.d 


# Each subdirectory must supply rules for building sources it contributes
system/FreeRTOS/event_groups.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/event_groups.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/FreeRTOS/event_groups.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/FreeRTOS/list.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/list.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/FreeRTOS/list.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/FreeRTOS/queue.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/queue.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/FreeRTOS/queue.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/FreeRTOS/tasks.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/tasks.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/FreeRTOS/tasks.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/FreeRTOS/timers.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/timers.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/FreeRTOS/timers.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


