/*****************************************************************************
 * asm_prep_Core1.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "asm_prep_Core1.h"

/** 
 * If you want to use command program arguments, then place them in the following string. 
 */
char __argv_string[] = "";
//void copy(int*,int*,int,float);
void copy(int*,int*,int*);
void cicrcular_buffer_copy(int*,int*,int,int);


int main(int argc, char *argv[])
{

	/**
	 * Initialize managed drivers and/or services that have been added to
	 * the project.
	 * @return zero on success
	 */
//	adi_initComponents();

	/**
	 * The default startup code does not include any functionality to allow
	 * core 1 to enable core 2. A convenient way to enable
	 * core 2 is to use the adi_core_enable function.
	 */
//	adi_core_enable(ADI_CORE_SHARC1);

	/*int src[8*3];

	for(int i=0;i<8*3;i++)
	{
		src[i] = i&7;
	}

	int dest[8*3*2];
	copy(src,dest,8*3*2,5.6f);*/

	int array_1[10] = {1,2,3,4,5,6,7,8,9,10};
	int array_2[10] = {2,2,2,2,2,2,2,2,2,2};
	int result[10];



	/*************Code for SIMD**************/
	copy(array_1,array_2,result);
	for(int i=0;i<10;i++)
	{
		printf("%d ",result[i]);
	}
	/*************Code for SIMD**************/
	printf("\n");


	/*************code for circular buffer***************/
	int src[5] = {1,2,3,4,5};
	int dest[20]={0};

	cicrcular_buffer_copy(src,dest,5,20); // 5 - src length , 20 - dest length
	for(int j=0;j<20;j++)
	{
		printf("%d ",dest[j]);
	}
	/*************code for circular buffer***************/


	return 0;
}

