#pragma default_section(CODE,"seg_Customer_code")

#include "Customer_PP.h"
#include "..\src\System\Include\Def_struct.h"
#include "..\src\System\Include\Extern.h"

/******************************************************************************
*  Module Name        : CustomerPP_gain_control
*  Functionality      : CustPPInputList contains the parameter for
   *CustomerPPProcessBufferPtr;
	CustomerPPProcessBufferSize;
	Blocksize;
	Number_of_Channels;
	DataFormat;
	ChannelMask;
	StreamType;
	SamplingFrequency;,
*						DB_VALUE is used to set the dB level.
*  Input Parameters	  : Customer_PP_IO_buffer
*  Output Parameters  : None
******************************************************************************/
void CustomerPP_gain_control(int *CustPPInputList)
{
  #ifdef FLOAT
	 float *CustomerPPProcessBufferPtr;
	 float DB_VALUE;
  #else
	 int *CustomerPPProcessBufferPtr;
	 int DB_VALUE;
  #endif

	int CustomerPPProcessBufferSize;
	int Blocksize;
	int Number_of_Channels;
	int DataFormat;
	int ChannelMask;
	int StreamType;
	int SamplingFrequency;
	int Volume;

	CustomerPPProcessBufferPtr  = CustPPInputList[0];
	CustomerPPProcessBufferSize = CustPPInputList[1];
	Blocksize                   = CustPPInputList[2];
	Number_of_Channels          = CustPPInputList[3];
	DataFormat                  = CustPPInputList[4];
	ChannelMask                 = CustPPInputList[5];
	StreamType                  = CustPPInputList[6];
	SamplingFrequency           = CustPPInputList[7];
	Volume                      = CustPPInputList[8];

  if(DataFormat == 1)
  {
	switch(Volume)
	{
	  case 0:
		  DB_VALUE = 1.0;     // 0 db
		  break;

	  case 1:
	  	  DB_VALUE = 0.891;   // -1 db
	  	  break;

	  case 2:
	  	  DB_VALUE = 0.707;   //  -3 db
	  	  break;

	  case 3:
	  	  DB_VALUE = 0.501;   //  -6 db
	  	  break;

	  default:
	  	  break;
	}
	for(int i=0;i<(Blocksize*Number_of_Channels);i=(i+Number_of_Channels))
	{
		CustomerPPProcessBufferPtr[i] = ((CustomerPPProcessBufferPtr[i] * DB_VALUE));  //L channel
		CustomerPPProcessBufferPtr[i+1] = (CustomerPPProcessBufferPtr[i+1] * DB_VALUE);  //R channel
	}
  }
  else
  {
	acc80 Temp_val;
	switch(Volume)
	{
	  case 0:
	  	  DB_VALUE = 0x80000000;     // 0 db
	  	  break;

	  case 1:
	  	  DB_VALUE = 0x720C49BA;   // -1 db
	  	  break;

	  case 2:
	  	  DB_VALUE = 0x5A7EF9DB;   //  -3 db
	  	  break;

	  case 3:
	  	  DB_VALUE = 0x4020C49C;   //  -6 db
	  	  break;

	  default:
	  	  	  break;
	}
	for(int i=0;i<(Blocksize*Number_of_Channels);i=(i+Number_of_Channels))
	{
		Temp_val = A_mul_ssf (CustomerPPProcessBufferPtr[i], DB_VALUE);
		CustomerPPProcessBufferPtr[i] = sat_sf (Temp_val);
		Temp_val = A_mul_ssf (CustomerPPProcessBufferPtr[i+1], DB_VALUE);
		CustomerPPProcessBufferPtr[i+1] = sat_sf (Temp_val);
    }

  }

}

#ifdef CUSTOMER_PP

void CUSTOMER_PP_COMMAND(void)
{

	Frmwk.Customer_pp.Volume		= 	(Frmwk.Spi.PARAMETER_1)&0x3;

}

#endif

int DAC_Channel_Size_Allocation(void)
{
	if(TX_DAC_Output_Ch_Cnt == 3)
	{
		 CUSTOMER_PP_CHANNELS_CNT = 24;
		 PP_BUFF_MAX_SIZE_Var = 256*24  ;
		 PP_BUFF_MAX_SIZE_HALF_Var = 128*24 ;
	}
	else if(TX_DAC_Output_Ch_Cnt == 2)
	{
		 CUSTOMER_PP_CHANNELS_CNT = 18;
		 PP_BUFF_MAX_SIZE_Var = 256*18 ;
		 PP_BUFF_MAX_SIZE_HALF_Var = 128*18;
	}
	else
	{
		 CUSTOMER_PP_CHANNELS_CNT = 16;
		 PP_BUFF_MAX_SIZE_Var = 256*16;
		 PP_BUFF_MAX_SIZE_HALF_Var = 128*16;
	}

}
