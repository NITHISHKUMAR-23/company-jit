/***************************************************************************
*
*  (C)Copyright Analog Devices Inc., India.
*  All rights reserved. Reproduction in whole or part is prohibited without 
*  the written permission of the copyright owner.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Def_Struct.h
*  Description      :   All the Struture Variables inlcluded
******************************************************************************/

#include "Commn.h"

#ifndef DEF_STRUCT_H_
#define DEF_STRUCT_H_

extern volatile struct kernel Frmwk;

struct Transmitter
{
	int	*Tx_4a_chain_ptr;	
	int	*Tx_4a_chain1_ptr;	
	int	*Tx_4b_chain_ptr;	
	int	*Tx_4b_chain1_ptr;	
	int	*Tx_2a_chain_ptr;	
	int	*Tx_2a_chain1_ptr;	
	int	*Tx_2b_chain_ptr;	
	int	*Tx_2b_chain1_ptr;	
	int	*Tx_0a_chain_ptr;	
	int	*Tx_0a_chain1_ptr;
	int	*Tx_0b_chain_ptr;	
	int	*Tx_0b_chain1_ptr;	
	
	int	*dac_buf_LCRSw0_ptr;
	int	*dac_buf_LCRSw1_ptr;
	int	*dac_buf_LsLsrRsRsr0_ptr;
	int	*dac_buf_LsLsrRsRsr1_ptr;
	int *dac_buf_addch1ch3ch2ch4_set0_ptr;
	int *dac_buf_addch5ch7ch6ch8_set0_ptr;
	int *dac_buf_addch1ch3ch2ch4_set1_ptr;
	int *dac_buf_addch5ch7ch6ch8_set1_ptr;

	int	*dac_buf_addch1ch3addch2ch4_set0_ptr;
	int	*dac_buf_addch1ch3addch2ch4_set1_ptr;
	int	*dac_buf_addch5ch7addch6ch8_set0_ptr;
	int	*dac_buf_addch5ch7addch6ch8_set1_ptr;


    int *dac_buf_addch9ch11addch10ch12_set0_ptr;  
	int *dac_buf_addch9ch11addch10ch12_set1_ptr;  



	int *dac_buf_addch13ch15addch14ch16_set0_ptr;  
	int *dac_buf_addch13ch15addch14ch16_set1_ptr;  


	int buf_zero_data;
	int Latency_data;
	int TX_prev_i2;
	int Tx_LatencyFlag;

};

struct Receiver
{
	int	*Rx_1a_chain_ptr;	
	int	*Rx_1a_chain1_ptr;	
	int	*Rx_3a_chain_ptr;	
	int	*Rx_3a_chain1_ptr;	
	int	*Rx_3b_chain_ptr;	
	int	*Rx_3b_chain1_ptr;	
	int	*Rx_5a_chain_ptr;	
	int	*Rx_5a_chain1_ptr;	
	int	*Rx_5b_chain_ptr;	
	int	*Rx_5b_chain1_ptr;	
	
	int	*Rx_1a_chain_ptr_DSD;	
	int	*Rx_1a_chain1_ptr_DSD;	
	int	*Rx_1b_chain_ptr_DSD;	
	int	*Rx_1b_chain1_ptr_DSD;
	int	*Rx_3a_chain_ptr_DSD;	
	int	*Rx_3a_chain1_ptr_DSD;	
	int	*Rx_3b_chain_ptr_DSD;	
	int	*Rx_3b_chain1_ptr_DSD;	
	int	*Rx_5a_chain_ptr_DSD;	
	int	*Rx_5a_chain1_ptr_DSD;	
	int	*Rx_5b_chain_ptr_DSD;	
	int	*Rx_5b_chain1_ptr_DSD;
	
	int	*DummyInAutbuf0m_ptr;
	int	*DummyInAutbuf1m_ptr;
	
