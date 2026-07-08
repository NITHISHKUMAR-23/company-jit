/*********************************************************************************
Copyright(c) 2021-2022 Analog Devices, Inc. All Rights Reserved.

This software is proprietary.  By using this software you agree
to the terms of the associated Analog Devices License Agreement.
 *********************************************************************************/

/*!
 * @file      main.c
 * @brief     Example to demonstrate Encrypt-Hash operation using PKTE.
 * @version:  $Revision: 37561 $
 * @date:     $Date: 2019-08-14 17:51:16 +0530 (Wed, 14 Aug 2019) $
 *
 * @details
 *            This is the primary source file to demonstrate
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





/*=============  I N C L U D E S   =============*/
#include "main.h"
#include <drivers/crypto/adi_pkte_2156x.h>
#include <services/int/adi_int.h>
#include <sys/adi_core.h>

#if defined(__ADSPARM__)
/* A55 core */
#include <runtime/cache/adi_cache.h>
#else
/* SHARC core */
#include <sys/cache.h>
#endif

#if defined(__ADSPSHARC__)
#pragma section("seg_l2_dmda_bw")
#endif
ADI_CACHE_ALIGN uint32_t Error_Count=0;
static uint8_t gPKTEMemory[ADI_PKTE_MEMORY_SIZE];
static ADI_PKTE_HANDLE ghPKTE;

volatile ADI_PKTE_LIST PkteList1,PkteList2,PkteList3;
ADI_PKTE_COMMAND command0,command1,command2;
int count=0;

/*=============  L O C A L    F U N C T I O N S  =============*/
void  adi_PKTE_Status (int *pError_Response,int Error,void *pArg)
{

	count++;

	if(Error == ADI_PKTE_SUCCESS)
	{
		/* Pointer to device instance */
		*pError_Response = Error;

	}
	else
		*pError_Response = 1;
}

void Configure_Encrypt_Hash_Command(ADI_PKTE_COMMAND *command2)
{
	command2->opcode=opcode_encrypt_hash;
	command2->direction=dir_outbound;
#ifdef AES_Encryption
	command2->cipher=cipher_aes;
#ifdef AES128_Encryption
	command2->aes_key_length=aes_key_length128;
#endif
#ifdef AES192_Encryption
	command2->aes_key_length=aes_key_length192;
#endif
#ifdef AES256_Encryption
	command2->aes_key_length=aes_key_length256;
#endif
	command2->aes_des_key=aes_key;
#endif
#ifdef DES_Encryption
	command2->cipher=cipher_des;
	command2->aes_key_length=aes_key_length_other;
#endif

#ifdef TDES_Encryption
	command2->cipher=cipher_tdes;
	command2->aes_key_length=aes_key_length_other;
#endif

#ifdef ARC4_Encryption
	command2->cipher=cipher_arc4;
	command2->aes_key_length=aes_key_length128;
#endif
#ifdef SHA1_Hashing
	command2->hash=hash_sha1;
	command2->digest_length=digest_length5;
#endif
#ifdef SHA224_Hashing
	command2->hash=hash_sha224;
	command2->digest_length=digest_length7;
#endif
#ifdef SHA256_Hashing
	command2->hash=hash_sha256;
	command2->digest_length=digest_length8;
#endif
#ifdef MD5_Hashing
	command2->hash=hash_md5;
	command2->digest_length=digest_length4;
#endif

	command2->cipher_mode=cipher_mode_ecb;
	command2->hash_mode=hash_mode_standard;
	command2->hash_source=hash_source_no_load;
	command2->final_hash_condition=final_hash;
#ifdef AUTO_MODE
    command2->pkte_mode= PKTE_AUTONOMOUS_MODE;
#endif
#ifdef TCM_MODE
    command2->pkte_mode= PKTE_TCM_MODE;
#endif
#ifdef HOST_MODE
    command2->pkte_mode= PKTE_HOST_MODE;
#endif
}

