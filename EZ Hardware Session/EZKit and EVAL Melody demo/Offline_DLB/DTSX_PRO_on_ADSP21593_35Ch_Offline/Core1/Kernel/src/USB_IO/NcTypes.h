
/****************************************************************************

Copyright (C) 2004, NetChip Technology, Inc. (http://www.netchip.com)

THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.

NCTYPES.H

NetChip data types. Data types specified in this file are used by NetChip
files.


****************************************************************************/

#ifndef NCTYPES_H
#define NCTYPES_H

#define NUM_CHARS_IN_UNICODE_CHAR 2
typedef unsigned long ULONG;
typedef ULONG *PULONG;
typedef unsigned short USHORT;
typedef USHORT *PUSHORT;
typedef unsigned char UCHAR;
typedef UCHAR *PUCHAR;
typedef char *PSZ;
typedef char CHAR, *PCHAR;
typedef char *LPSTR;
typedef bool *PBOOL;
typedef void VOID;

typedef unsigned long       DWORD;
typedef unsigned char       BYTE;
typedef unsigned short      WORD;
typedef float               FLOAT;
typedef DWORD               *PDWORD;
typedef BYTE                *PBYTE;
typedef FLOAT               *PFLOAT;
typedef int                 INT;
typedef unsigned int        UINT;
typedef unsigned int        *PUINT;
typedef void                *PVOID;
typedef void                *LPVOID;

/* Types use for passing & returning polymorphic values */
typedef UINT WPARAM;
typedef long LPARAM;
typedef long LRESULT;

#define LOBYTE(w)           ((BYTE)(w & 0xff))
#define HIBYTE(w)           ((BYTE)(((WORD)(w) >> 8) & 0xFF))
#define NC_LOBYTE(w)        ((BYTE)(w&0xFF))
#define NC_HIBYTE(w)        ((BYTE)(((USHORT)(w) >> 8) & 0xFF))
#define HANDLE              PUINT
#define LOWORD(a) ((USHORT)a & 0xffff)
#define HIWORD(a) ((USHORT)(a >> 16))

///////////////////////////////////////////////////////////////////////////////
// Little Endian <--> Big Endian conversion helper macros
//  - USB is Little Endian (See USB 2.0: 8.1)
//  - Using these macros, the native CPU can be Big or Little Endian
#define NATIVECPU_BIGENDIAN false   // TRUE: Native CPU is a Big Endian machine (e.g. Motorola MP860)

#define LITTLEEND_LO 0              // Offset to low byte of a Little Endian word
#define LITTLEEND_HI 1              // Offset to high byte of a Little Endian word
#define BIGEND_LO 1                 // Offset to low byte of a Big Endian word
#define BIGEND_HI 0                 // Offset to high byte of a Big Endian word

#if NATIVECPU_BIGENDIAN
#define MYEND_LO BIGEND_LO          // Offset to low byte if we are a Big Endian machine
#define MYEND_HI BIGEND_HI          // Offset to high byte if we are a Big Endian machine
#else
#define MYEND_LO LITTLEEND_LO       // Offset to low byte if we are a Little Endian machine
#define MYEND_HI LITTLEEND_HI       // Offset to high byte if we are a Little Endian machine
#endif

///////////////////////////////////////////////////////////////////////////////
typedef union _WORDBYTE
{   // WordByte helps to handle Little Endian USB content across Big and Little Endian CPUs
    //  - USB is Little Endian. USB bytes are written to a WordByte, one byte at a time
    //  - Using the MyEndian and LittleEndian macros, USB bytes should become arranged in
    //    memory in the appropriate order for the target CPU
    //  - Packing: Be sure the target compiler packs this union properly!
    BYTE Byte[2];   // Two 8-bit bytes
    USHORT Word;    // One 16 bit word
} WORDBYTE, * PWORDBYTE;

/////////////////////////////////////////////////////////////////////////////
// Print compile-time message (not a warning or error)
//  - Compile-time messages direct first-time users to interesting code sections
#define __NCSTR2__(x) #x
#define __NCSTR1__(x) __NCSTR2__(x)
#define _NC_MESSAGE " -- NetChip message: Line "__NCSTR1__(__LINE__)": "

/////////////////////////////////////////////////////////////////////////////
// Prevent warnings for unreferenced parameters and variables
//  - Thanks to Windows DDK
#ifndef UNREFERENCED_PARAMETER
#define UNREFERENCED_PARAMETER(P)          (P)      // Parameter will never be referenced
#define DBG_UNREFERENCED_PARAMETER(P)      (P)      // Parameter will eventually be referenced
#define DBG_UNREFERENCED_LOCAL_VARIABLE(V) (V)      // Local variable will eventually be referenced
#endif

/////////////////////////////////////////////////////////////////////////////
#endif // NCTYPES_H

/////////////////////////////////////////////////////////////////////////////
//  End of file
