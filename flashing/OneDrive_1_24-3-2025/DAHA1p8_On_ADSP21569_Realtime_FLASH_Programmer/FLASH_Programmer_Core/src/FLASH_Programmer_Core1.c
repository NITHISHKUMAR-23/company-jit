/*****************************************************************************
 * SPI Flash Driver-BD.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "FLASH_Programmer_Core1.h"
#include <sys/platform.h>
#include <stdio.h>
#include "stdlib.h"
#include <stdint.h>
#include <stdbool.h>


/*****************************************************************************************************************************************************************/

#define PROGRAM_SSL
//#define PROGRAM_S4
//#define PROGRAM_S8

#ifdef PROGRAM_SSL
	#define 	WR_Block_ID		0
	#define		INCLUDE_FILE 	"ADSP21569.ldr"
#endif

#ifdef PROGRAM_S4
	#define 	WR_Block_ID		4
	#define		INCLUDE_FILE 	"Sector4_Core1.ldr"
#endif

#ifdef PROGRAM_S8
	#define 	WR_Block_ID		8
	#define		INCLUDE_FILE 	"Sector8_Core1.ldr"
#endif


#define 	RD_Block_ID		WR_Block_ID

//section ("seg_l2_uncached")
//section ("seg_sdram")
//unsigned char Write_BUFF[] = {
//	#include INCLUDE_FILE
//};

extern unsigned char Write_BUFF[];
extern unsigned char buffer_end;

section ("seg_sdram")
unsigned char Read_BUFF[FLASH_BLOCK_COUNT * FLASH_BLOCK_SIZE];
bool result;
/*****************************************************************************************************************************************************************/

void Init_PLL(void);
void Init_pinmux(void);
//void Init_DataBUFF(void);
void Init_SPI2(void);
void Verify_flash_codes(void);
void Erase_flash(unsigned char ERS_BLK_ID, unsigned long long data_count);
void Write_flash(unsigned char Block_ID, unsigned char* flash_page_data_buff, unsigned long long data_count);
void Read_flash(unsigned char Block_ID, unsigned char* flash_page_data_buff, unsigned long long data_count);
bool check_result(int size);

unsigned char flash_byte_access(unsigned char Databyte);
void wait_for_flash_status(char flag, bool state);
void Erase_flash_block(unsigned char Block_ID);
void Write_flash_page(unsigned int PAGE_ADDR, unsigned char* flash_page_data_buff, unsigned short page_data_count);
void Write_flash_Full(unsigned char ERS_BLK_ID, unsigned char* flash_page_data_buff, unsigned long long data_count);
/*****************************************************************************************************************************************************************/
int itemp=0;

void main(void)
{

	adi_initComponents();
	//Init_PLL();
	//itemp=sizeof(Write_BUFF);
	itemp = (&buffer_end) - Write_BUFF;
    Init_pinmux();
	Init_SPI2();
	//Verify_flash_codes();


	Erase_flash(WR_Block_ID, itemp);

	Write_flash_Full(WR_Block_ID, Write_BUFF, itemp);
	Read_flash (RD_Block_ID, Read_BUFF,  itemp);

	result = check_result(itemp);
	if(result)
	{
		printf("\n SUCCESS: DATA written and verified to flash \n");


	}

        else
		printf("\n ERROR: DATA writing or verification unsuccessful \n");

	printf("\nDATA written to flash \n");
	while(1);


}
/*****************************************************************************************************************************************************************/

void Init_PLL(void)
{

	  /* Check if the new MSEL is same as current MSEL Value. If so, just update the CGU_DIV register */

	   uint32_t current_MSEL = ((*pREG_CGU0_CTL & BITM_CGU_CTL_MSEL) >> BITP_CGU_CTL_MSEL);

	   if(current_MSEL == MSEL)
	   {

		   *pREG_CGU0_DIV =  (UPDT | OSEL | DSEL | S1SEL | S0SEL | SYSSEL | CSEL);
	   }

	   else
	   {
		   *pREG_CGU0_CTL = (MSEL | DF);
		   /* Check if PLL is enabled , PLL is not locking and Clocks are aligned */
		   while( !((*pREG_CGU0_STAT & BITM_CGU_STAT_CLKSALGN ) ==(~BITM_CGU_STAT_CLKSALGN)));
		   *pREG_CGU0_DIV =  (OSEL | DSEL | S1SEL | S0SEL | SYSSEL | CSEL);
		   *pREG_CGU0_CTL = MSEL ;
		   /* Wait till PLL is locked and clocks are aligned */
		   while( !((*pREG_CGU0_STAT & (BITM_CGU_STAT_PLOCK | BITM_CGU_STAT_CLKSALGN) ) == (BITM_CGU_STAT_PLOCK & (~BITM_CGU_STAT_CLKSALGN))));

	   }


}

