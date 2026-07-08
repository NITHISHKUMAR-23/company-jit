#include "ProcInclude.h"
#include "SPI0_macros.h"

#define 	BUFF_SIZE1	100


typedef struct
{
	unsigned int CFG;
	unsigned int XCNT;
	unsigned int XMOD;
}DMA_Regs;

extern unsigned int 	SPI0_Rx_BUFFER[];
extern unsigned int 	SPI0_Tx_BUFFER[];

