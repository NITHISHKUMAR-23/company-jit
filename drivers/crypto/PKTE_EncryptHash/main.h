/*********************************************************************************
Copyright(c) 2021 Analog Devices, Inc. All Rights Reserved.
This software is proprietary. By using this software you agree
to the terms of the associated Analog Devices License Agreement.
*********************************************************************************/

/*!
 * @file      main.h
 * @brief     Example to demonstrate Encrypt-Hash operation using PKTE.
 * @version:  $Revision: 37413 $
 * @date:     $Date: 2019-04-17 10:26:08 +0530 (Wed, 17 Apr 2019) $
 *
 * @details
 *            This is the primary include file to demonstrate
 *            Encrypt-Hash operation using PKTE peripheral.
 *            The 'EncryptAES128_HashSHA1' (default) application configures the PKTE to encrypt a plaintext in AES-128 bit
 *            and hash using SHA-1.
 *
 * 			  It can run in three different modes which can be passed as a pre-processor command:
 * 				AUTO_MODE (Default)	: To run in Autonomous mode
 * 				TCM_MODE		: To run in TCM mode
 * 				HOST_MODE	: To run in Host mode
 *
 *            To select other combinations, any one of the below needs to be passed as a pre-processor macro:
 * 				EncryptAES128_HashSHA1
 * 				EncryptAES128_HashSHA224
 * 				EncryptAES128_HashSHA256
 * 				EncryptAES128_HashMD5
 * 				EncryptAES192_HashSHA1
 * 				EncryptAES192_HashSHA224
 * 				EncryptAES192_HashSHA256
 * 				EncryptAES192_HashMD5
 * 				EncryptAES256_HashSHA1
 * 				EncryptAES256_HashSHA224
 * 				EncryptAES256_HashSHA256
 * 				EncryptAES256_HashMD5
 * 				EncryptDES_HashSHA1
 * 				EncryptDES_HashSHA224
 * 				EncryptDES_HashSHA256
 * 				EncryptDES_HashMD5
 * 				EncryptTDES_HashSHA1
 * 				EncryptTDES_HashSHA224
 * 				EncryptTDES_HashSHA256
 * 				EncryptTDES_HashMD5
 *	 			EncryptARC4_HashSHA1
 * 				EncryptARC4_HashSHA224
 *  			EncryptARC4_HashSHA256
 * 				EncryptARC4_HashMD5
 *
 */

#ifndef __MAIN_H__
#define __MAIN_H__

/* Add your custom header content here */



/* Example result definitions */
#define FAILED              (-1)
#define PASSED              ( 0)


#include <stdio.h>
#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"

#include <drivers/crypto/adi_pkte.h>


#ifdef EncryptAES128_HashSHA1
#define AES_Encryption
#define AES128_Encryption
#define SHA1_Hashing
#endif
#ifdef EncryptAES128_HashSHA224
#define AES_Encryption
#define AES128_Encryption
#define SHA224_Hashing
#endif
#ifdef EncryptAES128_HashSHA256
#define AES_Encryption
#define AES128_Encryption
#define SHA256_Hashing
#endif
#ifdef EncryptAES128_HashMD5
#define AES_Encryption
#define AES128_Encryption
#define MD5_Hashing
#endif
#ifdef EncryptAES192_HashSHA1
#define AES_Encryption
#define AES192_Encryption
#define SHA1_Hashing
#endif
#ifdef EncryptAES192_HashSHA224
#define AES_Encryption
#define AES192_Encryption
#define SHA224_Hashing
#endif
#ifdef EncryptAES192_HashSHA256
#define AES_Encryption
#define AES192_Encryption
#define SHA256_Hashing
#endif
#ifdef EncryptAES192_HashMD5
#define AES_Encryption
#define AES192_Encryption
#define MD5_Hashing
#endif
#ifdef EncryptAES256_HashSHA1
#define AES_Encryption
#define AES256_Encryption
#define SHA1_Hashing
#endif
#ifdef EncryptAES256_HashSHA224
#define AES_Encryption
#define AES256_Encryption
#define SHA224_Hashing
#endif
#ifdef EncryptAES256_HashSHA256
#define AES_Encryption
#define AES256_Encryption
#define SHA256_Hashing
#endif
#ifdef EncryptAES256_HashMD5
#define AES_Encryption
#define AES256_Encryption
#define MD5_Hashing
#endif
#ifdef EncryptDES_HashSHA1
#define DES_Encryption
#define SHA1_Hashing
#endif
#ifdef EncryptDES_HashSHA224
#define DES_Encryption
#define SHA224_Hashing
#endif
#ifdef EncryptDES_HashSHA256
#define DES_Encryption
#define SHA256_Hashing
#endif
#ifdef EncryptDES_HashMD5
#define DES_Encryption
#define MD5_Hashing
#endif
#ifdef EncryptTDES_HashSHA1
#define TDES_Encryption
#define SHA1_Hashing
#endif
#ifdef EncryptTDES_HashSHA224
#define TDES_Encryption
#define SHA224_Hashing
#endif
#ifdef EncryptTDES_HashSHA256
#define TDES_Encryption
#define SHA256_Hashing
#endif
#ifdef EncryptTDES_HashMD5
#define TDES_Encryption
#define MD5_Hashing
#endif
#ifdef EncryptARC4_HashSHA1
#define ARC4_Encryption
#define SHA1_Hashing
#endif
#ifdef EncryptARC4_HashSHA224
#define ARC4_Encryption
#define SHA224_Hashing
#endif
#ifdef EncryptARC4_HashSHA256
#define ARC4_Encryption
#define SHA256_Hashing
#endif
#ifdef EncryptARC4_HashMD5
#define ARC4_Encryption
#define MD5_Hashing
#endif





