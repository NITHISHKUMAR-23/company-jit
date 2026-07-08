/*********************************************************************************
Copyright(c) 2022 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*****************************************************************************
 * ADAU1372_TalkThrough_I2S.c
 *****************************************************************************/

#include <sys/platform.h>
#include "adi_initialize.h"
#include <stdio.h>
#include <stdlib.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include <services/int/adi_int.h>
#include <drivers/sport/adi_sport.h>
#include <services/spu/adi_spu.h>
#include <drivers/twi/adi_twi.h>
#include "ADAU_1372Common.h"
#include "math.h"
#include <SRU.h>
#include "ADAU1372_TalkThrough_I2S.h"

struct Config_Table
{
	short Reg_Add;
	char  Value;
};

char Config_read_DAC[58];
int count;


typedef enum
{
	/*! requested operation successful */
    ADI_1372_SUCCESS,
	/*! requested operation failed */
	ADI_1372_FAILED,
	/*! Operation encountered configuration failure */
	ADI_1372_CONFIG_FAILED,
	/*! timeout failure */
	ADI_TIMEOUT
}ADI_1372_CONFIG_RESULT;


struct Config_Table Config_array_DAC[58] = {
		   	    {     ADAU1372_REG_CLKOUT_SEL,			0x07},
		   	    {     ADAU1372_REG_RGTR,	    		0x01},
				/*  ADC mode register */
				{     ADAU1372_REG_MODE_MP0,			0x00},
				{     ADAU1372_REG_MODE_MP1,			0x00},
				{     ADAU1372_REG_MODE_MP4,			0x00},
				{     ADAU1372_REG_MODE_MP5,			0x00},
				{     ADAU1372_REG_MODE_MP6,			0x00},
				{     ADAU1372_REG_DECIM_PWR,			0xFF},
				{     ADAU1372_REG_ADC_CTRL2,			0x23 },
				{     ADAU1372_REG_ADC_CTRL3,			0x23  },
				{     ADAU1372_REG_ASRC_MODE,			0x03  },
				{     ADAU1372_REG_ASRCO_SOURCE_0_1,	0x54 },
			    {     ADAU1372_REG_ASRCO_SOURCE_2_3,	0x76 } ,
				{     ADAU1372_REG_ADC_CTRL0,			0x01 },
				{     ADAU1372_REG_ADC_CTRL1,			0x01 },
				/*  DAC mode register */
				{     ADAU1372_REG_INTERP_PWR,			0x0F},
				/*  ASRC mode register */
				{     ADAU1372_REG_DAC_SOURCE,	    	0xDC },
				{     ADAU1372_REG_DAC_CTRL,			0x1B},
				{     ADAU1372_REG_OP_STAGE_CTRL,		0x30},
				{     ADAU1372_REG_DAC_CTRL,			0x03},
				{     ADAU1372_REG_OP_STAGE_MUTE,		0x00},
		   	    {     ADAU1372_REG_SOUT_SOURCE_0_1,		0x54},
		   	    {     ADAU1372_REG_SOUT_SOURCE_2_3,		0x76 },
		   	    {     ADAU1372_REG_SOUT_SOURCE_4_5,		0x54 },
		   	    {     ADAU1372_REG_SOUT_SOURCE_6_7,	    0x76},
		   	    {     ADAU1372_REG_ADC_SDATA_CH,	    0x04},
				{     ADAU1372_REG_ADC0_VOL,			0x00 },
				{     ADAU1372_REG_ADC1_VOL,	    	0x00 },
				{     ADAU1372_REG_ADC2_VOL,			0x00  },
				{     ADAU1372_REG_ADC3_VOL,			0x00},
				{     ADAU1372_REG_PGA_CTRL0,			0x00},
				{     ADAU1372_REG_PGA_CTRL1,			0x00 },
				{     ADAU1372_REG_PGA_CTRL2,			0x00 },
				{     ADAU1372_REG_PGA_CTRL3,			0x00 },
				{     ADAU1372_REG_PGA_STEP_CTRL,		0x00 },
				{     ADAU1372_REG_PGA_BOOST,			0x00 },
				{     ADAU1372_REG_POP_SPRS,	    	0x3F},
				{     ADAU1372_REG_TALKTHROUGH,	    	0x00 },
				{     ADAU1372_REG_TALKTHROUGH_G0,		0x00},
				{     ADAU1372_REG_TALKTHROUGH_G1,		0x00},
				{     ADAU1372_REG_MICBIAS,				0x00},
				{     ADAU1372_REG_DAC0_VOL,			0x00},
				{     ADAU1372_REG_DAC1_VOL,			0x00},
				{     ADAU1372_REG_SAI0,				0x00},
				{     ADAU1372_REG_SAI1,				0x01},
				{     ADAU1372_REG_SOUT_CTRL,			0x00},
				{     ADAU1372_REG_PB_VOL_SET,			0x00},
				{     ADAU1372_REG_PB_VOL_CONV,			0x87},
				{     ADAU1372_REG_DEBOUNCE_MODE,		0x05},
				{     ADAU1372_REG_INTERP_PWR,			0x0F},
				{     ADAU1372_REG_BIAS_CTRL0,			0x00},
				{     ADAU1372_REG_BIAS_CTRL1,			0x00},
				{     ADAU1372_REG_PAD_CTRL0,			0x7F},
				{     ADAU1372_REG_PAD_CTRL1,			0x1F},
				{     ADAU1372_REG_PAD_CTRL2,			0x00},
				{     ADAU1372_REG_PAD_CTRL3,			0x00},
				{     ADAU1372_REG_PAD_CTRL4,			0x1E},
				{     ADAU1372_REG_PAD_CTRL5,			0x0C}
};


