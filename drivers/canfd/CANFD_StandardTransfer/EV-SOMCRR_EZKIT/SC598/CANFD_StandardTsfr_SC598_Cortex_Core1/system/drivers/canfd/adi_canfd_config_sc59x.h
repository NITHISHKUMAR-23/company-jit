/******************************************************************************

Copyright (c) 2020-21 Analog Devices.  All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*******************************************************************************/

/*!
* @file      adi_canfd_config_sc59x.h
*
* @brief     CANFD driver static configuration Header file
*
* @details
*            CANFD driver static configuration Header file
*/


/** @addtogroup CANFD_Driver CANFD Device Driver
 *  @{
 */

/** @addtogroup CANFD_Driver_Static_Configuration CANFD Device Driver Static Configuration
 *  @{
 */


#ifndef _ADI_CANFD_CONFIG_SC59X_H_
#define _ADI_CANFD_CONFIG_SC59X_H_


#ifdef _MISRA_RULES
#pragma diag(push)
#pragma diag(suppress:misra_rule_5_1:"Identifiers shall not rely on the significance of more than 31 characters")
#endif /* _MISRA_RULES */



/*! Number of CANFD instances that are enabled */
#define ADI_CANFD_CFG_INSTANCES          2UL

/*! CANFD Timeout duration used to wait for CAND MB related timeout, value of 0xFFFFFFFFU disables the timeout */
#define ADI_CANFD_MBTIMEOUT     0xFFFFFFFFU

/*********************************************** CANFD0 Instance static configuration ***********************************************/


/*! Defines whether the user intends to use the MDMA for FIFO read access
	0U - MDMA is not used
	1U - MDMA is used
*/
#define ADI_CANFD0_CFG_MDMAUSE                0U

/*! Defines which MDMA stream to use for CANFD FIFO access
	2U - MDMA stream 2 is used
	6U - MDMA stream 6 is used
    Other IDs are not allowed
*/
#define ADI_CANFD0_CFG_MDMASTREAMID           0U


/*! Defines whether the extended range for CAN bit timing divider values is needed
	0U - Normal range of divider value
	1U - Extended range of divider values
*/
#define ADI_CANFD0_CFG_EXTENDEDRANGE         1U


/*! Prescaler Division Factor
    (ADI_CANFD0_CFG_PREDIV + 1) defines the ratio of CAN module clock to the
    CAN protocol clock defining the time quantum of the CAN protocol

    Valid values: 0-255  for Normal range
    Valid values: 0-1023  for Extended range
*/
#define ADI_CANFD0_CFG_PREDIV				 4U


/*! Resync Jump Width - Defines the maximum number of time quanta that a bit
    time can be changed by one re-synchronization.

    Valid values: 0-3  for Normal range
    Valid values: 0-31  for Extended range
*/
#define ADI_CANFD0_CFG_JUMPWIDTH             1U


/*! Phase Segment 1 – Defines the length of Phase Segment 1 in the bit time.

    Valid values: 0-7  for Normal range
    Valid values: 0-31  for Extended range
*/
#define ADI_CANFD0_CFG_PSEG1                 4U


/*! Phase Segment 2 – Defines the length of Phase Segment 2 in the bit time.

    Valid values: 0-7  for Normal range
    Valid values: 0-31  for Extended range
*/
#define ADI_CANFD0_CFG_PSEG2                 3U


/*! Propagation Segment – Defines the length of the Propagation Segment in the bit time.

    Valid values: 0-7  for Normal range
    Valid values: 0-63  for Extended range
*/
#define ADI_CANFD0_CFG_PROPSEG               9U


/*! Enable for FD mode of operation.
    If this macro is set to 1U then ADI_CANFD0_CFG_USERXFIFO
    must be set to 0U other wise there will be configuration
    error
	0U - FD operation is disabled
	1U - FD operation is enabled
*/
#define ADI_CANFD0_CFG_ENABLE_FDMODE         0U


/*! Enable ISO-11898 compliant FD mode of operation.
    This macro has effect only if ADI_CANFD0_CFG_ENABLE_FDMODE
    is 1U

	0U - ISO non-compliant FD mode
	1U - ISO compliant FD mode
*/
#define ADI_CANFD0_CFG_ISOCANFDEN            0U


/*! Prescaler Division Factor
    (ADI_CANFD0_CFG_PREDIV_FD + 1) defines the ratio of CAN module clock to the
    CAN protocol clock defining the time quantum of the CAN protocol during
    data phase of FD packet when bit rate switching is enabled

    Valid values: 0-1023
*/
#define ADI_CANFD0_CFG_PREDIV_FD             9U


