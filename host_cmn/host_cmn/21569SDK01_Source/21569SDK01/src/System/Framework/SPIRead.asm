/***************************************************************************
*
*  (C)Copyright Analog Devices Inc., India.
*  All rights reserved. Reproduction in whole or part is prohibited without 
*  the written permission of the copyright owner.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	SPIRead.asm
*  Description      :   SPI Communication details

******************************************************************************/
#include <def21569.h>
#include "..\src\system\Include\HostDefines.h"
#include "..\src\system\Include\Adr_Lkup_Tab_Macros.h" 
.IMPORT "..\src\system\Include\Def_Struct.h";


.extern struct kernel Frmwk.;
.extern RXSPI.;
.extern TXSPI.;
.extern Tag_Location32.;

.section/sw  Seg_SPIRead_Code;
.extern ExitSPIReceiveInterrupt;
I_ALABEL_SPI_(ReadHeader)
	r3 = dm(Frmwk.->Spi->DataWrite);
	r3 = pass r3;
	if eq jump Cont_WriteLoop;
	
	I_AJUMP(WriteDataLoop);
	
Cont_WriteLoop:
	r3 = dm(RXSPI.);			
	
	b3 = dm(Frmwk.->Spi->SPIReceiveTempBuf);
	i3 = dm(Frmwk.->Spi->SPIReceiveTempBufPtr);				// store all bytes for debugging
	l3 = dm(Frmwk.->Spi->SPIReceivebufsize);  
	dm(i3,1) = r3;		     
	dm(Frmwk.->Spi->SPIReceiveTempBufPtr) = i3; 				
	
	b3 = TAGCOUNTADDR;
	l3 = 3;
	i3 = dm(Frmwk.->Spi->header_address);
	dm(i3,m6) = r3;
	dm(Frmwk.->Spi->header_address) = i3;
	
	r3 = dm(Frmwk.->Spi->header_count);
	r3 = r3-1;
	dm(Frmwk.->Spi->header_count) = r3;
	if ne jump ExitSPIReceiveInterrupt;
	
    r3 = dm(Frmwk.->Spi->DirectRead_flag);
	r3 = pass r3;
	if eq jump WriteLoopRoutine;
	
	I_AJUMP(ReadDataLoop);
	
WriteLoopRoutine:	
	
	I_ACALL(TAGBASEDLOOP);	
	
	jump ExitSPIReceiveInterrupt;
	
ReadHeader.END:	

I_ALABEL_SPI_(ReadDataLoop)	

	I_AJUMP(TAGBASEDLOOPREAD);	
	
ReadDataLoop.END:	

I_ALABEL_SPI_(WriteDataLoop)				

	r1 = 0x4;
	comp(r1,r3);
	if eq jump WriteDataLoop32;
	
	r1 = 0x5;
	comp(r1,r3);
	if eq jump WriteDataLoop48;

	r1 = 0x6;
	comp(r1,r3);
	if eq jump WriteDataLoop64;
	
	r1 = 0x3;
	comp(r1,r3);
	if eq jump WriteDataLoop16;
	
	jump ItIsError;
	
WriteDataLoop32:

	r3 = dm(RXSPI.);	
	
	l3 = 0;
	i3 = dm(Frmwk.->Spi->destination_address);
	dm(i3,m6) = r3;
	dm(Frmwk.->Spi->destination_address) = i3;
	
	r3 = dm(Frmwk.->Spi->destination_count);
	r3 = r3-1;
	dm(Frmwk.->Spi->destination_count) = r3;	
	
	if ne jump ExitSPIReceiveInterrupt;
	
	r3 = 0x1C;
	dm(Frmwk.->Spi->COMMAND_BYTE) = r3;
	
	dm(Frmwk.->Spi->download_status) = m6;	
	
	dm(Frmwk.->Spi->download_flag) = m5;	
	
	dm(Frmwk.->Spi->DataWrite) = m5;
	
	dm(Frmwk.->Spi->DirectWrite_flag) = m5;
	
	dm(Frmwk.->Spi->special_cmd_result) = m5;
	
	r0 = 3;
	dm(Frmwk.->Spi->header_count) = r0;
	r0 = TAGCOUNTADDR;
	dm(Frmwk.->Spi->header_address) = r0;
	
	jump ExitSPIReceiveInterrupt;	
	
