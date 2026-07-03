/*********************************************************************************

Copyright(c) 2005 Analog Devices, Inc. All Rights Reserved.

This software is proprietary and confidential.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.

*********************************************************************************/
#include "../host/hostapp/hostapp.h"

#ifndef _DEVICE_H
#include <device.h>                    // device header
#endif // _DEVICE_H

#include "NcTypes.h"
#include "services.h"
#include "SPI_Common.h"
#include <stdlib.h>                    // stdio header
#include <stdio.h>                    // stdio header
#include <string.h>                    // string header
#include <device_int.h>                // IO device header

ADI_SPI_BUFFER SPIDataBuffer;
ADI_SPI_BUFFER SPICommandBuffer;

static USBCB usbcb;                        // USB command block

#pragma align 4
static char stdiobuff[61440/*MAX_DATA_BYTES_BULKADI*/];    // stdio buffer

// USBIO prototypes
int usbio_init(struct DevEntry *dev);
int usbio_open(const char *name, int mode);
int usbio_close(int fd);
int usbio_write(int fd, unsigned char *buf, int size);
int usbio_read(int fd, unsigned char *buf, int size);
long usbio_seek(int fd, long offset, int whence);
int usbio_remove(const char *filename);
int usbio_rename(const char *oldname, const char *newname);
int usbio_ioctl(int fd, int request, va_list varg_list);

// make the buffer big enough to read a large file
#define USBIO_BUFFER_SIZE (MAX_DATA_BYTES_BULKADI)

#define USBIO_DEV_ID    123                        // USBIO device ID
#define USBIO_STDIN_FILENAME    "usbio_stdin"    // USBIO stdin filename
#define USBIO_STDOUT_FILENAME    "usbio_stdout"    // USBIO stdout filename
#define USBIO_STDERR_FILENAME    "usbio_stderr"    // USBIO stderr filename

// file paths on host, note these paths are relative to the location of the host app
// handling the requests
#define TXT_HOST_PATH "..\\..\\USB_IO\\main.c"
#define TXT2_HOST_PATH "..\\..\\USB_IO\\txt2.txt"
#define JPG_HOST_PATH "..\\..\\USB_IO\\sharc.jpg"
#define JPG2_HOST_PATH "..\\..\\USB_IO\\jpg2.jpg"

static DevEntry_Extension Stdio_Usb_extension = {
    DEVFLAGS_BYTEADDRESSED ,
    NULL,
    NULL
};

// DevEntry structure for USBIO
DevEntry _usbio_device =
{
    USBIO_DEV_ID,        // DeviceID
    0,                    // data
    &usbio_init,        // init
    &usbio_open,         // open
    &usbio_close,         // close
    &usbio_write,         // write
    &usbio_read,        // read
    &usbio_seek,        // seek

    // we will claim these for USBIO later
    dev_not_claimed,    // stdinfd
    dev_not_claimed,    // stdoutfd
    dev_not_claimed,    // stderrfd
	&usbio_remove,
	&usbio_rename,
	&usbio_ioctl,
	&Stdio_Usb_extension
};

//#pragma align 4
//char USBIOBuffer[USBIO_BUFFER_SIZE];    // buffer in internal memory

void PackBuffer(UCHAR* unpackedBuffer, UINT* packedBuffer, int transferSize);

extern bool adi_dev_Write(void               *pBuffer);
extern bool adi_dev_Read(void                *pBuffer);
extern volatile bool SPITxFlag,SPIRxFlag;
extern volatile bool bTransferReq;

/******************************************************************************
Routine Description:

    Perform file I/O and stdio over USB with the host.  This function uses all
    the supported capabilities of file I/O such as open, close, read, write,
    and seek and also uses the three stdio streams (stdin, stdout, and stderr).

Arguments:

    none

Return Value:

    unsigned int - return status

******************************************************************************/
int count_var = 0;