/*! Resync Jump Width - Defines the maximum number of time quanta that a bit
    time can be changed by one re-synchronization during data phase of FD
    packet when bit rate switching is enabled

    Valid values: 0-7
*/
#define ADI_CANFD0_CFG_JUMPWIDTH_FD          2U


/*! Phase Segment 1 – Defines the length of Phase Segment 1 in the bit time
    during data phase of FD packet when bit rate switching is enabled

    Valid values: 0-7
*/
#define ADI_CANFD0_CFG_PSEG1_FD              3U


/*! Phase Segment 2 – Defines the length of Phase Segment 2 in the bit time.
    during data phase of FD packet when bit rate switching is enabled

    Valid values: 0-7
*/
#define ADI_CANFD0_CFG_PSEG2_FD              3U


/*! Propagation Segment – Defines the length of the Propagation Segment in
    the bit time during data phase of FD packet when bit rate switching is
    enabled

    Valid values: 0-31
*/
#define ADI_CANFD0_CFG_PROPSEG_FD            10U


/*! Enables the bit rate switching in the FD mode of operation

	0U - Bit rate switching disabled
	1U - Bit rate switching enabled
*/
#define ADI_CANFD0_CFG_ENABLEBRS             0U


/*! Enables Transceiver Delay Compensation Enable

	0U - Delay Compensation disabled
	1U - Delay Compensation Enable
*/
#define ADI_CANFD0_CFG_TRANS_DELAYCOMP_EN    0U


/*! Transceiver Delay Compensation Offset
    This value contains the offset value to be added to the
    measured transceiver’s loop delay in order to define the
    position of the delayed comparison point when bit rate
    switching is active. Its value smaller than the CAN
    bit duration in the data bit rate for proper operation.
    Note: It is not recommended to use ADI_CANFD0_CFG_TRANS_DELAYOFFSET
    equal to zero

    Valid values: 0-31
*/
#define ADI_CANFD0_CFG_TRANS_DELAYOFFSET     0U


/*! Enable Listen only mode
    In Listen-Only Mode mode, transmission is disabled, all error
    counters are frozen and the CANFD module operates in a Error
    Passive mode. Only messages acknowledged by another CAN node
     will be received

	0U - Listen only mode disabled
	1U - Listen only mode Enabled
*/
#define ADI_CANFD0_CFG_LISTENONLY            0U


/*! Edge filter disable
    When the Edge Filter is not disabled, two consecutive nominal time
    quanta with dominant bus state are required to detect an edge that
    causes synchronization. When synchronization occurs, the counting
    of the sequence of eleven consecutive recessive bits is restarted.
    The Edge Filter prevents the dominant pulses that are shorter than
    a nominal bit time (present during the data phase of an FD Frame)
    from being mistaken for an idle condition

	0U - Edge filter mode not disabled
	1U - Edge filter mode disabled
*/
#define ADI_CANFD0_CFG_EDGEFILTERDIS          0U


/*! Message Buffer Data Size for Block 0
    Selects the data size for the Block 0 of message buffers
    allocated in RAM

	0U - Selects 8 bytes per message buffer.
	1U - Selects 16 bytes per message buffer.
	2U - Selects 32 bytes per message buffer.
	3U - Selects 64 bytes per message buffer.
*/
#define ADI_CANFD0_CFG_BLOCK0_MBSIZE         0U


/*! Message Buffer Data Size for Block 1
    Selects the data size for the Block 1 of message buffers
    allocated in RAM

	0U - Selects 8 bytes per message buffer.
	1U - Selects 16 bytes per message buffer.
	2U - Selects 32 bytes per message buffer.
	3U - Selects 64 bytes per message buffer.
*/
#define ADI_CANFD0_CFG_BLOCK1_MBSIZE         0U


/*! Enable use of RX FIFO for message reception
    FIFO mode works only for message reception.
    If this macro is set to 1U then ADI_CANFD0_CFG_ENABLE_FDMODE
    must be set to 0U other wise there will be configuration
    error
	0U - RX FIFO is disabled
	1U - RX FIFO is enabled
*/
#define ADI_CANFD0_CFG_USERXFIFO             0U


/*! Can Wake up from Low power mode by a recessive-to-dominant transition
     on CAN RX line
	0U - Wakeup Diabled
	1U - Wakeup Enabled
*/
#define ADI_CANFD0_CFG_WAKEUP_ENABLE         0U


