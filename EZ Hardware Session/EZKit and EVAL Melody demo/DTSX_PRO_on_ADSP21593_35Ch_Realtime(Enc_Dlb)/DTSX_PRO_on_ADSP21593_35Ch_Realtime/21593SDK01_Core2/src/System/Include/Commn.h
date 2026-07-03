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

#define NOP10 asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");

#define NOP1 asm("nop;");

#define MCPCM_DECODER

/*==============DTSX Decoder==========================================*/
#define DTSX_DECODER
#ifdef DTSX_DECODER
	#define DTSX_LIB
    #define DTSX_CHANREORDER
    #define TRUBASS
	#define TIMERENABLED_KERNAL
	#define DTSX_NUM_OUT_CHANNELS 32
	#define DOWNSAMPLING_DTSX
	#define OPTICAL_TESTING
	//#define DTSX_LATENCY_CALC
#ifndef DTSX_LATENCY_CALC
	//#define DTSX_MIPS_CALC                  	// DTSX_MIPS_CALC define is added under DTSX_DECODER define for internal validation.
#endif
#endif// DTSX_DECODER

#define STACK_MEM_L3 32768


#define NO_OF_SAMPLE_PROCESSING  256


#define NO_OF_CACHE_MD_SDRAM 16
// DDPlus - 1536 words, TureHD - 1024 words, MAT-PCM - 1024 words
#define MAX_EVO_UNPACKED_MD_SIZE (1536+16)

#define TOTAL_MD_CACHE_SIZE (NO_OF_CACHE_MD_SDRAM*MAX_EVO_UNPACKED_MD_SIZE)

#define MD_BUFFER_SDRAM_LENGTH (2*512*8)		// Metadata 8 times faster rxion compare to audio sample

#define MD_BUFFER_SDRAM_LENGTH_HALF (MD_BUFFER_SDRAM_LENGTH/2)

/*==============I/O Buffer Definition===========================================*/

#define NO_OF_PREDAC_CHANNEL		36


#define BUFF_MAX_SIZE				NO_OF_SAMPLE_PROCESSING*NO_OF_PREDAC_CHANNEL

#define SAMPLE_BLOCK_MCPCM			NO_OF_SAMPLE_PROCESSING
/*==============================================================================*/
/*============== Framework Definition===========================================*/
#define SYNCSIGUNKNOWN	     	    0x0f    // detection under progress 
#define FORCEPCM3   				4
#define INVALID						-1
#define NO_ERROR 					0
#define HEADER_PLACE_WRITTEN_ERROR 	1
#define STREAM_NOT_DETECTED 		2
#define FILLED_SPACE_ERROR 			3
#define EMPTY_SPACE_ERROR 			4
#define DECODER_ERROR				5
#define LED_TOGGLE
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





#define MDMA_COPY

#define CUSTOMER_PP

#ifdef CUSTOMER_PP
	#define FLOAT
	#define CUSTOMER_PP_CHANNELS  36
    #define PP_BUFF_MAX_SIZE NO_OF_SAMPLE_PROCESSING*CUSTOMER_PP_CHANNELS
    #define FLOAT_PP 1
#endif

//#define CHANNEL_VALIDATION        // Routing Last 12 channel(25ch-36ch) to First 12 channel

#ifdef DTSX_DECODER
	#define PACK_LENGTH_MCPCM_INT 	 256*32
	#define DTSX_INTPREDAC_LEN       9216 //Internal Predac Length
	#define DTSX_STREAM_PROFILE      10
    #define DTSXINTPREDACSIZE        8192
    #define DTSXINTPREDACSIZEHALF    4096
	#define DTSXMETADATASIZE         1700
	#define EXT_BUFFER_DATA_SIZE     73*1024
#ifdef DOWNSAMPLING_DTSX
	#define BUFF_MAX_SIZE_512			512*NO_OF_PREDAC_CHANNEL
#endif //DOWNSAMPLING_DTSX
#endif  //DTSX_DECODER
#endif
