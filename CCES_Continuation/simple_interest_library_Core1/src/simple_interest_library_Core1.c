/*****************************************************************************
 * simple_interest_library_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "simple_interest_library_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

void interest(float principle, float year, float rate_of_interest)
{
	float simple_interest;
	simple_interest = (principle * year * rate_of_interest)/100;
	printf("%.2f",simple_interest);
}
