/***************************************************************************
*
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you
agree to the terms of the associated Analog Devices License Agreement.
*
*  Project          :  	2159SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Def_Struct.h
*  Description      :   All the Struture Variables included
******************************************************************************/
#ifndef DEF_STRUCT_H_
#define DEF_STRUCT_H_

extern volatile struct kernel Frmwk;

struct Transmitter
{
	int	*dac_buf_LCRSw0_ptr;
	int	*dac_buf_LCRSw1_ptr;
	int	*dac_buf_LsLsrRsRsr0_ptr;
	int	*dac_buf_LsLsrRsRsr1_ptr;

	int	*dac_buf_ch9ch11ch10ch12_set0_ptr;
	int	*dac_buf_ch9ch11ch10ch12_set1_ptr;

	int	*dac_buf_ch13ch15ch14ch16_set0_ptr;
	int	*dac_buf_ch13ch15ch14ch16_set1_ptr;

	int	*dac_buf_ch17ch19ch18ch20_set0_ptr;
	int	*dac_buf_ch17ch19ch18ch20_set1_ptr;

	int	*dac_buf_ch21ch23ch22ch24_set0_ptr;
	int	*dac_buf_ch21ch23ch22ch24_set1_ptr;

	int *dac_buf_ch25ch27ch26ch28_set0_ptr;
	int *dac_buf_ch25ch27ch26ch28_set1_ptr;

	int *dac_buf_ch29ch31ch30ch32_set0_ptr;
	int *dac_buf_ch29ch31ch30ch32_set1_ptr;

	int *dac_buf_ch33ch35ch34ch36_set0_ptr;
	int *dac_buf_ch33ch35ch34ch36_set1_ptr;

	int buf_zero_data;
	int Latency_data;
	int TX_prev_i2;
	int Tx_LatencyFlag;
};

struct Receiver
{
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
	int	*InAutbuf_ptr;
	int	StreamDetectEnable;
	int	BreakCount;
	int PauseCount;
	int	LongPause;
	int	SmallPause ;
	int	HIGHTOLOWBRDOLBY;
	int	AlignFlg;
	int	HeaderAddress;
	int	HeaderAddWritten;
	int HeaderPlaceWritten;
	int	BurstSyncFound;
	int	TransferNeeded;
	int	No_Of_DWords_In_Present_Burst;
	
	int	FormatStream;
	int	PrevPc;
	
	int	CompareWord;
	int PcmZeroCount,PcmCount,MayBePcm;
	
    int empty;
	int	flag_receiver2;
	int FrameSizeWMAPRO;
	int MSGR4;
	int MAYBEPCMCOUNT_var;
	int save_MAYBEPCM;
	int MaybePcm_count;
	
	int	MayBeDTS,streamdetected,GoForchk;
	int	DTSSampleCount;
	int	StreamBlockOffset;
	int	StreamBlockCount,StreamBlockCountMax,PcmDetected;
	int	DTSDataLength,InitHeaderWritten;
	int	DataCanBeCopied;
	int	DTSDataLengthDouble;

#ifdef AAC_DEC
	int AAC_DataLen;
#endif

	int PcValue;
	int PdValue;

	int dtssynclsb;
	int dtssyncmsb;
	int BurstSyncFoundHalf;
	int BurstSyncFoundHalfPCM;
	int BurstPcFound;

	int PrevFrameDTS;
	int PrevPcClearCount;
	int dolbyblockcountmax;
	int dtsblockcountmax0;
	int dtsblockcountmax1;
	int dtsblockcountmax2;
	int dtsblockcountmax3;
	int dtsblockcountmax4;
	int mpegl1blockcountmax;
	int mpegl2blockcountmax;
	int aacblockcountmax;
	int ddplusblockcountmax;
	int truehdblockcountmax;
	int dtshdblockcountmax;
	int dtshdhr2kblockcountmax;
	int dtshdhr1kblockcountmax;
	int dtshdhr512blockcountmax;
	int dtslbrblockcountmax;
	int wmablockcountmax0;
	int wmablockcountmax1;
	int wmablockcountmax2;
	int wmablockcountmax3;
	int blockcountmax;
	int unformatdtsblockcountmax0;
	int unformatdtsblockcountmax1;
	int unformatdtsblockcountmax2;
	int unformatdtsblockcountmax3;
	int unformatdtsblockcountmax4;
	int mpeghblockcountmax;
#ifdef MPEG4_AAC
	int aacblockcountmax_hrls;
	int aacblockcountmax_qrls;
	int aacblockcountmax_drhs;

	int aacblockcountmax_latmloas0;
	int aacblockcountmax_latmloas1;
	int aacblockcountmax_latmloas2;
	int aacblockcountmax_latmloas3;
#endif

