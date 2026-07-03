/*****************************************************************************
 * CCES_Handson_P2_Library_Core2.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "CCES_Handson_P2_Library_Core2.h"
//#include<stdio.h>
#include <sys/platform.h>

int Reverse(int num)
{
	int rem,sum=0;
	while(num)
	{
		rem = num%10;
		sum = (sum*10)+rem;
		num = num/10;
	}
	return sum;

}
