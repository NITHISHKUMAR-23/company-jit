/*****************************************************************************
 * CCES_Handson_P2_Core2.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "CCES_Handson_P2_Core2.h"
#include<stdio.h>
#include <sys/platform.h>
int Reverse(int num);
int main()
{
	int num;
	printf("Enter the Number : ");
	scanf("%d",&num);
	int rev = Reverse(num);
	printf("Reverser Number : %d",rev);
	return 0;
}
