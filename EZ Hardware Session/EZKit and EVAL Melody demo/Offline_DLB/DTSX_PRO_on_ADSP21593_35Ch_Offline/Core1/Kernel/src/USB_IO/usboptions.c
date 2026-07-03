/*********************************************************************************

Copyright(c) 2005 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

*********************************************************************************/


#include <stdio.h>
#include <stdlib.h>
#include <services/gpio/adi_gpio.h>
#include "sysreg.h"

#include "../host/hostapp/hostapp.h"
/* Managed drivers and/or services include */
#include "../system/adi_initialize.h"

/* TWI2 pin mux configuration macros */ 
#define TWI2_SCL_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<28))
#define TWI2_SDA_PORTA_MUX  ((uint32_t) ((uint32_t) 0<<30))
#define TWI2_SCL_PORTA_FER  ((uint32_t) ((uint32_t) 1<<14))
#define TWI2_SDA_PORTA_FER  ((uint32_t) ((uint32_t) 1<<15))


#define M9

/*********************************************************************

Prototypes

*********************************************************************/

unsigned int QuerySupport( uint32_t u32Command );
unsigned int PerformIo(void);

char FwVersionInfo[NUM_VERSION_STRINGS][MAX_VERSION_STRING_LEN] =
{
                        __DATE__,   //build date
                        __TIME__,   //build time
                        "02.00.00", //version number
#ifdef __ADSP21262__
                        "SHARC - 21262",
#elif __ADSP21364__
                        "SHARC - 21364",
#elif __ADSP21369__
                        "SHARC - 21369",
#elif __ADSP21375__
                        "SHARC - 21375",
#elif __ADSP21469__
                        "SHARC - 21469",
#elif __ADSP21479__
                        "SHARC - 21479",
#elif __ADSP21489__
                        "SHARC - 21489",
#elif __ADSP21569__
                        "SHARC - 21569",
#elif __ADSP21593__
                        "SHARC - 21593",
#endif
    "usb_spi"//application name
};

volatile bool g_bDeviceConfigured = false;

/* Initialize SPI related configuration */

#include <services/spu/adi_spu.h>
#include <drivers/spi/adi_spi.h>
#include "SPI_Common.h"

void IntializeSPI(void);
int SpuInit(void);
void CheckResult(ADI_SPI_RESULT Result);
void SPICallback(void *pCBParam, uint32_t Event, void *pArg);

/* SPU handle */
ADI_SPU_HANDLE hSpu;
/* Memory required for the SPU operation */
uint8_t  SpuMemory[ADI_SPU_MEMORY_SIZE];

/* SPI Handle */
ADI_SPI_HANDLE hSPI;
/* Driver memory required for SPI */
uint8_t SPIMemory[ADI_SPI_BIDIR_MEMORY_SIZE];

/* Count to track the number of callBacks */
volatile bool SPITxFlag,SPIRxFlag;
volatile bool bTransferReq = false;

ADI_SPI_BUFFER SPICommandBuff_main;

void PrepareSPITxDescriptor(ADI_SPI_BUFFER *pSPIBuffer);
void PrepareSPIRxDescriptor(ADI_SPI_BUFFER *pSPIBuffer);

ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  SPI_Src_List_Desc;

ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  SPI_Dest_List_Desc;

ADI_CACHE_ALIGN ADI_PDMA_DESC_LIST  SPI_Dest_List_Desc_Dummy;

uint8_t Dummy_Read[1]= {0};

/*  Possible SPI instances are
    ADI_SPI_0,ADI_SPI_1 and ADI_SPI_2  */
#define SPI_DEV      ADI_SPI_2

#define DMA_NUM_DESC 1u

#define DMA_MSIZE_IN_BYTES  1u

#define ADI_CACHE_ALIGN _Pragma("align 64")

#define ADI_CACHE_ROUND_UP_SIZE(size, type) \
    (((((((size) * sizeof(type)) \
           + (ADI_CACHE_LINE_LENGTH - 1uL)) \
          / ADI_CACHE_LINE_LENGTH) * ADI_CACHE_LINE_LENGTH) \
      + (sizeof(type) - 1uL)) / sizeof(type))

#define SUCCESS   0
#define FAILED   -1

#define REPORT_ERROR

#define SPI0_SPU_PID             (101)
#define SPI1_SPU_PID             (102)
#define SPI2_SPU_PID             (103)
#define SPI3_SPU_PID             (104)