/*=============  L O C A L    F U N C T I O N    P R O T O T Y P E S =============*/
static int ADAU_1372_Pllinit(void);
static int ADAU_1372_init(void);
void SRU_Init(void);
static int Sport_Init(void);
#if (ADI_CONFIG_CONTINUOUS_AUDIO == 0)
static int Sport_Stop(void);
#endif
static int SPU_init(void);
static int Init_TWI(void);
static int Stop_TWI(void);

/*==============  D E F I N E S  ===============*/

/*=============  D A T A  =============*/

/* Buffers */
ADI_CACHE_ALIGN static int   int_SP0ABuffer1[COUNT];
ADI_CACHE_ALIGN static int   int_SP0ABuffer2[COUNT];

ADI_CACHE_ALIGN static int   int_SP0ABuffer4[COUNT];
ADI_CACHE_ALIGN static int   int_SP0ABuffer5[COUNT];

/* Destination Sport PDMA list */
ADI_PDMA_DESC_LIST iDESC_LIST_1_SP4A;
ADI_PDMA_DESC_LIST iDESC_LIST_2_SP4A;

/* Source Sport PDMA list */
ADI_PDMA_DESC_LIST iSRC_LIST_1_SP4B;
ADI_PDMA_DESC_LIST iSRC_LIST_2_SP4B;


/* Count to track the number of callBacks for SPORT transfer */
volatile uint8_t CallbackCount = 0;

volatile uint32_t TestCallbackCount = 0;
volatile uint32_t TestCallbackCountTx = 0;

/* Memory required for SPORT */
static uint8_t SPORTMemory4A[ADI_SPORT_MEMORY_SIZE];
static uint8_t SPORTMemory4B[ADI_SPORT_MEMORY_SIZE];

/* SPORT Handle */
static ADI_SPORT_HANDLE hSPORTDev4ATx;//TX
static ADI_SPORT_HANDLE hSPORTDev4BRx;//RX

/* Memory required for TWI */
uint8_t TwideviceMemory[ADI_TWI_MEMORY_SIZE];

/* TWI driver handle */
static ADI_TWI_HANDLE hTwiDevice;

/* SPU handle */
static ADI_SPU_HANDLE      ghSpu;

/* Memory required for the SPU operation */
uint8_t             SpuMemory[ADI_SPU_MEMORY_SIZE];


/* Dev buffer for configuring ADC-DAC through TWI*/
static uint8_t devBuffer[BUFFER_SIZE];


