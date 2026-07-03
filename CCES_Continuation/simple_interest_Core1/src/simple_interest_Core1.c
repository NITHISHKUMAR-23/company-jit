/*****************************************************************************
 * simple_interest_Core1.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "simple_interest_Core1.h"

#include <sys/platform.h>
#include <sys/adi_core.h>

int main()
{
	float principle;
	scanf("%f",&principle);
//	principle = 10000;
	float year;
	year = 1;
	float rate_of_interest = 1;
	interest(principle, year, rate_of_interest);

	return 0;
}