/*! Controls whether the CANFD is allowed to receive frames
    transmitted by itself. If set to 1 frames transmitted by the
    CANFD are not stored in any MB, regardless of whether the MB is
    programmed with an ID that matches the transmitted frame, and no
    interrupt is generated due to the frame reception

	0U - Self reception Enabled
	1U - Self reception Disabled
*/
#define ADI_CANFD0_CFG_SELFRXDISABLE         1U


/*! Define whether the individual masking is desired or a single
    global mask is preferred

    0U - Individual Rx masks disabled
    1U - Individual Rx masks enabled
*/
#define ADI_CANFD0_CFG_INDMASKENABLE         0U



/*! Global Mask for MBs except MB14 and MB15 */
#define ADI_CANFD0_CFG_GLOBAL_FILTERMASK 0xFFFFFFFFU

/*! Global Mask for MB14 */
#define ADI_CANFD0_CFG_MB14_FILTERMASK   0xFFFFFFFFU

/*! Global Mask for MB15 */
#define ADI_CANFD0_CFG_MB15_FILTERMASK   0xFFFFFFFFU

/*! Global Mask for FIFO filters */
#define ADI_CANFD0_CFG_GLOBALFIFO_FILTERMASK 0xFFFFFFFFU


/*  If individual Masking is  enabled, define Filter Masks for all the MBs */


/** Individual Mask for MB */
#define ADI_CANFD0_CFG_MB00_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB01_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB02_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB03_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB04_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB05_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB06_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB07_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB08_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB09_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB10_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB11_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB12_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB13_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB14_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB15_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB16_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB17_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB18_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB19_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB20_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB21_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB22_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB23_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB24_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB25_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB26_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB27_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB28_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB29_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB30_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB31_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB32_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB33_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB34_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB35_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB36_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB37_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB38_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB39_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB40_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB41_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB42_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB43_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB44_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB45_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB46_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB47_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB48_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB49_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB50_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB51_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB52_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB53_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB54_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB55_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB56_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB57_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB58_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB59_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB60_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB61_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB62_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD0_CFG_MB63_FILTERMASK   0xFFFFFFFFU



/*! Identifies the format of the Rx FIFO ID Filter Table elements

	0U - Format A – One full ID (standard and extended) per ID Filter
         Table element.
	1U - Format B – Two full standard IDs or two partial 14-bit (standard
         and extended) IDs per ID Filter Table element.
	2U - Format C – Four partial 8-bit standard IDs per ID Filter Table
         element.
	3U - Format D – All frames rejected
*/
#define ADI_CANFD0_CFG_IDFILTER_FORMAT       1U


/*! Defines the number of Rx FIFO filters
    ADI_CANFD0_CFG_NUM_FIFOFILTERS must not be programmed with values that make
    the number of message buffers occupied by Rx FIFO and ID Filter exceed
    the number of mailboxes present. Each group of eight filters occupies
    a memory space equivalent to two message buffers, which means that as
    more filters are implemented fewer mailboxes are available.

    Programmable range - 0-15

    Encoding:
    -------------------------------------------------------------
      Value      Number of  FIFO      Message buffers occupied by
                 Filter elements      Rx FIFO and filter table

		0x0            8                     0–7
		0x1            16                    0–9
		0x2            24                    0–11
		0x3            32                    0–13
		0x4            40                    0–15
		0x5            48                    0–17
		0x6            56                    0–19
		0x7            64                    0–21
		0x8            72                    0–23
		0x9            80                    0–25
		0xA            88                    0–27
		0xB            96                    0–29
		0xC            104                   0–31
		0xD            112                   0–33
		0xE            120                   0–35
		0xF            128                   0–37
*/
#define ADI_CANFD0_CFG_NUM_FIFOFILTERS       1U


/*! Timer Sync enables a mechanism that resets the free-running timer
    each time a message is received in message buffer

    0U - Timer Sync disabled
    1U - Timer Sync enabled
*/
#define ADI_CANFD0_CFG_TMRSYNC               1U


/*! Defines the ordering mechanism for Message Buffer transmission

    0U - Buffer with highest priority is transmitted first.
    1U - Lowest number buffer is transmitted first.
*/
#define ADI_CANFD0_CFG_TXORDER               0U


/*! Tx Arbitration Start Delay
    Indicates how many CAN bits the Tx arbitration process start
    point can be delayed from the first bit of CRC field on CAN bus.

    Valid values: 0-31
*/
#define ADI_CANFD0_CFG_TXARB_DELAY           1U


