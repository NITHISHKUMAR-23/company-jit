################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LDF_SRCS += \
../src/sc59x_init_Core1.ldf 

C_SRCS += \
../src/SC59x_InitPreload_code.c \
../src/adi_clockrates_SC59x_config.c \
../src/adi_dmc.c \
../src/adi_dmc_SC59x_config.c \
../src/adi_pwr_SC59x_config.c \
../src/adi_smpu_SC59x_config.c 

SRC_OBJS += \
./src/SC59x_InitPreload_code.doj \
./src/adi_clockrates_SC59x_config.doj \
./src/adi_dmc.doj \
./src/adi_dmc_SC59x_config.doj \
./src/adi_pwr_SC59x_config.doj \
./src/adi_smpu_SC59x_config.doj 

C_DEPS += \
./src/SC59x_InitPreload_code.d \
./src/adi_clockrates_SC59x_config.d \
./src/adi_dmc.d \
./src/adi_dmc_SC59x_config.d \
./src/adi_pwr_SC59x_config.d \
./src/adi_smpu_SC59x_config.d 


# Each subdirectory must supply rules for building sources it contributes
src/SC59x_InitPreload_code.doj: ../src/SC59x_InitPreload_code.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593_init_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov0 -DNDEBUG -DCORE1 @includes-67b05e6db0d6a65fa8e85b47f3e40404.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/SC59x_InitPreload_code.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/adi_clockrates_SC59x_config.doj: ../src/adi_clockrates_SC59x_config.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593_init_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov0 -DNDEBUG -DCORE1 @includes-67b05e6db0d6a65fa8e85b47f3e40404.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/adi_clockrates_SC59x_config.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/adi_dmc.doj: ../src/adi_dmc.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593_init_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov0 -DNDEBUG -DCORE1 @includes-67b05e6db0d6a65fa8e85b47f3e40404.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/adi_dmc.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/adi_dmc_SC59x_config.doj: ../src/adi_dmc_SC59x_config.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593_init_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov0 -DNDEBUG -DCORE1 @includes-67b05e6db0d6a65fa8e85b47f3e40404.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/adi_dmc_SC59x_config.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/adi_pwr_SC59x_config.doj: ../src/adi_pwr_SC59x_config.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593_init_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov0 -DNDEBUG -DCORE1 @includes-67b05e6db0d6a65fa8e85b47f3e40404.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/adi_pwr_SC59x_config.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/adi_smpu_SC59x_config.doj: ../src/adi_smpu_SC59x_config.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21593_init_Core1" -proc ADSP-21593 -flags-compiler --no_wrap_diagnostics -si-revision any -O -Ov0 -DNDEBUG -DCORE1 @includes-67b05e6db0d6a65fa8e85b47f3e40404.txt -structs-do-not-overlap -no-const-strings -no-multiline -warn-protos -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/adi_smpu_SC59x_config.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


