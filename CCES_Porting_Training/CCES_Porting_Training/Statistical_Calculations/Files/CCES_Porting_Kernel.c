/*****************************************************************************
 * CCES_Porting_Kernel.c
 *****************************************************************************/

#include "adi_initialize.h"
#include "CCES_Porting_Kernel.h"
#include <sys/platform.h>


int main(int argc, char *argv[])
{

    float data[] = {1.0, 2.0, 3.0, 4.0, 5.0};
    uint16_t length = sizeof(data) / sizeof(data[0]);

#ifdef MEAN
    float mean = calculateMean(data, length);
    printf("Mean: %f\n", mean);
#endif

#ifdef RMS
    float rms = calculateRMS(data, length);
    printf("RMS: %f\n", rms);
#endif

#ifdef VARIANCE
    float variance = calculateVariance(data, length);
    printf("Variance: %f\n", variance);
#endif

#ifdef DEVIATION
    float stddev = calculateStandardDeviation(data, length);
    printf("Standard Deviation: %f\n", stddev);
#endif


	return 0;

}