WriteDataLoop16:

	r3 = dm(RXSPI.);	

	dm(TAGLOCATION32) = r3;
	
	l3 = 0;
	i3 = dm(Frmwk.->Spi->destination_address);
	
	r3 = dm(Frmwk.->Spi->destination_count);
	r1 = 2;
	r3 = r3-r1;
	dm(Frmwk.->Spi->destination_count) = r3;
	
	if lt jump WriteDataLoop16_1;
		
	r3 = dm(TAGLOCATION16);
	dm(i3,m6) = r3;
	r3 = dm(TAGLOCATION16+1);
	dm(i3,m6) = r3;
	dm(Frmwk.->Spi->destination_address) = i3;
	
	r3 = dm(Frmwk.->Spi->destination_count);
	r3 = pass r3;
	if ne jump ExitSPIReceiveInterrupt;
	
	r3 = 0x1C;
	dm(Frmwk.->Spi->COMMAND_BYTE) = r3;
	
	dm(Frmwk.->Spi->download_status) = m6;	
	
	dm(Frmwk.->Spi->download_flag) = m5;	
	
	dm(Frmwk.->Spi->DataWrite) = m5;
	
	dm(Frmwk.->Spi->DirectWrite_flag) = m5;
	
	dm(Frmwk.->Spi->special_cmd_result) = m5;
	
	r0 = 3;
	dm(Frmwk.->Spi->header_count) = r0;
	r0 = TAGCOUNTADDR; 
	dm(Frmwk.->Spi->header_address) = r0;
	
	jump ExitSPIReceiveInterrupt;
	
WriteDataLoop16_1:
	
	r3 = dm(TAGLOCATION16);
	dm(i3,m6) = r3;
	
	r3 = 0x1C;
	dm(Frmwk.->Spi->COMMAND_BYTE) = r3;
	
	dm(Frmwk.->Spi->download_status) = m6;	
	
	dm(Frmwk.->Spi->download_flag) = m5;		
	
	dm(Frmwk.->Spi->DataWrite) = m5;
	
	dm(Frmwk.->Spi->DirectWrite_flag) = m5;
	
	dm(Frmwk.->Spi->special_cmd_result) = m5;
	
	r0 = 3;
	dm(Frmwk.->Spi->header_count) = r0;
	r0 = TAGCOUNTADDR;
	dm(Frmwk.->Spi->header_address) = r0;
	
	jump ExitSPIReceiveInterrupt;
					