/*****************************************************************************************************************************************************************/


bool check_result(int size)
{
	unsigned long long count,	BUFF_size = size;
	for(count=0; count<BUFF_size; count++)
		if(Read_BUFF[count] != Write_BUFF[count])
			return false;
	return true;
}
/*****************************************************************************************************************************************************************/


void Init_pinmux(void)
{

	*pREG_PORTA_MUX = 0;
	*pREG_PORTA_FER = (BITM_PORT_FER_PX1 | BITM_PORT_FER_PX2 | BITM_PORT_FER_PX3 | BITM_PORT_FER_PX4 | BITM_PORT_FER_PX5 |BITM_PORT_FER_PX6 );
	*pREG_PORTA_INEN_SET = 0x1;
}
/*****************************************************************************************************************************************************************/


void Init_SPI2(void)
{
	*pREG_SPI2_CLK	 = 24;
	*pREG_SPI2_DLY	 = 0;	//((1 << BITP_SPI_DLY_STOP) & BITM_SPI_DLY_STOP) ;
	*pREG_SPI2_SLVSEL= ENUM_SPI_SLVSEL_SSEL1_HI | ENUM_SPI_SLVSEL_SSEL1_EN;

	*pREG_SPI2_CTL 	 = ENUM_SPI_CTL_MASTER ;
	*pREG_SPI2_TXCTL = ENUM_SPI_TXCTL_TTI_EN | ENUM_SPI_TXCTL_TWC_EN | ENUM_SPI_TXCTL_ZERO ;
	*pREG_SPI2_RXCTL = ENUM_SPI_RXCTL_OVERWRITE ;

	*pREG_SPI2_TXCTL |= ENUM_SPI_TXCTL_TX_EN;	//	enable Tx SPI
	*pREG_SPI2_RXCTL |= ENUM_SPI_RXCTL_RX_EN;	//	enable Rx SPI
	*pREG_SPI2_CTL 	 |= ENUM_SPI_CTL_EN;
}
/*****************************************************************************************************************************************************************/


void Verify_flash_codes(void)
{
	unsigned char FLASH_MAN_ID;
	unsigned short FLASH_DEV_ID;

	*pREG_SPI2_SLVSEL &= ~ENUM_SPI_SLVSEL_SSEL1_HI ;			//	select flash
	*pREG_SPI2_SLVSEL &= ~ENUM_SPI_SLVSEL_SSEL1_HI ;

	flash_byte_access(FLASH_RD_JDCID);							//	send command for reading flash Identification codes
	FLASH_MAN_ID  = (flash_byte_access(DUMMY_BYTE));			//	Manufacturer ID
	FLASH_DEV_ID  = (flash_byte_access(DUMMY_BYTE)<<8);			//	Memory type ID15-8
	FLASH_DEV_ID |= (flash_byte_access(DUMMY_BYTE));			//	capacity ID7-0

	*pREG_SPI2_SLVSEL |= ENUM_SPI_SLVSEL_SSEL1_HI ;				//	deselct_flash;
	*pREG_SPI2_SLVSEL |= ENUM_SPI_SLVSEL_SSEL1_HI ;
/*
	if((FLASH_MAN_ID == 0x20) && (FLASH_DEV_ID ==0x16))
		printf("\n Flash Identification passed:\n\tManufactarer ID = 0xEF\tDevice ID = 0x4016\n");
	else	{
		printf("\nERROR: Flash Identification failed\n");
		while(1) asm("nop;");	}*/

}
/*****************************************************************************************************************************************************************/


