################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/SHARC_215xx/osal/adi_osal_arch_c.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/SHARC_215xx/osal/adi_osal_arch_int_table.c \
D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/SHARC_215xx/osal/adi_osal_freertos_arch_c.c 

SRC_OBJS += \
./system/osal/SHARC_215xx/adi_osal_arch_c.doj \
./system/osal/SHARC_215xx/adi_osal_arch_int_table.doj \
./system/osal/SHARC_215xx/adi_osal_freertos_arch_c.doj 

C_DEPS += \
./system/osal/SHARC_215xx/adi_osal_arch_c.d \
./system/osal/SHARC_215xx/adi_osal_arch_int_table.d \
./system/osal/SHARC_215xx/adi_osal_freertos_arch_c.d 


# Each subdirectory must supply rules for building sources it contributes
system/osal/SHARC_215xx/adi_osal_arch_c.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/SHARC_215xx/osal/adi_osal_arch_c.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/SHARC_215xx/adi_osal_arch_c.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/osal/SHARC_215xx/adi_osal_arch_int_table.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/SHARC_215xx/osal/adi_osal_arch_int_table.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/SHARC_215xx/adi_osal_arch_int_table.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/osal/SHARC_215xx/adi_osal_freertos_arch_c.doj: D:/RTOS/FreeRTOS-release-FreeRTOSv10.5.x/Source/portable/CCES/SHARC_215xx/osal/adi_osal_freertos_arch_c.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "system/osal/SHARC_215xx/adi_osal_freertos_arch_c.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