unsigned int PerformIo(void)
{
    unsigned int Result = 0;    // result
    static int AddEntryResult = 0;                    // add entry result
    int i=0, j=0, k=0, m=0;                            // temps
    int nDataBytesWritten = 0;                        
    int nDataBytesRead = 0;
    volatile unsigned int v = 0;                    // counter
    static FILE *fpin, *fpout, *fperr;                // stdio file ptrs

    // only setup USBIO if we haven't already
    if ( USBIO_DEV_ID != AddEntryResult )
    {
        // show that printf currently displays in VDSP output window
        printf("This will show up in the VDSP output window\n");

        // add the device to the table
        AddEntryResult = add_devtab_entry( &_usbio_device );

        // make it the default IO device
        set_default_io_device(USBIO_DEV_ID);

        // reopening with USBIO as the default will send stdio to USBIO instead
        fpin = freopen(USBIO_STDIN_FILENAME, "r", stdin);
        fpout = freopen(USBIO_STDOUT_FILENAME, "w", stdout);
        fperr = freopen(USBIO_STDERR_FILENAME, "w", stderr);

        // setup stdout and stderr for line buffering meaning newline will call write()
        setvbuf(fpout, stdiobuff, _IOLBF, sizeof(stdiobuff));
        setvbuf(fperr, stdiobuff, _IOLBF, sizeof(stdiobuff));
    }
    
    DTS_UHD_CommandProcessing();

    //////////////////////////////////////////////////////////
    // tell the host we are done with USBIO to free it up
    //////////////////////////////////////////////////////////

    // init buffer
    SPICommandBuffer.pData = &usbcb;
#ifdef DUMMY_READ
    SPICommandBuffer.ElementCount = (sizeof(usbcb)-sizeof(unsigned long));
#else
    SPICommandBuffer.ElementCount = sizeof(usbcb);
#endif

    // setup the USBCB
    usbcb.u32_Command = USBIO_STOP;    // command

    // wait for host to take the USBCB
    Result = adi_dev_Write((ADI_SPI_BUFFER *)&SPICommandBuffer);

    return Result;
}

//////////////////////////////////////////////////////////////////////////////
// int usbio_init(struct DevEntry *dev)
//////////////////////////////////////////////////////////////////////////////

int usbio_init( struct DevEntry *dev )
{
    // do init here, we just return success
    return 1;
}

//////////////////////////////////////////////////////////////////////////////
//    int usbio_open(const char *name, int mode)
//////////////////////////////////////////////////////////////////////////////

int usbio_open( const char *name, int mode )
{
    char *pcInfo;        // data ptr
    size_t sz_name;        // size of filename
    size_t sz_info;        // size of info block
    int fd = -1;        // file descriptor
    int Result;            // result
    char *pcbytename;    // filename byte packed
    unsigned int mode1;
#ifdef DUMMY_READ
    unsigned long ulShift = 0;
#endif

    // first check for stdio streams, if so return the FD that indicates
    if ( !strcmp(name, USBIO_STDIN_FILENAME) )
        return USBIO_STDIN_FD;
    else if ( !strcmp(name, USBIO_STDOUT_FILENAME) )
        return USBIO_STDOUT_FD;
    else if ( !strcmp(name, USBIO_STDERR_FILENAME) )
        return USBIO_STDERR_FD;

    // get the sizes
    sz_name = strlen(name);
    sz_info = sz_name + 8;

    // if the info block is larger than MAX_DATA_BYTES_BULKADI just fail
    if ( sz_info > MAX_DATA_BYTES_BULKADI)
        return -1;

    // create an info block with mode and name to send to the host, add
    // a little padding for NULL terminator and mode
    pcInfo = (char*) malloc(sz_info);
    pcbytename = (char*) malloc((sz_info) + 4);

    // make sure the malloc worked
    if (!pcInfo || !pcbytename)
        return -1;

    mode1 = (unsigned int)(mode & 0xFFFF);

    // fill in the info block, use "sz + 1" to include the NULL terminator
    memcpy( (void*)(pcInfo + FILE_OPEN_MODE_OFFSET), (void*)&mode1, sizeof(int) );
    PackBuffer( (UCHAR*)name, (UINT*)pcbytename, sz_name + 1 );
    memcpy( (void*)(pcInfo + FILE_OPEN_FILENAME_OFFSET), (void*)pcbytename, sz_name + 1 );

    SPICommandBuffer.pData = &usbcb;
#ifdef DUMMY_READ
    SPICommandBuffer.ElementCount = (sizeof(usbcb)-sizeof(unsigned long));
#else
    SPICommandBuffer.ElementCount = sizeof(usbcb);
#endif

    SPIDataBuffer.pData = pcInfo;
    SPIDataBuffer.ElementCount = sz_info;

    // setup the USBCB
    usbcb.u32_Command = USBIO_OPEN;    // command
    usbcb.u32_Count = sz_info;        // how many data bytes host should expect

    // wait for host to take the USBCB
    Result = adi_dev_Write((ADI_SPI_BUFFER *)&SPICommandBuffer);

    // then wait for the host to take the info block
    Result = adi_dev_Write((ADI_SPI_BUFFER *)&SPIDataBuffer);

    // finally wait for the host to send back the file descriptor or negative value
    // which would indicate a failure opening the file on the host
    SPICommandBuffer.pData = &usbcb;
#ifdef DUMMY_READ
    SPICommandBuffer.ElementCount = ((sizeof(usbcb)-sizeof(unsigned long))+1);
#else
    SPICommandBuffer.ElementCount = sizeof(usbcb);
#endif

    // get the data from the host
    Result = adi_dev_Read((ADI_SPI_BUFFER *)&SPICommandBuffer);
#ifdef DUMMY_READ
    ulShift = usbcb.u32_Command>>8;
    usbcb.u32_Command = ulShift | ((usbcb.u32_Data & 0xFF)<<24);
    ulShift = usbcb.u32_Data>>8;
    usbcb.u32_Data = ulShift | ((usbcb.u32_Count & 0xFF)<<24);
    ulShift = usbcb.u32_Count>>8;
    usbcb.u32_Count = ulShift | ((usbcb.u32_Rem & 0xFF)<<24);
#endif

    // if we got back NULL, that means the open failed on the host, we must return
    // a negative value to indicate failure
    if ( usbcb.u32_Data == 0x0 )
        fd = -1;
    else
        fd = usbcb.u32_Data;

    // free the memory
    free(pcInfo);
    free(pcbytename);

    // return the file descriptor
    return fd;
}