	int *DummyInAutbuf0_ptr;
	int *DummyInAutbuf1_ptr;
	int	*DummyInAutbuf2_ptr;
	int	*DummyInAutbuf3_ptr;
	int	*DummyInAutbuf4_ptr;
	int	*DummyInAutbuf5_ptr;
	int	*DummyInAutbuf6_ptr;
	int	*DummyInAutbuf7_ptr;
	
	int *DSD2PCMInAutbufL0_ptr;
	int *DSD2PCMInAutbufR0_ptr;
	int *DSD2PCMInAutbufLs0_ptr;
	int *DSD2PCMInAutbufRs0_ptr;
	int *DSD2PCMInAutbufC0_ptr;
	int *DSD2PCMInAutbufSw0_ptr;
	
	int *DSD2PCMInAutbufL1_ptr;
	int *DSD2PCMInAutbufR1_ptr;
	int *DSD2PCMInAutbufLs1_ptr;
	int *DSD2PCMInAutbufRs1_ptr;
	int *DSD2PCMInAutbufC1_ptr;
	int *DSD2PCMInAutbufSw1_ptr;	
	
	int *INPUTsamples_ptr;	
	int SingleI2S_prev_b2;
	int MCPCM_prev_b2;
	int prev_b2_adc;

};

struct Host
{
	/*************** Don't change the order*************/
	int COMMAND_BYTE;
	int PARAMETER_1;
	int PARAMETER_2;
	int PARAMETER_3;
	int PARAMETER_4;
	int PARAMETER_5;
	int PARAMETER_6;
	int PARAMETER_7;
	int PARAMETER_8;
	int PARAMETER_9;
	int PARAMETER_10;
	int PARAMETER_11;
	int PARAMETER_12;
	int PARAMETER_13;
	int PARAMETER_14;
	int PARAMETER_15;
	int PARAMETER_16;
	int PARAMETER_17;
	int PARAMETER_18;
	int PARAMETER_19;
	int PARAMETER_20;
	int PARAMETER_21;
	int PARAMETER_22;
	int PARAMETER_23;
	int PARAMETER_24;
	int PARAMETER_25;
	int PARAMETER_26;
	int PARAMETER_27;
	int PARAMETER_28;
	int PARAMETER_29;
	int PARAMETER_30;
	int PARAMETER_31;
	int STATUS_BYTE1;
	int STATUS_BYTE2;
	int STATUS_BYTE3;
	int STATUS_BYTE4;
	int STATUS_BYTE5;
	int STATUS_BYTE6;
	int STATUS_BYTE7;
	int STATUS_BYTE8;
	int STATUS_BYTE9;
	int STATUS_BYTE10;
	int STATUS_BYTE11;
	int STATUS_BYTE12;
	int STATUS_BYTE13;
	int STATUS_BYTE14;
	int STATUS_BYTE15;
	int STATUS_BYTE16;
	int RESERVED_BYTE1;
	int RESERVED_BYTE2;
	int RESERVED_BYTE3;
	int RESERVED_BYTE4;
	int RESERVED_BYTE5;
	int RESERVED_BYTE6;
	int RESERVED_BYTE7;
	int RESERVED_BYTE8;
	int RESERVED_BYTE9;
	int RESERVED_BYTE10;
	int RESERVED_BYTE11;
	int RESERVED_BYTE12;
	int RESERVED_BYTE13;
	int RESERVED_BYTE14;
	int RESERVED_BYTE15;
	int INTR_DESC_LOCN;

	/*************** END ****************************/
	
	int	PREV_STATUS_BYTE1;
	int PREV_STATUS_BYTE2;
	int PREV_STATUS_BYTE3;
	int PREV_STATUS_BYTE4;
	int PREV_STATUS_BYTE5;
	int PREV_STATUS_BYTE6;
	int PREV_STATUS_BYTE7;
	int PREV_STATUS_BYTE8;
	int PREV_STATUS_BYTE9;
	int PREV_STATUS_BYTE10;
	int PREV_STATUS_BYTE11;
	int PREV_STATUS_BYTE12;
	int PREV_STATUS_BYTE13;
	int PREV_STATUS_BYTE14;
	int PREV_STATUS_BYTE15;
	int PREV_STATUS_BYTE16;
	int PREV_RESERVED_BYTE1;
	int PREV_RESERVED_BYTE2;
	int PREV_RESERVED_BYTE3;
	int PREV_RESERVED_BYTE4;
	int PREV_RESERVED_BYTE5;
	int PREV_RESERVED_BYTE8;
	
