/*****************************************************************************
 * CCES_Handson_P1_Library_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "CCES_Handson_P1_Library_Core1.h"
#include<stdio.h>
#include <sys/platform.h>
#include <sys/adi_core.h>

int arr1[256];


void copy(int arr[])
{
	for(int i=1;i<=256;i++)
	{
		arr1[i]=arr[i];
	}
	for(int i=1;i<=256;i++)
	{
		printf("%d ",arr1[i]);
	}

	
}