/*! Mailboxes Reception Priority. FIFO vs Message Buffer

    0U - Matching starts from Rx FIFO and continues on mailboxes.
    1U - Matching starts from mailboxes and continues on Rx FIFO.
*/
#define ADI_CANFD0_CFG_RECP_PRIORITY         1U


/*! Remote Request Storing

    0U - Remote Response Frame is generated.
    1U - Remote Request Frame is stored
*/
#define ADI_CANFD0_CFG_REMOTEREQ_STORING     0U






/*********************************************** CANFD1 Instance static configuration ***********************************************/


/*! Defines whether the user intends to use the MDMA for FIFO read access
	0U - MDMA is not used
	1U - MDMA is used
*/
#define ADI_CANFD1_CFG_MDMAUSE                0U

/*! Defines which MDMA stream to use for CANFD FIFO access
	2U - MDMA stream 2 is used
	6U - MDMA stream 6 is used
    Other IDs are not allowed
*/
#define ADI_CANFD1_CFG_MDMASTREAMID           0U


/*! Define whether the extended range for CAN bit timing divider values is needed
	0U - Normal range of divider value
	1U - Extended range of divider values
*/
#define ADI_CANFD1_CFG_EXTENDEDRANGE         1U


/*! Prescaler Division Factor
    (ADI_CANFD1_CFG_PREDIV + 1) defines the ratio of CAN module clock to the
    CAN protocol clock defining the time quantum of the CAN protocol

    Valid values: 0-255  for Normal range
    Valid values: 0-1023  for Extended range
*/
#define ADI_CANFD1_CFG_PREDIV				4U


/*! Resync Jump Width - Defines the maximum number of time quanta that a bit
    time can be changed by one re-synchronization.

    Valid values: 0-3  for Normal range
    Valid values: 0-31  for Extended range
*/
#define ADI_CANFD1_CFG_JUMPWIDTH             1U


/*! Phase Segment 1 – Defines the length of Phase Segment 1 in the bit time.

    Valid values: 0-7  for Normal range
    Valid values: 0-31  for Extended range
*/
#define ADI_CANFD1_CFG_PSEG1                 3U


/*! Phase Segment 2 – Defines the length of Phase Segment 2 in the bit time.

    Valid values: 0-7  for Normal range
    Valid values: 0-31  for Extended range
*/
#define ADI_CANFD1_CFG_PSEG2                 4U


/*! Propagation Segment – Defines the length of the Propagation Segment in the bit time.

    Valid values: 0-7  for Normal range
    Valid values: 0-63  for Extended range
*/
#define ADI_CANFD1_CFG_PROPSEG               9U


/*! Enable for FD mode of operation.
    If this macro is set to 1U then ADI_CANFD1_CFG_USERXFIFO
    must be set to 0U other wise there will be configuration
    error
	0U - FD operation is disabled
	1U - FD operation is enabled
*/
#define ADI_CANFD1_CFG_ENABLE_FDMODE         0U


/*! Enable ISO-11898 compliant FD mode of operation.
    This macro has effect only if ADI_CANFD1_CFG_ENABLE_FDMODE
    is 1U

	0U - ISO non-compliant FD mode
	1U - ISO compliant FD mode
*/
#define ADI_CANFD1_CFG_ISOCANFDEN            0U


/*! Prescaler Division Factor
    (ADI_CANFD1_CFG_PREDIV_FD + 1) defines the ratio of CAN module clock to the
    CAN protocol clock defining the time quantum of the CAN protocol during
    data phase of FD packet when bit rate switching is enabled

    Valid values: 0-1023
*/
#define ADI_CANFD1_CFG_PREDIV_FD             9U


/*! Resync Jump Width - Defines the maximum number of time quanta that a bit
    time can be changed by one re-synchronization during data phase of FD
    packet when bit rate switching is enabled

    Valid values: 0-7
*/
#define ADI_CANFD1_CFG_JUMPWIDTH_FD          2U


/*! Phase Segment 1 – Defines the length of Phase Segment 1 in the bit time
    during data phase of FD packet when bit rate switching is enabled

    Valid values: 0-7
*/
#define ADI_CANFD1_CFG_PSEG1_FD              3U


/*! Phase Segment 2 – Defines the length of Phase Segment 2 in the bit time.
    during data phase of FD packet when bit rate switching is enabled

    Valid values: 0-7
*/
#define ADI_CANFD1_CFG_PSEG2_FD              3U


