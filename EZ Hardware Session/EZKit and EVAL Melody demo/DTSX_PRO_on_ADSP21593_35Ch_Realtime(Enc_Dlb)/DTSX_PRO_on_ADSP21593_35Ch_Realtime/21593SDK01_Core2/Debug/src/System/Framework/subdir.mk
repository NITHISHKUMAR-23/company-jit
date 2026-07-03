################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
ASM_SRCS += \
../src/System/Framework/Downsampling.asm 

DOJ_SRCS += \
../src/System/Framework/Init_Struct_Core2.doj 

C_SRCS += \
../src/System/Framework/Decoder_Core2.c \
../src/System/Framework/GPIO.c \
../src/System/Framework/Main_Core2.c \
../src/System/Framework/PostProcessing.c \
../src/System/Framework/Word_Addressing_Core2.c 

C_DEPS += \
./src/System/Framework/Decoder_Core2.d \
./src/System/Framework/GPIO.d \
./src/System/Framework/Main_Core2.d \
./src/System/Framework/PostProcessing.d \
./src/System/Framework/Word_Addressing_Core2.d 

SRC_OBJS += \
./src/System/Framework/Decoder_Core2.doj \
./src/System/Framework/Downsampling.doj \
./src/System/Framework/GPIO.doj \
./src/System/Framework/Main_Core2.doj \
./src/System/Framework/PostProcessing.doj \
./src/System/Framework/Word_Addressing_Core2.doj 

ASM_DEPS += \
./src/System/Framework/Downsampling.d 


# Each subdirectory must supply rules for building sources it contributes
src/System/Framework/Decoder_Core2.doj: ../src/System/Framework/Decoder_Core2.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core2" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE2 -D_DEBUG -DADI_MCAPI @includes-a318ad7d378d42081e06695e469bae54.txt -enum-is-int -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/Decoder_Core2.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/Downsampling.doj: ../src/System/Framework/Downsampling.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21593SDK01_Core2" -proc ADSP-21593 -si-revision any -g -DCORE2 -D_DEBUG -DADI_MCAPI @includes-b8e320e29dcf71f328223af7514cf29b.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/System/Framework/Downsampling.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/GPIO.doj: ../src/System/Framework/GPIO.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core2" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE2 -D_DEBUG -DADI_MCAPI @includes-a318ad7d378d42081e06695e469bae54.txt -enum-is-int -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/GPIO.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/Main_Core2.doj: ../src/System/Framework/Main_Core2.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core2" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE2 -D_DEBUG -DADI_MCAPI @includes-a318ad7d378d42081e06695e469bae54.txt -enum-is-int -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/Main_Core2.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/PostProcessing.doj: ../src/System/Framework/PostProcessing.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core2" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE2 -D_DEBUG -DADI_MCAPI @includes-a318ad7d378d42081e06695e469bae54.txt -enum-is-int -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/PostProcessing.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/System/Framework/Word_Addressing_Core2.doj: ../src/System/Framework/Word_Addressing_Core2.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593SDK01_Core2" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov100 -g -DCORE2 -D_DEBUG -DADI_MCAPI @includes-a318ad7d378d42081e06695e469bae54.txt -enum-is-int -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/System/Framework/Word_Addressing_Core2.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