WriteDataLoop48:

	r3 = dm(RXSPI.);	

	l3 = 0;
	i3 = dm(Frmwk.->Spi->temp_write_address);
	dm(i3,m6) = r3;
	dm(Frmwk.->Spi->temp_write_address) = i3;
	
	r3 = dm(Frmwk.->Spi->temp_write_count);
	r3 = r3-1;
	dm(Frmwk.->Spi->temp_write_count) = r3;
	
	if ne jump ExitSPIReceiveInterrupt;
	
	r3 = 3;
	dm(Frmwk.->Spi->temp_write_count) = r3;
	r3 = TAGLOCATION32;
	dm(Frmwk.->Spi->temp_write_address) = r3;
	
	i3 = dm(Frmwk.->Spi->destination_address);
	
	r3 = dm(Frmwk.->Spi->destination_count);
	r1 = 2;
	r3 = r3-r1;
	dm(Frmwk.->Spi->destination_count) = r3;
	
	if lt jump WriteDataLoop48_1;
		
	PX = dm(TAGLOCATION48);
	dm(i3,m6) = PX;
	PX = dm(TAGLOCATION48+1);
	dm(i3,m6) = PX;
	dm(Frmwk.->Spi->destination_address) = i3;
	
	r3 = dm(Frmwk.->Spi->destination_count);
	r3 = pass r3;
	if ne jump ExitSPIReceiveInterrupt;
	
	r3 = 0x1C;
	dm(Frmwk.->Spi->COMMAND_BYTE) = r3;
	
	dm(Frmwk.->Spi->download_status) = m6;	
	
	dm(Frmwk.->Spi->download_flag) = m5;		
	
	dm(Frmwk.->Spi->DataWrite) = m5;
	
	dm(Frmwk.->Spi->DirectWrite_flag) = m5;
	
	dm(Frmwk.->Spi->special_cmd_result) = m5;
	
	r0 = 3;
	dm(Frmwk.->Spi->header_count) = r0;
	r0 = TAGCOUNTADDR;
	dm(Frmwk.->Spi->header_address) = r0;
	
	jump ExitSPIReceiveInterrupt;
	
WriteDataLoop48_1:
	
	PX = dm(TAGLOCATION48);
	dm(i3,m6) = PX;
	
	r3 = 0x1C;
	dm(Frmwk.->Spi->COMMAND_BYTE) = r3;
	
	dm(Frmwk.->Spi->download_status) = m6;	
	
	dm(Frmwk.->Spi->download_flag) = m5;		
	
	dm(Frmwk.->Spi->DataWrite) = m5;
	
	dm(Frmwk.->Spi->DirectWrite_flag) = m5;
	
	dm(Frmwk.->Spi->special_cmd_result) = m5;
	
	r0 = 3;
	dm(Frmwk.->Spi->header_count) = r0;
	r0 = TAGCOUNTADDR;
	dm(Frmwk.->Spi->header_address) = r0;
	
	jump ExitSPIReceiveInterrupt;
	
WriteDataLoop64:

	r3 = dm(RXSPI.);	

	l3 = 0;
	i3 = dm(Frmwk.->Spi->temp_write_address);
	dm(i3,m6) = r3;
	dm(Frmwk.->Spi->temp_write_address) = i3;
	
	r3 = dm(Frmwk.->Spi->temp_write_count);
	r3 = r3-1;
	dm(Frmwk.->Spi->temp_write_count) = r3;
	
	if ne jump ExitSPIReceiveInterrupt;
	
	r3 = 2;
	dm(Frmwk.->Spi->temp_write_count) = r3;
	r3 = TAGLOCATION32;
	dm(Frmwk.->Spi->temp_write_address) = r3;
	
	i3 = dm(Frmwk.->Spi->destination_address);
	
	PX1 = dm(TAGLOCATION32);
	PX2 = dm(TAGLOCATION32+1);
	dm(i3,m6) = PX (lw);
	dm(Frmwk.->Spi->destination_address) = i3;
	
	r3 = dm(Frmwk.->Spi->destination_count);
	r3 = r3-1;
	dm(Frmwk.->Spi->destination_count) = r3;
	
	if ne jump ExitSPIReceiveInterrupt;
	
	r3 = 0x1C;
	dm(Frmwk.->Spi->COMMAND_BYTE) = r3;
	
	dm(Frmwk.->Spi->download_status) = m6;	
	
	dm(Frmwk.->Spi->download_flag) = m5;		
	
	dm(Frmwk.->Spi->DataWrite) = m5;
	
	dm(Frmwk.->Spi->DirectWrite_flag) = m5;
	
	dm(Frmwk.->Spi->special_cmd_result) = m5;
	
	r0 = 3;
	dm(Frmwk.->Spi->header_count) = r0;
	r0 = TAGCOUNTADDR;
	dm(Frmwk.->Spi->header_address) = r0;
	
	jump ExitSPIReceiveInterrupt;
	
