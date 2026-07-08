################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
ASM_SRCS += \
../src/System/Framework/Receiver_ISR.asm \
../src/System/Framework/SPIRead.asm \
../src/System/Framework/SPI_ISR.asm \
../src/System/Framework/Txmitter.asm \
../src/System/Framework/init_struct.asm 

C_SRCS += \
../src/System/Framework/Decoder.c \
../src/System/Framework/GPIO.c \
../src/System/Framework/Main.c \
../src/System/Framework/PostProcessing.c \
../src/System/Framework/SPI0_func.c \
../src/System/Framework/SPI_Interrupts.c \
../src/System/Framework/System_Init.c \
../src/System/Framework/System_Modules.c \
../src/System/Framework/Tx_Rx_Handler.c 

C_DEPS += \
./src/System/Framework/Decoder.d \
./src/System/Framework/GPIO.d \
./src/System/Framework/Main.d \
./src/System/Framework/PostProcessing.d \
./src/System/Framework/SPI0_func.d \
./src/System/Framework/SPI_Interrupts.d \
./src/System/Framework/System_Init.d \
./src/System/Framework/System_Modules.d \
./src/System/Framework/Tx_Rx_Handler.d 

SRC_OBJS += \
./src/System/Framework/Decoder.doj \
./src/System/Framework/GPIO.doj \
./src/System/Framework/Main.doj \
./src/System/Framework/PostProcessing.doj \
./src/System/Framework/Receiver_ISR.doj \
./src/System/Framework/SPI0_func.doj \
./src/System/Framework/SPIRead.doj \
./src/System/Framework/SPI_ISR.doj \
./src/System/Framework/SPI_Interrupts.doj \
./src/System/Framework/System_Init.doj \
./src/System/Framework/System_Modules.doj \
./src/System/Framework/Tx_Rx_Handler.doj \
./src/System/Framework/Txmitter.doj \
./src/System/Framework/init_struct.doj 

ASM_DEPS += \
./src/System/Framework/Receiver_ISR.d \
./src/System/Framework/SPIRead.d \
./src/System/Framework/SPI_ISR.d \
./src/System/Framework/Txmitter.d \
./src/System/Framework/init_struct.d 


# Each subdirectory must supply rules for building sources it contributes
src/System/Framework/Decoder.doj: ../src/System/Framework/Decoder.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-843c6aac2d806178ab260a16ed137280.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/Decoder.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/GPIO.doj: ../src/System/Framework/GPIO.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-843c6aac2d806178ab260a16ed137280.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/GPIO.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/Main.doj: ../src/System/Framework/Main.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-843c6aac2d806178ab260a16ed137280.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/Main.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/PostProcessing.doj: ../src/System/Framework/PostProcessing.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-843c6aac2d806178ab260a16ed137280.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/PostProcessing.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/Receiver_ISR.doj: ../src/System/Framework/Receiver_ISR.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -si-revision 0.0 -g -DCORE0 -D_DEBUG @includes-22fb32d8821546d7265af50e73bef5aa.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/System/Framework/Receiver_ISR.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/SPI0_func.doj: ../src/System/Framework/SPI0_func.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-843c6aac2d806178ab260a16ed137280.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/SPI0_func.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/SPIRead.doj: ../src/System/Framework/SPIRead.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -si-revision 0.0 -g -DCORE0 -D_DEBUG @includes-22fb32d8821546d7265af50e73bef5aa.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/System/Framework/SPIRead.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/SPI_ISR.doj: ../src/System/Framework/SPI_ISR.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -si-revision 0.0 -g -DCORE0 -D_DEBUG @includes-22fb32d8821546d7265af50e73bef5aa.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/System/Framework/SPI_ISR.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/SPI_Interrupts.doj: ../src/System/Framework/SPI_Interrupts.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-843c6aac2d806178ab260a16ed137280.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/SPI_Interrupts.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/System_Init.doj: ../src/System/Framework/System_Init.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-843c6aac2d806178ab260a16ed137280.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/System_Init.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/System_Modules.doj: ../src/System/Framework/System_Modules.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-843c6aac2d806178ab260a16ed137280.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/System_Modules.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/Tx_Rx_Handler.doj: ../src/System/Framework/Tx_Rx_Handler.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision 0.0 -O -Ov100 -g -DCORE0 -D_DEBUG @includes-843c6aac2d806178ab260a16ed137280.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/Tx_Rx_Handler.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/Txmitter.doj: ../src/System/Framework/Txmitter.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -si-revision 0.0 -g -DCORE0 -D_DEBUG @includes-22fb32d8821546d7265af50e73bef5aa.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/System/Framework/Txmitter.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/init_struct.doj: ../src/System/Framework/init_struct.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21569SDK01" -proc ADSP-21569 -si-revision 0.0 -g -DCORE0 -D_DEBUG @includes-22fb32d8821546d7265af50e73bef5aa.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/System/Framework/init_struct.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