	int STATUS_BYTE4T;
	int STATUS_BYTE5T;
	int STATUS_BYTE1T;
	int SPIDummyReadFlg;
	int DirectRead_flag;

	int header_count;
	int header_address;
	int destination_address;
	int destination_count;
	int temp_write_count;
	int temp_write_address;
	int DataRead;
	int special_cmd_result;
	int FlagToggle;
	int serialflash_flag;
	int download_status;
	int download_flag;
	int DirectWrite_flag;
	int DataWrite;
	int MicroWriteFlg;
	int loader_address;
	int serialflash_cmd_flag;
	int SpiTxBuffer;
	int COMMAND_SAVE_LOCATION;
	int SPIReceiveTempBufPtr;
	int SPIReceiveTempBuf;
	int SPIReceivebufsize;
	int spictl_8bit;		
	int spictl_16bit;	
	int spictl_32bit;	
	int spictl_32bit_read;
	int spival1;
	int spival2;
};

 struct Autodet  
{
	int	MSGR_Save;
	int	mpegstreamdetected;
	int PcmHeaderWritten;
	int autodetectcount;
	int autodetect3;
	int	*InAutbuf_ptr;	      // [INAUTOBUFSIZE*2];
	int	StreamDetectEnable;   // = 1;
	int	BreakCount;
	int PauseCount;	          // = 0
	int	LongPause;	          // = 0
	int	SmallPause ;         // = 0
	int	HIGHTOLOWBRDOLBY;    //	= 0
	int	AlignFlg;           // = 0
	int	HeaderAddress;
	int	HeaderAddWritten;   // = 0
	int HeaderPlaceWritten;	// = 0
	int	BurstSyncFound;    // = 0
	int	TransferNeeded;    // = 0
	int	No_Of_DWords_In_Present_Burst;	  // = 384
	
	int	FormatStream;
	int	PrevPc;
	
	int	CompareWord;
	int PcmZeroCount,PcmCount,MayBePcm;
	int	MayBeDTS,streamdetected,GoForchk;
	
    int empty;
	int	flag_receiver2;
	int FrameSizeWMAPRO;
	int MSGR4;
	int MAYBEPCMCOUNT_var;
	int save_MAYBEPCM;
	int MaybePcm_count;
	
};


struct saveunsave
{
	int prolbufsave_tx[75];
	int prolbufsave_rx[45];
	int prolbufsave_spi[20];
	int SveforSetSync[6];
	int saveint[90];
	int savestack[70];
	int save_creg[20];
	int save_rxisr;

};


struct Control_tag
{
     int ForcePcm;
     int XPcm;
     int ReceiveReqFlag;
     int TransmitReqFlag;
     int OutBufferEmptyFlag;
     int InAutobufsizeby2;
     int OutAutobufsizeby2;
     int InAutobufsizeby2_DSD;
     int InAutobufsizeDSD2PCMby2;
     int Bufzerocount;
};

struct Packbuf
{
	int heap;
	int rd_ptr;
	int wr_ptr;
	int length;
	int lengthhalf;
};

struct Customer_post_processing
{
    int ChannelMask;
	int Volume;
	int Data_Format;
};

struct Predacbuf
{
	int heap;
	int rd_ptr;
	int wr_ptr;
	int wr_ptr_c2;
	//int Tx_rd_ptr;
	int length;
	int lengthhalf;
};

struct AddPreDacbuf
{
	int heap;
	int rd_ptr;
	int wr_ptr;
	int length;
	int lengthhalf;
	int lengthperch;
};