static void SPORTCallback(
    void        *pAppHandle,
    uint32_t     nEvent,
    void        *pArg
)
{
	int i;

    /* CASEOF (event type) */
    switch (nEvent)
    {
        /* CASE (buffer processed) */
        case ADI_SPORT_EVENT_RX_BUFFER_PROCESSED:
        		TestCallbackCount +=1;
        		CallbackCount +=1;
        		if(CallbackCount==1)
        		{
        		   for(i=0;i<COUNT;i++)
        		   {
        			   int_SP0ABuffer1[i]=int_SP0ABuffer4[i];/*Copy ADC buffer to DAC buffer */
        		   }
        		}

        		if(CallbackCount==2)
				{
				   for(i=0;i<COUNT;i++)
				   {
					   int_SP0ABuffer2[i]=int_SP0ABuffer5[i];/* Copy ADC buffer to DAC buffers */
				   }
				   CallbackCount=0;
				}


        		break;
        default:
        	 break;
    }



    /* return */
}

static void SPORTCallbackTx(
    void        *pAppHandle,
    uint32_t     nEvent,
    void        *pArg
)
{
    /* CASEOF (event type) */
    switch (nEvent)
    {
        /* CASE (buffer processed) */
        case ADI_SPORT_EVENT_TX_BUFFER_PROCESSED:
        		TestCallbackCountTx +=1;
        		break;
        default:
        	 break;
    }



    /* return */
}


/*
 * Prepares SPU configuration.
 *
 * Parameters
 *  None
 *
 * Returns
 *  None
 *
 */
static int SPU_init(void)
{
    if(adi_spu_Init(0, SpuMemory, NULL, NULL, &ghSpu) != ADI_SPU_SUCCESS)
    {
    	REPORT_ERROR("Failed to initialize SPU service\n");
		return FAILED;
    }

    /* Make SPORT 0A to generate secure transactions */
    if(adi_spu_EnableMasterSecure(ghSpu, SPORT_4A_SPU, true) != ADI_SPU_SUCCESS)
    {
    	REPORT_ERROR("Failed to enable Master secure for SPORT0A\n");
		return FAILED;
    }

    /* Make SPORT 0B to generate secure transactions */
    if(adi_spu_EnableMasterSecure(ghSpu, SPORT_4B_SPU, true) != ADI_SPU_SUCCESS)
    {
    	REPORT_ERROR("Failed to enable Master secure for SPORT0B\n");
		return FAILED;
    }

    return SUCCESS;
}

/*
 * Prepares SRU configuration.
 *
 * Parameters
 *  None
 *
 * Returns
 *  None
 *
 */
void SRU_Init(void)
{
	*pREG_PADS0_DAI0_IE=0x1fffff;
	*pREG_PADS0_DAI1_IE=0x1fffff;


    SRU(DAI0_PB02_O,SPT4_ACLK_I); /*ADC-DAC clock to SPORT 4A*/
    SRU(DAI0_PB02_O,SPT4_BCLK_I); /*ADC-DAC clock to SPORT 4B*/
    SRU(LOW,DAI0_PBEN02_I);

    SRU(DAI0_PB01_O,SPT4_AFS_I);  /*ADC-DAC FS to SPORT 4A*/
    SRU(DAI0_PB01_O,SPT4_BFS_I);  /*ADC-DAC FS to SPORT 4B*/
    SRU(LOW,DAI0_PBEN01_I);

    SRU(SPT4_AD0_O,DAI0_PB03_I); /* SPORT 4A to DAC*/
    SRU(HIGH,DAI0_PBEN03_I);

    SRU(DAI0_PB04_O,SPT4_BD0_I); /*ADC data to SPORT 4B*/
    SRU(LOW,DAI0_PBEN04_I);

}