#define SPI0_TxDMA_SPU_PID       (93)
#define SPI0_RxDMA_SPU_PID       (94)

#define SPI1_TxDMA_SPU_PID       (95)
#define SPI1_RxDMA_SPU_PID       (96)

#define SPI2_TxDMA_SPU_PID       (97)
#define SPI2_RxDMA_SPU_PID       (98)

#define SPI3_TxDMA_SPU_PID       (99)
#define SPI3_RxDMA_SPU_PID       (100)

void ConfigSoftSwitches_EV_21593_SOM(void);
void ConfigSoftSwitches_EV_SOMCRR_EZKIT (void);

/*Select the GPIO output port and pin*/
#define GPIO_PORT ADI_GPIO_PORT_A
#define GPIO_PIN  ADI_GPIO_PIN_14

#define GPIO_MEMORY_SIZE (ADI_GPIO_CALLBACK_MEM_SIZE*2)
static uint8_t gpioMemory[GPIO_MEMORY_SIZE];
uint32_t gpiocallbacks;

/*
 * Initializes SPU
 *
 * Parameters           None
 *
 * Returns
 *  - SUCCESS   - SPU initialization passed
 *  - FAILURE   - SPU initialization failed
 *
 */
int SpuInit(void)
{
    /* Initialize SPU Service */
    if(adi_spu_Init(0u, SpuMemory, (void*)0, (void*)0, &hSpu) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to initialize SPU service\n");
        return (FAILED);
    }

    /* Make SPI0 to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI0_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for SPI0\n");
        return (FAILED);
    }

    /* Make SPI1 to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI1_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for SPI1\n");
        return (FAILED);
    }

    /* Make SPI2 to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI2_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for SPI2\n");
        return (FAILED);
    }

    /* Make SPI0 Tx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI0_TxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for SPI0 Tx DMA\n");
        return (FAILED);
    }

    /* Make SPI0 Rx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI0_RxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for SPI0 Rx DMA\n");
        return (FAILED);
    }

    /* Make SPI1 Tx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI1_TxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for SPI1 Tx DMA\n");
        return (FAILED);
    }

    /* Make SPI1 Rx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI1_RxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for SPI1 Rx DMA\n");
        return (FAILED);
    }

    /* Make SPI2 Tx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI2_TxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for SPI2 Tx DMA\n");
        return (FAILED);
    }

    /* Make SPI2 Rx DMA to generate secure transactions */
    if(adi_spu_EnableMasterSecure(hSpu, SPI2_RxDMA_SPU_PID, true) != ADI_SPU_SUCCESS)
    {
        REPORT_ERROR("Failed to enable Master secure for SPI2 Rx DMA\n");
        return (FAILED);
    }

    return (SUCCESS);
}
/*********************************************************************
*
*   Function:       CheckResult
*
*   Description:    Checks the SPI result is successful
*
*********************************************************************/
void CheckResult(ADI_SPI_RESULT Result) {
    if (Result != ADI_SPI_SUCCESS) {
        REPORT_ERROR("Failed with error code 0x%08X\n", Result);
    }
}

/*********************************************************************
*
*   Function:       SPICallback
*
*   Description:    SPI callback function for updating the SPI transfer status
*
*********************************************************************/
void SPICallback(void *pCBParam, uint32_t Event, void *pArg)
{
    if(Event == (uint32_t)ADI_SPI_EVENT_TX_PROCESSED)
    {
        SPITxFlag = true;
    }
    if(Event == (uint32_t)ADI_SPI_EVENT_RX_PROCESSED)
    {
    	SPIRxFlag = true;
    }
}

/*********************************************************************
*
*   Function:       IntializeSPI
*
*   Description:    This function will initialize the SPI module for operating in DMA mode
*
*********************************************************************/
void IntializeSPI(void)
{
    ADI_SPI_RESULT    eResult;

    /* making all the SPI transactions as secure master */
    if(SpuInit() != SUCCESS)
    {
        REPORT_ERROR("Failed to initialize spu\n");
    }

    /* Open SPI */
    eResult = adi_spi_Open(SPI_DEV, ADI_SPI_DIR_BIDIRECTION, SPIMemory, ADI_SPI_BIDIR_MEMORY_SIZE, &hSPI);
    CheckResult(eResult);

    eResult = adi_spi_SetasMaster(hSPI,false);
    CheckResult(eResult);

    /* Register SPI Callback function for DMA mode */
    eResult = adi_spi_RegisterCallback(hSPI, SPICallback, (void*)0);
    CheckResult(eResult);

    eResult = adi_spi_SetIOMode(hSPI,ADI_SPI_QSPI_MODE);
    CheckResult(eResult);

}

