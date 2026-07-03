/***********************************************************************
 * Copyright(c) 2006 Analog Devices, Inc. All Rights Reserved.
 *
 * This software is proprietary and confidential.  By using this software
 * you agree to the terms of the associated Analog Devices License Agreement.
 *
 * Description:
 * Provides definitions for host and device for use with the hostapp.
 *
 ***********************************************************************/
#ifndef _HOSTAPP_H_
#define _HOSTAPP_H_

#if defined(__ADSP21000__)
 #ifndef _USBCMD_H_
 #define _USBCMD_H_
      // warning "usbcmd.h has been depreciated, use hostapp.h"
       #include "../../host/hostapp/hostapp.h"
 #endif // _USBCMD_H_
#endif


/*********************************************************************
 * defines for host and device
 *********************************************************************/

enum _USB_COMMAND
{
    NO_COMMAND,             /* nothing doing here... */
    GET_FW_VERSION,         /* get the firmware version */
    QUERY_SUPPORT,          /* query for support */
    QUERY_REPLY,            /* query reply */

    LOOPBACK,               /* run loopback on the device */

    MEMORY_READ,            /* read from specified memory on the device */
    MEMORY_WRITE,           /* write to specified memory on the device */

    USBIO_START,            /* run USB IO on this device */
    USBIO_STOP,             /* stop USB IO on this device */
    USBIO_OPEN,             /* open file on host */
    USBIO_CLOSE,            /* close file on host */
    USBIO_READ,             /* read file on host */
    USBIO_READ_REPLY,       /* read reply from host */
    USBIO_WRITE,            /* write file on host */
    USBIO_WRITE_REPLY,      /* write reply from host */
    USBIO_SEEK_CUR,         /* seek from current position of file on host */
    USBIO_SEEK_END,         /* seek from end of file on host */
    USBIO_SEEK_SET,         /* seek from beginning of file on host */
    USBIO_SEEK_REPLY,       /* seek reply from host */
    USBIO_FILEPTR,          /* sending file pointer */

    CUSTOM_COMMAND          /* custom command */
};


enum _VERSION_STRINGS       /* version string info */
{
    FW_BUILD_DATE,          /* build date of firmware */
    FW_BUILD_TIME,          /* build time of firmware */
    FW_VERSION_NUMBER,      /* version number of firmware */
    FW_TARGET_PROC,         /* target processor of firmware */
    FW_APPLICATION_NAME,    /* application name of firmware */

    NUM_VERSION_STRINGS     /* number of version strings */
};

typedef struct _USBCB       /* USB command block */
{
#if defined(__ADSP21000__)          /*  SHARC */
  unsigned long u32_Command;    /* command to execute */
  unsigned long u32_Data;       /* generic data field */
  unsigned long u32_Count;      /* number of bytes to transfer */
#ifdef DUMMY_READ
  unsigned long u32_Rem;        /* number of bytes remaining to read */
#endif
#elif defined (__ADSPBLACKFIN__)
                        /* HOSTAPP uses int's */
  unsigned int u32_Command;     /* command to execute */
  unsigned int u32_Data;        /* generic data field */
  unsigned int u32_Count;       /* number of bytes to transfer */
#endif
} USBCB, *PUSBCB;

#define MAX_VERSION_STRING_LEN      32
#define VERSION_STRING_BLOCK_SIZE   (NUM_VERSION_STRINGS*MAX_VERSION_STRING_LEN)

#define LOOPBACK_HEADER_BYTES       4                       /* bytes in header of loopback data */

#if defined(__ADSP21569__) || defined(__ADSP21593__)
//        #define MAX_DATA_BYTES_BULKADI  (0x10000)                    /* max bytes to send for Sharc */
#define MAX_DATA_BYTES_BULKADI  ( 0x3FFF * sizeof(int) )     /* max bytes to send for Sharc */
#elif defined(__ADSP21000__)
        #define MAX_DATA_BYTES_BULKADI  ( 0x40 * sizeof(int) )     /* max bytes to send for Sharc */
#elif defined (__ADSPBLACKFIN__)
        #define MAX_DATA_BYTES_BULKADI  (0x10000)                       /* max bytes to send for Blackfin */
#else
        #warning "Processor family not specified for build"
#endif

#define MIN_DATA_BYTES_BULKADI  LOOPBACK_HEADER_BYTES       /* min bytes to send */

#define FILE_OPEN_MODE_OFFSET       0                       /* byte offset for mode for file open */
#define FILE_OPEN_FILENAME_OFFSET   (1 * sizeof(int))       /* byte offset for filename for file open */

#define USBIO_STDIN_FD  0       /* file descriptor for stdin on Blackfin */
#define USBIO_STDOUT_FD 1       /* file descriptor for stdout on Blackfin */
#define USBIO_STDERR_FD 2       /* file descriptor for stderr on Blackfin */

/*********************************************************************
 * defines for host only
 *********************************************************************/

#ifdef _HOSTAPP_

enum _ERROR_VALUES          /* error values */
{
    OPERATION_PASSED = 0,
    UNSUPPORTED_COMMAND,
    IO_WRITE_USBCB_FAILED,
    IO_READ_USBCB_FAILED,
    IO_READ_DATA_FAILED,
    IO_WRITE_DATA_FAILED,
    OUT_OF_MEMORY_ON_HOST,
    ERROR_OPENING_FILE,
    ERROR_READING_FILE,
    NO_AVAILABLE_FILE_PTRS,
    COULD_NOT_CONNECT,
};

#endif  /* _HOSTAPP_ */


/*********************************************************************
 * defines for device only
 *********************************************************************/

#ifndef _HOSTAPP_


#endif /* ! _HOSTAPP_ */


#endif /* _HOSTAPP_H_ */

