/*****************************************************************************
 * Kernel_Core2.c
 *****************************************************************************/

#include <sys/platform.h>
#include <sys/adi_core.h>
#include "adi_initialize.h"
#include "Kernel_Core2.h"
#include <stdio.h>
#include <string.h>

#ifndef CORE_1_2_SEPERATE_FILE_WRITE
extern int arg_count;
extern int arg_values[];
extern int dsp2_status_check_flag;
#endif
extern int *KeyValue_4;
#define MAX_ARGS				16
#define MAX_ARG_LEN				500
#define MAX_STREAM_COUNT		4000

#define NOP asm("nop;")
#define NOP10 asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");asm("nop;");

#ifdef CORE_1_2_SEPERATE_FILE_WRITE
segment("seg_dmda") char stream_list[MAX_STREAM_COUNT][MAX_ARG_LEN];
segment("seg_dmda") char command[MAX_ARGS][MAX_ARG_LEN];
int sdcard_init_flag = 1;
#else
static char *pcm_extension = ".pcm";
static char *DSPB_PCM_EXTENSION = "-postprocesspcm";
int sdcard_init_flag = 0;
#endif

void Enable_Cache(void);
int DTSX_main_DSP_B( int argc, char *argv[] );

int main()
{
	 
	Enable_Cache();
	*KeyValue_4 = 0;
	adi_initComponents();
#ifdef FILE_OP_SDCARD
	if(sdcard_init_flag==1)
	{
		Init_SDCard();
	}
#endif

	DTS_UHD_CommandProcessing();

#ifdef CORE_1_2_SEPERATE_FILE_WRITE
#ifdef FILE_OP_SDCARD
    fl_shutdown();
#endif
#endif
	return 0;
}

void DTS_UHD_CommandProcessing()
{
#ifndef CORE_1_2_SEPERATE_FILE_WRITE
	int argc = 0,x=0;
	char *argv[MAX_ARGS];
	char *file_name;
    char *str1;
	while(1)
	{
		if(dsp2_status_check_flag & 0x0001 == 1)
		{
			argc = arg_count;

			for(x=1; x<argc; x++)
			{
				argv[x] = arg_values[x];
			}
			
	/*************** PostProcessPCM_case **********************/
			str1=argv[1];
			 if(strcmp(str1,DSPB_PCM_EXTENSION)==0)
			 {
			 	argv[1]=argv[3];          //Needs to be taken care for Input file name. 
			 	for(x=2; x<argc; x++)
			 	{
			 		argv[x] = '\0';
			 	}
			 	argc=2;
			 }
	/**********************************************************/
	
			file_name = strrchr(argv[1],'.');

			if(file_name!=NULL)
			{
				*file_name = '\0';
			}

			strcat(argv[1],pcm_extension);

			DTSX_main_DSP_B(argc, argv);
		}
	}

#else
	FILE *fp_iplist;
	int i=0, j=0, k=0, m=0, x=0, y=0,flag=0;
	int argc=0;
	char *argv[MAX_ARGS];

	fp_iplist = fopen("input_list.txt","r");

	while ( fgets(stream_list[i],MAX_ARG_LEN,fp_iplist) != NULL )
		i++;

	fclose(fp_iplist);
	
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

		for(x=1; x<argc; x++)
		{
			argv[x] = command[x-1];
		}

		printf("Decoding stream %d out of %d\r", y+1, i);

		DTSX_main_DSP_B(argc, argv);

		j=0; k=0; m=0;

	}

	printf("\n\n----------	Decoding Completed	----------\n\n");
#endif
}

void Enable_Cache(void)
{
	//	47	-	1.0 Mbits
	//	45 	-	0.5 Mbits
	//	43	-	0.25 Mbits

	//	Bits	23-16	15-8	7-0
	//	Cache	 PM		 DM		 I
	//	Size	0.25	1.0		0.5	Mbits

	*pREG_SHL1C0_CFG = 0x00434745;
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			//33 NOPS

	*pREG_SHL1C0_CFG2 = 0x330;
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			//33 NOPS

	/* Uncached segment L2 */

	*pREG_SHL1C0_RANGE_START2 =0x20149800 ; // ;     0x20024300
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			//33 NOPS

	*pREG_SHL1C0_RANGE_END2 = 0x2017cc2f ;  //;     0x2004ffff
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			//33 NOPS

	/* Uncached segment L2 */

	*pREG_SHL1C0_RANGE_START3 = 0x20001000 ;  // ;     0x20008000
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			//33 NOPS

	*pREG_SHL1C0_RANGE_END3 = 0x20001fff ;  // ;     0x20008fff
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			//33 NOPS

	/* Uncached segment L3 & External Stack & Heap */

	*pREG_SHL1C0_RANGE_START4 = 0x8522e760;  // ;  0x88bf6000
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			//33 NOPS

	*pREG_SHL1C0_RANGE_END4 =0x87ffffff ;  // ;  0x88ffffff
	NOP10;NOP10;NOP10;NOP;NOP;NOP;			//33 NOPS
}