//////////////////////////////////////////////////////////////////////////////
//    int usbio_close(int fd)
//////////////////////////////////////////////////////////////////////////////

int usbio_close( int fd )
{

	int Result;            // result

    SPICommandBuffer.pData = &usbcb;
#ifdef DUMMY_READ
    SPICommandBuffer.ElementCount = (sizeof(usbcb)-sizeof(unsigned long));
#else
    SPICommandBuffer.ElementCount = sizeof(usbcb);
#endif

    // send a USBCB to the host indicating to stop waiting for data
    usbcb.u32_Count = 0x0;
    usbcb.u32_Command = USBIO_CLOSE;
    usbcb.u32_Data = (ULONG)fd;

    // wait for host to take the USBCB
    Result = adi_dev_Write((ADI_SPI_BUFFER *)&SPICommandBuffer);

    // return success
    return 1;
}

//////////////////////////////////////////////////////////////////////////////
//    int usbio_write(int fd, unsigned char *buf, int size)
//////////////////////////////////////////////////////////////////////////////

int usbio_write( int fd, unsigned char *buf, int size )
{
    int bytes_written = 0x0;                // track bytes written overall
    int bytes_current = 0x0;                // track bytes written current
    int bytes_left = size;                    // track bytes left to write
    int Result;                                // result
    bool bClosed = false;                    // closed flag
    bool bError = false;                    // error flag
    unsigned char ucTemp = 0;                // temp
#ifdef DUMMY_READ
    unsigned long ulShift = 0;
#endif

    // set the command buffer to be transmitted
    SPICommandBuffer.pData = &usbcb;
#ifdef DUMMY_READ
    SPICommandBuffer.ElementCount = (sizeof(usbcb)-sizeof(unsigned long));
#else
    SPICommandBuffer.ElementCount = sizeof(usbcb);
#endif
    
    // it seems \n characters cause problems and size is 1, so take care of it
    if ( size < 4 )
    {
        if ( size == 0 )        *buf = (*buf & 0x00000000);
        else if ( size == 1 )    *(unsigned int *)buf = (*(unsigned int *)buf & 0x000000ff);
        else if ( size == 2 )    *buf = (*buf & 0x0000ffff);
        else if ( size == 3 )    *buf = (*buf & 0x00ffffff);
        
        bytes_left = 4;        // don't send less than 4 bytes, it causes problems
    }

    // loop until all the bytes are written or we get closed or error
    while ( (bytes_written < size) && !bClosed && !bError )
    {
        // limit each write to MAX_DATA_BYTES_BULKADI bytes
        if ( bytes_left > MAX_DATA_BYTES_BULKADI)
            bytes_current = MAX_DATA_BYTES_BULKADI;
        else
            bytes_current = bytes_left;

        // setup USBCB
        usbcb.u32_Command = USBIO_WRITE;    // command
        usbcb.u32_Data = fd;                // file descriptor
        usbcb.u32_Count = bytes_current;    // how many data bytes to write this time

#ifdef DUMMY_READ
    SPICommandBuffer.ElementCount = (sizeof(usbcb)-sizeof(unsigned long));
#endif
        // wait for host to take the USBCB
        Result = adi_dev_Write((ADI_SPI_BUFFER *)&SPICommandBuffer);

        // update data buffer count and pointer
        SPIDataBuffer.ElementCount = bytes_current;
        SPIDataBuffer.pData = buf + bytes_written;

        // wait for host to take the data
        Result = adi_dev_Write((ADI_SPI_BUFFER *)&SPIDataBuffer);

        // host will send back USBCB containing actual bytes written which can differ
        // from what was requested and flag indicating if file closed or error occured
#ifdef DUMMY_READ
        SPICommandBuffer.ElementCount = ((sizeof(usbcb)-sizeof(unsigned long))+1);
#endif
        Result = adi_dev_Read((ADI_SPI_BUFFER *)&SPICommandBuffer);
#ifdef DUMMY_READ
        ulShift = usbcb.u32_Command>>8;
        usbcb.u32_Command = ulShift | ((usbcb.u32_Data & 0xFF)<<24);
        ulShift = usbcb.u32_Data>>8;
        usbcb.u32_Data = ulShift | ((usbcb.u32_Count & 0xFF)<<24);
        ulShift = usbcb.u32_Count>>8;
        usbcb.u32_Count = ulShift | ((usbcb.u32_Rem & 0xFF)<<24);
#endif

        // update bytes written and bytes left
        bytes_written += usbcb.u32_Count;
        bytes_left = size - bytes_written;

        // check for closed or error, this would break us out of the loop
        if ( 0x0 == usbcb.u32_Data )
            bClosed = true;
        else if ( 0xffffffff == usbcb.u32_Data )
            bError = true;
    }

    // if closed and we didn't write any data return 0x0
    if ( bClosed && (bytes_written == 0x0) )
        return 0x0;

    // else if error return negative value
    else if ( bError )
        return -1;

    // else return total bytes written
    else
        return bytes_written;
}