/* 128 bit plaintext for AES */
#if defined(__ADSPSHARC__)
section ("seg_l2_dmda_bw")
#endif
uint32_t source0[4]={0x6a84867c,0xd77e12ad,0x07ea1be8,0x95c53fa3};

/* 128 bit ciphertext for Encryption */
#if defined(__ADSPSHARC__)
section ("seg_l2_dmda_bw")
#endif
uint32_t ciphertext[4]= {1,2,3,4};

#ifdef SHA1_Hashing
/* Hash output */
#if defined(__ADSPSHARC__)
section ("seg_l2_dmda_bw")
#endif
uint32_t destination0[5]= {1,2,3,4};
/* Encrypt Hash Output */
uint32_t destination1[9]= {1,2,3,4};
#endif

#ifdef SHA224_Hashing
/* Hash output */
#if defined(__ADSPSHARC__)
section ("seg_l2_dmda_bw")
#endif
uint32_t destination0[7]= {1,2,3,4};
/* Encrypt Hash Output */
uint32_t destination1[11]= {1,2,3,4};
#endif

#ifdef SHA256_Hashing
/* Hash output */
#if defined(__ADSPSHARC__)
section ("seg_l2_dmda_bw")
#endif
uint32_t destination0[8]= {1,2,3,4};
/* Encrypt Hash Output */
uint32_t destination1[12]= {1,2,3,4};
#endif

#ifdef MD5_Hashing
/* Hash output */
#if defined(__ADSPSHARC__)
section ("seg_l2_dmda_bw")
#endif
uint32_t destination0[4]= {1,2,3,4};
/* Encrypt Hash Output */
uint32_t destination1[8]= {1,2,3,4};
#endif

/* 128 bit ciphertext for AES */
#if defined(__ADSPSHARC__)
#pragma section("seg_l2_dmda_bw")
#endif
ADI_CACHE_ALIGN uint32_t ciphertext1[ADI_CACHE_ROUND_UP_SIZE(4,uint32_t)];

/*256 bit key space assigned for 128bit key for AES */
#if defined(__ADSPSHARC__)
#pragma section("seg_l2_dmda_bw")
#endif
ADI_CACHE_ALIGN uint32_t Key[ADI_CACHE_ROUND_UP_SIZE(8,uint32_t)]={0x0,0x0,0x0,0x0,0,0,0,0};

/*Initialization Vector 128bit for AES*/
#if defined(__ADSPSHARC__)
#pragma section("seg_l2_dmda_bw")
#endif
ADI_CACHE_ALIGN uint32_t IV[ADI_CACHE_ROUND_UP_SIZE(4,uint32_t)]={0x0,0x0,0x0,0x0};

 /*256 bit space assigned for IDigest, though it will not be used for AES*/
#if defined(__ADSPSHARC__)
#pragma section("seg_l2_dmda_bw")
#endif
ADI_CACHE_ALIGN uint32_t IDigest[ADI_CACHE_ROUND_UP_SIZE(8,uint32_t)]={0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0};

#endif /* __MAIN_H__ */
