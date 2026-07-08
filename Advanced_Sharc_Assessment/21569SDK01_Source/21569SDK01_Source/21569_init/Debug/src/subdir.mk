################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LDF_SRCS += \
../src/2156x_init_Core0.ldf 

C_SRCS += \
../src/2156x_InitPreload_code.c \
../src/adi_clockrates_2156x_config.c \
../src/adi_dmc.c \
../src/adi_dmc_2156x_config.c \
../src/adi_pwr_2156x_config.c \
../src/adi_smpu_2156x_config.c 

SRC_OBJS += \
./src/2156x_InitPreload_code.doj \
./src/adi_clockrates_2156x_config.doj \
./src/adi_dmc.doj \
./src/adi_dmc_2156x_config.doj \
./src/adi_pwr_2156x_config.doj \
./src/adi_smpu_2156x_config.doj 

C_DEPS += \
./src/2156x_InitPreload_code.d \
./src/adi_clockrates_2156x_config.d \
./src/adi_dmc.d \
./src/adi_dmc_2156x_config.d \
./src/adi_pwr_2156x_config.d \
./src/adi_smpu_2156x_config.d 


# Each subdirectory must supply rules for building sources it contributes
src/2156x_InitPreload_code.doj: ../src/2156x_InitPreload_code.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569_init" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE0 -D_DEBUG @includes-a20828c440f19f28387b0febcb1054cb.txt -structs-do-not-overlap -no-const-strings -no-multiline -misra -misra-strict -misra-no-cross-module -misra-no-runtime -misra-testing -misra-suppress-advisory -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/2156x_InitPreload_code.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/adi_clockrates_2156x_config.doj: ../src/adi_clockrates_2156x_config.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569_init" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE0 -D_DEBUG @includes-a20828c440f19f28387b0febcb1054cb.txt -structs-do-not-overlap -no-const-strings -no-multiline -misra -misra-strict -misra-no-cross-module -misra-no-runtime -misra-testing -misra-suppress-advisory -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/adi_clockrates_2156x_config.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/adi_dmc.doj: ../src/adi_dmc.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569_init" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE0 -D_DEBUG @includes-a20828c440f19f28387b0febcb1054cb.txt -structs-do-not-overlap -no-const-strings -no-multiline -misra -misra-strict -misra-no-cross-module -misra-no-runtime -misra-testing -misra-suppress-advisory -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/adi_dmc.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/adi_dmc_2156x_config.doj: ../src/adi_dmc_2156x_config.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569_init" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE0 -D_DEBUG @includes-a20828c440f19f28387b0febcb1054cb.txt -structs-do-not-overlap -no-const-strings -no-multiline -misra -misra-strict -misra-no-cross-module -misra-no-runtime -misra-testing -misra-suppress-advisory -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/adi_dmc_2156x_config.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/adi_pwr_2156x_config.doj: ../src/adi_pwr_2156x_config.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569_init" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE0 -D_DEBUG @includes-a20828c440f19f28387b0febcb1054cb.txt -structs-do-not-overlap -no-const-strings -no-multiline -misra -misra-strict -misra-no-cross-module -misra-no-runtime -misra-testing -misra-suppress-advisory -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/adi_pwr_2156x_config.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/adi_smpu_2156x_config.doj: ../src/adi_smpu_2156x_config.c
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC C/C++ Compiler'
	cc21k -c -file-attr ProjectName="21569_init" -proc ADSP-21569 -flags-compiler --no_wrap_diagnostics -si-revision any -g -DCORE0 -D_DEBUG @includes-a20828c440f19f28387b0febcb1054cb.txt -structs-do-not-overlap -no-const-strings -no-multiline -misra -misra-strict -misra-no-cross-module -misra-no-runtime -misra-testing -misra-suppress-advisory -double-size-32 -char-size-8 -swc -gnu-style-dependencies -MD -Mo "src/adi_smpu_2156x_config.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