//////////////////////////////////////////////////////////////////////////////
//    int usbio_read(int fd, unsigned char *buf, int size)
//////////////////////////////////////////////////////////////////////////////

int usbio_read( int fd, unsigned char *buf, int size )
{
    int bytes_read = 0x0;            // track bytes read overall
    int bytes_current = 0x0;        // track bytes read current
    int bytes_left = size;            // track bytes left to read
    int Result;                        // result
    bool bEOF = false;                // EOF flag
    bool bError = false;            // error flag
    int nTemp = 0;                    // temp
#ifdef DUMMY_READ
    unsigned long ulShift = 0;
    unsigned char buf_temp[USBIO_BUFFER_SIZE+4] = { 0 };
#endif

    SPICommandBuffer.pData = &usbcb;
#ifdef DUMMY_READ
    SPICommandBuffer.ElementCount = (sizeof(usbcb)-sizeof(unsigned long));
#else
    SPICommandBuffer.ElementCount = sizeof(usbcb);
#endif

    // loop until all the bytes are read or we get EOF or error
    while ( (bytes_read < size) && !bEOF && !bError )
    {
        // limit each read to MAX_DATA_BYTES_BULKADI bytes
        if ( bytes_left > MAX_DATA_BYTES_BULKADI)
            bytes_current = MAX_DATA_BYTES_BULKADI;
        else
            bytes_current = bytes_left;

        // setup the USBCB
        usbcb.u32_Command = USBIO_READ;    // command
        usbcb.u32_Data = fd;                // file descriptor
        usbcb.u32_Count = bytes_current;    // how many data bytes to read this time

#ifdef DUMMY_READ
    SPICommandBuffer.ElementCount = (sizeof(usbcb)-sizeof(unsigned long));
#endif
        // wait for host to take the USBCB
        Result = adi_dev_Write((ADI_SPI_BUFFER *)&SPICommandBuffer);

        // host will send back USBCB containing actual bytes read which can differ
        // from what was requested and flag indicating if end-of-file or error occured
#ifdef DUMMY_READ
        SPICommandBuffer.ElementCount = ((sizeof(usbcb)-sizeof(unsigned long))+1);
#endif
        Result = adi_dev_Read((ADI_SPI_BUFFER *)&SPICommandBuffer);
#ifdef DUMMY_READ
        ulShift = usbcb.u32_Command>>8;
        usbcb.u32_Command = ulShift | ((usbcb.u32_Data & 0xFF)<<24);
        ulShift = usbcb.u32_Data>>8;
        usbcb.u32_Data = ulShift | ((usbcb.u32_Count & 0xFF)<<24);
        ulShift = usbcb.u32_Count>>8;
        usbcb.u32_Count = ulShift | ((usbcb.u32_Rem & 0xFF)<<24);
#endif

        // if there's data to read, get it
        if ( usbcb.u32_Count )
        {
            // update data buffer count and pointer
#ifdef DUMMY_READ
        	SPIDataBuffer.pData = buf_temp;
        	SPIDataBuffer.ElementCount = usbcb.u32_Count+1;    // actual bytes to read+1
#else
        	SPIDataBuffer.pData = buf + (bytes_read);
        	SPIDataBuffer.ElementCount = usbcb.u32_Count;    // actual bytes to read
#endif

            // then wait for the host to send the data
            Result = adi_dev_Read((ADI_SPI_BUFFER *)&SPIDataBuffer);
#ifdef DUMMY_READ
            memcpy((buf + bytes_read), &buf_temp[1], usbcb.u32_Count);
#endif
        }

        // update bytes read and bytes left
        bytes_read += usbcb.u32_Count;
        bytes_left = size - bytes_read;

        // check for EOF or error, this would break us out of the loop
        if ( 0x0 == usbcb.u32_Data )
            bEOF = true;
        else if ( 0xffffffff == usbcb.u32_Data )
            bError = true;

        // for now if STDIN, just get data one time because we're requesting
        // more than they'll probably enter
        if ( USBIO_STDIN_FD == fd )
            bEOF = true;
    }

    // if EOF and we didn't read any data return 0x0
    if ( bEOF && (bytes_read == 0x0) )
        return 0x0;

    // else if error return negative value
    else if ( bError )
        return -1;

    // else return total bytes read
    else
        return bytes_read;
}