void PrepareSPITxDescriptor(ADI_SPI_BUFFER *pSPIBuffer)
{
    /* Buffer Start Address */
	SPI_Src_List_Desc.pStartAddr            = pSPIBuffer->pData;
    /* DMA Config - only specify memory transfer size */
	SPI_Src_List_Desc.XCount                = pSPIBuffer->ElementCount;
	SPI_Src_List_Desc.XModify               = DMA_MSIZE_IN_BYTES;
	SPI_Src_List_Desc.Config                = ENUM_DMA_CFG_PERIPH_INT;
	SPI_Src_List_Desc.pNxtDscp              = (void*)0;
}

void PrepareSPIRxDescriptor(ADI_SPI_BUFFER *pSPIBuffer)
{
    /* Buffer Start Address */
	SPI_Dest_List_Desc.pStartAddr           = pSPIBuffer->pData;
    /* DMA Config - only specify memory transfer size */
	SPI_Dest_List_Desc.XCount               = pSPIBuffer->ElementCount;
	SPI_Dest_List_Desc.XModify              = DMA_MSIZE_IN_BYTES;
	SPI_Dest_List_Desc.Config               = ENUM_DMA_CFG_XCNT_INT;
	SPI_Dest_List_Desc.pNxtDscp             = (void*)0;
}

void PrepareSPIRxDescriptor_Dummy(void)
{
    /* Buffer Start Address */
	SPI_Dest_List_Desc_Dummy.pStartAddr           = &Dummy_Read[0];
    /* DMA Config - only specify memory transfer size */
	SPI_Dest_List_Desc_Dummy.XCount               = 1;
	SPI_Dest_List_Desc_Dummy.XModify              = DMA_MSIZE_IN_BYTES;
	SPI_Dest_List_Desc_Dummy.Config               = ENUM_DMA_CFG_XCNT_INT;
	SPI_Dest_List_Desc_Dummy.pNxtDscp             = (void*)0;
}

bool adi_dev_Read(
	void      *pBuffer)         // pointer to buffer
{
	/* SPI return code */
	ADI_SPI_RESULT    eResult;

	bool Result =SUCCESS;             // return value
    ADI_SPI_BUFFER    *pBuff;         // buffer pointer

    pBuff = (ADI_SPI_BUFFER*)pBuffer;

    /* Clear the flag for safety*/
    SPIRxFlag = false;

    PrepareSPIRxDescriptor(pBuff);

    eResult = adi_spi_DMARead(hSPI, &SPI_Dest_List_Desc, DMA_NUM_DESC, ADI_PDMA_STOP_MODE);
    CheckResult(eResult);

    // wait for operation to complete
    while(1)
    {
    	if(SPIRxFlag == 1)
    	{
    		SPIRxFlag = 0;
    		break;
    	}
    }

    /* Clear the flag */
    SPIRxFlag = false;

    return Result;
}

/*********************************************************************
*
*   Function:    adi_dev_Write
*
*   Description: Accepts buffer containing data to be transmitted out
*                through the NET2272
*
*********************************************************************/

bool adi_dev_Write(
    void                *pBuffer)         // pointer to buffer
{
	/* SPI return code */
	ADI_SPI_RESULT    eResult;

	bool               Result =SUCCESS;             // return value
    ADI_SPI_BUFFER *pBuff;             // buffer pointer

    pBuff = (ADI_SPI_BUFFER*)pBuffer;

    /* Clear the flag */
    SPITxFlag = false;

    PrepareSPITxDescriptor(pBuff);

    eResult = adi_spi_DMAWrite(hSPI, &SPI_Src_List_Desc, DMA_NUM_DESC, ADI_PDMA_STOP_MODE);
    CheckResult(eResult);

    adi_gpio_Set(GPIO_PORT,GPIO_PIN);

    // wait for operation to complete
    while(1)
    {
    	if(SPITxFlag == 1)
    	{
    		SPITxFlag = 0;
    		break;
    	}
    }

 	adi_gpio_Clear(GPIO_PORT,GPIO_PIN);

    /* Clear the flag */
    SPITxFlag = false;

    return(Result);
}


