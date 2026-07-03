/*****************************************************************************
 * CCES_Handson_P1_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "CCES_Handson_P1_Core1.h"
#include<stdio.h>
#include <sys/platform.h>
#include <sys/adi_core.h>

int arr[256]={
#include"sine_tone.dat"
};
void copy(int arr[]);
int main()
{
	copy(arr);
	return 0;
}