	int pc_value;


};


struct saveunsave
{
	int prolbufsave_tx[85];
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

struct DTSX_Status_Var
{
	int Valid;
	int Es_Flag;
	int DialNorm;
	int DecoderError;
	int ExtensionError;
	int SamplingFrequencyDecoded_status;
	int SamplingFrequencyOriginal_status;
	int SamplingFrequencyOriginal;
	int SamplingFrequencyDecoded;
	int NumberofChannelsOriginal;
	int ChannelConfigurationOriginal;
	int ReplacementGrp_ChSet[3];
	int HeadPhoneStream;
	int LFE_Presence;
	int LFE_Count;//=0;
	int LtRtStream;
	int StreamType;
	int DRC_Presence;
	int Number_of_objects;
	int Parma_done;
	int Rendering_done;
	int Downmix_Normalization;
	int Dialog_Presence;
	int NeoX_Flag;
	int Type1_Flag;
	int IMAX_Done;
	int TruBass_Done;
	int DTSX_CoreFsize_Status;
	int DTS_AmbisonicStream;
	int Type1CC_State_Var;
	int Remapping_Performed;
};

struct DTSX_Tag
{
	struct DTSX_Status_Var Status;

	int OutputChannel_Confiq_command;
	int frame_count_ker;
	int Frame_Length_ker;
	int Offset;
    int nPrimaryFlags;
    int *ppcmoutput;
    int initdecoder;
    int numberofchannels;
    int DTSXcommandprocessingdone_c1;
    int DTSX_Commands[7];
    int InitConfigStructureDone;

	int dtsxframecount;
	int previous_Frame_Length_ker;
	int init_done_local;

	int dec_mode_ctrl_var_1;
	int dec_mode_ctrl_var_2;
	int dec_mode_ctrl_var_3;
	int dec_mode_ctrl_var_4;
	int nDecMode_value;

	float TempMips;
	int MipsIdx;
	int cycles;

};
struct kernel
{
	
	struct Customer_post_processing Customer_pp;
	struct Autodet Autdet;
	struct Transmitter Tx;
	struct Receiver Rx;
	struct Host Spi;

	struct IOProcess IOP;
	struct Miscelleny Misc;
	struct DTSX_Tag DTSX;
	int Number_Of_Channels;
	int MemoryAllotDTS;
	int pack_length_dtshdhr;
	int predac_length_dtshd;
	int addpredac_length_dtshd;

	int Value;
    int run_flag;
	int stop_flag;
	int mute_flag;
	int decoder_error;
    int StreamType;
    int InitDoneForStreamType;
    int SampleBlock;
    int	PCMEnable;
	int	MCLPCMEnable;

	int MCLPCM_ON;
	int ADCEnable;
	
    int MemoryAllotPcm;
    int MemoryAllotMCLPCM; 
    int MemoryAllotPack;
	int MemoryAllotDac;
	int MemoryAllotEs;

	int LPCM_delay_index;
	int LPCMDelaySize_host;
	int cmd_temp_read;
	int pack_length_pcm;
	int pack_length_mcpcm;
	int predac_length_pcm;
	int predac_length_mcpcm;
	int AddPreDac_length_mcpcm;

	int SampleDropCount;
	int SampleDropCountIndex;
	int autodetect_mode;
	int OutputSampleRate;
	int PrevOutputSampleRate;
	int sampling_fs_micro;
	int prev_sampling_fs_micro;

    int ADI_DecoderError;
	int cmd_result;

	int sample_count_value;	
	int sample_count_value_save;
	int AddPreDac_pointer;
	
	int PackAllocateinProgress;
	int Mute_flag_from_HOST;
	int LPCMDelaySize;
	int lfesaveflag;
	int lfepresent;
	int PostDecoderStereo;

	// AAC, LBR
	int loop_offset;
	int inputChannelConfig;
	int outputChannelConfig_c1;

	int InitDoneForFS;
	

	int AutodetectMode_Enable;
	int InitDoneForAutodetectMode;

	int Decoder_Channel_Assignment;

	int Stream_Type_ForMUTE;
	int Bufzerocount;
	int Tx_ChSel;
	int No_of_Channel;
	int internal_Tx_buff;
	int mpeg2support;
	int PrevLPCMDelaySize_host;
	int LPCMDelayBuffer_heap;
	int LPCMDelayBuffer_wr_ptr;
	int LPCMDelayBuffer_rd_ptr;
	int	NoiseGenEnable;
	int DTSXDecoderEnable;
	//DS
	int init_ds_processing;
	int DS_Mode;
};

#endif  /*	DEF_STRUCT_H_  */

