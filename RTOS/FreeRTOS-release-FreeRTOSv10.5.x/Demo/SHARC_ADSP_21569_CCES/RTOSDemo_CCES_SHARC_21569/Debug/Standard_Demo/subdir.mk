################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/Common/Minimal/BlockQ.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/Common/Minimal/PollQ.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/Common/Minimal/StaticAllocation.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/Common/Minimal/death.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/Common/Minimal/flash.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/Common/Minimal/recmutex.c 

SRC_OBJS += \
./Standard_Demo/BlockQ.doj \
./Standard_Demo/PollQ.doj \
./Standard_Demo/StaticAllocation.doj \
./Standard_Demo/death.doj \
./Standard_Demo/flash.doj \
./Standard_Demo/recmutex.doj 

C_DEPS += \
./Standard_Demo/BlockQ.d \
./Standard_Demo/PollQ.d \
./Standard_Demo/StaticAllocation.d \
./Standard_Demo/death.d \
./Standard_Demo/flash.d \
./Standard_Demo/recmutex.d 


# Each subdirectory must supply rules for building sources it contributes
Standard_Demo/BlockQ.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/Common/Minimal/BlockQ.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "Standard_Demo/BlockQ.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Standard_Demo/PollQ.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/Common/Minimal/PollQ.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "Standard_Demo/PollQ.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Standard_Demo/StaticAllocation.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/Common/Minimal/StaticAllocation.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "Standard_Demo/StaticAllocation.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Standard_Demo/death.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/Common/Minimal/death.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "Standard_Demo/death.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Standard_Demo/flash.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/Common/Minimal/flash.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "Standard_Demo/flash.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Standard_Demo/recmutex.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Demo/Common/Minimal/recmutex.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "Standard_Demo/recmutex.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