//////////////////////////////////////////////////////////////////////////////
//    long usbio_seek(int fd, long offset, int whence)
//////////////////////////////////////////////////////////////////////////////

long usbio_seek( int fd, long offset, int whence )
{
    int Result;                // result
#ifdef DUMMY_READ
    unsigned long ulShift = 0;
#endif

    SPICommandBuffer.pData = &usbcb;
#ifdef DUMMY_READ
    SPICommandBuffer.ElementCount = (sizeof(usbcb)-sizeof(unsigned long));
#else
    SPICommandBuffer.ElementCount = sizeof(usbcb);
#endif

    // determine the origin
    if ( 0x0 == whence )
        usbcb.u32_Command = USBIO_SEEK_SET;
    else if ( 0x1 == whence )
        usbcb.u32_Command = USBIO_SEEK_CUR;
    else if ( 0x2 == whence )
        usbcb.u32_Command = USBIO_SEEK_END;

    usbcb.u32_Data = fd;            // file descriptor
    usbcb.u32_Count = offset;        // how many bytes from origin

    // wait for host to take the USBCB
    Result = adi_dev_Write((ADI_SPI_BUFFER *)&SPICommandBuffer);

    // host will send back USBCB containing new file position and status
#ifdef DUMMY_READ
    SPICommandBuffer.ElementCount = ((sizeof(usbcb)-sizeof(unsigned long))+1);
#endif
    Result = adi_dev_Read((ADI_SPI_BUFFER *)&SPICommandBuffer);
#ifdef DUMMY_READ
    ulShift = usbcb.u32_Command>>8;
    usbcb.u32_Command = ulShift | ((usbcb.u32_Data & 0xFF)<<24);
    ulShift = usbcb.u32_Data>>8;
    usbcb.u32_Data = ulShift | ((usbcb.u32_Count & 0xFF)<<24);
    ulShift = usbcb.u32_Count>>8;
    usbcb.u32_Count = ulShift | ((usbcb.u32_Rem & 0xFF)<<24);
#endif

    // if there was no error return the new file position
    if ( 0x0 == usbcb.u32_Data )
        return usbcb.u32_Count;

    // else there was an error
    else
        return -1;
}

