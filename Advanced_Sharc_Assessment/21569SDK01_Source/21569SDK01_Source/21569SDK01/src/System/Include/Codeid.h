

/******************************************************************************
 * THISCODEID is used to identify which code module is currently
	running on Sharc processor. This is used by auto stream detect routine
	to identify whether the stream detected is the valid stream for the
	code module running on the processor currently
 *******************************************************************************/
#ifndef CODEID_H_
#define CODEID_H_

#define IEC958SHUFFLEDSIG	    0xf872

#define SYNCSIGPCMZERO	     0x00     // detection under progress 
#define SYNCSIGPCM	     	 0x01
#define SYNCSIGDOLBY	     0x02
#define SYNCSIGDTSLDCD	     0x03
#define SYNCSIGDTSDVD	     0x04

#define SYNCSIGAAC	     	 0x08
#define SYNCSIGWMAPRO		 0x09
#define SYNCSIGDDPLUS        0x0A
#define SYNCSIGTRUEHD		 0x0B
#define SYNCSIGUNKNOWN	     0x0f    // detection under progress
#define SYNCSIGDTSMA		 0x0C
#define SYNCSIGDTSHR    	 0x0D
#define SYNCSIGDTSLBR		 0x0E

#define FORCEPCM2            3
#define CUSTOMAUTODETECT1    0xA

#define SBPD_AUTO1 			0
#define SBPD_AUTO2 			1
#define SBPD_FORCE_OFF		2
#define SBPD_FORCE_EX		3
#define SBPD_FORCE_ES		4

//#define PCM_ID		      	 0x1234
//#define HALFSECVAL           5   // 4096 * 5 at 48 Khz is 0.426 sec 
#define PCMZEROCOUNTMAX      96000//20480 // 4096*5 samples is 0.426 sec at 48 Khz 
#define PCMCOUNTMAX	      	 4096
#define MAYBEPCMCOUNT	     4096-1024
#define PREVPCCLEARCOUNTMAX  30720


#endif /* End of #ifndef CODEID_H_	*/