static void PrepareDescriptors (void)
{
#if defined(__ADSPCORTEXA55__)
	iDESC_LIST_1_SP4A.pStartAddr	= (uint32_t)(uintptr_t)(int *)int_SP0ABuffer1;
	iDESC_LIST_1_SP4A.pNxtDscp		= (uint32_t)(uintptr_t)&iDESC_LIST_2_SP4A;
#else
	iDESC_LIST_1_SP4A.pStartAddr	= (int *)int_SP0ABuffer1;
	iDESC_LIST_1_SP4A.pNxtDscp		= &iDESC_LIST_2_SP4A;
#endif
	iDESC_LIST_1_SP4A.Config		= ENUM_DMA_CFG_XCNT_INT ;
	iDESC_LIST_1_SP4A.XCount		= COUNT;
	iDESC_LIST_1_SP4A.XModify		= 4;
	iDESC_LIST_1_SP4A.YCount		= 0;
	iDESC_LIST_1_SP4A.YModify		= 0;

#if defined(__ADSPCORTEXA55__)
	iDESC_LIST_2_SP4A.pStartAddr	= (uint32_t)(uintptr_t)(int *)int_SP0ABuffer2;
	iDESC_LIST_2_SP4A.pNxtDscp		= (uint32_t)(uintptr_t)&iDESC_LIST_1_SP4A;
#else
	iDESC_LIST_2_SP4A.pStartAddr	= (int *)int_SP0ABuffer2;
	iDESC_LIST_2_SP4A.pNxtDscp		= &iDESC_LIST_1_SP4A;
#endif
	iDESC_LIST_2_SP4A.Config		= ENUM_DMA_CFG_XCNT_INT ;
	iDESC_LIST_2_SP4A.XCount		= COUNT;
	iDESC_LIST_2_SP4A.XModify		= 4;
	iDESC_LIST_2_SP4A.YCount		= 0;
	iDESC_LIST_2_SP4A.YModify		= 0;

#if defined(__ADSPCORTEXA55__)
	iSRC_LIST_1_SP4B.pStartAddr		= (uint32_t)(uintptr_t)(int *)int_SP0ABuffer4;
	iSRC_LIST_1_SP4B.pNxtDscp		= (uint32_t)(uintptr_t)&iSRC_LIST_2_SP4B;
#else
	iSRC_LIST_1_SP4B.pStartAddr		=(int *)int_SP0ABuffer4;
	iSRC_LIST_1_SP4B.pNxtDscp		= &iSRC_LIST_2_SP4B;
#endif
	iSRC_LIST_1_SP4B.Config			= ENUM_DMA_CFG_XCNT_INT ;
	iSRC_LIST_1_SP4B.XCount			= COUNT;
	iSRC_LIST_1_SP4B.XModify		= 4;
	iSRC_LIST_1_SP4B.YCount			= 0;
	iSRC_LIST_1_SP4B.YModify		= 0;

#if defined(__ADSPCORTEXA55__)
	iSRC_LIST_2_SP4B.pStartAddr		= (uint32_t)(uintptr_t)(int *)int_SP0ABuffer5;
	iSRC_LIST_2_SP4B.pNxtDscp		= (uint32_t)(uintptr_t)&iSRC_LIST_1_SP4B;
#else
	iSRC_LIST_2_SP4B.pStartAddr		=(int *)int_SP0ABuffer5;
	iSRC_LIST_2_SP4B.pNxtDscp		= &iSRC_LIST_1_SP4B;
#endif
	iSRC_LIST_2_SP4B.Config			= ENUM_DMA_CFG_XCNT_INT;
	iSRC_LIST_2_SP4B.XCount			= COUNT;
	iSRC_LIST_2_SP4B.XModify		= 4;
	iSRC_LIST_2_SP4B.YCount			= 0;
	iSRC_LIST_2_SP4B.YModify		= 0;

}

