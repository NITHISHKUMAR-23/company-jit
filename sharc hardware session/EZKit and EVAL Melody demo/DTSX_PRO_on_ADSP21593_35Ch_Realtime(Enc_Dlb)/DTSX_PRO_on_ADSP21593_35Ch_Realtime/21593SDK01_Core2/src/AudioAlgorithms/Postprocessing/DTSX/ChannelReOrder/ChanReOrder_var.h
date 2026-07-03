/***************************************************************************
*
*  Copyright (c) 2023-2024 Analog Devices, Inc. All Rights Reserved.
*  This software is proprietary to Analog Devices, Inc. and its licensors.
*
*  Project          :  	DTSX_PRO_on_ADSP21593_35Ch
*  Organization     :   Jasmin Infotech Private Limited,Chennai
*  File Name        :	ChanReOrder_var.h
*  Description      :   All the global variables for ChanReOrder library can be included here
*
******************************************************************************/
#include "..\..\..\..\System\Include\Commn.h"

#ifdef DTSX_CHANREORDER
#define SAMPLEBLOCK		256
.segment/dm seg_dtsx_Ch_Reorder_data_dm;

.var ChanReorder_inputConfig_LIB;
.var ChanReorder_InBufHeap_LIB;
.var ChanReorder_InBufPtr_LIB;
.var ChanReorder_InBufLen_LIB;
.var ChanReorder_OutBufHeap_LIB;
.var ChanReorder_OutBufPtr_LIB;
.var ChanReorder_OutBufLen_LIB;
.var SingleChannel;
.var HC_channel_only;
.var Top_channel_only;
.var ChannelReorder_DTSX_LIB;
.var Lsrs_swap_flag;
.var ChanReorder_InBufHeap_LIB_Ptr;
.var ChannelReorder_ASLReroute_LIB;
.var DTSX_Ch_Reorder_Count;
.var DTSX_Lh_Rh_flag;

.var LR_Chan_Ptr;
.var C_Chan_Ptr;
.var LFE_Chan_Ptr;
.var LsRs_Chan_Ptr;
.var LrsRrs_Chan_Ptr;
.var Cs_Chan_Ptr;
.var LwRw_Chan_Ptr;
.var LfhRfh_Chan_Ptr;
.var LtfRtf_Chan_Ptr;
.var LhsRhs_Chan_Ptr;
.var LtrRtr_Chan_Ptr;
.var LrhRrh_Chan_Ptr;
.var SurrHt_Chan_Ptr;
.var HC_T_Chan_Ptr;
.var LssRss_Chan_Ptr;
.var LcRc_Chan_Ptr;
.var Ch_Chan_Ptr;
.var Oh_Chan_Ptr;
.var CHr_Chan_Ptr;
.var Clf_Chan_Ptr;
.var LlfRlf_Chan_Ptr;
.var LFE2_Chan_Ptr;
.var Lfh_Chan_Ptr;
.var Rfh_Chan_Ptr;

.global ChanReorder_inputConfig_LIB;
.global ChanReorder_InBufHeap_LIB;
.global ChanReorder_InBufPtr_LIB;
.global ChanReorder_InBufLen_LIB;
.global ChanReorder_OutBufHeap_LIB;
.global ChanReorder_OutBufPtr_LIB;
.global ChanReorder_OutBufLen_LIB;
.global SingleChannel;
.global HC_channel_only;
.global Top_channel_only;
.global ChannelReorder_DTSX_LIB;
.global Lsrs_swap_flag;
.global ChanReorder_InBufHeap_LIB_Ptr;
.global ChannelReorder_ASLReroute_LIB;
.global DTSX_Ch_Reorder_Count;
.global DTSX_Lh_Rh_flag;


.global LR_Chan_Ptr;
.global C_Chan_Ptr;
.global LFE_Chan_Ptr;
.global LsRs_Chan_Ptr;
.global LrsRrs_Chan_Ptr;
.global Cs_Chan_Ptr;
.global LwRw_Chan_Ptr;
.global LfhRfh_Chan_Ptr;
.global LtfRtf_Chan_Ptr;
.global LhsRhs_Chan_Ptr;
.global LtrRtr_Chan_Ptr;
.global LrhRrh_Chan_Ptr;
.global SurrHt_Chan_Ptr;
.global HC_T_Chan_Ptr;
.global LssRss_Chan_Ptr;
.global LcRc_Chan_Ptr;
.global Ch_Chan_Ptr;
.global Oh_Chan_Ptr;
.global CHr_Chan_Ptr;
.global Clf_Chan_Ptr;
.global LlfRlf_Chan_Ptr;
.global LFE2_Chan_Ptr;
.global Lfh_Chan_Ptr;
.global Rfh_Chan_Ptr;
.endseg;

#endif //DTSX_CHANREORDER