WriteDataLoop.END:	

I_ALABEL_SPI_(TAGBASEDLOOP)
	r3 = dm(TAGLOCATION32);
	
	r1 = 0x4;
	comp(r1,r3);
	if eq jump ItIs32or16;
	
	r1 = 0x5;
	comp(r1,r3);
	if eq jump ItIs48;
	
	r1 = 0x1;
	comp(r1,r3);
	if eq jump ItIsInit;
	
	r1 = 0x2;
	comp(r1,r3);
	if eq jump ItIsInit48;
	
	r1 = 0x6;
	comp(r1,r3);
	if eq jump ItIs64;
	
	r1 = 0x3;
	comp(r1,r3);
	if eq jump ItIs32or16;
	
	r1 = 0x0;
	comp(r1,r3);
	if ne jump ItIsError;
	
	dm(Frmwk.->Spi->download_flag) = m5;
	
	r3 = 0x1C;
	dm(Frmwk.->Spi->COMMAND_BYTE) = r3;
	
	dm(Frmwk.->Spi->special_cmd_result) = m5;
	
	rts;
	
TAGBASEDLOOP.END:	

ItIs32or16:

	dm(Frmwk.->Spi->DataWrite) = r3;
	r3 = dm(ADDRLOCATION32);
	dm(Frmwk.->Spi->destination_address) = r3;
	r3 = dm(COUNTLOCATION32);
	dm(Frmwk.->Spi->destination_count) = r3;
	
	rts;
	
ItIs48:

	dm(Frmwk.->Spi->DataWrite) = r3;
	r3 = dm(ADDRLOCATION32);
	dm(Frmwk.->Spi->destination_address) = r3;
	
	r3 = dm(COUNTLOCATION32);
	dm(Frmwk.->Spi->destination_count) = r3;
	
	r3 = TAGLOCATION32;
	dm(Frmwk.->Spi->temp_write_address) = r3;
	r3 = 3;
	dm(Frmwk.->Spi->temp_write_count) = r3;
	
	rts;
	
ItIs64:

	dm(Frmwk.->Spi->DataWrite) = r3;
	r3 = dm(ADDRLOCATION32);
	dm(Frmwk.->Spi->destination_address) = r3;
	r3 = dm(COUNTLOCATION32);
	dm(Frmwk.->Spi->destination_count) = r3;
	
	r3 = TAGLOCATION32;
	dm(Frmwk.->Spi->temp_write_address) = r3;
	r3 = 2;
	dm(Frmwk.->Spi->temp_write_count) = r3;
	
	rts;
	
ItIsInit:

	l3 = 0;
	i3 = dm(ADDRLOCATION32);
	r3 = dm(COUNTLOCATION32);
	
	r3 = pass r3;
	if le jump NoRepeatZeroInit;
	
	r1 = 0;
RepeatZeroInit:	
	dm(i3,m6) = r1;
	r3 = r3-1;
	if ne jump RepeatZeroInit;		

NoRepeatZeroInit:	
			
	r3 = 0x1C;
	dm(Frmwk.->Spi->COMMAND_BYTE) = r3;
	
	dm(Frmwk.->Spi->download_status) = m6;	
	
	dm(Frmwk.->Spi->download_flag) = m5;		

	dm(Frmwk.->Spi->DataWrite) = m5;
	
	dm(Frmwk.->Spi->DirectWrite_flag) = m5;	
	
	dm(Frmwk.->Spi->special_cmd_result) = m5;
	
	r0 = 3;
	dm(Frmwk.->Spi->header_count) = r0;
	r0 = TAGCOUNTADDR;
	dm(Frmwk.->Spi->header_address) = r0;
		
	rts;

ItIsInit48:

	l3 = 0;
	i3 = dm(ADDRLOCATION32);
	r3 = dm(COUNTLOCATION32);
	
	r3 = pass r3;
	if le jump NoRepeatZeroInit48;
	
	PX = 0;