struct IOProcess
{
	
	struct Packbuf Pack;
	struct Predacbuf Predac;
	struct AddPreDacbuf AddPreDac;
	int	   NextDataValid;
	int    ThirdDataValid;
	int    ThirdDacCount;
	int    ThirdDacAddPreDac;
	int    ThirdDacAdd;
	int    DataValid;	
	int    NextDacCount;
	int	   DacCount;	 
	int    NextDacAdd;
	int    NextDacAddPreDac;
	int    CopyToDacCounter;
	int    datacanbeprocessednow;
	int    CopyToLatencyCnt;
	int    LatencyCnt;
	int    FIFO_LatencyCnt;
	int    LatencyFlag;
	int    LatencyDone;	
	int    LatencyComplete;
	int    FIFOLatencyFlag;
	int    FIFOLatencyCnt;
	int    FIFOTx_LatencyFlag;
	int    Next_DataValid_count;
};

struct Miscelleny
{
	struct saveunsave Protect;
	struct Control_tag Control;
};

struct Volume_Tag
{
	int volume_left;
	int volume_center;
	int volume_right;
	int volume_ls;
	int volume_rs;
	int volume_sw;
	int volume_sbl;
	int volume_sbr;
	int volume_addch1;
	int volume_addch2;
	int volume_addch3;
	int volume_addch4;
	int volume_addch5;
	int volume_addch6;
	int volume_trim_right_db;
	int volume_trim_left_db;
	int volume_trim_sw_db;
	int volume_trim_center_db;
	int volume_trim_rs_db;
	int volume_trim_ls_db;
	int volume_trim_sbr_db;
	int volume_trim_sbl_db;	
	int volume_trim_Lt_db;
	int volume_trim_Rt_db;
	int volume_trim_addch1_db;
	int volume_trim_addch2_db;
	int volume_trim_addch3_db;
	int volume_trim_addch4_db;
	int volume_trim_addch5_db;
	int volume_trim_addch6_db;	
	int master_volume_db;
	int predac_heap;
	int predac_wr_ptr;
	int predac_length;
	int AddPreDac_heap;
	int AddPreDac_wr_ptr;
	int AddPreDac_length;
	int volume_trim_enable;
	int volume_control_enable;
	int sample_block;
	int savestack_ptr;
	int input_list_ptr;
	int volume_Rt;
	int volume_Lt;
}; 


struct kernel
{
	int RAM_codeid;
	struct Customer_post_processing Customer_pp;
	struct Autodet Autdet;
	struct Transmitter Tx;
	struct Receiver Rx;
	struct Host Spi;

	struct Volume_Tag Volume;
	struct IOProcess IOP;
	struct Miscelleny Misc;

	int Value;
	int mpeg2support;
    int run_flag;
	int stop_flag;
	int mute_flag;
	int decoder_error;
    int StreamType;
    int InitDoneForStreamType;
    int init_deemphasis;
    int SampleBlock;

    int SampleBlock_DS;  
    int	PCMEnable;
	int	MCLPCMEnable;
	int pcm_deemphasis_enable;

	int volume_control_enable;
	int volume_trim_enable;		
	int Set_Volume_Flag;
	

	int MCLPCM_ON;
	int ADCEnable;
	int MemoryAllotDD;
	int MemoryAllotDDP;
	
    int MemoryAllotPcm;
    int MemoryAllotMCLPCM; 
    int MemoryAllotPack;
	int MemoryAllotDac;
	int MemoryAllotEs;
	int SPORT_MODE_RX;
	int SPORT_MODE_TX;

	int Dual_Mono_Info;
	int cmd_temp_read;
	int MEnc_Enable;
	int Decoded_Fs;
	int SampleRate_DS;
	int LPCMDelayBuffer_heap;
	int LPCMDelayBuffer_wr_ptr;
	int LPCMDelayBuffer_rd_ptr;
	int LPCM_delay_index;
	int LPCMDelaySize_host;
	int PrevLPCMDelaySize_host;
	int RecOutEnable;
	int pack_length_default;	//to be elimanted in release as all Decoder pack length will be identified
	
