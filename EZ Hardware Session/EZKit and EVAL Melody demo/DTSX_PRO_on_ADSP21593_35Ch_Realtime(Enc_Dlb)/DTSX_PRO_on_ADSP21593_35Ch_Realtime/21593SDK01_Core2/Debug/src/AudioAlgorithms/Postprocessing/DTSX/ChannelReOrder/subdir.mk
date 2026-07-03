################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
ASM_SRCS += \
../src/AudioAlgorithms/Postprocessing/DTSX/ChannelReOrder/ChanReOrder_Dtsx.asm 

SRC_OBJS += \
./src/AudioAlgorithms/Postprocessing/DTSX/ChannelReOrder/ChanReOrder_Dtsx.doj 

ASM_DEPS += \
./src/AudioAlgorithms/Postprocessing/DTSX/ChannelReOrder/ChanReOrder_Dtsx.d 


# Each subdirectory must supply rules for building sources it contributes
src/AudioAlgorithms/Postprocessing/DTSX/ChannelReOrder/ChanReOrder_Dtsx.doj: ../src/AudioAlgorithms/Postprocessing/DTSX/ChannelReOrder/ChanReOrder_Dtsx.asm
	@echo 'Building file: $<'
	@echo 'Invoking: CrossCore SHARC Assembler'
	easm21k -file-attr ProjectName="21593SDK01_Core2" -proc ADSP-21593 -si-revision any -g -DCORE2 -D_DEBUG -DADI_MCAPI @includes-b8e320e29dcf71f328223af7514cf29b.txt -swc -char-size-8 -gnu-style-dependencies -MM -Mo "src/AudioAlgorithms/Postprocessing/DTSX/ChannelReOrder/ChanReOrder_Dtsx.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