void USB_Options(void)
{
    unsigned int Result;
    bool bKeepRunning = true;
    ADI_GPIO_RESULT    GPIOResult;
    uint32_t PortValue=0;
    USBCB usbcb;
    USBCB *pusbcb = &usbcb;
#ifdef DUMMY_READ
    unsigned long ulShift = 0;
#endif

	/* Initialize managed drivers and/or services */
	adi_initComponents();

	/* TWI 2 should be pinmuxed for softconfig */
    /* PORTx_MUX registers */
    *pREG_PORTA_MUX |=  TWI2_SCL_PORTA_MUX | TWI2_SDA_PORTA_MUX;

    /* PORTx_FER registers */
    *pREG_PORTA_FER |=  TWI2_SCL_PORTA_FER | TWI2_SDA_PORTA_FER;

    ConfigSoftSwitches_EV_21593_SOM();

#ifndef M9
    ConfigSoftSwitches_EV_SOMCRR_EZKIT();
#else
    *pREG_PORTB_FER_CLR=0x100;
    *pREG_PORTB_DIR_SET=0x100;
    *pREG_PORTB_DATA_CLR=0x100;
#endif

    /* TWI 2 should now be removed from mux so as to use this pins as GPIO */
    /* PORTx_FER registers */
    *pREG_PORTA_FER &=  ~(TWI2_SCL_PORTA_FER | TWI2_SDA_PORTA_FER);

    /* GPIO initialization of PA_14*/
    GPIOResult = adi_gpio_Init((void*)gpioMemory,GPIO_MEMORY_SIZE,&gpiocallbacks);
  	if(GPIOResult != ADI_GPIO_SUCCESS)
  	{
  		printf("GPIO Initialization failed \n");
  	}

  	/* GPIO initialization of PA_14 as input and low by default */
  	GPIOResult = adi_gpio_PortInit(GPIO_PORT, GPIO_PIN, ADI_GPIO_DIRECTION_OUTPUT,true);
  	if(GPIOResult != ADI_GPIO_SUCCESS)
  	{
  		printf("GPIO Initialization failed \n");
  	}

  	adi_gpio_Clear(GPIO_PORT,GPIO_PIN);

    // initialize the buffer
    SPICommandBuff_main.pData = &usbcb;
#ifdef DUMMY_READ
    SPICommandBuff_main.ElementCount = ((sizeof(usbcb)-sizeof(unsigned long))+1);
#else
    SPICommandBuff_main.ElementCount = sizeof(usbcb);
#endif

    IntializeSPI();
    asm("nop;");
    asm("nop;");
    asm("nop;");

	// wait for a USB command block from the host indicating what function we should perform
	Result = adi_dev_Read((ADI_SPI_BUFFER *)&SPICommandBuff_main);
#ifdef DUMMY_READ
    ulShift = usbcb.u32_Command>>8;
    usbcb.u32_Command = ulShift | ((usbcb.u32_Data & 0xFF)<<24);
    ulShift = usbcb.u32_Data>>8;
    usbcb.u32_Data = ulShift | ((usbcb.u32_Count & 0xFF)<<24);
    ulShift = usbcb.u32_Count>>8;
    usbcb.u32_Count = ulShift | ((usbcb.u32_Rem & 0xFF)<<24);
#endif

    // Check for acknowledgement from the Host
	if(usbcb.u32_Data == 0x00000001)
	{
	   g_bDeviceConfigured = true;
	}

    // while we should keep running
    while( bKeepRunning )
    {
        // wait for a USB command block from the host indicating what function we should perform
        Result = adi_dev_Read((ADI_SPI_BUFFER *)&SPICommandBuff_main);
#ifdef DUMMY_READ
        ulShift = usbcb.u32_Command>>8;
        usbcb.u32_Command = ulShift | ((usbcb.u32_Data & 0xFF)<<24);
        ulShift = usbcb.u32_Data>>8;
        usbcb.u32_Data = ulShift | ((usbcb.u32_Count & 0xFF)<<24);
        ulShift = usbcb.u32_Count>>8;
        usbcb.u32_Count = ulShift | ((usbcb.u32_Rem & 0xFF)<<24);
#endif

        if ( 0 == Result )
        {
            // switch on the command we just received
            switch( pusbcb->u32_Command )
            {
            // host is asking if we support a given command
            case QUERY_SUPPORT:
                Result = QuerySupport(pusbcb->u32_Data );
                break;

            // perform IO over USB
            case USBIO_START:
                Result = PerformIo();
                break;

            // unsupported command
            default:
                break;
            }
        }
    }
}
