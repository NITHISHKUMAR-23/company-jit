################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
ASM_SRCS += \
../src/System/Framework/Autdet.asm \
../src/System/Framework/Downsampling.asm \
../src/System/Framework/SPI_ISR.asm 

DOJ_SRCS += \
../src/System/Framework/Init_Struct_Core1.doj \
../src/System/Framework/Init_Struct_Core1_Source.doj \
../src/System/Framework/Receiver_ISR.doj \
../src/System/Framework/SPI0_Func.doj \
../src/System/Framework/SPI1_Fun.doj \
../src/System/Framework/SPI1_Optical.doj \
../src/System/Framework/SPIRead.doj \
../src/System/Framework/SPI_Interrupts.doj \
../src/System/Framework/Txmitter.doj 

C_SRCS += \
../src/System/Framework/ConfigSoftSwitches_EV_21593_SOM.c \
../src/System/Framework/Decoder_Core1.c \
../src/System/Framework/GPIO.c \
../src/System/Framework/Main_Core1.c \
../src/System/Framework/System_Init.c \
../src/System/Framework/System_Modules.c \
../src/System/Framework/Tx_Rx_Handler.c \
../src/System/Framework/Word_Addressing_Core1.c 

SRC_OBJS += \
./src/System/Framework/Autdet.doj \
./src/System/Framework/ConfigSoftSwitches_EV_21593_SOM.doj \
./src/System/Framework/Decoder_Core1.doj \
./src/System/Framework/Downsampling.doj \
./src/System/Framework/GPIO.doj \
./src/System/Framework/Main_Core1.doj \
./src/System/Framework/SPI_ISR.doj \
./src/System/Framework/System_Init.doj \
./src/System/Framework/System_Modules.doj \
./src/System/Framework/Tx_Rx_Handler.doj \
./src/System/Framework/Word_Addressing_Core1.doj 

ASM_DEPS += \
./src/System/Framework/Autdet.d \
./src/System/Framework/Downsampling.d \
./src/System/Framework/SPI_ISR.d 

C_DEPS += \
./src/System/Framework/ConfigSoftSwitches_EV_21593_SOM.d \
./src/System/Framework/Decoder_Core1.d \
./src/System/Framework/GPIO.d \
./src/System/Framework/Main_Core1.d \
./src/System/Framework/System_Init.d \
./src/System/Framework/System_Modules.d \
./src/System/Framework/Tx_Rx_Handler.d \
./src/System/Framework/Word_Addressing_Core1.d 


# Each subdirectory must supply rules for building sources it contributes
src/System/Framework/Autdet.doj: ../src/System/Framework/Autdet.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -si-revision any -g -DCORE1 -D_DEBUG @includes-61f6bf9d7ce64e05f9f3040dcd70264e.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/System/Framework/Autdet.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/ConfigSoftSwitches_EV_21593_SOM.doj: ../src/System/Framework/ConfigSoftSwitches_EV_21593_SOM.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-8ed3ab3e2629072de30378482a77a9cf.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/ConfigSoftSwitches_EV_21593_SOM.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/Decoder_Core1.doj: ../src/System/Framework/Decoder_Core1.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-8ed3ab3e2629072de30378482a77a9cf.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/Decoder_Core1.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/Downsampling.doj: ../src/System/Framework/Downsampling.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -si-revision any -g -DCORE1 -D_DEBUG @includes-61f6bf9d7ce64e05f9f3040dcd70264e.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/System/Framework/Downsampling.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/GPIO.doj: ../src/System/Framework/GPIO.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-8ed3ab3e2629072de30378482a77a9cf.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/GPIO.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/Main_Core1.doj: ../src/System/Framework/Main_Core1.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-8ed3ab3e2629072de30378482a77a9cf.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/Main_Core1.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/SPI_ISR.doj: ../src/System/Framework/SPI_ISR.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -si-revision any -g -DCORE1 -D_DEBUG @includes-61f6bf9d7ce64e05f9f3040dcd70264e.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/System/Framework/SPI_ISR.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/System_Init.doj: ../src/System/Framework/System_Init.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-8ed3ab3e2629072de30378482a77a9cf.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/System_Init.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/System_Modules.doj: ../src/System/Framework/System_Modules.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-8ed3ab3e2629072de30378482a77a9cf.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/System_Modules.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/Tx_Rx_Handler.doj: ../src/System/Framework/Tx_Rx_Handler.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-8ed3ab3e2629072de30378482a77a9cf.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/Tx_Rx_Handler.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/Word_Addressing_Core1.doj: ../src/System/Framework/Word_Addressing_Core1.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE1 -D_DEBUG -DADI_DEBUG @includes-8ed3ab3e2629072de30378482a77a9cf.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-32 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/Word_Addressing_Core1.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


