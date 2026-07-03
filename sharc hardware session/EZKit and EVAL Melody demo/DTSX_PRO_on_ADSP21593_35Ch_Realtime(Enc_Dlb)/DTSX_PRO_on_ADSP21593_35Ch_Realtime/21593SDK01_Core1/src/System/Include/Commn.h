/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	21593SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Commn.h
*  Description      :   Define MACRO added for all the Project files 
******************************************************************************/
#ifndef COMMN_H
#define COMMN_H

/*============== Decoder Definition==========================================*/

#define STATUS_UPDATE


#define MELODY9
#define COMMAND_PROCESSING
#define TX_NEW_LOGIC
#define SPI_COMMAND

#ifdef MELODY9
	#define eARC_ENABLE
#endif

#define MCPCM_DECODER
/*==========================PCM Decoder===========================================*/
#define PCM_DECODER
#ifdef PCM_DECODER
#define LPCMDelayBuffer_size		18432  //Lpcm delay for 96k and 192k(16384+(256*2*4))
#define PACK_LENGTH_PCM_INT         NO_OF_SAMPLE_PROCESSING*2*TWO_HALF
#endif //PCM_DECODER
/*==========================DTSX Decoder===========================================*/
/*In order to comment DTSX Decoder, Use the below define alone*/
#define DTSX_DECODER
#ifdef DTSX_DECODER
	#define DTSX_LIB
	#define TRUBASS
	#define DTSX_NUM_OUT_CHANNELS 32
	#define DOWNSAMPLING_DTSX
    //#define DTSX_LATENCY_CALC
	#define OPTICAL_TESTING
#ifndef DTSX_LATENCY_CALC
	//#define DTSX_MIPS_CALC                  	// DTSX_MIPS_CALC define is added under DTSX_DECODER define for internal validation.
#endif
#endif
//#define CORE2_DEBUG
/*==========================Down Sampling===========================================*/
#define DOWNSAMPLING
#ifdef DOWNSAMPLING
#define PACK_LENGTH_MCPCM_DS_96	 	512*8*2 	//2 Channel
#define PACK_LENGTH_MCPCM_DS_192	1024*8*2 	//2 Channel

#define PACK_LENGTH_PCM_INT_DS_96	512*2*2 	//2 Channel
#define PACK_LENGTH_PCM_INT_DS_192	1024*2*2 	//2 Channel
#endif

//#define CORE1_TX
#define MDMA_COPY
#define LED_TOGGLE
//#define SPI1  //To Enable the SPI1 Device

#define VALIDATION_36CH
#ifdef SPI1
	#define	SPI_DEVICE	1
#else
	#define	SPI_DEVICE	0



#endif
#define TWO_HALF    2
#define THREE_HALF	3
#define FOUR_HALF	4
#define FIVE_HALF   5

/*==============OPTICAL_MODULE Definition=================================================*/

//#define OPTICAL_MODULE

/*==============I/O Buffer Definition===========================================*/
#define INAUTOBUFSIZEBY2			32*2
#define OUTAUTOBUFSIZEBY2			16*2

#define SAMPLE_BLOCK_MCPCM			256
#define SAMPLE_BLOCK_PCM			256
#define NO_OF_SAMPLE_PROCESSING		256
#define SAMPLE_PROCESSING_PP        64
#define NO_OF_TX_SAMPLE_COUNT	    32

#define NO_OF_INPUT_CHANNEL 		8

#define NO_OF_PREDAC_CHANNEL		36

#define NUMMAXCHAN                  NO_OF_PREDAC_CHANNEL
#define PREDAC_INT_NUMCHAN          36

#define PACK_LENGTH_MCPCM 	 	 	NO_OF_SAMPLE_PROCESSING*NO_OF_INPUT_CHANNEL*TWO_HALF
#define PACK_LENGTH_MCPCM_INT 	 	NO_OF_SAMPLE_PROCESSING*NO_OF_INPUT_CHANNEL
#ifdef DTSX_DECODER
#define PACK_BUFFER_MAX_SIZE        18944
#else 
#define PACK_BUFFER_MAX_SIZE        256*NO_OF_INPUT_CHANNEL*2
#endif //DTSX_DECODER
#define PACK_LENGTH_PCM_EXT         NO_OF_SAMPLE_PROCESSING*2*TWO_HALF

#define PREDAC_LENGTH_PCM  	 		NO_OF_SAMPLE_PROCESSING*NO_OF_PREDAC_CHANNEL*THREE_HALF
#define PREDAC_LENGTH_MCPCM  	 	NO_OF_SAMPLE_PROCESSING*NO_OF_PREDAC_CHANNEL*THREE_HALF

#define BUFF_MAX_SIZE               NO_OF_SAMPLE_PROCESSING*NUMMAXCHAN


#define DEFAULT_FS					FS_48K

/*============== Framework Definition===========================================*/
#define FORCEPCM3   				4
#define INVALID					   -1

#define NO_ERROR 					0
#define HEADER_PLACE_WRITTEN_ERROR 	1
#define STREAM_NOT_DETECTED 		2
#define FILLED_SPACE_ERROR 			3
#define EMPTY_SPACE_ERROR 			4
#define DECODER_ERROR				5
/*===============================================================================*/
#define TRUE						1
#define FALSE						0
#define I2S_MODE 0
#define TDM_MODE 1

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
#define MCLK_96KHZ    256
#define MCLK_48KHZ    512


#define COUNT_2CH 32*2
#define COUNT_4CH 32*4

#define NOP1 asm("nop;");
#define NOP10 asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");

#define MP_OFFSET	(uint32_t)0x28000000  // SHARED MEMORY CONVERSION (NW to BW) OFFSET FOR CORE 1 BUFFERS
#define MP_OFFSET1	(uint32_t)0x28800000  // SHARED MEMORY CONVERSION (NW to BW) OFFSET FOR CORE 2 BUFFERS

#define SPI_BUFFER_SIZE 40
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
//#define CHANNEL_VALIDATION        // Routing Last 12 channel(25ch-36ch) to First 12 channel
#endif
#define TMU