/*! Propagation Segment – Defines the length of the Propagation Segment in
    the bit time during data phase of FD packet when bit rate switching is
    enabled

    Valid values: 0-31
*/
#define ADI_CANFD1_CFG_PROPSEG_FD            10U


/*! Enables the bit rate switching in the FD mode of operation

	0U - Bit rate switching disabled
	1U - Bit rate switching enabled
*/
#define ADI_CANFD1_CFG_ENABLEBRS             0U


/*! Enables Transceiver Delay Compensation Enable

	0U - Delay Compensation disabled
	1U - Delay Compensation Enable
*/
#define ADI_CANFD1_CFG_TRANS_DELAYCOMP_EN    0U


/*! Transceiver Delay Compensation Offset
    This value contains the offset value to be added to the
    measured transceiver’s loop delay in order to define the
    position of the delayed comparison point when bit rate
    switching is active. Its value smaller than the CAN
    bit duration in the data bit rate for proper operation.
    Note: It is not recommended to use ADI_CANFD1_CFG_TRANS_DELAYOFFSET
    equal to zero

    Valid values: 0-31
*/
#define ADI_CANFD1_CFG_TRANS_DELAYOFFSET     0U


/*! Enable Listen only mode
    In Listen-Only Mode mode, transmission is disabled, all error
    counters are frozen and the CANFD module operates in a Error
    Passive mode. Only messages acknowledged by another CAN node
     will be received

	0U - Listen only mode disabled
	1U - Listen only mode Enabled
*/
#define ADI_CANFD1_CFG_LISTENONLY            0U


/*! Edge filter disable
    When the Edge Filter is not disabled, two consecutive nominal time
    quanta with dominant bus state are required to detect an edge that
    causes synchronization. When synchronization occurs, the counting
    of the sequence of eleven consecutive recessive bits is restarted.
    The Edge Filter prevents the dominant pulses that are shorter than
    a nominal bit time (present during the data phase of an FD Frame)
    from being mistaken for an idle condition

	0U - Edge filter mode not disabled
	1U - Edge filter mode disabled
*/
#define ADI_CANFD1_CFG_EDGEFILTERDIS          0U


/*! Message Buffer Data Size for Block 0
    Selects the data size for the Block 0 of message buffers
    allocated in RAM

	0U - Selects 8 bytes per message buffer.
	1U - Selects 16 bytes per message buffer.
	2U - Selects 32 bytes per message buffer.
	3U - Selects 64 bytes per message buffer.
*/
#define ADI_CANFD1_CFG_BLOCK0_MBSIZE         0U


/*! Message Buffer Data Size for Block 1
    Selects the data size for the Block 1 of message buffers
    allocated in RAM

	0U - Selects 8 bytes per message buffer.
	1U - Selects 16 bytes per message buffer.
	2U - Selects 32 bytes per message buffer.
	3U - Selects 64 bytes per message buffer.
*/
#define ADI_CANFD1_CFG_BLOCK1_MBSIZE         0U


/*! Enable use of RX FIFO for message reception
    FIFO mode works only for message reception.
    If this macro is set to 1U then ADI_CANFD1_CFG_ENABLE_FDMODE
    must be set to 0U other wise there will be configuration
    error
	0U - RX FIFO is disabled
	1U - RX FIFO is enabled
*/
#define ADI_CANFD1_CFG_USERXFIFO             1U

/*! Can Wake up from Low power mode by a recessive-to-dominant transition
     on CAN RX line
	0U - Wakeup Disabled
	1U - Wakeup Enabled
*/
#define ADI_CANFD1_CFG_WAKEUP_ENABLE         0U


/*! Controls whether the CANFD is allowed to receive frames
    transmitted by itself. If set to 1 frames transmitted by the
    CANFD are not stored in any MB, regardless of whether the MB is
    programmed with an ID that matches the transmitted frame, and no
    interrupt is generated due to the frame reception

	0U - Self reception Enabled
	1U - Self reception Disabled
*/
#define ADI_CANFD1_CFG_SELFRXDISABLE         1U


/*! Define whether the individual masking is desired or a single
    global mask is preferred

    0U - Individual Rx masks disabled
    1U - Individual Rx masks enabled
*/
#define ADI_CANFD1_CFG_INDMASKENABLE         0U




/*! Global Mask for MBs except MB14 and MB15 */
#define ADI_CANFD1_CFG_GLOBAL_FILTERMASK 0xFFFFFFFFU

/*! Global Mask for MB14 */
#define ADI_CANFD1_CFG_MB14_FILTERMASK   0xFFFFFFFFU