void Configure_Hash_Command(ADI_PKTE_COMMAND *command1)
{
	/*Configure the mode of hash operation in ADI_PKTE_COMMAND structure */
		command1->opcode=opcode_hash;
		command1->direction=dir_outbound;
		command1->cipher=cipher_null;
	#ifdef SHA1_Hashing
		command1->hash=hash_sha1;
		command1->digest_length=digest_length5;
	#endif
	#ifdef SHA224_Hashing
		command1->hash=hash_sha224;
		command1->digest_length=digest_length7;
	#endif
	#ifdef SHA256_Hashing
		command1->hash=hash_sha256;
		command1->digest_length=digest_length8;
	#endif
	#ifdef MD5_Hashing
		command1->hash=hash_md5;
		command1->digest_length=digest_length4;
	#endif

		command1->cipher_mode=cipher_mode_ecb;
		command1->hash_mode=hash_mode_standard;
		command1->aes_key_length=aes_key_length128;
	    command1->aes_des_key=aes_key;
	    command1->hash_source=hash_source_no_load;
	    command1->final_hash_condition=final_hash;
#ifdef AUTO_MODE
	    command1->pkte_mode= PKTE_AUTONOMOUS_MODE;
#endif
#ifdef TCM_MODE
	    command1->pkte_mode= PKTE_TCM_MODE;
#endif
#ifdef HOST_MODE
	    command1->pkte_mode= PKTE_HOST_MODE;
#endif
}

void Configure_Encryption_Command(ADI_PKTE_COMMAND *command0)
{
	/*Configure the mode of encryption operation in ADI_PKTE_COMMAND structure */
	command0->opcode=opcode_encrypt;
	command0->direction=dir_outbound;
#ifdef AES_Encryption
	command0->cipher=cipher_aes;
#ifdef AES128_Encryption
	command0->aes_key_length=aes_key_length128;
#endif
#ifdef AES192_Encryption
	command0->aes_key_length=aes_key_length192;
#endif
#ifdef AES256_Encryption
	command0->aes_key_length=aes_key_length256;
#endif
	command0->aes_des_key=aes_key;
#endif

#ifdef DES_Encryption
	command0->cipher=cipher_des;
	command0->aes_key_length=aes_key_length_other;
#endif

#ifdef TDES_Encryption
	command0->cipher=cipher_tdes;
	command0->aes_key_length=aes_key_length_other;
#endif

#ifdef ARC4_Encryption
	command0->cipher=cipher_arc4;
	command0->aes_key_length=aes_key_length128;
#endif
	command0->hash=hash_null;
	command0->digest_length=digest_length4;
	command0->cipher_mode=cipher_mode_ecb;
	command0->hash_mode=hash_mode_standard;
	command0->hash_source=hash_source_no_load;
	command0->final_hash_condition=final_hash;
#ifdef AUTO_MODE
	command0->pkte_mode= PKTE_AUTONOMOUS_MODE;
#endif
#ifdef TCM_MODE
	command0->pkte_mode= PKTE_TCM_MODE;
#endif
#ifdef HOST_MODE
	command0->pkte_mode= PKTE_HOST_MODE;
#endif
}


/*********************************************************************
*
*   Function:   main
*
*********************************************************************/