RepeatZeroInit48:	
	dm(i3,m6) = PX;
	r3 = r3-1;
	if ne jump RepeatZeroInit48;		
	
NoRepeatZeroInit48:	
	
	r3 = 0x1C;
	dm(Frmwk.->Spi->COMMAND_BYTE) = r3;
	
	dm(Frmwk.->Spi->DataWrite) = m5;
	
	dm(Frmwk.->Spi->DirectWrite_flag) = m5;	
	
	dm(Frmwk.->Spi->download_status) = m6;	
	
	dm(Frmwk.->Spi->download_flag) = m5;		
	
	dm(Frmwk.->Spi->special_cmd_result) = m5;
	
	r0 = 3;
	dm(Frmwk.->Spi->header_count) = r0;
	r0 = TAGCOUNTADDR;
	dm(Frmwk.->Spi->header_address) = r0;
	
	rts;

ItIsError:

	dm(Frmwk.->Spi->download_flag) = m5;
	
	r3 = 0x1C;
	dm(Frmwk.->Spi->COMMAND_BYTE) = r3;
	
	dm(Frmwk.->Spi->DataWrite) = m5;
	dm(Frmwk.->Spi->DirectWrite_flag) = m5;
	
	dm(Frmwk.->Spi->DirectRead_flag) = m5;
	dm(Frmwk.->Spi->DataRead) = m5;
	
	dm(Frmwk.->Spi->special_cmd_result) = m6;		
	
	rts;
	ItIsErrorRead:

	dm(Frmwk.->Spi->download_flag) = m5;
	
	r3 = 0x1C;
	dm(Frmwk.->Spi->COMMAND_BYTE) = r3;
	
	dm(Frmwk.->Spi->DataWrite) = m5;
	dm(Frmwk.->Spi->DirectWrite_flag) = m5;
	dm(Frmwk.->Spi->DirectRead_flag) = m5;
	dm(Frmwk.->Spi->DataRead) = m5;
	
	dm(Frmwk.->Spi->special_cmd_result) = m6;		
	
	jump ExitSPIReceiveInterrupt;	
	
I_ALABEL_SPI_(TAGBASEDLOOPREAD)

	dm(Frmwk.->Spi->temp_write_count) = m5;

	r3 = dm(TAGLOCATION32);
	
	r1 = 0x4;
	comp(r1,r3);
	if eq jump ItIs32r;
	
	r1 = 0x5;
	comp(r1,r3);
	if eq jump ItIs48r;
	
	r1 = 0x6;
	comp(r1,r3);
	if eq jump ItIs64r;
	
	r1 = 0x3;
	comp(r1,r3);
	if eq jump ItIs16r;
	
	jump ItIsErrorRead;
	
ItIs32r:

	dm(Frmwk.->Spi->DataRead) = r3;
	r3 = dm(ADDRLOCATION32);
	dm(Frmwk.->Spi->destination_address) = r3;
	r3 = dm(COUNTLOCATION32);
	dm(Frmwk.->Spi->destination_count) = r3;
	
NextItr32:	
	
	l3 = 0;
	i3 = dm(Frmwk.->Spi->destination_address);
	r0 = dm(i3,m6);
	dm(TXSPI.)=r0;
	dm(Frmwk.->Spi->destination_address) = i3;
	
	r3 = dm(Frmwk.->Spi->destination_count);
	r3 = r3-1;
	dm(Frmwk.->Spi->destination_count) = r3;		
	
	jump ExitSPIReceiveInterrupt;
	
ItIs16r:

	dm(Frmwk.->Spi->DataRead) = r3;
	r3 = dm(ADDRLOCATION32);
	dm(Frmwk.->Spi->destination_address) = r3;
	r3 = dm(COUNTLOCATION32);
	dm(Frmwk.->Spi->destination_count) = r3;
	
