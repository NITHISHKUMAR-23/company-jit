/***************************************************************************
*
 *  (C)Copyright Analog Devices Inc., India.
*  All rights reserved. Reproduction in whole or part is prohibited without 
*  the written permission of the copyright owner.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Commn.h
*  Description      :   Define MACRO added for all the Project files 
******************************************************************************/
#ifndef COMMN_H
#define COMMN_H

/*============== Decoder Definition==========================================*/
#define FS_COMMAND_PROCESSING
#define LATENCY_CHANGE
#define TRANSMITTER_SYNC
#define DIRECT_AUTO_DET
#define STATUS_UPDATE
#define RX_CHAN_CHANGE
#define MPCM_DMIX
#define SPORT_CHANGE

#define C_SW_Swap
#define SIMD_CHANGE
#define MULTI_INPUT
#define MULTI_CHAN
#define MDMA_REMOVE
#define COMMAND_PROCESSING
#define SIMD_ENABLE
#define TX_NEW_LOGIC
#define SPI_COMMAND

#ifdef TX_32_CHAN
#define EXT_CHANNEL
#define USE_MDMA_EXTCHANNEL
#endif

#define MCPCM_DECODER

#define NUMMAXCHAN  32
#define STACK_MEM_L3 32768
//#define SPDIF_ENABLE
//#define ASRC_ENABLE

#define ADC_SR_48K          (0x00)
#define ADC_SR_96K          (0x40)
#define ADC_SR_192K         (0x80)

#define DAC_SR_48K          (0x00)
#define DAC_SR_96K          (0x02)
#define DAC_SR_192K         (0x04)

#define TWO_HALF    2
#define THREE_HALF	3
#define FOUR_HALF	4
#define FIVE_HALF   5

/* DAI FS Pin Definition Based On HRM */
/*==============OPTICAL_MODULE Definition=================================================*/

//#define OPTICAL_MODULE
#define SYNCSIGUNKNOWN	     	    0x0f    // detection under progress
/*==============I/O Buffer Definition===========================================*/
#define INAUTOBUFSIZEBY2			32*2
#define OUTAUTOBUFSIZEBY2			16*2

#define Mod_L		0
#define Mod_R		1
#define Mod_C		2
#define Mod_LFE		3
#define Mod_Ls		4
#define Mod_Rs		5
#define Mod_Lrs		6
#define Mod_Rrs		7

#define SAMPLE_BLOCK_MCPCM			256
#define SAMPLE_BLOCK_PCM			256
#define NO_OF_SAMPLE_PROCESSING		256
#define NO_OF_TX_SAMPLE_COUNT	    32
#define METADATASIZE				3072
#define Sample_Processing_PP 		64

#define PACK_LENGTH_PCM_EXT 		NO_OF_SAMPLE_PROCESSING*2*2
//#define PACK_LENGTH_PCM_INT	 	 	NO_OF_SAMPLE_PROCESSING*2*2 	//2 Channel

#define PACK_LENGTH_MCPCM 	 	 	NO_OF_SAMPLE_PROCESSING*8*2 	//8 Channel

#define PACK_LENGTH_MCPCM_INT 	 	NO_OF_SAMPLE_PROCESSING*8 	    //8 Channel
#define PREDAC_LENGTH_PCM  	 		NO_OF_SAMPLE_PROCESSING*NO_OF_PREDAC_CHANNEL*3
#define PREDAC_LENGTH_MCPCM  	 	NO_OF_SAMPLE_PROCESSING*NO_OF_PREDAC_CHANNEL*3

#define ADDPREDAC_LENGTH	     	METADATASIZE*2
#define PACK_BUFFER_MAX_SIZE        18944

#define ADDPREDAC_LENGTH_DSD2PCM 	METADATASIZE*2
#define NO_OF_INPUT_CHANNEL 		8
#define NO_OF_PREDAC_CHANNEL		32
#define NO_OF_ADDPREDAC_CHANNEL		2
//#define NO_OF_OUTPUT_CHANNEL		NO_OF_PREDAC_CHANNEL + NO_OF_ADDPREDAC_CHANNEL

#define SaveStackLib 				0
#define DEFAULT_FS					2		//48kHz
#define FSPHASE                     3      //To synchronize fs2 with fs1

/*==============Customer_PP Definition=================================================*/

#define CUSTOMER
#define FLOAT

#ifdef CUSTOMER
	#define CUSTOMER_PP
#endif

#define FLOAT_PP 1
#define BUFF_MAX_SIZE NO_OF_SAMPLE_PROCESSING*NUMMAXCHAN
#define PP_BUFF_MAX_SIZE NO_OF_SAMPLE_PROCESSING*CUSTOMER_PP_CHANNELS

/*==============================================================================*/
/*============== Framework Definition===========================================*/
//#define SYNCSIGUNKNOWN	     	    0x0f    // detection under progress
#define FORCEPCM3   				4
#define INVALID						-1

#define NO_ERROR 					0
#define HEADER_PLACE_WRITTEN_ERROR 	1
#define STREAM_NOT_DETECTED 		2
#define FILLED_SPACE_ERROR 			3
#define EMPTY_SPACE_ERROR 			4
#define DECODER_ERROR				5
#define LED_TOGGLE

#define I2S_MODE 0
#define ASRC_MODE 2
#define TDM_MODE 1
/*===============================================================================*/

#define TRUE						1
#define FALSE						0

#define FS_32K  	0x00
#define FS_44K  	0x01
#define FS_48K  	0x02
#define FS_64K  	0x04
#define FS_88K  	0x05
#define FS_96K  	0x06
#define FS_128K  	0x08
#define FS_176K  	0x09
#define FS_192K  	0x0A

#define MCLK_192KHZ  128
#define MCLK_96KHZ   256
#define MCLK_48KHZ	 512

#define COUNT_2CH 32*2
#define COUNT_4CH 32*4

#define NOP1 asm("nop;");
#define NOP10 asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");
#define MP_OFFSET	(uint32_t)0x28000000  // SHARED MEMORY CONVERSION (NW to BW) OFFSET FOR CORE BUFFERS

#define  STREAM_TYPE_FORMUTE	0x82E3
/*
	bit 0 - PCMZERO		- Mute enabled
	bit 1 - PCM			- Mute enabled
	bit 2 - DOLBY		- No mute	
	bit 3 - DTSLDCD		- No mute
	bit 4 - DTSDVD		- No mute
	bit 5 - MPEGL1		- Mute enabled
	bit 6 - MPEGL2L3	- Mute enabled 		
	bit 7 - HDCD		- Mute enabled
	bit 8 - AAC			- No mute
	bit 9 - WMAPRO		- Mute enabled
	bit 10 - DDPLUS		- No mute
	bit 11 - TRUEHD		- No mute
	bit 12 - DTSMA		- No mute
	bit 13 - DTSHR 		- No mute
	bit 14 - DTSLBR		- No mute
	bit 15 - UNKNOWN	- Mute enabled
*/

#endif