	int pack_length_pcm;
	int pack_length_mcpcm;
	int predac_length_pcm;
	int predac_length_mcpcm;
	int AddPreDac_length_mcpcm;

	int SampleDropCount;
	int SampleDropCountIndex;
	int autodetect_mode;
	int digital_rx_mute;
	int digital_tx_mute;
	int OutputSampleRate;
	int PrevOutputSampleRate;
	int sampling_fs_micro;
	int prev_sampling_fs_micro;
	int prev_DS_sampling_fs_micro;

    int ADI_DecoderError;
	int PPInterruptOccured[2];
	int SDRAMDIV;
	int SDControlWord;
	int SDRAMBankADD;
	int AMICTL1_Value;
	int SPIBAUD_Value;
	int cmd_result;
	int AACCodeDownloadedinRAM;
 	int LBRCodeDownloadedinRAM;
 	
	int sample_count_value;	
	int sample_count_value_save;
	int post_pointer;
	int AddPreDac_pointer;
	
	int DS_Mode;
	
	int Force_DTS_Enable;
	int AAC_Enable;
	int AACDecoderEnable;
	int LBRDecoderEnable;
	int DTSXDecoderEnable;
	int DOLBYDecoderEnable;
	int DDPLUSDecoderEnable;
	int TRUEHDDecoderEnable;
	
	int PackAllocateinProgress;
    int Rnd32BitFlag;
	int Mute_flag_from_HOST;
	int LPCMDelaySize;
	int lfesaveflag;
	int lfepresent;
	int neo_NeoLFEon;
	int Temp_Buffer_ptr;
	int EsDelayBuffer_ptr;
	int temp_pointer;
	int volatile ESProcessingEnable;
	int PostDecoderMC;
	int enableExEs;
	int Front_Attn_Flag;
	int es_done; 
	int InitDss;
	int prologic_init_flag;
	int PostDecoderStereo;
	int lfesaveflag_frmcmd;

	// AAC, LBR
	int loop_offset;
	int inputChannelConfig;

	int InitDoneForFS;
	//int MemoryAllotDss;
	
	//DSD2PCM
	int DSD2PCMMode_Enable;
	int AutodetectMode_Enable;
	int InitDoneForAutodetectMode;
	int InitDoneForDSD2PCM;

	//Au	
	int InitDoneForAuDt;
	int AuDt_Enable;
	int AuDt_Enable_Flag;
	int Au_Dt_Done;
	int PrevAuDt_Enable;
	//INTER_DSP_COMM_I2S	
	int Decoder_Channel_Assignment;
	//DS
	int init_ds_processing;
	int MemoryAllotMAT;
	int Object_Audio;
	int decoded_channel;
	//Noise Generator
#ifdef NOISEGEN
	int pack_length_noise;
	int predac_length_noise;
	int AddPreDac_length_noise;
	int	MemoryAllotNoise;
	int	NoiseGenEnable;
	int init_noise_gen;
	int ClearLeftChannelNoise;
	int NoiseGen_Ch;
#endif
	int Stream_Type_ForMUTE;
	int Bufzerocount;
	int EXProcessingEnable;
	int prologic_decode_flag;
	int prologic_done;
	int dss_done;
	int ex_done;
	int prologic_emulation_flag;
	int No_of_DAC_channel;
	int Max_No_of_DAC_channel;
	int Tx_ChSel;
	int No_of_Channel;
	int internal_Tx_buff;
	int previousoutputmap;
	int prevjocd_out_mode;
	int prevpcmsamplerate;
	int joc_dmx_out_order[16];
	int channel_router[32];
	int CIDK_Enable_C1;
	int CIDK_Enable_C2;
	int Legacy_Mode_enable;
};

#endif  /*	DEF_STRUCT_H_  */