void Erase_flash(unsigned char ERS_BLK_ID, unsigned long long data_count)
{
	unsigned char ERS_NUM_BLK = ( data_count / FLASH_BLOCK_SIZE ) + 1 ;
	
	if((ERS_BLK_ID+ERS_NUM_BLK) > FLASH_BLOCK_COUNT)	{
		printf("\nERROR: Flash Block ID may exceed maximum supported blocks\n");
		while(1) asm("nop;");				}

	printf("\nErasing the Blocks:\n");
	do{
		Erase_flash_block(ERS_BLK_ID);
		printf("\tSUCCESS: Block %d Erased\n", ERS_BLK_ID);
		ERS_NUM_BLK--; ERS_BLK_ID++;
	}while(ERS_NUM_BLK);
	printf("Erasing Completed\n ");
}
/*****************************************************************************************************************************************************************/

void Write_flash_Full(unsigned char ERS_BLK_ID, unsigned char* flash_page_data_buff, unsigned long long data_count)
{
	unsigned char ERS_NUM_BLK = ( data_count / FLASH_BLOCK_SIZE ) + 1 ;

	if((ERS_BLK_ID+ERS_NUM_BLK) > FLASH_BLOCK_COUNT)	{
		printf("\nERROR: Flash Block ID may exceed maximum supported blocks\n");
		while(1) asm("nop;");				}

	printf("\nErasing the Blocks:\n");
	do{
		Write_flash(ERS_BLK_ID, flash_page_data_buff+FLASH_BLOCK_SIZE*ERS_BLK_ID, FLASH_BLOCK_SIZE);
		printf("\tSUCCESS: Block %d Written\n", ERS_BLK_ID);
		ERS_NUM_BLK--; ERS_BLK_ID++;
	}while(ERS_NUM_BLK);
	printf("Write Completed\n ");
}

void Write_flash(unsigned char Block_ID, unsigned char* flash_page_data_buff, unsigned long long data_count)
{
	if(Block_ID > FLASH_BLOCK_COUNT-1)	{
		printf("\nERROR: Invalid Flash Block ID\n");
		while(1) asm("nop;");		}

	unsigned int PRGM_ADDR = Block_ID * FLASH_BLOCK_SIZE;
	printf("\nPogramming the Flash from Block %d:\n", Block_ID);
	while(data_count >= FLASH_PAGE_SIZE)
	{
		Write_flash_page(PRGM_ADDR, flash_page_data_buff, FLASH_PAGE_SIZE);
	//	printf("\tSUCCESS: Flash Page %d programmed\n", PRGM_ADDR>>8);
		data_count		-= FLASH_PAGE_SIZE;
		flash_page_data_buff	+= FLASH_PAGE_SIZE;
		PRGM_ADDR		+= FLASH_PAGE_SIZE;
	}

	if(data_count != 0x00)
	{
		Write_flash_page(PRGM_ADDR, flash_page_data_buff, data_count);
	//	printf("\tSUCCESS: Flash Page %d programmed\n", PRGM_ADDR>>8);
		flash_page_data_buff	+= data_count;
		PRGM_ADDR		+= data_count;
	}
	printf("Flash Programming Completed\n ");
}
/*****************************************************************************************************************************************************************/


void Read_flash(unsigned char Block_ID, unsigned char* flash_page_data_buff, unsigned long long data_count)
{
	if(Block_ID > FLASH_BLOCK_COUNT-1)		{
		printf("\nERROR: Invalid Flash Block ID\n");
		while(1) asm("nop;");			}

	unsigned int READ_ADDR = Block_ID * FLASH_BLOCK_SIZE;
	printf("\nReading the Flash from Block %d:\n", Block_ID);
	*pREG_SPI2_SLVSEL &= ~ENUM_SPI_SLVSEL_SSEL1_HI ;			//	selct_flash;

	flash_byte_access(FLASH_RD_DAT);					//	send sector erase command (0x64KB)
	flash_byte_access(READ_ADDR >> 16);					//	send block address
	flash_byte_access(READ_ADDR >> 8);
	flash_byte_access(READ_ADDR);

	unsigned long long RD_count;
	for(RD_count=0; RD_count<data_count; RD_count++)
		*flash_page_data_buff++ = (flash_byte_access(DUMMY_BYTE));

	*pREG_SPI2_SLVSEL |= ENUM_SPI_SLVSEL_SSEL1_HI ;				//	deselct_flash;
	printf("Flash Reading Completed\n");
}
/*****************************************************************************************************************************************************************/


