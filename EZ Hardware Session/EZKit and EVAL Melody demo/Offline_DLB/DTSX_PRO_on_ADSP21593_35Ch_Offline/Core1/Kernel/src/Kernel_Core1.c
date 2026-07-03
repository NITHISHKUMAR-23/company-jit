/*****************************************************************************
 * Kernel_Core.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "Kernel_Core1.h"

#include <string.h>
#include <stdlib.h>
#include "stdio.h"
#include "interrupt.h"
#include <ctype.h>

#ifndef CORE_1_2_SEPERATE_FILE_WRITE
extern int arg_count;
extern int arg_values[];
#endif

int DTSX_main_DSP_A( int, char *[]);
void USB_Options(void);

char __argv_string[] = "";
#define MAX_ARGS				20
#define MAX_ARG_LEN				575
#define MAX_STREAM_COUNT		4000
#define COMMAND_LENGTH          1000
//#define CORE1_INITONLY_CORE2_PROCESS  //Enable this define to run CORE2 seperately. In CCES 2.4.0, CORE1 init is required to run CORE2.

#define NOP asm("nop;")
#define NOP10 asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");

extern int VersionInfo_REF;
extern int VersionInfo_DSP;

//segment("seg_dmda") char stream_list[MAX_STREAM_COUNT][MAX_ARG_LEN];
//segment("seg_dts_uncached_L3") char command[MAX_ARGS][MAX_ARG_LEN];
segment("seg_dts_uncached_L3") char command[COMMAND_LENGTH];

void Enable_Cache(void);
void LED_init(void);

int main()
{


#ifdef CORE1_INITONLY_CORE2_PROCESS

	adi_initComponents();
#else

	//adi_initComponents();
	Enable_Cache();
	adi_core_enable(ADI_CORE_SHARC1);
	
#ifdef LED_TOGGLE
	LED_init();
#endif

	USB_Options();
	//DTS_UHD_CommandProcessing();

#endif
	return 0;
}
#pragma optimize_off
#if(0)
void DTS_UHD_CommandProcessing()
{
	FILE *fp_iplist;
	int i=0, j=0, k=0, m=0, x=0, y=0,flag=0;
	int argc=0;
	char *argv[MAX_ARGS];
	int tmpAddress;
	int v1, v2, v3, v4, v5, v6;

	fp_iplist = fopen("input_list.txt","r");

	i = 0;
	while ( fgets(stream_list[i],MAX_ARG_LEN,fp_iplist) != NULL )
		i++;

	fclose(fp_iplist);

	v1 = (VersionInfo_REF >> 20) & 0xFFF;
	v2 = (VersionInfo_REF >> 8) & 0xFFF;
	v3 = (VersionInfo_REF >> 4) & 0xF;
	v4 = (VersionInfo_REF >> 0) & 0xF;

	v5 = (VersionInfo_DSP >> 5) & 0x3;
	v6 = (VersionInfo_DSP) & 0xF;


	printf("$-------------------------------------------------------$\n");
	printf("$		DTS:X Pro on GRIFFIN LITE - XP		 $\n");
	printf("$		===============================		 $\n");
	printf("$	Reference Decoder Version	: %d.%d.%d.%d	 $\n", v1, v2, v3, v4);
	printf("$	DSP Version			: %d.%d		 $\n", v5, v6);
	printf("$-------------------------------------------------------$\n");
	printf("\n");

	printf("Total number of streams	:	%d\n\n", i);

	for(y=0; y<i; y++)
	{

		memset(command, 0, MAX_ARGS * MAX_ARG_LEN);

		while ( (stream_list[y][k] != '\n') && (stream_list[y][k] != '\0') )
		{
			flag = 0;
			while ((stream_list[y][k] != '\t') && (stream_list[y][k] != ' ') && (stream_list[y][k] != '\n') )
			{
				command[j][m] = (stream_list[y][k]);
				k++;
				m++;
				flag=1;
			}
			k++;
			m=0;
			if(flag == 1)
			{
				j++;
			}
		}

		argc = j+1;

#ifndef CORE_1_2_SEPERATE_FILE_WRITE
		arg_count = argc;
#endif

		for(x=1; x<argc; x++)
		{
			argv[x] = command[x-1];

#ifndef CORE_1_2_SEPERATE_FILE_WRITE
			arg_values[x] = argv[x];
#endif

		}

		printf("Decoding stream %d out of %d\r", y+1, i);

		DTSX_main_DSP_A(argc, argv);

		j=0; k=0; m=0;

	}

	printf("\n\n----------	Decoding Completed	----------\n\n");

}
#else

void DTS_UHD_CommandProcessing()
{
	FILE *fp_iplist;
		int i=0, j=0, k=0, m=0, x=0, y=0,flag=0;
		int argc=0;
		char *argv[MAX_ARGS];
		int tmpAddress;
		int v1, v2, v3, v4, v5, v6;

		fp_iplist = fopen("input_list.txt","r");

		i = 0;
		while ( fgets(command,COMMAND_LENGTH,fp_iplist) != NULL )
		{
			i++;
		}


		v1 = (VersionInfo_REF >> 20) & 0xFFF;
		v2 = (VersionInfo_REF >> 8) & 0xFFF;
		v3 = (VersionInfo_REF >> 4) & 0xF;
		v4 = (VersionInfo_REF >> 0) & 0xF;

		v5 = (VersionInfo_DSP >> 5) & 0x3;
		v6 = (VersionInfo_DSP) & 0xF;


		printf("$-------------------------------------------------------$\n");
		printf("$		DTS:X Pro on GRIFFIN LITE - XP		 $\n");
		printf("$		===============================		 $\n");
		printf("$	Reference Decoder Version	: %d.%d.%d.%d	 $\n", v1, v2, v3, v4);
		printf("$	DSP Version			: %d.%d		 $\n", v5, v6);
		printf("$-------------------------------------------------------$\n");
		printf("\n");

		printf("Total number of streams	:	%d\n\n", i);

		/* set file pointer to start position */
				fseek(fp_iplist, SEEK_SET, 0);

		while ( fgets(command,COMMAND_LENGTH,fp_iplist) != NULL )
				{
					y++;

					/* Remove the line ending */
					if(command[strlen(command) - 1] == '\n')
					{
						command[strlen(command) - 1] = '\0';
					}

					/* get the first token */
					argc = 1;
					argv[argc] = strtok(command, " ");

					argc+=1;
					/* walk through other tokens */
				while((argc > 0) && ((argv[argc] = strtok(NULL," ")) != NULL))
					{
						argc++;
					}


	#ifndef CORE_1_2_SEPERATE_FILE_WRITE
			arg_count = argc;
	#endif

			for(x=1; x<argc; x++)
			{

	#ifndef CORE_1_2_SEPERATE_FILE_WRITE
				arg_values[x] = argv[x];
	#endif
			}

	if(argc > 0)
		{

			printf("Decoding stream %d out of %d\r", y, i);

			DTSX_main_DSP_A(argc, argv);

			j=0; k=0; m=0;
		}

		}
		fclose(fp_iplist);

		printf("\n\n----------	Decoding Completed	----------\n\n");

	}

