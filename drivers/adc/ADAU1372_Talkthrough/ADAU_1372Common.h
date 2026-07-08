/*********************************************************************************
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * ADAU_1372Common.h
 *****************************************************************************/

/***********************************************************************************************************************/

#define ADAU1372_REG_CLK_CTRL			0x00
#define ADAU1372_REG_PLL_CTRL0			0x01
#define ADAU1372_REG_PLL_CTRL1			0x02
#define ADAU1372_REG_PLL_CTRL2			0x03
#define ADAU1372_REG_PLL_CTRL3			0x04
#define ADAU1372_REG_PLL_CTRL4			0x05
#define ADAU1372_REG_PLL_CTRL5			0x06
#define ADAU1372_REG_CLKOUT_SEL			0x07
#define ADAU1372_REG_RGTR				0x08
#define ADAU1372_REG_DAC_SOURCE			0x11
#define ADAU1372_REG_SOUT_SOURCE_0_1	0x13
#define ADAU1372_REG_SOUT_SOURCE_2_3	0x14
#define ADAU1372_REG_SOUT_SOURCE_4_5	0x15
#define ADAU1372_REG_SOUT_SOURCE_6_7	0x16
#define ADAU1372_REG_ADC_SDATA_CH		0x17
#define ADAU1372_REG_ASRCO_SOURCE_0_1	0x18
#define ADAU1372_REG_ASRCO_SOURCE_2_3	0x19
#define ADAU1372_REG_ASRC_MODE			0x1a
#define ADAU1372_REG_ADC_CTRL0			0x1b
#define ADAU1372_REG_ADC_CTRL1			0x1c
#define ADAU1372_REG_ADC_CTRL2			0x1d
#define ADAU1372_REG_ADC_CTRL3			0x1e
#define ADAU1372_REG_ADC0_VOL			0x1f
#define ADAU1372_REG_ADC1_VOL			0x20
#define ADAU1372_REG_ADC2_VOL			0x21
#define ADAU1372_REG_ADC3_VOL			0x22
#define ADAU1372_REG_PGA_CTRL0			0x23
#define ADAU1372_REG_PGA_CTRL1			0x24
#define ADAU1372_REG_PGA_CTRL2			0x25
#define ADAU1372_REG_PGA_CTRL3			0x26
#define ADAU1372_REG_PGA_STEP_CTRL		0x27
#define ADAU1372_REG_PGA_BOOST			0x28
#define ADAU1372_REG_POP_SPRS			0x29
#define ADAU1372_REG_TALKTHROUGH		0x2a
#define ADAU1372_REG_TALKTHROUGH_G0		0x2b
#define ADAU1372_REG_TALKTHROUGH_G1		0x2c
#define ADAU1372_REG_MICBIAS			0x2d
#define ADAU1372_REG_DAC_CTRL			0x2e
#define ADAU1372_REG_DAC0_VOL			0x2f
#define ADAU1372_REG_DAC1_VOL			0x30
#define ADAU1372_REG_OP_STAGE_MUTE		0x31
#define ADAU1372_REG_SAI0				0x32
#define ADAU1372_REG_SAI1				0x33
#define ADAU1372_REG_SOUT_CTRL			0x34
#define ADAU1372_REG_MODE_MP0			0x38
#define ADAU1372_REG_MODE_MP1			0x39
#define ADAU1372_REG_MODE_MP4			0x3c
#define ADAU1372_REG_MODE_MP5			0x3d
#define ADAU1372_REG_MODE_MP6			0x3e
#define ADAU1372_REG_PB_VOL_SET			0x3f
#define ADAU1372_REG_PB_VOL_CONV		0x40
#define ADAU1372_REG_DEBOUNCE_MODE		0x41
#define ADAU1372_REG_OP_STAGE_CTRL		0x43
#define ADAU1372_REG_DECIM_PWR			0x44
#define ADAU1372_REG_INTERP_PWR			0x45
#define ADAU1372_REG_BIAS_CTRL0			0x46
#define ADAU1372_REG_BIAS_CTRL1			0x47
#define ADAU1372_REG_PAD_CTRL0			0x48
#define ADAU1372_REG_PAD_CTRL1			0x49
#define ADAU1372_REG_PAD_CTRL2			0x4a
#define ADAU1372_REG_PAD_CTRL3			0x4b
#define ADAU1372_REG_PAD_CTRL4			0x4c
#define ADAU1372_REG_PAD_CTRL5			0x4d
/***********************************************************************************************************************/


