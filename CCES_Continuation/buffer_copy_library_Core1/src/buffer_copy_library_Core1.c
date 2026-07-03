/*****************************************************************************
 * buffer_copy_library_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "buffer_copy_library_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>


void copy_buffer(int buffer[])
{
	int i, buffer_copy[100];
	for(i=0; i<100; i++)
	{
		buffer_copy[i]=buffer[i];
		printf("%d ",buffer_copy[i]);
	}
}
