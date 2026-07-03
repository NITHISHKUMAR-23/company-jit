/*****************************************************************************
 * ASM_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "ASM_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

int array1[5] = {10, 20, 30, 40, 50};
int array2[5] = {1, 2, 3, 4, 5};
int result[5] = {0};

int a=7, b=3, c=10 , d=4, m=2, n=3;

void add_two_array(int array1[],int array2[],int *result);

int multiplication(int a, int b);

int expression(int,int,int,int,int,int);

int *transfer_data(int *);

int main(void)
{
	printf("\n");
	add_two_array(array1, array2,result);
	printf("Sum of Arrays : ");
	for(int i=0; i<5;i++)
	{
		printf("%d ",result[i]);
	}

	int result=multiplication(a,b);
	printf("\nMultiplication of two numbers : %d\n",result);

	int answer = expression(m,n,a,b,c,d);
    printf("Value for (m + n) + (a - b) - (c - d) : %d\n",answer);

    int data= 100;
	int *ptr;
	ptr = transfer_data(&data);
	printf("Transfered data value : %d\n",*ptr);
	printf("Address of pointer : %p\n",ptr);
	printf("Address of data : %p\n",&data);

	return 0;
}
