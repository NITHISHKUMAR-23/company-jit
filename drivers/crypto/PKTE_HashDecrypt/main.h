/*********************************************************************************
Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*!
 * @file      main.h
 * @brief     Example to demonstrate Hash-Decrypt operation using PKTE.
 * @version:  $Revision: 37413 $
 * @date:     $Date: 2019-04-17 10:26:08 +0530 (Wed, 17 Apr 2019) $
 *
 * @details
 *            This is the primary include file to demonstrate
 *            Hash-Decrypt operation using PKTE peripheral.
 *            The 'HashSHA1_DecryptAES128' (default) application configures the PKTE to decrypt a plaintext in AES-128 bit
 *            and hash using SHA-1.
 *
 * 			  It can run in three different modes which can be passed as a pre-processor command:
 * 				AUTO_MODE (Default)	: To run in Autonomous mode
 * 				TCM_MODE		: To run in TCM mode
 * 				HOST_MODE	: To run in Host mode
 *
 *            To select other combinations, any one of the below needs to be passed as a pre-processor macro:
 *				HashSHA1_DecryptAES128
 *				HashSHA224_DecryptAES128
 *				HashSHA256_DecryptAES128
 *				HashMD5_DecryptAES128
 *				HashSHA1_DecryptAES192
 *				HashSHA224_DecryptAES192
 *				HashSHA256_DecryptAES192
 *				HashMD5_DecryptAES192
 *				HashSHA1_DecryptAES256
 *				HashSHA224_DecryptAES256
 *				HashSHA256_DecryptAES256
 *				HashMD5_DecryptAES256
 *				HashSHA1_DecryptDES
 *				HashSHA224_DecryptDES
 *				HashSHA256_DecryptDES
 *				HashMD5_DecryptDES
 *				HashSHA1_DecryptTDES
 *				HashSHA224_DecryptTDES
 *				HashSHA256_DecryptTDES
 *				HashMD5_DecryptTDES
 *				HashSHA1_DecryptARC4
 *				HashSHA224_DecryptARC4
 *				HashSHA256_DecryptARC4
 *				HashMD5_DecryptARC4
 *
 */

#ifndef __MAIN_H__
#define __MAIN_H__


/* Example result definitions */
#define FAILED              (-1)
#define PASSED              ( 0)


#include <stdio.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"

#include <drivers/crypto/adi_pkte.h>




#ifdef HashSHA1_DecryptAES128
#define AES_Decryption
#define AES128_Decryption
#define SHA1_Hashing
#endif
#ifdef HashSHA224_DecryptAES128
#define AES_Decryption
#define AES128_Decryption
#define SHA224_Hashing
#endif
#ifdef HashSHA256_DecryptAES128
#define AES_Decryption
#define AES128_Decryption
#define SHA256_Hashing
#endif
#ifdef HashMD5_DecryptAES128
#define AES_Decryption
#define AES128_Decryption
#define MD5_Hashing
#endif
#ifdef HashSHA1_DecryptAES192
#define AES_Decryption
#define AES192_Decryption
#define SHA1_Hashing
#endif
#ifdef HashSHA224_DecryptAES192
#define AES_Decryption
#define AES192_Decryption
#define SHA224_Hashing
#endif
#ifdef HashSHA256_DecryptAES192
#define AES_Decryption
#define AES192_Decryption
#define SHA256_Hashing
#endif
#ifdef HashMD5_DecryptAES192
#define AES_Decryption
#define AES192_Decryption
#define MD5_Hashing
#endif
#ifdef HashSHA1_DecryptAES256
#define AES_Decryption
#define AES256_Decryption
#define SHA1_Hashing
#endif
#ifdef HashSHA224_DecryptAES256
#define AES_Decryption
#define AES256_Decryption
#define SHA224_Hashing
#endif
#ifdef HashSHA256_DecryptAES256
#define AES_Decryption
#define AES256_Decryption
#define SHA256_Hashing
#endif
#ifdef HashMD5_DecryptAES256
#define AES_Decryption
#define AES256_Decryption
#define MD5_Hashing
#endif
#ifdef HashSHA1_DecryptDES
#define DES_Decryption
#define SHA1_Hashing
#endif
#ifdef HashSHA224_DecryptDES
#define DES_Decryption
#define SHA224_Hashing
#endif
#ifdef HashSHA256_DecryptDES
#define DES_Decryption
#define SHA256_Hashing
#endif
#ifdef HashMD5_DecryptDES
#define DES_Decryption
#define MD5_Hashing
#endif
#ifdef HashSHA1_DecryptTDES
#define TDES_Decryption
#define SHA1_Hashing
#endif
#ifdef HashSHA224_DecryptTDES
#define TDES_Decryption
#define SHA224_Hashing
#endif
#ifdef HashSHA256_DecryptTDES
#define TDES_Decryption
#define SHA256_Hashing
#endif
#ifdef HashMD5_DecryptTDES
#define TDES_Decryption
#define MD5_Hashing
#endif
#ifdef HashSHA1_DecryptARC4
#define ARC4_Decryption
#define SHA1_Hashing
#endif
#ifdef HashSHA224_DecryptARC4
#define ARC4_Decryption
#define SHA224_Hashing
#endif
#ifdef HashSHA256_DecryptARC4
#define ARC4_Decryption
#define SHA256_Hashing
#endif
#ifdef HashMD5_DecryptARC4
#define ARC4_Decryption
#define MD5_Hashing
#endif






/* 128 bit plaintext for AES */
#if defined(__ADSPSHARC__)
#pragma section ("seg_l2_dmda_bw")
#endif
uint32_t source0[4]={0x12345678,0x9abcdef0,0x11223344,0x55667788};

#ifdef SHA1_Hashing
int hash_output[5];
int destination0[4];
int destination1[9];
#endif
#ifdef SHA224_Hashing
int hash_output[7];
int destination0[4];
int destination1[11];
#endif
#ifdef SHA256_Hashing
int hash_output[8];
int destination0[4];
int destination1[12];
#endif
#ifdef MD5_Hashing
int hash_output[4];
int destination0[4];
int destination1[8];
#endif


/*256 bit key space assigned for 128bit key for AES */
#if defined(__ADSPSHARC__)
#pragma section ("seg_l2_dmda_bw")
#endif
ADI_CACHE_ALIGN uint32_t Key[ADI_CACHE_ROUND_UP_SIZE(8,uint32_t)]={0x0,0x0,0x0,0x0,0,0,0,0};

/*Initialization Vector 128bit for AES*/
#if defined(__ADSPSHARC__)
#pragma section ("seg_l2_dmda_bw")
#endif
ADI_CACHE_ALIGN uint32_t IV[ADI_CACHE_ROUND_UP_SIZE(4,uint32_t)]={0x0,0x0,0x0,0x0};

 /*256 bit space assigned for IDigest, though it will not be used for AES*/
#if defined(__ADSPSHARC__)
#pragma section ("seg_l2_dmda_bw")
#endif
ADI_CACHE_ALIGN uint32_t IDigest[ADI_CACHE_ROUND_UP_SIZE(8,uint32_t)]={0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0};

#endif /* __MAIN_H__ */