#endif
void Enable_Cache(void)
{
	//	47	-	1.0 Mbits
	//	45 	-	0.5 Mbits
	//	43	-	0.25 Mbits

	//	Bits	23-16	15-8	7-0
	//	Cache	 PM		 DM		 I
	//	Size	0.25	1.0		0.5	Mbits

	/* Cache Configurable Register*/

	*pREG_SHL1C0_CFG = 0x00434745;
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			// 33 NOPS

	/* Range Lock Register*/

	*pREG_SHL1C0_CFG2 |= 0x330;
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			// 33 NOPS

	/* Uncached segment L3 & External Stack & Heap */

	*pREG_SHL1C0_RANGE_START2 =0x83b63000; //;0x84963000
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			//33 NOPS

	*pREG_SHL1C0_RANGE_END2 = 0x83ffffff;   // ;0x84DFFFFF
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			//33 NOPS

	// need to check
	*pREG_SHL1C0_RANGE_START3 = 0x20010000 ;  //     0x2000c000
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			//33 NOPS

	*pREG_SHL1C0_RANGE_END3 =0x20010fff ;   //     0x2000cfff
	NOP10;NOP10;NOP10;NOP;NOP;NOP;

	/*Uncached segment L2*/

	*pREG_SHL1C0_RANGE_START4 = 0x20149800;  // ;    0x20024300
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			//33 NOPS

	*pREG_SHL1C0_RANGE_END4 = 0x2017cc2f ;  //;     0x2004ffff
	NOP10;NOP10;NOP10;NOP;NOP;NOP;
}

#ifdef LED_TOGGLE
void LED_init(void)
{
	*pREG_PORTC_FER = 0;
	*pREG_PORTC_DIR_SET  = 0x4000;
}
#endif
