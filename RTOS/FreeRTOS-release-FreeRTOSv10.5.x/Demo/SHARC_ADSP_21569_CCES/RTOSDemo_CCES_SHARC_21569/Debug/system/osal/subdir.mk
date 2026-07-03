################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_critical.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_event.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_init.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_message.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_mutex.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_rtl_lock.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_sem.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_thread.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_timing.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_tls.c 

SRC_OBJS += \
./system/osal/adi_osal_freertos.doj \
./system/osal/adi_osal_freertos_critical.doj \
./system/osal/adi_osal_freertos_event.doj \
./system/osal/adi_osal_freertos_init.doj \
./system/osal/adi_osal_freertos_message.doj \
./system/osal/adi_osal_freertos_mutex.doj \
./system/osal/adi_osal_freertos_rtl_lock.doj \
./system/osal/adi_osal_freertos_sem.doj \
./system/osal/adi_osal_freertos_thread.doj \
./system/osal/adi_osal_freertos_timing.doj \
./system/osal/adi_osal_freertos_tls.doj 

C_DEPS += \
./system/osal/adi_osal_freertos.d \
./system/osal/adi_osal_freertos_critical.d \
./system/osal/adi_osal_freertos_event.d \
./system/osal/adi_osal_freertos_init.d \
./system/osal/adi_osal_freertos_message.d \
./system/osal/adi_osal_freertos_mutex.d \
./system/osal/adi_osal_freertos_rtl_lock.d \
./system/osal/adi_osal_freertos_sem.d \
./system/osal/adi_osal_freertos_thread.d \
./system/osal/adi_osal_freertos_timing.d \
./system/osal/adi_osal_freertos_tls.d 


# Each subdirectory must supply rules for building sources it contributes
system/osal/adi_osal_freertos.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/adi_osal_freertos.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/osal/adi_osal_freertos_critical.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_critical.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/adi_osal_freertos_critical.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/osal/adi_osal_freertos_event.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_event.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/adi_osal_freertos_event.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/osal/adi_osal_freertos_init.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_init.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/adi_osal_freertos_init.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/osal/adi_osal_freertos_message.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_message.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/adi_osal_freertos_message.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/osal/adi_osal_freertos_mutex.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_mutex.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/adi_osal_freertos_mutex.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/osal/adi_osal_freertos_rtl_lock.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_rtl_lock.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/adi_osal_freertos_rtl_lock.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/osal/adi_osal_freertos_sem.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_sem.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/adi_osal_freertos_sem.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/osal/adi_osal_freertos_thread.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_thread.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/adi_osal_freertos_thread.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/osal/adi_osal_freertos_timing.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_timing.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/adi_osal_freertos_timing.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/osal/adi_osal_freertos_tls.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/osal/adi_osal_freertos_tls.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/adi_osal_freertos_tls.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