NextItr16:	

	r3 = dm(Frmwk.->Spi->destination_count);
	
	r0 = 0x1;
	comp(r0,r3);
	if eq jump OnlyOne16r;
	
	l3 = 0;
	i3 = dm(Frmwk.->Spi->destination_address);
	r0 = dm(i3,m6);					// First 16 bit value
	r1 = dm(i3,m6);					// Second 16 bit value
	r0 = r0 or lshift r1 by 16;
	dm(TXSPI.)=r0;
	dm(Frmwk.->Spi->destination_address) = i3;
	
	r3 = dm(Frmwk.->Spi->destination_count);
	r1 = 2;
	r3 = r3-r1;
	dm(Frmwk.->Spi->destination_count) = r3;		
	
	jump ExitSPIReceiveInterrupt;
	
OnlyOne16r:	

	l3 = 0;
	i3 = dm(Frmwk.->Spi->destination_address);
	r0 = dm(i3,m6);					// First 16 bit value
	dm(TXSPI.)=r0;
	
	dm(Frmwk.->Spi->destination_count) = m5;
	
	jump ExitSPIReceiveInterrupt;
	
ItIs48r:

	dm(Frmwk.->Spi->DataRead) = r3;
	r3 = dm(ADDRLOCATION32);
	dm(Frmwk.->Spi->destination_address) = r3;
	r3 = dm(COUNTLOCATION32);
	dm(Frmwk.->Spi->destination_count) = r3;
	
NextItr48:	

	r3 = dm(Frmwk.->Spi->destination_count);
	
	r0 = 0x1;
	comp(r0,r3);
	if eq jump OnlyOne48r;
	
	l3 = 0;
	i3 = dm(Frmwk.->Spi->destination_address);
	PX = dm(i3,m6);					// First 16 bit value
	r0 = PX2;
	r1 = PX1;
	PX = dm(i3,m6);
	r2 = PX2;
	r3 = PX1;
	
	r4 = lshift r1 by -16;
	r4 = r4 or lshift r0 by 16;	// FIRST DATA
	dm(TXSPI.) = r4;

	r4 = lshift r0 by -16;
	r4 = r4 or r3;
	dm(TAGLOCATION32) = r4; // SECOND DATA
	dm(COUNTLOCATION32) = r2; // THIRD DATA
	
	dm(Frmwk.->Spi->destination_address) = i3;

	r3 = 3;
	dm(Frmwk.->Spi->temp_write_count) = r3;
	r3 = TAGCOUNTADDR;
	dm(Frmwk.->Spi->temp_write_address) = r3;
	

	
	r3 = dm(Frmwk.->Spi->temp_write_count);
	r3 = r3-1;
	dm(Frmwk.->Spi->temp_write_count) = r3;
	
	r3 = dm(Frmwk.->Spi->destination_count);
	r1 = 2;
	r3 = r3-r1;
	dm(Frmwk.->Spi->destination_count) = r3;		
	
	jump ExitSPIReceiveInterrupt;
	
OnlyOne48r:	

	l3 = 0;
	i3 = dm(Frmwk.->Spi->destination_address);
	PX = dm(i3,m6);					// First 16 bit value
	r0 = PX2;
	r1 = PX1;
	PX = dm(i3,m6);
	r2 = PX2;
	r3 = PX1;
	
	r4 = lshift r1 by -16;
	r4 = r4 or lshift r0 by 16;	// FIRST DATA	
	dm(TXSPI.) = r4;

	r4 = lshift r0 by -16;
	dm(TAGLOCATION32) = r4; // SECOND DATA
	dm(COUNTLOCATION32) = m5; // THIRD DATA
	
	r3 = 3;
	dm(Frmwk.->Spi->temp_write_count) = r3;
	r3 = TAGCOUNTADDR;
	dm(Frmwk.->Spi->temp_write_address) = r3;
	
	r3 = dm(Frmwk.->Spi->temp_write_count);
	r3 = r3-1;
	dm(Frmwk.->Spi->temp_write_count) = r3;

	r3 = dm(Frmwk.->Spi->destination_count);
	r3 = r3-1;
	dm(Frmwk.->Spi->destination_count) = r3;	
	
	jump ExitSPIReceiveInterrupt;
	