/*! Global Mask for MB15 */
#define ADI_CANFD1_CFG_MB15_FILTERMASK   0xFFFFFFFFU

/*! Global Mask for FIFO filters */
#define ADI_CANFD1_CFG_GLOBALFIFO_FILTERMASK 0xFFFFFFFFU

/*! Global Mask for FIFO filters */
#define ADI_CANFD1_CFG_GLOBALFIFO_FILTERMASK 0xFFFFFFFFU


/* If individual Masking is  enabled, define Filter Masks for all the MBs */



/* Individual Mask for MB */
#define ADI_CANFD1_CFG_MB00_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB01_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB02_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB03_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB04_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB05_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB06_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB07_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB08_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB09_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB10_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB11_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB12_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB13_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB14_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB15_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB16_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB17_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB18_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB19_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB20_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB21_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB22_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB23_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB24_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB25_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB26_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB27_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB28_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB29_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB30_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB31_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB32_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB33_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB34_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB35_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB36_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB37_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB38_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB39_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB40_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB41_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB42_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB43_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB44_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB45_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB46_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB47_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB48_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB49_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB50_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB51_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB52_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB53_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB54_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB55_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB56_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB57_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB58_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB59_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB60_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB61_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB62_FILTERMASK   0xFFFFFFFFU
#define ADI_CANFD1_CFG_MB63_FILTERMASK   0xFFFFFFFFU



/*! Identifies the format of the Rx FIFO ID Filter Table elements

	0U - Format A – One full ID (standard and extended) per ID Filter
         Table element.
	1U - Format B – Two full standard IDs or two partial 14-bit (standard
         and extended) IDs per ID Filter Table element.
	2U - Format C – Four partial 8-bit standard IDs per ID Filter Table
         element.
	3U - Format D – All frames rejected
*/
#define ADI_CANFD1_CFG_IDFILTER_FORMAT       1U


/*! Defines the number of Rx FIFO filters
    ADI_CANFD1_CFG_NUM_FIFOFILTERS must not be programmed with values that make
    the number of message buffers occupied by Rx FIFO and ID Filter exceed
    the number of mailboxes present. Each group of eight filters occupies
    a memory space equivalent to two message buffers, which means that as
    more filters are implemented fewer mailboxes are available.

    Programmable range - 0-15

    Encoding:
    -------------------------------------------------------------
      Value      Number of  FIFO      Message buffers occupied by
                 Filter elements      Rx FIFO and filter table

		0x0            8                     0–7
		0x1            16                    0–9
		0x2            24                    0–11
		0x3            32                    0–13
		0x4            40                    0–15
		0x5            48                    0–17
		0x6            56                    0–19
		0x7            64                    0–21
		0x8            72                    0–23
		0x9            80                    0–25
		0xA            88                    0–27
		0xB            96                    0–29
		0xC            104                   0–31
		0xD            112                   0–33
		0xE            120                   0–35
		0xF            128                   0–37
*/
#define ADI_CANFD1_CFG_NUM_FIFOFILTERS       3U


/*! Timer Sync enables a mechanism that resets the free-running timer
    each time a message is received in message buffer

    0U - Timer Sync disabled
    1U - Timer Sync enabled
*/
#define ADI_CANFD1_CFG_TMRSYNC               1U


/*! Defines the ordering mechanism for Message Buffer transmission

    0U - Buffer with highest priority is transmitted first.
    1U - Lowest number buffer is transmitted first.
*/
#define ADI_CANFD1_CFG_TXORDER               0U


/*! Tx Arbitration Start Delay
    Indicates how many CAN bits the Tx arbitration process start
    point can be delayed from the first bit of CRC field on CAN bus.

    Valid values: 0-31
*/
#define ADI_CANFD1_CFG_TXARB_DELAY           1U


/*! Mailboxes Reception Priority. FIFO vs Message Buffer

    0U - Matching starts from Rx FIFO and continues on mailboxes.
    1U - Matching starts from mailboxes and continues on Rx FIFO.
*/
#define ADI_CANFD1_CFG_RECP_PRIORITY         1U


/*! Remote Request Storing

    0U - Remote Response Frame is generated.
    1U - Remote Request Frame is stored
*/
#define ADI_CANFD1_CFG_REMOTEREQ_STORING     0U


#ifdef _MISRA_RULES
#pragma diag(pop)
#endif /* _MISRA_RULES */

#endif /* _ADI_CANFD_CONFIG_SC59X_H_ */

/** @}*/
