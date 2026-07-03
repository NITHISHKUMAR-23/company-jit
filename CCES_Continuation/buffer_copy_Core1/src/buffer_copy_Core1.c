/*****************************************************************************
 * buffer_copy_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "buffer_copy_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

void copy_buffer(int buffer[]);

int main()
{
	int buffer[100],i;
	for(i=0;i<100;i++)
	{
		buffer[i]=i+1;
	}
	copy_buffer(buffer);

	return 0;
}