ItIs64r:

	dm(Frmwk.->Spi->DataRead) = r3;
	r3 = dm(ADDRLOCATION32);
	dm(Frmwk.->Spi->destination_address) = r3;
	r3 = dm(COUNTLOCATION32);
	dm(Frmwk.->Spi->destination_count) = r3;
	
NextItr64:	
	
	l3 = 0;
	i3 = dm(Frmwk.->Spi->destination_address);
	PX = dm(i3,m6) (lw);
	r0 = PX1;
	r1 = PX2;
	dm(Frmwk.->Spi->destination_address) = i3;
	
	dm(TXSPI.) = r0;
	dm(TAGLOCATION32) = r1;

	r3 = 2;
	dm(Frmwk.->Spi->temp_write_count) = r3;
	r3 = TAGCOUNTADDR;
	dm(Frmwk.->Spi->temp_write_address) = r3;
	
	r3 = dm(Frmwk.->Spi->temp_write_count);
	r3 = r3-1;
	dm(Frmwk.->Spi->temp_write_count) = r3;
	
	r1 = dm(Frmwk.->Spi->destination_count);
	r1 = r1-1;
	dm(Frmwk.->Spi->destination_count) = r1;
	
	jump ExitSPIReceiveInterrupt;
	
TAGBASEDLOOPREAD.END:	

.global serialflashAddrRoutine;	
serialflashAddrRoutine:

	r3 = dm(RXSPI.);
	nop;	
	dm(Frmwk.->Spi->loader_address) = r3;
	
	dm(Frmwk.->Spi->serialflash_flag) = m5;
	
	dm(Frmwk.->Spi->serialflash_cmd_flag) = m6;
	
	jump ExitSPIReceiveInterrupt;
	
serialflashAddrRoutine.END:	

I_ALABEL_SPI_(DirectReadRoutine)
	r3 = dm(RXSPI.);nop;

	l3 = 0;

	r3 = dm(Frmwk.->Spi->temp_write_count);
	r3 = pass r3;
	if eq jump check_dest_count;
	
	i3 = dm(Frmwk.->Spi->temp_write_address);
	r0 = dm(i3,m6);
	dm(TXSPI.) = r0;	
	
	dm(Frmwk.->Spi->temp_write_address) = i3;
	
	r3 = dm(Frmwk.->Spi->temp_write_count);
	r3 = r3-1;
	dm(Frmwk.->Spi->temp_write_count) = r3;
	
	jump ExitSPIReceiveInterrupt;
	
check_dest_count:

	r3 = dm(Frmwk.->Spi->destination_count);
	r3 = pass r3;
	if ne jump check_tag_info;
	
	dm(Frmwk.->Spi->DirectRead_flag) = m5;
	dm(Frmwk.->Spi->DataRead) = m5;
	
	r3 = 0x1E;
	dm(Frmwk.->Spi->COMMAND_BYTE) = r3;
	
	dm(Frmwk.->Spi->special_cmd_result) = m5;
	
	jump ExitSPIReceiveInterrupt;
	
check_tag_info:		
	
	r3 = dm(Frmwk.->Spi->DataRead);
			
	r1 = 0x4;
	comp(r1,r3);
	if eq jump NextItr32;
	
	r1 = 0x5;
	comp(r1,r3);
	if eq jump NextItr48;
	
	r1 = 0x6;
	comp(r1,r3);
	if eq jump NextItr64;
	
	r1 = 0x3;
	comp(r1,r3);
	if eq jump NextItr16;
	
	jump ItIsErrorRead;
	
	jump ExitSPIReceiveInterrupt;
	
DirectReadRoutine.END:
.endseg;