/* Remove is not supported in the STDIO service */
static int   usbio_remove(const char *filename)
{
    return -1;
}

/* Rename is not supported in the STDIO service */
static int   usbio_rename(const char *oldname, const char *newname)
{
    return -1;
}

/* IOCTL is not supported in the STDIO service */
static int   usbio_ioctl(int fd, int request, va_list varg_list)
{
    return -1;
}

/******************************************************************************
Routine Description:

    Reads data from memory and sends it back to the host.

Arguments:

    u8 *p8Address -                address to read from
    u32 u32Count -                number of bytes to read

Return Value:

    unsigned int - return status

******************************************************************************/

unsigned int ReadMemory( u8 *p8Address, u32 u32Count )
{
    SPIDataBuffer.ElementCount = u32Count;
    SPIDataBuffer.pData = p8Address;

    // send the data back to the host
    return adi_dev_Write((ADI_SPI_BUFFER *)&SPIDataBuffer);
}


/******************************************************************************
Routine Description:

    Receives data from the host and writes it to memory.

Arguments:

    u8 *p8Address -                address to write to
    u32 u32Count -                number of bytes to write

Return Value:

    unsigned int - return status

******************************************************************************/

unsigned int WriteMemory(  u8 *p8Address, u32 u32Count )
{
    SPIDataBuffer.ElementCount = u32Count;
    SPIDataBuffer.pData = p8Address;

    // get the data from the host
    return adi_dev_Read((ADI_SPI_BUFFER *)&SPIDataBuffer);
}

/******************************************************************************
Routine Description:

    Checks to see if a command is supported by this firmware.  The host can use
    this to verify that a command it wants to execute is supported ahead of time.

Arguments:

    u32 u32Command -            command we are querying on

Return Value:

    unsigned int - return status

******************************************************************************/

unsigned int QuerySupport( u32 u32Command )
{
    int Result;

    SPICommandBuffer.pData = &usbcb;
#ifdef DUMMY_READ
    SPICommandBuffer.ElementCount = (sizeof(usbcb)-4);
#else
    SPICommandBuffer.ElementCount = sizeof(usbcb);
#endif


    // check for a supported command
    if (QUERY_SUPPORT == u32Command || GET_FW_VERSION == u32Command ||
        USBIO_START == u32Command || MEMORY_READ == u32Command ||
        MEMORY_WRITE == u32Command || LOOPBACK == u32Command)
        usbcb.u32_Data = TRUE;
    else
        usbcb.u32_Data = FALSE;

    // send a USBCB to the host with the result
    usbcb.u32_Count = 0x0;
    usbcb.u32_Command = QUERY_REPLY;

    // wait for host to take the USBCB
    Result = adi_dev_Write((ADI_SPI_BUFFER *)&SPICommandBuffer);

    // return success
    return Result;
}


/******************************************************************************
Routine Description:

    Extracts the low byte from 4 consecutive 32-bit items and packs the data into
    a single 32-bit item.  Useful for taking SHARC character strings and creating
    a useful string for the host.
    
Arguments:

    UCHAR* unpackedBuffer -        unpacked buffer, 32 bits each
    UCHAR* packedBuffer -        packed buffer, 8 bits each
    int transferSize -            number of items to pack

Return Value:

    unsigned int - return status

******************************************************************************/
void PackBuffer(UCHAR* unpackedBuffer, UINT* packedBuffer, int transferSize)
{
    int i = 1, j= 1;

    // copy data to the packed buffer
    while (i <= transferSize)
    {
        i++;
        if (j == 4)
        {
            *packedBuffer |= ( *(unpackedBuffer) & 0xff ) << 24;
            unpackedBuffer++;
            j = 1;
            packedBuffer++;
        }
        else if (j == 3)
        {
            *packedBuffer |= ( *(unpackedBuffer) & 0xff ) << 16;
            unpackedBuffer++;
            j++;
        }
        else if (j == 2)
        {
            *packedBuffer |= ( *(unpackedBuffer) & 0xff ) << 8;
            unpackedBuffer++;
            j++;
        }
        else if (j == 1)
        {
            *packedBuffer = ( *(unpackedBuffer) & 0xff );    
            unpackedBuffer++;
            j++;
        }
    }
}