/***********************************************************************************************************************

#define ADAU1372_REG_CLK_CTRL			0x0000
#define ADAU1372_REG_PLL_CTRL0			0x0001
#define ADAU1372_REG_PLL_CTRL1			0x0002
#define ADAU1372_REG_PLL_CTRL2			0x0003
#define ADAU1372_REG_PLL_CTRL3			0x0004
#define ADAU1372_REG_PLL_CTRL4			0x0005
#define ADAU1372_REG_PLL_CTRL5			0x0006
#define ADAU1372_REG_CLKOUT_SEL			0x0007
#define ADAU1372_REG_RGTR				0x0008
#define ADAU1372_REG_DAC_SOURCE			0x0011
#define ADAU1372_REG_SOUT_SOURCE_0_1	0x0013
#define ADAU1372_REG_SOUT_SOURCE_2_3	0x0014
#define ADAU1372_REG_SOUT_SOURCE_4_5	0x0015
#define ADAU1372_REG_SOUT_SOURCE_6_7	0x0016
#define ADAU1372_REG_ADC_SDATA_CH		0x0017
#define ADAU1372_REG_ASRCO_SOURCE_0_1	0x0018
#define ADAU1372_REG_ASRCO_SOURCE_2_3	0x0019
#define ADAU1372_REG_ASRC_MODE			0x001a
#define ADAU1372_REG_ADC_CTRL0			0x001b
#define ADAU1372_REG_ADC_CTRL1			0x001c
#define ADAU1372_REG_ADC_CTRL2			0x001d
#define ADAU1372_REG_ADC_CTRL3			0x001e
#define ADAU1372_REG_ADC0_VOL			0x001f
#define ADAU1372_REG_ADC1_VOL			0x0020
#define ADAU1372_REG_ADC2_VOL			0x0021
#define ADAU1372_REG_ADC3_VOL			0x0022
#define ADAU1372_REG_PGA_CTRL0			0x0023
#define ADAU1372_REG_PGA_CTRL1			0x0024
#define ADAU1372_REG_PGA_CTRL2			0x0025
#define ADAU1372_REG_PGA_CTRL3			0x0026
#define ADAU1372_REG_PGA_STEP_CTRL		0x0027
#define ADAU1372_REG_PGA_BOOST			0x0028
#define ADAU1372_REG_POP_SPRS			0x0029
#define ADAU1372_REG_TALKTHROUGH		0x002a
#define ADAU1372_REG_TALKTHROUGH_G0		0x002b
#define ADAU1372_REG_TALKTHROUGH_G1		0x002c
#define ADAU1372_REG_MICBIAS			0x002d
#define ADAU1372_REG_DAC_CTRL			0x002e
#define ADAU1372_REG_DAC0_VOL			0x002f
#define ADAU1372_REG_DAC1_VOL			0x0030
#define ADAU1372_REG_OP_STAGE_MUTE		0x0031
#define ADAU1372_REG_SAI0				0x0032
#define ADAU1372_REG_SAI1				0x0033
#define ADAU1372_REG_SOUT_CTRL			0x0034
#define ADAU1372_REG_MODE_MP0			0x0038
#define ADAU1372_REG_MODE_MP1			0x0039
#define ADAU1372_REG_MODE_MP4			0x003c
#define ADAU1372_REG_MODE_MP5			0x003d
#define ADAU1372_REG_MODE_MP6			0x003e
#define ADAU1372_REG_PB_VOL_SET			0x003f
#define ADAU1372_REG_PB_VOL_CONV		0x0040
#define ADAU1372_REG_DEBOUNCE_MODE		0x0041
#define ADAU1372_REG_OP_STAGE_CTRL		0x0043
#define ADAU1372_REG_DECIM_PWR			0x0044
#define ADAU1372_REG_INTERP_PWR			0x0045
#define ADAU1372_REG_BIAS_CTRL0			0x0046
#define ADAU1372_REG_BIAS_CTRL1			0x0047
#define ADAU1372_REG_PAD_CTRL0			0x0048
#define ADAU1372_REG_PAD_CTRL1			0x0049
#define ADAU1372_REG_PAD_CTRL2			0x004a
#define ADAU1372_REG_PAD_CTRL3			0x004b
#define ADAU1372_REG_PAD_CTRL4			0x004c
#define ADAU1372_REG_PAD_CTRL5			0x004d

***********************************************************************************************************************/