static int Sport_Init(void)
{
    /* SPORT return code */
    ADI_SPORT_RESULT    eResult;

	/* Open the SPORT Device 4A */
	eResult = adi_sport_Open(SPORT_DEVICE_4A,ADI_HALF_SPORT_A,ADI_SPORT_DIR_TX, ADI_SPORT_I2S_MODE, SPORTMemory4A,ADI_SPORT_MEMORY_SIZE,&hSPORTDev4ATx);
	CHECK_RESULT(eResult);
	/* Open the SPORT Device 4B*/
	eResult = adi_sport_Open(SPORT_DEVICE_4B,ADI_HALF_SPORT_B,ADI_SPORT_DIR_RX, ADI_SPORT_I2S_MODE, SPORTMemory4B,ADI_SPORT_MEMORY_SIZE,&hSPORTDev4BRx);
	CHECK_RESULT(eResult);

	/* Register SPORT Callback function */
	eResult = adi_sport_RegisterCallback(hSPORTDev4BRx,SPORTCallback,NULL);
	CHECK_RESULT(eResult);

	/* Register SPORT Callback function */
	eResult = adi_sport_RegisterCallback(hSPORTDev4ATx,SPORTCallbackTx,NULL);
	CHECK_RESULT(eResult);

	/* Prepare descriptors */
	PrepareDescriptors();

	/* Submit the first buffer for Rx.  */
	eResult = adi_sport_DMATransfer(hSPORTDev4BRx,&iSRC_LIST_1_SP4B,(DMA_NUM_DESC),ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	CHECK_RESULT(eResult);
	/* Submit the first buffer for Tx.  */
	eResult = adi_sport_DMATransfer(hSPORTDev4ATx,&iDESC_LIST_1_SP4A,(DMA_NUM_DESC),ADI_PDMA_DESCRIPTOR_LIST, ADI_SPORT_CHANNEL_PRIM);
	CHECK_RESULT(eResult);

	/*Enable the Sport Device 4B */
	eResult = adi_sport_Enable(hSPORTDev4BRx,true);
	CHECK_RESULT(eResult);
	/*Enable the Sport Device 4A */
	eResult = adi_sport_Enable(hSPORTDev4ATx,true);
	CHECK_RESULT(eResult);

	return eResult;

}

#if (ADI_CONFIG_CONTINUOUS_AUDIO == 0)
static int Sport_Stop(void)
{
    /* SPORT return code */
    ADI_SPORT_RESULT    eResult;

    /*Stop the DMA transfer of  Sport Device 4B */
	eResult = adi_sport_StopDMATransfer(hSPORTDev4BRx);
	CHECK_RESULT(eResult);
	/*Stop the DMA transfer of  Sport Device 4A */
	eResult = adi_sport_StopDMATransfer(hSPORTDev4ATx);
	CHECK_RESULT(eResult);
	/*Close Sport Device 4B */
	eResult = adi_sport_Close(hSPORTDev4BRx);
	CHECK_RESULT(eResult);
	/*Close Sport Device 4A */
	eResult = adi_sport_Close(hSPORTDev4ATx);
	CHECK_RESULT(eResult);

	return eResult;
}
#endif

ADI_1372_CONFIG_RESULT Write_TWI_8bit_Reg(unsigned char Reg_ID, unsigned char Tx_Data)
{
	ADI_TWI_RESULT eResult;
	devBuffer[0] = 0x00;
	devBuffer[1] = Reg_ID;
	devBuffer[2] = Tx_Data;
	eResult= adi_twi_Write(hTwiDevice, devBuffer, 3u, false);
	if((ADI_1372_CONFIG_RESULT)eResult!=ADI_1372_SUCCESS)
	{
		return ADI_1372_CONFIG_FAILED;
	}

	return ADI_1372_SUCCESS;
}

unsigned char Read_TWI_8bit_Reg(unsigned char Reg_ID)
{
	ADI_TWI_RESULT eResult;
	unsigned char Rx_Data;

	/* write register address */
	devBuffer[0] = 0x00;
	devBuffer[1] = Reg_ID;
	eResult = adi_twi_Write(hTwiDevice, devBuffer, 2u, true);
	if(eResult!=ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("TWI write failed 0x%08X\n", eResult);
	}

	/* read register value */
	eResult = adi_twi_Read(hTwiDevice, &Rx_Data, 1u, false);
	if(eResult!=ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("TWI Read failed 0x%08X\n", eResult);
	}

	return Rx_Data;
}

static int Init_TWI(void)
{

	ADI_TWI_RESULT eResult;

	eResult = adi_twi_Open(TWIDEVNUM, ADI_TWI_MASTER, &TwideviceMemory[0],
			   	ADI_TWI_MEMORY_SIZE, &hTwiDevice);
	if(eResult!=ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("TWI Open failed 0x%08X\n", eResult);
	}

	eResult = adi_twi_SetPrescale(hTwiDevice, PRESCALEVALUE);
	if(eResult!=ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("TWI Set Prescale failed 0x%08X\n", eResult);
	}

	eResult = adi_twi_SetBitRate(hTwiDevice, BITRATE);
	if(eResult!=ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("TWI Set Bitrate failed 0x%08X\n", eResult);
	}


	eResult = adi_twi_SetDutyCycle(hTwiDevice, DUTYCYCLE);
	if(eResult!=ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("TWI Set Duty cycle failed 0x%08X\n", eResult);
	}

	eResult = adi_twi_SetHardwareAddress(hTwiDevice, TARGETADDR);
	if(eResult!=ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("TWI Set Hw address failed 0x%08X\n", eResult);
	}

	return eResult;
}

static int Stop_TWI(void)
{
	ADI_TWI_RESULT eResult;

	eResult = adi_twi_Close(hTwiDevice);
	CHECK_RESULT(eResult);

	return eResult;
}

/*****************************************************************************************************************************/

static int ADAU_1372_init(void)
{
	int i;

	for(i=0;i<58;i++)
	{
		/* write value */
		Write_TWI_8bit_Reg(Config_array_DAC[i].Reg_Add,Config_array_DAC[i].Value);
		Config_read_DAC[i]=Read_TWI_8bit_Reg(Config_array_DAC[i].Reg_Add);
        if(Config_array_DAC[i].Value!= Config_read_DAC[i])
		{
           	DEBUG_INFORMATION("\n fail");
           	return FAILED;
		}
	}

	return SUCCESS;
}

static int ADAU_1372_Pllinit(void)
{
	int status,delay1=0xffff;
	ADI_TWI_RESULT eResult;
	ADI_1372_CONFIG_RESULT e1372Configresult;


	/* Set the hardware address */
   	eResult = adi_twi_SetHardwareAddress(hTwiDevice, TARGETADDR_1372);
	if(eResult!=ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("TWI Set Hw address failed 0x%08X\n", eResult);
	}

	while(delay1--)
	{
		asm("nop;");
	}


	/* Configure the PLL*/
	e1372Configresult= Write_TWI_8bit_Reg(ADAU1372_REG_PLL_CTRL4,0x10);
	if(eResult!=ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("PLL CTRL4 register write failed 0x%08X\n", e1372Configresult);
	}

	delay1=0xffff;
	while(delay1--)
	{
		asm("nop;");
	}

	/* Configure the PLL/crystal, PLLEN*/
	e1372Configresult= Write_TWI_8bit_Reg(ADAU1372_REG_CLK_CTRL,0x89);
	if(eResult!=ADI_TWI_SUCCESS)
	{
		REPORT_ERROR("PLL Configure/enable failed 0x%08X\n", e1372Configresult);
	}
	delay1=0xffff;
	while(delay1--)
	{
		asm("nop;");
	}

	/* Wait for PLL to get locked*/
	status=Read_TWI_8bit_Reg(ADAU1372_REG_PLL_CTRL5);
	while(!(status & 0x01) )
	{
		/*DG: Code to be added by Nabeel for Timeout/delay*/
		status=Read_TWI_8bit_Reg(ADAU1372_REG_PLL_CTRL5);
	}



	return eResult;
}



/*
 * Main function
 */
int main(int argc, char *argv[])
{
	/**
	 * Initialize managed drivers and/or services that have been added to
	 * the project.
	 * @return zero on success
	 */

	uint32_t Result=0;

	adi_initComponents();
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif

	DEBUG_INFORMATION( "ADAU1372 ADC/DAC Audio talk-through test I2S\n" );

    /* SPU initialization */
	if (Result==0u)
	{
		Result=SPU_init();
	}

	/* SRU Configuration */
	SRU_Init();

	/* TWI Initialization */
	if (Result==0u)
	{
		Result=Init_TWI();
	}

	/* ADAU1372 PLL Initialization */
	if (Result==0u)
	{
		Result=ADAU_1372_Pllinit();
	}

	/* ADAU1372 Initialization */
	if (Result==0u)
	{
		Result=ADAU_1372_init();
	}

	/* SPORT Initialization */
	if (Result==0u)
	{
		Result=Sport_Init();
	}

	/* Close TWI */
	if (Result==0u)
	{
		Result=Stop_TWI();
	}

#if (ADI_CONFIG_CONTINUOUS_AUDIO==0)

	while(1)
	{
		if(TestCallbackCount == 8000)
		{
			int delay=0xffffff;
			while(delay--)
			{
				asm("nop;");
			}

			if (Result==0u)
			{
				Result=Sport_Stop();
			}

			if(Result==0u)
			{
				DEBUG_INFORMATION("All done\n");
			}
			else
			{
				DEBUG_INFORMATION("Example failed.\n");
			}

			break;
		}
	}
#elif (ADI_CONFIG_CONTINUOUS_AUDIO==1)
	while(1);
#endif
}



