/***************************************************************************
*
*  (C)Copyright Analog Devices Inc., India.
*  All rights reserved. Reproduction in whole or part is prohibited without 
*  the written permission of the copyright owner.
*
*  Project          :  	21569SDK
*  Organization     :  	Jasmin Infotech Private Limited,Chennai
*  File Name        :	Extern.h
*  Description      :   Extern variables & modules for framework & ISR can be included here
******************************************************************************/

#ifndef EXTERN_ASM_H
#define EXTERN_ASM_H

/*****************************************************************************
	Framework Modules
*****************************************************************************/	
//#include "..\src\System\Include\Main.h"

.extern AddPredac_heap_Ext.;
.extern AddPredac_length_Ext.;
.extern AddPredac_lengthhalf_Ext.;
.extern AddPredac_wr_ptr_Ext.;
.extern AddPredac_rd_ptr_Ext.;

.extern Predac_heap_Ext.;
//.extern Predac_length_Ext.;
.extern Predac_lengthhalf_Ext.;
.extern Predac_rd_ptr_Ext.;
.extern Predac_wr_ptr_Ext.;

.extern ControlParams_rd_ptr_Ext.;
.extern ControlParams_wr_ptr_Ext.;
.extern ControlParams_length_Ext.;
.extern ControlParams_heap_Ext.;

#endif  /*	EXTERN_ASM_H  */
