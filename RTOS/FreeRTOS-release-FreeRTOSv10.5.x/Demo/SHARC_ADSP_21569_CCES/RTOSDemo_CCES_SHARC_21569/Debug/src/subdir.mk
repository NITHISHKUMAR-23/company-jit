################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/Mutex.c \
../src/ParTest.c \
../src/Pipes_Message_queues.c \
../src/Priority_Round_Robin.c \
../src/Semaphore.c \
../src/Threads.c \
../src/Time_Slice_Task_Schedule.c 

SRC_OBJS += \
./src/Mutex.doj \
./src/ParTest.doj \
./src/Pipes_Message_queues.doj \
./src/Priority_Round_Robin.doj \
./src/Semaphore.doj \
./src/Threads.doj \
./src/Time_Slice_Task_Schedule.doj 

C_DEPS += \
./src/Mutex.d \
./src/ParTest.d \
./src/Pipes_Message_queues.d \
./src/Priority_Round_Robin.d \
./src/Semaphore.d \
./src/Threads.d \
./src/Time_Slice_Task_Schedule.d 


# Each subdirectory must supply rules for building sources it contributes
src/Mutex.doj: ../src/Mutex.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/Mutex.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/ParTest.doj: ../src/ParTest.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/ParTest.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/Pipes_Message_queues.doj: ../src/Pipes_Message_queues.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/Pipes_Message_queues.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/Priority_Round_Robin.doj: ../src/Priority_Round_Robin.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/Priority_Round_Robin.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/Semaphore.doj: ../src/Semaphore.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/Semaphore.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/Threads.doj: ../src/Threads.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/Threads.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/Time_Slice_Task_Schedule.doj: ../src/Time_Slice_Task_Schedule.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="RTOSDemo_CCES_SHARC_21569" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -save-temps -path-output ./$(@D) -ED -D_DEBUG -D__ADI_FREERTOS -DCORE0 -DADI_DEBUG @includes-68db4a61556bbb42fc11056e2dff00f6.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -threads -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/Time_Slice_Task_Schedule.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