unsigned char flash_byte_access(unsigned char Databyte)
{
	//	read RFIFO till it is empty
	while(!(*pREG_SPI2_STAT & BITM_SPI_STAT_RFE))
		*pREG_SPI2_RFIFO;

	*pREG_SPI2_TWC	= 	1;								//	single byte instruction, no addr/data
	*pREG_SPI2_TFIFO = Databyte;						//	command ID
	while(!(*pREG_SPI2_STAT & BITM_SPI_STAT_TF));		//	wait till completion
	*pREG_SPI2_STAT = BITM_SPI_STAT_TF;					//	clear latch
	return *pREG_SPI2_RFIFO;
}
/*****************************************************************************************************************************************************************/


void wait_for_flash_status(char flag, bool state)
{
	unsigned char flash_status;
	*pREG_SPI2_SLVSEL &= ~ENUM_SPI_SLVSEL_SSEL1_HI ;			//	selct_flash;
	flash_byte_access(FLASH_RD_STAT1);					//	send read status register command

	if(state)  {
		do {
			flash_status = flash_byte_access(FLASH_RD_STAT1);
		   } while(!(flash_status & flag));		}
	else	   {
		do {
			flash_status = flash_byte_access(FLASH_RD_STAT1);
		   } while(flash_status & flag);		}

	*pREG_SPI2_SLVSEL |= ENUM_SPI_SLVSEL_SSEL1_HI ;				//	deselct_flash;
}
/*****************************************************************************************************************************************************************/


void Erase_flash_block(unsigned char Block_ID)
{
	unsigned int Erase_ADDR = Block_ID * FLASH_BLOCK_SIZE;
	if(Block_ID > FLASH_BLOCK_COUNT-1)		{
		printf("\nERROR: Invalid Flash Block ID\n");
		while(1) asm("nop;");	}

	*pREG_SPI2_SLVSEL &= ~ENUM_SPI_SLVSEL_SSEL1_HI ;			//	selct_flash;
	flash_byte_access(FLASH_WR_EN);						//	send write enable command
	*pREG_SPI2_SLVSEL |= ENUM_SPI_SLVSEL_SSEL1_HI ;				//	deselct_flash;
	wait_for_flash_status(WEL, 1);					//	check whether WEN bit set properly


	*pREG_SPI2_SLVSEL &= ~ENUM_SPI_SLVSEL_SSEL1_HI ;			//	selct_flash;

	flash_byte_access(FLASH_BLK_ERS_L);					//	send sector erase command (0x64KB)
	flash_byte_access(Erase_ADDR >> 16);					//	send block address
	flash_byte_access(Erase_ADDR >> 8);
	flash_byte_access(Erase_ADDR);

	*pREG_SPI2_SLVSEL |= ENUM_SPI_SLVSEL_SSEL1_HI ;				//	deselct_flash;

	wait_for_flash_status(WIP, 0);
}
/*****************************************************************************************************************************************************************/


void Write_flash_page(unsigned int PAGE_ADDR, unsigned char* flash_page_data_buff, unsigned short page_data_count)
{
	*pREG_SPI2_SLVSEL &= ~ENUM_SPI_SLVSEL_SSEL1_HI ;			//	selct_flash;
	flash_byte_access(FLASH_WR_EN);						//	send write enable command
	*pREG_SPI2_SLVSEL |= ENUM_SPI_SLVSEL_SSEL1_HI ;				//	deselct_flash;
	wait_for_flash_status(WEL, 1);


	*pREG_SPI2_SLVSEL &= ~ENUM_SPI_SLVSEL_SSEL1_HI ;			//	selct_flash;
	flash_byte_access(FLASH_PG_PRM);					//	send page program command
	flash_byte_access(PAGE_ADDR >> 16);
	flash_byte_access(PAGE_ADDR >> 8);
	flash_byte_access(PAGE_ADDR);

	int i;
	for(i=0; i<page_data_count; i++)
		flash_byte_access(*flash_page_data_buff++);

	*pREG_SPI2_SLVSEL |= ENUM_SPI_SLVSEL_SSEL1_HI ;				//	deselct_flash;

	wait_for_flash_status(WIP, 0);
}
/*****************************************************************************************************************************************************************/