int main()
{

	adi_initComponents();
#if defined(__ADSPARM__)
	adi_core_enable(ADI_CORE_SHARC0);
	#if (__NUM_SHARC_CORES__ == 2)
	adi_core_enable(ADI_CORE_SHARC1);
	#endif
#elif (__NUM_ARM_CORES__ == 0)
	adi_core_enable(ADI_CORE_SHARC1);
#endif
	
	ADI_PKTE_RESULT eResult;

	/*Configure source, key, destination pointers in ADI_PKTE_LIST structure */
	PkteList1.pSource = (uint32_t*)&source0;
	PkteList1.pDestination = (uint32_t*)&ciphertext;
	PkteList1.pIV = (uint32_t*)&IV;
	PkteList1.pKey = (uint32_t*)&Key;
	PkteList1.pIdigest = (uint32_t*)&IDigest;
	PkteList1.nUserID = 0xF;
	PkteList1.nSrcSize = sizeof(source0);
	PkteList1.pNxtOperation = (ADI_PKTE_LIST*)&PkteList2;
	PkteList1.pCommand = &command0;

	/*Configure source, key, destination pointers in ADI_PKTE_LIST structure */
	PkteList2.pSource = (uint32_t*)&ciphertext;
	PkteList2.pDestination = (uint32_t*)&destination0;
	PkteList2.pIV = (uint32_t*)&IV;
	PkteList2.pKey = (uint32_t*)&Key;
	PkteList2.pIdigest = (uint32_t*)&IDigest;
	PkteList2.nUserID = 0xF;
	PkteList2.nSrcSize = sizeof(ciphertext);
	PkteList2.pNxtOperation = (ADI_PKTE_LIST*)&PkteList3;
	PkteList2.pCommand = &command1;

	/*Configure source, key, destination pointers in ADI_PKTE_LIST structure */
	PkteList3.pSource = (uint32_t*)&source0;
	PkteList3.pDestination = (uint32_t*)&destination1;
	PkteList3.pIV = (uint32_t*)&IV;
	PkteList3.pKey = (uint32_t*)&Key;
	PkteList3.pIdigest = (uint32_t*)&IDigest;
	PkteList3.nUserID = 0xF;
	PkteList3.nSrcSize = sizeof(source0);
	PkteList3.pNxtOperation = NULL;
	PkteList3.pCommand = &command2;

	Configure_Encryption_Command(&command0);
	Configure_Hash_Command(&command1);
	Configure_Encrypt_Hash_Command(&command2);

	/*Open the PKTE module */
	eResult= adi_pkte_Open(&ghPKTE,&gPKTEMemory,ADI_PKTE_MEMORY_SIZE);
    if (eResult != ADI_PKTE_SUCCESS)
    {
        return FAILED;
    }

    PkteList1.nErrorResponse = 1;
    PkteList2.nErrorResponse = 1;
    PkteList3.nErrorResponse = 1;
	eResult=  adi_pkte_RegisterCallback(ghPKTE,(ADI_CALLBACK)adi_PKTE_Status,(void *)&PkteList3.nErrorResponse);

    if (eResult != ADI_PKTE_SUCCESS)
    {
        return FAILED;
    }

    adi_pkte_Config(ghPKTE,(ADI_PKTE_LIST *)&PkteList1);

    /*Flushing the gPKTEMemory memory before adi_pkte_Start() */
    flush_data_buffer(&gPKTEMemory[0], &gPKTEMemory[ADI_PKTE_MEMORY_SIZE], ADI_FLUSH_DATA_INV);

    adi_pkte_Start(ghPKTE,(ADI_PKTE_LIST *)&PkteList1);

    while(PkteList1.nErrorResponse != 0 );
    while(PkteList2.nErrorResponse != 0 );
    while(PkteList3.nErrorResponse != 0 );



    adi_pkte_Close(ghPKTE);

#ifndef HOST_MODE
#ifdef MD5_Hashing
    printf("Test1 \n");
    printf("Test2 \n");
    printf("Test3 \n");
    printf("Test4 \n");
    printf("Test5 \n");
#endif
#endif

    int i=0;
    for(i=0;i<(sizeof(destination1)>>2);i++)
   		    {
   		    	if(i< sizeof(ciphertext)>>2)
   		    		{
   		    		if(ciphertext[i]!=destination1[i])
   		    			Error_Count++;
   		    		}
   		    	else
   		    	{
   		    		if(destination0[i- (sizeof(ciphertext)>>2)]!=destination1[i])
   		    			Error_Count++;
   		    	}
   		    }


    if(Error_Count ==0)
    {
    	printf("All Done\n");
    }
    else
    {
    	printf("Fail\n");
    }

return 0;
}

